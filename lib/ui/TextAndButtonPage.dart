import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextPage extends StatefulWidget {
  @override
  TextPageState createState() {
    return new TextPageState();
  }
}

class TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    '学习Text',
                    textAlign: TextAlign.center,
                    //文本对齐方式  居中
                    textDirection: TextDirection.ltr,
                    //文本方向
                    softWrap: false,
                    //是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
                    overflow: TextOverflow.ellipsis,
                    //文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
                    textScaleFactor: 2.0,
                    //字体显示的赔率
                    maxLines: 10,
                    //最大行数
                    style: new TextStyle(
                      decorationColor: const Color(0xff000000),
                      //线的颜色
                      decoration: TextDecoration.none,
                      //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
                      decorationStyle: TextDecorationStyle.solid,
                      //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
                      wordSpacing: 0.0,
                      //单词间隙(负值可以让单词更紧凑)
                      letterSpacing: 0.0,
                      //字母间隙(负值可以让字母更紧凑)
                      fontStyle: FontStyle.italic,
                      //文字样式，斜体和正常
                      fontSize: 20.0,
                      //字体大小
                      fontWeight: FontWeight.w900,
                      //字体粗细  粗体和正常
                      color: const Color(0xff000000), //文字颜色
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      height: 200,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.send),
                            label: Text("发送"),
                            style: ButtonStyle(
                              //背景颜色
                              //背景颜色
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                //设置按下时的背景颜色
                                if (states.contains(MaterialState.pressed)) {
                                  return Color(0xff999999);
                                }
                                //默认不使用背景颜色
                                return Color(0xffffffff);
                              }),
                              //字体颜色
                              foregroundColor:
                                  MaterialStateProperty.all(Color(0xff5E6573)),
                              // 高亮色
                              overlayColor:
                                  MaterialStateProperty.all(Color(0xffffffff)),
                              //阴影颜色
                              shadowColor:
                                  MaterialStateProperty.all(Color(0xffffffff)),
                              //阴影值
                              elevation: MaterialStateProperty.all(0),
                              //字体
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 12)),
                              //边框
                              side: MaterialStateProperty.all(BorderSide(
                                  width: 1, color: Colors.redAccent)),

                              //形状
                              shape: MaterialStateProperty.all(StadiumBorder(
                                  side: BorderSide(
                                //设置 界面效果
                                style: BorderStyle.solid,
                                color: Color(0xffFF7F24),
                              ))),
                            ),
                            onPressed: () {},
                          ),
                          OutlineButton.icon(
                            icon: Icon(Icons.add),
                            label: Text("添加"),
                            onPressed: () {},
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.info),
                            label: Text("详情"),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: "Home: "),
                        TextSpan(
                          text: "https://flutterchina.club",
                          style: TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              //点击触发
                              Fluttertoast.showToast(
                                  msg: "This is Center Short Toast",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            },
                        ),
                      ])),
                    )),
              ],
            )));
  }
}
