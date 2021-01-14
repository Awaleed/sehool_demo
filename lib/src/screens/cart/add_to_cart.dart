import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sehool/generated/l10n.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../patched_components/stepper.dart';
import 'pages/finish.dart';
import 'pages/notes.dart';
import 'pages/quantity.dart';
import 'pages/slicing_method.dart';

class AddToCartScreen extends StatelessWidget {
  static const routeName = '/add_to_cart';

  const AddToCartScreen({
    Key key,
    this.product,
    this.cartItem,
  }) : super(key: key);

  final ProductModel product;
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.black54),
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
            child: CartStepper(
              cartItem: cartItem ?? (CartItemModel()
                ..product = product),
            ),
          ),
        ],
      ),
    );
  }
}

class CartStepper extends StatefulWidget {
  const CartStepper({
    Key key,
    @required this.cartItem,
  }) : super(key: key);
  final CartItemModel cartItem;
  @override
  _CartStepperState createState() => _CartStepperState();
}

class _CartStepperState extends State<CartStepper> {
  int currentStep = 0;

  List<_StepItem> get steps => [
        _StepItem(
          label: S.current.quantity,
          child: QuantityPage(cartItem: widget.cartItem),
          icon: const Icon(Icons.ac_unit),
        ),
        _StepItem(
          label: S.current.slicing_method,
          child: SlicingMethodPage(cartItem: widget.cartItem),
          icon: const Icon(Icons.ac_unit),
        ),
        _StepItem(
          label: S.current.notes,
          child: NotesPage(cartItem: widget.cartItem),
          icon: const Icon(Icons.ac_unit),
        ),
        _StepItem(
          label: S.current.finish,
          child: FinishPage(cartItem: widget.cartItem),
          icon: const Icon(Icons.ac_unit),
        ),
      ];

  List<PatchedStep> get stepsWidget {
    return <PatchedStep>[
      for (var i = 0; i < steps.length; i++)
        PatchedStep(
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
            onPatchedStepTapped: (value) => setState(() {
              currentStep = value;
            }),
            controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
                const SizedBox.shrink(),
            patchedSteps: stepsWidget,
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
                    Text(S.current.next),
                    const SizedBox(width: 10),
                    const Icon(FluentIcons.arrow_right_24_regular),
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
