import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../init_injectable.dart';
import '../../../components/my_error_widget.dart';
import '../../../components/products_carousel/products_carousel_widget.dart';
import '../../../cubits/product_cubits/banner_cubit/banner_cubit.dart';
import '../../../cubits/product_cubits/product_cubit/product_cubit.dart';
import '../../../models/banner_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BannerCubit cubit;
  ProductCubit productCubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<BannerCubit>();
    productCubit = getIt<ProductCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    productCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        cubit.getBanners();
        await productCubit.getProducts();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<BannerCubit, BannerState>(
              cubit: cubit,
              builder: (context, state) {
                return state.when(
                  loading: () => _buildBanner([], isLoading: true),
                  success: (values) => _buildBanner(values),
                  failure: (message) => MyErrorWidget(
                    onRetry: () {
                      cubit.getBanners();
                    },
                    message: message,
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: ProductsCarouselWidget(cubit: productCubit),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(List<BannerModel> values, {bool isLoading = false}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      height: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: values.isEmpty && isLoading
          ? const Center(child: CircularProgressIndicator())
          : CarouselSlider.builder(
              itemCount: values.length,
              itemBuilder: (_, index) => CachedNetworkImage(
                imageUrl: values[index].image,
                fit: BoxFit.cover,
              ),
              options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: MediaQuery.of(context).size.width / 250,
                autoPlay: true,
              ),
            ),
    );
  }
}
