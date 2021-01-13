// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String,
    description: json['description'] as String,
    price: (json['price'] as num)?.toDouble(),
    qyt: json['qyt'] as int,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'price': instance.price,
      'qyt': instance.qyt,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return ReviewModel(
    id: json['id'] as int,
    rating: json['rating'] as int,
    comment: json['comment'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt?.toIso8601String(),
      'user': instance.user?.toJson(),
    };

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
