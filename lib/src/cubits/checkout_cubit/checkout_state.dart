part of 'checkout_cubit.dart';

@freezed
abstract class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loading() = _Loading;
  const factory CheckoutState.success(OrderModel value) = _Success;
  const factory CheckoutState.failure({String message}) = _Failure;
}
