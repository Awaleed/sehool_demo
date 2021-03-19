import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/user_datasource.dart';
import '../models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> login(Map<String, dynamic> credentials);

  Future<UserModel> register(FormData credentials);

  Future<UserModel> me();

  Future<void> logout();

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String email, String password);
}

@Singleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final IUserLocalDataSource _localSource;
  final IUserRemoteDataSource _remoteSource;
  AuthRepositoryImpl(this._localSource, this._remoteSource);

  @override
  Future<UserModel> login(Map<String, dynamic> credentials) async {
    final res = await _remoteSource.login(credentials);
    final token = AccessTokenModel(
      expiresIn: res['expires_in'],
      token: res['access_token']['token'],
      tokenType: res['token_type'],
    );

    res['access_token']['user']['original']['wallet'] = double.tryParse('${res['access_token']['user']['original']['wallet']}');

    final user = UserModel.fromJson(
      res['access_token']['user']['original'],
    );
    await _localSource.saveUser(UserWithTokenModel(
      user: user,
      accessToken: token,
    ));

    if (rememberMe) {
      _localSource.saveCredentials({
        'email': credentials['email'],
        'password': credentials['password'],
      });
    } else {
      _localSource.removeCredentials();
    }
    return user;
  }

  @override
  Future<UserModel> register(FormData credentials) async {
    final res = await _remoteSource.register(credentials);
    final token = AccessTokenModel(
      expiresIn: res['expires_in'],
      token: res['access_token']['token'],
      tokenType: res['token_type'],
    );

    res['access_token']['user']['original']['wallet'] = double.tryParse('${res['access_token']['user']['original']['wallet']}');

    final user = UserModel.fromJson(
      res['access_token']['user']['original'],
    );
    await _localSource.saveUser(UserWithTokenModel(
      user: user,
      accessToken: token,
    ));
    if (rememberMe) {
      _localSource.saveCredentials({
        'email': credentials.fields.firstWhere((e) => e.key == 'email').value,
        'password': credentials.fields.firstWhere((e) => e.key == 'password').value,
      });
    } else {
      _localSource.removeCredentials();
    }
    return user;
  }

  @override
  Future<UserModel> me() async {
    final res = await _remoteSource.me();

    res['wallet'] = double.tryParse('${res['wallet']}');
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
  Future<void> forgotPassword(String email) => _remoteSource.forgotPassword({'email': email});

  @override
  Future<void> resetPassword(String email, String password) => _remoteSource.resetPassword({'email': email, 'password': password});
}
