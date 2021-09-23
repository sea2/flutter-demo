




import 'Log.dart';

class OnMultiClickListener{

  final Function? function;

  OnMultiClickListener(this.function);


  // 两次点击按钮之间的点击间隔不能少于1000毫秒
   int MIN_CLICK_DELAY_TIME = 5000;
   int lastClickTime = 0;

   void onClick() {
     int curClickTime = new DateTime.now().millisecondsSinceEpoch;
    int timeLimit= curClickTime - lastClickTime;
      if (timeLimit> MIN_CLICK_DELAY_TIME) {
      // 超过点击间隔后再将lastClickTime重置为当前点击时间
      lastClickTime = curClickTime;
      function!(1);
    }else{
      function!(0);
    }
  }


}