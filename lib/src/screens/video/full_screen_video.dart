// import 'package:chewie/chewie.dart';
// import 'package:division/division.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';

// import '../../patched_components/custom_material_controls.dart';

// class FullScreenVideoScreen extends StatefulWidget {
//   static const routeName = '/full_screen_video';

//   const FullScreenVideoScreen({
//     Key key,
//     this.videoController,
//   }) : super(key: key);

//   final VideoPlayerController videoController;

//   @override
//   _FullScreenVideoScreenState createState() => _FullScreenVideoScreenState();
// }

// class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
//   VideoPlayerController _videoPlayerController;
//   // ChewieController _chewieController;
//   // double _aspectRatio;

//   @override
//   void initState() {
//     super.initState();

//     // print(
//     //     'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
//     _videoPlayerController =
//         //  VideoPlayerController.network('http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
//         widget.videoController
//           ..addListener(() {
//             // _chewieController = ChewieController(
//             //   allowedScreenSleep: false,
//             //   deviceOrientationsAfterFullScreen: [
//             //     DeviceOrientation.landscapeRight,
//             //     DeviceOrientation.landscapeLeft,
//             //     DeviceOrientation.portraitUp,
//             //     DeviceOrientation.portraitDown,
//             //   ],
//             //   videoPlayerController: _videoPlayerController,
//             //   aspectRatio: _aspectRatio,
//             //   autoInitialize: true,
//             //   autoPlay: true,
//             //   customControls: const CustomMaterialControls(),
//             //   // overlay: Placeholder(),
//             // );
//             // setState(() {});
//           });
//     // _aspectRatio = _videoPlayerController.value.aspectRatio;
//     // SystemChrome.setPreferredOrientations([
//     //   DeviceOrientation.landscapeRight,
//     //   DeviceOrientation.landscapeLeft,
//     //   DeviceOrientation.portraitUp,
//     //   DeviceOrientation.portraitDown,
//     // ]);
//     // _chewieController = ChewieController(
//     //   allowedScreenSleep: false,
//     //   deviceOrientationsAfterFullScreen: [
//     //     DeviceOrientation.landscapeRight,
//     //     DeviceOrientation.landscapeLeft,
//     //     DeviceOrientation.portraitUp,
//     //     DeviceOrientation.portraitDown,
//     //   ],
//     //   videoPlayerController: _videoPlayerController,
//     //   aspectRatio: _aspectRatio,
//     //   autoInitialize: true,
//     //   autoPlay: true,
//     //   customControls: const CustomMaterialControls(),
//     //   // overlay: Placeholder(),
//     // );

//     // _chewieController.addListener(() {
//     //   if (_chewieController.isFullScreen) {
//     //     SystemChrome.setPreferredOrientations([
//     //       DeviceOrientation.landscapeRight,
//     //       DeviceOrientation.landscapeLeft,
//     //     ]);
//     //   } else {
//     //     SystemChrome.setPreferredOrientations([
//     //       DeviceOrientation.portraitUp,
//     //       DeviceOrientation.portraitDown,
//     //     ]);
//     //   }
//     // });
//   }

//   @override
//   void dispose() {
//     // _videoPlayerController.dispose();
//     // _chewieController.dispose();
//     // SystemChrome.setEnabledSystemUIOverlays([
//     //   SystemUiOverlay.top,
//     //   SystemUiOverlay.bottom,
//     // ]);

//     // SystemChrome.setPreferredOrientations([
//     //   DeviceOrientation.portraitUp,
//     //   DeviceOrientation.portraitDown,
//     // ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           DecoratedBox(
//             decoration: BoxDecoration(
//               color: Colors.black,
//               gradient: RadialGradient(
//                 colors: [
//                   Colors.black.withOpacity(.93),
//                   Colors.black.withOpacity(.95),
//                 ],
//               ),
//             ),
//           ),
//           PageView.builder(
//               scrollDirection: Axis.vertical,
//               itemBuilder: (context, index) =>
//                   VideoPlayer(_videoPlayerController)
//               //  Chewie(controller: _chewieController),
//               ),
//         ],
//       ),
//     );
//   }
// }

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoScreen extends StatefulWidget {
  static const routeName = '/full_screen_video';

  const FullScreenVideoScreen({
    Key key,
    @required this.videoController,
  }) : super(key: key);

  final VideoPlayerController videoController;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenVideoScreenState();
  }
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: _chewieController != null &&
                      _chewieController.videoPlayerController.value.initialized
                  ? Chewie(
                      controller: _chewieController,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
            ),
          ),
          TextButton(
            onPressed: () {
              _chewieController.enterFullScreen();
            },
            child: const Text('Fullscreen'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController1.pause();
                      _videoPlayerController1.seekTo(const Duration());
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController1,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Landscape Video"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController2.pause();
                      _videoPlayerController2.seekTo(const Duration());
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController2,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Portrait Video"),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      // _platform = TargetPlatform.android;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Android controls"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      // _platform = TargetPlatform.iOS;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("iOS controls"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
