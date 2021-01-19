import 'package:flutter/material.dart';
import 'package:sehool/src/models/order_model.dart';

import 'empty_orders_list.dart';
import 'orders_list_item_widget.dart';
import 'orders_list_loading_item_widget.dart';

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({
    Key key,
    @required this.orders,
    @required this.isLoading,
  }) : super(key: key);

  final List orders;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty && !isLoading) {
      return const EmptyOrdersList();
    }
    orders.retainWhere(
      (element) => (element as OrderModel).products?.isNotEmpty ?? false,
    );
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index >= orders.length) {
          return const OrdersListLoadingItemWidget();
        } else {
          return OrdersListItemWidget(cart: orders.elementAt(index));
        }
      },
      itemCount: isLoading ? orders.length + 5 : orders.length,
    );
  }
}
