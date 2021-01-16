import 'package:faker/faker.dart';
import 'package:injectable/injectable.dart';
import 'package:supercharged/supercharged.dart';

import '../core/api_caller.dart';
import '../helpers/fake_data_generator.dart';

abstract class IProductRemoteDataSource {
  Future<Map<String, dynamic>> getProduct(int id);
  Future<Map<String, dynamic>> addReview(Map<String, dynamic> data);

  Future<List> getReviews(Map<String, int> data);
}

@prod
@Singleton(as: IProductRemoteDataSource)
class ProductRemoteDataSource extends IProductRemoteDataSource with ApiCaller {
  @override
  Future<Map<String, dynamic>> getProduct(int id) {
    return get(
      path: '/products/$id',
    );
  }

  @override
  Future<Map<String, dynamic>> addReview(Map<String, dynamic> data) {
    return post(
      path: '/reviews',
      data: data,
    );
  }

  @override
  Future<List> getReviews(Map<String, dynamic> data) =>
      get(path: '/reviews', data: data);
}

@test
@Singleton(as: IProductRemoteDataSource)
class FakeProductRemoteDataSource extends IProductRemoteDataSource {
  @override
  Future<Map<String, dynamic>> addReview(Map<String, dynamic> data) async {
    await Future.delayed(random.integer(1000).milliseconds);
    return {'message': 'success'};
  }

  @override
  Future<List> getReviews(Map<String, dynamic> data) async {
    await Future.delayed(random.integer(1000).milliseconds);
    return FakeDataGenerator.reviews.map((e) => e.toJson()).toList();
  }

  @override
  Future<Map<String, dynamic>> getProduct(int id) => throw UnimplementedError();
}
