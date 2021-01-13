import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class CheckoutNotesPage extends StatefulWidget {
  const CheckoutNotesPage({Key key}) : super(key: key);

  @override
  _CheckoutNotesPageState createState() => _CheckoutNotesPageState();
}

class _CheckoutNotesPageState extends State<CheckoutNotesPage> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                'assets/images/meat1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 35,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Text(
                  faker.food.dish(),
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
              ),
              Text(
                'الكمية المتاحة ${ArabicNumbers().convert(random.integer(100))} قطعة',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              )
            ],
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
