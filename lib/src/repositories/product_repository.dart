import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/product_datasource.dart';
import '../models/product_model.dart';

abstract class IProductRepository {
  Future<ProductModel> getProduct(int id);
  Future<List<ReviewModel>> addReview({
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
  Future<List<ReviewModel>> addReview(
      {int productId, int rating, String review}) async {
    await _productRemoteDataSource.addReview(
      {
        'product_id': productId,
        'rating': rating,
        'comment': review,
      },
    );
    return getReviews(productId: productId);
  }

  @override
  Future<ProductModel> getProduct(int id) {
    throw UnsupportedError('message');
  }

  @override
  Future<List<ReviewModel>> getReviews({int productId}) async {
    final res = await _productRemoteDataSource.getReviews(
      {'product_id': productId},
    );

    return ApiCaller.listParser(res, (data) {
      return ReviewModel.fromJson(data);
    });
  }
}
