import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../components/cart_dropdown.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../models/order_model.dart';

import '../../../routes/config_routes.dart';
import '../../profile/dialogs/new_address_dialog.dart';

class ShippingDatePage extends StatefulWidget {
  const ShippingDatePage({
    Key key,
    @required this.cart,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _ShippingDatePageState createState() => _ShippingDatePageState();
}

class _ShippingDatePageState extends State<ShippingDatePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ShippingDateCard(
                enabeld: widget.cart.type == OrderType.secluded,
                cart: widget.cart,
                onChanged: (value) {
                  setState(() {
                    widget.cart.orderDate = value;
                  });
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CartDropdown(
                  dropdownType: DropdownValueType.orderType,
                  itemAsString: (value) => mapOrderTypeToLabel(value),
                  initialValue: widget.cart.type,
                  onValueChanged: (value) {
                    setState(() {
                      widget.cart.type = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShippingDateCard extends StatelessWidget {
  const ShippingDateCard({
    Key key,
    @required this.cart,
    @required this.onChanged,
    @required this.enabeld,
  }) : super(key: key);

  final ValueChanged<DateTime> onChanged;
  final CartModel cart;
  final bool enabeld;
  @override
  Widget build(BuildContext context) {
    return Card(
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
              S.current.delivery_date,
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
                enabled: enabeld,
                onTap: onChanged == null
                    ? null
                    : () async {
                        final _date = await showDatePicker(
                          context: context,
                          initialDate: cart.orderDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (_date != null) {
                          onChanged(cart.orderDate.setDate(_date));
                        }
                      },
                title: cart == null
                    ? null
                    : Center(
                        child: Text(
                          cart.type == OrderType.unsecluded
                              ? S.current.unsecluded
                              : DateFormat.MEd().format(cart.orderDate),
                        ),
                      ),
                // subtitle: date == null ? null : Text('بعد 3 ايام'),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

extension on DateTime {
  DateTime setDate(DateTime newValue) {
    return DateTime(
      newValue.year,
      newValue.month,
      newValue.day,
      hour,
      minute,
    );
  }

  DateTime setTime(TimeOfDay newValue) {
    return DateTime(
      year,
      month,
      day,
      newValue.hour,
      newValue.minute,
    );
  }
}
