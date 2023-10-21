import 'package:dio/dio.dart';
import 'package:fe_capstone/models/PloDetail.dart';
import 'package:fe_capstone/models/RevenueModel.dart';
import 'package:fe_capstone/models/UpdateProfileRequest.dart';

class AuthPloAPIs{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparking.azurewebsites.net';

  static Future<PloProfile> getPloProfile(String token) async {
    try {
      final response = await dio.get(
        '$baseUrl/PLO/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
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
      final Map<String, dynamic> requestData = {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'reNewPassword': reNewPassword,
      };

      final response = await dio.put(
        '$baseUrl/PLO/changePassword',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: requestData,
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
        '$baseUrl/PLO/updateProfile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
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

  static Future<RevenueModel> getPloRevenue(String token) async {
    try {
      final response = await dio.get(
        '$baseUrl/PLO/getRevenue',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = Map<String, dynamic>.from(response.data);
        RevenueModel revenueModel = RevenueModel.fromJson(responseData);
        return revenueModel;
      } else {
        throw Exception('Failed to get PloRevenue');
      }
    } catch (e) {
      throw Exception('Failed to get PloRevenue: $e');
    }
  }



}