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
import '../../components/my_error_widget.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/cart_model.dart';
import '../../models/dropdown_value_model.dart';
import '../../models/product_model.dart';
import '../../routes/config_routes.dart';
import '../checkout/checkout.dart';

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
        ..background.color(Colors.white)
        ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
      child: Scaffold(
        backgroundColor: Colors.white70,
        extendBodyBehindAppBar: true,
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
              grid: true,
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
          ),
        ),
        _StepItem(
          hideLabel: true,
          label: S.current.finish,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CartItemPreview(cartItem: widget.cartItem),
          ),
          // state: widget.cartItem.validate ? CustomStepState.indexed : CustomStepState.disabled,
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
            label: Text(S.current.next,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildButton(
                    enabled: widget.cartItem.validate,
                    label: Text(S.current.back_to_shopping,
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildButton(
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
                ),
              ),
            ],
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
      child: FittedBox(child: label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: stepsWidget,
      ),
    );
  }
}
