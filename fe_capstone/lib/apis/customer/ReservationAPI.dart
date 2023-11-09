

import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/url_constants.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';

class ReservationAPI {
  static Dio dio =  Dio();


  static Future<void> getBooking(String licensePlate, int methodID, String ploID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '${UrlConstant.RESERVATION}/bookingReservation',
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
        '${UrlConstant.RESERVATION}/cancelReservation?reservationID=$reservationID',

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
        '${UrlConstant.CUSTOMER}/getListMethodByTime?ploID=$ploID',

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
        '${UrlConstant.RATING}/cancelRating?reservationID=${reservationID}',

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

  static Future<void> sendRating(String content, String ploID, int reservationID, int star) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '${UrlConstant.RATING}/sendRating',
        data: {
          "content": content,
          "ploID": ploID,
          "reservationID": reservationID,
          "star": star,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Send rating thành công');
      } else {
        throw Exception('Failed to send rating');
      }
    } catch (e) {
      throw Exception('Failed to send rating: $e');
    }
  }

  static Future<bool> updateReservationToCancel(int reservationID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '${UrlConstant.CUSTOMER}/updateReservationToCancel?reservationID=$reservationID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data != null) {
          bool isCancelled = response.data;
          return isCancelled;
        } else {
          throw Exception('Response data is null');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update reservation to cancel: $e');
    }
  }

  static Future<bool> updateReservationToLater(int reservationID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '${UrlConstant.CUSTOMER}/updateReservationToLate?reservationID=$reservationID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data != null) {
          bool isCancelled = response.data;
          return isCancelled;
        } else {
          throw Exception('Response data is null');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update reservation to later: $e');
    }
  }

}