import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/cart_model.dart';

class CartItemPreview extends StatelessWidget {
  const CartItemPreview({Key key, @required this.cartItem}) : super(key: key);
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                S.current.summery,
                style: Theme.of(context).textTheme.button,
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(S.current.item),
                    subtitle: Text(cartItem.product.name ?? S.current.none),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(S.current.quantity),
                    subtitle: Text('${cartItem.quantity}'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(S.current.slicing_method),
                    subtitle:
                        Text(cartItem.slicingMethod?.name ?? S.current.none),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(S.current.total),
                    subtitle: Text('${cartItem.total} ﷼'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
