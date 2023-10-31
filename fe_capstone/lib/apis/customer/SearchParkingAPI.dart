import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/Parking.dart';

class SearchParkingAPI{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<List<Parking>> findParkingList(double latitude, double longitude, int method, double radius) async {
    print(latitude);
    print(longitude);
    print(method);
    print(radius);

    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '$baseUrl/customer/findParkingList',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'method': method,
          'radius': radius,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Parking> parkingList = data.map((item) => Parking.fromJson(item)).toList();
        return parkingList;
      } else {
        throw Exception('Failed to get Parking List');
      }
    } catch (e) {
      throw Exception('Failed to get Parking List: $e');
    }
  }


}

