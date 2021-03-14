import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/my_error_widget.dart';
import '../../../core/api_caller.dart';
import '../../../cubits/dropdown_cubit/dropdown_cubit.dart';
import '../../../data/user_datasource.dart';
import '../../../helpers/helper.dart';
import '../../../models/bank_model.dart';
import '../../../models/cart_model.dart';
import '../../../models/dropdown_value_model.dart';
import '../../../models/order_model.dart';

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
        // const SizedBox(height: 20),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: _TotalCard(cart: widget.cart),
        // ),
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
        // if (selectedValue == null) {
        //   setState(() {
        //     final value = state.maybeWhen(
        //           success: (values) =>
        //               values?.isNotEmpty ?? false ? values.first : null,
        //           orElse: () => null,
        //         ) ??
        //         selectedValue;
        //     selectedValue = value;
        //     // widget.onValueChanged?.call(value);
        //   });
        // }
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

  Widget _buildRadio(List _values, {bool isLoading = false}) {
    if (widget.cart.organization && widget.cart.association == null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ListTile(
          leading: Image.asset('assets/images/sign-warning.png'),
          title: Text(
            S.current.please_choose_an_association,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ),
      );
    }
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
    final canPayWithPoints = kUser.wallet >= widget.cart.total;
    final disableOtherButton = (canPayWithPoints && widget.cart.fromWallet) || widget.cart.total == 0;
    final values = [];
    final otherValues = [];
    for (final e in _values) {
      if (e.type == 'wallet' || e.type == 'cash on delivery') {
        if (e.type == 'wallet' && !disableOtherButton) {
        } else {
          otherValues.add(e);
        }
      } else {
        values.add(e);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        StaggeredGridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          // maxCrossAxisExtent: 150,
          staggeredTiles: [
            ...values.map((e) {
              if (e.type == 'cash on delivery' || e.type == 'wallet') {
                return const StaggeredTile.count(4, 1);
              }
              return const StaggeredTile.count(2, 1);
            }),
          ],
          physics: const NeverScrollableScrollPhysics(),
          children: values
              .map(
                (e) => GridTile(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: e.type != 'wallet' && disableOtherButton
                        ? null
                        : e.type == 'disabled'
                            ? () {
                                Helpers.showErrorOverlay(
                                  context,
                                  error: S.current.payment_not_active,
                                );
                              }
                            : () async {
                                if (e is PaymentMethodModel && e.type == 'wallet') {
                                  if (kUser.wallet < widget.cart.total) {
                                    Helpers.showErrorOverlay(
                                      context,
                                      error: S.current.sorry_your_balance_is_not_enough,
                                    );
                                  } else {
                                    // widget.onValueChanged?.call(e);
                                    setState(() => selectedValue = e);
                                  }
                                } else {
                                  // widget.onValueChanged?.call(e);
                                  setState(() => selectedValue = e);
                                }
                                if (e is PaymentMethodModel && e.type == 'transfer') {
                                  await showDialog(
                                    context: context,
                                    useRootNavigator: true,
                                    builder: (context) => BankInfoWidget(),
                                  );
                                }
                                widget.onValueChanged?.call(e);
                              },
                    child: Card(
                      // margin: EdgeInsets.zero,
                      margin: const EdgeInsets.all(5),
                      color: e.type != 'wallet' && disableOtherButton ? Colors.grey : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: CachedNetworkImage(
                          imageUrl: e.icon,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        ...otherValues.map((e) => InkWell(
              onTap: (e.type != 'wallet' && disableOtherButton) || (e.type == 'cash on delivery' && widget.cart.organization)
                  ? null
                  : e.type == 'disabled'
                      ? () {
                          Helpers.showErrorOverlay(
                            context,
                            error: S.current.payment_not_active,
                          );
                        }
                      : () async {
                          if (e is PaymentMethodModel && e.type == 'wallet') {
                            if (kUser.wallet < widget.cart.total) {
                              Helpers.showErrorOverlay(
                                context,
                                error: S.current.sorry_your_balance_is_not_enough,
                              );
                            } else {
                              // widget.onValueChanged?.call(e);
                              setState(() => selectedValue = e);
                            }
                          } else if (e.type == 'cash on delivery') {
                            await showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) => AlertDialog(
                                content: Text(S.current.not_in_my_points_program),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() => selectedValue = e);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(S.current.confirmation),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text(
                                      S.current.cancel,
                                    ),
                                  ),
                                ],
                              ),
                            ); // setState(() => selectedValue = e);
                          } else {
                            // widget.onValueChanged?.call(e);
                            setState(() => selectedValue = e);
                          }
                          if (e is PaymentMethodModel && e.type == 'transfer') {
                            await showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) => BankInfoWidget(),
                            );
                          }
                          if (selectedValue != null) {
                            widget.onValueChanged?.call(selectedValue);
                          }
                        },
              child: Row(
                children: [
                  // SizedBox(
                  //   height: 80,
                  //   width: 80,
                  //   child: Card(
                  //     color: e.type != 'wallet' && disableOtherButton ? Colors.grey : null,
                  //     child: CachedNetworkImage(
                  //       imageUrl: e.icon,
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: Card(
                        color: (e.type != 'wallet' && disableOtherButton) || (e.type == 'cash on delivery' && widget.cart.organization) ? Colors.grey : null,
                        child: Center(child: Text(e.name)),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class BankInfoWidget extends StatelessWidget with ApiCaller {
  BankInfoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: Colors.white70,
      title: Text(S.current.bank_info),
      content: FutureBuilder<List<BankModel>>(
        future: () async {
          final List res = await get(path: '/account/banks');
          return ApiCaller.listParser(res, (data) => BankModel.fromJson(data));
        }(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...snapshot.data.map(
                  (e) => Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(S.current.bank_name),
                          subtitle: Text(e.name),
                        ),
                        ListTile(
                          title: Text(S.current.account_number),
                          subtitle: Text(e.accountNumber),
                        ),
                        ListTile(
                          title: Text(S.current.iban_number),
                          subtitle: Text(e.ibanNumber),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
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
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
