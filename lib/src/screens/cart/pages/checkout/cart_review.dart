import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartReviewPage extends StatefulWidget {
  const CartReviewPage({Key key}) : super(key: key);

  @override
  _CartReviewPageState createState() => _CartReviewPageState();
}

class _CartReviewPageState extends State<CartReviewPage> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 20),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _TotalCard(),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _TotalCard(),
            ),
          ),
          SizedBox(height: 20),
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
                    title: Text('الكمية'),
                    subtitle: Text('10'),
                  ),
                  ListTile(
                    title: Text('طريقة التقطيع'),
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
