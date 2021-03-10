import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  // final floatingKey = ValueKey('DraggableWhatsAppIconState');
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
            // home: LayoutBuilder(
            //   builder: (context, constraints) {
            //     if (!added) WidgetsBinding.instance.addPostFrameCallback((_) => insertOverlay(context));
            //     return Navigator(
            //       key: AppRouter.sailor.navigatorKey,

            //       onGenerateRoute: AppRouter.sailor.generator(),
            //       observers: [
            //         _State(),
            //         // if (kDebugMode) ...[
            //         SailorLoggingObserver(),
            //         AppRouter.sailor.navigationStackObserver,
            //         // ],
            //       ],
            //     );
            //   },
            // ),
            onGenerateRoute: AppRouter.sailor.generator(),
            navigatorKey: AppRouter.sailor.navigatorKey,
            builder: (context, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return child;
                  // if (!added) WidgetsBinding.instance.addPostFrameCallback((_) => insertOverlay(context));
                  // return Navigator(
                  //   key: AppRouter.sailor.navigatorKey,
                  //   onGenerateRoute: AppRouter.sailor.generator(),
                  //   observers: [
                  //     _State(),
                  //     if (kDebugMode) ...[
                  //       SailorLoggingObserver(),
                  //       AppRouter.sailor.navigationStackObserver,
                  //     ],
                  //   ],
                  // );
                },
              );
            }
            //   return DraggableWhatsAppIcon(
            //     key: floatingKey,
            //     child: child,
            // );
            //   return Overlay(
            //     initialEntries: [
            //       OverlayEntry(
            //         builder: (context) => DraggableWhatsAppIcon(
            //           key: floatingKey,
            //           child: child,
            //         ),
            //       ),
            //     ],

            //     // floatingActionButton: FloatingActionButton(
            //     //   onPressed: () {},

            //     // ),
            //   );
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
            // },
            ,
            navigatorObservers: [
              // _State(),
              // if (kDebugMode) ...[
              SailorLoggingObserver(),
              AppRouter.sailor.navigationStackObserver,
              // ],
            ],
          ),
        );
      },
    );
  }
}

// bool added = false;
// void insertOverlay(BuildContext context) {
//   return Overlay.of(context)?.insert(
//     OverlayEntry(builder: (context) {
//       added = true;
//       final size = MediaQuery.of(context).size;
//       print(size.width);
//       return DraggableWhatsAppIcon();
//     }),
//   );
// }

// class _State extends NavigatorObserver {
//   // _State(this.floatingKey);

//   // final Key floatingKey;

//   // @override
//   // void didPop(Route route, Route previousRoute) {
//   //   floatingKey?.currentState?.setState(() {});
//   // }

//   // @override
//   // void didPush(Route route, Route previousRoute) {
//   //   setDraggableWhatsAppIconState?.call();
//   //   // floatingKey?.currentState?.setState(() {});
//   // }

//   // @override
//   // void didRemove(Route route, Route previousRoute) {
//   //   floatingKey?.currentState?.setState(() {});
//   // }

//   // @override
//   // void didReplace({Route newRoute, Route oldRoute}) {
//   //   floatingKey?.currentState?.setState(() {});
//   // }

//   // @override
//   // void didStartUserGesture(Route route, Route previousRoute) {
//   //   floatingKey?.currentState?.setState(() {});
//   // }

//   // @override
//   // void didStopUserGesture() {
//   //   floatingKey?.currentState?.setState(() {});
// }

// }
// Function setDraggableWhatsAppIconState;

// class DraggableWhatsAppIcon extends StatefulWidget {
//   const DraggableWhatsAppIcon({
//     Key key,
//   }) : super(key: key);

//   @override
//   DraggableWhatsAppIconState createState() => DraggableWhatsAppIconState();
// }

// class DraggableWhatsAppIconState extends State<DraggableWhatsAppIcon> {
//   Offset whatsappPosition;
//   Offset telegramPosition;
//   @override
//   void initState() {
//     super.initState();
//     setDraggableWhatsAppIconState = () {
//       setState(() {});
//     };
//     // position = Offset(20.0, 20.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('AppRouter.sailor: ${AppRouter.sailor.navigationStackObserver.getRouteNameStack()}');
//     if (AppRouter.sailor.navigationStackObserver.getRouteNameStack().isEmpty || AppRouter.sailor.navigationStackObserver.getRouteNameStack().contains('/') || AppRouter.sailor.navigationStackObserver.getRouteNameStack().contains('/login')) {
//       return Container();
//     }
//     return SafeArea(
//       child: Stack(
//         fit: StackFit.expand,
//         alignment: Alignment.bottomRight,
//         children: [
//           Positioned(
//             left: whatsappPosition?.dx,
//             top: whatsappPosition?.dy,
//             bottom: whatsappPosition == null ? 100 : null,
//             right: whatsappPosition == null ? 10 : null,
//             child: Draggable(
//               childWhenDragging: Container(),
//               onDragEnd: (details) {
//                 setState(() {
//                   whatsappPosition = details.offset;
//                 });
//                 print(whatsappPosition);
//                 print(whatsappPosition.dx);
//                 print(whatsappPosition.dy);
//               },
//               feedback: FloatingActionButton(
//                 heroTag: 'WhatsappFloatingActionButton',
//                 onPressed: () {
//                   launch('https://api.whatsapp.com/send?phone=966508808940'); // WhatsappFloatingActionButton
//                 },
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.transparent,
//                 child: SvgPicture.asset('assets/images/iconfinder-whatsapp-4550867_121343.svg'),
//                 // child: const Icon(
//                 //   FontAwesomeIcons.whatsapp,
//                 //   color: Color(
//                 //     0xFF20b038,
//                 //   ),
//                 // ),
//               ),
//               child: FloatingActionButton(
//                 heroTag: 'WhatsappFloatingActionButton',
//                 onPressed: () {
//                   launch('https://api.whatsapp.com/send?phone=966508808940');
//                   // WhatsappFloatingActionButton
//                 },
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.transparent,

//                 child: SvgPicture.asset('assets/images/iconfinder-whatsapp-4550867_121343.svg'),
//                 // child: const Icon(
//                 //   FontAwesomeIcons.whatsapp,
//                 //   color: Color(
//                 //     0xFF20b038,
//                 //   ),
//                 // ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: telegramPosition?.dx,
//             top: telegramPosition?.dy,
//             bottom: telegramPosition == null ? 160 : null,
//             right: telegramPosition == null ? 10 : null,
//             child: Draggable(
//               childWhenDragging: Container(),
//               onDragEnd: (details) {
//                 setState(() {
//                   telegramPosition = details.offset;
//                 });
//                 print(telegramPosition);
//                 print(telegramPosition.dx);
//                 print(telegramPosition.dy);
//               },
//               feedback: FloatingActionButton(
//                 heroTag: 'TelegramFloatingActionButton',
//                 onPressed: () {
//                   launch('https://t.me/'); // TelegramFloatingActionButton
//                 },
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.transparent,
//                 child: SvgPicture.asset('assets/images/telegram_104163.svg'),
//                 // child: const Icon(
//                 //   FontAwesomeIcons.whatsapp,
//                 //   color: Color(
//                 //     0xFF20b038,
//                 //   ),
//                 // ),
//               ),
//               child: FloatingActionButton(
//                 heroTag: 'TelegramFloatingActionButton',
//                 onPressed: () {
//                   launch('https://t.me/');
//                   // WhatsappFloatingActionButton
//                 },
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.transparent,

//                 child: SvgPicture.asset('assets/images/telegram_104163.svg'),
//                 // child: const Icon(
//                 //   FontAwesomeIcons.whatsapp,
//                 //   color: Color(
//                 //     0xFF20b038,
//                 //   ),
//                 // ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
