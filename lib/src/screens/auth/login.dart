import 'dart:math';

import 'package:division/division.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/background_images_generate.dart';
import '../../components/custom_form_fileds.dart';
import '../../components/login_card/flutter_login.dart';
import '../../components/login_card/src/providers/login_theme.dart';
import '../../components/login_card/src/widgets/animated_text_form_field.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/form_data_model.dart';
import '../../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final credentials = <String, dynamic>{};
  final formKey = GlobalKey<FormState>();
  LoginCubit cubit;
  UserLevel userLevel;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    cubit = getIt<LoginCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()..background.color(Colors.white),
      child: _buildUI(),
    );
  }

  Widget _buildUI() => Stack(
        children: [
          BackgroundGeneratorGroup(
            number: 60,
            colors: Colors.accents,
            direction: Direction.up,
            speed: DotSpeed.medium,
            opacity: .9,
            image: const [
              'assets/images/meat.png',
              'assets/images/meat2.png',
              'assets/images/meat3.png',
              'assets/images/ribs.png',
              'assets/images/ribs2.png',
              'assets/images/knife.png',
              'assets/images/delivery-truck.png',
            ],
          ),
          _loginCard()
        ],
      );

  Widget _buildLevelDropdownInput({
    @required Map<String, dynamic> map,
    @required FormFieldType type,
    bool enabled = true,
  }) {
    final _model = FormFieldModel.mapType(type, map);
    return Center(
      child: CustomDropdownFromField<UserLevel>(
        type: type,
        map: map,
        itemAsString: (item) {
          switch (item) {
            case UserLevel.customer:
              return S.current.customer;
            case UserLevel.merchant:
              return S.current.merchant;
            default:
              return '';
          }
        },
        items: UserLevel.values,
        enabled: enabled,
        onChanged: (value) => setState(() {
          userLevel = value;
        }),
        validator: (value) => _model.validator(
          EnumToString.convertToString(value),
        ),
        onSave: (value) => _model.onSave(
          EnumToString.convertToString(value),
        ),
      ),
    );
  }

  Widget _loginCard() {
    return FlutterLogin(
      title: '',
      theme: LoginTheme(
        pageColorLight: Colors.transparent,
      ),
      logo: 'assets/images/logo.png',
      onLogin: (val) async {
        Helpers.dismissFauces(context);
        credentials['email'] = val.name.trim();
        credentials['password'] = val.password.trim();
        await cubit.login(credentials);
        return cubit.state.maybeWhen(
          failure: (message) => message,
          orElse: () => null,
        );
      },
      onSignup: (val) async {
        Helpers.dismissFauces(context);
        credentials['email'] = val.name.trim();
        credentials['password'] = val.password.trim();
        await cubit.registration(credentials);
        return cubit.state.maybeWhen(
          failure: (message) => message,
          orElse: () => null,
        );
      },
      onRecoverPassword: (pass) async {
        Helpers.dismissFauces(context);
        await cubit.requestCode(pass.trim());
        return cubit.state.maybeWhen(
          failure: (message) => message,
          orElse: () => null,
        );
      },
      onSubmitAnimationCompleted: () {
        getIt<AuthCubit>().authenticateUser();
      },
      signupFields: [
        const SizedBox(height: 15),
        _builsCustomTextFromField(
          type: FormFieldType.name,
          map: credentials,
        ),
        const SizedBox(height: 15),
        _builsCustomTextFromField(
          type: FormFieldType.phone,
          map: credentials,
        ),
        const SizedBox(height: 15),
        _buildLevelDropdownInput(
          type: FormFieldType.level,
          map: credentials,
        ),
        if (userLevel == UserLevel.merchant) ...[
          const SizedBox(height: 15),
          _builsCustomTextFromField(
            type: FormFieldType.storeName,
            map: credentials,
          ),
          const SizedBox(height: 15),
          _builsCustomTextFromField(
            type: FormFieldType.vatNumber,
            map: credentials,
          ),
        ],
        const Divider(height: 30),
      ],
    );
  }

  Widget _builsCustomTextFromField({
    @required Map<String, dynamic> map,
    @required FormFieldType type,
    Widget suffixIcon,
    bool enabled = true,
    bool obscureText = false,
  }) {
    final cardWidth = min(MediaQuery.of(context).size.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final _model = FormFieldModel.mapType(type, map);
    return AnimatedTextFormField(
      prefixIcon: suffixIcon ?? Icon(_model.iconData),
      labelText: _model.labelText,
      enabled: enabled,
      keyboardType: _model.keyboardType,
      onSaved: _model.onSave,
      validator: _model.validator,
      obscureText: obscureText,
      width: cardWidth - cardPadding * 2,
    );
  }
}
