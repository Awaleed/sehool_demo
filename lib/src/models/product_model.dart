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
class SlicingMethod {
  const SlicingMethod();

  factory SlicingMethod.fromJson(Map<String, dynamic> json) =>
      _$SlicingMethodFromJson(json);
  Map<String, dynamic> toJson() => _$SlicingMethodToJson(this);
}
