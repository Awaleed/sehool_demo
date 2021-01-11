import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/models/settings_model.dart';

import 'src/data/settings_datasource.dart';
import 'src/data/user_datasource.dart';

List<String> _boxesNames = [
  settingsBoxName,
  userBoxName,
];

List<TypeAdapter> _adapters = [
  SettingsModelAdapter()
];

Future<void> initHive() async {
  if (kIsWeb) {
    Hive.init('hive_data');
  } else {
    await Hive.initFlutter();
  }
  for (final adapter in _adapters) {
    Hive.registerAdapter(adapter);
  }
  for (final name in _boxesNames) {
    await Hive.openBox(name);
  }
}
