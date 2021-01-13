import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/profile/dialogs/new_address_dialog.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingDatePage extends StatefulWidget {
  const ShippingDatePage({Key key}) : super(key: key);

  @override
  _ShippingDatePageState createState() => _ShippingDatePageState();
}

class _ShippingDatePageState extends State<ShippingDatePage> {
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
                    items: ['حالا', 'مجدولة']
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
          elevation: 10,
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
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    ),
                    title: Text(
                      DateFormat.MEd().format(
                        DateTime.now().add(
                          random.integer(30).days,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      'بعد 3 ايام',
                    ),
                  ),
                ),
                const Divider(),
                Text(
                  'الساعة',
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
                    onTap: () => showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute,
                      ),
                    ),
                    title: Text(
                      DateFormat.Hm().format(
                        DateTime.now().add(
                          random.integer(30).days,
                        ),
                      ),
                    ),
                    subtitle: Text('صباحا'),
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
