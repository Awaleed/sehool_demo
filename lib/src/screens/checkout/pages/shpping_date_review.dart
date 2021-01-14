import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:sehool/src/components/cart_dropdown.dart';
import 'package:sehool/src/models/cart_model.dart';
import 'package:sehool/src/models/dropdown_value_model.dart';
import 'package:sehool/src/models/order_model.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ShippingDateCard(
              date: widget.cart.orderDate,
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
              child: CartDropdown<OrderType>(
                dropdownType: DropdownValueType.orderType,
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
    );
  }
}

class ShippingDateCard extends StatelessWidget {
  const ShippingDateCard({
    Key key,
    @required this.date,
    @required this.onChanged,
  }) : super(key: key);

  final ValueChanged<DateTime> onChanged;
  final DateTime date;

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
                  'التاريخ',
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
                    onTap: onChanged == null
                        ? null
                        : () async {
                            final _date = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );
                            if (_date != null) {
                              onChanged(date.setDate(_date));
                            }
                          },
                    title: date == null
                        ? null
                        : Text(DateFormat.MEd().format(date)),
                    subtitle: date == null ? null : Text('بعد 3 ايام'),
                  ),
                ),
                const Divider(),
                Text(
                  'الساعة',
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
                    onTap: onChanged == null
                        ? null
                        : () async {
                            final _time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                hour: date.hour,
                                minute: date.minute,
                              ),
                            );
                            if (_time != null) {
                              onChanged(date.setTime(_time));
                            }
                          },
                    title: date == null
                        ? null
                        : Text(DateFormat.Hm().format(date)),
                    subtitle: date == null ? null : Text('صباحا'),
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
