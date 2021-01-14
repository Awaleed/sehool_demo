import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/cubits/address_cubit/address_cubit.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/product/product.dart';
import 'package:sehool/src/screens/profile/dialogs/new_address_dialog.dart';
import 'package:sehool/src/screens/profile/profile_settings.dart';

import '../../init_injectable.dart';
import '../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../models/dropdown_value_model.dart';

class CartDropdown extends StatefulWidget {
  const CartDropdown({
    Key key,
    @required this.dropdownType,
    @required this.initialValue,
    @required this.onValueChanged,
    this.itemAsString,
  }) : super(key: key);
  final DropdownValueType dropdownType;
  final ValueChanged onValueChanged;
  final String Function(dynamic value) itemAsString;
  final dynamic initialValue;

  @override
  _CartDropdownState createState() => _CartDropdownState();
}

class _CartDropdownState extends State<CartDropdown> {
  dynamic selectedValue;
  DropdownCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<DropdownCubit>();
    cubit.getDropdownValues(widget.dropdownType);
    selectedValue = widget.initialValue;
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: BlocBuilder<DropdownCubit, DropdownState>(
          cubit: cubit,
          builder: (context, state) {
            return state.when(
              initial: () => _buildDropdown([], isLoading: true),
              loading: () => _buildDropdown([], isLoading: true),
              success: (values) => _buildDropdown(values),
              failure: (_) => throw UnimplementedError(),
            );
          },
        ),
      ),
    );
  }

  DropdownButton _buildDropdown(List values, {bool isLoading = false}) {
    return DropdownButton(
      value: isLoading ? null : selectedValue,
      dropdownColor: Colors.amber.withOpacity(.8),
      onChanged: isLoading
          ? null
          : (value) {
              if (value == 'add_a_new_address') return;
              widget.onValueChanged?.call(value);
              setState(() => selectedValue = value);
            },
      icon: const SizedBox.shrink(),
      isExpanded: true,
      hint: DropdownMenuItem(
        child: Center(
          child: Text(
            () {
              switch (widget.dropdownType) {
                case DropdownValueType.cites:
                  return S.current.cites;
                case DropdownValueType.citySections:
                  return S.current.city_section;
                case DropdownValueType.slicingMethods:
                  return S.current.slicing_method;
                case DropdownValueType.paymentMethods:
                  return S.current.payment_options;
                case DropdownValueType.addresses:
                  return S.current.address;
                case DropdownValueType.pickupMethod:
                  return S.current.pickup_method;
                case DropdownValueType.orderType:
                  return S.current.delivery_date;
              }
            }(),
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black),
          ),
        ),
      ),
      items: [
        ...values.map(
          (e) => DropdownMenuItem(
            value: e,
            child: Center(
              child: Text(
                widget.itemAsString?.call(e) ?? '$e',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
        if (widget.dropdownType == DropdownValueType.addresses)
          DropdownMenuItem(
            value: 'add_a_new_address' as dynamic,
            onTap: () async {
              Navigator.of(context).pop();
              final _cubit = getIt<AddressCubit>();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(),
                ),
              ));
              // await AppRouter.sailor.navigate(
              //   ProfileSettingsScreen.routeName,
              // );
              final values = cubit.state.maybeWhen(
                success: (value) => value,
                orElse: () => null,
              );
              if (values != null) cubit.setDropdownValues(values);
              _cubit.close();
            },
            child: Center(
              child: Text(
                '${S.current.add_a_new_address} +',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
      ],
    );
  }
}
