import 'dart:developer';

class Log{

  static const String _defTagApp = 'app ';
  static const String _defTag = 'tag';
  static bool _debugMode = true; //是否是debug模式,true: log v 不输出.
  static int _maxLen = 128;
  static String _tagValue = _defTag;

  static void init({
    String tag = _defTag,
    bool isDebug = false,
    int maxLen = 128,
  }) {
    _tagValue = tag;
    _debugMode = isDebug;
    _maxLen = maxLen;
  }

  static bool getMode() {
    return _debugMode;
  }


  static void d(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag!, ' d ', object);
    }
  }

  static void e(Object object, {String? tag}) {
    _printLog(tag!, ' e ', object);
  }

  static void v(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag!, ' v ', object);
    }
  }

  static void _printLog(String tag, String stag, Object object) {
    String da = object.toString();
    tag = tag ?? _tagValue;
    if (da.length <= _maxLen) {
      print('$_defTagApp$tag$stag $da');
      return;
    }
    print(
        '$_defTagApp$tag$stag — — — — — — — — — — — — — — — — st — — — — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print('$tag$stag| ${da.substring(0, _maxLen)}');
        da = da.substring(_maxLen, da.length);
      } else {
        print('$tag$stag| $da');
        da = '';
      }
    }
    print(
        '$_defTagApp$tag$stag — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —');
  }



}