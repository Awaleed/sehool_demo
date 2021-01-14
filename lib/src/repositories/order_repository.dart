import 'package:injectable/injectable.dart';

import '../data/order_datasource.dart';
import '../models/checkout_model.dart';
import '../models/order_model.dart';

abstract class IOrderRepository {
  Future<OrderModel> getOrder(int id);
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
  Future<OrderModel> getOrder(int id) {
    throw UnsupportedError('message');
  }

  @override
  Future<OrderModel> placeOrder(CheckoutModel model) {
    throw UnsupportedError('message');
  }
}
