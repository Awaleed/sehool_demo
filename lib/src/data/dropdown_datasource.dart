import 'package:injectable/injectable.dart';
import 'package:sehool/src/models/dropdown_value_model.dart';

import '../core/api_caller.dart';

abstract class IDropdownRemoteDataSource {
  Future<List> getDropdownValues(DropdownValueType type);
}

@Singleton(as: IDropdownRemoteDataSource)
class DropdownRemoteDataSource extends IDropdownRemoteDataSource
    with ApiCaller {
  @override
  Future<List> getDropdownValues(DropdownValueType type) {
    return get(path: '/$type');
  }
}
