import 'package:injectable/injectable.dart';
import 'package:sehool/src/core/api_caller.dart';

import '../data/product_datasource.dart';
import '../models/product_model.dart';

abstract class IProductRepository {
  Future<ProductModel> getProduct(int id);
  Future<ReviewModel> addReview({
    int productId,
    int rating,
    String review,
  });

  Future<List<ReviewModel>> getReviews({int productId});
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

  @override
  Future<List<ReviewModel>> getReviews({int productId}) async {
    final res = await _productRemoteDataSource.getReviews(
      {'product_id': productId},
    );

    return ApiCaller.listParser(res, (data) {
      data['rating'] = int.tryParse(data['rating'] ?? '0') ?? 0;

      return ReviewModel.fromJson(data);
    });
  }
}
