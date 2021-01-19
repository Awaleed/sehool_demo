part of 'product_cubit.dart';

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState.loading() = _Loading;
  const factory ProductState.success(List<ProductModel> values) = _Success;
  const factory ProductState.failure({String message}) = _Failure;
}
