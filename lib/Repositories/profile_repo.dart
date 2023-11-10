import 'package:dio/dio.dart';

import '../Models/user_model.dart';
import '../Utils/Constants/end_point.dart';

class ProfileRepository {
  Dio dio = Dio();
  Future<UserModel> myProfile(UserModel user) async {
    var url = '$baseUrl$myProfileEndpoint?uid=${user.uid}';
    try {
      final response = await dio.get(url,
          options: Options(
              headers: {'Context-Type': 'application/json;charSet=UTF-8'}));
      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data['response']);
        return userModel;
      } else {
        throw Exception("Some went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateProfile(UserModel user) async {
  var url = baseUrl + updateProfileEndpoint;
  try {
    var response = await dio.put(
      url,
      data: user,
      options: Options(
        headers: {'Content-Type': 'application/json; charset=UTF-8'}, // Fixed 'Context-Type' to 'Content-Type'
      ),
    );
    if (response.statusCode == 200) {
      var user = UserModel.fromJson(response.data["response"]);
      return user;
    } else {
      print("Something went wrong");
    }
    return UserModel.fromJson(response.data);
  } catch (e) {
    rethrow;
  }
}

}
