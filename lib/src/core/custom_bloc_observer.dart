import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../init_injectable.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    // print('onCreate -- cubit: ${cubit.runtimeType}');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    // print('onChange -- cubit: ${cubit.runtimeType}, change: $change');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    // print('onError -- cubit: ${cubit.runtimeType}, error: $error');
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
    // print('onClose -- cubit: ${cubit.runtimeType}');
  }
}
