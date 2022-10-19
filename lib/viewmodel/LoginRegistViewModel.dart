import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/base/BaseViewModel.dart';
import 'package:wanandroid_flutter/cache/Contast.dart';
import 'package:wanandroid_flutter/response/RegistResponse.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';

class LoginRegistViewModel extends BaseViewModel {
  void login(String userName, String password,
      Function(bool loginOk, String errorMsg) callback) {
    if (userName.isEmpty || password.isEmpty) {
      callback(false, "请输入用户名或密码");
      return;
    }
    HttpUtils.doPost(
        Contast.LOGIN, {"username": userName, "password": password},
        (response) {
      var registResponse = RegistLoginResponse.fromJson(response);
      saveUser(registResponse.data.publicName);
      callback(true, "");
    }, failed: (fail) {
      callback(false, fail);
    });
  }

  void saveUser(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(Contast.USER_NAME, userName);
  }

  void regist(String userName, String password, String repassword,
      Function(bool registOk, String errorMsg) callback) {
    if (userName.isEmpty || password.isEmpty || repassword.isEmpty) {
      callback(false, "请输入用户名或密码");
      return;
    } else if (password != repassword) {
      callback(false, "两次密码输入不一致");
      return;
    }

    HttpUtils.doPost(Contast.REGISTER, {
      "username": userName,
      "password": password,
      "repassword": repassword
    }, (response) {
      saveUser(RegistLoginResponse.fromJson(response).data.publicName);
      callback(true, "");
    }, failed: (fail) {
      callback(false, fail);
    });
  }
}
