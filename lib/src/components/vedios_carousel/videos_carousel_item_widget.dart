import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:video_player/video_player.dart';

import '../../models/video_model.dart';

class VideosCarouselItemWidget extends StatelessWidget {
  const VideosCarouselItemWidget({
    Key key,
    @required this.video,
    @required this.play,
    @required this.controller,
  }) : super(key: key);

  final VideoModel video;
  final bool play;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Hero(
            tag: 'image${video.id}',
            createRectTween: (begin, end) => RectTween(begin: begin, end: end),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: VideoApp(
                controller: controller,
                video: video,
                play: play,
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: Container(
            padding: const EdgeInsets.only(bottom: 50, top: 20),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 35,
          child: IgnorePointer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Text(
                    video.title,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  video.description,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),

        // Positioned(
        //   bottom: -30,
        //   height: 60,
        //   left: 30,
        //   right: 30,
        //   child: TextButton(
        //     onPressed: () {},
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(Colors.black),
        //       overlayColor:
        //           MaterialStateProperty.all(Colors.amber.withOpacity(.3)),
        //       shape: MaterialStateProperty.all(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(25),
        //         ),
        //       ),
        //     ),
        //     child: Text(
        //       S.current.add_to_cart,
        //       style: const TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class VideoApp extends StatelessWidget {
  final VideoModel video;
  final bool play;
  final VideoPlayerController controller;

  const VideoApp({Key key, this.video, this.play, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   AppRouter.sailor.navigate(
      //     VideoScreen.routeName,
      //     params: {'video': video},
      //   );
      // },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomAnimation<double>(
          control: play
              ? CustomAnimationControl.PLAY
              : CustomAnimationControl.PLAY_REVERSE,
          tween: 0.0.tweenTo(1.0),
          duration: 500.milliseconds,
          curve: Curves.easeOut,
          builder: (context, child, value) => Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: value,
                child: play
                    ? Center(
                        child: controller.value.initialized
                            ? AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: VideoPlayer(controller),
                              )
                            : Container(
                                margin: const EdgeInsets.only(
                                    left: 40.0, right: 40.0),
                                decoration: const BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0),
                                ),
                              ),
                      )
                    : CachedNetworkImage(
                        imageUrl: video.preview,
                        fit: BoxFit.cover,
                      ),
              ),
              Opacity(
                opacity: 1 - value,
                child: CachedNetworkImage(
                  imageUrl: video.preview,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

        // ),
        // floatingActionButton: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       _controller.value.isPlaying
        //           ? _controller.pause()
        //           : _controller.play();
        //     });
        //   },
        //   icon: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //   ),
        // ),
      ),
    );
  }
}
