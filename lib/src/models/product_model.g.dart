// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel();
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{};

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return ReviewModel();
}

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{};

SlicingMethodModel _$SlicingMethodModelFromJson(Map<String, dynamic> json) {
  return SlicingMethodModel(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$SlicingMethodModelToJson(SlicingMethodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
