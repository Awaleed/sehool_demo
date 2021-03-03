import 'package:flutter/material.dart';

import '../../../components/videos_carousel/videos_carousel_widget.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: VideosCarouselWidget(),
    );
  }
}
