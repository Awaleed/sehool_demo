import 'package:json_annotation/json_annotation.dart';
import 'package:sehool/generated/l10n.dart';

part 'order_model.g.dart';

enum OrderType { secluded, unsecluded }
enum PickupMethod { pickup, delivery }
String mapOrderTypeToLabel(OrderType type) {
  switch (type) {
    case OrderType.secluded:
      return S.current.secluded;
    case OrderType.unsecluded:
      return S.current.unsecluded;
  }
  throw UnsupportedError('message');
}

String mapPickupMethodToLabel(PickupMethod type) {
  switch (type) {
    case PickupMethod.pickup:
      return S.current.pickup;
    case PickupMethod.delivery:
      return S.current.delivery;
  }
  throw UnsupportedError('message');
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class OrderModel {
  const OrderModel();

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class PaymentMethodModel {
  const PaymentMethodModel({
    this.id,
    this.name,
  });
  final int id;
  final String name;

  @override
  String toString() => name;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}
