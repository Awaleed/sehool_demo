import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/my_loading_overlay.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../data/user_datasource.dart';
import '../../../routes/config_routes.dart';
import '../../profile/pages/addresses.dart';
import '../../profile/pages/language.dart';
import '../../profile/profile_settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MyLoadingOverLay(
      isLoading: false,
      showSpinner: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: isURL(kUser.image)
                          ? CachedNetworkImageProvider(kUser.image)
                          : const AssetImage('assets/img/user.png'),
                      onBackgroundImageError: (exception, stackTrace) =>
                          const Center(
                        child: Icon(Icons.not_interested),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        title: Text(kUser.name),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(FluentIcons.mail_28_regular),
                                Flexible(
                                  child: Text(
                                    kUser.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(FluentIcons.settings_28_regular),
                      title: Text(S.of(context).settings),
                      onTap: () async {
                        await AppRouter.sailor.navigate(
                          ProfileSettingsScreen.routeName,
                        );
                        setState(() {});
                      },
                    ),
                    ListTile(
                      leading:
                          const Icon(FluentIcons.globe_location_24_regular),
                      title: Text(S.of(context).addresses),
                      onTap: () =>
                          AppRouter.sailor.navigate(AddressesScreen.routeName),
                    ),
                    ListTile(
                      leading:
                          const Icon(FluentIcons.local_language_28_regular),
                      title: Text(S.of(context).languages),
                      onTap: () =>
                          AppRouter.sailor.navigate(LanguageScreen.routeName),
                    ),
                    ListTile(
                      leading: const Icon(FluentIcons.chat_help_24_regular),
                      title: Text(S.of(context).help_support),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(FluentIcons.money_24_regular),
                      title:
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? Text(
                                  '${kUser.wallet} SDG',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.end,
                                )
                              : Text(
                                  '${kUser.wallet} SDG',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                ),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        FluentIcons.sign_out_24_regular,
                        color: Colors.red,
                      ),
                      title: Text(
                        S.of(context).log_out,
                        style: const TextStyle(color: Colors.red),
                      ),
                      onTap: () => getIt<AuthCubit>().unauthenticateUser(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
