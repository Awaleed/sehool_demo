import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/src/components/ripple_animation.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/empty_addresses_widget.dart';
import '../../../cubits/address_cubit/address_cubit.dart';
import '../../../models/address_model.dart';
import '../../../routes/config_routes.dart';
import '../dialogs/new_address_dialog.dart';

class AddressesScreen extends StatefulWidget {
  static const routeName = '/addresses';

  const AddressesScreen({Key key}) : super(key: key);

  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  AddressCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = getIt<AddressCubit>();
    cubit.getAddresses();
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Parent(
                style: ParentStyle()
                  ..background.color(Colors.white.withOpacity(.1))
                  ..padding(all: 12)
                  ..borderRadius(all: 30),
                child: const Icon(FluentIcons.location_28_regular,
                    color: Colors.white, size: 20),
              ),
              Text(
                S.current.addresses,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: BlocBuilder<AddressCubit, AddressState>(
          cubit: cubit,
          builder: (context, state) {
            return state.when(
              initial: _buildUi,
              loading: () => _buildUi(isLoading: true),
              success: (value) => _buildUi(addresses: value),
              // TODO: Handel ERROR STATE
              failure: (message) => throw UnimplementedError(),
            );
          },
        ),
        floatingActionButton: RipplesAnimation(
          onPressed: () => AppRouter.sailor.navigate(
            NewAddressDialog.routeName,
            params: {'address_cubit': cubit},
          ),
          color: Colors.amberAccent,
          size: 30,
          child: const Icon(
            FluentIcons.add_28_filled,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildUi({
    List<AddressModel> addresses = const [],
    bool isLoading = false,
  }) =>
      addresses.isEmpty
          ? const EmptyAddressesWidget()
          : ListView.separated(
              itemCount: addresses.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final AddressModel address = addresses[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Stack(
                      children: [
                        InputDecorator(
                          decoration: InputDecoration(
                            isDense: true,
                            border: const OutlineInputBorder(),
                            labelText: S.current.shipping_address +
                                (index == 0
                                    ? ' - ${S.current.default_address}'
                                    : ''),
                            filled: false,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  '${S.current.address}: ${address.address}',
                                ),
                                Text(
                                  '${S.current.notes}: ${address.note ?? ''}',
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(S.current.show_on_map),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => cubit.deleteAddress(address.id),
                              child: Text(S.current.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
}
