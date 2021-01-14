import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:sehool/src/components/cart_text_field.dart';
import 'package:sehool/src/models/cart_model.dart';

class CheckoutNotesPage extends StatelessWidget {
  const CheckoutNotesPage({Key key, @required this.cart, this.onChanged})
      : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CartTextField(cart: cart),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
