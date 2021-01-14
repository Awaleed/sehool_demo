import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../cubits/settings_cubit/settings_cubit.dart';
import '../../../models/language_model.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = '/language_settings';

  const LanguageScreen({Key key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  SettingsCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = getIt<SettingsCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.languages),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(),
                leading: Icon(
                  Icons.translate,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.current.app_language,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(S.current.select_your_preferred_languages),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<SettingsCubit, SettingsState>(
              cubit: cubit,
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (value) => _buildList(value.languageCode),
                  orElse: () => _buildList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList([String selectedLanguage]) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: LanguageModel.languages.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final _language = LanguageModel.languages[index];
        _language.selected = _language.code == selectedLanguage;

        return InkWell(
          onTap: () => cubit.setLanguageCode(_language.code),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        image: DecorationImage(
                          image: AssetImage(_language.flag),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: _language.selected ? 40 : 0,
                      width: _language.selected ? 40 : 0,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        color: Theme.of(context)
                            .accentColor
                            .withOpacity(_language.selected ? 0.85 : 0),
                      ),
                      child: Icon(
                        Icons.check,
                        size: _language.selected ? 24 : 0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _language.localName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        _language.englishName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.white60),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
