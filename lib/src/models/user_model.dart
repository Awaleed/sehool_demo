import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class UserWithTokenModel {
  const UserWithTokenModel({
    this.user,
    this.accessToken,
  });

  final UserModel user;
  final TokenModel accessToken;

  factory UserWithTokenModel.fromJson(Map<String, dynamic> json) =>
      _$UserWithTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserWithTokenModelToJson(this);

  UserWithTokenModel copyWith({
    UserModel user,
    TokenModel accessToken,
  }) {
    return UserWithTokenModel(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class UserModel {
  const UserModel({
    this.id,
  });
  final int id;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class TokenModel {
  const TokenModel({
    this.token,
  });

  final String token;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
