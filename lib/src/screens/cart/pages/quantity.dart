import 'package:flutter/material.dart';

import '../../../components/cart_product_preview.dart';
import '../../../components/cart_quantity_card.dart';
import '../../../models/cart_model.dart';

class QuantityPage extends StatelessWidget {
  const QuantityPage({Key key, @required this.cartItem}) : super(key: key);
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 300,
            child: CartProductPreview(product: cartItem.product),
          ),
          CartQuantityCard(cartItem: cartItem, onChanged: () {}),
        ],
      ),
    );
  }
}
