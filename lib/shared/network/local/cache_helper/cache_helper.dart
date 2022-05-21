import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString({
    required String key,
    required String value,
  }) async {
    return await _sharedPreferences!.setString(key, value);
  }

  static String? getString({required String key}) {
    return _sharedPreferences!.getString(key);
  }
}
