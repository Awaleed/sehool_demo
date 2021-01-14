import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:sehool/src/components/checkout_item_preview.dart';
import 'package:sehool/src/models/cart_model.dart';

class CartReviewPage extends StatelessWidget {
  const CartReviewPage({Key key, @required this.cartItems, this.onChanged})
      : super(key: key);
  final List<CartItemModel> cartItems;
  final ValueChanged onChanged;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ...cartItems.map(
            (e) => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CheckoutItemPreview(cartItem: e),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
