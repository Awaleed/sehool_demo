import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/init_injectable.dart';
import 'package:sehool/src/cubits/splash_cubit/splash_cubit.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/auth/login.dart';
import 'package:sehool/src/screens/home.dart';
import 'package:sehool/src/screens/onboarding.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      cubit: getIt<SplashCubit>(),
      listener: (context, state) async {
        // await Future.delayed(5.seconds);
        switch (state) {
          case SplashState.initial:
            break;
          case SplashState.firstLaunch:
            AppRouter.sailor.navigate(OnboardingScreen.routeName);
            break;
          case SplashState.authenticated:
            AppRouter.sailor.navigate(HomeScreen.routeName);
            break;
          case SplashState.unauthenticated:
            AppRouter.sailor.navigate(LoginScreen.routeName);
            break;
        }
      },
      child: Scaffold(
        body: Center(
          child: CustomAnimation<double>(
            control: CustomAnimationControl.MIRROR,
            tween: .5.tweenTo(1.0),
            duration: 1500.milliseconds,
            curve: Curves.easeInOut,
            builder: (context, child, value) => Transform.scale(
              scale: sin(value).abs(),
              child: child,
            ),
            child: const FlutterLogo(size: 200),
          ),
        ),
      ),
    );
  }
}
