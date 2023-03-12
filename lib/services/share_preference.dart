import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String userLoggedInKey = "LOGGED_IN_KEY";
  static String userLogType = "LOG_TYPE";
  static String userNameKey = "USERNAME";
  static String userEmailKey = "USER_EMAIL";

  static Future<bool?> getLoggedInStatus() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.getBool(userLoggedInKey);
  }

  static Future<String?> getLogType() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.getString(userLogType);
  }

  static Future<bool> setLogType(String type) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.setString(userLogType, type);
  }

  static Future<bool> setLoggedInStatus(bool status) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.setBool(userLoggedInKey, status);
  }

  static Future<bool> setLoggedInEmail(String email) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.setString(userLoggedInKey, email);
  }

  // static Future<bool> setLoggedInPassword(String password) async {
  //   SharedPreferences data = await SharedPreferences.getInstance();
  //   return data.setString(userLoggedInKey, password);
  // }
}
