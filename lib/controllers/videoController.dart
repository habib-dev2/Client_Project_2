import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tesst/model/video.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  VideoPlayerController? videoController;
  final isLoading = false.obs;
  final _dio = Dio();
  final videos = RxList<Video>();

  Future<void> getVideo() async {
    try {
      final res = await _dio.get(
        'http://www.coonch.com/admin/api/all-videos',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );
      // print('All Videos');

      List<Video> videoData = res.data['data']
          .map((json) => Video.fromJson(json))
          .toList()
          .cast<Video>();

      videos.clear();
      videos.addAll(videoData);
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
