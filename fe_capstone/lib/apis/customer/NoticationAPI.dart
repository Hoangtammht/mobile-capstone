import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fe_capstone/models/CustomerNotification.dart';
import 'package:fe_capstone/models/History.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';

class NoticationAPI{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<List<CustomerNotification>> getNotication() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/user/getNotifcations',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<CustomerNotification> customerNotication =
        data.map((item) => CustomerNotification.fromJson(item)).toList();
        return customerNotication;

      } else {
        throw Exception('Failed to get Noti List');
      }
    } catch (e) {
      throw Exception('Failed to get Noti List: $e');
    }
  }

}