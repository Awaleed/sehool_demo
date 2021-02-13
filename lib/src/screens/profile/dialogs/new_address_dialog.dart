import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sehool/src/screens/home/home.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/address_picker_card.dart';
import '../../../components/my_error_widget.dart';
import '../../../components/my_loading_overlay.dart';
import '../../../cubits/address_cubit/address_cubit.dart';
import '../../../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../../../helpers/helper.dart';
import '../../../models/address_model.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../models/form_data_model.dart';
import '../../../patched_components/places_picker/src/place_picker.dart';
import '../../../routes/config_routes.dart';

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
  DropdownCubit cityCubit;

  @override
  void initState() {
    super.initState();
    cityCubit = getIt<DropdownCubit>();
    cityCubit.getDropdownValues(DropdownValueType.cites);
  }

  @override
  void dispose() {
    cityCubit.close();
    super.dispose();
  }

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
                        BlocBuilder<DropdownCubit, DropdownState>(
                          cubit: cityCubit,
                          builder: (context, state) {
                            return state.when(
                              initial: () => _buildCityDropdownUI([], isLoading: true),
                              loading: () => _buildCityDropdownUI([], isLoading: true),
                              success: (values) => _buildCityDropdownUI(values),
                              failure: (message) => MyErrorWidget(
                                onRetry: () {
                                  cityCubit.getDropdownValues(
                                    DropdownValueType.cites,
                                  );
                                },
                                message: message,
                              ),
                            );
                          },
                        ),
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
          floatingActionButton: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(),
              Expanded(
                child: FloatingActionButton(
                  onPressed: () async {
                    Helpers.dismissFauces(context);
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      cubit.addAddress(data);
                    }
                  },
                  child: const Icon(FluentIcons.save_24_regular, color: Colors.white),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: WhatsappFloatingActionButton(),
                    )
                  ],
                ),
              ),
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
                initialPosition: const LatLng(
                  15.591851764538097,
                  32.520090490579605,
                ),
                onSave: (newValue) {
                  if (newValue != null) {
                    onSaved(newValue);
                    state.didChange(newValue);
                    _model.onSave(newValue);
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
      decoration: InputDecoration(
        labelText: _model.hintText,
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

  Widget _buildCityDropdownUI(List values, {bool isLoading = false}) {
    return Column(
      children: [
        _buildDropdownInput(
          values: values,
          value: selectedCity,
          type: FormFieldType.cityId,
          enabled: !isLoading,
          onChanged: (value) => setState(() {
            selectedCity = value;
          }),
        ),
        const SizedBox(height: 10),
        _buildDropdownInput(
          values: selectedCity?.sections ?? [],
          value: selectedSection,
          type: FormFieldType.citySectionId,
          enabled: !isLoading,
          onChanged: (value) => setState(() {
            selectedSection = value;
          }),
        ),
      ],
    );
  }

  Widget _buildDropdownInput({
    @required FormFieldType type,
    List values,
    dynamic value,
    bool enabled = true,
    ValueChanged onChanged,
  }) {
    final _model = FormFieldModel.mapType(type, data);
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(_model.iconData, color: Theme.of(context).accentColor),
          labelStyle: TextStyle(color: Theme.of(context).accentColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
          hintText: _model.hintText,
          labelText: _model.labelText,
          hintStyle: TextStyle(color: Theme.of(context).accentColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        ),
        value: value,
        style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).accentColor),
        items: [
          ...values.map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name,
                overflow: TextOverflow.visible,
                // style: Theme.of(context)
                //     .textTheme
                //     .bodyText2
                //     .copyWith(color: Theme.of(context).accentColor),
              ),
            ),
          )
        ],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        validator: _model.validator,
        onSaved: (newValue) => _model.onSave('${newValue.id}'),
        onTap: () => Helpers.dismissFauces(context),
      ),
    );
  }
}
