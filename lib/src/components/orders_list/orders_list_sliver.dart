import 'package:flutter/material.dart';
import 'package:sehool/src/models/order_model.dart';

import '../../../init_injectable.dart';
import '../../models/product_model.dart';
import 'orders_list_item_widget.dart';
import 'orders_list_loading_item_widget.dart';
import 'empty_orders_list.dart';

class OrdersListSliver extends StatelessWidget {
  const OrdersListSliver({
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= orders.length) {
            return const OrdersListLoadingItemWidget();
          } else {
            return OrdersListItemWidget(cart: orders.elementAt(index));
          }
        },
        childCount: isLoading ? orders.length + 5 : orders.length,
      ),
    );
  }
}
