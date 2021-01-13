import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../init_injectable.dart';
import '../../cubits/lazy_list_cubit/lazy_list_cubit.dart';
import '../../models/lazy_list_model.dart';
import '../../models/product_model.dart';
import '../../models/video_model.dart';
import 'videos_carousel_item_widget.dart';
import 'videos_carousel_loading_item_widget.dart';

class VideosCarouselWidget extends StatefulWidget {
  const VideosCarouselWidget({
    Key key,
    @required this.videosList,
  }) : super(key: key);

  final List<ProductModel> videosList;

  @override
  _VideosCarouselWidgetState createState() => _VideosCarouselWidgetState();
}

class _VideosCarouselWidgetState extends State<VideosCarouselWidget> {
  LazyListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<LazyListCubit>()..getContent(LazyListType.videos);
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

  CarouselSlider _buildUI(
    List videosList, {
    bool isLoading = false,
  }) {
    // TODO: add lazy load more
    return CarouselSlider.builder(
      itemCount: isLoading ? videosList.length + 5 : videosList.length,
      itemBuilder: (context, index) {
        if (index >= videosList.length) {
          return const VideosCarouselLoadingItemWidget();
        } else {
          return VideosCarouselItemWidget(
            video: videosList.elementAt(index),
          );
        }
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
        aspectRatio: 1,
        viewportFraction: .6,
      ),
    );
  }
}
