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
  // String note;
  bool isGift = false;
  ValueWithId phrase;
  ValueWithId event;
  CouponModel coupon;

  String from;
  String to;
  String customPhrase;

  double deliveryFees = 50;

  double get totalWithoutDiscount => subtotalWithDelivery * 1.15;
  double get total => discountedSubtotal * 1.15;

  double get subtotal {
    double value = 0;
    for (final item in cartItems) {
      value += item.total;
    }
    return value;
  }

  double get subtotalWithDelivery => subtotal + deliveryFees;

  double get discountedSubtotal {
    double value = subtotalWithDelivery;
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

  double get discountAmount => subtotalWithDelivery - discountedSubtotal;

  bool get validate => paymentMethod != null && address != null;

  Map<String, dynamic> toJson() {
    return {
      // 'note': note ?? '',
      if (isGift) ...{
        'from': from,
        'to': to,
        'event': event.name,
        'phrases': customPhrase ?? phrase.name,
      },
      'address_id': address.id,
      'payment_method_id': paymentMethod.id,
      'coupon_id': coupon?.id,
      'products': cartItems
          .map(
            (e) => {'product_id': e.product.id, 'qyt': e.quantity, 'note': e.note ?? '', 'slicer_type_id': e.slicingMethod.id},
          )
          .toList(),
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartModel && listEquals(o.cartItems, cartItems) && o.address == address && o.paymentMethod == paymentMethod; // &&
    // o.note == note;
  }

  @override
  int get hashCode {
    return cartItems.hashCode ^ address.hashCode ^ paymentMethod.hashCode; //^ note.hashCode;
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

    return o is CartItemModel && o.quantity == quantity && o.slicingMethod == slicingMethod && o.note == note;
  }

  @override
  int get hashCode => quantity.hashCode ^ slicingMethod.hashCode ^ note.hashCode;
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CartMessageModel {
  CartMessageModel({
    this.phrases,
    this.event,
  });

  final List<ValueWithId> phrases;
  final List<ValueWithId> event;

  factory CartMessageModel.fromJson(Map<String, dynamic> json) => _$CartMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartMessageModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class ValueWithId {
  ValueWithId(this.id, this.name);

  final int id;
  final String name;

  factory ValueWithId.fromJson(Map<String, dynamic> json) => _$ValueWithIdFromJson(json);
  Map<String, dynamic> toJson() => _$ValueWithIdToJson(this);
  @override
  String toString() => name;
}

enum CouponType { fixed, percentage }

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
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

  factory CouponModel.fromJson(Map<String, dynamic> json) => _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CouponModel && o.id == id && o.name == name && o.amount == amount && o.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ amount.hashCode ^ type.hashCode;
  }
}
