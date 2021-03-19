import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/cart_model.dart';

@singleton
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cart: CartModel()));

  void addItem(CartItemModel value) {
    state.cart.cartItems.add(value);

    emit(state);
  }

  void removeItem(CartItemModel value) {
    state.cart.cartItems.removeWhere((e) => e == value);
    emit(state);
  }

  void clear() {
    emit(CartState(cart: CartModel()));
  }

  void reset() {
    state.cart
      ..address = null
      ..coupon = null
      ..paymentMethod = null
      ..fromWallet = false
      ..hasCoupon = false
      ..organization = false
      ..associationDiscount = null;
  }
}

class CartState {
  CartState({this.cart});
  CartModel cart;

  @override
  int get hashCode => cart.hashCode;

  @override
  bool operator ==(_) => false;
}
