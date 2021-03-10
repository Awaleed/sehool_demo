import 'package:flutter/material.dart';

import '../../../components/cart_product_preview.dart';
import '../../../models/cart_model.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key key, @required this.cartItem}) : super(key: key);
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: CartTextField(cartItem: cartItem),
          // ),
        ],
      ),
    );
  }
}
