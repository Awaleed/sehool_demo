import 'package:flutter/material.dart';
import 'package:sehool/src/components/address_card.dart';
import '../../../components/cart_dropdown.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AddressCard(address: widget.cart.address),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CartDropdown(
                isRadio: true,
                dropdownType: DropdownValueType.addresses,
                initialValue: widget.cart.address,
                itemAsString: (value) => (value as AddressModel).address,
                onValueChanged: (value) {
                  setState(() {
                    widget.cart.address = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
