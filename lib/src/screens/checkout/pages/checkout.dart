import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/data/user_datasource.dart';
import 'package:sehool/src/helpers/helper.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/address_card.dart';
import '../../../cubits/cart_cubit/cart_cubit.dart';
import '../../../models/cart_model.dart';
import '../../../routes/config_routes.dart';
import '../../cart/add_to_cart.dart';
import '../checkout.dart';

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

class SummeryCard extends StatelessWidget {
  const SummeryCard({Key key, @required this.cart, this.onChanged}) : super(key: key);
  final CartModel cart;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          color: Colors.white.withOpacity(.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text(
                //   S.current.bill,
                //   style: Theme.of(context).textTheme.headline5,
                // ),
                // const Divider(),
                ...cart.cartItems.map(
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e?.product?.name ?? '',
                                        style: Theme.of(context).textTheme.headline6,
                                      ),
                                      Text(
                                        '${e.quantity} ${S.current.piece}, ${e.slicingMethod?.name}',
                                        style: Theme.of(context).textTheme.bodyText2,
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
                                onChanged(e);
                                AppRouter.sailor.navigate(
                                  CheckoutScreen.routeName,
                                  navigationType: NavigationType.pushReplace,
                                );
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
                    ),
                    onTap: () async {
                      await AppRouter.sailor.navigate(
                        AddToCartScreen.routeName,
                        params: {
                          'cart_item': e,
                          'editing': true,
                        },
                      );
                      if (cart.fromWallet && kUser.wallet < cart.total) {
                        Helpers.showErrorOverlay(context, error: S.current.sorry_your_balance_is_not_enough);
                        cart.fromWallet = false;
                      }
                      onChanged(e);
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
                  title: Text(S.current.delivery_price, style: Theme.of(context).textTheme.bodyText2),
                  trailing: Text('${cart.deliveryFees.format()} ﷼', style: Theme.of(context).textTheme.bodyText2),
                ),
                ListTile(
                  title: Text(S.current.total, style: Theme.of(context).textTheme.bodyText2),
                  trailing: Text('${cart.subtotalWithDelivery.format()} ﷼', style: Theme.of(context).textTheme.bodyText2),
                ),
                const Divider(),
                if (cart.discountAmount > 0) ...[
                  ListTile(
                    // tileColor: Colors.amber.withOpacity(.8),
                    title: Text(S.current.discount, style: Theme.of(context).textTheme.bodyText2),
                    trailing: Text('${cart.discountAmount.format()} ﷼', style: Theme.of(context).textTheme.bodyText2),
                  ),
                  ListTile(
                    // tileColor: Colors.amber.withOpacity(.8),
                    title: Text(S.current.discounted_total, style: Theme.of(context).textTheme.bodyText2),
                    trailing: Text('${cart.discountedSubtotal.format()} ﷼', style: Theme.of(context).textTheme.bodyText2),
                  ),
                  const Divider(),
                ],
                ListTile(
                  title: Text(S.current.tax, style: Theme.of(context).textTheme.bodyText2),
                  trailing: Text('${cart.tax.format()} ﷼', style: Theme.of(context).textTheme.bodyText2),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ListTile(
                    // tileColor: Colors.cyan.withOpacity(.8),
                    title: Text(S.current.net_bill, style: Theme.of(context).textTheme.bodyText1),
                    trailing: Text('${cart.total.format()} ﷼', style: Theme.of(context).textTheme.bodyText1),
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
            ),
          ),
        ),
        // Positioned(
        //   top: -75,
        //   left: 15,
        //   right: 15,
        //   height: 120,
        //   child: Card(
        //     elevation: 2,
        //     clipBehavior: Clip.hardEdge,
        //     color: Colors.amber.withOpacity(.8),
        //     margin: EdgeInsets.zero,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(25),
        //     ),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(25),
        //       child: FittedBox(
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(S.current.summery),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

extension on double {
  String format() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}
