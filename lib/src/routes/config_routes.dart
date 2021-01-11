import 'package:sailor/sailor.dart';

abstract class AppRouter {
  static final sailor = Sailor(
    options: const SailorOptions(
      handleNameNotFoundUI: true,
      isLoggingEnabled: true,
    ),
  );

  static void createRoutes() {
    sailor.addRoutes(
      [],
    );
  }
}
