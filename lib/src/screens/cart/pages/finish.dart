import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/init_injectable.dart';
import 'package:sehool/src/components/cart_item_preview.dart';
import 'package:sehool/src/components/cart_product_preview.dart';
import 'package:sehool/src/cubits/cart_cubit/cart_cubit.dart';
import 'package:sehool/src/models/cart_model.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/checkout/checkout.dart';
import 'package:sehool/src/screens/home/home.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({Key key, @required this.cartItem}) : super(key: key);
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 150,
            child: CartProductPreview(product: cartItem.product),
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CartItemPreview(cartItem: cartItem),
            ),
          ),
          const SizedBox(height: 20),
          if (cartItem.validate)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  label: 'اضافة',
                  onTap: () {
                    getIt<CartCubit>().addItem(cartItem);
                    AppRouter.sailor.pop();
                  },
                ),
                _buildButton(
                  label: S.of(context).checkout,
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
        onPressed: onTap,
        child: Text(label),
      );
}
