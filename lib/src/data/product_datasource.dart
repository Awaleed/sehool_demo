import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';

abstract class IProductRemoteDataSource {
  Future<List> getProducts();
  Future<Map<String, dynamic>> addReview(Map<String, dynamic> data);
  Future<List> getReviews(Map<String, int> data);

  Future<List> getVideos();
  Future<List> getBanners();
}

@prod
@Singleton(as: IProductRemoteDataSource)
class ProductRemoteDataSource extends IProductRemoteDataSource with ApiCaller {
  @override
  Future<List> getProducts() => get(path: '/products');

  @override
  Future<Map<String, dynamic>> addReview(Map<String, dynamic> data) => post(path: '/reviews', data: data);

  @override
  Future<List> getReviews(Map<String, dynamic> data) => get(path: '/reviews', data: data);

  @override
  Future<List> getVideos() => get(path: '/videos');

  @override
  Future<List> getBanners() => get(path: '/carousel');
}
