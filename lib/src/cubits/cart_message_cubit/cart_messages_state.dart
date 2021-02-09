part of 'cart_messages_cubit.dart';

@freezed
abstract class CartMessagesState with _$CartMessagesState {
  const factory CartMessagesState.initial() = _Initial;
  const factory CartMessagesState.loading() = _Loading;
  const factory CartMessagesState.success(CartMessageModel value) = _Success;
  const factory CartMessagesState.failure({String message}) = _Failure;
}
