import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../models/lazy_list_model.dart';

abstract class ILazyListRemoteDataSource {
  Future<List> getLazyListValues(
    LazyListType type,
    ValueNotifier<String> pageUrl,
  );
}

@prod
@Singleton(as: ILazyListRemoteDataSource)
class LazyListRemoteDataSource extends ILazyListRemoteDataSource with ApiCaller {
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
