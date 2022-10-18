import 'package:flutter/cupertino.dart';
import 'package:wanandroid_flutter/base/BaseViewModel.dart';


abstract class BasePage extends StatefulWidget{
  const BasePage({super.key});

}

abstract class BasePageState<T extends BaseViewModel, V extends StatefulWidget>
    extends State<V> {
  late T mViewModel;

  @override
  void initState() {
    mViewModel = getViewModel();
    super.initState();
  }

  @protected
  T getViewModel();
}
