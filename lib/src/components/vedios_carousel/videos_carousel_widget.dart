import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../init_injectable.dart';
import '../../cubits/lazy_list_cubit/lazy_list_cubit.dart';
import '../../models/lazy_list_model.dart';
import 'empty_videos_carousel.dart';
import 'videos_carousel_item_widget.dart';
import 'videos_carousel_loading_item_widget.dart';

class VideosCarouselWidget extends StatefulWidget {
  const VideosCarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  _VideosCarouselWidgetState createState() => _VideosCarouselWidgetState();
}

class _VideosCarouselWidgetState extends State<VideosCarouselWidget> {
  LazyListCubit cubit;
  int currentItem = 0;

  Map<String, VideoPlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    cubit = getIt<LazyListCubit>()..getContent(LazyListType.videos);
    _controllers = {};
  }

  @override
  void dispose() {
    cubit.close();
    for (final _controller in _controllers.values) {
      _controller.pause();
      _controller.dispose();
    }
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
    List videosList, {
    bool isLoading = false,
  }) {
    if (videosList.isEmpty && !isLoading) {
      return const EmptyVideosCarousel();
    }
    return CarouselSlider.builder(
      itemCount: isLoading ? videosList.length + 5 : videosList.length,
      itemBuilder: (context, index) {
        if (index >= videosList.length) {
          return const VideosCarouselLoadingItemWidget();
        } else {
          if (Platform.isWindows) {
            return Center(
                child: Text(
              'Video play back is not supported',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ));
          }
          final video = videosList.elementAt(index);
          VideoPlayerController _controller = _controllers[video.video];
          if (_controller == null) {
            _controller = VideoPlayerController.network(video.video)
              ..initialize().then((_) {
                setState(() {});
              });

            _controllers[video.video] = _controller;
          }

          final play = currentItem == index;
          if (play) {
            _controller.play();
          } else {
            _controller.pause();
          }
          print('play: $play');
          print(video);
          return VideosCarouselItemWidget(
            play: play,
            controller: _controller,
            video: video,
          );
        }
      },
      options: CarouselOptions(
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
        aspectRatio: 1,
        viewportFraction: .6,
        onPageChanged: (index, reason) {
          setState(() {
            currentItem = index;
          });
        },
      ),
    );
  }
}
