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
    section: json['section'] == null
        ? null
        : CitySectionModel.fromJson(json['section'] as Map<String, dynamic>),
    id: json['id'] as int,
    lang: (json['lang'] as num)?.toDouble(),
    lat: (json['lat'] as num)?.toDouble(),
    address: json['address'] as String,
  );
}

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    id: json['id'] as int,
    name: json['name'] as String,
    sections: (json['sections'] as List)
        ?.map((e) => e == null
            ? null
            : CitySectionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sections': instance.sections?.map((e) => e?.toJson())?.toList(),
    };

CitySectionModel _$CitySectionModelFromJson(Map<String, dynamic> json) {
  return CitySectionModel(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CitySectionModelToJson(CitySectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
