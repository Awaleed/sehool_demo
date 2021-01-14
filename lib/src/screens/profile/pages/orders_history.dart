import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/components/empty_orders_widget.dart';
import 'package:sehool/src/components/products_carousel/products_carousel_item_widget.dart';
import 'package:sehool/src/models/product_model.dart';

class OrdersHistory extends StatefulWidget {
  static const routeName = '/myOrdersHistory';
  const OrdersHistory({Key key}) : super(key: key);

  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black54,
            title: Text(
              S.current.my_orders,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
          ),
          body: EmptyOrdersWidget()),
    );
  }

  Widget _buildList() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return const ProductsCarouselItemWidget(
          product: ProductModel(
              id: 0,
              name: 'pro',
              qyt: 2,
              price: 200,
              description: 'bla bla bla',
              image:
                  'https://cdn.britannica.com/96/197396-131-0096D43E/ribeye-steak-beef-cow-meat.jpg'),
        );
      },
    );
  }
}
