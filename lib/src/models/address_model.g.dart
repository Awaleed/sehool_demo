// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    city: json['city'] == null
        ? null
        : CityModel.fromJson(json['city'] as Map<String, dynamic>),
    citySection: json['city_section'] == null
        ? null
        : CitySectionModel.fromJson(
            json['city_section'] as Map<String, dynamic>),
    id: json['id'] as int,
    lang: (json['lang'] as num)?.toDouble(),
    lat: (json['lat'] as num)?.toDouble(),
    note: json['note'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city?.toJson(),
      'city_section': instance.citySection?.toJson(),
      'lang': instance.lang,
      'lat': instance.lat,
      'note': instance.note,
      'address': instance.address,
    };

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CitySectionModel _$CitySectionModelFromJson(Map<String, dynamic> json) {
  return CitySectionModel(
    id: json['id'] as int,
    city: json['city'] == null
        ? null
        : CityModel.fromJson(json['city'] as Map<String, dynamic>),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CitySectionModelToJson(CitySectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city?.toJson(),
      'name': instance.name,
    };
