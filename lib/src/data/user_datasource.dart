import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supercharged/supercharged.dart';

import '../../init_injectable.dart';
import '../core/api_caller.dart';
import '../models/user_model.dart';

const String userBoxName = 'UserBox';
const String currentUserKey = 'currentUser';
const String rememberedUserKey = 'rememberedUserKey';
bool rememberMe = true;
UserModel get kUser => getIt<IUserLocalDataSource>().readUser();

abstract class IUserLocalDataSource {
  Future<void> saveUser(UserWithTokenModel user);
  Future<void> updateUser(UserModel user);
  Future<void> removeUser();
  String readAuthToken();
  UserModel readUser();

  Future<void> saveCredentials(Map<String, dynamic> credentials);
  Map<String, dynamic> readCredentials();
  Future<void> removeCredentials();
}

@Singleton(as: IUserLocalDataSource)
class UserLocalDataSource extends IUserLocalDataSource {
  UserLocalDataSource() : box = Hive.box(userBoxName);

  final Box box;

  @override
  UserModel readUser() {
    final userEncodedJson = box.get(currentUserKey);
    if (userEncodedJson == null) return null;
    final user = UserWithTokenModel.fromJson(jsonDecode(userEncodedJson));
    return user.user;
  }

  @override
  Future<void> saveUser(UserWithTokenModel user) async {
    try {
      await OneSignal.shared.setExternalUserId(
        user.user.id.toString(),
      );
    } catch (e) {}
    final userEncodedJson = jsonEncode(user.toJson());
    await box.put(currentUserKey, userEncodedJson);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final _user = UserWithTokenModel.fromJson(jsonDecode(box.get(currentUserKey)));
    final userEncodedJson = jsonEncode(_user.copyWith(user: user).toJson());
    await box.put(currentUserKey, userEncodedJson);
  }

  @override
  Future<void> removeUser() async {
    try {
      OneSignal.shared.removeExternalUserId();
    } catch (e) {}
    return box.delete(currentUserKey);
  }

  @override
  String readAuthToken() {
    final userEncodedJson = box.get(currentUserKey);
    if (userEncodedJson == null) return null;
    final user = UserWithTokenModel.fromJson(jsonDecode(userEncodedJson));
    return user.accessToken.token.trim();
  }

  @override
  Map<String, dynamic> readCredentials() {
    try {
      final String credentialsEncodedJson = box.get(rememberedUserKey);
      if (credentialsEncodedJson == null) return null;
      final credentials = jsonDecode(credentialsEncodedJson);
      return credentials;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveCredentials(Map<String, dynamic> credentials) async {
    final credentialsEncodedJson = jsonEncode(credentials);
    await box.put(rememberedUserKey, credentialsEncodedJson);
  }

  @override
  Future<void> removeCredentials() async {
    return box.delete(rememberedUserKey);
  }
}

abstract class IUserRemoteDataSource {
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials);
  Future<Map<String, dynamic>> logout();
  Future<Map<String, dynamic>> me();
  Future<Map<String, dynamic>> register(FormData credentials);

  Future<Map<String, dynamic>> forgotPassword(Map<String, dynamic> credentials);
  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> credentials);

  Future<List> getAddresses();
  Future addAddress(Map<String, dynamic> data);
  Future deleteAddress(int id);
  Future updateAddress(Map<String, dynamic> data);

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data);

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateProfileImage(FormData data);
}

@prod
@Singleton(as: IUserRemoteDataSource)
class UserRemoteDataSource extends IUserRemoteDataSource with ApiCaller {
  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) => post(path: '/auth/login', data: credentials);

  @override
  Future<Map<String, dynamic>> logout() {
    return post(
      path: '/auth/logout',
    );
  }

  @override
  Future<Map<String, dynamic>> me() => post(path: '/auth/me');

  @override
  Future<Map<String, dynamic>> register(FormData credentials) => post(path: '/auth/registration', data: credentials);

  @override
  Future<Map<String, dynamic>> forgotPassword(
    Map<String, dynamic> credentials,
  ) async =>
      post(path: '/auth/ForgotPassword', data: credentials);

  @override
  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> credentials) async {
    await Future.delayed(1500.milliseconds);
    return {'time_out': 5};
  }

  @override
  Future<List> getAddresses() {
    return get(path: '/addresses');
  }

  @override
  Future addAddress(Map<String, dynamic> data) {
    return post(path: '/addresses', data: data);
  }

  @override
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) {
    return post(path: '/auth/login', data: data);
  }

  @override
  Future deleteAddress(int id) {
    return delete(path: '/addresses/$id');
  }

  @override
  Future updateAddress(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) {
    return post(
      path: '/auth/ProfileEdit',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> updateProfileImage(FormData data) => post(path: '/auth/updateProfilePhoto', data: data);
}
