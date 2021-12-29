import 'package:get/get.dart';
import 'package:tesst/controllers/audioController.dart';
import 'package:tesst/controllers/commentController.dart';
import 'package:tesst/controllers/likeController.dart';
import 'package:tesst/controllers/videoController.dart';

class BaseController {
  final videoC = Get.put(VideoController());
  final likeC = Get.put(LikeController());
  final commentC = Get.put(CommentController());
  final audioC = Get.put(AudioController());
}
