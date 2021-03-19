import 'dart:convert';

import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sailor/sailor.dart';
import 'package:supercharged/supercharged.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/cart_coupon_field.dart';
import '../../components/cart_text_field.dart';
import '../../components/my_error_widget.dart';
import '../../components/my_loading_overlay.dart';
import '../../core/api_caller.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../cubits/checkout_cubit/checkout_cubit.dart';
import '../../data/user_datasource.dart';
import '../../helpers/helper.dart';
import '../../models/cart_model.dart';
import '../../models/user_model.dart';
import '../../routes/config_routes.dart';
import '../home/home.dart';
import 'pages/address_review.dart';
import 'pages/checkout.dart';
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
        ..background.color(Colors.white)
        ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
      child: Scaffold(
        backgroundColor: Colors.white70,
        extendBodyBehindAppBar: true,
        floatingActionButton: WhatsappFloatingActionButton(),
        appBar: AppBar(
          title: Text(
            S.current.checkout,
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.black54,
        ),
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
  final bool hideLabel;
  final Widget child;
  final Widget icon;
  final Key key;
  _StepItem({
    this.key,
    this.label,
    this.hideLabel = false,
    this.child,
    this.icon = const Icon(
      Icons.track_changes,
      color: Colors.amber,
      size: 100,
    ),
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
  final otherFormKey = GlobalKey<FormState>();

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
            AppRouter.sailor.navigate(
              HomeScreen.routeName,
              navigationType: NavigationType.pushAndRemoveUntil,
              removeUntilPredicate: (_) => false,
            );
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: stepsWidget,
        ),
      ),
    );
  }

  ValueChanged get onChange => (_) => setState(() {});

  List<_StepItem> get steps => [
        if (kUser.level != UserLevel.merchant)
          _StepItem(
            label: S.current.discounts,
            child: CartCouponField(
              cart: widget.cart,
              onChanged: onChange,
            ),
            icon: SvgPicture.asset(
              'assets/images/if-advantage-sale-1034365_88851.svg',
              height: 50,
              width: 50,
            ),
          ),
        _StepItem(
          label: S.current.bill,
          icon: SizedBox(
            height: 50,
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/Invoice.png',
              ),
            ),
          ),
          child: SummeryCard(
            cart: widget.cart,
            onChanged: onChange,
          ),
        ),
        _StepItem(
          hideLabel: true,
          label: S.current.notes,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CartTextField(cart: widget.cart),
          ),
          icon: const Icon(
            FluentIcons.note_24_regular,
            size: 50,
            color: Colors.black,
          ),
        ),
        _StepItem(
          key: addressKey,
          label: S.current.shipping_address,
          child: AddressReviewPage(
            cart: widget.cart,
            otherFormKey: otherFormKey,
            onChanged: onChange,
          ),
          icon: Image.asset(
            'assets/images/1-46.png',
            height: 50,
            width: 50,
          ),
        ),
        _StepItem(
          key: paymentMethodKey,
          label: S.current.payment_method,
          child: PaymentMethodReviewPage(
            cart: widget.cart,
            onChanged: (value) {
              onChange(value);
              if (widget.cart.validate) {
                Helpers.dismissFauces(context);
                if (otherFormKey?.currentState?.validate() ?? true) {
                  otherFormKey?.currentState?.save();
                  cubit.placeOrder(widget.cart);
                } else {
                  Helpers.showErrorOverlay(context, error: S.current.check_that_you_filled_all_fields_correctly);
                }
              }
            },
          ),
          icon: Image.asset(
            'assets/images/717moneybag_100438.png',
            height: 50,
            width: 50,
          ),
        ),
      ];

  List<Widget> get stepsWidget {
    return <Widget>[
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!steps[i].hideLabel) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      steps[i].icon,
                      const SizedBox(width: 10),
                      Text(
                        steps[i].label,
                        style: Theme.of(context).textTheme.button.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
              steps[i].child,
            ],
          ),
        ),
      Column(
        children: [
          if (widget.cart.address == null && !widget.cart.organization)
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
        ],
      ),
    ];
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
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isLoading) return false;

        if (await Helpers.onWillPop(context)) {
          try {
            setState(() {
              isLoading = true;
            });
            await post(
              path: '/payments_order_callback',
              data: {'order_id': widget.orderId, 'status': 'failed'},
            );
            return true;
          } catch (e) {
            return true;
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        }
        return false;
      },
      child: MyLoadingOverLay(
        isLoading: isLoading,
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
              } catch (e) {}
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
      ),
    );
  }
}
