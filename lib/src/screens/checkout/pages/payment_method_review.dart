import 'package:flutter/material.dart';

import '../../../routes/config_routes.dart';
import '../../profile/dialogs/new_address_dialog.dart';

class PaymentMethodReviewPage extends StatefulWidget {
  const PaymentMethodReviewPage({Key key}) : super(key: key);

  @override
  _PaymentMethodReviewPageState createState() =>
      _PaymentMethodReviewPageState();
}

class _PaymentMethodReviewPageState extends State<PaymentMethodReviewPage> {
  String selectedValue;

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
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedValue,
                    dropdownColor: Colors.amber.withOpacity(.8),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    icon: const SizedBox.shrink(),
                    isExpanded: true,
                    items: ['normal', 'light', 'full', 'none', ' + اضافة جديد']
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            onTap: e != ' + اضافة جديد'
                                ? null
                                : () => AppRouter.sailor
                                    .navigate(NewAddressDialog.routeName),
                            child: Center(
                              child: Text(
                                e,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({Key key, this.id}) : super(key: key);
  final int id;

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
                  'المجموع',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Text('2,500 ريال'),
                  ),
                ),
                const Divider(),
                Text(
                  'رصيد المحفظة',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Text('1000 ريال'),
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
