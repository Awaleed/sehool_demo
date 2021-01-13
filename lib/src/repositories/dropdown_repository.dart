import 'package:injectable/injectable.dart';
import 'package:sehool/src/core/api_caller.dart';
import 'package:sehool/src/models/address_model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:sehool/src/models/order_model.dart';
import 'package:sehool/src/models/product_model.dart';
import '../data/dropdown_datasource.dart';
import '../models/dropdown_value_model.dart';

abstract class IDropdownRepository {
  Future<List> getDropdownValues(DropdownValueType type);
}

@Singleton(as: IDropdownRepository)
class DropdownRepositoryImpl implements IDropdownRepository {
  final IDropdownRemoteDataSource _dropdownRemoteDataSource;

  DropdownRepositoryImpl(this._dropdownRemoteDataSource);

  @override
  Future<List> getDropdownValues(DropdownValueType type) async {
    final res = await _dropdownRemoteDataSource.getDropdownValues(
      EnumToString.convertToString(type),
    );
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
          return AddressModel.fromJson(data);
      }
    });
  }
}
