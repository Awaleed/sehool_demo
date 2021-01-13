import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/auth_repository.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepository)
      : super(const ForgotPasswordState.enterYourEmail());

  final IAuthRepository _authRepository;
  String _email;
  int _timeOut;

  Future<void> requestCode(String email) async {
    emit(ForgotPasswordState.enterYourEmailLoading(email: email));
    try {
      final timeOut = await _authRepository.forgotPassword(email);
      _email = email;
      _timeOut = timeOut;
      emit(
        ForgotPasswordState.enterNewPassword(email: email, timeout: timeOut),
      );
    } catch (e) {
      // TODO: Handel error messages
      emit(ForgotPasswordState.failureOnEnterYourEmail(message: '$e'));
    }
  }

  Future<void> setPassword(String password) async {
    emit(ForgotPasswordState.enterNewPasswordLoading(email: _email));
    try {
      await _authRepository.resetPassword(_email, password);
      emit(const ForgotPasswordState.success());
    } catch (e) {
      // TODO: Handel error messages
      emit(ForgotPasswordState.failureOnNewPassword(
        email: _email,
        message: '$e',
        timeout: _timeOut,
      ));
    }
  }

  void editEmail() => emit(ForgotPasswordState.enterYourEmail(email: _email));

  void resend() {
    requestCode(_email);
  }
}
