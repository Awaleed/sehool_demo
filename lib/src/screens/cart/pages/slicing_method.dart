import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SlicingMethodPage extends StatefulWidget {
  const SlicingMethodPage({Key key}) : super(key: key);

  @override
  _SlicingMethodPageState createState() => _SlicingMethodPageState();
}

class _SlicingMethodPageState extends State<SlicingMethodPage> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: SizedBox(
            height: 300,
            child: _HomeCard(),
          ),
        ),
        Expanded(
          child: Center(
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
                    icon: const SizedBox.shrink(),
                    isExpanded: true,
                    items: [
                      'normal',
                      'light',
                      'full',
                      'none',
                    ]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
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
        ),
      ],
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
