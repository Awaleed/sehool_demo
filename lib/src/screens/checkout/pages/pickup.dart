import 'package:flutter/material.dart';
import 'package:sehool/src/components/cart_dropdown.dart';
import 'package:sehool/src/models/cart_model.dart';
import 'package:sehool/src/models/dropdown_value_model.dart';
import 'package:sehool/src/models/order_model.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(padding: EdgeInsets.all(10), child: _TotalCard()),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CartDropdown<PickupMethod>(
                dropdownType: DropdownValueType.pickupMethod,
                initialValue: cart.pickupMethod,
                onValueChanged: (value) {
                  cart.pickupMethod = value;
                  onChanged?.call(value);
                },
              ),
            ),
          ),
        ],
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

class _TotalCard extends StatelessWidget {
  const _TotalCard({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 10,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.zero,
            color: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    ' ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('المدينة'),
                    subtitle: Text('10'),
                  ),
                  ListTile(
                    title: Text('الحي'),
                    subtitle: Text('بدون'),
                  ),
                  ListTile(
                    title: Text('العنوان'),
                    subtitle: Text('بدون'),
                  ),
                  ListTile(
                    title: Text('ملاحظات'),
                    subtitle: Text('بدون'),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -80,
            left: 15,
            right: 15,
            height: 150,
            child: _HomeCard(),
          ),
        ],
      ),
    );
  }
}
