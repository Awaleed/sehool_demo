import 'package:injectable/injectable.dart';

import '../data/product_datasource.dart';
import '../models/product_model.dart';

abstract class IProductRepository {
  Future<ProductModel> getProduct(int id);
  Future<ReviewModel> addReview({
    int productId,
    int rating,
    String review,
  });
}

@Singleton(as: IProductRepository)
class ProductRepositoryImpl implements IProductRepository {
  final IProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl(this._productRemoteDataSource);

  @override
  Future<ReviewModel> addReview({int productId, int rating, String review}) {
    _productRemoteDataSource.addReview(productId, {'data': ''});
  }

  @override
  Future<ProductModel> getProduct(int id) {
    _productRemoteDataSource.getProduct(id);
  }
}
