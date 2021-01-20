import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../init_injectable.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    debugPrint('onCreate -- cubit: ${cubit.runtimeType}');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    debugPrint('onChange -- cubit: ${cubit.runtimeType}, change: $change');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    debugPrint('onError -- cubit: ${cubit.runtimeType}, error: $error');
    if (error is DioError) {
      if (error.response.statusCode == 401) {
        getIt<AuthCubit>().unauthenticateUser();
      }
    }
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    debugPrint('onClose -- cubit: ${cubit.runtimeType}');
  }
}
