import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/url_constants.dart';
import 'package:fe_capstone/models/RevenueModel.dart';

class AuthPloAPIs{
  static Dio dio = Dio();

  static Future<RevenueModel> getPloRevenue() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '${UrlConstant.PARKING_OWNER}/getRevenue',
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