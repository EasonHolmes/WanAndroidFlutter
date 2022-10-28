import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:wanandroid_flutter/assets_common/Assets.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/response/BannerResponse.dart';
import 'package:wanandroid_flutter/response/HomeListResponse.dart';
import 'package:wanandroid_flutter/ui/WebViewPage.dart';
import 'package:wanandroid_flutter/utils/HttpUtils.dart';
import 'package:wanandroid_flutter/utils/RouteUtils.dart';
import 'package:wanandroid_flutter/viewmodel/TabPageMainViewModel.dart';
import 'package:wanandroid_flutter/widget/CustomWidget.dart';
import 'package:wanandroid_flutter/widget/RefreshWidget.dart';

class TabPageMain extends BasePage {
  const TabPageMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageMain();
  }
}

class _TabPageMain extends BasePageState<TabPageMainViewModel, TabPageMain>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // ** and here

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
        _getListData(true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    super.build(context);
    return builded(context);
  }

  @override
  Widget builded(BuildContext context) {
    return RefreshWidget(
        onRefresh: () {
          // var page = _listData
          pageSize = 0;
          return _getListData(false);
        },
        child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: _listData.length + 2, //header+footer
            itemBuilder: (BuildContext context, int index) {
              return _renderRow(context, index);
            }));
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index == 0) {
      return _getHeaderWidget(context);
    } else if (index > 0 && index <= _listData.length) {
      //index 1 ~ index data.length
      return _listContent(context, index - 1); //减去header footer
    } else {
      return _getMoreWidget();
    }
  }

  Widget _listContent(BuildContext context, int index) {
    String? user = "";
    if (_listData[index].author != null &&
        _listData[index].author!.isNotEmpty) {
      user = _listData[index].author;
    } else {
      user = _listData[index].shareUser;
    }
    return Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        margin: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 0),
        child: CustomInkWell(
            onPressed: () {
              RouteUtils.routePage(
                  context,
                  WebViewPage(
                    url: _listData[index].link.toString(),
                    title: _listData[index].title.toString(),
                    isCollect: _listData[index].collect,
                    id: _listData[index].id.toString(),
                  ),res: (result){
                    if(result!=null && result){
                        _listData[index].collect = true;
                    }
              });
            },
            radius: 20,
            child: Column(
              children: [
                Row(children: [
                  Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Image.asset(
                        "${ImagePaths.root}/main_title_icon.png",
                        width: 50,
                        height: 50,
                      )),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(_listData[index].title.toString())))
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Image.asset(
                        "${ImagePaths.root}/main_user_icon.png",
                        width: 40,
                        height: 40,
                      )),
                  Expanded(child: Text("作者：${user!}"))
                ]),
                Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 10),
                    alignment: Alignment.bottomRight,
                    child: Text(_listData[index].niceDate.toString()))
              ],
            )));
  }

  Widget _getHeaderWidget(BuildContext context) {
    return LiveDataBuilder(
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
        });
  }

  /// 加载更多时显示的组件,给用户提示
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
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
