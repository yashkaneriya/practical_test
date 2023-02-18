import 'package:practical_test/model/user-model.dart';
import 'package:practical_test/resources/user-provider.dart';

class UserRepository {
  final _provider = UserProvider();

  Future<User> fetchUserData() {
    return _provider.fetchUserData();
  }
}

class NetworkError extends Error {}
