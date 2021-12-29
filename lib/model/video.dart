import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  int? id;
  String? title;
  int? likes;
  @JsonKey(name: 'category_id')
  int? categoryId;
  String? videourl;
  int? status;

  Video({
    this.id,
    this.title,
    this.likes,
    this.categoryId,
    this.videourl,
    this.status,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
