import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:supercharged/supercharged.dart';

import '../core/api_caller.dart';
import '../helpers/fake_data_generator.dart';
import '../models/lazy_list_model.dart';

abstract class ILazyListRemoteDataSource {
  Future<List> getLazyListValues(
    LazyListType type,
    ValueNotifier<String> pageUrl,
  );
}

@prod
@Singleton(as: ILazyListRemoteDataSource)
class LazyListRemoteDataSource extends ILazyListRemoteDataSource
    with ApiCaller {
  @override
  Future<List> getLazyListValues(
    LazyListType type,
    ValueNotifier<String> pageUrl,
  ) async {
    return get<List>(
      path: pageUrl.value ??
          () {
            switch (type) {
              case LazyListType.products:
                return '/products';
              case LazyListType.videos:
                return '/videos';
              case LazyListType.banners:
                return '/carousel';
              case LazyListType.reviews:
              case LazyListType.orders:
              default:
                throw UnsupportedError(
                  'Unsupported LazyListType with pram $type',
                );
            }
          }(),
    );
  }
}

@test
@Singleton(as: ILazyListRemoteDataSource)
class FakeLazyListRemoteDataSource extends ILazyListRemoteDataSource {
  @override
  Future<List> getLazyListValues(
    LazyListType type,
    ValueNotifier<String> pageUrl,
  ) async {
    await Future.delayed(random.integer(1000).milliseconds);
    switch (type) {
      case LazyListType.products:
        return FakeDataGenerator.products.map((e) => e.toJson()).toList();
      case LazyListType.videos:
        return List.generate(
          10,
          (_) => FakeDataGenerator.videoModel.toJson(),
        );
      case LazyListType.banners:
        return List.generate(
          10,
              (_) => FakeDataGenerator.bannerModel.toJson(),
        );
      case LazyListType.orders:
      // return List.generate(
      //   10,
      //   (_) => FakeDataGenerator.orderModel,
      // );
      case LazyListType.reviews:
      default:
        throw UnsupportedError(
          'Unsupported LazyListType with pram $type',
        );
    }
  }
}
