import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:supercharged/supercharged.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/custom_form_fileds.dart';
import '../../cubits/forgot_password_cubit/forgot_password_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/form_data_model.dart';
import '../../routes/config_routes.dart';
import 'login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password';

  const ForgotPasswordScreen({
    Key key,
  }) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final credentials = <FormFieldType, FormFieldModel>{};
  final formKey = GlobalKey<FormState>();
  ForgotPasswordCubit cubit;
  Timer resendTimer;
  int timerValue;

  @override
  void initState() {
    super.initState();
    cubit = getIt<ForgotPasswordCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    if (resendTimer != null && resendTimer.isActive) resendTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              cubit: cubit,
              listener: (context, state) {
                state.maybeWhen(
                  success: () => AppRouter.sailor.navigate(
                    LoginScreen.routeName,
                    navigationType: NavigationType.pushAndRemoveUntil,
                    removeUntilPredicate: (_) => false,
                  ),
                  enterNewPassword: (email, timeout) {
                    credentials.clear();
                    formKey.currentState.reset();
                    timerValue = timeout;
                    resendTimer = Timer.periodic(1.seconds, (timer) {
                      if (timerValue == 0) timer.cancel();
                      setState(() {
                        timerValue--;
                      });
                    });
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.when(
                  enterYourEmail: (email) => _buildEnterEmail(email),
                  enterYourEmailLoading: (email) =>
                      _buildEnterEmail(email, true),
                  enterNewPassword: (email, timeout) =>
                      _buildEnterPassword(email, timeout),
                  enterNewPasswordLoading: (email) =>
                      _buildEnterPassword(email, null, true),
                  success: () => _buildEnterEmail(),
                  failureOnEnterYourEmail: (_) => _buildEnterEmail(),
                  failureOnNewPassword: (message, email, timeout) =>
                      _buildEnterPassword(email, timeout),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnterEmail([String email, bool isLoading = false]) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                S.of(context).i_forgot_password,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        CustomTextFromField(
          type: FormFieldType.email,
          map: credentials,
          enabled: !isLoading,
          initialValue: email,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  Helpers.dismissFauces(context);
                  credentials.clear();
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    cubit.requestCode(credentials[FormFieldType.email].value);
                  }
                },
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Text(
                  S.of(context).send,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildEnterPassword(
    String email,
    int timeout, [
    bool isLoading = false,
  ]) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    S.of(context).the_code_has_been_sent_to,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 20),
                      Center(
                        child: TextButton.icon(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.grey),
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                                  credentials.clear();
                                  Helpers.dismissFauces(context);
                                  cubit.editEmail();
                                },
                          icon: const Icon(Icons.edit),
                          label: Text(S.of(context).edit),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        CustomTextFromField(
          type: FormFieldType.password,
          map: credentials,
          enabled: !isLoading,
          obscureText: true,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: (timerValue > 0)
                  ? null
                  : () {
                      cubit.resend();
                    },
              style: (timerValue > 0)
                  ? ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    )
                  : null,
              child: Text(
                  'اعادة الارسال${(timerValue > 0) ? ' بعد $timerValue' : ''}'),
            ),
            const SizedBox(width: 30),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      credentials.clear();
                      Helpers.dismissFauces(context);
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        cubit.setPassword(
                            credentials[FormFieldType.password].value);
                      }
                    },
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      S.of(context).send,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
