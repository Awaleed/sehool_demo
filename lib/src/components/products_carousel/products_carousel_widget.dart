import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../init_injectable.dart';
import '../../cubits/lazy_list_cubit/lazy_list_cubit.dart';
import '../../models/lazy_list_model.dart';
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
  LazyListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<LazyListCubit>()..getContent(LazyListType.products);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LazyListCubit, LazyListState>(
      cubit: cubit,
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI([], isLoading: true),
          loading: () => _buildUI([], isLoading: true),
          loadingMore: (values) => _buildUI(values, isLoading: true),
          success: (values) => _buildUI(values),
          finished: (values) => _buildUI(values),

          //TODO: handel ERRORS
          failure: (message, values) => throw UnimplementedError(),
          failureOnLoadMore: (message, values) => throw UnimplementedError(),
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
        // aspectRatio: 9 / 12,
        // viewportFraction: .5,
        enableInfiniteScroll: false,
        height: 400,
        enlargeCenterPage: true,
      ),
    );
  }
}
