import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _TotalCard(),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _TotalCardAddress(),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _TotalCardDate(),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                // value: selectedValue,
                // dropdownColor: Colors.amber.withOpacity(.8),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 7,
                maxLines: 14,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                // selectedItemBuilder: (_) => [
                //   'normal',
                //   'light',
                //   'full',
                //   'none',
                // ]
                //     .map(
                //       (e) => Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             e,
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .headline5
                //                 .copyWith(color: Colors.black),
                //           ),
                //         ],
                //       ),
                //     )
                //     .toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text('اتمام الدفع'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text('اضافة المزيد'),
              ),
            ],
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
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('ملخص الطلب'),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.transparent,
                Colors.transparent,
              ],
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
      padding: const EdgeInsets.only(top: 75),
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
                    title: Text(faker.lorem.word()),
                    subtitle: Text('10 قطع, بدون تقطيع'),
                    trailing: Text('1,200 ريال'),
                  ),
                  ListTile(
                    title: Text(faker.lorem.word()),
                    subtitle: Text('10 قطع, بدون تقطيع'),
                    trailing: Text('1,200 ريال'),
                  ),
                  ListTile(
                    title: Text(faker.lorem.word()),
                    subtitle: Text('10 قطع, بدون تقطيع'),
                    trailing: Text('1,200 ريال'),
                  ),
                  const Divider(),
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
                    'طريقة الدفع',
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
                      title: Text('VISA'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -75,
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

class _HomeCardAddress extends StatelessWidget {
  const _HomeCardAddress({Key key, this.id}) : super(key: key);
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

class _TotalCardAddress extends StatelessWidget {
  const _TotalCardAddress({Key key, this.id}) : super(key: key);
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
            child: _HomeCardAddress(),
          ),
        ],
      ),
    );
  }
}

class _HomeCardDate extends StatelessWidget {
  const _HomeCardDate({Key key, this.id}) : super(key: key);
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

class _TotalCardDate extends StatelessWidget {
  const _TotalCardDate({Key key, this.id}) : super(key: key);
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
