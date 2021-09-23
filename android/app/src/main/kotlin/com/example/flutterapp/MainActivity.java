package com.example.flutterapp;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Toast;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * Created by lhy on 2021/8/12 0012.
 */
public class MainActivity extends FlutterActivity {

    String TAG = this.getClass().getSimpleName();
    private static final String CHANNEL = "from.dart.call.native";


    // 设置状态栏沉浸式透明（修改flutter状态栏黑色半透明为全透明）
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            getWindow().setStatusBarColor(0);
        }
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
//        }

//        setStatusTextColor(true);

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            getWindow().getDecorView().setSystemUiVisibility(
//                    View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
//        }
    }

    public  void setStatusTextColor(boolean useDart) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (useDart) {//黑色状态栏字体
                int vis = this.getWindow().getDecorView().getSystemUiVisibility();
                vis |= View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
                this.getWindow().getDecorView().setSystemUiVisibility(vis);
            } else {
                int vis = this.getWindow().getDecorView().getSystemUiVisibility();
                vis &= ~View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
                //vis |= View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
                this.getWindow().getDecorView().setSystemUiVisibility(vis);
            }
        }
    }

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            Object para = call.arguments;
                            System.out.println("flutter传给安卓的值：" + para);
                            //与Flutter Client invokeMethod调用字符串标识符匹配
                            if (call.method.equals("interaction")) {
                                //initBlueTooth为后面安卓端需要调取的方法
                                result.success("success");
                            } else if (call.method.equals("toast")) {
                                if (!TextUtils.isEmpty(para.toString())) {
                                    Toast.makeText(MainActivity.this, para.toString(), Toast.LENGTH_SHORT).show();
                                }
                                result.success("success");
                            } else if (call.method.equals("browser")) {
                                Intent i = new Intent(Intent.ACTION_VIEW);
                                i.setData(Uri.parse("http://baidu.com"));
                                MainActivity.this.startActivity(i);
                                result.success("success");
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }


}
