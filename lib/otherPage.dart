
import 'dart:core';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/utils/Log.dart';
import 'package:flutterapp/utils/OnMultiClickListener.dart';

class OtherPage extends StatefulWidget {
  OtherPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  OtherPageState createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage> with WidgetsBindingObserver {
  final String TAG="OtherPage";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    print(Log.getMode());
    Log.v("initState", tag: TAG);

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Log.v("didChangeDependencies", tag: TAG);
  }

  @override
  Widget build(BuildContext context) {
    Log.v("build", tag: TAG);



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
      body: Stack(fit: StackFit.passthrough, children: <Widget>[
        Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 100.0,
              width: 200.0,
              color: Colors.green,
              child: Text("tets"),
            )),
        Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              height: 100.0,
              width: 200.0,
              color: Colors.green,
              child: Text("tets"),
            )),
      Positioned(
        bottom: 40,
        left: MediaQuery.of(context).size.width / 2 ,
        child: Container(
          alignment: Alignment.center,
          height: 100.0,
          width: 200.0,
          color: Colors.green,
          child: Text("tets"),
        ),
      ),
        Container(
          color: Colors.red,
          height: 200.0,
          width: 200.0,
          alignment: Alignment.topRight,
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
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "我是返回值");
                },
                child: Text("返回"),
              ),
              ElevatedButton(
                onPressed: () {
                  listener.onClick();
                },
                child: Text("测试重复点击"),
              ),
              ElevatedButton(
                onPressed: () {
                  listener2.onClick();
                },
                child: Text("测试重复点击"),
              ),
            ],
          ),
        )
      ]),
    );
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Log.v("didChangeAppLifecycleState${state.toString()}", tag: TAG);
  }

 var listener= new OnMultiClickListener((data){
   print(data.toString());
   if(data==1){
     print("1点击");
   }else{
     print("1重复点击");
   }
  });
 var listener2= new OnMultiClickListener((data){
   print(data.toString());
   if(data==1){
     print("2点击");
   }else{
     print("2重复点击");
   }
  });

  @override
  void deactivate() {
    super.deactivate();
    Log.v("deactivate", tag: TAG);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.addObserver(this);
    Log.v("dispose", tag: TAG);
  }




}
