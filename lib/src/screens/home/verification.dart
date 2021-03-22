import 'dart:math';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import '../../../generated/l10n.dart';
import '../../components/background_images_generate.dart';
import '../../core/api_caller.dart';
import '../../helpers/helper.dart';
import '../../routes/config_routes.dart';
import '../splash.dart';

enum _VerificationState { initial, loading, success, failure }

class _VerificationCubit extends Cubit<_VerificationState> with ApiCaller {
  _VerificationCubit() : super(_VerificationState.initial);

  Future<void> sendVerificationCode(String code) async {
    emit(_VerificationState.loading);
    try {
      await post(
        path: '/verification_code',
        data: {'verification': code.trim()},
      );
      emit(_VerificationState.success);
    } catch (e) {
      emit(_VerificationState.failure);
      // addError(e);
    }
  }

  Future<void> requestVerificationCode() async {
    emit(_VerificationState.loading);
    try {
      await post(path: '/resend_code');
      emit(_VerificationState.success);
    } catch (e) {
      emit(_VerificationState.failure);
      // addError(e);
    }
  }
}

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController codeController;
  final formKey = GlobalKey<FormState>();
  _VerificationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = _VerificationCubit();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    cubit.close();
    codeController.dispose();
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

  Widget _loginCard() {
    final theme = Theme.of(context);
    // final auth = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;

    return BlocBuilder<_VerificationCubit, _VerificationState>(
      cubit: cubit,
      builder: (context, state) {
        final isLoading = state == _VerificationState.loading;
        return Center(
          child: FittedBox(
            child: Card(
              child: Container(
                padding: const EdgeInsets.only(
                  left: cardPadding,
                  top: cardPadding + 10.0,
                  right: cardPadding,
                  bottom: cardPadding,
                ),
                width: cardWidth,
                alignment: Alignment.center,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        S.current.the_code_has_been_sent_to,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: codeController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {},
                        validator: (value) => null,
                        style: const TextStyle(fontSize: 14),
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          fillColor: Colors.amber.withOpacity(.2),
                          filled: true,
                          labelText: S.current.enter_the_code,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: S.current.enter_the_code,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.code, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.0))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.0))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.0))),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size.fromRadius(20),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: !isLoading
                            ? () async {
                                await cubit.requestVerificationCode();
                                if (cubit.state == _VerificationState.success) {
                                  Helpers.showMessageOverlay(context, message: S.current.the_code_has_been_sent_to);
                                }
                              }
                            : null,
                        child: FittedBox(
                          child: Text(
                            S.current.send,
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size.fromRadius(20),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            backgroundColor: !isLoading ? MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.9)) : null,
                          ),
                          onPressed: !isLoading
                              ? () async {
                                  Helpers.dismissFauces(context);
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    await cubit.sendVerificationCode(codeController.text.trim());
                                    if (cubit.state == _VerificationState.success) {
                                      AppRouter.sailor.navigate(
                                        SplashScreen.routeName,
                                        navigationType: NavigationType.pushAndRemoveUntil,
                                        removeUntilPredicate: (_) => false,
                                      );
                                    } else if (cubit.state == _VerificationState.failure) {
                                      Helpers.showErrorOverlay(context, error: S.current.the_entered_code_is_invalid);
                                    }
                                  }
                                }
                              : null,
                          child: FittedBox(
                            child: Text(
                              S.current.ok,
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
