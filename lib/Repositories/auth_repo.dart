import 'package:dio/dio.dart';
import 'package:notes_app/Utils/Constants/end_point.dart';

import '../Models/user_model.dart';

class AuthRepository {
  Dio dio = Dio();
  Future<bool> registerUser(
      String username, String email, String password) async {
    var url = baseUrl + registerEndpoint;
    try {
      final response = await dio.post(url,
          data: {
            'username': username,
            'email': email,
            'password': password,
            'uid': ""
          },
          options: Options(
              headers: {'Context-Type': 'application/json;charSet=UTF-8'}));
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("There was an error Registering in!");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(String email, String password) async {
    var url = baseUrl + loginEndpoint;
    try {
      var response = await dio.post(url,
          data: {"email": email, "password": password},
          options: Options(
              headers: {'Context-Type': 'application/json;charSet=UTF-8'}));
      if (response.statusCode == 200) {
        var user = UserModel.fromJson(response.data["response"]);
        return user;
      } else {
        print("some went wrong");
      }
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
