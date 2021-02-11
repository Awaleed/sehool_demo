import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../generated/l10n.dart';
import '../models/cart_model.dart';
import '../routes/config_routes.dart';

class CartQuantityCard extends StatefulWidget {
  const CartQuantityCard({Key key, @required this.cartItem, @required this.onChanged}) : super(key: key);
  final CartItemModel cartItem;
  final VoidCallback onChanged;
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
                ? () {}
                : () {
                    widget.onChanged();
                    widget.cartItem.decrementCart();
                  },
            child: const Icon(Icons.remove_rounded)),
        TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size.fromRadius(50)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final key = GlobalKey<FormState>();
                return SimpleDialog(
                  backgroundColor: Colors.white70,
                  title: Text(S.current.quantity),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: key,
                        child: TextFormField(
                          initialValue: '${widget.cartItem.quantity}',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          onSaved: (value) => widget.cartItem.quantity = int.tryParse(value),
                          validator: (value) {
                            if (!isNumeric(value) || int.tryParse(value) <= 0) {
                              return S.current.verify_your_quantity_and_click_checkout;
                            }
                            return null;
                          },
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            labelText: S.current.quantity,
                            labelStyle: TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: const EdgeInsets.all(12),
                            hintText: S.current.quantity,
                            hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            prefixIcon: Icon(FluentIcons.number_symbol_24_regular, color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size.fromRadius(30),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          onPressed: () => AppRouter.sailor.pop(),
                          child: Text(S.current.cancel),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size.fromRadius(30),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (key.currentState.validate()) {
                              key.currentState.save();
                              AppRouter.sailor.pop();
                              setState(() {});
                              widget.onChanged();
                            }
                          },
                          child: Text(S.current.save),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            '${widget.cartItem.quantity}',
            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.black87),
          ),
        ),
        _buildButton(
          onTap: widget.cartItem.quantity >= 100
              ? () {}
              : () {
                  widget.onChanged();
                  widget.cartItem.incrementCart();
                },
          child: const Icon(FluentIcons.add_24_regular),
        ),
      ],
    );
  }

  Widget _buildButton({
    VoidCallback onTap,
    Widget child,
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
        onPressed: () => setState(onTap),
        child: child,
      );
}
