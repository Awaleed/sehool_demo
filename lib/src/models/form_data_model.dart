import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

enum FormFieldType {
  height,
  userId,
  sportId,
  weight,
  mainPositionId,
  otherPositionId,
  startActivity,
  skills,
  professionalId,
  currentClub,
  achievements,
  biography,
  vision,
  educationalLevel,
  ageCategory,
  certificate,
  yearsOfExperience,
  fitness,
  specializations,
  reference,
  method,
  language,
  critic,
  clubId,
  leagueId,
  playerId,
  address,
  establishment,
  percentage,
  conditions,
  agencyId,
}

class FormFieldModel {
  final String name;
  final String hintText;
  final IconData iconData;
  final TextInputType keyboardType;
  final String Function(dynamic value) validator;
  final IconData icon;
  final void Function(dynamic value) onSave;

  dynamic value;

  FormFieldModel({
    this.name,
    this.hintText,
    this.iconData,
    this.keyboardType,
    this.validator,
    this.icon,
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
      case FormFieldType.height:
        return FormFieldModel(
          hintText: 'الطول',
          iconData: Icons.height_outlined,
          keyboardType: TextInputType.number,
          validator: _Validators.numericValidator,
          onSave: (value) {
            map[FormFieldType.height] = FormFieldModel(
              name: 'height',
              value: _toDouble(value),
            );
          },
        );
      case FormFieldType.weight:
        return FormFieldModel(
          iconData: Icons.panorama_horizontal_outlined,
          hintText: 'الوزن',
          validator: _Validators.numericValidator,
          keyboardType: TextInputType.number,
          onSave: (value) {
            map[FormFieldType.weight] = FormFieldModel(
              name: 'weight',
              value: _toDouble(value),
            );
          },
        );
      case FormFieldType.mainPositionId:
        return FormFieldModel(
          iconData: Icons.location_history_outlined,
          hintText: 'المركز الرئيسي',
          validator: _Validators.notNullValidator,
          onSave: (value) {
            map[FormFieldType.mainPositionId] = FormFieldModel(
              name: 'main_position_id',
              value: _toInt(value),
            );
          },
        );
      case FormFieldType.otherPositionId:
        return FormFieldModel(
          iconData: Icons.person_pin_circle_outlined,
          hintText: 'المركز الفرعي',
          validator: _Validators.notNullValidator,
          onSave: (value) {
            map[FormFieldType.otherPositionId] = FormFieldModel(
              name: 'other_position_id',
              value: _toInt(value),
            );
          },
        );
      case FormFieldType.startActivity:
        return FormFieldModel(
          hintText: 'تاريخ بدء النشاط',
          iconData: Icons.date_range_outlined,
          validator: _Validators.notNullValidator,
          onSave: (value) {
            map[FormFieldType.startActivity] = FormFieldModel(
              name: 'start_activity',
              value: _toString('$value'),
            );
          },
        );
      case FormFieldType.skills:
        return FormFieldModel(
          hintText: 'المهارات',
          iconData: Icons.block_outlined,
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.skills] = FormFieldModel(
              name: 'skills',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.professionalId:
        return FormFieldModel(
          iconData: Icons.next_week_outlined,
          hintText: 'الاحتراف',
          validator: _Validators.notNullValidator,
          onSave: (value) {
            map[FormFieldType.professionalId] = FormFieldModel(
              name: 'professional_id',
              value: _toInt(value),
            );
          },
        );
      case FormFieldType.currentClub:
        return FormFieldModel(
          iconData: Icons.people_alt_outlined,
          hintText: 'النادي الحالي',
          validator: _Validators.notNullValidator,
          onSave: (value) {
            map[FormFieldType.currentClub] = FormFieldModel(
              name: 'current_club',
              value: _toInt(value),
            );
          },
        );
      case FormFieldType.biography:
        return FormFieldModel(
          iconData: Icons.post_add_outlined,
          hintText: 'السيرة الذاتية',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.biography] = FormFieldModel(
              name: 'biography',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.vision:
        return FormFieldModel(
          hintText: 'الرؤية',
          iconData: Icons.visibility_rounded,
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.vision] = FormFieldModel(
              name: 'vision',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.educationalLevel:
        return FormFieldModel(
          iconData: Icons.school,
          hintText: 'المستوي التعليمي',
          validator: _Validators.notNullValidator,
          onSave: (value) {
            map[FormFieldType.educationalLevel] = FormFieldModel(
              name: 'educational_level',
              value: _toInt(value),
            );
          },
        );
      case FormFieldType.ageCategory:
        return FormFieldModel(
          iconData: Icons.school,
          hintText: 'الفئة العمرية',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.ageCategory] = FormFieldModel(
              name: 'age_category',
              value: _toString(value),
            );
          },
        );

      case FormFieldType.certificate:
        return FormFieldModel(
          iconData: Icons.school,
          hintText: 'الشهادة',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.certificate] = FormFieldModel(
              name: 'certificate',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.yearsOfExperience:
        return FormFieldModel(
          iconData: Icons.school,
          hintText: 'سنوات الخبرة',
          validator: _Validators.numericValidator,
          onSave: (value) {
            map[FormFieldType.yearsOfExperience] = FormFieldModel(
              name: 'years_of_experience',
              value: _toInt(value),
            );
          },
        );

      case FormFieldType.fitness:
        return FormFieldModel(
          iconData: Icons.school,
          hintText: 'اللياقة',
          validator: _Validators.numericValidator,
          onSave: (value) {
            map[FormFieldType.fitness] = FormFieldModel(
              name: 'fitness',
              value: _toInt(value),
            );
          },
        );
      case FormFieldType.reference:
        return FormFieldModel(
          iconData: Icons.school,
          hintText: 'العمل السابق',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.reference] = FormFieldModel(
              name: 'reference',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.specializations:
        return FormFieldModel(
          iconData: Icons.school,
          hintText: 'التخصص',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.specializations] = FormFieldModel(
              name: 'specializations',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.method:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'الطريقه',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.method] = FormFieldModel(
              name: 'method',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.language:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'اللغه',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.language] = FormFieldModel(
              name: 'language',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.critic:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'النقاد',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.critic] = FormFieldModel(
              name: 'critic',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.playerId:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'اللاعب',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.playerId] = FormFieldModel(
              name: 'player',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.clubId:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'النادي',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.clubId] = FormFieldModel(
              name: 'club',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.leagueId:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'الدوري',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.leagueId] = FormFieldModel(
              name: 'league',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.address:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'العنوان',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.address] = FormFieldModel(
              name: 'address',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.establishment:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'الموسسه',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.establishment] = FormFieldModel(
              name: 'establishment',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.percentage:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'النسبه',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            map[FormFieldType.percentage] = FormFieldModel(
              name: 'percentage',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.agencyId:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'الوكاله',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            // ignore: unnecessary_statements
            map[FormFieldType.agencyId] = FormFieldModel(
              name: 'agency',
              value: _toString(value),
            );
          },
        );
      case FormFieldType.conditions:
        return FormFieldModel(
          iconData: Icons.change_history,
          hintText: 'الحاله',
          validator: _Validators.notEmptyStringValidator,
          onSave: (value) {
            // ignore: unnecessary_statements
            map[FormFieldType.conditions] = FormFieldModel(
              name: 'conditions',
              value: _toString(value),
            );
          },
        );

      case FormFieldType.userId:
      case FormFieldType.sportId:
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
