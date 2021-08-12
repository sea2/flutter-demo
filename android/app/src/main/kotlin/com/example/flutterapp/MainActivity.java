package com.example.flutterapp;

import android.content.Intent;
import android.net.Uri;
import android.text.TextUtils;
import android.widget.Toast;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * Created by lhy on 2021/8/12 0012.
 */
public class MainActivity extends FlutterActivity {


    private static final String CHANNEL = "from.dart.call.native";

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
                                if(!TextUtils.isEmpty(para.toString())){
                                Toast.makeText(MainActivity.this, para.toString(), Toast.LENGTH_SHORT).show();}
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
