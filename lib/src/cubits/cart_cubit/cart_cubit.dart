import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/cart_model.dart';

@singleton
class CartCubit extends Cubit<CartState> {
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
}

class CartState {
  CartState({this.cart});
  CartModel cart;

  @override
  int get hashCode => cart.hashCode;

  @override
  bool operator ==(_) => false;
}
