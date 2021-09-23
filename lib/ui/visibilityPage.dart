import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisibilityPage extends StatefulWidget {
  @override
  VisibilityPageState createState() => VisibilityPageState();
}

class VisibilityPageState extends State<VisibilityPage> {
  bool isShow1 = true;
  bool isShow2 = false;
  bool isShow3 = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              isShow1 ? isShow1 = false : isShow1 = true;

              //刷新
              setState(() {});
            },
            child: Text("Visibility的显示隐藏",    style: new TextStyle(
              fontSize: 14.0,
              //字体大小
              //字体粗细  粗体和正常
            ),),
          ),
          ElevatedButton(
            onPressed: () {
              isShow2 ? isShow2 = false : isShow2 = true;
              //刷新
              setState(() {});
            },
            child: Text("Offstage的显示隐藏"),
          ),
          ElevatedButton(
            onPressed: () {
              isShow3 ? isShow3 = false : isShow3 = true;
              //刷新
              setState(() {});
            },
            child: Text("Opacity的透明度显示隐藏"),
          ),
          Visibility(
            //   replacement	不可见时显示的组件（当maintainState = false）
            // visible	子组件是否可见，默认true（可见）
            visible: isShow1,
            // maintainState	不可见时是否维持状态，默认为false
            // maintainAnimation	不可见时，是否维持子组件中的动画
            // maintainSize	不可见时是否留有空间（设置为true，会报错。如果想隐藏并保留组件空间请使用Opacity）
            // maintainSemantics	不可见时是否维持它的语义（我也没搞明白是什么）
            // maintainInteractivity	不可见时是否具有交互性
            child: Container(
              color: Colors.red,
              child: Text("Visibility的显示隐藏",),
            ),
          ),
          Offstage(
            offstage: isShow2,
            child: Container(
              color: Colors.red,
              child: Text("Offstage的显示隐藏"),
            ),
          ),
          Opacity(
            opacity: isShow3 ? 1 : 0,
            child: Container(
              color: Colors.red,
              child: Text("Opacity的透明度显示隐藏"),
            ),
          ),
          Container(
            color: Colors.red,
            child: Text("参考块"),
          ),
        ],
      ),
    );
  }
}
