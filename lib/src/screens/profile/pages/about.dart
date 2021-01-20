import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Parent(
        style: ParentStyle()
          ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              S.current.about,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(),
              ),
              Txt(
                '❤Made in Panda180 with love❤',
                style: TxtStyle()
                  ..textColor(Colors.white)
                  ..alignment.center(),
              )
            ],
          ),
        ));
  }
}
