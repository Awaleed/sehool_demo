import 'package:division/division.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailor/sailor.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/my_loading_overlay.dart';
import '../../../cubits/address_cubit/address_cubit.dart';
import '../../../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../../../helpers/helper.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../models/form_data_model.dart';

class NewAddressDialog extends StatelessWidget {
  static const routeName = '/addresses/new';

  NewAddressDialog({Key key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final data = <FormFieldType, FormFieldModel>{};

  @override
  Widget build(BuildContext context) {
    final cubit = Sailor.param<AddressCubit>(context, 'AddressCubit');
    return BlocBuilder<AddressCubit, AddressState>(
      cubit: cubit,
      builder: (context, state) {
        return state.when(
          initial: () => _buildUi(context, cubit),
          loading: () => _buildUi(context, cubit, isLoading: true),
          success: (value) => _buildUi(context, cubit),
          // TODO: Handel ERROR STATE
          failure: (message) => throw UnimplementedError(),
        );
      },
    );
  }

  Widget _buildUi(BuildContext context, AddressCubit cubit,
      {bool isLoading = false}) {
    return MyLoadingOverLay(
      isLoading: isLoading,
      showSpinner: true,
      child: Parent(
        style: ParentStyle()
          ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black54,
            title: Text(
              S.of(context).address,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(FluentIcons.save_24_regular),
                onPressed: () async {
                  Helpers.dismissFauces(context);
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Card(
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
                    _buildTextInput(
                      context,
                      map: data,
                      type: FormFieldType.notes,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 8),
                    _buildDropdownInput(
                      map: data,
                      type: FormFieldType.cityId,
                      dropType: DropdownValueType.cites,
                    ),
                    const SizedBox(height: 8),
                    _buildDropdownInput(
                      map: data,
                      type: FormFieldType.citySectionId,
                      dropType: DropdownValueType.citySections,
                    ),
                    const SizedBox(height: 8),
                    // _buildAddressPickerCard(
                    //   context,
                    //   map: data,
                    //   type: FormFieldType.email,
                    //   enabled: !isLoading,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // AddressPickerCard _buildAddressPickerCard(
  //   BuildContext context, {
  //   Map<FormFieldType, FormFieldModel> map,
  //   FormFieldType type,
  //   bool enabled,
  // }) {
  //   return AddressPickerCard(
  //     label: S.of(context).show_on_map,
  //     onSaved: (newValue) {
  //       // setState(() {
  //       //   location = newValue;
  //       // });
  //     },
  //     validator: (value) => value == null ? ' ' : null,
  //     // initialValue: location,
  //     openMapScreen: (onSaved, state) {
  //       Helpers.dismissFauces(context);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PlacePicker(
  //             initialPosition: const LatLng(
  //               15.591851764538097,
  //               32.520090490579605,
  //             ),
  //             onSave: (newValue) {
  //               if (newValue != null) {
  //                 onSaved(newValue);
  //                 state.didChange(newValue);
  //               }
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildTextInput(
    BuildContext context, {
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

  Widget _buildDropdownInput({
    @required Map<FormFieldType, FormFieldModel> map,
    @required FormFieldType type,
    @required DropdownValueType dropType,
  }) {
    final cubit = getIt<DropdownCubit>();
    final _model = FormFieldModel.mapType(type, map);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<DropdownCubit, DropdownState>(
        cubit: cubit..getDropdownValues(dropType),
        builder: (BuildContext context, DropdownState state) {
          return state.when(
            success: (values) {
              return DropdownSearch(
                items: values,
                label: _model.hintText,
                dropdownSearchDecoration:
                    const InputDecoration(border: InputBorder.none),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                // validator: (value) => _model.validator(value?.id?.toString()),
                // onSaved: (value) => _model.onSave(value?.id?.toString()),
              );
            },
            failure: (String message) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Txt(
                    message,
                    style: TxtStyle()
                      ..textColor(Colors.red)
                      ..bold()
                      ..fontSize(18),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Txt('اعادة تحميل'),
                    onPressed: () {
                      cubit.getDropdownValues(dropType);
                    },
                  ),
                ],
              );
            },
            initial: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
