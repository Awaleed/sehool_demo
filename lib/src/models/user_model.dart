import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class UserWithTokenModel {
  const UserWithTokenModel({
    this.user,
    this.accessToken,
  });

  final UserModel user;
  final AccessTokenModel accessToken;

  factory UserWithTokenModel.fromJson(Map<String, dynamic> json) => _$UserWithTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserWithTokenModelToJson(this);

  UserWithTokenModel copyWith({
    UserModel user,
    AccessTokenModel accessToken,
  }) {
    return UserWithTokenModel(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class UserModel {
  const UserModel({
    this.storeName,
    this.vatNumber,
    this.name,
    this.email,
    this.settings,
    this.level,
    this.phone,
    this.password,
    this.image,
    this.wallet,
    this.id,
    this.status,
  });

  final int id;
  final String name;
  final int status;
  final String phone;
  final String storeName;
  final String vatNumber;
  final String settings;
  final String password;
  final String image;
  final double wallet;
  final UserLevel level;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    int id,
    int status,
    String name,
    String phone,
    String storeName,
    String vatNumber,
    String settings,
    String password,
    String image,
    double wallet,
    String level,
    String email,
  }) {
    return UserModel(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      storeName: storeName ?? this.storeName,
      vatNumber: vatNumber ?? this.vatNumber,
      settings: settings ?? this.settings,
      password: password ?? this.password,
      image: image ?? this.image,
      wallet: wallet ?? this.wallet,
      level: level ?? this.level,
      email: email ?? this.email,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel && o.id == id && o.status == status && o.name == name && o.phone == phone && o.storeName == storeName && o.vatNumber == vatNumber && o.settings == settings && o.password == password && o.image == image && o.wallet == wallet && o.level == level && o.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ status.hashCode ^ name.hashCode ^ phone.hashCode ^ storeName.hashCode ^ vatNumber.hashCode ^ settings.hashCode ^ password.hashCode ^ image.hashCode ^ wallet.hashCode ^ level.hashCode ^ email.hashCode;
  }
}

enum UserLevel { customer, merchant, delivery }

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class AccessTokenModel {
  const AccessTokenModel({
    this.token,
    this.tokenType,
    this.expiresIn,
  });

  final String token;
  final String tokenType;
  final int expiresIn;

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) => _$AccessTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenModelToJson(this);

  AccessTokenModel copyWith({
    String token,
    String tokenType,
    int expiresIn,
  }) {
    return AccessTokenModel(
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}
