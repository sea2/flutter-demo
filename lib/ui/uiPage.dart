import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiPage extends StatefulWidget {
  UiPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  UiPageState createState() => UiPageState();
}

class UiPageState extends State<UiPage> {
  @override
  Widget build(BuildContext context) {
//    return Container(
//        color: Colors.white,
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.end,
//          mainAxisSize: MainAxisSize.max,
//          children: [
//            Expanded(
//              flex: 1,
//              child: Text(
//                '学习Text',
//                textAlign: TextAlign.center,
//                //文本对齐方式  居中
//                textDirection: TextDirection.ltr,
//                //文本方向
//                softWrap: false,
//                //是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
//                overflow: TextOverflow.ellipsis,
//                //文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
//                textScaleFactor: 2.0,
//                //字体显示的赔率
//                maxLines: 10,
//                //最大行数
//                style: new TextStyle(
//                  decorationColor: const Color(0xff000000),
//                  //线的颜色
//                  decoration: TextDecoration.none,
//                  //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
//                  decorationStyle: TextDecorationStyle.solid,
//                  //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
//                  wordSpacing: 0.0,
//                  //单词间隙(负值可以让单词更紧凑)
//                  letterSpacing: 0.0,
//                  //字母间隙(负值可以让字母更紧凑)
//                  fontStyle: FontStyle.italic,
//                  //文字样式，斜体和正常
//                  fontSize: 20.0,
//                  //字体大小
//                  fontWeight: FontWeight.w900,
//                  //字体粗细  粗体和正常
//                  color: const Color(0xff000000), //文字颜色
//                ),
//              ),
//            ),
//            Expanded(
//                flex: 2,
//                child: Container(
//                  color: Colors.redAccent,
//                  margin: EdgeInsets.all(10.0),
//                  padding: EdgeInsets.all(10.0),
//                  width: 100,
//                  height: 200,
//                  alignment: Alignment.centerLeft,
//                  child: Text("123"),
//                )),
//            Expanded(
//                flex: 1,
//                child: Container(
//                  color: Colors.pink,
//                  child: Text("123"),
//                )),
//          ],
//        ));

    return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
                //标题
                child: new Container(
              decoration: new BoxDecoration(color: Colors.white),
              height: 50,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Text(
                    "返回",
                    style: new TextStyle(
                      fontSize: 20.0,
                      //字体大小
                      fontWeight: FontWeight.w900,
                      //字体粗细  粗体和正常
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  new Expanded(
                      flex: 1,
                      child: Text(
                        "标题",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontSize: 20.0,
                          //字体大小
                          fontWeight: FontWeight.w900,
                          //字体粗细  粗体和正常
                          color: const Color(0xff000000),
                        ),
                      )),
                  Text(
                    "更多",
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                      fontSize: 20.0,
                      //字体大小
                      fontWeight: FontWeight.w900,
                      //字体粗细  粗体和正常
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              ),
            )),

            new Expanded(
              flex: 1,
              child: new Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                width: 350,
                child: new SingleChildScrollView(
                    child: Column(children: [
                  Image(
                    image: NetworkImage(
                        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage3.xyzs.com%2Fupload%2F18%2F5c%2F627%2F20150505%2F143082761977906_0.jpg&refer=http%3A%2F%2Fimage3.xyzs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631431787&t=007c328ebf8102097ee558b2a30a6af1"),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    "李白 （唐代著名浪漫主义诗人） 编辑 讨论99+\n\t李白（701年－762年） ，字太白，号青莲居士，又号“谪仙人”，是唐代伟大的浪漫主义诗人，被后人誉为“诗仙”，与杜甫并称为“李杜”，为了与另两位诗人李商隐与杜牧即“小李杜”区别，杜甫与李白又合称“大李杜”。据《新唐书》记载，李白为兴圣皇帝（凉武昭王李暠）九世孙，与李唐诸王同宗。其人爽朗大方，爱饮酒作诗，喜交友。\n\t李白深受黄老列庄思想影响，有《李太白集》传世，诗作中多以醉时写的，代表作有《望庐山瀑布》《行路难》《蜀道难》《将进酒》《明堂赋》《早发白帝城》等多首。\n\t李白所作词赋，宋人已有传记（如文莹《湘山野录》卷上），就其开创意义及艺术成就而言，“李白词”享有极为崇高的地位。",
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.blue),
                  )
                ])),
                alignment: Alignment.topLeft,
              ),
            ),
          ],
        ));
  }
}
