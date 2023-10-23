import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyAccessToken = 'access_token';

  static final _storage = FlutterSecureStorage();

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setAccessToken(String value) async {
    await _storage.write(key: _keyAccessToken, value: value);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  static Future logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

}
