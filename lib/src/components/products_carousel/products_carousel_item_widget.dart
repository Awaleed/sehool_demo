import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
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
      onTap: () => AppRouter.sailor.navigate(ProductScreen.routeName, params: {'product': product}),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Card(
            elevation: 10,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(bottom: 30, top: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 50, top: 30),
            margin: const EdgeInsets.only(bottom: 30, top: 30),
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
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                  ),
                ),
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
                final cartItem = getIt<CartCubit>().getItem(product.id);
                return FloatingActionButton.extended(
                  heroTag: 'btn${product.id}',
                  onPressed: () {
                    if (cartItem != null) {
                      final action = CupertinoActionSheet(
                        title: Text(
                          S.current.remove_from_cart,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        message: Theme(
                          data: Theme.of(context),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem?.product?.name ?? '',
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                      '${cartItem.quantity} ${S.current.piece}, ${cartItem.slicingMethod?.name}',
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                              Text('${cartItem.total} ﷼'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              getIt<CartCubit>().removeItem(product.id);
                              Navigator.pop(context, true);

                              // AppRouter.sailor.navigate(
                              //   CheckoutScreen.routeName,
                              //   navigationType: NavigationType.pushReplace,
                              // );
                            },
                            child: Text(
                              S.current.confirmation,
                              style: Theme.of(context).textTheme.button.copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text(
                            S.current.cancel,
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      );
                      showCupertinoModalPopup(context: context, builder: (context) => action);
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
                  backgroundColor: Colors.amber,
                  hoverColor: Colors.amber.withOpacity(.3),
                  splashColor: Colors.amber.withOpacity(.3),
                  icon: Icon(cartItem != null ? FluentIcons.delete_24_regular : FluentIcons.cart_24_regular, color: Colors.black),
                  label: Text(
                    cartItem != null ? S.current.remove_from_cart : S.current.add_to_cart,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            height: 60,
            left: 30,
            right: 30,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: FittedBox(
                child: Text(
                  '${product.price} ﷼ / ${S.current.piece}',
                  style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.amber),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
