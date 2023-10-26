import 'package:dio/dio.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/ResponseWalletCustomer.dart';



class WalletScreenAPI{
  static Dio dio = Dio();
  static const String baseUrl = 'https://eparkingcapstone.azurewebsites.net';

  static Future<ResponseWalletCustomer> getWalletScreenData() async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.get(
        '$baseUrl/customer/walletScreen',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = Map<String, dynamic>.from(response.data);
        ResponseWalletCustomer walletCustomer = ResponseWalletCustomer.fromJson(responseData);
        return walletCustomer;
      } else {
        throw Exception('Failed to load wallet screen data');
      }
    } catch (e) {
      throw Exception('Failed to load wallet screen data: $e');
    }
  }

  static Future<String> createPayment(double amount) async {
    try {
      String? token = await UserPreferences.getAccessToken();
      if (token == null) {
        throw Exception('Access token is null');
      }
      var response = await dio.post(
        '$baseUrl/customer/createPayment',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'amount': amount,
        },
      );

      if (response.statusCode == 200) {
        return response.data['url'];
      } else {
        throw Exception('Failed to create payment');
      }
    } catch (e) {
      throw Exception('Failed to create payment: $e');
    }
  }

}