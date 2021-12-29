import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'video_id')
  int? videoId;
  String? comment;
  String? userImage;
  String? user;

  Comment({
    this.id,
    this.userId,
    this.videoId,
    this.comment,
    this.userImage,
    this.user,
  });
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
