import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/ui/Home.dart';
import 'package:wanandroid_flutter/utils/RouteUtils.dart';
import 'package:wanandroid_flutter/utils/Snack.dart';
import 'package:wanandroid_flutter/viewmodel/LoginRegistViewModel.dart';

class LoginRegistPage extends StatefulWidget {
  const LoginRegistPage({super.key});

  @override
  State<LoginRegistPage> createState() => _LoginRegistPageState();
}

class _LoginRegistPageState
    extends BasePageState<LoginRegistViewModel, LoginRegistPage>
    with TickerProviderStateMixin {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _unpasswordController = TextEditingController();
  final TextEditingController _unpasswordAgainController =
      TextEditingController();
  final ValueNotifier _loginText = ValueNotifier<String>("登录");
  final ValueNotifier _isVisibily = ValueNotifier<bool>(false);
  bool _isLoginAction = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录/注册"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _unameController,
              decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入用户名",
                  prefixIcon: Icon(Icons.person)),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: _unpasswordController,
                  decoration: const InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.password_rounded)),
                  obscureText: true,
                )),
            ValueListenableBuilder(
                valueListenable: _isVisibily,
                builder: (context, value, child) {
                  return AnimatedOpacity(
                    opacity: value ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _unpasswordAgainController,
                          decoration: const InputDecoration(
                              labelText: "请再次输入密码",
                              hintText: "密码",
                              prefixIcon: Icon(Icons.password_rounded)),
                          obscureText: true,
                        )),
                  );
                }),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: () {
                      _loginOrRegist(context);
                    },
                    child: ValueListenableBuilder(
                        valueListenable: _loginText,
                        builder: (context, value, child) {
                          return Container(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 50, top: 10, bottom: 10),
                              child: Text(
                                _loginText.value,
                                style: const TextStyle(fontSize: 20),
                              ));
                        })))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _isLoginAction = !_isLoginAction;
          _isVisibily.value = !_isVisibily.value;
          _loginText.value = _isLoginAction ? "登录" : "注册";
        },
        child: const Icon(Icons.change_circle),
      ),
    );
  }
  void _loginOrRegist(BuildContext context){
    if (_isLoginAction) {
      mViewModel.login(
          _unameController.text, _unpasswordController.text,
              (loginOk, errorMsg) {
            if (loginOk) {
              SnackUtils.show(context, "登录成功");
              RouteUtils.routePage(context, const HomePage(),finishMine: true);
            } else {
              SnackUtils.show(context, errorMsg);
            }
          });
    } else {
      mViewModel.regist(
          _unameController.text,
          _unpasswordController.text,
          _unpasswordAgainController.text,
              (registOk, errorMsg) {
            if (registOk) {
              SnackUtils.show(context, "注册成功");
              RouteUtils.routePage(context, const HomePage(),finishMine: true);
            } else {
              SnackUtils.show(context, errorMsg);
            }
          });
    }
  }

  @override
  LoginRegistViewModel getViewModel() => LoginRegistViewModel();
}
