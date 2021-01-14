import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sehool/init_injectable.dart';
import 'package:sehool/src/components/cart_text_field.dart';
import 'package:sehool/src/cubits/cart_cubit/cart_cubit.dart';
import 'package:sehool/src/models/cart_model.dart';
import 'package:sehool/src/models/order_model.dart';
import 'package:sehool/src/screens/checkout/pages/pickup.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../patched_components/stepper.dart';
import 'pages/address_review.dart';
import 'pages/cart_review.dart';
import 'pages/checkout.dart';
import 'pages/checkout_notes.dart';
import 'pages/payment_method_review.dart';
import 'pages/shpping_date_review.dart';
import 'package:supercharged/supercharged.dart';

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
  ValueChanged get onChange => (_) => setState(() {});
  List<_StepItem> get steps => [
        _StepItem(
          label: 'محتويات العربة',
          child: CartReviewPage(
            cartItems: widget.cart.cartItems,
            onChanged: onChange,
          ),
        ),
        _StepItem(
          label: 'نوع التوصيل',
          child: PickupPage(
            cart: widget.cart,
            onChanged: onChange,
          ),
        ),
        _StepItem(
          label: 'عنوان الشحن',
          child: AddressReviewPage(
            cart: widget.cart,
            onChanged: onChange,
          ),
          state: widget.cart?.pickupMethod == PickupMethod.delivery
              ? PatchedStepState.indexed
              : PatchedStepState.disabled,
        ),
        _StepItem(
          label: 'موعد الشحن',
          child: ShippingDatePage(
            cart: widget.cart,
            onChanged: onChange,
          ),
          state: widget.cart?.pickupMethod == PickupMethod.delivery
              ? PatchedStepState.indexed
              : PatchedStepState.disabled,
        ),
        _StepItem(
          label: 'ملاحظاف',
          child: CheckoutNotesPage(
            cart: widget.cart,
            onChanged: onChange,
          ),
        ),
        _StepItem(
          label: 'الدفع',
          child: PaymentMethodReviewPage(),
        ),
        _StepItem(
          label: 'انهاء',
          child: CheckoutPage(
            cart: widget.cart,
            onChanged: onChange,
          ),
        ),
      ];

  List<PatchedStep> get stepsWidget {
    return <PatchedStep>[
      for (var i = 0; i < steps.length; i++)
        PatchedStep(
          index: i,
          isActive: currentStep == i,
          state: steps[i].state,
          title: Text(
            steps[i].label,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: steps[i].icon,
          content: steps[i].child,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PatchedStepper(
            currentPatchedStep: currentStep,
            physics: const BouncingScrollPhysics(),
            onPatchedStepTapped: (value) => setState(() => currentStep = value),
            patchedSteps: stepsWidget,
            controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
                const SizedBox.shrink(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: <Widget>[
              _buildButton(
                label: Row(
                  children: const [
                    Icon(FluentIcons.arrow_left_24_regular),
                    SizedBox(width: 10),
                    Text('السابق'),
                  ],
                ),
                enabled: currentStep == 0,
                onTap: () {
                  for (var i = currentStep - 1; i >= 0; i--) {
                    final _StepItem step = steps[i];
                    if (step.state == PatchedStepState.disabled) {
                      continue;
                    } else {
                      setState(() => currentStep = i);
                      break;
                    }
                  }
                },
              ),
              const Spacer(),
              _buildButton(
                label: Row(
                  children: const [
                    Text('التالي'),
                    SizedBox(width: 10),
                    Icon(FluentIcons.arrow_right_24_regular),
                  ],
                ),
                enabled: currentStep == steps.length - 1,
                onTap: () {
                  for (var i = currentStep + 1; i < steps.length; i++) {
                    final _StepItem step = steps[i];
                    if (step.state == PatchedStepState.disabled) {
                      continue;
                    } else {
                      setState(() => currentStep = i);
                      break;
                    }
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildButton({
    Widget label,
    bool enabled = true,
    VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      onPressed: enabled ? null : onTap,
      child: label,
    );
  }
}

class _StepItem {
  final String label;
  final Widget child;
  final Widget icon;
  final PatchedStepState state;
  _StepItem({
    this.label,
    this.child,
    this.icon = const Icon(
      Icons.track_changes,
      color: Colors.amber,
      size: 100,
    ),
    this.state = PatchedStepState.indexed,
  });
}
