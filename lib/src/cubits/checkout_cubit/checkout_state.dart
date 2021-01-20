part of 'checkout_cubit.dart';

@freezed
abstract class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;

  const factory CheckoutState.loading() = _Loading;

  const factory CheckoutState.visaPayment(String payUrl) = _VisaPayment;

  const factory CheckoutState.success() = _Success;

  const factory CheckoutState.failure({String message}) = _Failure;
}
