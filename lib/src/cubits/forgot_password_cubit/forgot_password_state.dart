part of 'forgot_password_cubit.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.loading() = _Loading;

  const factory ForgotPasswordState.enterYourEmail() = _EnterYourEmail;

  const factory ForgotPasswordState.enterNewPassword(
      {String email, int timeout}) = _EnterNewPassword;

  const factory ForgotPasswordState.success() = _Success;

  const factory ForgotPasswordState.failureOnEnterYourEmail({String message}) =
      _FailureOnEnterYourEmail;

  const factory ForgotPasswordState.failureOnNewPassword(
      {String message, String email, int timeout}) = _FailureOnNewPassword;
}
