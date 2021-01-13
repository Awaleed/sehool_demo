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
    level: json['level'] as String,
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
      'level': instance.level,
      'email': instance.email,
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
