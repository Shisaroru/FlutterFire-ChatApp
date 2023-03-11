import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String userLoggedInKey = "LOGGED_IN_KEY";
  static String userNameKey = "USERNAME";
  static String userEmailKey = "USER_EMAIL";

  static Future getUserLoggedInData() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.getBool(userLoggedInKey);
  }
}
