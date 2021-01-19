import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/user_datasource.dart';
import '../models/address_model.dart';
import '../models/form_data_model.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  UserModel getUser();

  Future<List<AddressModel>> getAddresses();
  Future<List<AddressModel>> addAddress(
      Map<FormFieldType, FormFieldModel> data);
  Future<List<AddressModel>> updateAddress(AddressModel model);
  Future<List<AddressModel>> deleteAddress(int id);

  Future<UserModel> updateProfile(Map<FormFieldType, FormFieldModel> data);
  Future<UserModel> changePassword(String password);
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
  Future<List<AddressModel>> addAddress(
      Map<FormFieldType, FormFieldModel> data) async {
    await _remoteSource.addAddress(FormFieldModel.generateJson(data));
    return getAddresses();
  }

  @override
  Future<UserModel> changePassword(String password) {
    throw UnsupportedError('message');
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
  Future<UserModel> updateProfile(
      Map<FormFieldType, FormFieldModel> data) async {
    final res =
        await _remoteSource.updateProfile(FormFieldModel.generateJson(data));
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
    final user = UserModel.fromJson(res);
    await _localSource.updateUser(user);
    return user;
  }
}
