import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wanandroid_flutter/cache/Contast.dart';
import 'package:wanandroid_flutter/ui/TabPageMain.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';

import '../base/BasePageWidget.dart';
import '../viewmodel/HomePageViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePageViewModel, HomePage>
    with SingleTickerProviderStateMixin {
  /// PageView 控制器 , 用于控制 PageView
  final _pageController = PageController(
    /// 初始索引值
    initialPage: 0,
    keepPage: true,
  );

  /// 当前的索引值
  int _currentIndex = 0;

  @override
  HomePageViewModel getViewModel() => HomePageViewModel();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      Contast.appName = info.appName;
      Contast.version = info.version;
      Contast.packageName = info.packageName;
      Contast.buildNumber = info.buildNumber;
      LogUtils.log(info.appName, tag: "app_name");
      LogUtils.log(info.version, tag: "version");
      LogUtils.log(info.packageName, tag: "packageName");
      LogUtils.log(info.buildNumber, tag: "buildNumber");
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget builded(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_packageInfo.appName),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar(const SnackBar(content: Text("content")));
      //   },
      // ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        //NeverScrollableScrollPhysics 禁止滑动 ，BouncingScrollPhysics ios滑动风格，ClampingScrollPhysics android滑动风格
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          // setState(() {
          //   // 更新当前的索引值
          //   _currentIndex = index;
          // });
        },
        children: const [
          TabPageMain(),
          TabPageMain(),
          TabPageMain(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },

        /// 设置底部的若干点击导航栏点击按钮
        /// 注意该 List<BottomNavigationBarItem> items
        /// 中的按钮顺序 , 要与 PageView 中的页面顺序必须保持一致
        /// 个数个顺序都要保持一致
        items: datas.map((data) {
          return BottomNavigationBarItem(

              /// 默认状态下的图标, 灰色
              icon: Icon(
                data.icon,
                color: Colors.grey,
              ),

              /// 选中状态下的图标, 红色
              activeIcon: Icon(
                data.icon,
                // color: Colors.blue,
                color: Theme.of(context).primaryColor,
              ),

              /// 根据当前页面是否选中 , 确定
              label: data.title,
              tooltip: ""
              //   data.title,
              //   style: TextStyle(
              //     /// 如果是选中状态 , 则设置红色
              //     /// 如果是非选中状态, 则设置灰色
              //       color: _currentIndex == data.index ? Colors.red : Colors.grey),
              // ),

              );
        }).toList(),
      ),
    );
  }
}

/// 封装导航栏的图标与文本数据
class TabData {
  /// 导航数据构造函数
  const TabData({required this.index, required this.title, required this.icon});

  /// 导航标题
  final String title;

  /// 导航图标
  final IconData icon;

  /// 索引
  final int index;
}

/// 导航栏数据集合
const List<TabData> datas = <TabData>[
  TabData(index: 0, title: '首页', icon: Icons.home_outlined),
  TabData(index: 1, title: '项目', icon: Icons.camera),
  TabData(index: 2, title: '我的', icon: Icons.account_box),
  // TabData(index: 3, title: '设置', icon: Icons.settings),
];
