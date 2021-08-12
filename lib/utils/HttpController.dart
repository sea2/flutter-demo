import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpController {
  static void get(
    String url,
    Function callback,
    Map<String, String> params,
  ) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(url);
      if (callback != null) {
        // 不会乱码
        String messageTxt = Utf8Decoder().convert(res.bodyBytes);
        callback(messageTxt);
      }
    } catch (exception) {
      if (callback != null) {
        callback(exception);
      }
    }
  }

  static void post(
      String url, Function callback, Map<String, String> params) async {
    try {
      http.Response res = await http.post(url, body: params);
      if (callback != null) {
        String messageTxt = Utf8Decoder().convert(res.bodyBytes);
        callback(messageTxt);
      }
    } catch (e) {
      if (callback != null) {
        callback(e);
      }
    }
  }
}
