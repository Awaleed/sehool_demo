import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailor/sailor.dart';
import 'package:supercharged/supercharged.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/cart_dropdown.dart';
import '../../components/cart_item_preview.dart';
import '../../components/cart_quantity_card.dart';
import '../../components/cart_text_field.dart';
import '../../components/my_error_widget.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/cart_model.dart';
import '../../models/dropdown_value_model.dart';
import '../../models/product_model.dart';
import '../../patched_components/custom_stepper.dart';
import '../../routes/config_routes.dart';
import '../checkout/checkout.dart';
import '../home/home.dart';

class AddToCartScreen extends StatelessWidget {
  static const routeName = '/add_to_cart';

  const AddToCartScreen({
    Key key,
    this.product,
    this.cartItem,
    this.editing = false,
  }) : super(key: key);

  final ProductModel product;
  final CartItemModel cartItem;
  final bool editing;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        // ..linearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Colors.black,
        //     Colors.amber,
        //     Colors.black,
        //   ],
        // ),
        ..background.color(Colors.white)
        ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
      child: Scaffold(
        backgroundColor: Colors.white70,
        extendBodyBehindAppBar: true,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [WhatsappFloatingActionButton(), SizedBox(height: 50)],
        ),
        appBar: AppBar(
          title: Text(
            cartItem != null ? '${S.current.edit}: ${cartItem.product.name}' : '${S.current.add} ${product.name}',
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.black54,
        ),
        body: SafeArea(
          child: CartScroll(
            cartItem: cartItem ?? (CartItemModel()..product = product),
            editing: editing,
          ),
          // child: CartStepper(
          //   cartItem: cartItem ?? (CartItemModel()..product = product),
          // ),
        ),
      ),
    );
  }
}

class _StepItem {
  final Key key;
  final String label;
  final bool hideLabel;
  final Widget child;
  final Widget icon;
  final CustomStepState state;

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
    this.state = CustomStepState.indexed,
  });
}

class CartScroll extends StatefulWidget {
  const CartScroll({
    Key key,
    @required this.cartItem,
    @required this.editing,
  }) : super(key: key);

  final CartItemModel cartItem;
  final bool editing;

  @override
  _CartScrollState createState() => _CartScrollState();
}

class _CartScrollState extends State<CartScroll> {
  final slicingMethodKey = GlobalKey();
  final messageFormKey = GlobalKey<FormState>();

  List<_StepItem> get steps => [
        _StepItem(
          label: S.current.quantity,
          child: CartQuantityCard(
            cartItem: widget.cartItem,
            onChanged: () => setState(() {}),
          ),
          icon: SvgPicture.asset(
            'assets/images/1455739809_Kitchen_Bold_Line_Color_Mix-30_icon-icons.com_53387.svg',
            height: 50,
            width: 50,
            // color: Colors.black,
          ),
        ),
        _StepItem(
          key: slicingMethodKey,
          label: S.current.slicing_method,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CartDropdown(
              dropdownType: DropdownValueType.slicingMethods,
              initialValue: widget.cartItem.slicingMethod,
              isRadio: true,
              cartItem: widget.cartItem,
              messageFormKey: messageFormKey,
              onValueChanged: (value) {
                widget.cartItem.slicingMethod = value;
                setState(() {});
              },
            ),
          ),
          icon: SvgPicture.asset(
            'assets/images/3808368-bloody-butcher-knife-knife-weapon_109095.svg',
            width: 50,
            height: 50,
            // color: Colors.black,
          ),
        ),
        // _StepItem(
        //   hideLabel: true,
        //   label: S.current.notes,
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: CartTextField(cartItem: widget.cartItem),
        //   ),
        //   icon: const Icon(
        //     FluentIcons.note_24_regular,
        //     size: 50,
        //     color: Colors.black,
        //   ),
        // ),
        _StepItem(
          hideLabel: true,
          label: S.current.finish,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CartItemPreview(cartItem: widget.cartItem),
          ),
          state: widget.cartItem.validate ? CustomStepState.indexed : CustomStepState.disabled,
          icon: const Icon(
            FluentIcons.checkmark_48_regular,
            size: 50,
            color: Colors.black,
          ),
        ),
      ];

  List<Widget> get stepsWidget {
    return <Widget>[
      for (var i = 0; i < steps.length; i++) ...[
        Card(
          key: steps[i].key,
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          // margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      // const SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          title: Text(steps[i].label, style: Theme.of(context).textTheme.button.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
                          subtitle: steps[i].key == slicingMethodKey ? Text(S.current.please_choose_one) : null,
                        ),
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
        if (steps[i].key == slicingMethodKey && !widget.editing) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildButton(
              icon: 'assets/images/shopping-cart.svg',
              enabled: widget.cartItem.validate,
              label: Text(S.current.choose_another_item,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )),
              onTap: () {
                Helpers.dismissFauces(context);
                if (messageFormKey?.currentState?.validate() ?? true) {
                  messageFormKey?.currentState?.save();
                  getIt<CartCubit>().addItem(widget.cartItem);
                  AppRouter.sailor.pop();
                } else {
                  Helpers.showErrorOverlay(context, error: S.current.check_that_you_filled_all_fields_correctly);
                }
              },
            ),
          ),
        ]
      ],
      Column(
        children: [
          if (widget.cartItem.slicingMethod == null)
            MyErrorWidget(
              message: S.current.not_a_valid_slicing_method,
              buttonLabel: S.current.slicing_method,
              onRetry: () {
                Scrollable.ensureVisible(
                  slicingMethodKey.currentContext,
                  duration: 700.milliseconds,
                  curve: Curves.easeOut,
                );
              },
            ),
        ],
      ),
      if (widget.editing)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: _buildButton(
            enabled: widget.cartItem.validate,
            label: Text(S.current.back,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    )),
            onTap: () {
              Helpers.dismissFauces(context);
              AppRouter.sailor.pop();
            },
          ),
        )
      else
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            // crossAxisAlignment: WrapCrossAlignment.center,
            // alignment: WrapAlignment.spaceBetween,
            // runAlignment: WrapAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // _buildButton(
              //   icon: 'assets/images/shopping-cart.svg',
              //   enabled: widget.cartItem.validate,
              //   label: Text(S.current.choose_another_item,
              //       style: Theme.of(context).textTheme.bodyText1.copyWith(
              //             color: Colors.black,
              //             fontWeight: FontWeight.normal,
              //           )),
              //   onTap: () {
              //     Helpers.dismissFauces(context);
              //     if (messageFormKey?.currentState?.validate() ?? true) {
              //       messageFormKey?.currentState?.save();
              //       getIt<CartCubit>().addItem(widget.cartItem);
              //       AppRouter.sailor.pop();
              //     } else {
              //       Helpers.showErrorOverlay(context, error: S.current.check_that_you_filled_all_fields_correctly);
              //     }
              //   },
              // ),
              // const SizedBox(height: 15),
              _buildButton(
                icon: 'assets/images/carduse_card_payment.svg',
                enabled: widget.cartItem.validate,
                label: Text(S.current.continue_to_checkout,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        )),
                onTap: () {
                  Helpers.dismissFauces(context);
                  if (messageFormKey?.currentState?.validate() ?? true) {
                    messageFormKey?.currentState?.save();
                    getIt<CartCubit>().addItem(widget.cartItem);
                    AppRouter.sailor.navigate(
                      CheckoutScreen.routeName,
                      navigationType: NavigationType.pushReplace,
                    );
                  } else {
                    Helpers.showErrorOverlay(context, error: S.current.check_that_you_filled_all_fields_correctly);
                  }
                },
              ),
            ],
          ),
        )
    ];
  }

  Widget _buildButton({
    Widget label,
    String icon,
    bool enabled = true,
    VoidCallback onTap,
  }) {
    // return FlatButton(
    //   onPressed: enabled ? onTap : null,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //   color: Theme.of(context).primaryColor.withOpacity(.9),
    //   // child: Container(
    //   //   alignment: Alignment.center,
    //   //   padding: const EdgeInsets.all(12),
    //   //   margin: const EdgeInsets.all(3),
    //   //   decoration: BoxDecoration(
    //   //     borderRadius: BorderRadius.circular(15),
    //   //   ),
    //   child: label,
    //   // ),
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size.fromRadius(20),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: enabled ? MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.9)) : null,
        ),
        onPressed: enabled ? onTap : null,
        child: label,
      ),
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
