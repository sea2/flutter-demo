import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/otherPage.dart';
import 'package:flutterapp/ui/shopping.dart';

import 'ListViewPage.dart';
import 'callNative.dart';
import 'entity/city.dart';
import 'ui/uiPage.dart';
import 'utils/HttpController.dart';
import 'view/imagePage.dart';

final TAG = "AppPage";

void main() {
//  debugPaintSizeEnabled = true; //打开视觉调试开关
  LogUtil.init(isDebug: true);

  //宽高
  final width = window.physicalSize.width;
  final height = window.physicalSize.height;
  print("屏幕 宽度=$width  高度=$height");

  Future.delayed(const Duration(milliseconds: 100), () {
    runApp(MyApp());
    //去除沉浸式状态栏
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      // SystemChrome.setSystemUIOverlayStyle(
      //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

int testInt = 1;

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _tabIndex = 0;
  int _counter = 0;
  String textInfo = "默认信息";
  String textHttp = "http默认信息";
  var isSuccess = false;
  var pages;
  var tabImages;
  final tabTextStyleSelected = TextStyle(color: const Color(0xfffe0137));
  final tabTextStyleNormal = TextStyle(color: const Color(0xff969696));
  var _body;

  HomePageState() {
    LogUtil.v("_MyHomePageState", tag: TAG);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter = _counter + 2;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    pages = <Widget>[ShoppingPage(title: "1"), Text("2"), Text("3"), Text("4"), Text("5")];
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('assets/images/ic_nav_news_normal.png'),
          getTabImage('assets/images/ic_nav_news_actived.png')
        ],
        [
          getTabImage('assets/images/ic_nav_tweet_normal.png'),
          getTabImage('assets/images/ic_nav_tweet_actived.png')
        ],
        [
          getTabImage('assets/images/ic_nav_discover_normal.png'),
          getTabImage('assets/images/ic_nav_discover_actived.png')
        ],
        [
          getTabImage('assets/images/ic_nav_my_normal.png'),
          getTabImage('assets/images/ic_nav_my_pressed.png')
        ],
        [
          getTabImage('assets/images/ic_nav_my_normal.png'),
          getTabImage('assets/images/ic_nav_my_pressed.png')
        ]
      ];
    }

    LogUtil.v("initState", tag: TAG);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LogUtil.v("didChangeDependencies", tag: TAG);
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("build", tag: TAG);
    _body = IndexedStack(
      children: pages,
      index: _tabIndex,
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _body,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), label: "购物"),
          BottomNavigationBarItem(icon: getTabIcon(1), label: "魔力盲盒"),
          BottomNavigationBarItem(icon: getTabIcon(2), label: "任务"),
          BottomNavigationBarItem(icon: getTabIcon(3), label: "购物车"),
          BottomNavigationBarItem(icon: getTabIcon(4), label: "我的"),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    LogUtil.v("didChangeAppLifecycleState${state.toString()}", tag: TAG);
  }

  @override
  void deactivate() {
    super.deactivate();
    LogUtil.v("deactivate", tag: TAG);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.addObserver(this);
    LogUtil.v("dispose", tag: TAG);
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  // Text getTabTitle(int curIndex) {
  //   return Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  // }

  Image getTabImage(path) {
    return Image.asset(path, width: 20.0, height: 20.0);
  }
}
