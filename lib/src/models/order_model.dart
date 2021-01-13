import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

enum OrderType { secluded, unsecluded }

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
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class PickupMethodModel {
  const PickupMethodModel({
    this.id,
    this.name,
  });
  final int id;
  final String name;
  @override
  String toString() => name;
  factory PickupMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PickupMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$PickupMethodModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PickupMethodModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
