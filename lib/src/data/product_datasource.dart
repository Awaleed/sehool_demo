import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';

abstract class IProductRemoteDataSource {
  Future<Map<String, dynamic>> getProduct(int id);
  Future<Map<String, dynamic>> addReview(int id, Map<String, dynamic> data);
}

@Singleton(as: IProductRemoteDataSource)
class ProductRemoteDataSource extends IProductRemoteDataSource with ApiCaller {
  @override
  Future<Map<String, dynamic>> getProduct(int id) {
    return get(
      path: '/products/$id',
    );
  }

  @override
  Future<Map<String, dynamic>> addReview(int id, Map<String, dynamic> data) {
    return post(
      path: '/products/$id/reviews/new',
      data: data,
    );
  }
}
