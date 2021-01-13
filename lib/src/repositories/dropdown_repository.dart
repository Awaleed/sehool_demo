import 'package:enum_to_string/enum_to_string.dart';
import 'package:faker/faker.dart';
import 'package:injectable/injectable.dart';
import 'package:sehool/src/helpers/fake_data_generator.dart';

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
      return [
        PickupMethodModel(id: 0, name: 'من المعرض'),
        PickupMethodModel(id: 0, name: 'توصيل'),
      ];
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
          return PaymentMethodModel.fromJson(data);
        case DropdownValueType.addresses:
          data['lang'] = double.tryParse(data['lang'] ?? '0') ?? 0;
          data['lat'] = double.tryParse(data['lat'] ?? '0') ?? 0;
          data['note'] = data['description'];
          data['address'] = data['description'];

          return AddressModel.fromJson(data);
        // return FakeDataGenerator.addressModel;
      }
    });
  }
}
