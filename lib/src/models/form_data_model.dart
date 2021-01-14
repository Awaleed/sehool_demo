import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../generated/l10n.dart';

enum FormFieldType {
  /// TODO: MODELS USED HERE REMOVE OTHER
  address,
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

  static Map<String, dynamic> generateJson(
    Map<FormFieldType, FormFieldModel> map,
  ) {
    final jsonMap = <String, dynamic>{};
    for (final item in map.entries) {
      jsonMap[item.value.name] = item.value.value;
    }
    return jsonMap;
  }

  factory FormFieldModel.mapType(
      FormFieldType type, Map<FormFieldType, FormFieldModel> map) {
    switch (type) {
      case FormFieldType.name:
        return FormFieldModel(
          hintText: S.current.john_doe,
          labelText: S.current.full_name,
          iconData: FluentIcons.person_28_regular,
          keyboardType: TextInputType.text,
          validator: _Validators.shortStringValidator,
          onSave: (value) {
            map[FormFieldType.name] = FormFieldModel(
              name: 'name',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.address:
        return FormFieldModel(
          hintText: S.current.address,
          labelText: S.current.address,
          iconData: FluentIcons.location_28_regular,
          keyboardType: TextInputType.text,
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.address] = FormFieldModel(
              name: 'username',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.password:
        return FormFieldModel(
          hintText: '************',
          labelText: S.current.password,
          iconData: FluentIcons.eye_show_24_regular,
          keyboardType: TextInputType.text,
          validator: _Validators.longStringValidator,
          onSave: (value) {
            map[FormFieldType.password] = FormFieldModel(
              name: 'password',
              value: _toString(value),
            );
          },
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
          onSave: (value) {
            map[FormFieldType.email] = FormFieldModel(
              name: 'email',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.phone:
        return FormFieldModel(
          hintText: '0599676388',
          labelText: S.current.phone,
          iconData: FluentIcons.phone_28_regular,
          keyboardType: TextInputType.number,
          validator: _Validators.numericValidator,
          onSave: (value) {
            map[FormFieldType.phone] = FormFieldModel(
              name: 'phone',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.notes:
        return FormFieldModel(
          hintText: 'ملاحظات',
          iconData: FluentIcons.send_28_regular,
          keyboardType: TextInputType.number,
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.notes] = FormFieldModel(
              name: 'notes',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.cityId:
        return FormFieldModel(
          hintText: 'المدينة',
          iconData: FluentIcons.location_28_regular,
          keyboardType: TextInputType.number,
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.cityId] = FormFieldModel(
              name: 'city_id',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.citySectionId:
        return FormFieldModel(
          hintText: 'قطاع المدينة',
          iconData: FluentIcons.location_28_regular,
          keyboardType: TextInputType.number,
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.citySectionId] = FormFieldModel(
              name: 'city_section_id',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.level:
        return FormFieldModel(
          //TODO: Add localization
          hintText: 'S.current.level',
          labelText: 'S.current.level',
          iconData: FluentIcons.person_accounts_24_regular,
          validator: _Validators.notNullValidator,
          onSave: (value) {
            map[FormFieldType.level] = FormFieldModel(
              name: 'level',
              value: _toInt(value),
            );
          },
        );
      case FormFieldType.storeName:
        //TODO: Add localization
        return FormFieldModel(
          hintText: 'S.current.store',
          labelText: 'S.current.store',
          iconData: FluentIcons.store_24_regular,
          keyboardType: TextInputType.text,
          validator: _Validators.shortStringValidator,
          onSave: (value) {
            map[FormFieldType.storeName] = FormFieldModel(
              name: 'store_name',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.vatNumber:
        return FormFieldModel(
          hintText: '123456789123456',
          labelText: 'S.current.vat_number',
          iconData: FluentIcons.money_24_regular,
          keyboardType: TextInputType.number,
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.vatNumber] = FormFieldModel(
              name: 'vat_number',
              value: _toInt(value),
            );
          },
        );
      default:
        throw UnsupportedError(
          'Unsupported FormFieldModel with prams FormFieldType $type, Map<FormFieldType, FormFieldModel> $BigInt.one',
        );
    }
  }

  static double _toDouble(String value) => double.tryParse(value ?? '0') ?? 0;
  static int _toInt(String value) => int.tryParse(value ?? '0') ?? 0;
  static String _toString(String value) => value?.trim();
}

abstract class _Validators {
  static String notEmptyStringValidator(value) {
    if (value is String) {
      if (value.isEmpty || value == null) {
        return 'إملاء هذا الحقل';
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }

  static String shortStringValidator(value) {
    if (value is String) {
      if (value.length < 3 || value == null) {
        return S.current.should_be_more_than_3_letters;
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }

  static String longStringValidator(value) {
    if (value is String) {
      if (value.length < 6 || value == null) {
        return S.current.should_be_more_than_6_letters;
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }

  static String notNullValidator(value) {
    if (value == null) {
      return 'الرجاء إختيار واحد';
    }
    return null;
  }

  static String numericValidator(value) {
    if (value is String) {
      if (!isNumeric(value) || value.isEmpty || value == null) {
        return 'أدخل رقم صحيح';
      }
      return null;
    }
    throw UnsupportedError('value $value');
  }
}
