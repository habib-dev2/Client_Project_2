import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/model/likes.dart';
import 'package:tesst/screens/Auth/loginpage.dart';

class LikeController extends GetxController {
  final isLoading = false.obs;
  final _dio = Dio();
  final likes = RxList<Likes>();
  final uId = RxInt(0);

  getUid() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? _userId = _prefs.getInt('userId');
    uId.value = _userId!;
    return uId.value;
  }

  Future<void> getLikes() async {
    try {
      final res = await _dio.get(
        'https://coonch.com/admin/api/all-likes',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      List<Likes> likeData = res.data['data']
          .map((json) => Likes.fromJson(json))
          .toList()
          .cast<Likes>();

      likes.clear();
      likes.addAll(likeData);
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> addLike({required int id}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      int? _userId = _prefs.getInt('userId');

      final data = {
        "user_id": _userId,
        "video_id": id,
      };
      final res = await _dio.post(
        'https://coonch.com/admin/api/add-like',
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
      uId.value = _userId!;
      getLikes();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> deleteLikeById({required int id}) async {
    try {
      final res = await _dio.get(
        'https://coonch.com/admin/api/delete-like/$id',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            // "Accept": "application/json",
          },
        ),
      );
      // print(res);
      isLoading.value = false;
      getLikes();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  videoLikesCount({required int id}) {
    var likeCount = [];
    for (var element in likes) {
      if (element.videoId == id) {
        likeCount.add(element.videoId);
      }
    }
    return likeCount.length;
  }

  likeExist({required int id}) {
    // ignore: prefer_typing_uninitialized_variables
    var isLikeExist;
    for (var element in likes) {
      if (element.videoId == id) {
        if (element.userId == uId.value) {
          isLikeExist = element.userId;
        }
      }
    }
    return isLikeExist != null ? true : false;
  }

  checkLikeExist({required BuildContext context, required int id}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? _userId = _prefs.getInt('userId');
    if (_userId != null && _userId > 0) {
      if (!isUserLikeIdExist(id: id, uId: _userId)) {
        addLike(id: id);
      } else {
        deleteLikeById(id: isUserIdExist(id: id, uId: _userId));
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  isUserLikeIdExist({required int id, required int uId}) {
    // ignore: prefer_typing_uninitialized_variables
    var isExist;
    for (var element in likes) {
      if (element.videoId == id) {
        if (element.userId == uId) {
          isExist = element.userId;
        }
      }
    }
    return isExist != null ? true : false;
  }

  isUserIdExist({required int id, required int uId}) {
    // ignore: prefer_typing_uninitialized_variables
    var isUserExist;
    for (var element in likes) {
      if (element.videoId == id) {
        if (element.userId == uId) {
          isUserExist = element.id;
        }
      }
    }
    return isUserExist;
  }
}
