import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../models/user_model.dart';

const String userBoxName = 'UserBox';
const String currentUserKey = 'currentUser';

abstract class IUserLocalDataSource {
  Future<void> saveUser(UserWithTokenModel user);
  Future<void> updateUser(UserModel user);
  Future<void> removeUser();
  String readAuthToken();
  UserModel readUser();
}

@Singleton(as: IUserLocalDataSource)
class UserLocalDataSource extends IUserLocalDataSource {
  UserLocalDataSource() : box = Hive.box(userBoxName);

  final Box box;

  @override
  UserModel readUser() {
    final userEncodedJson = box.get(currentUserKey);
    final user = UserWithTokenModel.fromJson(jsonDecode(userEncodedJson));
    return user.user;
  }

  @override
  Future<void> saveUser(UserWithTokenModel user) async {
    final userEncodedJson = jsonEncode(user.toJson());
    await box.put(currentUserKey, userEncodedJson);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final _user =
        UserWithTokenModel.fromJson(jsonDecode(box.get(currentUserKey)));
    _user.copyWith(user: user);
    final userEncodedJson = jsonEncode(_user.toJson());
    await box.put(currentUserKey, userEncodedJson);
  }

  @override
  Future<void> removeUser() {
    return box.delete(currentUserKey);
  }

  @override
  String readAuthToken() {
    final userEncodedJson = box.get(currentUserKey);
    if (userEncodedJson == null) return null;
    final user = UserWithTokenModel.fromJson(jsonDecode(userEncodedJson));
    return user.accessToken.token.trim();
  }
}

abstract class IUserRemoteDataSource {
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials);
  Future<Map<String, dynamic>> logout();
  Future<Map<String, dynamic>> me();
  Future<Map<String, dynamic>> register(Map<String, dynamic> credentials);

  Future<Map<String, dynamic>> forgotPassword(Map<String, dynamic> credentials);
  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> credentials);

  Future<Map<String, dynamic>> addAddress(Map<String, dynamic> data);
  Future<Map<String, dynamic>> deleteAddress(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateAddress(Map<String, dynamic> data);

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data);

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateProfileImage(Map<String, dynamic> data);
}

@Singleton(as: IUserRemoteDataSource)
class UserRemoteDataSource extends IUserRemoteDataSource with ApiCaller {
  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) {
    return post(
      path: '/auth/login',
      data: credentials,
    );
  }

  @override
  Future<Map<String, dynamic>> logout() {
    return post(
      path: '/auth/logout',
    );
  }

  @override
  Future<Map<String, dynamic>> me() {
    return post(
      path: '/auth/me',
      data: {'user_id': userId},
    );
  }

  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> credentials) {
    return post(
      path: '/auth/register',
      data: credentials,
    );
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(
    Map<String, dynamic> credentials,
  ) {
    return post(
      path: '/auth/forgot_password',
      data: credentials,
    );
  }

  @override
  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> credentials) {
    return post(
      path: '/auth/reset_password',
      data: credentials,
    );
  }

  @override
  Future<Map<String, dynamic>> addAddress(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> deleteAddress(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> updateAddress(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> updateProfileImage(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }
}
