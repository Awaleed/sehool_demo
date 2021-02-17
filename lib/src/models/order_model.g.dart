// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    payment: json['payment'] as String,
    status: json['status'] == null
        ? null
        : StatusModel.fromJson(json['status'] as Map<String, dynamic>),
    id: json['id'] as int,
    note: json['note'] as String,
    total: (json['total'] as num)?.toDouble(),
    address: json['address'] == null
        ? null
        : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'payment': instance.payment,
      'total': instance.total,
      'address': instance.address?.toJson(),
      'status': instance.status?.toJson(),
      'created_at': instance.createdAt?.toIso8601String(),
      'products': instance.products?.map((e) => e?.toJson())?.toList(),
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) {
  return OrderItemModel(
    image: json['image'] as String,
    note: json['note'] as String,
    description: json['description'] as String,
    subtotal: (json['subtotal'] as num)?.toDouble(),
    id: json['id'] as int,
    slicerType: json['slicer_type'] as String,
    name: json['name'] as String,
    qyt: json['qyt'] as int,
  );
}

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'note': instance.note,
      'slicer_type': instance.slicerType,
      'subtotal': instance.subtotal,
      'qyt': instance.qyt,
    };

PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) {
  return PaymentMethodModel(
    id: json['id'] as int,
    name: json['name'] as String,
    type: json['type'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodModelToJson(PaymentMethodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'icon': instance.icon,
    };

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) {
  return StatusModel(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
