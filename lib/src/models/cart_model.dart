import 'package:sehool/src/models/address_model.dart';
import 'package:sehool/src/models/product_model.dart';

import 'order_model.dart';

class CartModel {
  const CartModel(
    this.cartItems,
    this.address,
    this.pickupMethod,
    this.orderDate,
    this.paymentMethod,
    this.notes,
  );

  final List<CartItemModel> cartItems;
  final AddressModel address;
  final PickupMethodModel pickupMethod;
  final DateTime orderDate;
  final PaymentMethodModel paymentMethod;
  final String notes;

  CartModel copyWith({
    List<CartItemModel> cartItems,
    AddressModel address,
    PickupMethodModel pickupMethod,
    DateTime orderDate,
    PaymentMethodModel paymentMethod,
    String notes,
  }) {
    return CartModel(
      cartItems ?? this.cartItems,
      address ?? this.address,
      pickupMethod ?? this.pickupMethod,
      orderDate ?? this.orderDate,
      paymentMethod ?? this.paymentMethod,
      notes ?? this.notes,
    );
  }
}

class CartItemModel {
  const CartItemModel({
    this.quantity,
    this.slicingMethod,
    this.notes,
  });

  final int quantity;
  final SlicingMethodModel slicingMethod;
  final String notes;

  CartItemModel copyWith({
    int quantity,
    SlicingMethodModel slicingMethod,
    String notes,
  }) {
    return CartItemModel(
      quantity: quantity ?? this.quantity,
      slicingMethod: slicingMethod ?? this.slicingMethod,
      notes: notes ?? this.notes,
    );
  }
}
