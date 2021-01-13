import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/components/products_carousel/products_carousel_widget.dart';
import 'package:sehool/src/helpers/fake_data_generator.dart';
import 'package:sehool/src/models/product_model.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/cart/add_to_cart.dart';
import 'package:sehool/src/screens/product/product.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../generated/l10n.dart';

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
