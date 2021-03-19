import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../init_injectable.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    if (error is DioError) {
      if (error.response.statusCode == 401) {
        getIt<AuthCubit>().unauthenticateUser();
      }
    }
    super.onError(cubit, error, stackTrace);
  }
}
