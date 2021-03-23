import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supercharged/supercharged.dart';
import 'package:validators/validators.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../data/user_datasource.dart';
import '../../../helpers/helper.dart';
import '../../../models/user_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../profile/pages/addresses.dart';
import '../../profile/pages/orders_history.dart';
import '../../profile/profile_settings.dart';

class UserPage extends StatelessWidget {
  ParentStyle contentStyle(BuildContext context) => ParentStyle()
    ..overflow.scrollable()
    ..padding(vertical: 30, horizontal: 20)
    ..minHeight(MediaQuery.of(context).size.height - (2 * 30));

  final titleStyle = TxtStyle()
    ..bold()
    ..fontSize(32)
    ..textColor(Colors.black)
    ..margin(bottom: 20);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(userBoxName).listenable(),
        builder: (BuildContext context, dynamic value, Widget child) {
          if (kUser == null) {
            return Container();
          } else {
            return Parent(
              style: contentStyle(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Txt(S.current.profile, style: titleStyle),
                  UserCard(),
                  const Settings(),
                ],
              ),
            );
          }
        });
  }
}

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  Widget _buildUserRow() {
    return Row(
      children: <Widget>[
        Parent(
          style: userImageStyle,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: isURL(kUser.image) ? CachedNetworkImageProvider(kUser.image) : const AssetImage('assets/img/user.png'),
            onBackgroundImageError: (exception, stackTrace) => const Center(
              child: Icon(Icons.not_interested),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt(kUser.name, style: nameTextStyle),
            const SizedBox(height: 5),
            Txt(
              (kUser.level == UserLevel.merchant) ? S.current.merchant : S.current.customer,
              style: nameDescriptionTextStyle,
            )
          ],
        )
      ],
    );
  }

  Widget _buildUserStats() {
    return Parent(
      style: userStatsStyle,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildUserStatsItem(kUser.email, FluentIcons.mail_24_regular),
              _buildUserStatsItem(kUser.phone, FluentIcons.phone_24_regular),
            ],
          ),
          if (kUser.level == UserLevel.merchant)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildUserStatsItem(
                  '${kUser.wallet} ﷼',
                  FluentIcons.money_24_regular,
                  () async {
                    final completer = Helpers.showLoading(context);
                    await getIt<IAuthRepository>().me();
                    setState(() {});
                    completer.complete();
                  },
                ),
                _buildUserStatsItem(kUser.storeName, Icons.store),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildUserStatsItem(String value, IconData icon, [Function() onTap]) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(height: 5),
            Txt(value, style: nameDescriptionTextStyle),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: userCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildUserRow(),
          _buildUserStats(),
        ],
      ),
    );
  }

  final ParentStyle userCardStyle = ParentStyle()
    ..padding(horizontal: 20.0, vertical: 10)
    ..alignment.center()
    ..background.color(Colors.amber)
    ..borderRadius(all: 20.0)
    ..elevation(10, color: Colors.amber);

  final ParentStyle userImageStyle = ParentStyle()
    ..height(50)
    ..width(50)
    ..margin(horizontal: 10.0)
    ..borderRadius(all: 30)
    ..background.hex('ffffff');

  final ParentStyle userStatsStyle = ParentStyle()..margin(vertical: 10.0);

  final TxtStyle nameTextStyle = TxtStyle()
    ..textColor(Colors.white)
    ..fontSize(18)
    ..fontWeight(FontWeight.w600);

  final TxtStyle nameDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.white.withOpacity(0.8))
    ..textAlign.center()
    ..bold()
    ..fontSize(12);
}

class Settings extends StatefulWidget {
  final VoidCallback onRefresh;

  const Settings({Key key, this.onRefresh}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingsItem(
          onRefresh: widget.onRefresh,
          icon: FluentIcons.sign_out_20_regular,
          title: S.current.log_out,
          iswarrning: true,
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
                  onPressed: () {
                    getIt<AuthCubit>().unauthenticateUser();
                  },
                  child: Text(
                    S.current.yes,
                    style: Theme.of(context).textTheme.button.copyWith(color: Colors.red),
                  ),
                ),
                CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    S.current.no,
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  S.current.cancel,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            );
            showCupertinoModalPopup(context: context, builder: (context) => action);
          },
        ),
        SettingsItem(
          onRefresh: widget.onRefresh,
          icon: FluentIcons.location_12_regular,
          title: S.current.addresses,
          target: const AddressesScreen(),
        ),
        SettingsItem(
          onRefresh: widget.onRefresh,
          icon: FluentIcons.settings_28_regular,
          title: S.current.settings,
          target: const ProfileSettingsScreen(),
        ),
        SettingsItem(
          onRefresh: widget.onRefresh,
          icon: FluentIcons.history_20_filled,
          title: S.current.my_orders,
          target: const OrdersHistory(),
        ),
        if (kUser.level == UserLevel.customer)
          SettingsItem(
            onTap: () async {
              final completer = Helpers.showLoading(context);
              await getIt<IAuthRepository>().me();
              setState(() {});
              completer.complete();
            },
            icon: FluentIcons.money_24_regular,
            title: '${S.current.my_points} ${kUser.wallet} ﷼',
          ),
      ],
    );
  }
}

class SettingsItem extends StatefulWidget {
  const SettingsItem({
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
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
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
          style: settingsItemStyle(pressed: pressed),
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
                style: settingsItemIconStyle(iswarrning: widget.iswarrning),
                child: Icon(widget.icon, color: widget.iswarrning ? Colors.red : Colors.amber, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Txt(widget.title, style: itemTitleTextStyle(iswarrning: widget.iswarrning)),
                  if (widget.description != null) ...[
                    const SizedBox(height: 5),
                    Txt(widget.description, style: itemDescriptionTextStyle),
                  ]
                ],
              )
            ],
          ),
        );
      },
    );
  }

  ParentStyle settingsItemStyle({bool pressed}) => ParentStyle()
    ..elevation(pressed ? 0 : 50, color: Colors.grey)
    ..scale(pressed ? 0.90 : 1.0)
    ..alignmentContent.center()
    ..height(70)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..background.hex('#ffffff')
    ..ripple(true)
    ..animate(150, Curves.easeInOut);

  ParentStyle settingsItemIconStyle({bool iswarrning}) => ParentStyle()
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
