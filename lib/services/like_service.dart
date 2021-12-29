import 'package:tesst/model/like.dart';
import 'package:tesst/repository/repository.dart';

class LikeService {
  Repository? _repository;
  LikeService() {
    _repository = Repository();
  }
  getLikes() async {
    return await _repository?.httpGet('all-likes');
  }

  postLike(Like like) async {
    return await _repository?.httpPost('add-like', like.toJson());
  }
// postCategory(Category category) async {
//   return await _repository.httpPost('post-categories', category.toJson());
// }
}
