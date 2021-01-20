import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

import '../../generated/l10n.dart';
import '../core/api_caller.dart';
import '../helpers/helper.dart';
import '../models/cart_model.dart';

enum _CouponState { initial, loading, success, failure }

class _CouponCubit extends Cubit<_CouponState> with ApiCaller {
  _CouponCubit() : super(_CouponState.initial);

  CouponModel coupon;

  Future<void> validateCoupon(String couponStr) async {
    emit(_CouponState.loading);
    try {
      dio.clear();
      final res = await post<List>(
        path: '/coupon',
        data: {'name': couponStr.trim()},
      );
      res.first['amount'] = double.tryParse('${res.first['amount']}' ?? '');
      coupon = CouponModel.fromJson(res.first);
      emit(_CouponState.success);
    } catch (e) {
      emit(_CouponState.failure);
    }
  }
}

class CartCouponField extends StatefulWidget {
  const CartCouponField({
    Key key,
    this.cart,
    this.onChanged,
  }) : super(key: key);
  final CartModel cart;
  final ValueChanged onChanged;

  @override
  _CartCouponFieldState createState() => _CartCouponFieldState();
}

class _CartCouponFieldState extends State<CartCouponField> with ApiCaller {
  TextEditingController couponController;
  _CouponCubit cubit;
  Timer sendTimer;

  @override
  void initState() {
    super.initState();
    cubit = _CouponCubit();
    couponController = TextEditingController(text: widget.cart?.coupon?.name);
  }

  @override
  void dispose() {
    cubit.close();
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<_CouponCubit, _CouponState>(
      cubit: cubit,
      listener: (context, state) {
        if (state == _CouponState.initial) return;
        if (state == _CouponState.success) {
          widget.cart.coupon = cubit.coupon;
        } else if (state == _CouponState.failure) {
          widget.cart.coupon = null;
        }
        widget.onChanged?.call(widget.cart);
      },
      builder: (context, state) {
        final isLoading = state == _CouponState.loading;
        final color =
            widget.cart.coupon != null || state == _CouponState.success
                ? Colors.green.withOpacity(0.7)
                : state == _CouponState.failure
                    ? Colors.red.withOpacity(0.7)
                    : Colors.white70;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: couponController,
                decoration: InputDecoration(
                  hintText: S.current.add_coupon,
                  filled: true,
                  fillColor: color,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                onSubmitted: (value) {
                  cubit.validateCoupon(couponController.text);
                },
                onChanged: (value) {
                  sendTimer?.cancel();
                  sendTimer = Timer(700.milliseconds, () {
                    cubit.validateCoupon(couponController.text);
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildButton(
                label: isLoading
                    ? const FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Text(S.current.add_coupon),
                onTap: isLoading
                    ? null
                    : () async {
                        Helpers.dismissFauces(context);
                        cubit.validateCoupon(couponController.text);
                      },
              ),
            ],
          ),
        );
      },
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
