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

@Singleton(as: ILazyListRemoteDataSource)
class LazyListRemoteDataSource extends ILazyListRemoteDataSource
    with ApiCaller {
  @override
  Future<List> getLazyListValues(
    LazyListType type,
    ValueNotifier<String> pageUrl,
  ) async {
    return get<List>(path: pageUrl.value);
  }
}
