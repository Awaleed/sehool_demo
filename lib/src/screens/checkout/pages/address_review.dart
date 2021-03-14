import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sehool/src/data/user_datasource.dart';
import 'package:sehool/src/models/form_data_model.dart';
import 'package:sehool/src/models/user_model.dart';
import 'package:validators/validators.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/address_card.dart';
import '../../../components/cart_dropdown.dart';
import '../../../cubits/address_cubit/address_cubit.dart';
import '../../../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../../../models/address_model.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../routes/config_routes.dart';
import '../../profile/dialogs/new_address_dialog.dart';

class AddressReviewPage extends StatefulWidget {
  const AddressReviewPage({
    Key key,
    @required this.cart,
    @required this.otherFormKey,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;
  final GlobalKey<FormState> otherFormKey;

  @override
  _AddressReviewPageState createState() => _AddressReviewPageState();
}

class _AddressReviewPageState extends State<AddressReviewPage> {
  DropdownCubit cubit;
  TextEditingController otherNameController;

  TextEditingController otherPhoneController;
  final addressDropdownKey = GlobalKey<CartDropdownState>();
  @override
  void initState() {
    super.initState();
    cubit = getIt<DropdownCubit>();
    otherNameController = TextEditingController(text: widget.cart?.otherName);
    otherPhoneController = TextEditingController(text: widget.cart?.otherPhone);
  }

  @override
  void dispose() {
    cubit.close();
    otherNameController.dispose();
    otherPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cart.organization) {
      if (widget.cart.association == null) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: Image.asset('assets/images/sign-warning.png'),
            title: Text(
              S.current.please_choose_an_association,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: Image.asset('assets/images/sign-warning.png'),
            title: Text(
              '${S.current.org_delivery_msg_p1} ${widget.cart.association?.name ?? ''} ${S.current.org_delivery_msg_p2}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
            ),
          ),
        );
      }
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          if (!widget.cart.pickup)
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
                backgroundColor: widget.cart.hasOtherName ? null : MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.9)),
              ),
              onPressed: widget.cart.hasOtherName
                  ? null
                  : () async {
                      final _cubit = getIt<AddressCubit>();
                      await AppRouter.sailor.navigate(
                        NewAddressDialog.routeName,
                        params: {'address_cubit': _cubit},
                      );
                      await _cubit.close();
                      await cubit.getDropdownValues(DropdownValueType.addresses);
                      setState(() {
                        final value = cubit.state.maybeWhen(
                              success: (values) => values?.isNotEmpty ?? false ? values.last : null,
                              orElse: () => null,
                            ) ??
                            widget.cart.address;

                        // widget.cart.address = value;
                        // widget.onChanged?.call(value);
                        addressDropdownKey?.currentState?.setValue(value);
                      });
                    },
              child: Text(
                S.current.add_a_new_address,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
              ),
            ),
          if (kUser.level == UserLevel.merchant)
            Row(
              children: [
                Switch(
                  value: widget.cart.pickup,
                  onChanged: (value) {
                    setState(() {
                      widget.cart.pickup = value;
                    });
                  },
                ),
                const SizedBox(width: 10),
                Text(S.current.pickup),
              ],
            ),
          if (!widget.cart.pickup) ...[
            Row(
              children: [
                Switch(
                  value: widget.cart.hasOtherName,
                  onChanged: (value) {
                    widget.cart.otherName = null;
                    setState(() {
                      widget.cart.hasOtherName = value;
                    });
                  },
                ),
                const SizedBox(width: 10),
                Text(S.current.the_recipient_is_someone_else),
              ],
            ),
            if (widget.cart.hasOtherName) ...[
              Form(
                key: widget.otherFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: otherNameController,
                      decoration: InputDecoration(
                        hintText: S.current.full_name,
                        hintStyle: const TextStyle(color: Colors.black26),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                      validator: Validators.shortStringValidator,
                      onChanged: (value) {
                        widget.cart.otherName = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: otherPhoneController,
                      decoration: InputDecoration(
                        hintText: S.current.phone,
                        hintStyle: const TextStyle(color: Colors.black26),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!isNumeric(value.trim()) || value.isEmpty || value == null) {
                          return S.current.enter_a_valid_number;
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                      onChanged: (value) {
                        widget.cart.otherPhone = value;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.9)),
                ),
                onPressed: () async {
                  final _cubit = getIt<AddressCubit>();
                  await AppRouter.sailor.navigate(
                    NewAddressDialog.routeName,
                    params: {'address_cubit': _cubit},
                  );
                  await _cubit.close();
                  await cubit.getDropdownValues(DropdownValueType.addresses);
                  setState(() {
                    final value = cubit.state.maybeWhen(
                          success: (values) => values?.isNotEmpty ?? false ? values.last : null,
                          orElse: () => null,
                        ) ??
                        widget.cart.address;

                    // widget.cart.address = value;
                    // widget.onChanged?.call(value);
                    addressDropdownKey?.currentState?.setValue(value);
                  });
                },
                child: Text(
                  S.current.add_recipient_address,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ),
            ],
            const SizedBox(height: 10),
            AddressCard(address: widget.cart.address),
            const SizedBox(height: 10),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(3),
                child: SvgPicture.asset('assets/images/31_104880.svg'),
              ),
              title: Text(
                S.current.saved_addresses,
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(S.current.please_choose_one),
            ),
            const SizedBox(height: 10),
            CartDropdown(
              key: addressDropdownKey,
              // isRadio: true,
              dropdownType: DropdownValueType.addresses,
              initialValue: widget.cart.address,
              itemAsString: (value) => (value as AddressModel).address,
              cubit: cubit,
              onValueChanged: (value) {
                setState(() {
                  widget.cart.address = value;
                });
                widget.onChanged(value);
              },
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
