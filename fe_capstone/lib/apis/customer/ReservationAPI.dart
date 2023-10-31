

import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';

class ReservationAPI {
  static Dio dio =  Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<void> getBooking(String licensePlate, int methodID, String ploID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '$baseUrl/reservation/bookingReservation',
        data: {
          "licensePlate": licensePlate,
          "methodID": methodID,
          "ploID": ploID
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Booking xe thành công");
      } else {
        throw Exception('Failed to get booking reservation');
      }
    } catch (e) {
      throw Exception('Failed to get booking reservation: $e');
    }
  }

  static Future<void> cancelReservation(int reservationID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/reservation/cancelReservation?reservationID=$reservationID',

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Huỷ xe thành công");
      } else {
        throw Exception('Failed to cancel Reservation');
      }
    } catch (e) {
      throw Exception('Failed to cancel Reservation: $e');
    }
  }

  static Future<List<ReservationMethod>> getMethodofPLO(String ploID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/customer/getListMethodByTime?ploID=$ploID',

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('data ${response.data}');
        final List<dynamic> data = response.data;
        List<ReservationMethod>  reservationMethod = data.map((item) => ReservationMethod.fromJson(item)).toList();
        return reservationMethod;
      } else {
        throw Exception('Failed to get method of Parking lot');
      }
    } catch (e) {
      throw Exception('Failed to get method of Parking lot: $e');
    }
  }

  static Future<void> skipRating(int reservationID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/rating/cancelRating?reservationID=${reservationID}',

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
       print('Skip rating thành công');
      } else {
        throw Exception('Failed to skip rating');
      }
    } catch (e) {
      throw Exception('Failed to skip rating: $e');
    }
  }


}