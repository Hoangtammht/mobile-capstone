import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/url_constants.dart';
import 'package:fe_capstone/models/ListVehicleCustomer.dart';

class VehicleAPI{
  static Dio dio = Dio();


  static Future<List<ListVehicleCustomer>> getVehicleList() async {
      try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '${UrlConstant.LICENSE_PLATE}/getLicensePlate',
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
        '${UrlConstant.LICENSE_PLATE}/addLicensePlate?licensePlate=$licencePlate',
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
        '${UrlConstant.LICENSE_PLATE}/deleteLicensePlate?licensePlateID=$licencePlateID',
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