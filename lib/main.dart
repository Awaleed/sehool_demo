import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/screens/splash.dart';

import 'generated/l10n.dart';
import 'init_hive.dart';
import 'init_injectable.dart';
import 'src/cubits/auth_cubit/auth_cubit.dart';
import 'src/data/settings_datasource.dart';
import 'src/routes/config_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  configureDependencies();
  AppRouter.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box(settingsBoxName).listenable(),
        builder: (context, box, widget) {
          return BlocListener<AuthCubit, AuthState>(
            cubit: getIt<AuthCubit>(),
            listener: (context, state) {
              AppRouter.sailor.navigate(SplashScreen.routeName);
            },
            child: MaterialApp(
              title: 'Sehool',
              //TODO: add theme here
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: box.get(currentSettingsKey)?.locale,
              onGenerateRoute: AppRouter.sailor.generator(),
              navigatorKey: AppRouter.sailor.navigatorKey,
              navigatorObservers: [
                SailorLoggingObserver(),
                AppRouter.sailor.navigationStackObserver,
              ],
            ),
          );
        });
  }
}
