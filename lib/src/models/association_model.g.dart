// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociationModel _$AssociationModelFromJson(Map<String, dynamic> json) {
  return AssociationModel(
    association: (json['association'] as List)
        ?.map((e) =>
            e == null ? null : Association.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    discount: (json['discount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AssociationModelToJson(AssociationModel instance) =>
    <String, dynamic>{
      'association': instance.association?.map((e) => e?.toJson())?.toList(),
      'discount': instance.discount,
    };

Association _$AssociationFromJson(Map<String, dynamic> json) {
  return Association(
    id: json['id'] as int,
    name: json['name'] as String,
    associationOfficial: json['association_official'] as String,
    phoneOfficial: json['phone_official'] as int,
    ownersName: json['owners_name'] as String,
  );
}

Map<String, dynamic> _$AssociationToJson(Association instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'association_official': instance.associationOfficial,
      'phone_official': instance.phoneOfficial,
      'owners_name': instance.ownersName,
    };
