import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../init_injectable.dart';
import '../data/user_datasource.dart';

mixin ApiCaller {
  static final box = Hive.box(userBoxName)
    ..listenable().addListener(() {
      _userId = getIt<IUserLocalDataSource>().readUser().id;
      _configureDioClient();
    });

  static const _baseUrl = 'http://192.168.9.104:8000/api';
  static Dio _dio;
  static final PrettyDioLogger _logger = PrettyDioLogger(
    responseBody: false,
    requestHeader: true,
    requestBody: true,
  );

  Dio get dio => _dio;

  static int _userId = getIt<IUserLocalDataSource>().readUser().id;

  int get userId => _userId;

  Future<T> get<T>({
    @required String path,
    dynamic data,
  }) async {
    _configureDioClient();
    final res = await _dio.get(path, queryParameters: data);
    return res.data;
  }

  Future<T> post<T>({
    @required String path,
    dynamic data,
  }) async {
    _configureDioClient();
    final res = await _dio.post(path, data: data);
    return res.data;
  }

  Future<T> put<T>({
    @required String path,
    dynamic data,
  }) async {
    _configureDioClient();
    final res = await _dio.put(path, data: data);
    return res.data;
  }

  Future<T> delete<T>({
    @required String path,
    dynamic data,
  }) async {
    _configureDioClient();
    final res = await _dio.delete(path, data: data);
    return res.data;
  }

  static List<T> listParser<T>(dynamic data, T Function(dynamic data) parser) {
    final list = <T>[];
    if (data is List) {
      for (final item in data) {
        list.add(parser(item));
      }
    }
    return list;
  }

  static Map<String, dynamic> _getHeaders() {
    final token = getIt<IUserLocalDataSource>().readAuthToken();
    return token == null
        ? {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }
        : {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          };
  }

  static void _configureDioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: _getHeaders(),
      ),
    )..interceptors.add(_logger);
  }
}
