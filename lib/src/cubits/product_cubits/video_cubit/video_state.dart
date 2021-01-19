part of 'video_cubit.dart';

@freezed
abstract class VideoState with _$VideoState {
  const factory VideoState.loading() = _Loading;
  const factory VideoState.success(List<VideoModel> values) = _Success;
  const factory VideoState.failure({String message}) = _Failure;
}
