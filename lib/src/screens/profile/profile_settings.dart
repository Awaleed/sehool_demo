import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/cubits/profile_cubit/profile_cubit.dart';
import 'package:sehool/src/data/user_datasource.dart';
import 'package:sehool/src/helpers/helper.dart';
import 'package:sehool/src/models/form_data_model.dart';

import '../../../init_injectable.dart';
import '../../components/avatar_section.dart';
import '../../components/my_loading_overlay.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static const routeName = '/profile_settings';

  const ProfileSettingsScreen({Key key}) : super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  ProfileCubit cubit;
  bool hidePassword = true;
  final data = <FormFieldType, FormFieldModel>{};
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cubit = getIt<ProfileCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).profile_settings)),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        cubit: cubit,
        builder: (context, state) {
          return state.when(
            initial: _buildUi,
            loading: () => _buildUi(isLoading: true),
            success: (value) => _buildUi(),
            // TODO: Handel ERROR STATE
            failure: (message) => throw UnimplementedError(),
          );
        },
      ),
    );
  }

  Widget _buildUi({bool isLoading = false}) => MyLoadingOverLay(
        isLoading: isLoading,
        showSpinner: true,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AvatarSection(
                    onSaved: (newValue) {},
                    onChanged: (value) {
                      cubit.updateProfileImage(value.path);
                    },
                    remoteImageUrl: kUser.image,
                  ),
                  const SizedBox(height: 8),
                  _buildTextInput(
                    map: data,
                    type: FormFieldType.name,
                    initialValue: kUser.name,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 8),
                  _buildTextInput(
                    map: data,
                    type: FormFieldType.email,
                    initialValue: kUser.email,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 8),
                  _buildTextInput(
                    map: data,
                    type: FormFieldType.phone,
                    initialValue: kUser.phone,
                    enabled: !isLoading,
                  ),
                  // const SizedBox(height: 8),
                  // _buildTextInput(
                  //   map: data,
                  //   type: FormFieldType.password,
                  //   enabled: !isLoading,
                  //   obscureText: hidePassword,
                  //   suffixIcon: IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         hidePassword = !hidePassword;
                  //       });
                  //     },
                  //     color: Theme.of(context).focusColor,
                  //     icon: Icon(hidePassword
                  //         ? Icons.visibility
                  //         : Icons.visibility_off),
                  //   ),
                  // ),
                  const Divider(),
                  ElevatedButton(
                    onPressed: () {
                      Helpers.dismissFauces(context);
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        cubit.updateProfile(data);
                      }
                    },
                    child: Text(
                      S.of(context).save,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildTextInput({
    @required Map<FormFieldType, FormFieldModel> map,
    @required FormFieldType type,
    bool enabled = true,
    bool obscureText = false,
    String initialValue,
    Widget suffixIcon,
  }) {
    final _model = FormFieldModel.mapType(type, map);

    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: _model.keyboardType,
      onSaved: _model.onSave,
      validator: _model.validator,
      style: const TextStyle(fontSize: 14),
      enabled: enabled,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: _model.hintText,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: const EdgeInsets.all(12),
        hintText: _model.hintText,
        hintStyle:
            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        prefixIcon: Icon(_model.iconData, color: Theme.of(context).accentColor),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }
}
