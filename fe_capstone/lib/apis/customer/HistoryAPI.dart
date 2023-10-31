import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fe_capstone/models/History.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/HistoryDetail.dart';

class HistoryAPI{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<List<History>> getHistoryList() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/reservation/reservationHistory',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        List<History> historyList =
        data.map((item) => History.fromJson(item)).toList();
        return historyList;
      } else {
        throw Exception('Failed to get HistoryList');
      }
    } catch (e) {
      throw Exception('Failed to get HistoryList: $e');
    }
  }



  static Future<HistoryDetail> getHistoryDetail(int reservationId) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/reservation/reservationHistoryDetail?reservationId=$reservationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'];
        HistoryDetail historyDetail = HistoryDetail.fromJson(data);
        return historyDetail;
      } else {
        throw Exception('Failed to get History Detail');
      }
    } catch (e) {
      throw Exception('Failed to get History Detail: $e');
    }
  }




}