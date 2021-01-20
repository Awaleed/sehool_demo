import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../init_injectable.dart';
import '../../../components/products_carousel/products_carousel_widget.dart';
import '../../../cubits/product_cubits/banner_cubit/banner_cubit.dart';
import '../../../models/banner_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BannerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<BannerCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<BannerCubit, BannerState>(
          cubit: cubit,
          builder: (context, state) {
            return state.when(
              loading: () => _buildBanner([], isLoading: true),
              success: (values) => _buildBanner(values),

              //TODO: handel ERRORS
              failure: (message) => throw UnimplementedError(),
            );
          },
        ),
        const Expanded(child: ProductsCarouselWidget()),
      ],
    );
  }

  Widget _buildBanner(List<BannerModel> values, {bool isLoading = false}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(8.0),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
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
