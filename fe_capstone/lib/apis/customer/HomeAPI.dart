import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/url_constants.dart';
import 'package:fe_capstone/models/CustomerHome.dart';

class HomeAPI{
  static Dio dio = Dio();

  static Future<CustomerHome> getHomeStatus() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      final response = await dio.get(
        '${UrlConstant.CUSTOMER}/getScreen',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final status = response.data['status'];
        if(status == 1 || status == 0){
          return CustomerHome(reservationID: 0, ploID: '', statusID: 0, statusName:  '', parkingName: '', address: '', longitude: 0, latitude: 0, price: 0, methodName: '', licensePlate: '');
        }
          final Map<String, dynamic> data = response.data['data'];
          CustomerHome historyDetail = CustomerHome.fromJson(data);
        if (status == 5) {
          final int reservationID = historyDetail.reservationID;
          final String ploID = historyDetail.ploID;
          final String parkingName = historyDetail.parkingName;
          return CustomerHome(reservationID: reservationID, ploID: ploID, statusID: 5, statusName: '', parkingName: parkingName, address: '', longitude: 0, latitude: 0, price: 0, methodName: '', licensePlate: '');
        }
        return historyDetail;
      } else {
        throw Exception('Failed to get home status');
      }
    } catch (e) {
      throw Exception('Failed to get home status: $e');
    }
  }


}