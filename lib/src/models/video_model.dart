import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class VideoModel {
  const VideoModel({
    this.id,
    this.title,
    this.description,
  });

  final int id;
  final String title;
  final String description;
  
  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
