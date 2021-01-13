import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../cubits/lazy_list_cubit/lazy_list_cubit.dart';
import '../../patched_components/custom_material_controls.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/video';

  const VideoScreen({
    Key key,
    this.heroTag,
    this.cubit,
  }) : super(key: key);

  final String heroTag;
  final LazyListCubit cubit;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  double _aspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();

    // print(
    //     'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    SystemChrome.setEnabledSystemUIOverlays([]);
    _videoPlayerController = VideoPlayerController.network(
      'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4',
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
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
      showControls: true,
      customControls: CustomMaterialControls(),
      // overlay: Placeholder(),
    );

    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
    );
  }
}
