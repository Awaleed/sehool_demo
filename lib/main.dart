import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sailor/sailor.dart';

import 'generated/l10n.dart';
import 'init_hive.dart';
import 'init_injectable.dart';
import 'onesignal.dart';
import 'src/core/custom_bloc_observer.dart';
import 'src/cubits/auth_cubit/auth_cubit.dart';
import 'src/data/settings_datasource.dart';
import 'src/routes/config_routes.dart';
import 'src/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPushNotifications();
  await initHive();
  configureDependencies();
  AppRouter.createRoutes();

  Bloc.observer = CustomBlocObserver();

  await SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
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
            AppRouter.sailor.navigate(
              SplashScreen.routeName,
              navigationType: NavigationType.pushAndRemoveUntil,
              removeUntilPredicate: (_) => false,
            );
          },
          child: MaterialApp(
              title: 'Sehool',
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  brightness: Brightness.dark,
                  actionsIconTheme: IconThemeData(color: Colors.white),
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                primarySwatch: Colors.amber,
                textTheme: GoogleFonts.tajawalTextTheme(),
              ),
              supportedLocales: S.delegate.supportedLocales,
              locale: box.get(currentSettingsKey)?.locale,
              onGenerateRoute: AppRouter.sailor.generator(),
              navigatorKey: AppRouter.sailor.navigatorKey,
              builder: (context, child) {
                return Scaffold(
                  body: child,
                  // floatingActionButton: FloatingActionButton(
                  //   onPressed: () {},
                  // ),
                );
                //   return Stack(
                //     fit: StackFit.expand,
                //     children: [
                //       child,
                //       Positioned(
                //         left: 0,
                //         top: 0,
                //         bottom: 0,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             for (var i = 0; i < 4; i++)
                //               // IconButton(
                //               // icon:
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Icon(FontAwesomeIcons.facebook),
                //               ),
                //             // onPressed: () {},
                //             // ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   );
              },
              navigatorObservers: [
                if (kDebugMode) ...[
                  SailorLoggingObserver(),
                  AppRouter.sailor.navigationStackObserver,
                ],
              ]),
        );
      },
    );
  }
}
