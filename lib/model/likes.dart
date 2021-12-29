import 'package:json_annotation/json_annotation.dart';

part 'likes.g.dart';

@JsonSerializable()
class Likes {
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'video_id')
  int? videoId;

  Likes({
    this.id,
    this.userId,
    this.videoId,
  });

  factory Likes.fromJson(Map<String, dynamic> json) => _$LikesFromJson(json);

  Map<String, dynamic> toJson() => _$LikesToJson(this);
}
