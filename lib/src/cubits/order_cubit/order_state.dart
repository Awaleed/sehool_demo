part of 'order_cubit.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;
  const factory OrderState.loading() = _Loading;
  const factory OrderState.success(OrderModel value) = _Success;
  const factory OrderState.failure({String message}) = _Failure;
}
