import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:division/division.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/video/video.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CarouselSlider.builder(
            itemCount: 100,
            itemBuilder: (context, index) => _HomeCard(id: index),
            options: CarouselOptions(
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
              aspectRatio: 1,
              viewportFraction: .6,
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.only(bottom: 50, top: 20),
        //   decoration: BoxDecoration(
        //     color: Colors.black38,
        //     borderRadius: BorderRadius.circular(25),
        //     gradient: const LinearGradient(
        //       begin: Alignment.bottomCenter,
        //       end: Alignment.topCenter,
        //       colors: [
        //         Colors.black,
        //         Colors.transparent,
        //         Colors.transparent,
        //       ],
        //     ),
        //   ),
        // ),
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
      onTap: () => AppRouter.sailor.navigate(
        VideoScreen.routeName,
        params: {'heroTag': '$id'},
      ),
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

          // Positioned(
          //   bottom: -30,
          //   height: 60,
          //   left: 30,
          //   right: 30,
          //   child: TextButton(
          //     onPressed: () {},
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(Colors.black),
          //       overlayColor:
          //           MaterialStateProperty.all(Colors.amber.withOpacity(.3)),
          //       shape: MaterialStateProperty.all(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(25),
          //         ),
          //       ),
          //     ),
          //     child: Text(
          //       S.of(context).add_to_cart,
          //       style: const TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
