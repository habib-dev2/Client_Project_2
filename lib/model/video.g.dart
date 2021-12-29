// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) {
  return Video(
    id: json['id'] as int?,
    title: json['title'] as String?,
    likes: json['likes'] as int?,
    categoryId: json['category_id'] as int?,
    videourl: json['videourl'] as String?,
    status: json['status'] as int?,
  );
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'likes': instance.likes,
      'category_id': instance.categoryId,
      'videourl': instance.videourl,
      'status': instance.status,
    };
