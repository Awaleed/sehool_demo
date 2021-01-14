import 'package:enum_to_string/enum_to_string.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/dropdown_datasource.dart';
import '../models/address_model.dart';
import '../models/dropdown_value_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

abstract class IDropdownRepository {
  Future<List> getDropdownValues(DropdownValueType type);
}

@Singleton(as: IDropdownRepository)
class DropdownRepositoryImpl implements IDropdownRepository {
  final IDropdownRemoteDataSource _dropdownRemoteDataSource;

  DropdownRepositoryImpl(this._dropdownRemoteDataSource);

  @override
  Future<List> getDropdownValues(DropdownValueType type) async {
    if (type == DropdownValueType.pickupMethod) {
      return PickupMethod.values;
    } else if (type == DropdownValueType.orderType) {
      return OrderType.values;
    }
    final res = await _dropdownRemoteDataSource.getDropdownValues(type);
    return ApiCaller.listParser(res, (data) {
      switch (type) {
        case DropdownValueType.cites:
          return CityModel.fromJson(data);
        case DropdownValueType.citySections:
          return CitySectionModel.fromJson(data);
        case DropdownValueType.slicingMethods:
          return SlicingMethodModel.fromJson(data);
        case DropdownValueType.paymentMethods:
          return EnumToString.fromString(PaymentMethodType.values, '$data');
        case DropdownValueType.addresses:
          data['lang'] = double.tryParse(data['lang'] ?? '0') ?? 0;
          data['lat'] = double.tryParse(data['lat'] ?? '0') ?? 0;
          data['note'] = data['description'];
          data['address'] = data['description'];

          return AddressModel.fromJson(data);
        case DropdownValueType.pickupMethod:
        case DropdownValueType.orderType:
        default:
          throw UnsupportedError('message');
      }
    });
  }
}
