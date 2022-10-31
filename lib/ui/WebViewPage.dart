import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/assets_common/Assets.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';
import 'package:wanandroid_flutter/utils/Snack.dart';
import 'package:wanandroid_flutter/viewmodel/WebViewPageViewModel.dart';
import 'package:wanandroid_flutter/widget/CustomWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends BasePage {
  final String url;
  final String title;
  final String id;
  final bool isCollect;

  const WebViewPage(
      {super.key,
      required this.url,
      required this.title,
      required this.id,
      this.isCollect = false});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState
    extends BasePageState<WebViewPageViewModel, WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  // Add from here ...
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget builded(BuildContext context) {
    var webProgress = ValueNotifier<int>(0);
    bool collect = false;
    LogUtils.log(widget.url, tag: widget.url);
    return WillPopScope(child:Scaffold(
      appBar: AppBar(
          title: Row(children: [
        Expanded(
          child:
              Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        // Container(
        //   margin: const EdgeInsets.only(left: 15, right: 15),
        //   child: CustomInkWell(
        //     radius: 360,
        //     onPressed: () {
        //       mViewModel.collect(widget.id, (success) {
        //         if (success) {
        //           collect =true;
        //           SnackUtils.show(context, "收藏成功");
        //         }
        //       });
        //     },
        //     child: Image.asset(
        //       "${ImagePaths.root}/collect_icon.png",
        //       width: 30,
        //       height: 30,
        //       color: widget.isCollect ? Colors.redAccent : Colors.grey,
        //     ),
        //   ),
        // )
      ])),
      body: Stack(
        children: [
          Center(
              child: ValueListenableBuilder(
                  valueListenable: webProgress,
                  builder: (context, values, child) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$values%",
                            style: const TextStyle(fontSize: 40),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 50, right: 50),
                            child: LinearProgressIndicator(
                              value: values / 100,
                              color: Theme.of(context).primaryColor,
                              backgroundColor: Colors.grey,
                            ),
                          )
                        ]);
                  })),
          WebView(
            initialUrl: widget.url,
            // javascriptMode: JavascriptMode.unrestricted,//是否开启javascript
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              LogUtils.log('WebView is loading (progress : $progress%)');
              webProgress.value = progress;
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              //导航拦截
              if (request.url.startsWith('https://www.youtube.com/')) {
                LogUtils.log('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              LogUtils.log('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              LogUtils.log('Page started loading: $url');
            },
            onPageFinished: (String url) {
              LogUtils.log('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
        ],
      ),
    ), onWillPop: ()async{
      Navigator.pop(context,collect);
      return true;
    });;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  WebViewPageViewModel getViewModel() {
    return WebViewPageViewModel();
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
