import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import 'image_colors.dart';

class Playground extends StatelessWidget {
  static const routeName = '/playground';

  const Playground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black45,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.amber,
                  Colors.black,
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            right: 5,
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
            // child: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       faker.lorem.word(),
            //       style: Theme.of(context)
            //           .textTheme
            //           .headline2
            //           .copyWith(color: Colors.white, height: 1),
            //     ),
            //     const SizedBox(height: 20),
            //     Text(
            //       faker.lorem.sentence() +
            //           faker.lorem.sentence() +
            //           faker.lorem.sentence(),
            //       maxLines: 2,
            //       style: Theme.of(context)
            //           .textTheme
            //           .headline4
            //           .copyWith(color: Colors.white, height: 1),
            //     ),
            //   ],
            // ),
          ),
          Positioned(
            top: 300,
            bottom: 100,
            left: 0,
            right: 0,
            child: CarouselSlider.builder(
              itemCount: 100,
              itemBuilder: (context, index) => _HomeCard(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 1,
                viewportFraction: .6,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    FluentIcons.person_24_filled,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    FluentIcons.video_24_filled,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  onPressed: () {},
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton.icon(
                    icon: const Icon(
                      FluentIcons.home_24_filled,
                      color: Colors.amber,
                    ),
                    label: Text(
                      S.current.home,
                      style: const TextStyle(color: Colors.amber),
                    ),
                    // iconSize: 30,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Card(
            elevation: 10,
            clipBehavior: Clip.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 50, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    // gradient: LinearGradient(
                    //   begin: Alignment.bottomCenter,
                    //   end: Alignment.topCenter,
                    //   colors: [
                    //     Colors.red,
                    //     Colors.amber,
                    //   ],
                    // ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        'https://lh3.googleusercontent.com/proxy/CJPvJZGzrzpwnSFgMuVqwJrr9XRxLtCDOGLk6ORqJRE0wwgasyTLOdgCY-JTNO1U4tEoBa-h5ChWREeJVtt7rpjti8BIN1VsOf9402aeolNZkL3yCu9gBYOdKo0yPig',
                        fit: BoxFit.contain,
                      ),
                      FittedBox(
                        child: Text(
                          faker.food.dish(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Text(
                        'الكمية المتاحة ${ArabicNumbers().convert(random.integer(100))} قطعة',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -30,
                  height: 60,
                  left: 30,
                  right: 30,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      overlayColor: MaterialStateProperty.all(
                          Colors.amber.withOpacity(.3)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: Text(
                      S.current.add_to_cart,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
