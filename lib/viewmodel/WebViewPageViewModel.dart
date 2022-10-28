import 'package:wanandroid_flutter/cache/Contast.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';

import '../base/BaseViewModel.dart';

class WebViewPageViewModel extends BaseViewModel {
  void collect(String id, Function(bool collected) callback) {
    HttpUtils.doGet("${Contast.COLLECT}$id/json", (response) {
      callback(true);
    }, failed: (fail) {
      callback(false);
    });
  }
}
