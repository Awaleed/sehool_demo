import 'package:flutter/material.dart';

import '../../../components/videos_carousel/videos_carousel_widget.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 100,
            width: 100,
          ),
          const Expanded(child: VideosCarouselWidget()),
        ],
      ),
    );
  }
}
