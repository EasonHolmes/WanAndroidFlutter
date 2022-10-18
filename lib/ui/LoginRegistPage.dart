import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/ui/Home.dart';
import 'package:wanandroid_flutter/utils/RouteUtils.dart';
import '../viewmodel/LoginRegistViewModel.dart';

class LoginRegistPage extends StatefulWidget {
  const LoginRegistPage({super.key});

  @override
  State<LoginRegistPage> createState() => _LoginRegistPageState();
}

class _LoginRegistPageState
    extends BasePageState<LoginRegistViewModel, LoginRegistPage> {
//定义一个controller
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _unpasswordController = TextEditingController();
  final ValueNotifier _loginText = ValueNotifier<String>("登录");
  bool _isLogin = true;

  @override
  void initState() {
    super.initState();

  }

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
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: () {
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
          _isLogin = !_isLogin;
          _loginText.value = _isLogin ? "登录" : "注册";
        },
        child: const Icon(Icons.change_circle),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  LoginRegistViewModel getViewModel() => LoginRegistViewModel();
}
