import 'package:dio/dio.dart';

class QuestionService {
  Dio _dio = Dio(BaseOptions(
      baseUrl: "https://trans.rticonsulting.com.au/"
  ));

  Future<bool> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        '/user/login',
        data: {
          'userName': username,
          'userPassword': password,
        },
      );

      if (response.data != null && response.data['status'] == 'OK') {
        print("Login successful. User ID: ${response.data['id']}");
        return true;
      } else {
        print("Login failed.");
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

}