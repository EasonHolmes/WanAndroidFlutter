import 'package:flutterx_live_data/flutterx_live_data.dart';

class BaseViewModel{
  final MutableLiveData<String> errorMsg_liveData = MutableLiveData(initialValue: "");

}