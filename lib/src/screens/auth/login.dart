import 'package:division/division.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/src/components/background_images_generate.dart';
import 'package:sehool/src/components/login_card/flutter_login.dart';
import 'package:sehool/src/components/login_card/src/providers/login_messages.dart';
import 'package:sehool/src/components/login_card/src/providers/login_theme.dart';
import 'package:sehool/src/components/login_card/src/widgets/auth_card.dart';
import 'package:sehool/src/components/my_loading_overlay.dart';
import 'package:sehool/src/models/user_model.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/custom_form_fileds.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/form_data_model.dart';
import '../../routes/config_routes.dart';
import 'forgot_password.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final credentials = <FormFieldType, FormFieldModel>{};
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
      child: BlocConsumer<LoginCubit, LoginState>(
        cubit: cubit,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state.when(
            initial: () => _buildUI(),
            loading: () => _buildUI(isLoading: true),
            success: () => _buildUI(),
            // TODO: Handel ERROR STATE
            failure: (e) {
              return _buildUI();
            },
          );
        },
      ),
    );
  }

  Widget _buildUI({bool isLoading = false}) => MyLoadingOverLay(
        isLoading: isLoading,
        showSpinner: true,
        child: Stack(
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
        ),
      );

  Widget _buildLevelDropdownInput({
    @required Map<FormFieldType, FormFieldModel> map,
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
              return S.current.customers;
            case UserLevel.merchant:
              return S.current.merchants;
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
      messages: LoginMessages(
          passwordHint: S.current.password,
          usernameHint: S.current.email,
          forgotPasswordButton: S.current.i_forgot_password,
          signupButton: S.current.register,
          loginButton: S.current.login,
          recoverPasswordButton: S.current.send,
          goBackButton: S.current.i_have_account_back_to_login,
          recoverPasswordIntro: S.current.i_forgot_password,
          recoverPasswordDescription: ''),
      theme: LoginTheme(
        pageColorLight: Colors.transparent,
      ),
      logo: 'assets/images/logo.png',
      onLogin: (val) {
        credentials[FormFieldType.email] = FormFieldModel(
          name: 'email',
          value: val.name,
        );
        credentials[FormFieldType.password] = FormFieldModel(
          name: 'password',
          value: val.password,
        );
        cubit.login(credentials);
        return Future.value();
      },
      onSignup: (val) {
        credentials[FormFieldType.email] = FormFieldModel(
          name: 'email',
          value: val.name,
        );
        credentials[FormFieldType.password] = FormFieldModel(
          name: 'password',
          value: val.password,
        );
        cubit.registration(credentials);
        return Future.value();
      },
      signupFields: [
        const SizedBox(height: 15),
        CustomTextFromField(
          type: FormFieldType.name,
          map: credentials,
        ),
        const SizedBox(height: 15),
        CustomTextFromField(
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
          CustomTextFromField(
            type: FormFieldType.storeName,
            map: credentials,
          ),
          const SizedBox(height: 15),
          CustomTextFromField(
            type: FormFieldType.vatNumber,
            map: credentials,
          ),
        ],
        const Divider(height: 30),
      ],
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => DashboardScreen(),
        // ));
      },
      onRecoverPassword: (pass) {},
    );
  }

  // Widget oldLogin() {
  //   return Scaffold(
  //     backgroundColor: Colors.transparent,
  //     body: Center(
  //       child: SingleChildScrollView(
  //         padding: const EdgeInsets.all(8.0),
  //         child: BlocConsumer<LoginCubit, LoginState>(
  //           cubit: cubit,
  //           listener: (context, state) {
  //             state.maybeWhen(
  //               failure: (message) => Helpers.showErrorOverlay(
  //                 context,
  //                 error: message,
  //               ),
  //               orElse: () {},
  //             );
  //           },
  //           builder: (context, state) {
  //             return state.when(
  //               initial: () => _buildColumn(context),
  //               loading: () => _buildColumn(context, isLoading: true),
  //               success: () => _buildColumn(context),
  //               // TODO: Handel ERROR STATE
  //               failure: (e) {
  //                 print(e);
  //                 return _buildColumn(context);
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Column _buildColumn(
  //   BuildContext context, {
  //   bool isLoading = false,
  // }) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       SizedBox(
  //         height: 300,
  //         child: Image.asset(
  //           'assets/images/logo.png',
  //         ),
  //       ),
  //       Form(
  //         key: formKey,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const SizedBox(height: 10),
  //             CustomTextFromField(
  //               type: FormFieldType.email,
  //               map: credentials,
  //               enabled: !isLoading,
  //             ),
  //             const SizedBox(height: 10),
  //             CustomTextFromField(
  //               type: FormFieldType.password,
  //               map: credentials,
  //               enabled: !isLoading,
  //               suffixIcon: IconButton(
  //                 onPressed: () =>
  //                     setState(() => passwordVisible = !passwordVisible),
  //                 icon: Icon(passwordVisible
  //                     ? FluentIcons.eye_hide_24_regular
  //                     : FluentIcons.eye_show_24_regular),
  //               ),
  //               obscureText: passwordVisible,
  //             ),
  //             const Divider(height: 30),
  //           ],
  //         ),
  //       ),
  //       ElevatedButton(
  //         onPressed: isLoading
  //             ? null
  //             : () {
  //                 Helpers.dismissFauces(context);
  //                 if (formKey.currentState.validate()) {
  //                   formKey.currentState.save();
  //                   cubit.login(credentials);
  //                 }
  //               },
  //         child: isLoading
  //             ? const Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Center(child: CircularProgressIndicator()),
  //               )
  //             : Txt(
  //                 S.current.login,
  //                 style: TxtStyle()..textColor(Colors.white),
  //               ),
  //       ),
  //       const SizedBox(height: 10),
  //       Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Txt(S.current.i_dont_have_an_account),
  //           TextButton(
  //             onPressed: isLoading
  //                 ? null
  //                 : () =>
  //                     AppRouter.sailor.navigate(RegistrationScreen.routeName),
  //             child: Txt(S.current.register),
  //           ),
  //         ],
  //       ),
  //       Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             S.current.i_forgot_password,
  //           ),
  //           TextButton(
  //             onPressed: isLoading
  //                 ? null
  //                 : () =>
  //                     AppRouter.sailor.navigate(ForgotPasswordScreen.routeName),
  //             child: Text(S.current.restore),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
