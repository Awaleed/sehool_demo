import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../models/dropdown_value_model.dart';

abstract class IDropdownRemoteDataSource {
  Future<List> getDropdownValues(DropdownValueType type);
}

@prod
@Singleton(as: IDropdownRemoteDataSource)
class DropdownRemoteDataSource extends IDropdownRemoteDataSource with ApiCaller {
  @override
  Future<List> getDropdownValues(DropdownValueType type) {
    return get(path: () {
      switch (type) {
        case DropdownValueType.slicingMethods:
          return '/slicerTypes';
        case DropdownValueType.cites:
        case DropdownValueType.citySections:
          return '/cities';
        case DropdownValueType.paymentMethods:
          return '/paymentMethod';
        case DropdownValueType.addresses:
          return '/addresses';
        default:
          throw UnsupportedError('message');
      }
    }());
  }
}
