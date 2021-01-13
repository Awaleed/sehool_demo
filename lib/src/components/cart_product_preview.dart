import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartProductPreview extends StatelessWidget {
  const CartProductPreview({Key key, @required this.product}) : super(key: key);
  final ProductModel product;

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
            tag: 'image${product.id}',
            createRectTween: (begin, end) => RectTween(begin: begin, end: end),
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
                  product.name,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
              ),
              Text(
                'الكمية المتاحة ${ArabicNumbers().convert(product.qyt)} قطعة',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
