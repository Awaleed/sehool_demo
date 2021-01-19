import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class VideoModel {
  const VideoModel({
    this.id,
    this.description,
    this.video,
    this.preview,
  });

  final int id;
  final String description;
  final String video;
  final String preview;

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);

  @override
  String toString() {
    return 'VideoModel(id: $id, description: $description, video: $video, preview: $preview)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VideoModel &&
        o.id == id &&
        o.description == description &&
        o.video == video &&
        o.preview == preview;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        video.hashCode ^
        preview.hashCode;
  }
}
