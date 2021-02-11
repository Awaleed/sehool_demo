import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../components/cart_dropdown.dart';
import '../../../data/user_datasource.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';

class PaymentMethodReviewPage extends StatefulWidget {
  const PaymentMethodReviewPage({
    Key key,
    @required this.cart,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _PaymentMethodReviewPageState createState() => _PaymentMethodReviewPageState();
}

class _PaymentMethodReviewPageState extends State<PaymentMethodReviewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _TotalCard(cart: widget.cart),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CartDropdown(
                isRadio: true,
                dropdownType: DropdownValueType.paymentMethods,
                initialValue: widget.cart.paymentMethod,
                itemAsString: (value) => value.name,
                cart: widget.cart,
                onValueChanged: (value) {
                  setState(() {
                    widget.cart.paymentMethod = value;
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
          elevation: 0,
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
                    title: Row(
                      children: [
                        Text('${cart.total} ﷼'),
                        if (cart.coupon != null) ...[
                          const SizedBox(width: 20),
                          Text(
                            '${cart.totalWithoutDiscount} ﷼',
                            style: TextStyle(
                              decoration: cart.coupon != null ? TextDecoration.lineThrough : TextDecoration.none,
                            ),
                          ),
                        ]
                      ],
                    ),
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
                    title: Text('${kUser.wallet} ﷼'),
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
