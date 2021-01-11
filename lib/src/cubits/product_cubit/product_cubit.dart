import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';

part 'product_cubit.freezed.dart';
part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(const ProductState.initial());

  final IProductRepository _productRepository;

  Future<void> getProduct(int id) async {
    emit(const ProductState.loading());
    try {
      final value = await _productRepository.getProduct(id);
      emit(ProductState.success(value));
    } catch (e) {
      // TODO: Handel error messages
      emit(ProductState.failure(message: '$e'));
    }
  }
}
