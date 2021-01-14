import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:video_player/video_player.dart';

import '../../models/video_model.dart';
import '../../routes/config_routes.dart';
import '../../screens/video/video.dart';
import 'package:supercharged/supercharged.dart';

class VideosCarouselItemWidget extends StatelessWidget {
  const VideosCarouselItemWidget({
    Key key,
    @required this.video,
    @required this.play,
  }) : super(key: key);

  final VideoModel video;
  final bool play;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.sailor.navigate(
        VideoScreen.routeName,
        params: {'video': video},
      ),
      child: Stack(
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
              createRectTween: (begin, end) =>
                  RectTween(begin: begin, end: end),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CustomAnimation<double>(
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
                            ? VideoApp(url: video.video)
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
              ),
            ),
          ),
          Container(
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 35,
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
      ),
    );
  }
}

class VideoApp extends StatefulWidget {
  final String url;

  const VideoApp({Key key, this.url}) : super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        icon: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
