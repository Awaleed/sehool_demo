import 'package:animations/animations.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/helpers/helper.dart';
import '../../home/home.dart';
import 'package:supercharged/supercharged.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/l10n.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final aboutAr = '''شركة سهول شركة متخصصة في استيراد اللحوم السودانية من بيئتها الطبيعية بالسودان (سهول البطانة) الخضراء المترامية الاطراف حيث المراعي الطبيعية التي لا دخل ليد الإنسان فيها ..

وتصل يوميا طازجة بالطيران السعودي معتمدة من هيئة الغذاء والدواء السعودية لمعاملنا بشمال الرياض حيث نقوم بتجهيزها بأحدث الوسائل واعلى معايير الجودة والسلامة المهنية ويتم توصليها اليكم عبر اسطولنا المنتشر بجميع احياء الرياض ..''';

  final aboutEn = '''Sehool Company is a company specialized in importing Sudanese meat from its natural environment in Sudan (Butana Plains), the sprawling green pastures where the human hand has no control.

And they arrive daily fresh by Saudi aviation approved by the Saudi Food and Drug Authority for our laboratories in the north of Riyadh, where we supply them with the latest means and the highest standards of quality and occupational safety, and they are delivered to you through our fleet spread all over Riyadh.''';

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
          floatingActionButton: WhatsappFloatingActionButton(),
          backgroundColor: Colors.white70,
          appBar: AppBar(
            backgroundColor: Colors.black54,
            elevation: 0,
            title: Text(
              S.current.about,
              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              S.current.who_are_we,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Helpers.isArabic(context) ? aboutAr : aboutEn,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AboutItem(
                      icon: FontAwesomeIcons.whatsapp,
                      title: 'Whatsapp',
                      onTap: () {
                        launch('https://api.whatsapp.com/send?phone=966508808940');
                      },
                      description: 'Whatsapp',
                    ),
                    AboutItem(
                      icon: FontAwesomeIcons.snapchat,
                      title: 'SnapChat',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.black54,
                            child: Image.asset('assets/images/snapchat.jpeg'),
                          ),
                        );
                      },
                      description: 'SnapChat',
                    ),
                    AboutItem(
                      icon: FontAwesomeIcons.instagram,
                      title: 'Instagram',
                      onTap: () => launchUrl('https://www.instagram.com/sehoool/'),
                      description: 'Instagram',
                    ),
                    AboutItem(
                      icon: FontAwesomeIcons.facebook,
                      title: 'Facebook',
                      onTap: () => launchUrl('https://www.facebook.com/sehoool/'),
                      description: 'Facebook',
                    ),
                    AboutItem(
                      icon: FontAwesomeIcons.twitter,
                      title: 'Twitter',
                      onTap: () => launchUrl('https://twitter.com/sehoool/'),
                      description: 'Twitter',
                    ),
                  ],
                ),
              ),
              Txt(
                '❤ Made in Panda180 with love ❤',
                style: TxtStyle()
                  ..textColor(Colors.black)
                  ..alignment.center(),
              )
            ],
          ),
        ));
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class AboutItem extends StatefulWidget {
  const AboutItem({
    this.icon,
    this.iswarrning = false,
    this.title,
    this.target,
    this.description,
    this.onTap,
    this.onRefresh,
  });

  final IconData icon;
  final bool iswarrning;
  final String title;
  final Widget target;
  final String description;
  final VoidCallback onTap;
  final VoidCallback onRefresh;

  @override
  _AboutItemState createState() => _AboutItemState();
}

class _AboutItemState extends State<AboutItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionDuration: 800.milliseconds,
      openBuilder: (context, action) => widget.target,
      closedColor: Colors.transparent,
      tappable: false,
      closedElevation: 0,
      openElevation: 0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      openColor: Colors.transparent,
      closedBuilder: (context, action) {
        return Parent(
          style: aboutItemStyle(pressed: pressed),
          gesture: Gestures()
            ..isTap((isTapped) {
              setState(() => pressed = isTapped);
            })
            ..onTap(() {
              widget.target == null ? widget.onTap() : action();
            }),
          child: Row(
            children: <Widget>[
              Parent(
                style: aboutItemIconStyle(iswarrning: widget.iswarrning),
                child: Icon(widget.icon, color: widget.iswarrning ? Colors.red : Colors.amber, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Txt(
                    widget.title,
                    style: itemTitleTextStyle(
                      iswarrning: widget.iswarrning,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Txt(
                    widget.description,
                    style: itemDescriptionTextStyle,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  ParentStyle aboutItemStyle({bool pressed}) => ParentStyle()
    ..elevation(pressed ? 0 : 50, color: Colors.grey)
    ..scale(pressed ? 0.90 : 1.0)
    ..alignmentContent.center()
    ..height(70)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..background.hex('#ffffff')
    ..ripple(true)
    ..animate(150, Curves.easeInOut);

  ParentStyle aboutItemIconStyle({bool iswarrning}) => ParentStyle()
    ..background.color(iswarrning ? Colors.red.withOpacity(.1) : Colors.amber.withOpacity(.1))
    ..margin(horizontal: 15)
    ..padding(all: 12)
    ..borderRadius(all: 30);

  TxtStyle itemTitleTextStyle({bool iswarrning}) => TxtStyle()
    ..bold()
    ..textColor(iswarrning ? Colors.red : Colors.amber)
    ..fontSize(16);

  final TxtStyle itemDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.black26)
    ..bold()
    ..fontSize(12);
}
