

import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/url_constants.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';

class ReservationAPI {
  static Dio dio =  Dio();


  static Future<int> getBooking(int licensePlateID, int methodID, String ploID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '${UrlConstant.RESERVATION}/bookingReservation',
        data: {
          "methodID": methodID,
          "motorbikeID": licensePlateID,
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
        String responseMessage = response.data;
        if(responseMessage.contains('Full')){
          return 2;
        }
        return 1;
      } else {
        throw Exception('Failed to get booking reservation');
      }
    } catch (e) {
      throw Exception('Failed to get booking reservation: $e');
    }
  }


  static Future<int> getBookingForStranger(String image, String licensePlate) async {
    print('test $image');
    print('test $licensePlate');
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '${UrlConstant.RESERVATION}/bookingGuest',
        data: {
          "image": image,
          "licensePlate": licensePlate,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        String responseMessage = response.data;
        if(responseMessage.contains('Full')){
          return 2;
        }
        return 1;
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

  static Future<ReservationMethod> getMethodofPLO(String ploID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '${UrlConstant.CUSTOMER}/getMethodByTime?ploID=$ploID',

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('data ${response.data}');
        final Map<String, dynamic> data = response.data;
        ReservationMethod  reservationMethod =  ReservationMethod.fromJson(data);
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