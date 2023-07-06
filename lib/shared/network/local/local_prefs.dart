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
}
