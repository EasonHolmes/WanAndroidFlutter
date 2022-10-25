import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/base/BaseViewModel.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends BasePage {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, required this.title});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends BasePageState<BaseViewModel, WebViewPage> {
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
    var webprogress = ValueNotifier<int>(0);

    LogUtils.log(widget.url, tag: widget.url);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
              child: ValueListenableBuilder(
                  valueListenable: webprogress,
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
              webprogress.value = progress;
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  BaseViewModel getViewModel() {
    return BaseViewModel();
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
