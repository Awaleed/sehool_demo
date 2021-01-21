import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/user_datasource.dart';
import '../models/address_model.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  UserModel getUser();

  Future<List<AddressModel>> getAddresses();

  Future<List<AddressModel>> addAddress(Map<String, dynamic> data);

  Future<List<AddressModel>> updateAddress(AddressModel model);
  Future<List<AddressModel>> deleteAddress(int id);

  Future<UserModel> updateProfile(Map<String, dynamic> data);

  Future<UserModel> updateProfileImage(String imagePath);
}

@Singleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserLocalDataSource _localSource;
  final IUserRemoteDataSource _remoteSource;

  UserRepositoryImpl(this._localSource, this._remoteSource);

  @override
  UserModel getUser() => _localSource.readUser();

  @override
  Future<List<AddressModel>> getAddresses() async {
    final res = await _remoteSource.getAddresses();
    final list = ApiCaller.listParser(
      res,
      (data) {
        data['lang'] = double.tryParse('${data['lang']}' ?? '');
        data['lat'] = double.tryParse('${data['lat']}' ?? '');
        return AddressModel.fromJson(data);
      },
    );
    return list;
  }

  @override
  Future<List<AddressModel>> addAddress(Map<String, dynamic> data) async {
    await _remoteSource.addAddress(data);
    return getAddresses();
  }

  @override
  Future<List<AddressModel>> deleteAddress(int id) async {
    await _remoteSource.deleteAddress(id);
    return getAddresses();
  }

  @override
  Future<List<AddressModel>> updateAddress(AddressModel model) async {
    final res = await _remoteSource.getAddresses();
    final list = ApiCaller.listParser(
      res,
      (data) => AddressModel.fromJson(data),
    );
    return list;
  }

  @override
  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final res = await _remoteSource.updateProfile(data);
    res['wallet'] = double.tryParse('${res['wallet']}');
    res['vat_number'] = '${res['vat_number']}';

    final user = UserModel.fromJson(res);
    await _localSource.updateUser(user);
    return user;
  }

  @override
  Future<UserModel> updateProfileImage(String imagePath) async {
    final data = FormData.fromMap({
      'photo': await MultipartFile.fromFile(imagePath),
    });
    final res = await _remoteSource.updateProfileImage(data);
    res['wallet'] = double.tryParse('${res['wallet']}');
    res['vat_number'] = '${res['vat_number']}';

    final user = UserModel.fromJson(res);
    await _localSource.updateUser(user);
    return user;
  }
}
