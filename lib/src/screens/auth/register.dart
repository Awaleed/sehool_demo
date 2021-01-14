import 'package:division/division.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/l10n.dart';
import '../../components/custom_form_fileds.dart';
import '../../cubits/registration_cubit/registration_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/form_data_model.dart';
import '../../models/user_model.dart';
import '../../routes/config_routes.dart';
import 'login.dart';

import '../../../init_injectable.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegistrationScreen({
    Key key,
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final credentials = <FormFieldType, FormFieldModel>{};
  final formKey = GlobalKey<FormState>();

  UserLevel userLevel;
  RegistrationCubit cubit;

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    cubit = getIt<RegistrationCubit>();
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
        ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<RegistrationCubit, RegistrationState>(
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
          child: Image.asset(
            'assets/images/logo.png',
            color: Colors.white,
          ),
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              CustomTextFromField(
                type: FormFieldType.name,
                map: credentials,
                enabled: !isLoading,
              ),
              const SizedBox(height: 15),
              CustomTextFromField(
                type: FormFieldType.email,
                map: credentials,
                enabled: !isLoading,
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
              CustomTextFromField(
                type: FormFieldType.phone,
                map: credentials,
                enabled: !isLoading,
              ),
              const SizedBox(height: 15),
              _buildLevelDropdownInput(
                type: FormFieldType.level,
                map: credentials,
                enabled: !isLoading,
              ),
              if (userLevel == UserLevel.merchant) ...[
                const SizedBox(height: 15),
                CustomTextFromField(
                  type: FormFieldType.storeName,
                  map: credentials,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 15),
                CustomTextFromField(
                  type: FormFieldType.vatNumber,
                  map: credentials,
                  enabled: !isLoading,
                ),
              ],
              const Divider(height: 30),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  Helpers.dismissFauces(context);
                  credentials.clear();
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    cubit.registration(credentials);
                  }
                },
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Txt(
                  S.current.register,
                  style: TxtStyle()..textColor(Colors.white),
                ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Txt(S.current.i_have_account_back_to_login),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () => AppRouter.sailor.navigate(LoginScreen.routeName),
              child: Txt(S.current.login),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelDropdownInput({
    @required Map<FormFieldType, FormFieldModel> map,
    @required FormFieldType type,
    bool enabled = true,
  }) {
    final _model = FormFieldModel.mapType(type, map);
    return CustomDropdownFromField<UserLevel>(
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
    );
  }
}
