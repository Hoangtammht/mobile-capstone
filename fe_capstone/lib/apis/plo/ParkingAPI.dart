import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/ListVehicleInParking.dart';
import 'package:fe_capstone/models/PLONotification.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:fe_capstone/models/ParkingStatusInformation.dart';
import 'package:fe_capstone/models/PaymentResponse.dart';
import 'package:fe_capstone/models/RatingModel.dart';
import 'package:fe_capstone/models/RequestResgisterParking.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';
import 'package:fe_capstone/models/ResponseSettingParking.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingAPI {
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<ParkingInformationModel> getParkingInformation() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/PLO/getParkingInformation',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        ParkingInformationModel parkingInfo =
            ParkingInformationModel.fromJson(data);
        return parkingInfo;
      } else {
        throw Exception('Failed to get parking information');
      }
    } catch (e) {
      throw Exception('Failed to get parking information: $e');
    }
  }

  static Future<List<RatingModel>> getRatingList() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/PLO/getRatingList',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<RatingModel> ratings =
            data.map((json) => RatingModel.fromJson(json)).toList();
        return ratings;
      } else {
        throw Exception('Failed to get rating list');
      }
    } catch (e) {
      throw Exception('Failed to get rating list: $e');
    }
  }

  static Future<void> updateParkingInformation(
    String description,
    List<String> images,
    String parkingName,
    int slot,
    Map<String, dynamic> waitingTime,
    Map<String, dynamic> cancelBookingTime,
  ) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/PLO/updateParkingInformation',
        data: {
          "description": description,
          "image": images,
          "parkingName": parkingName,
          "waitingTime": waitingTime,
          "slot": slot,
          "cancelBookingTime": cancelBookingTime,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Cập nhật thông tin bãi xe thành công');
      } else {
        throw Exception('Failed to update parking information');
      }
    } catch (e) {
      throw Exception('Failed to update parking information: $e');
    }
  }

  static Future<String?> uploadFile(File file) async {
    try {
      if (file == null) {
        print("No file selected!");
        return null;
      }

      String fullPath = file.path;
      List<String> pathElements = fullPath.split('/');
      String fileName = pathElements.last;

      String uploadUrl =
          "https://sg.storage.bunnycdn.com/fiftyfiftycdn/eparking/$fileName";

      dio.options.headers = {
        "AccessKey": "11073c71-c367-41b8-a5c4273b5027-0919-47bf",
        "Content-Type": "application/octet-stream",
      };

      Response response = await dio.put(
        uploadUrl,
        data: await file.readAsBytes(),
      );

      if (response.statusCode == 201) {
        String imageLink = "https://fiftyfifty.b-cdn.net/eparking/$fileName";
        return imageLink;
      } else {
        print('Upload failed with status ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<List<ListVehicleInParking>> fetchListVehicleInParking(
      int statusID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.get(
        '$baseUrl/parking/showListVehicleInParking',
        queryParameters: {'statusID': statusID},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<ListVehicleInParking> list = [];
        for (var item in response.data) {
          list.add(ListVehicleInParking.fromJson(item));
        }
        return list;
      } else {
        throw Exception('Failed to load list of vehicles in parking');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<ResponseSettingParking> getParkingSetting() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.get(
        '$baseUrl/parking/getParkingSetting',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        var responseSettingParking =
            ResponseSettingParking.fromJson(responseData);
        return responseSettingParking;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Request failed. Please check your connection.');
    }
  }

  static Future<void> updateParkingSetting(
      List<Map<String, dynamic>> data) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/parking/updateParkingSetting',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Update setting parking successfully");
      } else {
        throw Exception('Failed to update parking setting');
      }
    } catch (e) {
      throw Exception('Failed to update parking setting: $e');
    }
  }

  static Future<void> checkoutReservation(int reservationID) async {
  print(reservationID);
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.put(
        '$baseUrl/reservation/checkoutReservation',
        data: {"reservationID": reservationID},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Checkout successfully");
      } else {
        throw Exception('Failed to update parking setting');
      }
    } catch (e) {
      throw Exception('Failed to checkout reservation: $e');
    }
  }

  static Future<void> checkInReservation(int reservationID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.put(
        '$baseUrl/reservation/checkinReservation',
        data: {"reservationID": reservationID},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("CheckIn successfully");
      } else {
        throw Exception('Failed to update parking setting');
      }
    } catch (e) {
      throw Exception('Failed to checkout reservation: $e');
    }
  }

  static Future<ReservationDetail> getReservationDetail(
      int reservationID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.get(
        '$baseUrl/parking/getReservationDetail',
        queryParameters: {'reservationID': reservationID},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        ReservationDetail reservationDetail = ReservationDetail.fromJson(data);
        return reservationDetail;
      } else {
        throw Exception('Failed to get reservation detail');
      }
    } catch (e) {
      throw Exception('Failed to get reservation detail: $e');
    }
  }

  static Future<void> checkPLOTransfer(String phoneNumber) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/PLO/checkPLOTransfer',
        queryParameters: {
          'phoneNumber': phoneNumber,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Gửi otp để xác nhận số điện thoại');
      } else {
        throw Exception('Failed to check PLO transfer');
      }
    } catch (e) {
      throw Exception('Failed to check PLO transfer: $e');
    }
  }

  static Future<void> checkOTPcodeTransferParking(
      String otpCode, String phoneNumber) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/PLO/checkOTPcodeTransferParking',
        queryParameters: {
          'OTPcode': otpCode,
          'phoneNumber': phoneNumber,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Check OTP code transfer parking success');
      } else {
        throw Exception('Failed to check OTP code transfer parking');
      }
    } catch (e) {
      throw Exception('Failed to check OTP code transfer parking: $e');
    }
  }

  static Future<ParkingStatusInformation> getParkingStatusID() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/parking/getParkingStatusID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        ParkingStatusInformation parkingStatus =
            ParkingStatusInformation.fromJson(data);
        return parkingStatus;
      } else {
        throw Exception('Failed to get parking status ID');
      }
    } catch (e) {
      throw Exception('Failed to get parking status ID: $e');
    }
  }

  static Future<List<PLONotification>> getNotifications() async {
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
        List<PLONotification> notifications =
            data.map((item) => PLONotification.fromJson(item)).toList();
        return notifications;
      } else {
        throw Exception('Failed to get notifications');
      }
    } catch (e) {
      throw Exception('Failed to get notifications: $e');
    }
  }

  static Future<double> getBalance() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/PLO/getBalance',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return double.parse(response.data.toString());
      } else {
        throw Exception('Failed to get balance');
      }
    } catch (e) {
      throw Exception('Failed to get balance: $e');
    }
  }

  static Future<void> updateParkingStatusID(int parkingStatusID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/parking/updateParkingStatusID',
        queryParameters: {
          'parkingStatusID': parkingStatusID,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Parking status updated successfully');
      } else {
        throw Exception('Failed to update parking status');
      }
    } catch (e) {
      throw Exception('Failed to update parking status: $e');
    }
  }

  static Future<PaymentResponse> makePayment() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '$baseUrl/parking/paymentRegisterParking',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data['Payment']['body'];
        String paymentUrl = responseData['url'];
        String uuid = response.data['UUID'];
        return PaymentResponse(paymentUrl, uuid);
      } else {
        throw Exception('Failed to create payment');
      }
    } catch (e) {
      throw Exception('Failed to create payment: $e');
    }
  }

  static Future<void> registerParking(RequestRegisterParking request) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '$baseUrl/parking/registerParking',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        print("Đăng kí thông tin bãi xe thành công");
      } else {
        throw Exception('Failed to register parking');
      }
    } catch (e) {
      throw Exception('Failed to register parking: $e');
    }
  }

  static Future<void> checkinReservationWithLicensePlate(
      String licensePlate) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/reservation/checkinReservationWithLicensePlate',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: {"licensePlate": licensePlate},
      );
      if (response.statusCode == 200) {
        print("Check-in successful");
      } else {
        throw Exception('Failed to check-in reservation by license plate');
      }
    } catch (e) {
      throw Exception('Failed to check-in reservation by license plate: $e');
    }
  }

  static Future<void> checkoutReservationWithLicensePlate(
      String licensePlate) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.put(
        '$baseUrl/reservation/checkoutReservationWithLicensePlate',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: {"licensePlate": licensePlate},
      );
      if (response.statusCode == 200) {
        print("Check-out successful");
      } else {
        throw Exception('Failed to check-out reservation');
      }
    } catch (e) {
      throw Exception('Failed to check-out reservation: $e');
    }
  }

  static Future<double> getSumByDate(
      String startTime, String startTime2nd) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.get(
        '$baseUrl/PLO/getSumByDate',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        queryParameters: {
          'startTime': startTime,
          'startTime2nd': startTime2nd,
        },
      );

      if (response.statusCode == 200) {
        print('Response Data: ${response.data}');
        return double.parse(response.data.toString());
      } else {
        throw Exception('Failed to get sum by date');
      }
    } catch (e) {
      throw Exception('Failed to get sum by date: $e');
    }
  }

  static Future<void> requestWithdrawal(
      double amount, String method1, String method2) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '$baseUrl/PLO/requestWithdrawal',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "amount": amount,
          "method1": method1,
          "method2": method2,
        },
      );
      if (response.statusCode == 200) {
        print("Withdrawal request successful");
      } else {
        throw Exception('Failed to request withdrawal');
      }
    } catch (e) {
      throw Exception('Failed to request withdrawal: $e');
    }
  }

  static Future<ParkingLotDetail> getParkingLotDetail(String ploID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response =
          await dio.get('$baseUrl/customer/detailPloForCustomer?ploID=$ploID',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
              ));
      if (response.statusCode == 200) {
        print("getParkingLotDetail successful");
        final data = response.data['data'];
        ParkingLotDetail parkingLotDetail = ParkingLotDetail.fromJson(data);
        return parkingLotDetail;
      } else {
        throw Exception('Failed to rgetParkingLotDetail');
      }
    } catch (e) {
      throw Exception('Failed to getParkingLotDetail: $e');
    }
  }

  static Future<List<CustomerRating>> getRatingParkingLot(String ploID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response =
          await dio.get('$baseUrl/rating/getRatingOfCustomer?ploID=$ploID',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
              ));

      if (response.statusCode == 200) {
        print("get RatingList successful");
        final List<dynamic> data = response.data['data'];
        List<CustomerRating> ratingList;
        ratingList = data.map((item) => CustomerRating.fromJson(item)).toList();

        return ratingList;
      } else {
        throw Exception('Failed to get RatingList');
      }
    } catch (e) {
      throw Exception('Failed to get RatingList: $e');
    }
  }

  static Future<ReservationByLicensePlate> getReservationByLicensePlate(String licensePlate) async {

    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response =
      await dio.get('$baseUrl/reservation/getInforReservationByLicensePlate?licensePlate=$licensePlate',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ));

      if (response.statusCode == 200) {
        ReservationByLicensePlate reservationByLicensePlate = ReservationByLicensePlate(customerName: '', licensePlate: '', methodName: '', status: 0, statusName: '', checkIn: '', checkOut: '');
        final status = response.data['status'];

        if(status == 200){
          print("get reservation by LicensePlate  successful");
          final data = response.data['data'];
          reservationByLicensePlate  = ReservationByLicensePlate.fromJson(data);
        }
        print(reservationByLicensePlate);
        return reservationByLicensePlate;
      } else {
        throw Exception('Failed to get RatingList');
      }
    } catch (e) {
      throw Exception('Failed to get RatingList: $e');
    }
  }

}
