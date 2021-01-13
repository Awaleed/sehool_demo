import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartItemPreview extends StatelessWidget {
  const CartItemPreview({Key key, @required this.cartItem}) : super(key: key);
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
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
              'الملخص:',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Divider(),
            ListTile(
              title: Text('الكمية'),
              subtitle: Text('${cartItem.quantity}'),
            ),
            ListTile(
              title: Text('طريقة التقطيع'),
              subtitle: Text(cartItem.slicingMethod?.name ?? 'لم يتم الاختيار'),
            ),
            ListTile(
              title: Text('ملاحظات'),
              subtitle: Text(cartItem.notes ?? 'بدون'),
            ),
          ],
        ),
      ),
    );
  }
}
