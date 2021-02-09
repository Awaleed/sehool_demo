import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/components/message_check_box.dart';
import 'package:supercharged/supercharged.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/cart_coupon_field.dart';
import '../../components/my_error_widget.dart';
import '../../components/my_loading_overlay.dart';
import '../../core/api_caller.dart';
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
        ..linearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.amber,
            Colors.black,
          ],
        ), //..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            S.current.checkout,
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
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
  final Key key;
  _StepItem({
    this.key,
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
  final addressKey = GlobalKey();
  final paymentMethodKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    cubit = getIt<CheckoutCubit>();
    getIt<CartCubit>().reset();
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
          visaPayment: (url, orderId) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OnlinePay(
                  url: url,
                  cubit: cubit,
                  orderId: orderId,
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
          visaPayment: (_, __) => _buildUI(),
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
        _StepItem(
          key: addressKey,
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
          key: paymentMethodKey,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MessageCheckBox(
              cart: widget.cart,
              onValueChanged: (value) {
                setState(() {});
              },
            ),
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
        Card(
          key: steps[i].key,
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      steps[i].label,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    steps[i].icon,
                  ],
                ),
              ),
              const Divider(),
              steps[i].child,
            ],
          ),
        ),
      Column(
        children: [
          if (widget.cart.address == null)
            MyErrorWidget(
              message: S.current.not_a_valid_address,
              buttonLabel: S.current.select_shipping_address,
              onRetry: () {
                Scrollable.ensureVisible(
                  addressKey.currentContext,
                  duration: 700.milliseconds,
                  curve: Curves.easeOut,
                );
              },
            ),
          if (widget.cart.paymentMethod == null)
            MyErrorWidget(
              message: S.current.select_your_preferred_payment_mode,
              buttonLabel: S.current.payments_settings,
              onRetry: () {
                Scrollable.ensureVisible(
                  paymentMethodKey.currentContext,
                  duration: 700.milliseconds,
                  curve: Curves.easeOut,
                );
              },
            ),
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

class OnlinePay extends StatefulWidget {
  const OnlinePay({
    Key key,
    @required this.url,
    @required this.cubit,
    @required this.orderId,
  }) : super(key: key);

  final String url;
  final CheckoutCubit cubit;
  final int orderId;

  @override
  _OnlinePayState createState() => _OnlinePayState();
}

class _OnlinePayState extends State<OnlinePay> with ApiCaller {
  WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await Helpers.onWillPop(context)) {
          try {
            post(
              path: '/payments_order_callback',
              data: {'order_id': widget.orderId, 'status': 'failed'},
            );
          } catch (e) {}
          widget.cubit.orderFailure(S.current.cancel_the_request);
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.current.confirm_payment,
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (str) async {
            Helpers.dismissFauces(context);
            final res = await controller.evaluateJavascript('document.documentElement.innerText');

            try {
              final json = jsonDecode(jsonDecode(res));

              if (json['errors'] != null) {
                controller.goBack();
              }

              Helpers.showErrorDialog(context, error: json);
            } catch (e) {
              // Helpers.showErrorOverlay(context, error: e);
            }
          },
          onWebViewCreated: (_controller) async {
            Helpers.dismissFauces(context);
            await _controller.loadUrl(widget.url, headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Accept-Language': 'ar',
            });
            setState(() {
              controller = _controller;
            });
          },
          navigationDelegate: (NavigationRequest request) {
            Helpers.dismissFauces(context);
            try {
              final uri = Uri.tryParse(request.url);
              if (uri != null && uri.queryParameters['status'] == 'paid') {
                post(
                  path: '/payments_order_callback',
                  data: {'order_id': widget.orderId, 'status': 'paid'},
                );
                AppRouter.sailor.pop();
                widget.cubit.orderSuccess();
              } else if (uri != null && uri.queryParameters['status'] == 'failed') {
                post(
                  path: '/payments_order_callback',
                  data: {'order_id': widget.orderId, 'status': 'failed'},
                );
                AppRouter.sailor.pop();
                widget.cubit.orderFailure(uri.queryParameters['message']);
              }
            } catch (e) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
