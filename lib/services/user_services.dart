import 'package:tesst/model/user.dart';
import 'package:tesst/repository/repository.dart';

class UserService {
  Repository? _repository;

  UserService() {
    _repository = Repository();
  }

  createUser(User user) async {
    return await _repository?.httpPost('new-user-registration', user.toJson());
  }

  login(User user) async {
    return await _repository?.httpPost('registered-user-login', user.toJson());
  }
}
