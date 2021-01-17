import 'package:injectable/injectable.dart';

import '../data/user_datasource.dart';
import '../models/form_data_model.dart';
import '../models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> login(Map<FormFieldType, FormFieldModel> credentials);
  Future<UserModel> register(Map<FormFieldType, FormFieldModel> credentials);
  Future<UserModel> me();
  Future<void> logout();

  Future<int> forgotPassword(String email);
  Future<void> resetPassword(String email, String password);
}

@Singleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final IUserLocalDataSource _localSource;
  final IUserRemoteDataSource _remoteSource;
  AuthRepositoryImpl(this._localSource, this._remoteSource);

  @override
  Future<UserModel> login(
      Map<FormFieldType, FormFieldModel> credentials) async {
    final res = await _remoteSource.login(
      FormFieldModel.generateJson(credentials),
    );
     final token = AccessTokenModel(
       expiresIn: res['expires_in'],
       token: res['access_token']['token'],
       tokenType: res['token_type'],
     );

     final user = UserModel.fromJson(
       res['access_token']['user']['original'],
     );
     await _localSource.saveUser(UserWithTokenModel(
       user: user,
       accessToken: token,
     ));

   // final user = UserWithTokenModel.fromJson(res);

   // await _localSource.saveUser(user);

    return user;
  }

  @override
  Future<UserModel> register(
      Map<FormFieldType, FormFieldModel> credentials) async {
    final res = await _remoteSource.register(
      FormFieldModel.generateJson(credentials),
    );
    final token = AccessTokenModel(
      expiresIn: res['expires_in'],
      token: res['access_token']['token'],
      tokenType: res['token_type'],
    );

    final user = UserModel.fromJson(
      res['access_token']['user']['original'],
    );
    await _localSource.saveUser(UserWithTokenModel(
      user: user,
      accessToken: token,
    ));
    return user;
  }

  @override
  Future<UserModel> me() async {
    final res = await _remoteSource.me();
    final user = UserModel.fromJson(res);
    await _localSource.updateUser(user);
    return user;
  }

  @override
  Future<void> logout() async {
    _remoteSource.logout();
    await _localSource.removeUser();
  }

  @override
  Future<int> forgotPassword(String email) async {
    final res = await _remoteSource.forgotPassword({'email': email});
    return res['time_out'];
  }

  @override
  Future<void> resetPassword(String email, String password) =>
      _remoteSource.resetPassword({'email': email, 'password': password});
}
