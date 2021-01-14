import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';

part 'review_cubit.freezed.dart';
part 'review_state.dart';

@injectable
class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._productRepository) : super(const ReviewState.initial());

  final IProductRepository _productRepository;

  Future<void> getReviews(int productId) async {
    emit(const ReviewState.loading());
    try {
      final values = await _productRepository.getReviews(productId: productId);
      emit(ReviewState.success(values));
    } catch (e) {
      addError(e);
      // TODO: Handel error messages
      emit(ReviewState.failure(message: '$e'));
    }
  }

  Future<void> addReview({
    int productId,
    int rating,
    String review,
  }) async {
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
      addError(e);
      // TODO: Handel error messages
      emit(ReviewState.failure(message: '$e'));
    }
  }
}
