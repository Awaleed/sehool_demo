import 'package:injectable/injectable.dart';

import '../core/api_caller.dart';
import '../data/order_datasource.dart';
import '../models/checkout_model.dart';
import '../models/order_model.dart';

abstract class IOrderRepository {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> cancelOrder({
    int orderId,
    String reason,
  });

  Future<OrderModel> placeOrder(CheckoutModel model);
}

@Singleton(as: IOrderRepository)
class OrderRepositoryImpl implements IOrderRepository {
  final IOrderRemoteDataSource _orderRemoteDataSource;

  OrderRepositoryImpl(this._orderRemoteDataSource);

  @override
  Future<OrderModel> cancelOrder({int orderId, String reason}) {
    throw UnsupportedError('message');
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final res = await _orderRemoteDataSource.getOrders();
    return ApiCaller.listParser(
      res,
      (data) {
        data['total'] = double.tryParse('${data['total']}' ?? '');
        // data['lat'] = double.tryParse('${data['lat']}' ?? '');
        data['items'] = data['products'];
        // data['address'] = data['description'];
        if (data['address'] != null) {
          data['address']['lang'] =
              double.tryParse('${data['address']['lang']}' ?? '');
          data['address']['lat'] =
              double.tryParse('${data['address']['lat']}' ?? '');
          data['address']['note'] = data['address']['description'];
          data['address']['address'] = data['address']['description'];
        }
        return OrderModel.fromJson(data);
      },
    );
  }

  @override
  Future<OrderModel> placeOrder(CheckoutModel model) {
    throw UnsupportedError('message');
  }
}
