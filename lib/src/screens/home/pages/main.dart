import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/cart/add_to_cart.dart';
import 'package:sehool/src/screens/product/product.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../generated/l10n.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Image.network(
              'https://i.pinimg.com/originals/29/6a/4d/296a4d4d6bd75d9154721df9055c72a2.gif',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: CarouselSlider.builder(
            itemCount: 100,
            itemBuilder: (context, index) => _HomeCard(id: index),
            options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 1.3,
              viewportFraction: .6,
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
    return GestureDetector(
      onTap: () => AppRouter.sailor
          .navigate(ProductScreen.routeName, params: {'heroTag': '$id'}),
      child: Stack(
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
              createRectTween: (begin, end) =>
                  RectTween(begin: begin, end: end),
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
          Positioned(
            bottom: -30,
            height: 60,
            left: 30,
            right: 30,
            child: FloatingActionButton.extended(
              heroTag: 'btn$id',
              onPressed: () => AppRouter.sailor.navigate(
                AddToCartScreen.routeName,
                params: {'heroTag': '$id'},
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              backgroundColor: Colors.black,
              hoverColor: Colors.amber.withOpacity(.3),
              splashColor: Colors.amber.withOpacity(.3),
              icon: const FaIcon(
                FontAwesomeIcons.cartPlus,
                color: Colors.white,
              ),
              label: Text(
                S.of(context).add_to_cart,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
