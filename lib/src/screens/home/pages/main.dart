import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/src/cubits/lazy_list_cubit/lazy_list_cubit.dart';
import 'package:sehool/src/helpers/fake_data_generator.dart';
import 'package:sehool/src/models/banner_model.dart';
import 'package:sehool/src/models/lazy_list_model.dart';

import '../../../../init_injectable.dart';
import '../../../components/products_carousel/products_carousel_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LazyListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<LazyListCubit>()..getContent(LazyListType.banners);
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
        BlocBuilder<LazyListCubit, LazyListState>(
          cubit: cubit,
          builder: (context, state) {
            return state.when(
              initial: () => _buildBanner([], isLoading: true),
              loading: () => _buildBanner([], isLoading: true),
              loadingMore: (values) => _buildBanner(values, isLoading: true),
              success: (values) => _buildBanner(values),
              finished: (values) => _buildBanner(values),

              //TODO: handel ERRORS
              failure: (message, values) => throw UnimplementedError(),
              failureOnLoadMore: (message, values) =>
                  throw UnimplementedError(),
            );
          },
        ),
        const Expanded(child: ProductsCarouselWidget()),
      ],
    );
  }

  Widget _buildBanner(List values, {bool isLoading = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: values.isEmpty && isLoading
            ? const Center(child: CircularProgressIndicator())
            : CachedNetworkImage(
                imageUrl: 
                FakeDataGenerator.images.random,
                // TODO: Fix me
                    // 'https://i.pinimg.com/originals/29/6a/4d/296a4d4d6bd75d9154721df9055c72a2.gif' ??
                        // values?.first?.image,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
extension on List {
  get random => this[Random().nextInt(this.length)];
}
