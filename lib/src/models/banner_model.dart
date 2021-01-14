import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class BannerModel {
  const BannerModel({
    this.id,
    this.image,
  });
  final int id;
  final String image;
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
