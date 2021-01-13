import 'package:enum_to_string/enum_to_string.dart';
import 'package:faker/faker.dart';
import 'package:injectable/injectable.dart';
import 'package:supercharged/supercharged.dart';

import '../core/api_caller.dart';
import '../helpers/fake_data_generator.dart';
import '../models/dropdown_value_model.dart';

abstract class IDropdownRemoteDataSource {
  Future<List> getDropdownValues(DropdownValueType type);
}

@prod
@Singleton(as: IDropdownRemoteDataSource)
class DropdownRemoteDataSource extends IDropdownRemoteDataSource
    with ApiCaller {
  @override
  Future<List> getDropdownValues(DropdownValueType type) {
    return get(path: () {
      switch (type) {
        case DropdownValueType.slicingMethods:
          return '/slicerTypes';
        case DropdownValueType.cites:
        case DropdownValueType.citySections:
        case DropdownValueType.paymentMethods:
        case DropdownValueType.addresses:
          return '/addresses';
        default:
          throw UnsupportedError('message');
      }
    }());
  }
}

@test
@Singleton(as: IDropdownRemoteDataSource)
class FakeDropdownRemoteDataSource extends IDropdownRemoteDataSource {
  @override
  Future<List> getDropdownValues(DropdownValueType type) async {
    await Future.delayed(random.integer(1000).milliseconds);
    switch (type) {
      case DropdownValueType.cites:
        return List.generate(
          10,
          (_) => FakeDataGenerator.cityModel.toJson(),
        );
      case DropdownValueType.citySections:
        return List.generate(
          10,
          (_) => FakeDataGenerator.citySectionModel.toJson(),
        );
      case DropdownValueType.slicingMethods:
        return List.generate(
          10,
          (_) => FakeDataGenerator.slicingMethodsModel.toJson(),
        );
      case DropdownValueType.paymentMethods:
        return List.generate(
          10,
          (_) => FakeDataGenerator.paymentMethodsModel.toJson(),
        );
      case DropdownValueType.addresses:
        return List.generate(
          10,
          (_) => FakeDataGenerator.addressModel.toJson(),
        );
      default:
        throw UnsupportedError('message');
    }
  }
}
