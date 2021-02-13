import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/init_injectable.dart';
import 'package:sehool/src/components/my_error_widget.dart';
import 'package:sehool/src/cubits/dropdown_cubit/dropdown_cubit.dart';
import 'package:sehool/src/helpers/helper.dart';
import 'package:sehool/src/models/order_model.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../generated/l10n.dart';
import '../../../data/user_datasource.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';

class PaymentMethodReviewPage extends StatefulWidget {
  const PaymentMethodReviewPage({
    Key key,
    @required this.cart,
    this.onChanged,
  }) : super(key: key);

  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _PaymentMethodReviewPageState createState() => _PaymentMethodReviewPageState();
}

class _PaymentMethodReviewPageState extends State<PaymentMethodReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _TotalCard(cart: widget.cart),
        ),
        const SizedBox(height: 20),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CartDropdown(
              isRadio: true,
              dropdownType: DropdownValueType.paymentMethods,
              initialValue: widget.cart.paymentMethod,
              itemAsString: (value) => value.name,
              cart: widget.cart,
              onValueChanged: (value) {
                setState(() {
                  widget.cart.paymentMethod = value;
                });
                widget.onChanged(value);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({
    Key key,
    this.cart,
  }) : super(key: key);
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.total,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text('${cart.total} ﷼'),
                        if (cart.coupon != null) ...[
                          const SizedBox(width: 20),
                          Text(
                            '${cart.totalWithoutDiscount} ﷼',
                            style: TextStyle(
                              decoration: cart.coupon != null ? TextDecoration.lineThrough : TextDecoration.none,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Text(
                  S.current.balance,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Divider(),
                Card(
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Text('${kUser.wallet} ﷼'),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CartDropdown extends StatefulWidget {
  const CartDropdown({
    Key key,
    @required this.dropdownType,
    @required this.initialValue,
    @required this.onValueChanged,
    this.cart,
    this.messageFormKey,
    this.cartItem,
    this.isRadio = false,
    this.itemAsString,
  }) : super(key: key);
  final DropdownValueType dropdownType;
  final ValueChanged onValueChanged;
  final String Function(PaymentMethodModel value) itemAsString;
  final PaymentMethodModel initialValue;
  final CartModel cart;
  final CartItemModel cartItem;
  final bool isRadio;
  final GlobalKey<FormState> messageFormKey;

  @override
  _CartDropdownState createState() => _CartDropdownState();
}

class _CartDropdownState extends State<CartDropdown> {
  dynamic selectedValue;
  DropdownCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<DropdownCubit>();
    cubit.getDropdownValues(widget.dropdownType);
    selectedValue = widget.initialValue;
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DropdownCubit, DropdownState>(
      cubit: cubit,
      listener: (context, state) {
        if (selectedValue == null) {
          setState(() {
            final value = state.maybeWhen(
                  success: (values) => values?.isNotEmpty ?? false ? values.first : null,
                  orElse: () => null,
                ) ??
                selectedValue;
            selectedValue = value;
            widget.onValueChanged?.call(value);
          });
        }
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI([], isLoading: true),
          loading: () => _buildUI([], isLoading: true),
          success: (values) => _buildUI(values),
          failure: (message) => MyErrorWidget(
            onRetry: () {
              cubit.getDropdownValues(widget.dropdownType);
            },
            message: message,
          ),
        );
      },
    );
  }

  Widget _buildUI(List values, {bool isLoading = false}) => _buildRadio(values, isLoading: isLoading);

  Widget _buildRadio(List values, {bool isLoading = false}) {
    if (isLoading) {
      return FittedBox(
        child: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...values.map(
          (e) => GridTile(
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                if (e is PaymentMethodModel && e.type == 'wallet') {
                  if (kUser.wallet <= widget.cart.total) {
                    Helpers.showErrorOverlay(
                      context,
                      error: S.current.sorry_your_balance_is_not_enough,
                    );
                  } else {
                    widget.onValueChanged?.call(e);
                    setState(() => selectedValue = e);
                  }
                } else {
                  widget.onValueChanged?.call(e);
                  setState(() => selectedValue = e);
                }
              },
              child: Container(
                // padding: const EdgeInsets.all(12),
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.all(5),
                // duration: 300.milliseconds,

                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: e == selectedValue ? Theme.of(context).primaryColor : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: e.icon,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      if (e == selectedValue)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            children: [
                              Container(
                                color: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.check),
                              ),
                            ],
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black54,
                          // decoration: BoxDecoration(
                          //   // borderRadius: BorderRadius.vertical(
                          //   //   bottom: Radius.circular(15),
                          //   // ),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              widget.itemAsString?.call(e) ?? '$e',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Column(
                //   children: [
                //     // Text(
                //     //   widget.itemAsString?.call(e) ?? '$e',
                //     //   style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                //     // ),
                //   ],
                // ),
              ),
            ),
          ),
        ),
        // ...values.map(
        //   (e) => Card(
        //     elevation: 0,
        //     color: Colors.transparent,
        //     // shape: OutlineInputBorder(
        //     //   borderRadius: BorderRadius.circular(25),
        //     // ),
        //     child: RadioListTile(
        //       value: e,
        //       groupValue: selectedValue,
        //       title: Text(
        //         widget.itemAsString?.call(e) ?? '$e',
        //         style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
        //       ),
        //       onChanged: (value) async {
        //         if (value is PaymentMethodModel && value.type == 'wallet') {
        //           if (kUser.wallet <= widget.cart.total) {
        //             Helpers.showErrorOverlay(
        //               context,
        //               error: S.current.sorry_your_balance_is_not_enough,
        //             );
        //           } else {
        //             widget.onValueChanged?.call(value);
        //             setState(() => selectedValue = value);
        //           }
        //         } else {
        //           widget.onValueChanged?.call(value);
        //           setState(() => selectedValue = value);
        //         }
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
