import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:sehool/src/core/api_caller.dart';
import 'package:sehool/src/helpers/helper.dart';
import 'package:sehool/src/routes/config_routes.dart';

import '../../models/cart_model.dart';

@singleton
class CartCubit extends Cubit<CartState> with ApiCaller {
  CartCubit() : super(CartState(cart: CartModel()));

  void addItem(CartItemModel value) {
    final foundIndex = state.cart.cartItems
        .indexWhere((e) => e.product.id == value.product.id);
    if (foundIndex > -1) {
      state.cart.cartItems[foundIndex] = value;
    } else {
      state.cart.cartItems.add(value);
    }
    emit(state);
  }

  void removeItem(int productId) {
    state.cart.cartItems.removeWhere((e) => e.product.id == productId);
    emit(state);
  }

  Future<void> placeOrder(BuildContext context, CartModel cart) async {
    final com = Helpers.showLoading(context);
    try {
      final res = await post(path: '/shoppingCart', data: cart.toJson());
      emit(CartState(cart: CartModel()));

      AppRouter.sailor.pop();
    } catch (e) {
      addError(e);
      Helpers.showErrorOverlay(context, error: '$e');
    } finally {
      com.complete();
    }
  }
}

class CartState {
  CartState({this.cart, this.isLoading});
  CartModel cart;
  bool isLoading;

  @override
  int get hashCode => cart.hashCode;

  @override
  bool operator ==(_) => false;
}
