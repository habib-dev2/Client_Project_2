import 'package:tesst/repository/repository.dart';

class VideoService {
  Repository? _repository;
  VideoService() {
    _repository = Repository();
  }
  getVideos() async {
    return await _repository?.httpGet('all-videos');
  }

// postCategory(Category category) async{
//   return await _repository.httpPost('post-categories', category.toJson());
// }
// postCategory(Category category) async {
//   return await _repository.httpPost('post-categories', category.toJson());
// }
}
