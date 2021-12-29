import 'package:tesst/repository/repository.dart';

class CategoryService {
  Repository? _repository;
  CategoryService() {
    _repository = Repository();
  }
  getCategories() async {
    return await _repository?.httpGet('categories');
  }

  deleteCategory(categoryId) async {
    return await _repository?.httpGetById('delete-category', categoryId);
  }

  // postCategory(Category category) async{
  //   return await _repository.httpPost('post-categories', category.toJson());
  // }
  // postCategory(Category category) async {
  //   return await _repository.httpPost('post-categories', category.toJson());
  // }
}
