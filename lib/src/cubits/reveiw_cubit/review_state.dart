part of 'review_cubit.dart';

@freezed
abstract class ReviewState with _$ReviewState {
  const factory ReviewState.initial() = _Initial;
  const factory ReviewState.loading() = _Loading;
  const factory ReviewState.success(ReviewModel value) = _Success;
  const factory ReviewState.failure({String message}) = _Failure;
}
