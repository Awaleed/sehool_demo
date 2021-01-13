import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/products_carousel/products_carousel_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
        ),
        const Expanded(child: ProductsCarouselWidget()),
      ],
    );
  }
}
