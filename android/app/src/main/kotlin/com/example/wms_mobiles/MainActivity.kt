package com.example.wms_mobiles

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
//    private val CHANNEL = "com.example.method_channel"
//
//    var idataRfid: iDataRFID? = null
//    var idataBarcodeScan: iDataBarcodeScan? = null
//
//    var channelBarcodeScan: MethodChannel? = null
//
//    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "getBatteryLevel") {
//                val batteryLevel = getBatteryLevel()
//                result.success(batteryLevel.toString())
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
//    private fun getBatteryLevel(): Int {
//        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
//        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
//    }
}
