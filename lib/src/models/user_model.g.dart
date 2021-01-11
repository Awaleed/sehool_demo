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
        : TokenModel.fromJson(json['access_token'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserWithTokenModelToJson(UserWithTokenModel instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'access_token': instance.accessToken?.toJson(),
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
    };

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) {
  return TokenModel(
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
