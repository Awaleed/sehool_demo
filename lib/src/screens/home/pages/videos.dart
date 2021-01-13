import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../routes/config_routes.dart';
import '../../video/video.dart';

import '../../../components/vedios_carousel/videos_carousel_widget.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: VideosCarouselWidget(),
    );
  }
}
