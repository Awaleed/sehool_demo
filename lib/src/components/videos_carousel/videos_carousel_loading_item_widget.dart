import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class VideosCarouselLoadingItemWidget extends StatelessWidget {
  const VideosCarouselLoadingItemWidget({Key key}) : super(key: key);

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Colors.black,
          child: Container(
            padding: const EdgeInsets.only(bottom: 50, top: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.amber,
                ],
              ),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 35,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: add localization
              Text(
                '${S.current.please_wait}...',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
