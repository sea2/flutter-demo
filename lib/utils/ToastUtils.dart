


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils{




  static void toast(String msg,{
    Toast? toastLength,
    double? fontSize,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  }){
    Fluttertoast.showToast(
        msg: msg,
        toastLength:toastLength??Toast.LENGTH_SHORT,
        gravity: gravity?? ToastGravity.CENTER,
        backgroundColor:  backgroundColor??Colors.black,
        textColor: textColor??Colors.white,
        fontSize: fontSize??16.0
    );
  }

}