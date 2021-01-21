import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/cart_dropdown.dart';
import '../../components/cart_item_preview.dart';
import '../../components/cart_quantity_card.dart';
import '../../components/cart_text_field.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/cart_model.dart';
import '../../models/dropdown_value_model.dart';
import '../../models/product_model.dart';
import '../../patched_components/custom_stepper.dart';
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
        ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
  final String label;
  final Widget child;
  final Widget icon;
  final IconData header;
  final CustomStepState state;
  _StepItem({
    this.label,
    this.child,
    this.icon = const Icon(
      Icons.track_changes,
      color: Colors.amber,
      size: 100,
    ),
    this.state = CustomStepState.indexed,
    this.header,
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
  List<_StepItem> get steps => [
        _StepItem(
          label: S.current.quantity,
          child: CartQuantityCard(
            cartItem: widget.cartItem,
            onChanged: () => setState(() {}),
          ),
          icon: const Icon(
            FluentIcons.re_order_dots_24_regular,
            size: 50,
            color: Colors.amber,
          ),
          header: FluentIcons.re_order_dots_24_regular,
        ),
        _StepItem(
            label: S.current.slicing_method,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CartDropdown(
                dropdownType: DropdownValueType.slicingMethods,
                initialValue: widget.cartItem.slicingMethod,
                isRadio: true,
                onValueChanged: (value) {
                  widget.cartItem.slicingMethod = value;
                  setState(() {});
                },
              ),
            ),
            icon: const Icon(
              FluentIcons.cut_24_regular,
              size: 50,
              color: Colors.amber,
            ),
            header: FluentIcons.cut_24_regular),
        _StepItem(
          label: S.current.notes,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CartTextField(cartItem: widget.cartItem),
          ),
          icon: const Icon(
            FluentIcons.note_24_regular,
            size: 50,
            color: Colors.amber,
          ),
          header: FluentIcons.note_24_regular,
        ),
        _StepItem(
            label: S.current.finish,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CartItemPreview(cartItem: widget.cartItem),
            ),
            state: widget.cartItem.validate
                ? CustomStepState.indexed
                : CustomStepState.disabled,
            icon: const Icon(
              FluentIcons.checkmark_48_regular,
              size: 50,
              color: Colors.amber,
            ),
            header: FluentIcons.checkmark_48_regular),
      ];

  List<Widget> get stepsWidget {
    return <Widget>[
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
      if (widget.editing)
        _buildButton(
          enabled: widget.cartItem.validate,
          label: Text(S.current.back),
          onTap: () {
            Helpers.dismissFauces(context);
            AppRouter.sailor.pop();
          },
        )
      else
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.center,
            children: <Widget>[
              _buildButton(
                enabled: widget.cartItem.validate,
                label: Text(S.current.continue_to_checkout),
                onTap: () {
                  Helpers.dismissFauces(context);
                  getIt<CartCubit>().addItem(widget.cartItem);
                  AppRouter.sailor.navigate(
                    CheckoutScreen.routeName,
                    navigationType: NavigationType.pushReplace,
                  );
                },
              ),
              _buildButton(
                enabled: widget.cartItem.validate,
                label: Text(S.current.continue_shopping),
                onTap: () {
                  Helpers.dismissFauces(context);
                  getIt<CartCubit>().addItem(widget.cartItem);
                  AppRouter.sailor.pop();
                },
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
