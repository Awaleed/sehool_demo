// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    id: json['id'] as int,
    description: json['description'] as String,
    video: json['video'] as String,
    preview: json['preview'] as String,
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'video': instance.video,
      'preview': instance.preview,
    };
