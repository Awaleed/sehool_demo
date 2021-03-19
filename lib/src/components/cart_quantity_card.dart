import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../generated/l10n.dart';
import '../data/user_datasource.dart';
import '../models/cart_model.dart';
import '../models/user_model.dart';
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
        const Spacer(),
        _buildButton(
            onTap: () {
              widget.onChanged();
              widget.cartItem.decrementCart();
              if (kUser.level == UserLevel.merchant && !widget.cartItem.canDecrement) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white70,
                      content: Text(S.current.delivery_qyt_msg),
                    );
                  },
                );
              }
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
                            } else if (int.tryParse(value) > widget.cartItem.product.qyt) {
                              return S.current.qyt_not_enough_message;
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
            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black87),
          ),
        ),
        _buildButton(
          onTap: () {
            widget.onChanged();
            if (widget.cartItem.quantity == widget.cartItem.product.qyt) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white70,
                  content: Text(S.current.qyt_not_enough_message),
                ),
              );
            } else {
              widget.cartItem.incrementCart();
            }
          },
          child: const Icon(FluentIcons.add_24_regular),
        ),
        const Spacer(),
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
            const Size.fromRadius(20),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () => setState(onTap),
        child: child,
      );
}
