import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/product_cubits/product_cubit/product_cubit.dart';
import '../my_error_widget.dart';
import 'empty_products_carousel.dart';
import 'products_carousel_item_widget.dart';
import 'products_carousel_loading_item_widget.dart';

class ProductsCarouselWidget extends StatelessWidget {
  const ProductsCarouselWidget({
    Key key,
    @required this.cubit,
  }) : super(key: key);

  final ProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      cubit: cubit,
      builder: (context, state) {
        return state.when(
          loading: () => _buildUI([], isLoading: true),
          success: (values) => _buildUI(values),
          failure: (message) => MyErrorWidget(
            onRetry: () {
              cubit.getProducts();
            },
            message: message,
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CarouselSlider.builder(
        itemCount: isLoading ? productsList.length + 5 : productsList.length,
        itemBuilder: (context, index) {
          if (index >= productsList.length) {
            return const ProductsCarouselLoadingItemWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ProductsCarouselItemWidget(
                product: productsList.elementAt(index),
              ),
            );
          }
        },
        options: CarouselOptions(
          enableInfiniteScroll: false,
          height: 400,
          enlargeCenterPage: true,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
