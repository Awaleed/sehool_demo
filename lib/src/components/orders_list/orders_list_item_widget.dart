import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../models/order_model.dart';

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
            if (cart.products?.isNotEmpty ?? false)
              ...cart.products.map(
                (e) => ListTile(
                  title: Text(e.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${e.qyt} ${S.current.piece}, ${e.slicerType}',
                      ),
                      Text(
                        '${S.current.notes}: ${e.note ?? S.current.none}',
                      ),
                    ],
                  ),
                  trailing: Text('${cart.total} ${S.current.rial}'),
                ),
              ),
            const Divider(),
            Text(
              S.current.notes,
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
                title: Text(cart.note ?? S.current.none),
              ),
            ),
            const Divider(),
            Text(
              S.current.shipping_address,
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
              child: Column(
                children: [
                  ListTile(
                    title: Text(S.current.cites),
                    subtitle: Text(cart.address?.city?.name ?? S.current.none),
                  ),
                  ListTile(
                    title: Text(S.current.city_section),
                    subtitle:
                        Text(cart.address?.section?.name ?? S.current.none),
                  ),
                  ListTile(
                    title: Text(S.current.address),
                    subtitle: Text(cart.address?.address ?? S.current.none),
                  ),
                ],
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
              child: ListTile(title: Text(cart.payment ?? '')),
            ),
          ],
        ),
      ),
    );
  }
}
