import 'package:dio/dio.dart';
import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/constant/url_constants.dart';
import 'package:fe_capstone/models/CustomerDetail.dart';
import 'package:fe_capstone/models/UpdateProfileRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthAPIs {
  static Dio dio = Dio();


  static Future<void> loginUser(String id, String password) async {
    try {
      var response = await dio.post(
        '${UrlConstant.AUTH}/loginUser',
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

        String? deviceToken = await FirebaseAPI.getFirebaseMessagingToken();
        AuthAPIs.addDeviceToken(deviceToken!);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("device_token", deviceToken);


        final ploData = response.data['PLO'];
        if (ploData != null && ploData.containsKey('role')) {
          final fullName = ploData['fullName'];
          await UserPreferences.setFullName(fullName);
          final userId = ploData['ploID'];
          await UserPreferences.setUserID(userId);
        }
        final cusData = response.data['Customer'];
        if (cusData != null && cusData.containsKey('role')) {
          final fullName = cusData['fullName'];
          await UserPreferences.setFullName(fullName);
          final userId = cusData['customerID'];
          await UserPreferences.setUserID(userId);
        }
      } else {
        throw Exception(
            'Tài khoản hoặc mật khẩu không đúng. Vui lòng đăng nhập lại.');
      }
    } catch (e) {
      throw Exception('Login failed. Please check your credentials.');
    }
  }

  static Future<void> addDeviceToken(String deviceToken) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.post(
        '${UrlConstant.AUTH}/addDeviceToken',
        data: {
          "deviceToken": deviceToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Thêm device token thành công');
      } else {
        throw Exception('Failed to add device token.');
      }
    } catch (e) {
      throw Exception('Failed to add device token: $e');
    }
  }

  static Future<void> deleteDeviceToken(String deviceToken) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.delete(
        '${UrlConstant.AUTH}/deleteDeviceToken?deviceToken=$deviceToken',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Xóa device token thành công');
      } else {
        throw Exception('Failed to delete device token.');
      }
    } catch (e) {
      throw Exception('Failed to delete device token: $e');
    }
  }

  static Future<UserProfile> getUserProfile() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }

      final response = await dio.get(
        '${UrlConstant.AUTH}/getProfileUser',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        UserProfile userProfile = UserProfile.fromJson(data);
        return userProfile;
      } else {
        throw Exception('Failed to get user profile');
      }
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
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
        '${UrlConstant.AUTH}/changePassword',
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
        '${UrlConstant.AUTH}/updateProfileUser',
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

  static Future<void> checkPhoneNumber(String phoneNumber, String role) async {
    try {
      var response = await dio.post(
        '${UrlConstant.AUTH}/checkPhoneNumber',
        data: {
          "phoneNumber": phoneNumber,
          "role": role,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Check phone number successful");
      } else {
        throw Exception('Failed to check phone number');
      }
    } catch (e) {
      throw Exception('Failed to check phone number: $e');
    }
  }

  static Future<void> verifyOTP(String otpCode, String phoneNumber) async {
    try {
      var response = await dio.post(
        '${UrlConstant.AUTH}/checkOTPcode',
        data: {
          "otpcode": otpCode,
          "phoneNumber": phoneNumber,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      throw Exception('Verification failed: $e');
    }
  }

  static Future<void> updatePassword(
      String password, String phoneNumber, String role) async {
    try {
      var response = await dio.put(
        '${UrlConstant.AUTH}/updatePassword',
        data: {
          "password": password,
          "phoneNumber": phoneNumber,
          "role": role,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Thay đổi mật khẩu thành công');
      } else {
        throw Exception('Failed to update password');
      }
    } catch (e) {
      throw Exception('Update password failed: $e');
    }
  }

  static Future<void> registerUser(String phoneNumber, String role) async {
    try {
      var response = await dio.post(
        '${UrlConstant.AUTH}/registerUser',
        queryParameters: {
          'phoneNumber': phoneNumber,
          'role': role,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Đăng ký thành công');
      } else {
        throw Exception('Đăng ký thất bại. Vui lòng thử lại sau.');
      }
    } catch (e) {
      throw Exception('Đăng ký thất bại: $e');
    }
  }

  static Future<void> confirmRegisterOTP(
    String fullName,
    String otpCode,
    String password,
    String phoneNumber,
    String role,
  ) async {
    try {
      var response = await dio.post(
        '${UrlConstant.AUTH}/confirmRegisterOTP',
        data: {
          'fullName': fullName,
          'otpcode': otpCode,
          'password': password,
          'phoneNumber': phoneNumber,
          'role': role,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Xác nhận đăng ký thành công');
      } else {
        throw Exception('Xác nhận đăng ký thất bại. Vui lòng thử lại sau.');
      }
    } catch (e) {
      throw Exception('Xác nhận đăng ký thất bại: $e');
    }
  }

}


