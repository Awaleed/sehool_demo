import 'package:flutter/material.dart';

import '../../../models/cart_model.dart';

class PickupPage extends StatelessWidget {
  const PickupPage({
    Key key,
    @required this.cart,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(height: 20),
            // if (cart.pickupMethod == PickupMethod.pickup)
            //   Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: CheckoutAddressCard(cart: cart),
            //   ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: CartDropdown(
            //     isRadio: true,
            //     dropdownType: DropdownValueType.pickupMethod,
            //     itemAsString: (value) => mapPickupMethodToLabel(value),
            //     initialValue: cart.pickupMethod,
            //     onValueChanged: (value) {
            //       cart.pickupMethod = value;
            //       onChanged?.call(value);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
