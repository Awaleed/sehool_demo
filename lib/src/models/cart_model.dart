import 'package:flutter/foundation.dart';

import 'address_model.dart';
import 'order_model.dart';
import 'product_model.dart';

class CartModel {
  List<CartItemModel> cartItems = [];
  AddressModel address;
  PickupMethodModel pickupMethod;
  DateTime orderDate = DateTime.now();
  OrderType type;
  PaymentMethodModel paymentMethod;
  String notes;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartModel &&
        listEquals(o.cartItems, cartItems) &&
        o.address == address &&
        o.pickupMethod == pickupMethod &&
        o.orderDate == orderDate &&
        o.type == type &&
        o.paymentMethod == paymentMethod &&
        o.notes == notes;
  }

  @override
  int get hashCode {
    return cartItems.hashCode ^
        address.hashCode ^
        pickupMethod.hashCode ^
        orderDate.hashCode ^
        type.hashCode ^
        paymentMethod.hashCode ^
        notes.hashCode;
  }
}

class CartItemModel {
  int get quantity => _quantity;
  int _quantity = 1;

  ProductModel product;
  SlicingMethodModel slicingMethod;
  String notes;

  void incrementCart() => _quantity < 100 ? _quantity++ : _quantity;
  void decrementCart() => _quantity > 1 ? _quantity-- : _quantity;

  bool get validate => product != null && slicingMethod != null && quantity > 0;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartItemModel &&
        o.quantity == quantity &&
        o.slicingMethod == slicingMethod &&
        o.notes == notes;
  }

  @override
  int get hashCode =>
      quantity.hashCode ^ slicingMethod.hashCode ^ notes.hashCode;
}
