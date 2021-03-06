import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/background_images_generate.dart';
import '../../../cubits/settings_cubit/settings_cubit.dart';
import '../../../helpers/helper.dart';
import '../../../models/language_model.dart';
import '../../../routes/config_routes.dart';
import '../../home/home.dart';
import '../../splash.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = '/language_settings';

  const LanguageScreen({Key key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  SettingsCubit cubit;

  String selectedLanguage;
  String currentLanguage;

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
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
      child: Stack(
        children: [
          BackgroundGeneratorGroup(
            number: _Hello.hellos.length,
            colors: Colors.accents,
            trajectory: Trajectory.straight,
            speed: DotSpeed.medium,
            opacity: .9,
            span: List.generate(_Hello.hellos.length, (e) => _Hello.fromJson(_Hello.hellos[e]).hello),
          ),
          Scaffold(
            floatingActionButton: const WhatsappFloatingActionButton(),
            backgroundColor: Colors.white70,
            appBar: AppBar(
              backgroundColor: Colors.black54,
              elevation: 0,
              title: Text(
                S.current.languages,
                style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
              ),
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
                      leading: const Icon(Icons.translate, color: Colors.white),
                      title: Text(
                        S.current.app_language,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        S.current.select_your_preferred_languages,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocListener<SettingsCubit, SettingsState>(
                    cubit: cubit,
                    listener: (context, state) {
                      state.maybeWhen(
                        loaded: (value) {
                          setState(() {
                            selectedLanguage = value.languageCode;
                            currentLanguage = value.languageCode;
                          });
                        },
                        orElse: () {},
                      );
                    },
                    child: _buildList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: LanguageModel.languages.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index >= LanguageModel.languages.length) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                Helpers.dismissFauces(context);
                if (currentLanguage != selectedLanguage) {
                  await cubit.setLanguageCode(selectedLanguage);
                  AppRouter.sailor.navigate(
                    SplashScreen.routeName,
                    navigationType: NavigationType.pushAndRemoveUntil,
                    removeUntilPredicate: (_) => false,
                  );
                } else {
                  AppRouter.sailor.pop();
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  const Size.fromRadius(25),
                ),
              ),
              child: Text(
                S.current.save,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        final _language = LanguageModel.languages[index];
        _language.selected = _language.code == selectedLanguage;

        return InkWell(
          onTap: () async {
            setState(() {
              selectedLanguage = _language.code;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
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
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        child: FittedBox(
                          child: Text(_language.code),
                        ),
                      ),
                      Container(
                        height: _language.selected ? 40 : 0,
                        width: _language.selected ? 40 : 0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                          color: Colors.amber.withOpacity(_language.selected ? 0.85 : 0),
                        ),
                        child: Icon(
                          Icons.check,
                          size: _language.selected ? 24 : 0,
                          color: Colors.amber,
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
                          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.amber),
                        ),
                        Text(
                          _language.englishName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption.copyWith(color: Colors.amber.withOpacity(.6)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Hello {
  static final hellos = [
    {'language': 'English', 'hello': 'Welcome!'},
    {'language': 'Afrikaans', 'hello': 'hallo'},
    {'language': 'Albanian', 'hello': 'P??rsh??ndetje'},
    {'language': 'Amharic', 'hello': '?????????'},
    {'language': 'Arabic', 'hello': '??????????'},
    {'language': 'Armenian', 'hello': '??????????'},
    {'language': 'Azerbaijani', 'hello': 'Salam'},
    {'language': 'Basque', 'hello': 'Kaixo'},
    {'language': 'Belarusian', 'hello': '?????????? ??????????'},
    {'language': 'Bengali', 'hello': '??????????????????'},
    {'language': 'Bosnian', 'hello': 'zdravo'},
    {'language': 'Bulgarian', 'hello': '??????????????????'},
    {'language': 'Catalan', 'hello': 'Hola'},
    {'language': 'Cebuano', 'hello': 'Hello'},
    {'language': 'Chichewa', 'hello': 'Moni'},
    {'language': 'Chinese (Simplified)', 'hello': '??????'},
    {'language': 'Chinese (Traditional)', 'hello': '??????'},
    {'language': 'Corsican', 'hello': 'Bonghjornu'},
    {'language': 'Croatian', 'hello': 'zdravo'},
    {'language': 'Czech', 'hello': 'Ahoj'},
    {'language': 'Danish', 'hello': 'Hej'},
    {'language': 'Dutch', 'hello': 'Hallo'},
    {'language': 'English', 'hello': 'Hello'},
    {'language': 'Esperanto', 'hello': 'Saluton'},
    {'language': 'Estonian', 'hello': 'Tere'},
    {'language': 'Filipino', 'hello': 'Hello'},
    {'language': 'Finnish', 'hello': 'Hei'},
    {'language': 'French', 'hello': 'Bonjour'},
    {'language': 'Frisian', 'hello': 'Hello'},
    {'language': 'Galician', 'hello': 'Ola'},
    {'language': 'Georgian', 'hello': '???????????????????????????'},
    {'language': 'German', 'hello': 'Hallo'},
    {'language': 'Greek', 'hello': '???????? ??????'},
    {'language': 'Gujarati', 'hello': '????????????'},
    {'language': 'Haitian Creole', 'hello': 'Bonjou'},
    {'language': 'Hausa', 'hello': 'Sannu'},
    {'language': 'Hawaiian', 'hello': 'Aloha??oe'},
    {'language': 'Hebrew', 'hello': '????????'},
    {'language': 'Hindi', 'hello': '??????????????????'},
    {'language': 'Hmong', 'hello': 'Nyob zoo'},
    {'language': 'Hungarian', 'hello': 'Hell??'},
    {'language': 'Icelandic', 'hello': 'Hall??'},
    {'language': 'Igbo', 'hello': 'Ndewo'},
    {'language': 'Indonesian', 'hello': 'Halo'},
    {'language': 'Irish', 'hello': 'Dia duit'},
    {'language': 'Italian', 'hello': 'Ciao'},
    {'language': 'Japanese', 'hello': '???????????????'},
    {'language': 'Javanese', 'hello': 'Hello'},
    {'language': 'Kannada', 'hello': '?????????'},
    {'language': 'Kazakh', 'hello': '??????????'},
    {'language': 'Khmer', 'hello': '????????????????????????'},
    {'language': 'Korean', 'hello': '???????????????.'},
    {'language': 'Kurdish (Kurmanji)', 'hello': 'Hello'},
    {'language': 'Kyrgyz', 'hello': '??????????'},
    {'language': 'Lao', 'hello': '?????????????????????'},
    {'language': 'Latin', 'hello': 'salve'},
    {'language': 'Latvian', 'hello': 'Labdien!'},
    {'language': 'Lithuanian', 'hello': 'Sveiki'},
    {'language': 'Luxembourgish', 'hello': 'Moien'},
    {'language': 'Macedonian', 'hello': '????????????'},
    {'language': 'Malagasy', 'hello': 'Hello'},
    {'language': 'Malay', 'hello': 'Hello'},
    {'language': 'Malayalam', 'hello': '?????????'},
    {'language': 'Maltese', 'hello': 'Hello'},
    {'language': 'Maori', 'hello': 'Hiha'},
    {'language': 'Marathi', 'hello': '????????????'},
    {'language': 'Mongolian', 'hello': '???????? ?????????? ????'},
    {'language': 'Myanmar (Burmese)', 'hello': '???????????????????????????'},
    {'language': 'Nepali', 'hello': '??????????????????'},
    {'language': 'Norwegian', 'hello': 'Hallo'},
    {'language': 'Pashto', 'hello': '????????'},
    {'language': 'Persian', 'hello': '????????'},
    {'language': 'Polish', 'hello': 'Cze????'},
    {'language': 'Portuguese', 'hello': 'Ol??'},
    {'language': 'Punjabi', 'hello': '????????????'},
    {'language': 'Romanian', 'hello': 'Alo'},
    {'language': 'Russian', 'hello': '????????????'},
    {'language': 'Samoan', 'hello': 'Talofa'},
    {'language': 'Scots Gaelic', 'hello': 'Hello'},
    {'language': 'Serbian', 'hello': '????????????'},
    {'language': 'Sesotho', 'hello': 'Hello'},
    {'language': 'Shona', 'hello': 'Hello'},
    {'language': 'Sindhi', 'hello': '????????'},
    {'language': 'Sinhala', 'hello': '????????????'},
    {'language': 'Slovak', 'hello': 'ahoj'},
    {'language': 'Slovenian', 'hello': 'Pozdravljeni'},
    {'language': 'Somali', 'hello': 'Hello'},
    {'language': 'Spanish', 'hello': 'Hola'},
    {'language': 'Sundanese', 'hello': 'halo'},
    {'language': 'Swahili', 'hello': 'Sawa'},
    {'language': 'Swedish', 'hello': 'Hall??'},
    {'language': 'Tajik', 'hello': '??????????'},
    {'language': 'Tamil', 'hello': '????????????'},
    {'language': 'Telugu', 'hello': '?????????'},
    {'language': 'Thai', 'hello': '??????????????????'},
    {'language': 'Turkish', 'hello': 'Merhaba'},
    {'language': 'Ukranian', 'hello': '????????????????????'},
    {'language': 'Urdu', 'hello': '????????'},
    {'language': 'Uzbek', 'hello': 'Salom'},
    {'language': 'Vietnamese', 'hello': 'Xin ch??o'},
    {'language': 'Welsh', 'hello': 'Helo'},
    {'language': 'Xhosa', 'hello': 'Sawubona'},
    {'language': 'Yiddish', 'hello': '????????'},
    {'language': 'Yoruba', 'hello': 'Kaabo'},
    {'language': 'Zulu', 'hello': 'Sawubona'}
  ];
  String language;
  String hello;

  _Hello({this.language, this.hello});

  _Hello.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    hello = json['hello'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    data['hello'] = hello;
    return data;
  }
}
