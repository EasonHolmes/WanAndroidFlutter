import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/base/BaseViewModel.dart';
import 'package:wanandroid_flutter/cache/Contast.dart';

class SplashPageViewModel extends BaseViewModel{

  isLogin(Function(bool login) logined) async {
    final SharedPreferences prefes = await SharedPreferences.getInstance();
    var name = prefes.getString(Contast.USER_NAME);
    logined(name != null && name.isNotEmpty);
  }
}