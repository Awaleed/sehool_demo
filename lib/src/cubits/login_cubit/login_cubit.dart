import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../models/form_data_model.dart';

import '../../../init_injectable.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';
import '../auth_cubit/auth_cubit.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState.initial());

  final IAuthRepository _authRepository;

  Future<void> login(Map<FormFieldType, FormFieldModel> credentials) async {
    emit(const LoginState.loading());
    try {
      await _authRepository.login(credentials);
      emit(const LoginState.success());
      getIt<AuthCubit>().authenticateUser();
        } catch (e) {
      addError(e);
      // TODO: Handel error messages
      emit(LoginState.failure(message: '$e'));
    }
  }
}
