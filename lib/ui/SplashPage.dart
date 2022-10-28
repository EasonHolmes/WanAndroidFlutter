import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/ui/Home.dart';
import 'package:wanandroid_flutter/ui/LoginRegistPage.dart';
import 'package:wanandroid_flutter/utils/RouteUtils.dart';
import 'package:wanandroid_flutter/viewmodel/SplashPageViewModel.dart';

class SplashPage extends BasePage {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends BasePageState<SplashPageViewModel, SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  SplashPageViewModel getViewModel() {
    return SplashPageViewModel();
  }

  @override
  Widget builded(BuildContext context) {
    mViewModel.isLogin((login) =>
    {
      if (login)
        mViewModel.refreshUserData(() {
          RouteUtils.routePage(context, const HomePage(), finishMine: true);
        })
      else
        {
          RouteUtils.routePage(context, const LoginRegistPage(),
              finishMine: true)
        }
    });
    return Scaffold();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
