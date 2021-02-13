import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/screens/home/home.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/background_images_generate.dart';
import '../../../cubits/settings_cubit/settings_cubit.dart';
import '../../../helpers/helper.dart';
import '../../../models/language_model.dart';
import '../../../routes/config_routes.dart';
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
            floatingActionButton: WhatsappFloatingActionButton(),
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
                        child: FittedBox(
                          child: Text(_language.code),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          // image: DecorationImage(
                          //   image: AssetImage(_language.flag),
                          //   fit: BoxFit.cover,
                          // ),
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
    {'language': 'Albanian', 'hello': 'Përshëndetje'},
    {'language': 'Amharic', 'hello': 'ሰላም'},
    {'language': 'Arabic', 'hello': 'مرحبا'},
    {'language': 'Armenian', 'hello': 'Բարեւ'},
    {'language': 'Azerbaijani', 'hello': 'Salam'},
    {'language': 'Basque', 'hello': 'Kaixo'},
    {'language': 'Belarusian', 'hello': 'добры дзень'},
    {'language': 'Bengali', 'hello': 'হ্যালো'},
    {'language': 'Bosnian', 'hello': 'zdravo'},
    {'language': 'Bulgarian', 'hello': 'Здравейте'},
    {'language': 'Catalan', 'hello': 'Hola'},
    {'language': 'Cebuano', 'hello': 'Hello'},
    {'language': 'Chichewa', 'hello': 'Moni'},
    {'language': 'Chinese (Simplified)', 'hello': '您好'},
    {'language': 'Chinese (Traditional)', 'hello': '您好'},
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
    {'language': 'Georgian', 'hello': 'გამარჯობა'},
    {'language': 'German', 'hello': 'Hallo'},
    {'language': 'Greek', 'hello': 'Γεια σας'},
    {'language': 'Gujarati', 'hello': 'હેલો'},
    {'language': 'Haitian Creole', 'hello': 'Bonjou'},
    {'language': 'Hausa', 'hello': 'Sannu'},
    {'language': 'Hawaiian', 'hello': 'Alohaʻoe'},
    {'language': 'Hebrew', 'hello': 'שלום'},
    {'language': 'Hindi', 'hello': 'नमस्ते'},
    {'language': 'Hmong', 'hello': 'Nyob zoo'},
    {'language': 'Hungarian', 'hello': 'Helló'},
    {'language': 'Icelandic', 'hello': 'Halló'},
    {'language': 'Igbo', 'hello': 'Ndewo'},
    {'language': 'Indonesian', 'hello': 'Halo'},
    {'language': 'Irish', 'hello': 'Dia duit'},
    {'language': 'Italian', 'hello': 'Ciao'},
    {'language': 'Japanese', 'hello': 'こんにちは'},
    {'language': 'Javanese', 'hello': 'Hello'},
    {'language': 'Kannada', 'hello': 'ಹಲೋ'},
    {'language': 'Kazakh', 'hello': 'Сәлем'},
    {'language': 'Khmer', 'hello': 'ជំរាបសួរ'},
    {'language': 'Korean', 'hello': '안녕하세요.'},
    {'language': 'Kurdish (Kurmanji)', 'hello': 'Hello'},
    {'language': 'Kyrgyz', 'hello': 'салам'},
    {'language': 'Lao', 'hello': 'ສະບາຍດີ'},
    {'language': 'Latin', 'hello': 'salve'},
    {'language': 'Latvian', 'hello': 'Labdien!'},
    {'language': 'Lithuanian', 'hello': 'Sveiki'},
    {'language': 'Luxembourgish', 'hello': 'Moien'},
    {'language': 'Macedonian', 'hello': 'Здраво'},
    {'language': 'Malagasy', 'hello': 'Hello'},
    {'language': 'Malay', 'hello': 'Hello'},
    {'language': 'Malayalam', 'hello': 'ഹലോ'},
    {'language': 'Maltese', 'hello': 'Hello'},
    {'language': 'Maori', 'hello': 'Hiha'},
    {'language': 'Marathi', 'hello': 'हॅलो'},
    {'language': 'Mongolian', 'hello': 'Сайн байна уу'},
    {'language': 'Myanmar (Burmese)', 'hello': 'မင်္ဂလာပါ'},
    {'language': 'Nepali', 'hello': 'नमस्ते'},
    {'language': 'Norwegian', 'hello': 'Hallo'},
    {'language': 'Pashto', 'hello': 'سلام'},
    {'language': 'Persian', 'hello': 'سلام'},
    {'language': 'Polish', 'hello': 'Cześć'},
    {'language': 'Portuguese', 'hello': 'Olá'},
    {'language': 'Punjabi', 'hello': 'ਹੈਲੋ'},
    {'language': 'Romanian', 'hello': 'Alo'},
    {'language': 'Russian', 'hello': 'привет'},
    {'language': 'Samoan', 'hello': 'Talofa'},
    {'language': 'Scots Gaelic', 'hello': 'Hello'},
    {'language': 'Serbian', 'hello': 'Здраво'},
    {'language': 'Sesotho', 'hello': 'Hello'},
    {'language': 'Shona', 'hello': 'Hello'},
    {'language': 'Sindhi', 'hello': 'هيلو'},
    {'language': 'Sinhala', 'hello': 'හෙලෝ'},
    {'language': 'Slovak', 'hello': 'ahoj'},
    {'language': 'Slovenian', 'hello': 'Pozdravljeni'},
    {'language': 'Somali', 'hello': 'Hello'},
    {'language': 'Spanish', 'hello': 'Hola'},
    {'language': 'Sundanese', 'hello': 'halo'},
    {'language': 'Swahili', 'hello': 'Sawa'},
    {'language': 'Swedish', 'hello': 'Hallå'},
    {'language': 'Tajik', 'hello': 'Салом'},
    {'language': 'Tamil', 'hello': 'ஹலோ'},
    {'language': 'Telugu', 'hello': 'హలో'},
    {'language': 'Thai', 'hello': 'สวัสดี'},
    {'language': 'Turkish', 'hello': 'Merhaba'},
    {'language': 'Ukranian', 'hello': 'Здрастуйте'},
    {'language': 'Urdu', 'hello': 'ہیلو'},
    {'language': 'Uzbek', 'hello': 'Salom'},
    {'language': 'Vietnamese', 'hello': 'Xin chào'},
    {'language': 'Welsh', 'hello': 'Helo'},
    {'language': 'Xhosa', 'hello': 'Sawubona'},
    {'language': 'Yiddish', 'hello': 'העלא'},
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
