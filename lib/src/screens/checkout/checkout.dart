import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/components/cart_coupon_field.dart';
import 'package:sehool/src/core/api_caller.dart';
import 'package:sehool/src/helpers/helper.dart';
import 'package:sehool/src/patched_components/custom_stepper.dart';
import 'package:sehool/src/routes/config_routes.dart';
import '../../../generated/l10n.dart';

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
    return Parent(
      style: ParentStyle()
        ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocBuilder<CartCubit, CartState>(
            cubit: getIt<CartCubit>(),
            builder: (context, state) => CheckoutScroll(cart: state.cart),
          ),
        ),
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
          header: FluentIcons.cart_24_regular,
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
            state: widget.cart.validate
                ? CustomStepState.indexed
                : CustomStepState.disabled,
            icon: const Icon(
              FluentIcons.checkmark_48_regular,
              size: 50,
              color: Colors.amber,
            ),
            header: FluentIcons.checkmark_48_regular),
      ];

  List<CustomStep> get stepsWidget {
    return <CustomStep>[
      for (var i = 0; i < steps.length; i++)
        CustomStep(
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomStepper(
            currentCustomStep: currentStep,
            physics: const BouncingScrollPhysics(),
            onCustomStepTapped: (value) => setState(() => currentStep = value),
            customSteps: stepsWidget,
            controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
                const SizedBox.shrink(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.center,
            children: <Widget>[
              _buildButton(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(FluentIcons.arrow_left_24_regular),
                    const SizedBox(width: 10),
                    Text(S.current.previous),
                  ],
                ),
                enabled: currentStep != 0,
                onTap: () {
                  for (var i = currentStep - 1; i >= 0; i--) {
                    final _StepItem step = steps[i];
                    if (step.state == CustomStepState.disabled) {
                      continue;
                    } else {
                      setState(() => currentStep = i);
                      break;
                    }
                  }
                },
              ),
              if (currentStep == steps.length - 1)
                _buildButton(
                  label: Text(S.current.checkout),
                  onTap: () {
                    getIt<CartCubit>().placeOrder(context, widget.cart);
                  },
                )
              else
                _buildButton(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(S.current.next),
                      const SizedBox(width: 10),
                      const Icon(FluentIcons.arrow_right_24_regular),
                    ],
                  ),
                  enabled: currentStep != steps.length - 1,
                  onTap: () {
                    for (var i = currentStep + 1; i < steps.length; i++) {
                      final _StepItem step = steps[i];
                      if (step.state == CustomStepState.disabled) {
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
          const Size.fromRadius(25),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      onPressed: enabled ? onTap : null,
      child: label,
    );
  }
}

class _StepItem {
  final String label;
  final Widget child;
  final Widget icon;
  final IconData header;
  final CustomStepState state;
  _StepItem({
    this.label,
    this.child,
    this.header,
    this.icon = const Icon(
      Icons.track_changes,
      color: Colors.amber,
      size: 100,
    ),
    this.state = CustomStepState.indexed,
  });
}

class CheckoutScroll extends StatefulWidget {
  const CheckoutScroll({
    Key key,
    this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  _CheckoutScrollState createState() => _CheckoutScrollState();
}

class _CheckoutScrollState extends State<CheckoutScroll> {
  ValueChanged get onChange => (_) => setState(() {});

  List<_StepItem> get steps => [
        // _StepItem(
        //   label: S.current.cart_contents,
        //   child: CartReviewPage(
        //     cartItems: widget.cart.cartItems,
        //     onChanged: onChange,
        //   ),
        //   icon: const Icon(
        //     FluentIcons.cart_24_regular,
        //     size: 50,
        //     color: Colors.amber,
        //   ),
        //   header: FluentIcons.cart_24_regular,
        // ),
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
        ),
        _StepItem(
          label: S.current.add_coupon,
          child: CartCouponField(
            cart: widget.cart,
            onChanged: onChange,
          ),
          icon: const Icon(
            FluentIcons.plug_disconnected_28_regular,
            size: 50,
            color: Colors.amber,
          ),
          header: FluentIcons.plug_disconnected_28_regular,
        ),
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
          header: FluentIcons.payment_28_regular,
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
          header: FluentIcons.note_24_regular,
        ),
      ];
  List<Widget> get stepsWidget {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(20),
        child: SummeryCard(cart: widget.cart),
      ),
      for (var i = 0; i < steps.length; i++)
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              // margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      steps[i].label,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w600,
                            // color: Colors.black,
                          ),
                    ),
                    steps[i].icon,
                  ],
                ),
              ),
            ),
            steps[i].child,
          ],
        ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: _buildButton(
          enabled: widget.cart.validate,
          label: Text(S.current.checkout),
          onTap: () {
            getIt<CartCubit>().placeOrder(context, widget.cart);
          },
        ),
      )
    ];
  }

  Widget _buildButton({
    Widget label,
    bool enabled = true,
    VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size.fromRadius(25),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      onPressed: enabled ? onTap : null,
      child: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: stepsWidget,
      ),
    );
  }
}
