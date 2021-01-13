import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class AddressModel {
  const AddressModel({
    this.city,
    this.citySection,
    this.id,
    this.lang,
    this.lat,
    this.note,
    this.address,
  });

  final int id;
  final CityModel city;
  final CitySectionModel citySection;
  final double lang;
  final double lat;
  final String note;
  final String address;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CityModel {
  const CityModel({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  @override
  String toString() => name;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CitySectionModel {
  const CitySectionModel({
    this.id,
    this.city,
    this.name,
  });

  final int id;
  final CityModel city;
  final String name;

  @override
  String toString() => name;

  factory CitySectionModel.fromJson(Map<String, dynamic> json) =>
      _$CitySectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$CitySectionModelToJson(this);
}
