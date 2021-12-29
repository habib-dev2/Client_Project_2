// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    videoId: json['video_id'] as int?,
    comment: json['comment'] as String?,
    userImage: json['userImage'] as String?,
    user: json['user'] as String?,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'video_id': instance.videoId,
      'comment': instance.comment,
      'userImage': instance.userImage,
      'user': instance.user,
    };
