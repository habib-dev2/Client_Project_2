// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Likes _$LikesFromJson(Map<String, dynamic> json) {
  return Likes(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    videoId: json['video_id'] as int?,
  );
}

Map<String, dynamic> _$LikesToJson(Likes instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'video_id': instance.videoId,
    };
