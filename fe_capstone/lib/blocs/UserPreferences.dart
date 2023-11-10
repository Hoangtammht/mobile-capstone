import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyAccessToken = 'access_token';

  static const _keyUserData = 'PLO';

  static final _storage = FlutterSecureStorage();

  static const _keyLoggedIn = 'loggedIn';
  static const _keyUsername = 'username';
  static const _keyPassword = 'password';
  static const _keyUserID = 'userID';
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool isLoggedIn() => _preferences?.getBool(_keyLoggedIn) ?? false;

  static Future setLoggedIn(bool value) async {
    await _preferences?.setBool(_keyLoggedIn, value);
  }

  static Future setUsername(String value) async {
    await _storage.write(key: _keyUsername, value: value);
  }

  static Future<String?> getUsername() async {
    return await _storage.read(key: _keyUsername);
  }

  static Future setPassword(String value) async {
    await _storage.write(key: _keyPassword, value: value);
  }

  static Future<String?> getPassword() async {
    return await _storage.read(key: _keyPassword);
  }

  static Future<void> setAccessToken(String value) async {
    await _storage.write(key: _keyAccessToken, value: value);
  }

  static Future<void> setFullName(String value) async {
    await _storage.write(key: _keyUserData, value: value);
  }

  static Future<String?> getFullName() async {
    return await _storage.read(key: _keyUserData);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  static Future<void> setUserID(String value) async {
    await _storage.write(key: _keyUserID, value: value);
  }

  static Future<String?> getUserID() async {
    return await _storage.read(key: _keyUserID);
  }
  static Future logout() async {
    await _storage.deleteAll();
    await setLoggedIn(false);
  }

}
