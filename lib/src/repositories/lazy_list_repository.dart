import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/lazy_list_datasource.dart';
import '../models/lazy_list_model.dart';
import '../models/product_model.dart';

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
    // TODO: Map LazyListType to url
    final res = await _lazyListRemoteDataSource.getLazyListValues(
      type,
      pageUrl,
    );

    final list = ApiCaller.listParser(
      res,
      (data) {
        switch (type) {
          case LazyListType.products:
            data['price'] = double.tryParse(data['price'] ?? '0') ?? 0;
            data['qyt'] = int.tryParse(data['qyt'] ?? '0') ?? 0;
            return ProductModel.fromJson(data);
          case LazyListType.videos:
          case LazyListType.reviews:
          case LazyListType.orders:
          default:
            throw UnsupportedError('Unsupported LazyListType with pram $type');
        }
      },
    );
    return list;
  }
}
