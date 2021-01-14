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

  @override
  String toString() => address;
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AddressModel &&
        o.id == id &&
        o.city == city &&
        o.citySection == citySection &&
        o.lang == lang &&
        o.lat == lat &&
        o.note == note &&
        o.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        citySection.hashCode ^
        lang.hashCode ^
        lat.hashCode ^
        note.hashCode ^
        address.hashCode;
  }
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

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CityModel &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
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

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CitySectionModel &&
      o.id == id &&
      o.city == city &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ city.hashCode ^ name.hashCode;
}
