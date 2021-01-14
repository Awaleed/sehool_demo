import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/product_model.dart';
import '../../routes/config_routes.dart';
import '../../screens/cart/add_to_cart.dart';
import '../../screens/product/product.dart';

class ProductsCarouselItemWidget extends StatelessWidget {
  const ProductsCarouselItemWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.sailor
          .navigate(ProductScreen.routeName, params: {'product': product}),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Card(
            elevation: 10,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(bottom: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: Colors.transparent,
            child: Hero(
              tag: 'image${product.id}',
              createRectTween: (begin, end) =>
                  RectTween(begin: begin, end: end),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 50, top: 20),
            margin: const EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              color: Colors.black,
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
            bottom: 35 + 30.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Text(
                    product.name,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  '${S.current.available_quantity} ${Helpers.isArabic(context) ? ArabicNumbers().convert(product.qyt) : product.qyt} ${S.current.piece}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            height: 60,
            left: 30,
            right: 30,
            child: BlocBuilder<CartCubit, CartState>(
              cubit: getIt<CartCubit>(),
              builder: (context, state) {
                final inCart = state.cart.cartItems
                        .indexWhere((e) => e.product.id == product.id) >
                    -1;
                return FloatingActionButton.extended(
                  heroTag: 'btn${product.id}',
                  onPressed: () {
                    if (inCart) {
                      getIt<CartCubit>().removeItem(product.id);
                    } else {
                      AppRouter.sailor.navigate(
                        AddToCartScreen.routeName,
                        params: {'product': product},
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Colors.black,
                  hoverColor: Colors.amber.withOpacity(.3),
                  splashColor: Colors.amber.withOpacity(.3),
                  icon: Icon(
                    inCart
                        ? FluentIcons.remove_24_regular
                        : FluentIcons.cart_24_regular,
                    color: Colors.white,
                  ),
                  label: Text(
                    inCart ? S.current.remove_from_cart : S.current.add_to_cart,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
