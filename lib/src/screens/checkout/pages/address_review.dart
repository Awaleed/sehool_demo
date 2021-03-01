import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sehool/generated/l10n.dart';

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
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _AddressReviewPageState createState() => _AddressReviewPageState();
}

class _AddressReviewPageState extends State<AddressReviewPage> {
  DropdownCubit cubit;
  TextEditingController otherNameController;

  TextEditingController otherPhoneController;

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
      return SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.white70,
              // shape: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(25),
              // ),
              child: ListTile(
                leading: Image.asset('assets/images/sign-warning.png'),
                title: Text(
                  '${S.current.org_delivery_msg_p1} ${widget.cart.association?.name ?? ''} ${S.current.org_delivery_msg_p2}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Card(
            color: Colors.white70,
            // shape: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(25),
            // ),
            child: ListTile(
              tileColor: widget.cart.hasOtherName ? Colors.grey.withOpacity(.7) : null,
              title: Text(
                S.current.add_a_new_address,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
              ),
              onTap: widget.cart.hasOtherName
                  ? null
                  : () async {
                      final _cubit = getIt<AddressCubit>();
                      await AppRouter.sailor.navigate(
                        NewAddressDialog.routeName,
                        params: {'address_cubit': _cubit},
                      );
                      await _cubit.close();
                      cubit.getDropdownValues(DropdownValueType.addresses);
                    },
            ),
          ),
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
            TextField(
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
              style: const TextStyle(fontWeight: FontWeight.bold),
              onChanged: (value) {
                widget.cart.otherName = value;
              },
            ),
            const SizedBox(height: 10),
            TextField(
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
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
              onChanged: (value) {
                widget.cart.otherPhone = value;
              },
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              // shape: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(25),
              // ),
              child: ListTile(
                title: Text(
                  S.current.add_recipient_address,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                ),
                onTap: () async {
                  final _cubit = getIt<AddressCubit>();
                  await AppRouter.sailor.navigate(
                    NewAddressDialog.routeName,
                    params: {'address_cubit': _cubit},
                  );
                  await _cubit.close();
                  cubit.getDropdownValues(DropdownValueType.addresses);
                },
              ),
            ),
          ],
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AddressCard(address: widget.cart.address),
          ),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CartDropdown(
                isRadio: true,
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
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
