import 'package:json_annotation/json_annotation.dart';

import 'address_model.dart';

part 'order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class OrderModel {
  const OrderModel({
    this.payment,
    this.status,
    this.id,
    this.note,
    this.total,
    this.address,
    this.products,
    this.createdAt,
  });

  final int id;
  final String note;
  final String payment;
  final double total;
  final AddressModel address;
  final StatusModel status;
  final DateTime createdAt;
  final List<OrderItemModel> products;

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class OrderItemModel {
  const OrderItemModel({
    this.image,
    this.note,
    this.description,
    this.subtotal,
    this.id,
    this.slicerType,
    this.name,
    this.qyt,
  });

  final int id;
  final String name;
  final String image;
  final String description;
  final String note;
  final String slicerType;
  final double subtotal;
  final int qyt;

  @override
  String toString() => name;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class PaymentMethodModel {
  const PaymentMethodModel({this.id, this.name, this.type, this.icon});

  final int id;
  final String name;
  final String type;
  final String icon;

  @override
  String toString() => name;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaymentMethodModel && o.id == id && o.name == name && o.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode;
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class StatusModel {
  const StatusModel({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  @override
  String toString() => name;

  factory StatusModel.fromJson(Map<String, dynamic> json) => _$StatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$StatusModelToJson(this);

  static const statuses = [
    StatusModel(
      id: 1,
      name: 'تم استلام الطلب',
    ),
    StatusModel(
      id: 2,
      name: 'قيد المعالجه',
    ),
    StatusModel(
      id: 3,
      name: 'التجهيز',
    ),
    StatusModel(
      id: 4,
      name: 'التوصيل',
    ),
    StatusModel(
      id: 5,
      name: 'تم',
    ),
    // StatusModel(
    //   id: 6,
    //   name: 'ملغى',
    // ),
    // StatusModel(
    //   id: 7,
    //   name: 'في انتظار الموافقه من الاداره',
    // ),
  ];
}
