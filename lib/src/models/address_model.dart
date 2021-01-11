import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class AddressModel {
  const AddressModel();

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CityModel {
  const CityModel();

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CitySectionModel {
  const CitySectionModel();

  factory CitySectionModel.fromJson(Map<String, dynamic> json) =>
      _$CitySectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$CitySectionModelToJson(this);
}
