import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../../generated/l10n.dart';
import '../../components/comments_list/comments_list_sliver.dart';
import '../../components/new_review_field.dart';
import '../../models/product_model.dart';
import '../../routes/config_routes.dart';
import '../cart/add_to_cart.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/product';

  const ProductScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

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
                image: CachedNetworkImageProvider(
                  'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomScrollView(
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
                            product.name,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Hero(
                              tag: 'image${product.id}',
                              child: CachedNetworkImage(
                                imageUrl: product.image,
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
                            heroTag: 'btn${product.id}',
                            onPressed: () => AppRouter.sailor.navigate(
                              AddToCartScreen.routeName,
                              params: {'product': product},
                            ),
                            backgroundColor: Colors.black,
                            hoverColor: Colors.amber.withOpacity(.3),
                            splashColor: Colors.amber.withOpacity(.3),
                            child: const Icon(
                              FluentIcons.add_24_filled,
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
              SliverToBoxAdapter(
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
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
                          S.of(context).description,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const Divider(),
                        Text(product.description),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(title: Text(S.of(context).comments)),
                  ),
                ),
              ),
              CommentsListSliver(productId: product.id),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: NewReviewField(productId: product.id),
          ),
        ],
      ),
    );
  }
}
