import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

class EmptyVideosCarousel extends StatelessWidget {
  const EmptyVideosCarousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Theme.of(context).focusColor.withOpacity(0.7),
                        Theme.of(context).focusColor.withOpacity(0.05),
                      ])),
              child: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).scaffoldBackgroundColor,
                size: 70,
              ),
            ),
            const SizedBox(height: 15),
            Opacity(
              opacity: 0.4,
              child: Text(S.of(context).no_suggestions,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .merge(const TextStyle(fontWeight: FontWeight.w300)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
