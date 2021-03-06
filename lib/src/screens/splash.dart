import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../init_injectable.dart';
import '../cubits/splash_cubit/splash_cubit.dart';
import '../routes/config_routes.dart';
import 'auth/login.dart';
import 'home/home.dart';

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
        String routeName;
        switch (state) {
          case SplashState.initial:
            break;
          case SplashState.authenticated:
            routeName = HomeScreen.routeName;
            break;
          case SplashState.firstLaunch:

          case SplashState.unauthenticated:
            routeName = LoginScreen.routeName;
            break;
        }

        AppRouter.sailor.navigate(
          routeName,
          navigationType: NavigationType.pushAndRemoveUntil,
          removeUntilPredicate: (_) => false,
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xffDCA11B),
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
            child: Image.asset('assets/images/black.png'),
          ),
        ),
      ),
    );
  }
}
