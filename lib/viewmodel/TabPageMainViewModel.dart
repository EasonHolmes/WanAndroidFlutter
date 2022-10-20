import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:wanandroid_flutter/base/BaseViewModel.dart';
import 'package:wanandroid_flutter/cache/Contast.dart';
import 'package:wanandroid_flutter/response/BannerResponse.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';

class TabPageMainViewModel extends BaseViewModel {
  final MutableLiveData banner_liveData = MutableLiveData();

  void getBannerData() {
    HttpUtils.doGet(
        Contast.BANNER_JSON,
        (response) => {
              banner_liveData.value = BannerResponse.fromJson(response)
            }, failed: (fail) {
      errorMsg_liveData.value = fail;
    });
  }
}