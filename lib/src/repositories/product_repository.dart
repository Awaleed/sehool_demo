import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/product_datasource.dart';
import '../models/banner_model.dart';
import '../models/product_model.dart';
import '../models/video_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<List<ReviewModel>> addReview(
      {int productId, int rating, String review});
  Future<List<ReviewModel>> getReviews(int productId);

  Future<List<VideoModel>> getVideos();
  Future<List<BannerModel>> getBanners();
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
    return getReviews(productId);
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final res = await _productRemoteDataSource.getProducts();
    return ApiCaller.listParser(res, (data) {
      data['price'] = double.tryParse('${data['price']}' ?? '');
      data['qyt'] = int.tryParse('${data['qyt']}' ?? '');
      return ProductModel.fromJson(data);
    });
  }

  @override
  Future<List<ReviewModel>> getReviews(int productId) async {
    final res = await _productRemoteDataSource.getReviews(
      {'product_id': productId},
    );
    return ApiCaller.listParser(res, (data) {
      data['rating'] = double.tryParse('${data['rating']}' ?? '');
      if (data['user'] != null) {
        data['user']['level'] = 'customer';
        data['user']['wallet'] =
            double.tryParse('${data['user']['wallet']}' ?? '');
        data['user']['vat_number'] = '${data['user']['vat_number']}';
      }

      return ReviewModel.fromJson(data);
    });
  }

  @override
  Future<List<VideoModel>> getVideos() async {
    final res = await _productRemoteDataSource.getVideos();
    return ApiCaller.listParser(res, (data) {
      data['preview'] = data['image'];
      data['video'] = data['path'];
      return VideoModel.fromJson(data);
    });
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    final res = await _productRemoteDataSource.getBanners();
    return ApiCaller.listParser(res, (data) {
      data['image'] = data['path'];
      return BannerModel.fromJson(data);
    });
  }
}
