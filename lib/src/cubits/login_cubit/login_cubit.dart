import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../helpers/helper.dart';
import '../../repositories/auth_repository.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState.initial());

  final IAuthRepository _authRepository;

  Future<void> login(Map<String, dynamic> credentials) async {
    emit(const LoginState.loading());
    try {
      await _authRepository.login(credentials);
      emit(const LoginState.success());
    } catch (e) {
      emit(LoginState.failure(message: Helpers.mapErrorToMessage(e)));
    }
  }

  Future<void> registration(FormData credentials) async {
    emit(const LoginState.loading());
    try {
      await _authRepository.register(credentials);
      emit(const LoginState.success());
    } catch (e) {
      emit(LoginState.failure(message: Helpers.mapErrorToMessage(e)));
    }
  }

  Future<void> requestCode(String email) async {
    emit(const LoginState.loading());
    try {
      await _authRepository.forgotPassword(email);

      emit(const LoginState.codeRequested());
    } catch (e) {
      emit(LoginState.failure(message: Helpers.mapErrorToMessage(e)));
    }
  }
}
