import 'dart:math';

import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../data/user_datasource.dart';
import '../../helpers/helper.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';
import '../../routes/config_routes.dart';
import '../checkout/checkout.dart';
import '../profile/pages/orders_history.dart';
import 'pages/main.dart';
import 'pages/userpage.dart';
import 'pages/videos.dart';

ValueNotifier<int> selectedIndex = ValueNotifier(0);

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<_TabBarItem> get pages => [
        _TabBarItem(
          icon: FluentIcons.home_24_regular,
          label: S.current.home,
          page: const MainPage(),
        ),
        _TabBarItem(
          icon: FluentIcons.cart_24_filled,
          label: S.current.about,
          page: const SizedBox.shrink(),
        ),
        _TabBarItem(
          icon: FluentIcons.cart_24_filled,
          label: S.current.cart,
          page: const SizedBox.shrink(),
        ),
        _TabBarItem(
          icon: FluentIcons.video_24_regular,
          label: S.current.watch,
          page: const VideosPage(),
        ),
        _TabBarItem(
          icon: FluentIcons.person_24_regular,
          label: S.current.profile,
          page: UserPage(),
        ),
      ];

  void onPageChanged(int index) {
    setState(() => selectedIndex.value = index);
  }

  @override
  Widget build(BuildContext context) {
    if (kUser.status == 0 && kUser.level == UserLevel.merchant) {
      return _buildNotActive(context);
    }
    return WillPopScope(
        onWillPop: () => Helpers.onWillPop(context),
        child: Parent(
          style: ParentStyle()
            ..background.color(Colors.white)
            ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
          child: Scaffold(
            backgroundColor: Colors.white70,
            floatingActionButton: const WhatsappFloatingActionButton(),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
              child: FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRange(0, 2),
                    _buildCartButton(),
                    _buildRange(3, 5),
                  ],
                ),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: IndexedStack(
                          sizing: StackFit.expand,
                          alignment: Alignment.center,
                          index: selectedIndex.value,
                          children: [
                            ...pages.map((e) => e.page),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildRange(int min, int max) {
    final list = <Widget>[];
    for (var i = min; i < max; i++) {
      final isSelected = selectedIndex.value == i;
      final item = pages[i];

      if (item.label == S.current.cart) {
        list.add(_buildCartButton());
        continue;
      } else if (item.label == S.current.about) {
        list.add(_buildMessageButton());
        continue;
      }
      final tab = Parent(
        gesture: Gestures()
          ..onTap(() {
            if (!isSelected) onPageChanged(i);
          }),
        style: ParentStyle()
          ..animate(600, Curves.easeOut)
          ..width(isSelected ? 130 : 70)
          ..background.color(isSelected ? Colors.black87 : Colors.transparent)
          ..padding(
            horizontal: 20,
            vertical: 10,
          )
          ..borderRadius(all: 50)
          ..alignmentContent.center(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: Colors.amber,
            ),
            if (isSelected)
              Flexible(
                child: FittedBox(
                  child: Text(
                    '  ${item.label}',
                    style: const TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
      list.add(tab);
    }
    return Row(children: list);
  }

  Widget _buildMessageButton() => Parent(
        gesture: Gestures()
          ..onTap(() async {
            showDialog(
              context: context,
              builder: (context) => const WhoAreWeDialog(),
            );
          }),
        style: ParentStyle()
          ..animate(600, Curves.easeOut)
          ..width(70)
          ..background.color(Colors.transparent)
          ..padding(
            horizontal: 20,
            vertical: 10,
          )
          ..borderRadius(all: 50)
          ..alignmentContent.center(),
        child: const Icon(FontAwesomeIcons.shareAlt, color: Colors.amber),
      );

  Widget _buildCartButton() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CartCubit, CartState>(
          cubit: getIt<CartCubit>(),
          builder: (context, state) => FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              if (state.cart.cartItems.isNotEmpty) {
                AppRouter.sailor.navigate(CheckoutScreen.routeName);
              } else {
                Helpers.showMessageOverlay(
                  context,
                  message: S.current.dont_have_any_item_in_your_cart,
                );
              }
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  FluentIcons.cart_24_filled,
                  color: Colors.amber,
                ),
                if (state.cart.cartItems.isNotEmpty)
                  Positioned(
                    top: -20,
                    left: -20,
                    right: -20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox.fromSize(
                          size: const Size.fromRadius(14),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              '${state.cart.cartItems.length}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget _buildNotActive(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(20),
              color: Colors.white54,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  S.current.account_not_active_msg,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _buildButton(
                        label: Text(S.current.retry, style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal)),
                        onTap: () async {
                          final completer = Helpers.showLoading(context);
                          await getIt<IAuthRepository>().me();
                          setState(() {});
                          completer.complete();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _buildButton(
                        label: Text(S.current.log_out, style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white, fontWeight: FontWeight.normal)),
                        color: Colors.red,
                        onTap: () {
                          final action = CupertinoActionSheet(
                            title: Text(
                              S.current.log_out,
                              style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.amber),
                            ),
                            message: Text(
                              S.current.do_you_want_to_log_out_and_switch_account,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.amberAccent),
                            ),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () => getIt<AuthCubit>().unauthenticateUser(),
                                child: Text(
                                  S.current.yes,
                                  style: Theme.of(context).textTheme.button.copyWith(color: Colors.red),
                                ),
                              ),
                              CupertinoActionSheetAction(
                                isDefaultAction: true,
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(
                                  S.current.no,
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                S.current.cancel,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          );
                          showCupertinoModalPopup(context: context, builder: (context) => action);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    Widget label,
    Color color = Colors.amber,
    VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromRadius(20)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        backgroundColor: MaterialStateProperty.all(color.withOpacity(.9)),
      ),
      onPressed: onTap,
      child: FittedBox(child: label),
    );
  }
}

class WhatsappFloatingActionButton extends StatelessWidget {
  const WhatsappFloatingActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'WhatsappFloatingActionButton',
                onPressed: () {
                  launch('https://api.whatsapp.com/send?phone=966508808940');
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                child: SvgPicture.asset('assets/images/iconfinder-whatsapp-4550867_121343.svg'),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: 'PinnedOrdersFloatingActionButton',
                onPressed: () {
                  AppRouter.sailor.navigate(OrdersHistory.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/delivery.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabBarItem {
  final Widget page;
  final IconData icon;
  final String label;

  const _TabBarItem({this.page, this.icon, this.label});
}

class WhoAreWeDialog extends StatelessWidget {
  const WhoAreWeDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const aboutAr = '''
      شركة سهول شركة متخصصة في استيراد اللحوم السودانية من بيئتها الطبيعية بالسودان (سهول البطانة) الخضراء المترامية الاطراف حيث المراعي الطبيعية التي لا دخل ليد الإنسان فيها ..

وتصل يوميا طازجة بالطيران السعودي معتمدة من هيئة الغذاء والدواء السعودية لمعاملنا بشمال الرياض حيث نقوم بتجهيزها بأحدث الوسائل واعلى معايير الجودة والسلامة المهنية ويتم توصليها اليكم عبر اسطولنا المنتشر بجميع احياء الرياض ..''';

    const aboutEn = '''
      Sehool Company is a company specialized in importing Sudanese meat from its natural environment in Sudan (Butana Plains), the sprawling green pastures where the human hand has no control.

And they arrive daily fresh by Saudi aviation approved by the Saudi Food and Drug Authority for our laboratories in the north of Riyadh, where we supply them with the latest means and the highest standards of quality and occupational safety, and they are delivered to you through our fleet spread all over Riyadh.''';
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      contentPadding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.current.who_are_we),
                  InkWell(
                    onTap: () {
                      launchUrl('http://sehoool.com');
                    },
                    child: Text(
                      'sehoool.com',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildSocailIcons(context),
            ],
          ),
          const Divider(height: 5, thickness: 1, color: Colors.black),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Helpers.isArabic(context) ? aboutAr : aboutEn,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 10),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              String message;
              if (snapshot.hasData) {
                message = snapshot.data.version;
              } else {
                message = 'loading';
              }
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${S.current.about_msg_p1} $message ${S.current.about_msg_p2}',
                  style: Theme.of(context).textTheme.caption,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(),
                    Text(
                      '${S.current.contact_us_on_all_social_networks_at} @panda180sd',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      '${S.current.kingdom_of_saudi_arabia_riyadh} ${S.current.phone}: 00966508808940',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                trailing: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const AnimatedPandaLogo(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _buildSocailIcons(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => launchUrl('https://api.whatsapp.com/send?phone=966508808940'),
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(
                FontAwesomeIcons.whatsapp,
                size: 20,
                color: Color(0xFF20b038),
              ),
            ),
          ),
          InkWell(
            onTap: () => launchUrl('https://www.facebook.com/sehoool/'),
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(
                FontAwesomeIcons.facebook,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/snapchat.jpeg'),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(
                FontAwesomeIcons.snapchat,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
          InkWell(
            onTap: () => launchUrl('https://www.instagram.com/sehoool/'),
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(
                FontAwesomeIcons.instagram,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
          InkWell(
            onTap: () => launchUrl('https://twitter.com/sehoool/'),
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(
                FontAwesomeIcons.twitter,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedPandaLogo extends StatefulWidget {
  const AnimatedPandaLogo({
    Key key,
  }) : super(key: key);

  @override
  _AnimatedPandaLogoState createState() => _AnimatedPandaLogoState();
}

class _AnimatedPandaLogoState extends State<AnimatedPandaLogo> {
  CustomAnimationControl control = CustomAnimationControl.STOP;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          control = CustomAnimationControl.PLAY_FROM_START;
        });
      },
      child: CustomAnimation(
        control: control,
        tween: 0.0.tweenTo(pi * 2),
        curve: Curves.bounceOut,
        duration: 700.milliseconds,
        builder: (context, child, value) {
          return Transform.rotate(
            angle: value,
            child: child,
          );
        },
        child: Image.asset('assets/images/pp.jpg'),
      ),
    );
  }
}
