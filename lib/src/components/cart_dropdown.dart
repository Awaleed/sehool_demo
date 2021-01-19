import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../init_injectable.dart';
import '../cubits/address_cubit/address_cubit.dart';
import '../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../models/dropdown_value_model.dart';
import '../routes/config_routes.dart';
import '../screens/profile/dialogs/new_address_dialog.dart';

class CartDropdown extends StatefulWidget {
  const CartDropdown({
    Key key,
    @required this.dropdownType,
    @required this.initialValue,
    @required this.onValueChanged,
    this.isRadio = false,
    this.itemAsString,
  }) : super(key: key);
  final DropdownValueType dropdownType;
  final ValueChanged onValueChanged;
  final String Function(dynamic value) itemAsString;
  final dynamic initialValue;
  final bool isRadio;

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
    return BlocConsumer<DropdownCubit, DropdownState>(
      cubit: cubit,
      listener: (context, state) {
        if (selectedValue == null) {
          setState(() {
            final value = state.maybeWhen(
                  success: (values) =>
                      values?.isNotEmpty ?? false ? values.first : null,
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
          failure: (_) => throw UnimplementedError(),
        );
      },
    );
  }

  Widget _buildUI(List values, {bool isLoading = false}) => widget.isRadio
      ? _buildRadio(values, isLoading: isLoading)
      : _buildDropdown(
          values,
          isLoading: isLoading,
        );

  Widget _buildRadio(List values, {bool isLoading = false}) {
    if (isLoading) {
      return Container(
        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
        decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(strokeWidth: 2.0),
        ),
      );
    }

    return Column(
      children: [
        ...values.map(
          (e) => Card(
            color: Colors.white70,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: RadioListTile(
              value: e,
              groupValue: selectedValue,
              title: Text(
                widget.itemAsString?.call(e) ?? '$e',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black),
              ),
              onChanged: (value) async {
                widget.onValueChanged?.call(value);
                setState(() => selectedValue = value);
              },
            ),
          ),
        ),
        if (widget.dropdownType == DropdownValueType.addresses)
          Card(
            color: Colors.white70,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: ListTile(
              title: Text(
                S.current.add_a_new_address,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black),
              ),
              onTap: () async {
                final _cubit = getIt<AddressCubit>();
                await AppRouter.sailor.navigate(
                  NewAddressDialog.routeName,
                  params: {'address_cubit': _cubit},
                );
                await _cubit.close();
                cubit.getDropdownValues(widget.dropdownType);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildDropdown(List values, {bool isLoading = false}) {
    return InputDecorator(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: isLoading ? null : selectedValue,
          dropdownColor: Colors.amber.withOpacity(.8),
          onChanged: isLoading
              ? null
              : (value) async {
                  if (value == 'add_a_new_address') {
                    final _cubit = getIt<AddressCubit>();
                    await AppRouter.sailor.navigate(
                      NewAddressDialog.routeName,
                      params: {'address_cubit': _cubit},
                    );
                    final values = cubit.state.maybeWhen(
                      success: (value) => value,
                      orElse: () => null,
                    );
                    if (values != null) cubit.setDropdownValues(values);
                    _cubit.close();
                    return;
                  } else {
                    widget.onValueChanged?.call(value);
                    setState(() => selectedValue = value);
                  }
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
        ),
      ),
    );
  }
}
