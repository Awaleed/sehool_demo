import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../init_injectable.dart';
import '../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../models/dropdown_value_model.dart';

class CartDropdown<T> extends StatefulWidget {
  const CartDropdown({
    Key key,
    @required this.dropdownType,
    @required this.initialValue,
    @required this.onValueChanged,
  }) : super(key: key);
  final DropdownValueType dropdownType;
  final ValueChanged<T> onValueChanged;
  final T initialValue;

  @override
  _CartDropdownState<T> createState() => _CartDropdownState<T>();
}

class _CartDropdownState<T> extends State<CartDropdown<T>> {
  T selectedValue;
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
    print('Values: ${values}');

    return DropdownButton<T>(
      value: isLoading ? null : selectedValue,
      dropdownColor: Colors.amber.withOpacity(.8),
      onChanged: isLoading
          ? null
          : (value) {
              widget.onValueChanged?.call(value);
              setState(() => selectedValue = value);
            },
      icon: const SizedBox.shrink(),
      isExpanded: true,
      hint: DropdownMenuItem<T>(
        child: Center(
          child: Text(
            '${widget.dropdownType}',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black),
          ),
        ),
      ),
      items: [
        ...values.map(
          (e) => DropdownMenuItem<T>(
            value: e,
            child: Center(
              child: Text(
                '$e',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}
