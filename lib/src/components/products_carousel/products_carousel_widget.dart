import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../init_injectable.dart';
import '../../cubits/product_cubits/product_cubit/product_cubit.dart';
import 'empty_products_carousel.dart';
import 'products_carousel_item_widget.dart';
import 'products_carousel_loading_item_widget.dart';

class ProductsCarouselWidget extends StatefulWidget {
  const ProductsCarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  _ProductsCarouselWidgetState createState() => _ProductsCarouselWidgetState();
}

class _ProductsCarouselWidgetState extends State<ProductsCarouselWidget> {
  ProductCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<ProductCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      cubit: cubit,
      builder: (context, state) {
        return state.when(
          loading: () => _buildUI([], isLoading: true),
          success: (values) => _buildUI(values),

          //TODO: handel ERRORS
          failure: (message) => throw UnimplementedError(),
        );
      },
    );
  }

  Widget _buildUI(
    List productsList, {
    bool isLoading = false,
  }) {
    if (productsList.isEmpty && !isLoading) {
      return const EmptyProductsCarousel();
    }
    return CarouselSlider.builder(
      itemCount: isLoading ? productsList.length + 5 : productsList.length,
      itemBuilder: (context, index) {
        if (index >= productsList.length) {
          return const ProductsCarouselLoadingItemWidget();
        } else {
          return ProductsCarouselItemWidget(
            product: productsList.elementAt(index),
          );
        }
      },
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: 400,
        enlargeCenterPage: true,
      ),
    );
  }
}
