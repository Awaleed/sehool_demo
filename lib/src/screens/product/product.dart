import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/cart/add_to_cart.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/product';

  const ProductScreen({
    Key key,
    @required this.heroTag,
  }) : super(key: key);

  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomScrollView(
            // clipBehavior: Clip.none,
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 400,
                elevation: 0,
                backgroundColor: Colors.black54,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                      child: FlexibleSpaceBar(
                        title: PlayAnimation(
                          tween: 0.0.tweenTo(1.0),
                          curve: Curves.easeInOut,
                          duration: 1700.milliseconds,
                          builder: (context, child, value) => Opacity(
                            opacity: value,
                            child: child,
                          ),
                          child: Text(
                            faker.food.dish(),
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Hero(
                              tag: 'image$heroTag',
                              child: Image.asset(
                                'assets/images/meat1.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            PlayAnimation(
                              tween: 0.0.tweenTo(1.0),
                              curve: Curves.easeInOut,
                              duration: 1700.milliseconds,
                              builder: (context, child, value) => Opacity(
                                opacity: value,
                                child: child,
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(bottom: 50, top: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  gradient: LinearGradient(
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      right: 30,
                      bottom: -20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            heroTag: 'btn$heroTag',
                            onPressed: () => AppRouter.sailor.navigate(
                              AddToCartScreen.routeName,
                              params: {'heroTag': heroTag},
                            ),
                            backgroundColor: Colors.black,
                            hoverColor: Colors.amber.withOpacity(.3),
                            splashColor: Colors.amber.withOpacity(.3),
                            child: const FaIcon(
                              FontAwesomeIcons.cartPlus,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, __) => const _Card(),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: const FaIcon(FontAwesomeIcons.paperPlane),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white54,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Card(
              color: Colors.white70,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Text(faker.lorem.word()),
                      const Spacer(),
                      RatingBarIndicator(
                        rating: 2.75,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 13.0,
                        // direction: Axis.vertical,
                      )
                    ],
                  ),
                ),
                subtitle: Text(faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence()),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: -10,
            child: CircleAvatar(
              radius: 30,
            ),
          )
        ],
      ),
    );
  }
}
