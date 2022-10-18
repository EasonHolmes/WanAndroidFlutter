import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/BasePageWidget.dart';
import '../viewmodel/HomePageViewModel.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  State<StatefulWidget> createState() => _HomePageState();

}
class _HomePageState extends BasePageState<HomePageViewModel,HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }

  @override
  HomePageViewModel getViewModel() => HomePageViewModel();

}
