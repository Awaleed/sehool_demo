part of 'address_cubit.dart';

@freezed
abstract class AddressState with _$AddressState {
  const factory AddressState.initial() = _Initial;
  const factory AddressState.loading() = _Loading;
  const factory AddressState.success(AddressModel value) = _Success;
  const factory AddressState.failure({String message}) = _Failure;
}
