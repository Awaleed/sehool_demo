part of 'dropdown_cubit.dart';

@freezed
abstract class DropdownState with _$DropdownState {
  const factory DropdownState.initial() = _Initial;
  const factory DropdownState.loading() = _Loading;
  const factory DropdownState.success(List<DropdownValueModel> values) =
      _Success;
  const factory DropdownState.failure({String message}) = _Failure;
}
