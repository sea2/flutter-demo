



import 'package:flutter/material.dart';
class ListDialog extends SimpleDialog {
Function callBack;
  ListDialog(this.callBack);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SimpleDialog(
      title: new Text("标题"),
      contentPadding: const EdgeInsets.all(10.0),
      children: <Widget>[    //SimpleDialog内可指定多个children
        new Text("文字内容1"),
        new ListTile(
          leading: new Icon(Icons.android),
          title: new Text("android"),
        ),
        ElevatedButton(
            onPressed: () {
              callBack(1);
              Navigator.pop(context);
            },
            child: Text("取消")),
      ],
    );
  }
}
