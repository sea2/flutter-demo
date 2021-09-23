import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp/utils/Log.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ShoppingState createState() => ShoppingState();
}

class ShoppingState extends State<ShoppingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late List<Image> imgs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      Log.d("ShoppingPage", tag: tabController.index.toString());
    });

    imgs = [
      //建立了一个图片数组
      Image.asset(
        "assets/images/img_bar_firest.png",
        fit: BoxFit.cover,
      ),
      Image.asset(
        "assets/images/img_bar_firest.png",
        fit: BoxFit.cover,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: false,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Stack(
                children: [
                  Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      //条目构建函数传入了index,根据index索引到特定图片
                      return imgs[index];
                    },
                    itemCount: imgs.length,
                    autoplay: true,
                    duration: 300,
                    pagination: new SwiperPagination(),
                    //这些都是控件默认写好的,直接用
                    control:
                        new SwiperControl(iconNext: null, iconPrevious: null),
                    onTap: (index) {

                    },
                  ),
                  Positioned(left: 20, top: 20, child: Icon(Icons.search)),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: new TabBar(
                indicatorColor: Color(0xFFEF5350),
                //指示器颜色
                labelColor: Colors.black,
                //选中 label 颜色
                unselectedLabelColor: Colors.black38,
                //未选中 label 颜色
                indicatorSize: TabBarIndicatorSize.label,
                //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                unselectedLabelStyle:
                    TextStyle(fontSize: 14.0, fontWeight: (FontWeight.normal)),
                //设置选中时的字体颜色，tabs里面的字体样式优先级最高
                labelStyle:
                    TextStyle(fontSize: 16.0, fontWeight: (FontWeight.bold)),
                //指示器大小计算方式，TabBarIndicatorSize.label 跟文 字等宽,TabBarIndicatorSize.tab 跟每个 tab 等宽
                tabs: <Widget>[
                  new Tab(
                    text: "热门",
                  ),
                  new Tab(
                    text: "盲盒",
                  ),
                  new Tab(
                    text: "数码产品",
                  ),
                ],
                controller: tabController,
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: this.tabController,
        children: <Widget>[
          ListViewContnet(
            title: "1",
          ),
          ListViewContnet(
            title: "2",
          ),
          ListViewContnet(
            title: "3",
          ),
        ],
      ),
    );

    /*return Column(children: [

      InkWell(
        child: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff999999), width: 1), //边框
            borderRadius: BorderRadius.all(
              //圆角
              Radius.circular(20.0),
            ),
          ),
          child: Icon(Icons.search),
        ),
        onTap: () {},
      ),

      Container(
        margin: EdgeInsets.only(top: 10.0),
        height: 200,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            //条目构建函数传入了index,根据index索引到特定图片
            return imgs[index];
          },
          itemCount: imgs.length,
          autoplay: true,
          duration: 1000,
          pagination: new SwiperPagination(),
          //这些都是控件默认写好的,直接用
          control: new SwiperControl(),
          onTap: (index) {},
        ),
      ),
      Container(
        // 这里设置tab的背景色  bg#ffffff
        color: Colors.white,
        child: DefaultTabController(
          length: 3,
          child: new TabBar(
            indicatorColor: Color(0xFFEF5350),
            //指示器颜色
            labelColor: Colors.black,
            //选中 label 颜色
            unselectedLabelColor: Colors.black38,
            //未选中 label 颜色
            indicatorSize: TabBarIndicatorSize.label,
            //设置未选中时的字体样式，tabs里面的字体样式优先级最高
            unselectedLabelStyle:
                TextStyle(fontSize: 14.0, fontWeight: (FontWeight.normal)),
            //设置选中时的字体颜色，tabs里面的字体样式优先级最高
            labelStyle:
                TextStyle(fontSize: 16.0, fontWeight: (FontWeight.bold)),
            //指示器大小计算方式，TabBarIndicatorSize.label 跟文 字等宽,TabBarIndicatorSize.tab 跟每个 tab 等宽
            tabs: <Widget>[
              new Tab(
                text: "热门",
              ),
              new Tab(
                text: "盲盒",
              ),
              new Tab(
                text: "数码产品",
              ),
            ],
            controller: tabController,
          ),
        ),
      ),

      Expanded(
        flex: 1,
        child: TabBarView(
          controller: this.tabController,
          children: <Widget>[
            ListViewContnet(
              title: "1",
            ),
            ListViewContnet(
              title: "2",
            ),
            ListViewContnet(
              title: "3",
            ),
          ],
        ),
      ),
    ]);*/
  }
}

class ListViewContnet extends StatefulWidget {
  ListViewContnet({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ListViewContnetPage createState() => ListViewContnetPage("123");
}

class ListViewContnetPage extends State<ListViewContnet> {
  String title;

  ListViewContnetPage(this.title);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      //水平子Widget之间间距
      crossAxisSpacing: 10.0,
      //垂直子Widget之间间距
      mainAxisSpacing: 10.0,
      //GridView内边距
      padding: EdgeInsets.all(10.0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      childAspectRatio: 0.7,
      //子Widget列表
      children: getWidgetList(),
    );
  }

  List<String> getDataList() {
    List<String> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(i.toString());
    }
    return list;
  }

  List<Widget> getWidgetList() {
    List<Widget> widgets = [];
    getDataList().forEach((element) {
      widgets.add(getItemContainer(element));
    });

    return widgets;
  }

  Widget getItemContainer(String item) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/image_goods1.png",
            fit: BoxFit.cover,
          ),
          Text("任天堂Switch掌上游戏机便 携NS 红蓝手柄"),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 1,
              child: Text(
                "￥350",
                textAlign: TextAlign.start,
                style: new TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Color(0xFFEF5350)),
              ),
            ),
            Text(
              "15人想要",
              textAlign: TextAlign.left,
              style: new TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Color(0xFF808080)),
            ),
          ]),
        ],
      ),
      color: Colors.white54,
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
