import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences sharedPrefrences;

  static init() async {
    sharedPrefrences = await SharedPreferences.getInstance();
  }

  static Future<bool> setTheme({key, value}) async {
    return await sharedPrefrences.setBool(key, value);
  }

  static bool getTheme({key}) {
    return sharedPrefrences.getBool(key) ?? false;
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    print(sharedPrefrences.containsKey('onBoarding'));
    if (value is String) return await sharedPrefrences.setString(key, value);
    if (value is int) return await sharedPrefrences.setInt(key, value);
    if (value is bool) return await sharedPrefrences.setBool(key, value);
    return await sharedPrefrences.setDouble(key, value);
  }

  static dynamic getSharedData({key}) {
    return sharedPrefrences.get(key);
  }
}
