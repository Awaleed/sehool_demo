import 'package:injectable/injectable.dart';

import '../data/dropdown_datasource.dart';
import '../models/dropdown_value_model.dart';

abstract class IDropdownRepository {
  Future<List<DropdownValueModel>> getDropdownValues(DropdownValueType type);
}

@Singleton(as: IDropdownRepository)
class DropdownRepositoryImpl implements IDropdownRepository {
  final IDropdownRemoteDataSource _dropdownRemoteDataSource;

  DropdownRepositoryImpl(this._dropdownRemoteDataSource);

  @override
  Future<List<DropdownValueModel>> getDropdownValues(DropdownValueType type) {
    // TODO: Map DropdownValueType to url
    _dropdownRemoteDataSource.getDropdownValues(type);
  }
}
