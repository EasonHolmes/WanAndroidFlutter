import 'package:wanandroid_flutter/base/BaseViewModel.dart';
import 'package:wanandroid_flutter/cache/Contast.dart';
import 'package:wanandroid_flutter/response/RegistResponse.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';

class LoginRegistViewModel extends BaseViewModel {
  void login(String userName, String password) {
     HttpUtils.doPost(Contast.LOGIN, {"username": userName, "password": password},(response){
          print("object+++${RegistResponse.fromJson(response)}");
     });
  }

  void regist(String userName, String password, repassword) {
    // var data = HttpUtils.doPost(Contast.LOGIN,
    //     {"username": userName, "password": password, "repassword": repassword});
  }
}
