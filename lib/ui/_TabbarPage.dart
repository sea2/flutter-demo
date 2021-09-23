import 'package:flutter/material.dart';
import 'package:flutterapp/page/describePage.dart';
import 'package:flutterapp/ui/shopping.dart';
import 'package:flutterapp/view/imagePage.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() {
    return new _TabBarPageState();
  }
}

class _TabBarPageState extends State<TabBarPage> {
  late PageController _pageController;
  int currentIndex = 0;
  List<Widget> pagesLists = [
    new Page1(),
    new Page1(),
    new Page1(),
  ];
  List<String> navTitleLsit = ["首页", "任务", "我的"];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: pagesLists.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return pagesLists[index];
        },
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        //选中和未选中设置一样的字体大小,就不会出现类似动画的情况
        selectedFontSize: 14,
        unselectedFontSize: 14,
        //不设置显示不出文字
        type: BottomNavigationBarType.fixed,
        //设置选中时的颜色
        selectedItemColor: Colors.redAccent,
        currentIndex: currentIndex,
        items: [
          buliderBottomNavgationBarItem("nav_news", navTitleLsit[0]),
          buliderBottomNavgationBarItem("nav_tweet", navTitleLsit[1]),
          buliderBottomNavgationBarItem("nav_my", navTitleLsit[2])
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  BottomNavigationBarItem buliderBottomNavgationBarItem(
      String imageNameStr, String titleStr) {
    return BottomNavigationBarItem(
        icon: Image.asset("assets/images/ic_${imageNameStr}_normal.png",
            //下面两行代码解决点击icon时会发生闪动的情况
            excludeFromSemantics: true,
            gaplessPlayback: true,
            width: 23),
        activeIcon: Image.asset(
          "assets/images/ic_${imageNameStr}_actived.png",
          excludeFromSemantics: true,
          gaplessPlayback: true,
          width: 23,
        ),
        label: titleStr);
  }
}

class Page1 extends StatefulWidget{
  @override
  _Page1State createState() {
    return new _Page1State();
  }
}

class _Page1State extends State<Page1> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    print("Page 1 init");
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new LayoutBuilder(builder: (context, constraints) {
      return new NotificationListener<ScrollNotification>(
        onNotification: (notification){
          ScrollMetrics metrics = notification.metrics;
          print('ScrollNotification####################');
          print('pixels = ${metrics.pixels}');
          print('atEdge = ${metrics.atEdge}');
          print('axis = ${metrics.axis}');
          print('axisDirection = ${metrics.axisDirection}');
          print('extentAfter = ${metrics.extentAfter}');
          print('extentBefore = ${metrics.extentBefore}');
          print('extentInside = ${metrics.extentInside}');
          print('maxScrollExtent = ${metrics.maxScrollExtent}');
          print('minScrollExtent = ${metrics.minScrollExtent}');
          print('viewportDimension = ${metrics.viewportDimension}');
          print('outOfRange = ${metrics.outOfRange}');
          print('ScrollNotification####################');
          return false;
        },
        child: new ListView.builder(
          itemCount: 40,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Text('今天吃什么？$index'),
            );
          },
        ),
      );
    });
  }
  @override
  bool get wantKeepAlive => true;
}

