import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ClassRoomWebView extends StatefulWidget {
  ClassRoomWebView({required this.url}) : super();
  final String url; // 外部传入的URL

  @override
  _ClassRoomWebViewState createState() => _ClassRoomWebViewState();
}

class _ClassRoomWebViewState extends State<ClassRoomWebView> {
  late BuildContext _context;
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  double _navBarHeight = 27; // 刘海高度

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((loadUrl) {
      //WebviewScaffold 加载的url变化时触发此方法
      // print('===>>当前 url:$loadUrl');

      // h5 点退出按钮，关闭webView
      if (loadUrl.endsWith('/backapp')) {
        flutterWebviewPlugin.close();
      }
      // 跳转到dart页面
      else if (loadUrl.endsWith('/policy')) {
        // 因为flutter_webview_plugin 是浮在flutterUI上的一层视图，它不在widget树中，跳转到dart页面时，需要隐藏掉web页面，再跳回来时再显示web页面
        flutterWebviewPlugin.hide();
        flutterWebviewPlugin.show();
        flutterWebviewPlugin.reloadUrl(widget.url);
      }
    });

    //加载错误时监听
    // flutterWebviewPlugin.onHttpError.listen((error){
    //   print('加载错误:${error.code}  ${error.url}');
    // });

    //加载状态变化监听
    // flutterWebviewPlugin.onStateChanged.listen((state){
    //   print('状态监听:${state.type.toString()}');
    // });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose(); // 页面退出时销毁flutter_webview_plugin
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _navBarHeight = MediaQuery.of(context).padding.top; //屏幕刘海高度

    return WebviewScaffold(
// 导航栏是H5页面的，这里需要留出刘海的高度
      appBar: PreferredSize(
          child: Container(
            color: Colors.white,
          ),
          preferredSize: Size.fromHeight(0)),
      url: widget.url,
      initialChild: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            '加载中...',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
