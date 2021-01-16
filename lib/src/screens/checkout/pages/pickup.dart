import 'package:flutter/material.dart';
import '../../../components/cart_dropdown.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../models/order_model.dart';

import '../../../routes/config_routes.dart';
import '../../profile/dialogs/new_address_dialog.dart';

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
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CartDropdown(
                isRadio: true,
                dropdownType: DropdownValueType.pickupMethod,
                itemAsString: (value) => mapPickupMethodToLabel(value),
                initialValue: cart.pickupMethod,
                onValueChanged: (value) {
                  cart.pickupMethod = value;
                  onChanged?.call(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Hero(
            tag: 'image$id',
            createRectTween: (begin, end) => RectTween(begin: begin, end: end),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
