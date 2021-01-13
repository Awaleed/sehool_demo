import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/components/cart_item_preview.dart';
import 'package:sehool/src/components/cart_product_preview.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CheckoutItemPreview extends StatelessWidget {
  const CheckoutItemPreview({Key key, @required this.cartItem})
      : super(key: key);
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    title: Text(S.of(context).quantity),
                    subtitle: Text('${cartItem.quantity}'),
                  ),
                  ListTile(
                    title: Text('طريقة التقطيع'),
                    subtitle: Text(cartItem.slicingMethod.name),
                  ),
                  ListTile(
                    title: Text(S.of(context).notes),
                    subtitle:
                        Text(cartItem.notes ?? 'S.of(context).no_comments'),
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
    );
  }
}
