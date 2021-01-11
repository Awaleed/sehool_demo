import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../data/lazy_list_datasource.dart';
import '../models/lazy_list_model.dart';

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
  }) {
    // TODO: Map LazyListType to url
    _lazyListRemoteDataSource.getLazyListValues(type, pageUrl);
  }
}
