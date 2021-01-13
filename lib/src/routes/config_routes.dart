import 'package:sailor/sailor.dart';
import 'package:supercharged/supercharged.dart';

import '../screens/auth/forgot_password.dart';
import '../screens/auth/login.dart';
import '../screens/auth/register.dart';
import '../screens/cart/add_to_cart.dart';
import '../screens/cart/cart.dart';
import '../screens/debug/playground.dart';
import '../screens/home/home.dart';
import '../screens/onboarding.dart';
import '../screens/product/product.dart';
import '../screens/profile/dialogs/new_address_dialog.dart';
import '../screens/profile/pages/addresses.dart';
import '../screens/profile/pages/language.dart';
import '../screens/profile/profile_settings.dart';
import '../screens/splash.dart';
import '../screens/video/video.dart';

abstract class AppRouter {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      defaultTransitionDuration: 700.milliseconds,
      defaultTransitions: [
        SailorTransition.fade_in,
        // SailorTransition.zoom_in,
      ],
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
        SailorRoute(
          name: RegistrationScreen.routeName,
          builder: (context, args, paramMap) => const RegistrationScreen(),
        ),
        SailorRoute(
          name: ForgotPasswordScreen.routeName,
          builder: (context, args, paramMap) => const ForgotPasswordScreen(),
        ),

        /// App Screens
        SailorRoute(
          name: HomeScreen.routeName,
          builder: (context, args, paramMap) => const HomeScreen(),
        ),

        /// Product Screens
        SailorRoute(
          name: ProductScreen.routeName,
          builder: (context, args, paramMap) =>
              ProductScreen(product: paramMap.param('product')),
          params: [SailorParam(name: 'product', isRequired: true)],
        ),

        /// Video Screens
        SailorRoute(
          name: VideoScreen.routeName,
          builder: (context, args, paramMap) => VideoScreen(
            video: paramMap.param('video'),
          ),
          params: [
            SailorParam(name: 'product', isRequired: true),
            SailorParam(name: 'cubit', isRequired: true),
          ],
        ),

        /// Cart Screens
        SailorRoute(
          name: AddToCartScreen.routeName,
          builder: (context, args, paramMap) =>
              AddToCartScreen(product: paramMap.param('product')),
          params: [SailorParam(name: 'product', isRequired: true)],
        ),
        SailorRoute(
          name: CartScreen.routeName,
          builder: (context, args, paramMap) => const CartScreen(),
        ),

        /// Profile Screens
        SailorRoute(
          name: ProfileSettingsScreen.routeName,
          builder: (context, args, paramMap) => const ProfileSettingsScreen(),
        ),
        SailorRoute(
          name: LanguageScreen.routeName,
          builder: (context, args, paramMap) => const LanguageScreen(),
        ),
        SailorRoute(
          name: AddressesScreen.routeName,
          builder: (context, args, paramMap) => const AddressesScreen(),
        ),
        SailorRoute(
          name: NewAddressDialog.routeName,
          builder: (context, args, paramMap) => NewAddressDialog(),
          params: [SailorParam(name: 'AddressCubit', isRequired: true)],
        ),

        /// Debug Screens
        SailorRoute(
          name: Playground.routeName,
          builder: (context, args, paramMap) => const Playground(),
        ),
      ],
    );
  }
}
