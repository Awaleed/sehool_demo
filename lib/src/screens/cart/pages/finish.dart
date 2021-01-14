import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/cart_item_preview.dart';
import '../../../components/cart_product_preview.dart';
import '../../../cubits/cart_cubit/cart_cubit.dart';
import '../../../models/cart_model.dart';
import '../../../routes/config_routes.dart';
import '../../checkout/checkout.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({Key key, @required this.cartItem}) : super(key: key);
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CartItemPreview(cartItem: cartItem),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(
                label: S.current.add_to_cart,
                onTap: () {
                  getIt<CartCubit>().addItem(cartItem);
                  AppRouter.sailor.pop();
                },
              ),
              _buildButton(
                label: S.current.checkout,
                onTap: () {
                  getIt<CartCubit>().addItem(cartItem);
                  AppRouter.sailor.navigate(
                    CheckoutScreen.routeName,
                    navigationType: NavigationType.pushReplace,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    VoidCallback onTap,
    String label,
  }) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
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
            onPressed: onTap,
            child: Text(label),
          ),
        ),
      );
}
