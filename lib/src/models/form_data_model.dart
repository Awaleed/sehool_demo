import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../generated/l10n.dart';

enum FormFieldType {
  address,
  location,
  password,
  name,
  email,
  notes,
  phone,
  cityId,
  citySectionId,
  level,
  storeName,
  vatNumber,
  commercialRegister,
}

class FormFieldModel {
  final String name;
  final String hintText;
  final String labelText;
  final IconData iconData;
  final TextInputType keyboardType;
  final String Function(dynamic value) validator;
  final void Function(dynamic value) onSave;

  dynamic value;

  FormFieldModel({
    this.name,
    this.hintText,
    this.labelText,
    this.iconData,
    this.keyboardType,
    this.validator,
    this.onSave,
    this.value,
  });

  // static Map<String, dynamic> generateJson(
  //   Map<String, dynamic> map,
  // ) {
  //   final jsonMap = <String, dynamic>{};
  //   for (final item in map.entries) {
  //     if (item.value?.value == null) continue;
  //     jsonMap[item.value.name] = item.value.value;
  //   }
  //   return jsonMap;
  // }

  factory FormFieldModel.mapType(FormFieldType type, Map<String, dynamic> map) {
    switch (type) {
      case FormFieldType.name:
        return FormFieldModel(
          hintText: S.current.john_doe,
          labelText: S.current.full_name,
          iconData: FluentIcons.person_28_regular,
          keyboardType: TextInputType.text,
          validator: Validators.shortStringValidator,
          onSave: (value) => map['name'] = _toString(value),
        );
      case FormFieldType.address:
        return FormFieldModel(
          hintText: S.current.address,
          labelText: S.current.address_title,
          iconData: FluentIcons.location_28_regular,
          keyboardType: TextInputType.text,
          validator: Validators.notEmptyStringValidator,
          onSave: (value) => map['address'] = _toString(value),
        );
      case FormFieldType.location:
        return FormFieldModel(
          hintText: S.current.show_on_map,
          labelText: S.current.show_on_map,
          iconData: FluentIcons.location_28_regular,
          keyboardType: TextInputType.text,
          validator: Validators.notNullValidator,
          onSave: (value) {
            map['lat'] = _toDouble(value.latitude);
            map['lang'] = _toDouble(value.longitude);
          },
        );
      case FormFieldType.password:
        return FormFieldModel(
          hintText: '************',
          labelText: S.current.password,
          iconData: FluentIcons.eye_show_24_regular,
          keyboardType: TextInputType.visiblePassword,
          validator: Validators.longStringValidator,
          onSave: (value) => map['password'] = _toString(value),
        );
      case FormFieldType.email:
        return FormFieldModel(
          hintText: 'example@example.com',
          labelText: S.current.email,
          iconData: FluentIcons.mail_28_regular,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (!isEmail(value)) return S.current.should_be_a_valid_email;
            return null;
          },
          onSave: (value) => map['email'] = _toString(value),
        );
      case FormFieldType.phone:
        return FormFieldModel(
          hintText: '0599676388',
          labelText: S.current.phone,
          iconData: FluentIcons.call_28_regular,
          keyboardType: TextInputType.number,
          validator: Validators.numericValidator,
          onSave: (value) => map['phone'] = _toString(value),
        );
      case FormFieldType.notes:
        return FormFieldModel(
          hintText: S.current.notes,
          iconData: FluentIcons.send_28_regular,
          keyboardType: TextInputType.multiline,
          validator: Validators.notEmptyStringValidator,
          onSave: (value) => map['note'] = _toString(value),
        );
      case FormFieldType.cityId:
        return FormFieldModel(
          hintText: S.current.city,
          iconData: FluentIcons.location_28_regular,
          keyboardType: TextInputType.number,
          validator: Validators.notNullValidator,
          onSave: (value) => map['city_id'] = _toInt(value),
        );
      case FormFieldType.citySectionId:
        return FormFieldModel(
          hintText: S.current.neighborhood,
          iconData: FluentIcons.location_28_regular,
          keyboardType: TextInputType.number,
          validator: Validators.notNullValidator,
          onSave: (value) => map['section_id'] = _toInt(value),
        );
      case FormFieldType.level:
        return FormFieldModel(
          hintText: S.current.level,
          labelText: S.current.level,
          iconData: FluentIcons.person_accounts_24_regular,
          validator: Validators.notNullValidator,
          onSave: (value) => map['level'] = _toString(value),
        );
      case FormFieldType.storeName:
        return FormFieldModel(
          hintText: S.current.store,
          labelText: S.current.store,
          iconData: Icons.store,
          keyboardType: TextInputType.text,
          validator: Validators.shortStringValidator,
          onSave: (value) => map['store_name'] = _toString(value),
        );
      case FormFieldType.vatNumber:
        return FormFieldModel(
          hintText: S.current.choose_an_image,
          labelText: S.current.vat_number,
          iconData: FluentIcons.money_24_regular,
          keyboardType: TextInputType.number,
          validator: Validators.notEmptyStringValidator,
          onSave: (value) {
            map['vat_number'] = _toString(value);
          },
        );
      case FormFieldType.commercialRegister:
        return FormFieldModel(
          hintText: S.current.choose_an_image,
          labelText: S.current.commercial_register,
          iconData: FluentIcons.connector_24_regular,
          keyboardType: TextInputType.number,
          validator: Validators.notEmptyStringValidator,
          onSave: (value) {
            map['commercial_register'] = _toString(value);
          },
        );
      default:
        throw UnsupportedError(
          'Unsupported FormFieldModel with prams FormFieldType $type, Map<String, dynamic> $BigInt.one',
        );
    }
  }

  static double _toDouble(value) => double.tryParse(value?.toString() ?? '');

  static int _toInt(value) => int.tryParse(value.toString() ?? '');

  static String _toString(value) => value?.toString()?.trim();
}

abstract class Validators {
  static String notEmptyStringValidator(dynamic value) {
    if (value is String) {
      if (value.isEmpty || value == null) {
        return S.current.must_not_be_empty;
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }

  static String shortStringValidator(dynamic value) {
    if (value is String) {
      if (value.length < 3 || value == null) {
        return S.current.should_be_more_than_3_letters;
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }

  static String longStringValidator(dynamic value) {
    if (value is String) {
      if (value.length < 6 || value == null) {
        return S.current.should_be_more_than_6_letters;
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }

  static String notNullValidator(dynamic value) {
    if (value == null) {
      return S.current.please_choose_one;
    }
    return null;
  }

  static String numericValidator(dynamic value) {
    if (value is String) {
      if (!isNumeric(value) || value.isEmpty || value == null) {
        return S.current.enter_a_valid_number;
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }
}
