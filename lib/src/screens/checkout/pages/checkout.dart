import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sehool/src/models/order_model.dart';
import 'package:supercharged/supercharged.dart';

import 'package:sehool/generated/l10n.dart';
import 'package:sehool/src/data/user_datasource.dart';

import '../../../components/checkout_address.dart';
import '../../../models/cart_model.dart';
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
              child: _SummeryCard(cart: cart),
            ),
          ),
          const SizedBox(height: 20),
          if (cart.pickupMethod == PickupMethod.delivery) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CheckoutAddressCard(cart: cart),
              ),
            ),
            const SizedBox(height: 20),
          ],
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ShippingDateCard(
                cart: cart,
                enabeld: false,
                onChanged: null,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                initialValue: cart.notes,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.headline4),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(S.current.checkout),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SummeryCard extends StatelessWidget {
  const _SummeryCard({Key key, @required this.cart}) : super(key: key);
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
                      title: Text(e.product.name),
                      subtitle: Text(
                        '${e.quantity} ${S.current.piece}, ${e.slicingMethod.name}',
                      ),
                      trailing: Text('${cart.total} ${S.current.rial}'),
                    ),
                  ),
                  const Divider(),
                  Text(
                    S.current.total,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.zero,
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      title: Text('${cart.total} ${S.current.rial}'),
                    ),
                  ),
                  const Divider(),
                  Text(
                    S.current.payment_mode,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.zero,
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(title: Text('${cart.paymentMethod}')),
                  ),
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

class _HomeCardAddress extends StatelessWidget {
  const _HomeCardAddress({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Hero(
            tag: 'image$id',
            createRectTween: (begin, end) => RectTween(begin: begin, end: end),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TotalCardAddress extends StatelessWidget {
  const _TotalCardAddress({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
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
                    ' ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('المدينة'),
                    subtitle: Text('10'),
                  ),
                  ListTile(
                    title: Text('الحي'),
                    subtitle: Text('بدون'),
                  ),
                  ListTile(
                    title: Text('العنوان'),
                    subtitle: Text('بدون'),
                  ),
                  ListTile(
                    title: Text('ملاحظات'),
                    subtitle: Text('بدون'),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -80,
            left: 15,
            right: 15,
            height: 150,
            child: _HomeCardAddress(),
          ),
        ],
      ),
    );
  }
}

class _HomeCardDate extends StatelessWidget {
  const _HomeCardDate({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Hero(
            tag: 'image$id',
            createRectTween: (begin, end) => RectTween(begin: begin, end: end),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TotalCardDate extends StatelessWidget {
  const _TotalCardDate({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  'التاريخ',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    ),
                    title: Text(
                      DateFormat.MEd().format(
                        DateTime.now().add(
                          random.integer(30).days,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      'بعد 3 ايام',
                    ),
                  ),
                ),
                const Divider(),
                Text(
                  'الساعة',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    onTap: () => showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute,
                      ),
                    ),
                    title: Text(
                      DateFormat.Hm().format(
                        DateTime.now().add(
                          random.integer(30).days,
                        ),
                      ),
                    ),
                    subtitle: Text('صباحا'),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
