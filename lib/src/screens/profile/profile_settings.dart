import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/avatar_section.dart';
import '../../components/background_images_generate.dart';
import '../../components/my_error_widget.dart';
import '../../components/my_loading_overlay.dart';
import '../../cubits/profile_cubit/profile_cubit.dart';
import '../../data/user_datasource.dart';
import '../../helpers/helper.dart';
import '../../models/form_data_model.dart';
import '../../models/user_model.dart';
import '../../routes/config_routes.dart';
import '../home/home.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static const routeName = '/profile_settings';

  const ProfileSettingsScreen({Key key}) : super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  ProfileCubit cubit;
  bool hidePassword = true;
  final data = <String, dynamic>{};
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
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
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
          Scaffold(
            floatingActionButton: const WhatsappFloatingActionButton(),
            backgroundColor: Colors.white70,
            appBar: AppBar(
              title: Text(
                S.current.profile_settings,
                style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.black54,
              elevation: 0,
            ),
            body: BlocBuilder<ProfileCubit, ProfileState>(
              cubit: cubit,
              builder: (context, state) {
                return state.when(
                  initial: _buildUi,
                  loading: () => _buildUi(isLoading: true),
                  success: (value) => _buildUi(),
                  failure: (message) => MyErrorWidget(
                    onRetry: () {
                      cubit.reset();
                    },
                    message: message,
                  ),
                );
              },
            ),
          ),
        ],
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
                  Parent(
                    style: ParentStyle()
                      ..background.color(Colors.white)
                      ..borderRadius(all: 10)
                      ..padding(all: 16, vertical: 40)
                      ..elevation(5),
                    child: Column(
                      children: [
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
                        const SizedBox(height: 8),
                        _buildTextInput(
                          map: data,
                          type: FormFieldType.password,
                          onSaved: (value) {
                            if (value is String && value.isNotEmpty) {
                              data['password'] = value.trim();
                            }
                          },
                          validator: (value) {
                            if (value is String && value.isNotEmpty) {
                              return Validators.longStringValidator(value);
                            } else {
                              return null;
                            }
                          },
                          enabled: !isLoading,
                        ),
                        if (kUser.level == UserLevel.merchant) ...[
                          const SizedBox(height: 8),
                          _buildTextInput(
                            map: data,
                            type: FormFieldType.storeName,
                            initialValue: kUser.storeName,
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 8),
                          _buildTextInput(
                            map: data,
                            type: FormFieldType.vatNumber,
                            initialValue: kUser.vatNumber,
                            enabled: !isLoading,
                          ),
                        ]
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Helpers.dismissFauces(context);
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        await cubit.updateProfile(data);
                        cubit.state.maybeWhen(
                          success: (_) {
                            AppRouter.sailor.pop();
                          },
                          orElse: () {},
                        );
                      }
                    },
                    child: Text(
                      S.current.save,
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
    @required Map<String, dynamic> map,
    @required FormFieldType type,
    bool enabled = true,
    bool obscureText = false,
    String initialValue,
    Widget suffixIcon,
    void Function(String) onSaved,
    String Function(dynamic) validator,
  }) {
    final _model = FormFieldModel.mapType(type, map);

    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: _model.keyboardType,
      onSaved: onSaved ?? _model.onSave,
      validator: validator ?? _model.validator,
      style: const TextStyle(fontSize: 14),
      enabled: enabled,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.amber.withOpacity(.2),
        filled: true,
        labelText: _model.labelText,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: const EdgeInsets.all(12),
        hintText: _model.hintText,
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        prefixIcon: Icon(_model.iconData, color: Theme.of(context).accentColor),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.0))),
      ),
    );
  }
}
