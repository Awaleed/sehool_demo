import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class ProductModel {
  const ProductModel();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class ReviewModel {
  const ReviewModel();

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
