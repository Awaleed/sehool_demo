import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'address_model.dart';
import 'order_model.dart';
import 'product_model.dart';

part 'cart_model.g.dart';

class CartModel {
  List<CartItemModel> cartItems = [];
  AddressModel address;
  PaymentMethodModel paymentMethod;
  String note;
  CouponModel coupon;

  double get total {
    double value = 0;
    for (final item in cartItems) {
      value += item.total;
    }
    if (coupon != null) {
      switch (coupon.type) {
        case CouponType.fixed:
          value -= coupon.amount;
          break;
        case CouponType.percentage:
          value *= (100 - coupon.amount) / 100;
          break;
      }
    }

    return value >= 0 ? value : 0;
  }

  double get totalBeforeCoupon {
    double value = 0;
    for (final item in cartItems) {
      value += item.total;
    }
    return value;
  }

  bool get validate => paymentMethod != null && address != null;

  Map<String, dynamic> toJson() {
    return {
      'note': note ?? '',
      'address_id': address.id,
      'payment_method_id': paymentMethod.id,
      'products': cartItems
          .map(
            (e) => {
              'product_id': e.product.id,
              'qyt': e.quantity,
              'note': e.note ?? '',
              'slicer_type_id': e.slicingMethod.id
            },
          )
          .toList(),
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartModel &&
        listEquals(o.cartItems, cartItems) &&
        o.address == address &&
        o.paymentMethod == paymentMethod &&
        o.note == note;
  }

  @override
  int get hashCode {
    return cartItems.hashCode ^
        address.hashCode ^
        paymentMethod.hashCode ^
        note.hashCode;
  }
}

class CartItemModel {
  int quantity = 1;

  ProductModel product;
  SlicingMethodModel slicingMethod;
  String note;

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
        o.note == note;
  }

  @override
  int get hashCode =>
      quantity.hashCode ^ slicingMethod.hashCode ^ note.hashCode;
}

enum CouponType { fixed, percentage }

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CouponModel {
  const CouponModel({
    this.id,
    this.name,
    this.amount,
    this.type,
  });

  final int id;
  final String name;
  final double amount;
  final CouponType type;

  @override
  String toString() {
    return 'CouponModel(id: $id, name: $name, amount: $amount, type: $type)';
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CouponModel &&
      o.id == id &&
      o.name == name &&
      o.amount == amount &&
      o.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      amount.hashCode ^
      type.hashCode;
  }
}
