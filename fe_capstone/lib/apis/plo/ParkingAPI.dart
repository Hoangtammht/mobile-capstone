import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fe_capstone/models/ListVehicleInParking.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:fe_capstone/models/RatingModel.dart';

class ParkingAPI {
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparking.azurewebsites.net';

  static Future<ParkingInformationModel> getParkingInformation(
      String token) async {
    try {
      final response = await dio.get(
        '$baseUrl/PLO/getParkingInformation',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
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

  static Future<List<RatingModel>> getRatingList(String token) async {
    try {
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
    String token,
    String description,
    List<String> images,
    String parkingName,
  ) async {
    try {
      final response = await dio.put(
        '$baseUrl/PLO/updateParkingInformation',
        data: {
          "description": description,
          "image": images,
          "parkingName": parkingName,
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
      String token, int parkingStatusID) async {
    try {
      var response = await dio.get(
        '$baseUrl/parking/showListVehicleInParking',
        queryParameters: {'parkingStatusID': parkingStatusID},
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
}
