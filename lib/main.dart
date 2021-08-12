import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/otherPage.dart';

import 'utils/HttpController.dart';
import 'entity/city.dart';
import 'callNative.dart';

void main() {
  //去除沉浸式状态栏
//  if (Platform.isAndroid) {
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//  }
  runApp(MyApp());
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String textInfo = "默认信息";
  String textHttp = "http默认信息";

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
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '本地json-$textInfo',
            ),
            Divider(height: 1.0,indent: 100,color: Colors.red,),
            Text(
              '网络请求-$textHttp',
            ),
            Divider(height: 1.0,indent: 100,color: Colors.red,),
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
