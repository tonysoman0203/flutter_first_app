package com.example.flutter_first_app

import android.content.Context
import android.content.Intent
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.lang.Boolean

class MainActivity: FlutterActivity() {
    private val CHANNEL = "getBatteryStatus";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL)
                .setMethodCallHandler(object : MethodChannel.MethodCallHandler{
                    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
                    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                        if (call.method.equals("getBatteryStatus")) {
                            val batteryStatus = getBatteryStatus();
                            val myMessage = batteryStatus.toString()
                            result.success(myMessage)
                        }

                        if (call.method.equals("takePhoto")) {
                            val intent = Intent("android.media.action.IMAGE_CAPTURE");
                            startActivity(intent);
                        }
                    }
                })

    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getBatteryStatus(): Int {
        val bm: BatteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
