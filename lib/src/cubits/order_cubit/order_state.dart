part of 'order_cubit.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState.loading() = _Loading;
  const factory OrderState.canceled() = _Canceled;
  const factory OrderState.success(List<OrderModel> value) = _Success;
  const factory OrderState.failure({String message}) = _Failure;
}
