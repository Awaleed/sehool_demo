import 'package:sailor/sailor.dart';
import 'package:supercharged/supercharged.dart';

import '../screens/auth/login.dart';
import '../screens/cart/add_to_cart.dart';
import '../screens/checkout/checkout.dart';
import '../screens/home/home.dart';
import '../screens/onboarding.dart';
import '../screens/product/product.dart';
import '../screens/profile/dialogs/new_address_dialog.dart';
import '../screens/profile/pages/addresses.dart';
import '../screens/profile/pages/language.dart';
import '../screens/profile/pages/orders_history.dart';
import '../screens/profile/profile_settings.dart';
import '../screens/splash.dart';

abstract class AppRouter {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      defaultTransitionDuration: 700.milliseconds,
      defaultTransitions: [
        SailorTransition.fade_in,
      ],
    ),
  );

  static void createRoutes() {
    sailor.addRoutes(
      [
        SailorRoute(
          name: SplashScreen.routeName,
          builder: (context, args, paramMap) => const SplashScreen(),
        ),
        SailorRoute(
          name: OnboardingScreen.routeName,
          builder: (context, args, paramMap) => const OnboardingScreen(),
        ),
        SailorRoute(
          name: LoginScreen.routeName,
          builder: (context, args, paramMap) => const LoginScreen(),
        ),
        SailorRoute(
          name: HomeScreen.routeName,
          builder: (context, args, paramMap) => const HomeScreen(),
        ),
        SailorRoute(
          name: ProductScreen.routeName,
          builder: (context, args, paramMap) => ProductScreen(product: paramMap.param('product')),
          params: [SailorParam(name: 'product', isRequired: true)],
        ),
        SailorRoute(
          name: AddToCartScreen.routeName,
          builder: (context, args, paramMap) => AddToCartScreen(
            product: paramMap.param('product'),
            cartItem: paramMap.param('cart_item'),
            editing: paramMap.param('editing'),
          ),
          params: [
            SailorParam(name: 'product'),
            SailorParam(name: 'cart_item'),
            SailorParam(name: 'editing', defaultValue: false),
          ],
        ),
        SailorRoute(
          name: CheckoutScreen.routeName,
          builder: (context, args, paramMap) => const CheckoutScreen(),
        ),
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
          name: OrdersHistory.routeName,
          builder: (context, args, paramMap) => const OrdersHistory(),
        ),
        SailorRoute(
          name: NewAddressDialog.routeName,
          builder: (context, args, paramMap) => NewAddressDialog(
            cubit: paramMap.param('address_cubit'),
          ),
          params: [SailorParam(name: 'address_cubit')],
        ),
      ],
    );
  }
}
