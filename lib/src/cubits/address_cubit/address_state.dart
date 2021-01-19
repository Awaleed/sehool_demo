part of 'address_cubit.dart';

@freezed
abstract class AddressState with _$AddressState {
  const factory AddressState.initial() = _Initial;
  const factory AddressState.loading() = _Loading;
  const factory AddressState.created() = _Created;
  const factory AddressState.success(List<AddressModel> value) = _Success;
  const factory AddressState.failure({String message}) = _Failure;
}
