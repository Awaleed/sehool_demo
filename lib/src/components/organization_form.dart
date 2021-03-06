import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../init_injectable.dart';
import '../cubits/associations_cubit/associations_cubit.dart';
import '../models/association_model.dart';
import '../models/cart_model.dart';
import 'my_error_widget.dart';

class OrganizationForm extends StatefulWidget {
  const OrganizationForm({
    Key key,
    @required this.cart,
    @required this.onValueChanged,
  }) : super(key: key);
  final ValueChanged onValueChanged;
  final CartModel cart;

  @override
  _OrganizationFormState createState() => _OrganizationFormState();
}

class _OrganizationFormState extends State<OrganizationForm> {
  AssociationsCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = getIt<AssociationsCubit>();
    cubit.getMessagesValues();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationsCubit, AssociationsState>(
      cubit: cubit,
      listener: (context, state) {
        final error = state.maybeWhen(
          failure: (message) => message,
          orElse: () => null,
        );
        if (error != null) {
          setState(() {
            widget.cart.associationDiscount = null;
            widget.cart.association = null;
            widget.cart.organization = false;
            widget.onValueChanged?.call(null);
          });
          showDialog(
            context: context,
            useRootNavigator: true,
            builder: (context) => AlertDialog(
              content: Text(error),
            ),
          );

          return;
        }
        final value = widget.cart.association;
        final discount = widget.cart.associationDiscount;

        setState(() {
          widget.cart.association = value;
          widget.cart.associationDiscount = discount;
          widget.onValueChanged?.call(value);
        });

        if (widget.cart.association != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              backgroundColor: Colors.white70,
              content: ListTile(
                leading: Image.asset('assets/images/sign-warning.png'),
                title: Text(
                  '${S.current.org_delivery_msg_p1} ${widget.cart.association?.name ?? ''} ${S.current.org_delivery_msg_p2}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI(null, isLoading: true),
          loading: () => _buildUI(null, isLoading: true),
          success: (value) => _buildUI(value),
          failure: (message) => MyErrorWidget(
            onRetry: () {
              cubit.getMessagesValues();
            },
            message: message,
          ),
        );
      },
    );
  }

  Widget _buildUI(AssociationModel value, {bool isLoading = false}) {
    if (isLoading) {
      return FittedBox(
        child: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        ),
      );
    }
    return Column(
      children: [
        _buildDropdown(
          value.association,
          widget.cart.association,
          (_value) {
            widget.cart.association = _value;
            widget.cart.associationDiscount = value.discount;
          },
          S.current.choose_an_association,
        ),
      ],
    );
  }

  Widget _buildDropdown(List<Association> values, Association value, ValueChanged onChange, String label) {
    return DropdownButtonHideUnderline(
      child: DropdownSearch<Association>(
        selectedItem: widget.cart.association,
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        showSearchBox: true,
        autoFocusSearchBox: true,
        itemAsString: (item) => item.name,
        onChanged: (value) {
          if (value == null) return;
          setState(() => onChange(value));
          widget.onValueChanged?.call(value);

          if (widget.cart.association != null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                backgroundColor: Colors.white70,
                content: ListTile(
                  leading: Image.asset('assets/images/sign-warning.png'),
                  title: Text(
                    '${S.current.org_delivery_msg_p1} ${widget.cart.association?.name ?? ''} ${S.current.org_delivery_msg_p2}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            );
          }
        },
        items: [...values],
      ),
    );
  }
}
