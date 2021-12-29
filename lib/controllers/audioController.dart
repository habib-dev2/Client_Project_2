import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioController extends GetxController {
  final isLoading = false.obs;
  final _dio = Dio();
  final audioTitle = RxString('');
  final audioUrl = RxString('');

  Future<void> addAudio() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      int? _userId = _prefs.getInt('userId');

      final data = {
        "user_id": _userId,
        "title": audioTitle.value,
        "audiourl": audioUrl.value,
      };
      final res = await _dio.post(
        'https://coonch.com/admin/api/add-audio',
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
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
