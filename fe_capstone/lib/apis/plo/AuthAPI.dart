import 'package:dio/dio.dart';
import 'package:fe_capstone/models/PloDetail.dart';
import 'package:fe_capstone/models/UpdateProfileRequest.dart';

class AuthPloAPIs{
  static Dio dio = Dio();

  static Future<PloProfile> getPloProfile(String token) async {
    try {
      final response = await dio.get(
        'https://eparking.azurewebsites.net/PLO/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        PloProfile ploProfile = PloProfile.fromJson(data);
        return ploProfile;
      } else {
        throw Exception('Failed to get PloProfile');
      }
    } catch (e) {
      throw Exception('Failed to get PloProfile: $e');
    }
  }

  static Future<void> changePassword(
      String token,
      String currentPassword,
      String newPassword,
      String reNewPassword,
      ) async {
    try {
      final response = await dio.put(
        'https://eparking.azurewebsites.net/PLO/changePassword',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
        queryParameters: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'reNewPassword': reNewPassword,
        },
      );

      if (response.statusCode == 200) {
        print('Thay đổi mật khẩu thành công');
      } else {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  static Future<void> updateProfile(String token, UpdateProfileRequest request) async {
    try {
      final response = await dio.put(
        'https://eparking.azurewebsites.net/PLO/updateProfile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        print('Cập nhật thông tin cá nhân thành công');
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }




}