import 'package:flutter/material.dart';

import '../../../components/cart_dropdown.dart';
import '../../../components/cart_product_preview.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../models/product_model.dart';

class SlicingMethodPage extends StatelessWidget {
  const SlicingMethodPage({Key key, @required this.cartItem}) : super(key: key);
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
            child: CartDropdown(
              dropdownType: DropdownValueType.slicingMethods,
              initialValue: cartItem.slicingMethod,
              onValueChanged: (value) {
                cartItem.slicingMethod = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
