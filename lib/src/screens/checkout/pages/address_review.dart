import 'package:flutter/material.dart';
import '../../../components/cart_dropdown.dart';

import '../../../components/checkout_address.dart';
import '../../../models/address_model.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../routes/config_routes.dart';
import '../../profile/dialogs/new_address_dialog.dart';

class AddressReviewPage extends StatefulWidget {
  const AddressReviewPage({
    Key key,
    @required this.cart,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _AddressReviewPageState createState() => _AddressReviewPageState();
}

class _AddressReviewPageState extends State<AddressReviewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CheckoutAddressCard(cart: widget.cart),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CartDropdown(
                isRadio: true,
                value: 0,
                dropdownType: DropdownValueType.addresses,
                initialValue: widget.cart.address,
                onValueChanged: (value) {
                  setState(() {
                    widget.cart.address = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
