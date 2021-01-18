import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/data/user_datasource.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/profile/pages/addresses.dart';
import 'package:sehool/src/screens/profile/pages/language.dart';
import 'package:sehool/src/screens/profile/profile_settings.dart';
import 'package:validators/validators.dart';
import 'package:supercharged/supercharged.dart';

class UserPage extends StatelessWidget {
  final contentStyle = (BuildContext context) => ParentStyle()
    ..overflow.scrollable()
    ..padding(vertical: 30, horizontal: 20)
    ..minHeight(MediaQuery.of(context).size.height - (2 * 30));

  final titleStyle = TxtStyle()
    ..bold()
    ..fontSize(32)
    ..textColor(Colors.white)
    ..margin(bottom: 20)
    ..alignmentContent.centerLeft();

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: contentStyle(context),
      child: Column(
        children: <Widget>[
          Txt(S.current.profile, style: titleStyle),
          UserCard(),
          // ActionsRow(),
          Settings(),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  Widget _buildUserRow() {
    return Row(
      children: <Widget>[
        Parent(
          style: userImageStyle,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: isURL(kUser.image)
                ? CachedNetworkImageProvider(kUser.image)
                : const AssetImage('assets/img/user.png'),
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
            Txt(kUser.level == '0' ? 'مستخدم' : 'تاجر',
                style: nameDescriptionTextStyle)
          ],
        )
      ],
    );
  }

  Widget _buildUserStats() {
    return Parent(
      style: userStatsStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildUserStatsItem(
              '${kUser.wallet} ﷼', FluentIcons.money_24_regular),
          _buildUserStatsItem(kUser.email, FluentIcons.mail_24_regular),
          _buildUserStatsItem(kUser.phone, FluentIcons.phone_24_regular),
          _buildUserStatsItem(
              '@user${kUser.id}', FluentIcons.person_accounts_24_regular)
        ],
      ),
    );
  }

  Widget _buildUserStatsItem(String value, IconData icon) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(20)
      ..textColor(Colors.white);
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(height: 5),
        Txt(value, style: nameDescriptionTextStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: userCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_buildUserRow(), _buildUserStats()],
      ),
    );
  }

  //Styling

  final ParentStyle userCardStyle = ParentStyle()
    ..height(175)
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
    ..bold()
    ..fontSize(12);
}

// class ActionsRow extends StatelessWidget {
//   Widget _buildActionsItem(String title, IconData icon) {
//     return Parent(
//       style: actionsItemStyle,
//       child: Column(
//         children: <Widget>[
//           Parent(
//             style: actionsItemIconStyle,
//             child: Icon(icon, size: 20, color: Color(0xFF42526F)),
//           ),
//           Txt(title, style: actionsItemTextStyle)
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         _buildActionsItem('Wallet', Icons.attach_money),
//         _buildActionsItem('Delivery', Icons.card_giftcard),
//         _buildActionsItem('Message', Icons.message),
//         _buildActionsItem('Service', Icons.room_service),
//       ],
//     );
//   }

//   final ParentStyle actionsItemIconStyle = ParentStyle()
//     ..alignmentContent.center()
//     ..width(50)
//     ..height(50)
//     ..margin(bottom: 5)
//     ..borderRadius(all: 30)
//     ..background.hex('#F6F5F8')
//     ..ripple(true);

//   final ParentStyle actionsItemStyle = ParentStyle()..margin(vertical: 20.0);

//   final TxtStyle actionsItemTextStyle = TxtStyle()
//     ..textColor(Colors.black.withOpacity(0.8))
//     ..fontSize(12);
// }

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingsItem(
          icon: FluentIcons.sign_out_24_regular,
          title: S.current.log_out,
          description: 'تغير الحساب',
          iswarrning: true,
          target: const AddressesScreen(),
          onTap: () {},
        ),
        SettingsItem(
            icon: FluentIcons.location_28_regular,
            title: S.current.addresses,
            target: const AddressesScreen(),
            // iswarrning: true,
            // onTap: () => AppRouter.sailor.navigate(AddressesScreen.routeName),
            description: 'عناوينك التي تريدنا ان نوصل اليك'),
        SettingsItem(
            icon: FluentIcons.local_language_28_regular,
            title: S.current.languages,
            target: const LanguageScreen(),
            description: 'نحن نتحدث اكثر من لغة'),
        SettingsItem(
            icon: FluentIcons.settings_28_regular,
            title: S.current.settings,
            target: const ProfileSettingsScreen(),
            description: 'تطبيقك قواعدك'),
        SettingsItem(
            icon: FluentIcons.chat_help_24_regular,
            title: S.current.help_support,
            target: const AddressesScreen(),
            description: 'نحن هنا لاجلك'),
        SettingsItem(
            icon: FluentIcons.money_24_regular,
            title: S.current.balance,
            target: const AddressesScreen(),
            description: 'محفظتك الخاصة'),
      ],
    );
  }
}

class SettingsItem extends StatefulWidget {
  const SettingsItem(
      {this.icon,
      this.iswarrning = false,
      this.title,
      this.target,
      this.description,
      this.onTap});

  final IconData icon;
  final bool iswarrning;
  final String title;
  final Widget target;
  final String description;
  final VoidCallback onTap;

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
      closedBuilder: (context, action) => Parent(
        style: settingsItemStyle(pressed),
        gesture: Gestures()
          ..isTap((isTapped) {
            setState(() => pressed = isTapped);
          })
          ..onTap(action),
        child: Row(
          children: <Widget>[
            Parent(
              style: settingsItemIconStyle(widget.iswarrning),
              child: Icon(widget.icon,
                  color: widget.iswarrning ? Colors.red : Colors.amber,
                  size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(widget.title, style: itemTitleTextStyle(widget.iswarrning)),
                const SizedBox(height: 5),
                Txt(widget.description, style: itemDescriptionTextStyle),
              ],
            )
          ],
        ),
      ),
    );
  }

  final settingsItemStyle = (pressed) => ParentStyle()
    ..elevation(pressed ? 0 : 50, color: Colors.grey)
    ..scale(pressed ? 0.90 : 1.0)
    ..alignmentContent.center()
    ..height(70)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..background.hex('#ffffff')
    ..ripple(true)
    ..animate(150, Curves.easeInOut);

  settingsItemIconStyle(bool iswarrning) => ParentStyle()
    ..background.color(
        iswarrning ? Colors.red.withOpacity(.1) : Colors.amber.withOpacity(.1))
    ..margin(horizontal: 15)
    ..padding(all: 12)
    ..borderRadius(all: 30);

  TxtStyle itemTitleTextStyle(bool iswarrning) => TxtStyle()
    ..bold()
    ..textColor(iswarrning ? Colors.red : Colors.amber)
    ..fontSize(16);

  final TxtStyle itemDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.black26)
    ..bold()
    ..fontSize(12);
}
