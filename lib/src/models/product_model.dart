import 'package:json_annotation/json_annotation.dart';
import 'package:sehool/src/models/user_model.dart';

part 'product_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class ProductModel {
  const ProductModel({
    this.id,
    this.name,
    this.image,
    this.description,
    this.price,
    this.qyt,
  });
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final int qyt;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class ReviewModel {
  const ReviewModel({
    this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.user,
  });

  final int id;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final UserModel user;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class SlicingMethodModel {
  const SlicingMethodModel({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  factory SlicingMethodModel.fromJson(Map<String, dynamic> json) =>
      _$SlicingMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$SlicingMethodModelToJson(this);
}
