import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';

import '../models/cart_model.dart';

class CartTextField extends StatelessWidget {
  const CartTextField({
    Key key,
    @required this.cartItem,
  }) : super(key: key);
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController.fromValue(
        TextEditingValue(text: cartItem.notes ?? ''),
      ),
      onChanged: (value) => cartItem.notes = value,
      decoration: InputDecoration(
        hintText: S.of(context).notes,
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 10,
    );
  }
}
