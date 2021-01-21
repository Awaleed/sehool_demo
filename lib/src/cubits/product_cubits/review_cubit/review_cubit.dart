import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../helpers/helper.dart';
import '../../../models/product_model.dart';
import '../../../repositories/product_repository.dart';

part 'review_cubit.freezed.dart';
part 'review_state.dart';

@injectable
class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._productRepository) : super(const ReviewState.initial());

  final IProductRepository _productRepository;
  int _productId;
  int _rating;
  String _review;

  Future<void> retryGetReviews() => getReviews(_productId);

  Future<void> getReviews(int productId) async {
    _productId = productId;
    emit(const ReviewState.loading());
    try {
      final values = await _productRepository.getReviews(productId);
      emit(ReviewState.success(values));
    } catch (e) {
      emit(ReviewState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> retryAddReview() =>
      addReview(productId: _productId, rating: _rating, review: _review);

  Future<void> addReview({
    int productId,
    int rating,
    String review,
  }) async {
    _productId = productId;
    _rating = rating;
    _review = review;

    emit(ReviewState.addingReview(
      state.maybeWhen(success: (values) => values, orElse: () => []),
    ));
    try {
      final value = await _productRepository.addReview(
        productId: productId,
        rating: rating,
        review: review,
      );
      emit(ReviewState.success(value));
    } catch (e) {
      emit(ReviewState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
