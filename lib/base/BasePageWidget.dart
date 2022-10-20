
import 'package:flutter/cupertino.dart';
import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:wanandroid_flutter/base/BaseViewModel.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';
import 'package:wanandroid_flutter/utils/Snack.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<T extends BaseViewModel, V extends StatefulWidget>
    extends State<V> with StateObserver{
  late T mViewModel;

  @override
  void initState() {
    mViewModel = getViewModel();
    super.initState();
  }

  @protected
  T getViewModel();

  @protected
  Widget builded(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return builded(context);
  }


  @override
  void registerObservers() {
    observe<String>(mViewModel.errorMsg_liveData, _handleChange);
  }
  void _handleChange(String errMsg){
    SnackUtils.show(context, errMsg);
  }


}
