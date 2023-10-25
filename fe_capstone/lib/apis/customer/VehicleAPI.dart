import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/ListVehicleCustomer.dart';

class VehicleAPI{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<List<ListVehicleCustomer>> getVehicleList() async {
      try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/licensePlate/getLicensePlate',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        List<ListVehicleCustomer> listVehicleList = data.map((item) => ListVehicleCustomer.fromJson(item)).toList();
        return listVehicleList;
      } else {
        throw Exception('Failed to get vehicle list');
      }
    } catch (e) {
      throw Exception('Failed to get vehicle list: $e');
    }
  }

  static Future<void> addNewLicencePlate(String licencePlate) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.post(
        '$baseUrl/licensePlate/addLicensePlate?licensePlate=$licencePlate',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Thêm xe thành công!");
      }
    } catch (e) {
      throw Exception('Failed to add New Licence Plate: $e');
    }
  }

  static Future<void> deleteNewLicencePlate(int licencePlateID) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.delete(
        '$baseUrl/licensePlate/deleteLicensePlate?licensePlateID=$licencePlateID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Xóa xe thành công!");
      } else {
        throw Exception('Failed to get delete vehicle');
      }
    } catch (e) {
      throw Exception('Failed to get delete vehicle: $e');
    }
  }


}