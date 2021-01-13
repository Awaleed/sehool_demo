import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/custom_form_fileds.dart';
import 'forgot_password.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/form_data_model.dart';
import '../../routes/config_routes.dart';
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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<LoginCubit, LoginState>(
            cubit: cubit,
            listener: (context, state) {
              state.maybeWhen(
                failure: (message) => Helpers.showErrorOverlay(
                  context,
                  error: message,
                ),
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.when(
                initial: () => _buildColumn(context),
                loading: () => _buildColumn(context, isLoading: true),
                success: () => _buildColumn(context),
                // TODO: Handel ERROR STATE
                failure: (_) => _buildColumn(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Column _buildColumn(
    BuildContext context, {
    bool isLoading = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 300,
          child: Image.asset('assets/images/logo.png'),
        ),
        Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              CustomTextFromField(
                type: FormFieldType.email,
                map: credentials,
                enabled: !isLoading,
              ),
              const SizedBox(height: 10),
              CustomTextFromField(
                type: FormFieldType.password,
                map: credentials,
                enabled: !isLoading,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => passwordVisible = !passwordVisible),
                  icon: Icon(passwordVisible
                      ? FluentIcons.eye_hide_24_regular
                      : FluentIcons.eye_show_24_regular),
                ),
                obscureText: passwordVisible,
              ),
              const Divider(height: 30),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  Helpers.dismissFauces(context);
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    cubit.login(credentials);
                  }
                },
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Txt(
                  S.of(context).login,
                  style: TxtStyle()..textColor(Colors.white),
                ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Txt(S.of(context).i_dont_have_an_account),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () =>
                      AppRouter.sailor.navigate(RegistrationScreen.routeName),
              child: Txt(S.of(context).register),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).i_forgot_password,
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () =>
                      AppRouter.sailor.navigate(ForgotPasswordScreen.routeName),
              child: Text(S.of(context).restore),
            ),
          ],
        ),
      ],
    );
  }
}
