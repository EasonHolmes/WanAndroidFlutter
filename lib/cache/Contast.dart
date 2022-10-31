import 'package:shared_preferences/shared_preferences.dart';

class Contast {
  static const String USER_NAME = "USER_NAME";
  static const String PASSWORD = "PASSWORD";
  static String appName = "";
  static String version = "";
  static String packageName = "";
  static String buildNumber = "";

  static String cookie = "";
  static String COOKIE_KEY = "Cookie";
  static String EXPIRES_KEY = "expires";

  static const String BASE_URL = "https://www.wanandroid.com";
  static const String LOGIN = "/user/login";
  static const String REGISTER = "/user/register";
  static const String BANNER_JSON = "/banner/json";
  static const String HOME_LIST = "/article/list/";
  static const String COLLECT = "/lg/collect/";

  static isLogin(Function(bool login) logined) async {
    final SharedPreferences prefes = await SharedPreferences.getInstance();
    var name = prefes.getString(Contast.USER_NAME);
    logined(name != null && name.isNotEmpty);
  }
}
