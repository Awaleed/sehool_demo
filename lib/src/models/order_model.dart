import 'package:json_annotation/json_annotation.dart';
import '../../generated/l10n.dart';

import 'address_model.dart';
import 'cart_model.dart';

// part 'order_model.g.dart';

enum OrderType { unsecluded, secluded }
enum PaymentMethodType { cash, visa, wallet }
enum PickupMethod { pickup, delivery }
String mapPaymentMethodTypeToLabel(PaymentMethodType type) {
  switch (type) {
    case PaymentMethodType.cash:
      return S.current.cash_on_delivery;
    case PaymentMethodType.visa:
      return 'VISA';
    case PaymentMethodType.wallet:
      return S.current.balance;
  }
  return '';
}

String mapOrderTypeToLabel(OrderType type) {
  switch (type) {
    case OrderType.secluded:
      return S.current.secluded;
    case OrderType.unsecluded:
      return S.current.unsecluded;
  }
  return '';
}

String mapPickupMethodToLabel(PickupMethod type) {
  switch (type) {
    case PickupMethod.pickup:
      return S.current.pickup;
    case PickupMethod.delivery:
      return S.current.delivery;
  }
  return '';
}

// @JsonSerializable(
//     fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class OrderModel {
  const OrderModel({
    this.cartItems,
    this.orderDate,
    this.address,
    this.pickupMethod,
    this.type,
    this.paymentMethod,
    this.notes,
  });

  final List<CartItemModel> cartItems;
  final AddressModel address;
  final PickupMethod pickupMethod;
  final DateTime orderDate;
  final OrderType type;
  final PaymentMethodType paymentMethod;
  final String notes;
  double get total {
    double value = 0;
    for (var item in cartItems) {
      value += item.total;
    }
    return value;
  }
  // factory OrderModel.fromJson(Map<String, dynamic> json) =>
  //     _$OrderModelFromJson(json);
  // Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

// @JsonSerializable(
//     fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
// class PaymentMethodModel {
//   const PaymentMethodModel({
//     this.id,
//     this.name,
//   });
//   final int id;
//   final String name;

//   @override
//   String toString() => name;

//   factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
//       _$PaymentMethodModelFromJson(json);
//   Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
// }
