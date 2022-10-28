import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/base/BaseViewModel.dart';
import 'package:wanandroid_flutter/cache/Contast.dart';
import 'package:wanandroid_flutter/utils/DateUtil.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';

class SplashPageViewModel extends BaseViewModel {
  isLogin(Function(bool login) logined) async {
    final SharedPreferences prefes = await SharedPreferences.getInstance();
    var name = prefes.getString(Contast.USER_NAME);
    logined(name != null && name.isNotEmpty);
  }

  void refreshUserData(Function() callback) async {
    var sp = await SharedPreferences.getInstance();
    var str = sp.getString(Contast.EXPIRES_KEY);
    if (null != str && str.isNotEmpty) {
      var cookieExpiresTime = DateTime.parse(str);
      //提前3天请求新的cookie
      if (cookieExpiresTime.isAfter(DateUtil.getDaysAgo(3))) {
        HttpUtils.doPost(
            Contast.LOGIN, {
          "username": sp.getString(Contast.USER_NAME),
          "password": sp.getString(Contast.PASSWORD)
        },
                (response) {
              callback();
                },failed: (e){

        });
      }
    }
  }
}
