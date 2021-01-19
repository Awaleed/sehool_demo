import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../models/product_model.dart';
import '../../../repositories/product_repository.dart';

part 'product_cubit.freezed.dart';
part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(const ProductState.loading()) {
    getProducts();
  }

  final IProductRepository _productRepository;

  Future<void> getProducts() async {
    emit(const ProductState.loading());
    try {
      final value = await _productRepository.getProducts();
      emit(ProductState.success(value));
    } catch (e) {
      addError(e);
      // TODO: Handel error messages
      emit(ProductState.failure(message: '$e'));
    }
  }
}
