import 'package:bloc/bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/components/my_error_widget.dart';
import 'package:sehool/src/core/api_caller.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/address_card.dart';
import '../../../cubits/cart_cubit/cart_cubit.dart';
import '../../../data/user_datasource.dart';
import '../../../helpers/helper.dart';
import '../../../models/cart_model.dart';
import '../../../routes/config_routes.dart';
import '../../cart/add_to_cart.dart';
import '../checkout.dart';

enum _DeliveryFeesState { initial, loading, success, failure }

class _DeliveryFeesCubit extends Cubit<_DeliveryFeesState> with ApiCaller {
  _DeliveryFeesCubit() : super(_DeliveryFeesState.initial);
  double deliveryFees;

  Future<void> getDeliveryFees() async {
    emit(_DeliveryFeesState.loading);
    try {
      final res = await get(path: '/deliveryfees');
      if (res is Map) {
        deliveryFees = double.tryParse(res['delivery_fees']) ?? 0;
        emit(_DeliveryFeesState.success);
      }
    } catch (e) {
      emit(_DeliveryFeesState.failure);
      addError(e);
    }
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    Key key,
    @required this.cart,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SummeryCard(cart: cart),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AddressCard(address: cart.address),
            ),
          ),
          // const SizedBox(height: 20),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: ShippingDateCard(
          //       cart: cart,
          //       enabeld: false,
          //       onChanged: null,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: TextFormField(
          //       initialValue: cart.note,
          //       readOnly: true,
          //       decoration: InputDecoration(
          //         filled: true,
          //         fillColor: Colors.white70,
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(25),
          //         ),
          //       ),
          //       keyboardType: TextInputType.multiline,
          //       minLines: 7,
          //       maxLines: 14,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class SummeryCard extends StatefulWidget {
  const SummeryCard({Key key, @required this.cart, this.onChanged})
      : super(key: key);
  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _SummeryCardState createState() => _SummeryCardState();
}

class _SummeryCardState extends State<SummeryCard> {
  _DeliveryFeesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = _DeliveryFeesCubit();
    cubit.getDeliveryFees();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
        color: Colors.white.withOpacity(.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<_DeliveryFeesCubit, _DeliveryFeesState>(
              cubit: cubit,
              listener: (context, state) {
                if (state == _DeliveryFeesState.success) {
                  widget.cart.deliveryFees = cubit.deliveryFees;
                  widget.onChanged(widget.cart);
                }
              },
              builder: (context, state) {
                if (state == _DeliveryFeesState.loading ||
                    state == _DeliveryFeesState.initial) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  );
                } else if (state == _DeliveryFeesState.failure) {
                  return MyErrorWidget(
                    onRetry: () => cubit.getDeliveryFees(),
                    message: S.current.an_error_occurred,
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text(
                      //   S.current.bill,
                      //   style: Theme.of(context).textTheme.headline5,
                      // ),
                      // const Divider(),
                      ...widget.cart.cartItems.map(
                        (e) => ListTile(
                          leading: IconButton(
                            icon: const Icon(
                              FluentIcons.delete_24_regular,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              final action = CupertinoActionSheet(
                                title: Text(
                                  S.current.remove_from_cart,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                message: Theme(
                                  data: Theme.of(context),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e?.product?.name ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Text(
                                              '${e.quantity} ${S.current.piece}, ${e.slicingMethod?.name}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text('${e.total.format()} ﷼'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      getIt<CartCubit>().removeItem(e);
                                      widget.onChanged(e);
                                      AppRouter.sailor.navigate(
                                        CheckoutScreen.routeName,
                                        navigationType:
                                            NavigationType.pushReplace,
                                      );
                                    },
                                    child: Text(
                                      S.current.confirmation,
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .copyWith(color: Colors.red),
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
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => action);
                            },
                          ),
                          onTap: () async {
                            await AppRouter.sailor.navigate(
                              AddToCartScreen.routeName,
                              params: {
                                'cart_item': e,
                                'editing': true,
                              },
                            );
                            if (widget.cart.fromWallet &&
                                kUser.wallet < widget.cart.total) {
                              Helpers.showErrorOverlay(context,
                                  error: S.current
                                      .sorry_your_balance_is_not_enough);
                              widget.cart.fromWallet = false;
                            }
                            widget.onChanged(e);
                          },
                          title: Text(e?.product?.name ?? ''),
                          subtitle: Text(
                            '${e.quantity} ${S.current.piece}, ${e.slicingMethod?.name}',
                          ),
                          trailing: Text('${e.total.format()} ﷼'),
                        ),
                      ),
                      const Divider(),
                      // ListTile(
                      //   title: Text(S.current.subtotal,style: Theme.of(context).textTheme.bodyText2),
                      //   trailing: Text('${cart.subtotal.format()} ﷼',style: Theme.of(context).textTheme.bodyText2),
                      // ),
                      ListTile(
                        title: Text(S.current.delivery_price,
                            style: Theme.of(context).textTheme.bodyText2),
                        trailing: Text('${widget.cart.deliveryFees.format()} ﷼',
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      ListTile(
                        title: Text(S.current.total,
                            style: Theme.of(context).textTheme.bodyText2),
                        trailing: Text(
                            '${widget.cart.subtotalWithDelivery.format()} ﷼',
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      const Divider(),
                      if (widget.cart.discountAmount > 0) ...[
                        ListTile(
                          // tileColor: Colors.amber.withOpacity(.8),
                          title: Text(S.current.discount,
                              style: Theme.of(context).textTheme.bodyText2),
                          trailing: Text(
                              '${widget.cart.discountAmount.format()} ﷼',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        ListTile(
                          // tileColor: Colors.amber.withOpacity(.8),
                          title: Text(S.current.discounted_total,
                              style: Theme.of(context).textTheme.bodyText2),
                          trailing: Text(
                              '${widget.cart.discountedSubtotal.format()} ﷼',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        const Divider(),
                      ],
                      ListTile(
                        title: Text(S.current.tax,
                            style: Theme.of(context).textTheme.bodyText2),
                        trailing: Text('${widget.cart.tax.format()} ﷼',
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: ListTile(
                          // tileColor: Colors.cyan.withOpacity(.8),
                          title: Text(S.current.net_bill,
                              style: Theme.of(context).textTheme.bodyText1),
                          trailing: Text('${widget.cart.total.format()} ﷼',
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),

                      // Text(
                      //   S.current.total,
                      //   style: Theme.of(context).textTheme.headline5,
                      // ),
                      // const Divider(),
                      // Card(
                      //   elevation: 2,
                      //   clipBehavior: Clip.hardEdge,
                      //   margin: EdgeInsets.zero,
                      //   color: Colors.white70,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(25),
                      //   ),
                      //   child: ListTile(
                      //     title: Text('${cart.total.format()} ﷼'),
                      //   ),
                      // ),
                      // const Divider(),
                      // Text(
                      //   S.current.payment_mode,
                      //   style: Theme.of(context).textTheme.headline5,
                      // ),
                      // const Divider(),
                      // Card(
                      //   elevation: 2,
                      //   clipBehavior: Clip.hardEdge,
                      //   margin: EdgeInsets.zero,
                      //   color: Colors.white70,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(25),
                      //   ),
                      //   child: ListTile(title: Text(cart.paymentMethod.name)),
                      // ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

extension on double {
  String format() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}
