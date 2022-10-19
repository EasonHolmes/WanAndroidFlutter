import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wanandroid_flutter/cache/Contast.dart';

// class DioSingleton {
//   late Dio dio;
//   DioSingleton._internal(){
//     dio = Dio();
//   }
//   factory DioSingleton() => _instance;
//   static late final DioSingleton _instance = DioSingleton._internal();
// }

class LogUtils {
  static void log(String content) {
    if (kDebugMode) {
      print(content);
    }
  }
}

class HttpUtils {
  static getHttpOptions() {
    var ops = BaseOptions();
    ops.baseUrl = Contast.BASE_URL;
    // ops.contentType = 'application/json; charset=utf-8';
    // ops.method = 'POST';
    return ops;
  }

  static void doPost(String action, Map<String, dynamic> map,
      Function(Map<String, dynamic> response) success,
      {Function(String fail)? failed}) async {
    LogUtils.log("requestUrl==$action data==$map");
    await Dio(getHttpOptions())
        .post(action, data: FormData.fromMap(map))
        .then((value) {
      LogUtils.log("responseData==${value.data}");
      var map = (value.data as Map<String, dynamic>);
      var errorCode = map["errorCode"];
      var errorMsg = map["errorMsg"];
      if (errorCode != 0 && failed != null) {
        failed(errorMsg);
      } else {
        success(value.data);
      }
    }).catchError((e) {
      LogUtils.log("error==$e");
      if (failed != null) {
        failed(e.toString());
      }
    });
  }

  static void doGet(
      String action, Function(Map<String, dynamic> response) success,
      //[]中括号为可选参
      {Map<String, Object>? queryParameters,
      Function(String fail)? failed}) async {
    LogUtils.log("requestUrl==$action data==$queryParameters");
    await Dio(getHttpOptions())
        .get(action, queryParameters: queryParameters)
        .then((value) {
      LogUtils.log("responseData==${value.data}");
      success(value.data);
    }).catchError((e) {
      LogUtils.log("error==$e");
      if (failed != null) {
        failed(e.toString());
      }
    });
  }
}
