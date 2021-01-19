import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/lazy_list_datasource.dart';
import '../models/banner_model.dart';
import '../models/lazy_list_model.dart';
import '../models/product_model.dart';
import '../models/video_model.dart';

abstract class ILazyListRepository {
  Future<List> getLazyListValues({
    LazyListType type,
    ValueNotifier<String> pageUrl,
  });
}

@Singleton(as: ILazyListRepository)
class LazyListRepositoryImpl implements ILazyListRepository {
  final ILazyListRemoteDataSource _lazyListRemoteDataSource;

  LazyListRepositoryImpl(this._lazyListRemoteDataSource);

  @override
  Future<List> getLazyListValues({
    LazyListType type,
    ValueNotifier<String> pageUrl,
  }) async {
    final res =
        await _lazyListRemoteDataSource.getLazyListValues(type, pageUrl);

    final list = ApiCaller.listParser(
      res,
      (data) {
        switch (type) {
          case LazyListType.products:
            data['price'] = double.tryParse('${data['price']}' ?? '');
            data['qyt'] = int.tryParse('${data['qyt']}' ?? '');
            return ProductModel.fromJson(data);
          case LazyListType.videos:
            return VideoModel.fromJson(data);
          case LazyListType.banners:
            data['image'] = data['path'];
            return BannerModel.fromJson(data);
          case LazyListType.reviews:
          case LazyListType.orders:
            return data;
          // return OrderModel.fromJson(data);
          default:
            throw UnsupportedError('Unsupported LazyListType with pram $type');
        }
      },
    );
    return list;
  }
}
