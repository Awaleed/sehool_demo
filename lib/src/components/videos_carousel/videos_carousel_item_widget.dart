import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../models/video_model.dart';

class VideosCarouselItemWidget extends StatelessWidget {
  const VideosCarouselItemWidget({
    Key key,
    @required this.video,
    @required this.play,
    @required this.chewieController,
  }) : super(key: key);

  final VideoModel video;
  final bool play;
  final ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            VideoApp(
              controller: chewieController,
              video: video,
              play: play,
            ),
            // IgnorePointer(
            //   child: Container(
            //     padding: const EdgeInsets.only(bottom: 50, top: 20),
            //     decoration: BoxDecoration(
            //       color: Colors.black38,
            //       borderRadius: BorderRadius.circular(25),
            //       gradient: const LinearGradient(
            //         begin: Alignment.bottomCenter,
            //         end: Alignment.topCenter,
            //         colors: [
            //           Colors.black,
            //           Colors.transparent,
            //           Colors.transparent,
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // if (video.description != null)
            //   Positioned(
            //     left: 0,
            //     right: 0,
            //     bottom: 35,
            //     child: IgnorePointer(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Text(
            //             video.description,
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .subtitle2
            //                 .copyWith(color: Colors.white),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
        
          ],
        ),
      ),
    );
  }
}

class VideoApp extends StatelessWidget {
  final VideoModel video;
  final bool play;
  final ChewieController controller;

  const VideoApp({Key key, this.video, this.play, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ? Container(
                      child: controller.videoPlayerController.value.initialized
                          ? IgnorePointer(child: Chewie(controller: controller))
                          : Center(
                              child: Container(
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
            if (!controller.videoPlayerController.value.initialized ||
                controller.videoPlayerController.value.isBuffering)
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                ),
              )
            else if (play) ...[
              StatefulBuilder(
                builder: (context, setState) => InkWell(
                  onTap: () {
                    if (controller.videoPlayerController.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }
                    setState(() {});
                  },
                  child: AnimatedOpacity(
                    // opacity: controller.videoPlayerController.value.isPlaying
                    //     ? 0
                    //     : 1,
                    opacity: 0,
                    duration: 500.milliseconds,
                    child: Center(
                      child: Container(
                        constraints:
                            BoxConstraints.loose(const Size.fromRadius(50)),
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.pause,
                            color: Colors.amber,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Row(
                  children: [
                    FloatingActionButton(
                      heroTag: video,
                      elevation: 0,
                      onPressed: () {
                        controller.enterFullScreen();
                      },
                      child: const Icon(Icons.fullscreen),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),

      // ),
      // floatingActionButton: IconButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.videoPlayerController.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   icon: Icon(
      //     _controller.videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
