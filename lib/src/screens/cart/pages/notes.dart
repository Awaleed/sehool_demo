import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:sehool/src/components/cart_product_preview.dart';
import 'package:sehool/src/components/cart_text_field.dart';
import 'package:sehool/src/models/cart_model.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key key, @required this.cartItem}) : super(key: key);
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 300,
            child: CartProductPreview(product: cartItem.product),
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CartTextField(cartItem: cartItem),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
