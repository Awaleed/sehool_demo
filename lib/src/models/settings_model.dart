import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel extends HiveObject {
  @HiveField(0)
  bool isFirstLaunch;

  @HiveField(1)
  String languageCode;

  @HiveField(2)
  int themeIndex;

  Locale get locale => Locale(languageCode, '');

  SettingsModel({this.isFirstLaunch, this.languageCode, this.themeIndex});
}
