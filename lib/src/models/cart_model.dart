import 'package:flutter/foundation.dart';

import 'address_model.dart';
import 'order_model.dart';
import 'product_model.dart';

class CartModel {
  List<CartItemModel> cartItems = [];
  AddressModel address;
  PickupMethod pickupMethod;
  DateTime orderDate = DateTime.now();
  OrderType type;
  PaymentMethodType paymentMethod;
  String notes;

  double get total {
    double value = 0;
    for (var item in cartItems) {
      value += item.total;
    }
    return value;
  }

  bool get validate => validateAddress && type != null && paymentMethod != null;
  bool get validateAddress =>
      pickupMethod == PickupMethod.pickup ||
      (pickupMethod == PickupMethod.delivery && address != null);

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
  int quantity = 1;

  ProductModel product;
  SlicingMethodModel slicingMethod;
  String notes;

  double get total => product.price * quantity;

  void incrementCart() => quantity++;
  void decrementCart() => quantity > 1 ? quantity-- : quantity;

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
