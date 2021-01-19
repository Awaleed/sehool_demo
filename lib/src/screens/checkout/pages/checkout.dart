import 'package:flutter/material.dart';
import 'package:sehool/src/components/address_card.dart';

import '../../../../generated/l10n.dart';
import '../../../models/cart_model.dart';
import '../../../models/order_model.dart';
import 'shpping_date_review.dart';

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
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                initialValue: cart.note,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 7,
                maxLines: 14,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class SummeryCard extends StatelessWidget {
  const SummeryCard({Key key, @required this.cart}) : super(key: key);
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 75),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 10,
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
                    '',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  ...cart.cartItems.map(
                    (e) => ListTile(
                      title: Text(e?.product?.name ?? ''),
                      subtitle: Text(
                        '${e.quantity} ${S.current.piece}, ${e.slicingMethod?.name}',
                      ),
                      trailing: Text('${cart.total} ${S.current.rial}'),
                    ),
                  ),
                  // const Divider(),
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
                  //     title: Text('${cart.total} ${S.current.rial}'),
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
          Positioned(
            top: -75,
            left: 15,
            right: 15,
            height: 150,
            child: Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              color: Colors.amber.withOpacity(.8),
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.current.summery),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
