import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ImagePageState createState() => ImagePageState();
}

class ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
            decoration: new BoxDecoration(color: Color(0xffFFFFFF)),
            child: Column(
                children: <Image>[
                  Image(
                    image: NetworkImage(
                        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage3.xyzs.com%2Fupload%2F18%2F5c%2F627%2F20150505%2F143082761977906_0.jpg&refer=http%3A%2F%2Fimage3.xyzs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631431787&t=007c328ebf8102097ee558b2a30a6af1"),
                    width: 300.0,
                  ),
                  Image(
                    image: NetworkImage(
                        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fphoto.16pic.com%2F00%2F38%2F88%2F16pic_3888084_b.jpg&refer=http%3A%2F%2Fphoto.16pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631432321&t=d2355ebdaa995217bff8e4751eee71c6"),
                    width: 300.0,
                    height: 300.0,
                    fit: BoxFit.contain,
                  ),

                ],
            ),
    );
  }
}
