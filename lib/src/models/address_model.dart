import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  nullable: true,
  createToJson: false,
)
class AddressModel {
  const AddressModel({
    this.city,
    this.section,
    this.id,
    this.lang,
    this.lat,
    this.address,
  });

  final int id;
  final String address;
  final double lat;
  final double lang;
  final CityModel city;
  final CitySectionModel section;

  bool get hasLocation => lat != null && lang != null;

  LatLng get latLng => LatLng(lat, lang);

  @override
  String toString() => address ?? '';

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => {
        'address': address,
        'lat': lat,
        'lang': lang,
        'section_id': section.id,
        'city_id': city.id,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AddressModel &&
        o.id == id &&
        o.city == city &&
        o.section == section &&
        o.lang == lang &&
        o.lat == lat &&
        o.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        section.hashCode ^
        lang.hashCode ^
        lat.hashCode ^
        address.hashCode;
  }
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CityModel {
  const CityModel({
    this.id,
    this.name,
    this.sections,
  });

  final int id;
  final String name;
  final List<CitySectionModel> sections;

  @override
  String toString() => name;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CityModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class CitySectionModel {
  const CitySectionModel({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  @override
  String toString() => name;

  factory CitySectionModel.fromJson(Map<String, dynamic> json) =>
      _$CitySectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CitySectionModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CitySectionModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
