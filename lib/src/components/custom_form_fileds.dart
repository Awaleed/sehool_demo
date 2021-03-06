import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/form_data_model.dart';

class CustomDropdownFromField<T> extends StatelessWidget {
  const CustomDropdownFromField({
    Key key,
    @required this.map,
    @required this.type,
    @required this.itemAsString,
    @required this.onChanged,
    @required this.items,
    this.onSave,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
    this.obscureText = false,
  }) : super(key: key);

  final String Function(T) itemAsString;
  final String Function(T) validator;
  final ValueChanged<T> onChanged;
  final ValueChanged<T> onSave;
  final List<T> items;
  final Map<String, dynamic> map;
  final FormFieldType type;
  final Widget suffixIcon;
  final bool enabled;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final _model = FormFieldModel.mapType(type, map);
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: suffixIcon ?? Icon(_model.iconData),
          fillColor: Theme.of(context).primaryColor.withOpacity(.1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
          hintText: _model.hintText,
          labelText: _model.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        items: [
          ...items.map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                itemAsString(e),
                overflow: TextOverflow.visible,
              ),
            ),
          )
        ],
        onChanged: onChanged,
        validator: validator,
        onSaved: onSave,
        onTap: () => Helpers.dismissFauces(context),
      ),
    );
  }
}

class CustomSearchDropdownFromField<T> extends StatelessWidget {
  const CustomSearchDropdownFromField({
    Key key,
    @required this.map,
    @required this.type,
    @required this.itemAsString,
    @required this.onChanged,
    @required this.items,
    this.onSave,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
    this.obscureText = false,
  }) : super(key: key);

  final String Function(T) itemAsString;
  final String Function(T) validator;
  final ValueChanged<T> onChanged;
  final ValueChanged<T> onSave;
  final List<T> items;
  final Map<String, dynamic> map;
  final FormFieldType type;
  final Widget suffixIcon;
  final bool enabled;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final _model = FormFieldModel.mapType(type, map);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownSearch<T>(
        itemAsString: itemAsString,
        items: items,
        label: _model.hintText,
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
        onChanged: onChanged,
        validator: validator,
        onSaved: onSave,
      ),
    );
  }
}
