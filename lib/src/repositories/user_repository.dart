import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sehool/src/core/api_caller.dart';
import 'package:sehool/src/models/address_model.dart';
import 'package:sehool/src/models/form_data_model.dart';

import '../data/user_datasource.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  UserModel getUser();

  Future<List<AddressModel>> getAddresses();
  Future<List<AddressModel>> addAddress(AddressModel model);
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
      (data) => AddressModel.fromJson(data),
    );
    return list;
  }

  @override
  Future<List<AddressModel>> addAddress(AddressModel model) async {
    final res = await _remoteSource.getAddresses();
    final list = ApiCaller.listParser(
      res,
      (data) => AddressModel.fromJson(data),
    );
    return list;
  }

  @override
  Future<UserModel> changePassword(String password) {
    _remoteSource.changePassword({'password': ''});
  }

  @override
  Future<List<AddressModel>> deleteAddress(int id) async {
    final res = await _remoteSource.getAddresses();
    final list = ApiCaller.listParser(
      res,
      (data) => AddressModel.fromJson(data),
    );
    return list;
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
    final res = await _remoteSource.updateProfile(FormFieldModel.generateJson(data));
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
