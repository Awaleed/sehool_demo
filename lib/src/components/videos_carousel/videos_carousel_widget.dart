import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';
import 'package:video_player/video_player.dart';

import '../../../init_injectable.dart';
import '../../cubits/product_cubits/video_cubit/video_cubit.dart';
import '../../models/video_model.dart';
import '../../screens/home/home.dart';
import '../my_error_widget.dart';
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
  VideoCubit cubit;
  int currentItem = 0;
  Map<int, VideoPlayerController> _controllers;
  bool canPlay = false;

  @override
  void initState() {
    super.initState();
    cubit = getIt<VideoCubit>();
    _controllers = {};
    selectedIndex.addListener(onPageChange);
  }

  @override
  void dispose() {
    cubit.close();
    selectedIndex.removeListener(onPageChange);
    for (final _controller in _controllers.values) {
      _controller.pause();
      _controller.dispose();
    }
    super.dispose();
  }

  void onPageChange() {
    if (selectedIndex.value != 3) {
      setState(() => canPlay = false);
      for (final _controller in _controllers.values) {
        _controller?.pause();
        _controller?.seekTo(0.seconds);
      }
    } else {
      setState(() => canPlay = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        for (final _controller in _controllers.values) {
          await _controller.pause();
          await _controller.seekTo(0.seconds);
        }
        return cubit.getVideos();
      },
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<VideoCubit, VideoState>(
              cubit: cubit,
              builder: (context, state) {
                return state.when(
                  loading: () => _buildUI([], isLoading: true),
                  success: (values) => _buildUI(values),
                  failure: (message) => MyErrorWidget(
                    onRetry: () {
                      cubit.getVideos();
                    },
                    message: message,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUI(
    List<VideoModel> videosList, {
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
          if (!canPlay) return const SizedBox.shrink();

          if (Platform.isWindows) {
            return Center(
                child: Text(
              'Video play back is not supported',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ));
          }
          final video = videosList.elementAt(index);
          VideoPlayerController _controller = _controllers[video.id];
          if (_controller == null) {
            _controller = VideoPlayerController.network(video.video)
              ..initialize().then((_) {
                _controller.setLooping(true);
                setState(() {});
              });
            _controllers[video.id] = _controller;
          }

          final play = currentItem == index;
          if (_controller.value.initialized) {
            if (play && !_controller.value.isPlaying) {
              _controller.play();
            } else if (!play) {
              _controller.pause().then((value) {
                _controller.seekTo(0.seconds);
              });
            }
          }
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
        // scrollDirection: Axis.vertical,
        aspectRatio: 1,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          setState(() {
            currentItem = index;
          });
        },
      ),
    );
  }
}
