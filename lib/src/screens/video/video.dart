import 'package:chewie/chewie.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../cubits/product_cubits/video_cubit/video_cubit.dart';
import '../../models/video_model.dart';
// import '../../patched_components/custom_material_controls.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/video';

  const VideoScreen({
    Key key,
    this.video,
    this.cubit,
  }) : super(key: key);

  final VideoModel video;
  final VideoCubit cubit;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  double _aspectRatio;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.video.video)
      ..addListener(() {
        _chewieController = ChewieController(
          allowedScreenSleep: false,
          deviceOrientationsAfterFullScreen: [
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
          videoPlayerController: _videoPlayerController,
          aspectRatio: _aspectRatio,
          autoInitialize: true,
          autoPlay: true,
          // customControls: const CustomMat/erialControls(),
        );
        setState(() {});
      });
    _aspectRatio = _videoPlayerController.value.aspectRatio;
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      // customControls: const CustomMaterialControls(),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                gradient: RadialGradient(
                  colors: [
                    Colors.black.withOpacity(.93),
                    Colors.black.withOpacity(.95),
                  ],
                ),
              ),
            ),
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Chewie(
                controller: _chewieController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
