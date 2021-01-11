part of 'registration_cubit.dart';

@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = _Initial;
  const factory RegistrationState.loading() = _Loading;
  const factory RegistrationState.success() = _Success;
  const factory RegistrationState.failure({String message}) =
      _Failure;
}
