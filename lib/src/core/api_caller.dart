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
      _configureDioClient();
    });

  static const _baseUrl = 'http://192.64.115.192/~gsportsup/public/api';
  static Dio _dio;
  static PrettyDioLogger logger =
      PrettyDioLogger(responseBody: false, requestHeader: true);

  Dio get dio {
    return _dio;
  }

  int get userId {
    return 12;
  }

  Future<T> get<T>({
    @required String path,
    @required T Function(dynamic) parser,
  }) async {
    _configureDioClient();
    final res = await _dio.get(path);
    return parser(res.data);
  }

  Future<T> post<T>({
    @required String path,
    // @required T Function(dynamic) parser,
    dynamic data,
  }) async {
    _configureDioClient();
    final res = await _dio.post(path, data: data);
    // print(res.data);
    return res.data;
  }

  Future<T> put<T>({
    @required String path,
    // @required T Function(dynamic) parser,
    dynamic data,
  }) async {
    _configureDioClient();
    final res = await _dio.put(path, data: data);
    // print(res.data);
    return res.data;
  }

  Future<T> delete<T>({
    @required String path,
    // @required T Function(dynamic) parser,
    dynamic data,
  }) async {
    _configureDioClient();
    final res = await _dio.delete(path, data: data);
    // print(res.data);
    return res.data;
  }

  List<T> listParser<T>(dynamic data, T Function(dynamic data) parser) {
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
    )..interceptors.add(logger);
  }
}
