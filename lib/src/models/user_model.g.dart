// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithTokenModel _$UserWithTokenModelFromJson(Map<String, dynamic> json) {
  return UserWithTokenModel(
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    accessToken: json['access_token'] == null
        ? null
        : AccessTokenModel.fromJson(
            json['access_token'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserWithTokenModelToJson(UserWithTokenModel instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'access_token': instance.accessToken?.toJson(),
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    storeName: json['store_name'] as String,
    vatNumber: json['vat_number'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    settings: json['settings'] as String,
    level: _$enumDecodeNullable(_$UserLevelEnumMap, json['level']),
    phone: json['phone'] as String,
    password: json['password'] as String,
    image: json['image'] as String,
    wallet: (json['wallet'] as num)?.toDouble(),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'store_name': instance.storeName,
      'vat_number': instance.vatNumber,
      'settings': instance.settings,
      'password': instance.password,
      'image': instance.image,
      'wallet': instance.wallet,
      'level': _$UserLevelEnumMap[instance.level],
      'email': instance.email,
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

const _$UserLevelEnumMap = {
  UserLevel.customer: 'customer',
  UserLevel.merchant: 'merchant',
  UserLevel.delivery: 'delivery',
};

AccessTokenModel _$AccessTokenModelFromJson(Map<String, dynamic> json) {
  return AccessTokenModel(
    token: json['token'] as String,
    tokenType: json['token_type'] as String,
    expiresIn: json['expires_in'] as int,
  );
}

Map<String, dynamic> _$AccessTokenModelToJson(AccessTokenModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
