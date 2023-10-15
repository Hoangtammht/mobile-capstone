import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthAPIs{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparking.azurewebsites.net';

  static Future<void> loginUser(String id, String password) async {
    try {
      Response response = await dio.post(
        '$baseUrl/user/loginUser',
        data: {
          "id": id,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', response.data['access_token']);
      } else {
        throw Exception('Tài khoản hoặc mật khẩu không đúng. Vui lòng đăng nhập lại.');
      }
    } catch (e) {
      throw Exception('Login failed. Please check your credentials.');
    }
  }


}