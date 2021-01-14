import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/components/cart_dropdown.dart';
import 'package:sehool/src/data/user_datasource.dart';
import 'package:sehool/src/models/cart_model.dart';
import 'package:sehool/src/models/dropdown_value_model.dart';
import 'package:sehool/src/models/order_model.dart';

import '../../../routes/config_routes.dart';
import '../../profile/dialogs/new_address_dialog.dart';

class PaymentMethodReviewPage extends StatefulWidget {
  const PaymentMethodReviewPage({
    Key key,
    @required this.cart,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _PaymentMethodReviewPageState createState() =>
      _PaymentMethodReviewPageState();
}

class _PaymentMethodReviewPageState extends State<PaymentMethodReviewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.all(10),
              child: _TotalCard(cart: widget.cart)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CartDropdown(
                dropdownType: DropdownValueType.paymentMethods,
                initialValue: widget.cart.paymentMethod,
                onValueChanged: (value) {
                  setState(() {
                    widget.cart.paymentMethod = value;
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

class _TotalCard extends StatelessWidget {
  const _TotalCard({
    Key key,
    this.cart,
  }) : super(key: key);
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  S.current.total,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Text('${cart.total} ${S.current.rial}'),
                  ),
                ),
                const Divider(),
                Text(
                  S.current.balance,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Text('${kUser.wallet} ${S.current.rial}'),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
