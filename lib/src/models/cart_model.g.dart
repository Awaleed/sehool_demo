// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartMessageModel _$CartMessageModelFromJson(Map<String, dynamic> json) {
  return CartMessageModel(
    phrases: (json['phrases'] as List)
        ?.map((e) =>
            e == null ? null : ValueWithId.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    event: (json['event'] as List)
        ?.map((e) =>
            e == null ? null : ValueWithId.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CartMessageModelToJson(CartMessageModel instance) =>
    <String, dynamic>{
      'phrases': instance.phrases?.map((e) => e?.toJson())?.toList(),
      'event': instance.event?.map((e) => e?.toJson())?.toList(),
    };

ValueWithId _$ValueWithIdFromJson(Map<String, dynamic> json) {
  return ValueWithId(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ValueWithIdToJson(ValueWithId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) {
  return CouponModel(
    id: json['id'] as int,
    name: json['name'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    type: _$enumDecodeNullable(_$CouponTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'type': _$CouponTypeEnumMap[instance.type],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CouponTypeEnumMap = {
  CouponType.fixed: 'fixed',
  CouponType.percentage: 'percentage',
};
