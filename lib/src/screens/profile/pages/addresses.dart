import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/routes/config_routes.dart';
import 'package:sehool/src/screens/profile/dialogs/new_address_dialog.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/empty_addresses_widget.dart';
import '../../../cubits/address_cubit/address_cubit.dart';
import '../../../models/address_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addresses),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => AppRouter.sailor.navigate(
              NewAddressDialog.routeName,
              params: {'AddressCubit': cubit},
            ),
          ),
        ],
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
                            labelText: S.of(context).shipping_address +
                                (index == 0
                                    ? ' - ${S.of(context).default_address}'
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
                                  '${S.of(context).address}: ${address.address}',
                                ),
                                Text(
                                  '${S.of(context).notes}: ${address.note ?? ''}',
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(S.of(context).show_on_map),
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
                              child: Text(S.of(context).delete),
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