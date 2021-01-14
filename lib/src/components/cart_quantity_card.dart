import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../models/cart_model.dart';

class CartQuantityCard extends StatefulWidget {
  const CartQuantityCard({Key key, @required this.cartItem}) : super(key: key);
  final CartItemModel cartItem;

  @override
  _CartQuantityCardState createState() => _CartQuantityCardState();
}

class _CartQuantityCardState extends State<CartQuantityCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(
            onTap: widget.cartItem.quantity <= 1
                ? null
                : widget.cartItem.decrementCart,
            icon: Icons.remove_rounded),
        Text(
          '${widget.cartItem.quantity}',
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.white),
        ),
        _buildButton(
          onTap: widget.cartItem.quantity >= 100
              ? null
              : widget.cartItem.incrementCart,
          icon: FluentIcons.add_24_regular,
        ),
      ],
    );
  }

  Widget _buildButton({
    VoidCallback onTap,
    IconData icon,
  }) =>
      ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size.fromRadius(50),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        onPressed: onTap == null ? null : () => setState(onTap),
        child: Icon(icon),
      );
}
