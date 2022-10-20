import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterx_live_data/flutterx_live_data.dart';
import 'package:wanandroid_flutter/base/BasePageWidget.dart';
import 'package:wanandroid_flutter/response/BannerResponse.dart';
import 'package:wanandroid_flutter/viewmodel/TabPageMainViewModel.dart';

class TabPageMain extends BasePage {
  const TabPageMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageMain();
  }
}

class _TabPageMain extends BasePageState<TabPageMainViewModel, TabPageMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  TabPageMainViewModel getViewModel() {
    return TabPageMainViewModel();
  }

  @override
  Widget builded(BuildContext context) {
    mViewModel.getBannerData();
    return Column(
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
    );
  }
}

class ItemBanner extends StatelessWidget {
  final BannerDatas value;

  const ItemBanner({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
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
