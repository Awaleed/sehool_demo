import 'package:sailor/sailor.dart';
import 'package:sehool/src/screens/auth/login.dart';
import 'package:sehool/src/screens/home.dart';
import 'package:sehool/src/screens/onboarding.dart';

import '../screens/splash.dart';

abstract class AppRouter {
  static final sailor = Sailor(
    options: const SailorOptions(
      handleNameNotFoundUI: true,
      isLoggingEnabled: true,
    ),
  );

  static void createRoutes() {
    sailor.addRoutes(
      [
        /// Pre Login
        SailorRoute(
          name: SplashScreen.routeName,
          builder: (context, args, paramMap) => const SplashScreen(),
        ),
        SailorRoute(
          name: OnboardingScreen.routeName,
          builder: (context, args, paramMap) => const OnboardingScreen(),
        ),

        /// Auth Screens
        SailorRoute(
          name: LoginScreen.routeName,
          builder: (context, args, paramMap) => const LoginScreen(),
        ),

        /// App Screens
        SailorRoute(
          name: HomeScreen.routeName,
          builder: (context, args, paramMap) => const HomeScreen(),
        ),
      ],
    );
  }
}
