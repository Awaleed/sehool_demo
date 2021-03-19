import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

import '../../generated/l10n.dart';
import '../../init_injectable.dart';
import '../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../data/user_datasource.dart';
import '../helpers/helper.dart';
import '../models/cart_model.dart';
import '../models/dropdown_value_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import 'message_check_box.dart';
import 'my_error_widget.dart';

class CartDropdown extends StatefulWidget {
  const CartDropdown({
    Key key,
    @required this.dropdownType,
    @required this.initialValue,
    @required this.onValueChanged,
    this.cart,
    this.messageFormKey,
    this.cartItem,
    this.cubit,
    this.grid = false,
    this.itemAsString,
  }) : super(key: key);
  final DropdownValueType dropdownType;
  final ValueChanged onValueChanged;
  final String Function(dynamic value) itemAsString;
  final dynamic initialValue;
  final CartModel cart;
  final CartItemModel cartItem;
  final bool grid;
  final GlobalKey<FormState> messageFormKey;
  final DropdownCubit cubit;

  @override
  CartDropdownState createState() => CartDropdownState();
}

class CartDropdownState extends State<CartDropdown> {
  dynamic selectedValue;
  DropdownCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = widget.cubit ?? getIt<DropdownCubit>();
    cubit.getDropdownValues(widget.dropdownType);
    selectedValue = widget.initialValue;
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  void setValue(dynamic value) {
    widget.onValueChanged?.call(value);
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DropdownCubit, DropdownState>(
      cubit: cubit,
      listener: (context, state) {
        if (selectedValue == null) {
          setState(() {
            final value = state.maybeWhen(
                  success: (values) => values?.isNotEmpty ?? false ? values.first : null,
                  orElse: () => null,
                ) ??
                selectedValue;
            selectedValue = value;
            widget.onValueChanged?.call(value);
          });
        }
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI([], isLoading: true),
          loading: () => _buildUI([], isLoading: true),
          success: (values) => _buildUI(values),
          failure: (message) => MyErrorWidget(
            onRetry: () {
              cubit.getDropdownValues(widget.dropdownType);
            },
            message: message,
          ),
        );
      },
    );
  }

  Widget _buildUI(List values, {bool isLoading = false}) => _buildRadio(values, isLoading: isLoading);

  Widget _buildRadio(List values, {bool isLoading = false}) {
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
    if (widget.grid) {
      return Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 10 / 3,
            children: [
              ...values.map(
                (e) => InkWell(
                  onTap: () {
                    if (e is SlicingMethodModel && e.id == 3) {
                      widget.cartItem.event = null;
                      widget.cartItem.phrase = null;
                    }
                    if (e is PaymentMethodModel && e.type == 'wallet') {
                      if (kUser.wallet < widget.cart.total) {
                        Helpers.showErrorOverlay(
                          context,
                          error: S.current.sorry_your_balance_is_not_enough,
                        );
                      } else {
                        widget.onValueChanged?.call(e);
                        setState(() => selectedValue = e);
                      }
                    } else {
                      widget.onValueChanged?.call(e);
                      setState(() => selectedValue = e);
                    }
                  },
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(3),
                    duration: 300.milliseconds,
                    decoration: BoxDecoration(
                      color: e == selectedValue ? Theme.of(context).primaryColor.withOpacity(.9) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FittedBox(
                      child: Text(
                        widget.itemAsString?.call(e) ?? '$e',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (widget.dropdownType == DropdownValueType.slicingMethods && selectedValue.id == 3) ...[
            const SizedBox(height: 10),
            MessageCheckBox(
              onValueChanged: (value) {
                setState(() {});
              },
              cart: widget.cartItem,
              formKey: widget.messageFormKey,
            ),
          ],
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...values.map(
            (e) => InkWell(
              onTap: () {
                if (e is SlicingMethodModel && e.id == 3) {
                  widget.cartItem.event = null;
                  widget.cartItem.phrase = null;
                }
                if (e is PaymentMethodModel && e.type == 'wallet') {
                  if (kUser.wallet < widget.cart.total) {
                    Helpers.showErrorOverlay(
                      context,
                      error: S.current.sorry_your_balance_is_not_enough,
                    );
                  } else {
                    widget.onValueChanged?.call(e);
                    setState(() => selectedValue = e);
                  }
                } else {
                  widget.onValueChanged?.call(e);
                  setState(() => selectedValue = e);
                }
              },
              child: AnimatedContainer(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(3),
                duration: 300.milliseconds,
                decoration: BoxDecoration(
                  color: e == selectedValue ? Theme.of(context).primaryColor.withOpacity(.9) : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  widget.itemAsString?.call(e) ?? '$e',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
          if (widget.dropdownType == DropdownValueType.slicingMethods && selectedValue.id == 3) ...[
            const SizedBox(height: 10),
            MessageCheckBox(
              onValueChanged: (value) {
                setState(() {});
              },
              cart: widget.cartItem,
              formKey: widget.messageFormKey,
            ),
          ],
        ],
      );
    }
  }
}
