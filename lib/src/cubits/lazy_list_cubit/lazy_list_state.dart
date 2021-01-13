part of 'lazy_list_cubit.dart';

@freezed
abstract class LazyListState with _$LazyListState {
  const factory LazyListState.initial() = _Initial;
  const factory LazyListState.loading() = _Loading;
  const factory LazyListState.loadingMore(List values) = _LoadingMore;
  const factory LazyListState.success(List values) = _Success;
  const factory LazyListState.finished(List values) = _Finished;
  const factory LazyListState.failure({String message, List values}) = _Failure;
  const factory LazyListState.failureOnLoadMore({String message, List values}) =
      _FailureOnLoadMore;
}
