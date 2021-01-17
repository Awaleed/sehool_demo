import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/generated/l10n.dart';

import '../../../init_injectable.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../models/cart_model.dart';
import '../../models/order_model.dart';
import '../../patched_components/stepper.dart';
import 'pages/address_review.dart';
import 'pages/cart_review.dart';
import 'pages/checkout.dart';
import 'pages/checkout_notes.dart';
import 'pages/payment_method_review.dart';
import 'pages/pickup.dart';
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
  ValueChanged get onChange => (_) => setState(() {});
  List<_StepItem> get steps => [
        _StepItem(
            label: S.current.cart_contents,
            child: CartReviewPage(
              cartItems: widget.cart.cartItems,
              onChanged: onChange,
            ),
            icon: const Icon(
              FluentIcons.cart_24_regular,
              size: 50,
              color: Colors.amber,
            ),
            header: FluentIcons.cart_24_regular),
        _StepItem(
          label: S.current.pickup_method,
          child: PickupPage(
            cart: widget.cart,
            onChanged: onChange,
          ),
          icon: const Icon(
            Icons.delivery_dining,
            size: 50,
            color: Colors.amber,
          ),
          header: Icons.delivery_dining,
        ),
        _StepItem(
          label: S.current.shipping_address,
          child: AddressReviewPage(
            cart: widget.cart,
            onChanged: onChange,
          ),
          icon: const Icon(
            FluentIcons.location_48_regular,
            size: 50,
            color: Colors.amber,
          ),
          header: FluentIcons.location_48_regular,
          state: widget.cart?.pickupMethod == PickupMethod.delivery
              ? PatchedStepState.indexed
              : PatchedStepState.disabled,
        ),
        _StepItem(
          label: S.current.delivery_date,
          header: FluentIcons.calendar_28_regular,
          child: ShippingDatePage(
            cart: widget.cart,
            onChanged: onChange,
          ),
          icon: const Icon(
            FluentIcons.calendar_28_regular,
            size: 50,
            color: Colors.amber,
          ),
          state: widget.cart?.pickupMethod == PickupMethod.delivery
              ? PatchedStepState.indexed
              : PatchedStepState.disabled,
        ),
        _StepItem(
            label: S.current.notes,
            icon: const Icon(
              FluentIcons.note_24_regular,
              size: 50,
              color: Colors.amber,
            ),
            child: CheckoutNotesPage(
              cart: widget.cart,
              onChanged: onChange,
            ),
            header: FluentIcons.note_24_regular),
        _StepItem(
            label: S.current.payment_mode,
            child: PaymentMethodReviewPage(
              cart: widget.cart,
              onChanged: onChange,
            ),
            icon: const Icon(
              FluentIcons.payment_28_regular,
              size: 50,
              color: Colors.amber,
            ),
            header: FluentIcons.payment_28_regular),
        _StepItem(
            label: S.current.finish,
            child: CheckoutPage(
              cart: widget.cart,
              onChanged: onChange,
            ),
            icon: const Icon(
              FluentIcons.checkmark_48_regular,
              size: 50,
              color: Colors.amber,
            ),
            header: FluentIcons.checkmark_48_regular),
      ];

  List<PatchedStep> get stepsWidget {
    return <PatchedStep>[
      for (var i = 0; i < steps.length; i++)
        PatchedStep(
            isActive: currentStep == i,
            state: steps[i].state,
            title: steps[i].label,
            subtitle: steps[i].icon,
            content: steps[i].child,
            header: steps[i].header),
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
                  children: [
                    const Icon(FluentIcons.arrow_left_24_regular),
                    const SizedBox(width: 10),
                    Text(S.current.previous),
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
                  children: [
                    Text(currentStep == steps.length - 1
                        ? S.current.finish
                        : S.current.next),
                    const SizedBox(width: 10),
                    Icon(currentStep == steps.length - 1
                        ? FluentIcons.checkmark_28_regular
                        : FluentIcons.arrow_right_24_regular),
                  ],
                ),
                enabled: currentStep == steps.length,
                onTap: () {
                  if (currentStep == steps.length - 1) {
                    //TODO:add ending
                  }
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
        minimumSize: MaterialStateProperty.all(
          const Size.fromRadius(30),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 30),
        ),
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
  final IconData header;
  final PatchedStepState state;
  _StepItem({
    this.label,
    this.child,
    this.header,
    this.icon = const Icon(
      Icons.track_changes,
      color: Colors.amber,
      size: 100,
    ),
    this.state = PatchedStepState.indexed,
  });
}
