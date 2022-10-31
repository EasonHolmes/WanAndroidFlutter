import 'package:flutter/cupertino.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';

class RouteUtils {
  static void routePage(BuildContext context, StatefulWidget widget,
      {bool finishMine = false, Function(dynamic res)? res}) async {
    //导航到新路由
    // var result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {//MaterialPageRoute自适应ios和android打开
    //     return const Page2(text: "我是过来的内容TabPageB");
    //   }),
    // );
    if (finishMine) {
      Navigator.of(context).pop();
    }
    var result = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        //统一用ios动画新页面
        return widget;
      }),
    );
    if (res != null) {
      LogUtils.log("result=="+result);
      res(result);
    }
  }
}
