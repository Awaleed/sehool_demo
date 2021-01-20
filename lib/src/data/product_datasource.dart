import 'package:faker/faker.dart';
import 'package:injectable/injectable.dart';
import 'package:supercharged/supercharged.dart';

import '../core/api_caller.dart';
import '../helpers/fake_data_generator.dart';

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
  Future<Map<String, dynamic>> addReview(Map<String, dynamic> data) =>
      post(path: '/reviews', data: data);

  @override
  Future<List> getReviews(Map<String, dynamic> data) =>
      get(path: '/reviews', data: data);

  @override
  Future<List> getVideos() => get(path: '/videos');

  @override
  Future<List> getBanners() => get(path: '/carousel');
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
  Future<List> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<List> getVideos() {
    // TODO: implement getVideos
    throw UnimplementedError();
  }

  @override
  Future<List> getBanners() {
    // TODO: implement getBanners
    throw UnimplementedError();
  }
}
