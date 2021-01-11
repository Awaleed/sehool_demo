import 'package:injectable/injectable.dart';
import 'package:sehool/src/models/checkout_model.dart';

import '../data/order_datasource.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

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
    _orderRemoteDataSource.cancelOrder(orderId, {'data': 'reason'});
  }

  @override
  Future<OrderModel> getOrder(int id) {
    _orderRemoteDataSource.getOrder(id);
  }

  @override
  Future<OrderModel> placeOrder(CheckoutModel model) {
    _orderRemoteDataSource.placeOrder(model.toJson());
  }
}
