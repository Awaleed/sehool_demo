import 'package:dio/dio.dart';
import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/cart_coupon_field.dart';
import '../../components/my_loading_overlay.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../cubits/checkout_cubit/checkout_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/cart_model.dart';
import '../../patched_components/custom_stepper.dart';
import '../../routes/config_routes.dart';
import '../home/home.dart';
import 'pages/address_review.dart';
import 'pages/checkout.dart';
import 'pages/checkout_notes.dart';
import 'pages/payment_method_review.dart';

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
          title: Text(
            S.current.add_to_cart,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocConsumer<CartCubit, CartState>(
            cubit: getIt<CartCubit>(),
            listener: (context, state) async {
              if (state.cart.cartItems.isEmpty) {
                AppRouter.sailor.navigate(
                  HomeScreen.routeName,
                  navigationType: NavigationType.pushAndRemoveUntil,
                  removeUntilPredicate: (_) => false,
                );
                // AppRouter.sailor.navigate(
                //   HomeScreen.routeName);
                Helpers.showMessageOverlay(
                  context,
                  message: S.current.dont_have_any_item_in_your_cart,
                );
              }
            },
            builder: (context, state) => CheckoutScroll(cart: state.cart),
          ),
        ),
      ),
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
  CheckoutCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<CheckoutCubit>();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      cubit: cubit,
      listener: (context, state) {
        state.maybeWhen(
          visaPayment: (url) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OnlinePay(
                  url: url,
                  cubit: cubit,
                ),
              ),
            );
          },
          success: () {
            Helpers.showSuccessOverlay(
              context,
              message: S.current.your_order_has_been_successfully_submitted,
            );
            getIt<CartCubit>().clear();
          },
          failure: (message) {
            Helpers.showErrorOverlay(context, error: message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI(),
          loading: () => _buildUI(isLoading: true),
          visaPayment: (_) => _buildUI(),
          success: () => _buildUI(),
          failure: (message) => _buildUI(),
        );
      },
    );
  }

  Widget _buildUI({bool isLoading = false}) {
    return MyLoadingOverLay(
      isLoading: isLoading,
      showSpinner: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: stepsWidget,
        ),
      ),
    );
  }

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
        child: SummeryCard(
          cart: widget.cart,
          onChanged: onChange,
        ),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
          onTap: widget.cart.validate
              ? () {
                  Helpers.dismissFauces(context);
                  cubit.placeOrder(widget.cart);
                }
              : null,
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
}

// class CheckoutStepper extends StatefulWidget {
//   const CheckoutStepper({
//     Key key,
//     @required this.cart,
//   }) : super(key: key);

//   final CartModel cart;

//   @override
//   _CheckoutStepperState createState() => _CheckoutStepperState();
// }

// class _CheckoutStepperState extends State<CheckoutStepper> {
//   int currentStep = 0;
//   ValueChanged get onChange => (_) => setState(() {});
//   List<_StepItem> get steps => [
//         _StepItem(
//           label: S.current.cart_contents,
//           child: CartReviewPage(
//             cartItems: widget.cart.cartItems,
//             onChanged: onChange,
//           ),
//           icon: const Icon(
//             FluentIcons.cart_24_regular,
//             size: 50,
//             color: Colors.amber,
//           ),
//           header: FluentIcons.cart_24_regular,
//         ),
//         _StepItem(
//           label: S.current.shipping_address,
//           child: AddressReviewPage(
//             cart: widget.cart,
//             onChanged: onChange,
//           ),
//           icon: const Icon(
//             FluentIcons.location_48_regular,
//             size: 50,
//             color: Colors.amber,
//           ),
//           header: FluentIcons.location_48_regular,
//         ),
//         _StepItem(
//             label: S.current.notes,
//             icon: const Icon(
//               FluentIcons.note_24_regular,
//               size: 50,
//               color: Colors.amber,
//             ),
//             child: CheckoutNotesPage(
//               cart: widget.cart,
//               onChanged: onChange,
//             ),
//             header: FluentIcons.note_24_regular),
//         _StepItem(
//             label: S.current.payment_mode,
//             child: PaymentMethodReviewPage(
//               cart: widget.cart,
//               onChanged: onChange,
//             ),
//             icon: const Icon(
//               FluentIcons.payment_28_regular,
//               size: 50,
//               color: Colors.amber,
//             ),
//             header: FluentIcons.payment_28_regular),
//         _StepItem(
//             label: S.current.finish,
//             child: CheckoutPage(
//               cart: widget.cart,
//               onChanged: onChange,
//             ),
//             state: widget.cart.validate
//                 ? CustomStepState.indexed
//                 : CustomStepState.disabled,
//             icon: const Icon(
//               FluentIcons.checkmark_48_regular,
//               size: 50,
//               color: Colors.amber,
//             ),
//             header: FluentIcons.checkmark_48_regular),
//       ];

//   List<CustomStep> get stepsWidget {
//     return <CustomStep>[
//       for (var i = 0; i < steps.length; i++)
//         CustomStep(
//             isActive: currentStep == i,
//             state: steps[i].state,
//             title: steps[i].label,
//             subtitle: steps[i].icon,
//             content: steps[i].child,
//             header: steps[i].header),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           child: CustomStepper(
//             currentCustomStep: currentStep,
//             physics: const BouncingScrollPhysics(),
//             onCustomStepTapped: (value) => setState(() => currentStep = value),
//             customSteps: stepsWidget,
//             controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
//                 const SizedBox.shrink(),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             alignment: WrapAlignment.spaceBetween,
//             runAlignment: WrapAlignment.center,
//             children: <Widget>[
//               _buildButton(
//                 label: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(FluentIcons.arrow_left_24_regular),
//                     const SizedBox(width: 10),
//                     Text(S.current.previous),
//                   ],
//                 ),
//                 enabled: currentStep != 0,
//                 onTap: () {
//                   for (var i = currentStep - 1; i >= 0; i--) {
//                     final _StepItem step = steps[i];
//                     if (step.state == CustomStepState.disabled) {
//                       continue;
//                     } else {
//                       setState(() => currentStep = i);
//                       break;
//                     }
//                   }
//                 },
//               ),
//               if (currentStep == steps.length - 1)
//                 _buildButton(
//                   label: Text(S.current.checkout),
//                   onTap: () {
//                     // getIt<CartCubit>().placeOrder(context, widget.cart);
//                   },
//                 )
//               else
//                 _buildButton(
//                   label: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(S.current.next),
//                       const SizedBox(width: 10),
//                       const Icon(FluentIcons.arrow_right_24_regular),
//                     ],
//                   ),
//                   enabled: currentStep != steps.length - 1,
//                   onTap: () {
//                     for (var i = currentStep + 1; i < steps.length; i++) {
//                       final _StepItem step = steps[i];
//                       if (step.state == CustomStepState.disabled) {
//                         continue;
//                       } else {
//                         setState(() => currentStep = i);
//                         break;
//                       }
//                     }
//                   },
//                 ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildButton({
//     Widget label,
//     bool enabled = true,
//     VoidCallback onTap,
//   }) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         minimumSize: MaterialStateProperty.all(
//           const Size.fromRadius(25),
//         ),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//           ),
//         ),
//       ),
//       onPressed: enabled ? onTap : null,
//       child: label,
//     );
//   }
// }

class OnlinePay extends StatelessWidget {
  const OnlinePay({
    Key key,
    this.url,
    this.cubit,
  }) : super(key: key);
  final String url;
  final CheckoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Helpers.onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.current.confirm_payment,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: WebView(
          initialUrl: url,
          navigationDelegate: (NavigationRequest request) {
            final uri = Uri.tryParse(request.url);
            if (uri != null && uri.queryParameters['status'] == 'paid') {
              AppRouter.sailor.pop();
              cubit.orderSuccess();
            } else if (uri != null &&
                uri.queryParameters['status'] == 'failed') {
              AppRouter.sailor.pop();
              cubit.orderFailure(uri.queryParameters['message']);
            }

            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
