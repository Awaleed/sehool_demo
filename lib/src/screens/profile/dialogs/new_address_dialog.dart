import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../generated/l10n.dart';
import '../../../components/address_picker_card.dart';
import '../../../components/my_error_widget.dart';
import '../../../components/my_loading_overlay.dart';
import '../../../cubits/address_cubit/address_cubit.dart';
import '../../../helpers/helper.dart';
import '../../../models/address_model.dart';
import '../../../models/form_data_model.dart';
import '../../../patched_components/places_picker/src/place_picker.dart';
import '../../../routes/config_routes.dart';
import '../../home/home.dart';

class NewAddressDialog extends StatefulWidget {
  static const routeName = '/addresses/new';

  const NewAddressDialog({
    Key key,
    this.cubit,
  }) : super(key: key);

  final AddressCubit cubit;

  @override
  _NewAddressDialogState createState() => _NewAddressDialogState();
}

class _NewAddressDialogState extends State<NewAddressDialog> {
  final formKey = GlobalKey<FormState>();
  final data = <String, dynamic>{};
  LatLng location;

  CityModel selectedCity;
  CitySectionModel selectedSection;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      cubit: widget.cubit,
      listener: (context, state) {
        state.maybeWhen(
          created: () {
            AppRouter.sailor.pop();
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildUi(context, widget.cubit),
          created: () => _buildUi(context, widget.cubit),
          loading: () => _buildUi(context, widget.cubit, isLoading: true),
          success: (value) => _buildUi(context, widget.cubit),
          failure: (message) => MyErrorWidget(
            onRetry: () {
              widget.cubit.retryAddAddress();
            },
            message: message,
          ),
        );
      },
    );
  }

  Widget _buildUi(
    BuildContext context,
    AddressCubit cubit, {
    bool isLoading = false,
  }) {
    return MyLoadingOverLay(
      isLoading: isLoading,
      showSpinner: true,
      child: Parent(
        style: ParentStyle()
          ..background.color(Colors.white)
          ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
        child: Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black54,
            title: Text(
              S.of(context).address,
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 8),
                        _buildTextInput(
                          context,
                          map: data,
                          type: FormFieldType.address,
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: 8),
                        _buildAddressCard(
                          context,
                          map: data,
                          enabled: !isLoading,
                          initialValue: location,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if (formKey?.currentState?.validate() ?? false)
                FloatingActionButton(
                  onPressed: () async {
                    Helpers.dismissFauces(context);
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      cubit.addAddress(data);
                    }
                  },
                  child: const Icon(FluentIcons.save_24_regular, color: Colors.white),
                ),
              const WhatsappFloatingActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(
    BuildContext context, {
    @required LatLng initialValue,
    @required Map<String, dynamic> map,
    bool enabled = true,
  }) {
    final _model = FormFieldModel.mapType(FormFieldType.location, map);

    return IgnorePointer(
      ignoring: !enabled,
      child: AddressPickerCard(
        key: ObjectKey(location),
        label: _model.labelText,
        onSaved: (newValue) {
          setState(() => location = newValue);
          _model.onSave(newValue);
        },
        validator: _model.validator,
        initialValue: initialValue,
        openMapScreen: (onSaved, state) {
          Helpers.dismissFauces(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlacePicker(
                initialPosition: LatLng(
                  location?.latitude ?? 24.860667,
                  location?.longitude ?? 46.674167,
                ),
                onSave: (newValue, region) {
                  if (newValue != null) {
                    onSaved(newValue);
                    state.didChange(newValue);
                    _model.onSave(newValue);
                    map['city_id'] = 1;
                    map['section_id'] = region;
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextInput(
    BuildContext context, {
    @required Map<String, dynamic> map,
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
      onChanged: (_) {
        setState(() {});
      },
      decoration: InputDecoration(
        labelText: _model.labelText,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: const EdgeInsets.all(12),
        hintText: _model.hintText,
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        prefixIcon: Icon(_model.iconData, color: Theme.of(context).accentColor),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }
}
