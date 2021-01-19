import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/cart_model.dart';
import '../routes/config_routes.dart';
import '../screens/cart/add_to_cart.dart';
import 'cart_product_preview.dart';

class CheckoutItemPreview extends StatelessWidget {
  const CheckoutItemPreview({Key key, @required this.cartItem})
      : super(key: key);
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.sailor.navigate(
          AddToCartScreen.routeName,
          params: {'cart_item': cartItem},
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 75),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              elevation: 10,
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.zero,
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
                      '',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(S.current.quantity),
                      subtitle: Text('${cartItem.quantity}'),
                    ),
                    ListTile(
                      title: Text(S.current.slicing_method),
                      subtitle: Text(cartItem?.slicingMethod?.name ?? ''),
                    ),
                    ListTile(
                      title: Text(S.current.notes),
                      subtitle: Text(cartItem.note ?? S.current.none),
                    ),
                    ListTile(
                      title: Text(S.current.total),
                      subtitle: Text('${cartItem.total} ${S.current.rial}'),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -75,
              left: 15,
              right: 15,
              height: 150,
              child: CartProductPreview(product: cartItem.product),
            ),
          ],
        ),
      ),
    );
  }
}
