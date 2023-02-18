import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:practical_test/model/user-model.dart';

class UserProvider {
  final Dio _dio = Dio();
  final String _url = 'https://randomuser.me/api/';

  Future<User> fetchUserData() async {
    try {
      Response response = await _dio.get(_url);
      print(response.data);
      return User.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      print("Here");
      return User();
    }
  }
}
