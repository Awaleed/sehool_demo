import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/src/cubits/associations_cubit/associations_cubit.dart';
import 'package:sehool/src/models/association_model.dart';
import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/form_data_model.dart';

import '../../init_injectable.dart';
import '../cubits/cart_message_cubit/cart_messages_cubit.dart';
import '../models/cart_model.dart';
import 'my_error_widget.dart';

class OrganizationForm extends StatefulWidget {
  const OrganizationForm({
    Key key,
    @required this.cart,
    @required this.onValueChanged,
    @required this.formKey,
  }) : super(key: key);
  final ValueChanged onValueChanged;
  final CartModel cart;
  final GlobalKey<FormState> formKey;

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
        setState(() {
          final value = state.maybeWhen(
                success: (values) => values?.association?.isNotEmpty ?? false ? values?.association?.first : null,
                orElse: () => null,
              ) ??
              widget.cart.association;
          widget.cart.association = value;
          widget.onValueChanged?.call(value);
        });
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
          S.current.association,
        ),

        // Form(
        //   key: widget.formKey,
        //   autovalidateMode: AutovalidateMode.onUserInteraction,
        //   child: Column(
        //     children: [
        //       TextFormField(
        //         validator: Validators.shortStringValidator,
        //         decoration: InputDecoration(
        //           hintText: S.current.association_name,
        //           hintStyle: const TextStyle(color: Colors.black26),
        //           filled: true,
        //           fillColor: Colors.white,
        //           contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //         ),
        //         onSaved: (value) => widget.cart.associationName = value,
        //         keyboardType: TextInputType.text,
        //         textAlign: TextAlign.center,
        //         style: const TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       const SizedBox(height: 20),
        //       TextFormField(
        //         validator: Validators.shortStringValidator,
        //         decoration: InputDecoration(
        //           hintText: S.current.association_official,
        //           hintStyle: const TextStyle(color: Colors.black26),
        //           filled: true,
        //           fillColor: Colors.white,
        //           contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //         ),
        //         onSaved: (value) => widget.cart.associationOfficial = value,
        //         keyboardType: TextInputType.text,
        //         textAlign: TextAlign.center,
        //         style: const TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       const SizedBox(height: 20),
        //       TextFormField(
        //         validator: Validators.numericValidator,
        //         decoration: InputDecoration(
        //           hintText: S.current.official_number,
        //           hintStyle: const TextStyle(color: Colors.black26),
        //           filled: true,
        //           fillColor: Colors.white,
        //           contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //         ),
        //         onSaved: (value) => widget.cart.officialNumber = value,
        //         keyboardType: TextInputType.number,
        //         textAlign: TextAlign.center,
        //         style: const TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       const SizedBox(height: 20),
        //       TextFormField(
        //         validator: Validators.shortStringValidator,
        //         decoration: InputDecoration(
        //           hintText: S.current.applicant_name,
        //           hintStyle: const TextStyle(color: Colors.black26),
        //           filled: true,
        //           fillColor: Colors.white,
        //           contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //         ),
        //         onSaved: (value) => widget.cart.applicantName = value,
        //         keyboardType: TextInputType.text,
        //         textAlign: TextAlign.center,
        //         style: const TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildDropdown(List<Association> values, Association value, ValueChanged onChange, String label) {
    // if (value == null) {
    //   Timer.run(() {
    //     setState(() {
    //       // setState(() => onChange(value));
    //       widget.onValueChanged?.call(value);
    //     });
    //   });
    // }
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
        // value: value,
        // isDense: true,
        // dropdownColor: Colors.amber.withOpacity(.8),
        showSearchBox: true,
        autoFocusSearchBox: true,
        itemAsString: (item) => item.name,
        onChanged: (value) {
          if (value == null) return;
          setState(() => onChange(value));
          widget.onValueChanged?.call(value);
        },
        // isExpanded: true,
        items: [...values],
      ),
    );
  }
}
