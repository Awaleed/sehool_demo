import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';

class CommentsListLoadingItemWidget extends StatelessWidget {
  const CommentsListLoadingItemWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Card(
              color: Colors.white70,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          const Positioned(
            right: 0,
            top: -10,
            child: CircleAvatar(
              radius: 30,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
