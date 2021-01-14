import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/helpers/helper.dart';
import 'package:sehool/src/models/order_model.dart';

import '../../models/product_model.dart';

class OrdersListItemWidget extends StatelessWidget {
  const OrdersListItemWidget({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final OrderModel cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(20),
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${S.current.order_status}: ${S.current.ready_for_delivery}',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Divider(),
            ...cart.cartItems.map(
              (e) => ListTile(
                title: Text(e.product.name),
                subtitle: Text(
                  '${e.quantity} ${S.current.piece}, ${e.slicingMethod.name}',
                ),
                trailing: Text('${cart.total} ${S.current.rial}'),
              ),
            ),
            const Divider(),
            Text(
              S.current.total,
              style: Theme.of(context).textTheme.headline5,
            ),
            const Divider(),
            Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.zero,
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                title: Text('${cart.total} ${S.current.rial}'),
              ),
            ),
            const Divider(),
            Text(
              S.current.payment_mode,
              style: Theme.of(context).textTheme.headline5,
            ),
            const Divider(),
            Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.zero,
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(title: Text('${mapPaymentMethodTypeToLabel(cart.paymentMethod)}')),
            ),
          ],
        ),
      ),
    );
  }
}
