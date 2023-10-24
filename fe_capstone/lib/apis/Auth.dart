import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/CustomerDetail.dart';
import 'package:fe_capstone/models/PloDetail.dart';
import 'package:fe_capstone/models/UpdateProfileRequest.dart';


class AuthAPIs{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<void> loginUser(String id, String password) async {
    try {
      var response = await dio.post(
        '$baseUrl/user/loginUser',
        data: {
          "id": id,
          "password": password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        await UserPreferences.setAccessToken(response.data['access_token']);
      } else {
        throw Exception('Tài khoản hoặc mật khẩu không đúng. Vui lòng đăng nhập lại.');
      }
    } catch (e) {
      throw Exception('Login failed. Please check your credentials.');
    }
  }

  static Future<PloProfile> getPloProfile() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }

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


  static Future<CustomerProfile> getCustomerProfile() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }

      final response = await dio.get(
        '$baseUrl/customer/getProfile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        CustomerProfile customerProfile = CustomerProfile.fromJson(data);
        return customerProfile;
      } else {
        throw Exception('Failed to get PloProfile');
      }
    } catch (e) {
      throw Exception('Failed to get PloProfile: $e');
    }
  }


  static Future<void> changePassword(
      String currentPassword,
      String newPassword,
      String reNewPassword,
      ) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
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

  static Future<void> updateProfile(UpdateProfileRequest request) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
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


}