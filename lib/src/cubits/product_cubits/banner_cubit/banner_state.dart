part of 'banner_cubit.dart';

@freezed
abstract class BannerState with _$BannerState {
  const factory BannerState.loading() = _Loading;
  const factory BannerState.success(List<BannerModel> values) = _Success;
  const factory BannerState.failure({String message}) = _Failure;
}
