import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key key}) : super(key: key);

  @override
  _HelpAndSupportState createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        // ..linearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Colors.black,
        //     Colors.amber,
        //     Colors.black,
        //   ],
        // ),
        ..background.color(Colors.white)
        ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            S.current.help_support,
            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
          ),
        ),
        body: Column(),
      ),
    );
  }
}
