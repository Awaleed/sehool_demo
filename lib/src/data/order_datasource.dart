import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';

abstract class IOrderRemoteDataSource {
  Future<List> getOrders();
  Future<Map<String, dynamic>> cancelOrder(int id, Map<String, dynamic> data);

  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> json);
}

@Singleton(as: IOrderRemoteDataSource)
class OrderRemoteDataSource extends IOrderRemoteDataSource with ApiCaller {
  @override
  Future<List> getOrders() {
    return get(path: '/shoppingCart');
  }

  @override
  Future<Map<String, dynamic>> cancelOrder(int id, Map<String, dynamic> data) {
    return post(
      path: '/orders/$id',
      data: data,
    );
  }

  @override
  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> data) {
    return post(
      path: '/orders/new',
      data: data,
    );
  }
}
