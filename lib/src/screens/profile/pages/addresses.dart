import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/address_card.dart';
import '../../../components/empty_addresses_widget.dart';
import '../../../components/my_error_widget.dart';
import '../../../components/ripple_animation.dart';
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
    return RefreshIndicator(
      onRefresh: cubit.getAddresses,
      child: Parent(
        style: ParentStyle()
          ..linearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.amber,
              Colors.black,
            ],
          ), //..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
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
                  child: const Icon(FluentIcons.location_28_regular, color: Colors.white, size: 20),
                ),
                Text(
                  S.current.addresses,
                  style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: BlocBuilder<AddressCubit, AddressState>(
            cubit: cubit,
            builder: (context, state) {
              return state.when(
                initial: _buildUi,
                created: _buildUi,
                loading: () => _buildUi(isLoading: true),
                success: (value) => _buildUi(addresses: value),
                failure: (message) => MyErrorWidget(
                  onRetry: () {
                    cubit.getAddresses();
                  },
                  message: message,
                ),
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
      ),
    );
  }

  Widget _buildUi({
    List<AddressModel> addresses = const [],
    bool isLoading = false,
  }) {
    if (addresses.isEmpty && !isLoading) {
      return const EmptyAddressesWidget();
    }
    return ListView.separated(
      itemCount: isLoading ? addresses.length + 5 : addresses.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        if (index >= addresses.length) {
          return const AddressLoadingCard();
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                AddressCard(address: addresses[index]),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          final action = CupertinoActionSheet(
                            title: Text(
                              S.current.delete_address,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            message: Theme(
                              data: Theme.of(context),
                              child: Text(
                                '${S.current.address} ${addresses[index].address}',
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context, true);
                                  cubit.deleteAddress(addresses[index].id);
                                },
                                child: Text(
                                  S.current.confirmation,
                                  style: Theme.of(context).textTheme.button.copyWith(color: Colors.red),
                                ),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text(
                                S.current.cancel,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          );
                          showCupertinoModalPopup(context: context, builder: (context) => action);
                        },
                        icon: const Icon(Icons.delete),
                        label: Text(S.current.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class AddressLoadingCard extends StatelessWidget {
  const AddressLoadingCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.zero,
            color: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    ' ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -80,
            left: 15,
            right: 15,
            height: 150,
            child: _HomeCard(),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
