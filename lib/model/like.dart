class Like {
  int? id;
  int? userId;
  int? videoId;

  toJson() {
    return {
      'id': id.toString(),
      'user_id': userId.toString(),
      'video_id': videoId.toString()
    };
  }
}
