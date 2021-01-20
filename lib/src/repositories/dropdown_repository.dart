import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/dropdown_datasource.dart';
import '../helpers/fake_data_generator.dart';
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
    final res = await _dropdownRemoteDataSource.getDropdownValues(type);
    return ApiCaller.listParser(res, (data) {
      switch (type) {
        case DropdownValueType.cites:
          return CityModel.fromJson(data);
        case DropdownValueType.citySections:
          return FakeDataGenerator.citySectionModel;
          return CitySectionModel.fromJson(data);
        case DropdownValueType.slicingMethods:
          return SlicingMethodModel.fromJson(data);
        case DropdownValueType.paymentMethods:
          return PaymentMethodModel.fromJson(data);
        case DropdownValueType.addresses:
          data['lang'] = double.tryParse('${data['lang']}' ?? '');
          data['lat'] = double.tryParse('${data['lat']}' ?? '');
          return AddressModel.fromJson(data);
        default:
          throw UnsupportedError('message');
      }
    });
  }
}
