import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sehool/init_injectable.dart';
import 'package:sehool/src/helpers/fake_data_generator.dart';

import '../core/api_caller.dart';
import '../models/user_model.dart';
import 'package:supercharged/supercharged.dart';

const String userBoxName = 'UserBox';
const String currentUserKey = 'currentUser';
UserModel get kUser => getIt<IUserLocalDataSource>().readUser();

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
    final userEncodedJson = jsonEncode(_user.copyWith(user: user).toJson());
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

  Future<List> getAddresses();
  Future<List> addAddress(Map<String, dynamic> data);
  Future<List> deleteAddress(Map<String, dynamic> data);
  Future<List> updateAddress(Map<String, dynamic> data);

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data);

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateProfileImage(FormData data);
}

@prod
@Singleton(as: IUserRemoteDataSource)
class UserRemoteDataSource extends IUserRemoteDataSource with ApiCaller {
  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) =>
      post(path: '/auth/login', data: credentials);

  @override
  Future<Map<String, dynamic>> logout() {
    return post(
      path: '/auth/logout',
    );
  }

  @override
  Future<Map<String, dynamic>> me() => post(path: '/auth/me');

  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> credentials) =>
      post(path: '/auth/registration', data: credentials);

  @override
  Future<Map<String, dynamic>> forgotPassword(
    Map<String, dynamic> credentials,
  ) async {
    //TODO FIXME
    await Future.delayed(200.milliseconds);
    return {'time_out': 5};
  }

  @override
  Future<Map<String, dynamic>> resetPassword(
      Map<String, dynamic> credentials) async {
    //TODO FIXME
    await Future.delayed(200.milliseconds);
    if (random.boolean()) throw DioError(response: Response(statusCode: 400));
    return {'time_out': 5};
  }

  @override
  Future<List> getAddresses() {
    return get(path: '/auth/login');
  }

  @override
  Future<List> addAddress(Map<String, dynamic> data) {
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
  Future<List> deleteAddress(Map<String, dynamic> data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }

  @override
  Future<List> updateAddress(Map<String, dynamic> data) {
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
  Future<Map<String, dynamic>> updateProfileImage(FormData data) {
    return post(
      path: '/auth/login',
      data: data,
    );
  }
}

@test
@Singleton(as: IUserRemoteDataSource)
class FakeUserRemoteDataSource extends IUserRemoteDataSource {
  @override
  Future<List> getAddresses() async {
    await Future.delayed(random.integer(1000).milliseconds);
    return List.generate(
      10,
      (_) => FakeDataGenerator.addressModel.toJson(),
    );
  }

  @override
  Future<List> addAddress(Map<String, dynamic> data) async {
    await Future.delayed(random.integer(1000).milliseconds);
    return List.generate(
      10,
      (_) => FakeDataGenerator.addressModel.toJson(),
    );
  }

  @override
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<List> deleteAddress(Map<String, dynamic> data) async {
    await Future.delayed(random.integer(1000).milliseconds);
    return List.generate(
      10,
      (_) => FakeDataGenerator.addressModel.toJson(),
    );
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(
      Map<String, dynamic> credentials) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) async {
    await Future.delayed(random.integer(1000).milliseconds);
    return FakeDataGenerator.userWithTokenModel.toJson();
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    await Future.delayed(random.integer(1000).milliseconds);
    return {'message': 'success'};
  }

  @override
  Future<Map<String, dynamic>> me() async {
    await Future.delayed(random.integer(1000).milliseconds);
    return FakeDataGenerator.userModel.toJson();
  }

  @override
  Future<Map<String, dynamic>> register(
      Map<String, dynamic> credentials) async {
    await Future.delayed(random.integer(1000).milliseconds);
    return FakeDataGenerator.userWithTokenModel.toJson();
  }

  @override
  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> credentials) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<List> updateAddress(Map<String, dynamic> data) {
    // TODO: implement updateAddress
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    await Future.delayed(random.integer(1000).milliseconds);
    return data;
  }

  @override
  Future<Map<String, dynamic>> updateProfileImage(FormData data) {
    // TODO: implement updateProfileImage
    throw UnimplementedError();
  }
}
