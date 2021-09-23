import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/otherPage.dart';
import 'package:flutterapp/ui/Dialog.dart';
import 'package:flutterapp/ui/TextAndButtonPage.dart';
import 'package:flutterapp/ui/_TabbarPage.dart';
import 'package:flutterapp/ui/visibilityPage.dart';
import 'package:flutterapp/utils/ToastUtils.dart';

import 'ListViewPage.dart';
import 'ui/uiPage.dart';
import 'utils/HttpController.dart';
import 'entity/city.dart';
import 'callNative.dart';
import 'view/imagePage.dart';

final TAG = "main";

void main() {
//  debugPaintSizeEnabled = true; //打开视觉调试开关
  LogUtil.init(isDebug: true);
  //去除沉浸式状态栏
  try {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
  } catch (e) {
    print(e);
  }
  //宽高
  final width = window.physicalSize.width;
  final height = window.physicalSize.height;
  print("屏幕 宽度=$width  高度=$height");

  Future.delayed(const Duration(milliseconds: 100), () {
    runApp(MyApp());
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

int testInt = 1;

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  String textInfo = "默认信息";
  String textHttp = "http默认信息";
  var isSuccess = false;

  _MyHomePageState() {
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

    getData();
    LogUtil.v("initState", tag: TAG);
    getDeviceInfo().then((data) {
      print("设备信息： ${data.model}  ${data.id}  ${data.device}");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LogUtil.v("didChangeDependencies", tag: TAG);
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("build", tag: TAG);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Wrap(
          spacing: 8.0, // 主轴(水平)方向间距
          runSpacing: 4.0, // 纵轴（垂直）方向间距
          alignment: WrapAlignment.center, //沿主轴方向居中
          children: <Widget>[
            Text(
              '本地json-$textInfo',
            ),
            Divider(
              color: Colors.grey,
              height: 1.0,
              thickness: 1.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
            Text(
              '网络请求-$textHttp',
            ),
            Divider(
              color: Colors.grey,
              height: 1.0,
              thickness: 1.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () async {
                // 打开`TipRoute`，并等待返回结果
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OtherPage(
                        // 路由参数
                        title: '新页面哦',
                      );
                    },
                  ),
                );
                //刷新
                setState(() {
                  textInfo = result;
                });
              },
              child: Text("打开新页面"),
            ),
            ElevatedButton(
              onPressed: () async {
                // 打开`TipRoute`，并等待返回结果
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ImagePage(
                        // 路由参数
                        title: 'Image',
                      );
                    },
                  ),
                );
              },
              child: Text("Image"),
            ),
            ElevatedButton(
              onPressed: () async {
                // 打开`TipRoute`，并等待返回结果
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UiPage(
                        // 路由参数
                        title: '布局测试',
                      );
                    },
                  ),
                );
              },
              child: Text("布局测试"),
            ),
            ElevatedButton(
              onPressed: () async {
                // 打开`TipRoute`，并等待返回结果
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ListViewPage(
                        // 路由参数
                        title: 'Listview',
                      );
                    },
                  ),
                );
              },
              child: Text("Listview"),
            ),
            ElevatedButton(
              onPressed: () async {
                // 打开`TipRoute`，并等待返回结果
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CallNative(
                        // 路由参数
                        title: '调用android原生',
                      );
                    },
                  ),
                );
                //刷新
                setState(() {
                  textInfo = result;
                });
              },
              child: Text("调用android原生"),
            ),
            ElevatedButton(
              onPressed: () {
                // 打开`TipRoute`，并等待返回结果
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TabBarPage();
                    },
                  ),
                );
              },
              child: Text("tab切换保持状态"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffffffff)),
                //背景颜色
                foregroundColor: MaterialStateProperty.all(Color(0xff5E6573)),
                //字体颜色
                overlayColor: MaterialStateProperty.all(Color(0xffffffff)),
                // 高亮色
                shadowColor: MaterialStateProperty.all(Color(0xffffffff)),
                //阴影颜色
                elevation: MaterialStateProperty.all(0),
                //阴影值
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 12)),
                //字体
                side: MaterialStateProperty.all(
                    BorderSide(width: 1, color: Color(0xffCAD0DB))),
                //边框
                shape: MaterialStateProperty.all(StadiumBorder(
                    side: BorderSide(
                  //设置 界面效果
                  style: BorderStyle.solid,
                  color: Color(0xffFF7F24),
                ))),
              ), //圆角弧度
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VisibilityPage();
                      },
                    ),
                  );
                },
                child: Text("显示隐藏")),
            ElevatedButton(
                onPressed: () {
                  showDialog(context: context,builder: (context){
                    return new ListDialog((data){
                      ToastUtils.toast("$data",backgroundColor: Color(0x88000000));
                    });
                  });
                },
                child: Text("dialog")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TextPage();
                      },
                    ),
                  );
                },
                child: Text("Text和button控件")),
            FutureBuilder(
              future: decodeCity(),
              builder: (BuildContext context, AsyncSnapshot<City> snapshot) {
                /*表示数据成功返回*/
                if (snapshot.hasData) {
                  City? city = snapshot.data;
                  return Text("FutureBuilder-${city!.name}");
                } else {
                  return Text("错误");
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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

  void getData() {
    //加载本地json
    rootBundle.loadString('assets/city.json').then((value) {
      final jsonMap = json.decode(value);
      City city = City.fromJson(jsonMap);
      setState(() {
        _counter = city.id;
        textInfo = city.name + city.phone;
      });
    });

    //网络请求
    Map<String, String> map = new Map();
    map["v"] = "1.0";
    map["month"] = "7";
    map["day"] = "25";
    map["key"] = "bd6e35a2691ae5bb8425c8631e475c2a";
    HttpController.get("https://commcdn.chiji-h5.com/flycar/json/cityList.json",
        (data) {
      if (data != null) {
        final body = json.decode(data);
        final feeds = body["result"];
        var items = [];
        feeds.forEach((item) {
          items.add(
              City(id: item["id"], name: item["name"], phone: item["phone"]));
        });
        setState(() {
          textHttp = items.toString();
        });
      }
    }, map);
  }

  // 读取 assets 文件夹中的 City.json 文件
  Future<String> _loadCityJson() async {
    return await DefaultAssetBundle.of(context).loadString("assets/city.json");
  }

  // 将 json 字符串解析为 City 对象
  Future<City> decodeCity() async {
    // 获取本地的 json 字符串
    String personJson = await _loadCityJson();

    // 解析 json 字符串，返回的是 Map<String, dynamic> 类型
    final jsonMap = json.decode(personJson);
    print('jsonMap runType is ${jsonMap.runtimeType}');

    City city = City.fromJson(jsonMap);
    return city;
  }
}

/*
    * @description:  获取设备信息
    * @return {type} 设备信息
    */
Future<dynamic> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
  var dataInfo;
  if (Platform.isIOS) {
    print('IOS设备：');
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    dataInfo = iosInfo;
  } else if (Platform.isAndroid) {
    print('Android设备');
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    dataInfo = androidInfo;
  }
  return dataInfo;
}

void getDeviceInfoCallBack(Function callback) async {
  DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
  var dataInfo;
  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    dataInfo = iosInfo;
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    dataInfo = androidInfo;
  }
  callback(dataInfo);
}

//  获取设备的指定信息
class FlutterDeviceInfo {
  // 获取设备的唯一标识 uuid
  static Future<String> get platformUid async {
    var data = await getDeviceInfo(), res;
    if (Platform.isIOS) {
      res = data.identifierForVendor;
    } else if (Platform.isAndroid) {
      res = data.id;
    }
    print("设备id=$res");
    return res;
  }

  //  获取设备name
  static Future<String> get platformName async {
    var data = await getDeviceInfo(), res;
    if (Platform.isIOS) {
      res = data.name;
    } else if (Platform.isAndroid) {
      res = data.device;
    }
    print("设备name=$res");
    return res;
  }

  // 获取设备的model
  static Future<String> get platformModel async {
    var data = await getDeviceInfo();
    print("model=${data.model}");

    return data.model;
  }
}

typedef MyCallBack = Function(String string, String s);

///可选参数
void printUserInfo(String name, [int? age]) {
  if (age != null) {
    print('姓名：$name----年龄：$age');
  } else {
    print('姓名：$name----年龄保密');
  }
}

/// 定义一个带默认参数的方法
void printUserInfo2(String name, [String sex = "女", int? age]) {
  if (age != null) {
    print('姓名：$name--性别$sex--年龄：$age');
  } else {
    print('姓名：$name--性别$sex--年龄保密');
  }
}

///定义一个命名参数的方法
void printUserInfo3(String name, {String sex = "女", int? age}) {
  if (age != null) {
    print('姓名：$name--性别$sex--年龄：$age');
  } else {
    print('姓名：$name--性别$sex--年龄保密');
  }
}


