import 'package:injectable/injectable.dart';
import 'package:sehool/src/models/address_model.dart';

import '../data/user_datasource.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  UserModel getUser();

  Future<AddressModel> addAddress(AddressModel model);
  Future<AddressModel> updateAddress(AddressModel model);
  Future<AddressModel> deleteAddress(int id);

  Future<UserModel> updateProfile(UserModel model);
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
  Future<AddressModel> addAddress(AddressModel model) {
    _remoteSource.addAddress({'model': ''});
  }

  @override
  Future<UserModel> changePassword(String password) {
    _remoteSource.changePassword({'password': ''});
  }

  @override
  Future<AddressModel> deleteAddress(int id) {
    _remoteSource.deleteAddress({'id': ''});
  }

  @override
  Future<AddressModel> updateAddress(AddressModel model) {
    _remoteSource.updateAddress({'model': ''});
  }

  @override
  Future<UserModel> updateProfile(UserModel model) {
    _remoteSource.updateProfile({'model': ''});
  }

  @override
  Future<UserModel> updateProfileImage(String imagePath) {
    _remoteSource.updateProfileImage({'imagePath': ''});
  }
}
