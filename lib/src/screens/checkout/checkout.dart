import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sehool/init_injectable.dart';
import 'package:sehool/src/cubits/cart_cubit/cart_cubit.dart';
import 'package:sehool/src/models/cart_model.dart';
import 'package:sehool/src/models/order_model.dart';
import 'package:sehool/src/screens/checkout/pages/pickup.dart';

import '../../patched_components/stepper.dart';
import 'pages/address_review.dart';
import 'pages/cart_review.dart';
import 'pages/checkout.dart';
import 'pages/checkout_notes.dart';
import 'pages/payment_method_review.dart';
import 'pages/shpping_date_review.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CheckoutScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // pinned: true,
        // expandedHeight: 400,
        elevation: 0,
        backgroundColor: Colors.black54,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: BlocBuilder<CartCubit, CartState>(
              cubit: getIt<CartCubit>(),
              builder: (context, state) => CheckoutStepper(cart: state.cart),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutStepper extends StatefulWidget {
  const CheckoutStepper({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  _CheckoutStepperState createState() => _CheckoutStepperState();
}

class _CheckoutStepperState extends State<CheckoutStepper> {
  int currentStep = 0;
  List<PatchedStep> get steps => [
        PatchedStep(
          isActive: 0 == currentStep,
          title: const Text('محتويات العربة',
              style: TextStyle(color: Colors.white)),
          content: CartReviewPage(cartItems: widget.cart.cartItems),
        ),
        PatchedStep(
          isActive: 1 == currentStep,
          title:
              const Text('نوع التوصيل', style: TextStyle(color: Colors.white)),
          content: PickupPage(cart: widget.cart),
        ),
        PatchedStep(
          isActive: 2 == currentStep,
          title:
              const Text('عنوان الشحن', style: TextStyle(color: Colors.white)),
          content: AddressReviewPage(cart: widget.cart),
        ),
        PatchedStep(
          isActive: 3 == currentStep,
          title:
              const Text('موعد الشحن', style: TextStyle(color: Colors.white)),
          content: ShippingDatePage(cart: widget.cart),
        ),
        PatchedStep(
          isActive: 4 == currentStep,
          title: const Text('ملاحظاف', style: TextStyle(color: Colors.white)),
          content: CheckoutNotesPage(cart: widget.cart),
        ),
        PatchedStep(
          isActive: 5 == currentStep,
          title: const Text('الدفع', style: TextStyle(color: Colors.white)),
          content: const PaymentMethodReviewPage(),
        ),
        PatchedStep(
          isActive: 6 == currentStep,
          title: const Text('انهاء', style: TextStyle(color: Colors.white)),
          content: const CheckoutPage(),
        ),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PatchedStepper(
            currentPatchedStep: currentStep,
            physics: const BouncingScrollPhysics(),
            onPatchedStepTapped: (value) => setState(() {
              currentStep = value;
            }),
            type: PatchedStepperType.horizontal,
            controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
                const SizedBox.shrink(),
            patchedSteps: steps,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: currentStep == 0
                    ? null
                    : () {
                        setState(() {
                          currentStep--;
                        });
                      },
                child: Row(
                  children: const [
                    Icon(FluentIcons.arrow_left_24_regular),
                    SizedBox(width: 10),
                    Text('السابق'),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: currentStep == steps.length - 1
                    ? null
                    : () {
                        setState(() {
                          currentStep++;
                        });
                      },
                child: Row(
                  children: const [
                    Text('التالي'),
                    SizedBox(width: 10),
                    Icon(FluentIcons.arrow_right_24_regular),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Card(
              color: Colors.white70,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Text(faker.lorem.word()),
                      const Spacer(),
                      RatingBarIndicator(
                        rating: 2.75,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 13.0,
                        // direction: Axis.vertical,
                      )
                    ],
                  ),
                ),
                subtitle: Text(faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence()),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: -10,
            child: CircleAvatar(
              radius: 30,
            ),
          )
        ],
      ),
    );
  }
}
