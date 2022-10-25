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
  static void log(String content,{String tag = "ethan"}) {
    if (kDebugMode) {
      print("$tag====$content");
    }
  }
}

class HttpUtils {
  static _getHttpOptions() {
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
    await Dio(_getHttpOptions())
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
      {Map<String, Object>? queryParameters,
      Function(String fail)? failed}) async {
    LogUtils.log("requestUrl==$action data==$queryParameters");
    await Dio(_getHttpOptions())
        .get(action, queryParameters: queryParameters)
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
      success(value.data);
    }).catchError((e) {
      LogUtils.log("error==$e");
      if (failed != null) {
        failed(e.toString());
      }
    });
  }

  static Future<Response> doFutureGet(String action,
      {Map<String, Object>? queryParameters}) async {
    LogUtils.log("requestUrl==$action data==$queryParameters");
    return await Dio(_getHttpOptions())
        .get(action, queryParameters: queryParameters)
        .then((value) {
      LogUtils.log("responseData==${value.data}");
      var map = (value.data as Map<String, dynamic>);
      var errorCode = map["errorCode"];
      var errorMsg = map["errorMsg"];
      if (errorCode != 0) {
        throw errorMsg;
      }
      return value;
    }).catchError((e) {
      LogUtils.log("error==$e");
    });
  }

  static Future<Response> doFuturePost(
      String action, Map<String, dynamic> map) async {
    LogUtils.log("requestUrl==$action data==$map");
    return await Dio(_getHttpOptions())
        .post(action, data: FormData.fromMap(map))
        .then((value) {
      LogUtils.log("responseData==${value.data}");
      var map = (value.data as Map<String, dynamic>);
      var errorCode = map["errorCode"];
      var errorMsg = map["errorMsg"];
      if (errorCode != 0) {
        throw errorMsg;
      }
      return value;
    }).catchError((e) {
      LogUtils.log("error==$e");
    });
  }
}
