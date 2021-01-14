import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/components/cart_item_preview.dart';
import 'package:sehool/src/components/cart_product_preview.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CheckoutAddressCard extends StatelessWidget {
  const CheckoutAddressCard({Key key, @required this.cart}) : super(key: key);
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 2,
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
                    title: Text('S.of(context).city'),
                    subtitle: Text(cart.address?.city?.name ?? 'بدون'),
                  ),
                  ListTile(
                    title: Text('الحي'),
                    subtitle: Text(cart.address?.citySection?.name ?? 'بدون'),
                  ),
                  ListTile(
                    title: Text('العنوان'),
                    subtitle: Text(cart.address?.address ?? 'بدون'),
                  ),
                  ListTile(
                    title: Text('ملاحظات'),
                    subtitle: Text(cart.address?.note ?? 'بدون'),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -80,
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
          elevation: 2,
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
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
