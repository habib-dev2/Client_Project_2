import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/model/comment.dart';

class CommentController extends GetxController {
  final isLoading = false.obs;
  final _dio = Dio();
  final comments = RxList<Comment>();
  final uId = RxString('');
  final comment = RxString('');

  Future<void> getComments() async {
    try {
      final res = await _dio.get(
        'https://coonch.com/admin/api/all-comments',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );
      // print(res);
      List<Comment> commentData = res.data['data']
          .map((json) => Comment.fromJson(json))
          .toList()
          .cast<Comment>();

      comments.clear();
      comments.addAll(commentData);
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> addComment(
      {required BuildContext context, required int id}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      int? _userId = _prefs.getInt('userId');

      final data = {
        "user_id": _userId,
        "video_id": id,
        "comment": comment.value,
      };
      final res = await _dio.post(
        'https://coonch.com/admin/api/add-comment',
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            // "Accept": "application/json",
          },
        ),
      );
      // print(res);

      isLoading.value = false;
      getComments();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  videoCommentCount({required int id}) {
    var commentCount = [];
    // ignore: avoid_function_literals_in_foreach_calls
    comments.forEach((element) {
      if (element.videoId == id) {
        commentCount.add(element.videoId);
      }
    });
    return commentCount.length;
  }
}
