import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

import '../models/cart_model.dart';

class CartTextField extends StatelessWidget {
  const CartTextField({
    Key key,
    this.cartItem,
    this.cart,
  }) : super(key: key);
  final CartItemModel cartItem;
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController.fromValue(
        TextEditingValue(text: cart?.notes ?? cartItem?.notes ?? ''),
      ),
      onChanged: (value) {
        cartItem?.notes = value;
        cart?.notes = value;
      },
      decoration: InputDecoration(
        hintText: S.current.notes,
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 5,
      maxLines: 20,
    );
  }
}
