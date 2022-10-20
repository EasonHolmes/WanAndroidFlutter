import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/response/BannerResponse.dart';
import 'package:wanandroid_flutter/response/HomeListResponse.dart';
import 'package:wanandroid_flutter/viewmodel/TabPageMainViewModel.dart';
import 'package:wanandroid_flutter/widget/RefreshWidget.dart';

class TabPageMain extends BasePage {
  const TabPageMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageMain();
  }
}

class _TabPageMain extends BasePageState<TabPageMainViewModel, TabPageMain> {
  final List<HomeListData> _listData = [];
  var pageSize = 0;
  final ScrollController _scrollController = ScrollController(); //listview的控制器
  @override
  void initState() {
    super.initState();
    mViewModel.getBannerData();
    _getListData(false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getListData(true);
      }
    });
  }

  Future _getListData(bool loadMore) {
    return mViewModel.getListData(pageSize).then((value) {
      if (value.datas != null) {
        if (!loadMore) {
          pageSize = 0;
          _listData.clear();
        } else {
          pageSize = value.curPage!;
        }
        _listData.addAll(value.datas!);
        setState(() {});
      }
    });
  }

  @override
  TabPageMainViewModel getViewModel() {
    return TabPageMainViewModel();
  }

  @override
  Widget builded(BuildContext context) {
    return RefreshWidget(
        onRefresh: () {
          // var page = _listData
          return _getListData(false);
        },
        child: ListView.builder(
          controller: _scrollController,
            itemCount: _listData.length+1,
            itemBuilder: (BuildContext context, int index) {
              return _renderRow(context,index) ;
            }));
    return Column(children: <Widget>[
      Column(
        children: [
          LiveDataBuilder(
              data: mViewModel.banner_liveData,
              builder: (context, value) {
                return SizedBox(
                    height: 200,
                    child: Swiper(
                      itemCount: value.data.length,
                      pagination: const SwiperPagination(),
                      control: const SwiperControl(),
                      itemBuilder: (context, index) {
                        return ItemBanner(value: value.data[index]);
                      },
                    ));
              })
        ],
      ),
      Expanded(
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("$index"));
            }),
      ),
    ]);
  }
  Widget _renderRow(BuildContext context, int index) {
    if (index < _listData.length) {
     return ListTile(title: Text(_listData[index].id.toString()));
    }
    return _getMoreWidget();
  }

  /**
   * 加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            // CircularProgressIndicator(
            //   strokeWidth: 1.0,
            // )
          ],
        ),
      ),
    );
  }
}

class ItemBanner extends StatelessWidget {
  final BannerDatas value;

  const ItemBanner({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: Image.network(value.imagePath!),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          // children: [Text(value.title!), Text(value.desc!)],
        ),
      ),
    ]);
  }
}
