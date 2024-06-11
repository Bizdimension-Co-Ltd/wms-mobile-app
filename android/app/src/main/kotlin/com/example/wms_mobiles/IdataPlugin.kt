package com.example.wms_mobiles


import android.annotation.SuppressLint
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar

public class IdataPlugin : MethodCallHandler  {

    private var registrar: Registrar? = null

    var channelBarcodeScan: MethodChannel? = null

    var channelRfid: MethodChannel? = null

    private fun IdataPlugin(registrar: Registrar): MethodCallHandler? {
        this.registrar = registrar
        return TODO("Provide the return value")
    }

    /** Plugin registration.  */
    fun registerWith(registrar: Registrar) {
        check(channelBarcodeScan == null) { "You should not call registerWith more than once." }
        channelBarcodeScan = MethodChannel(registrar.messenger(), "idata_barcode_plugin")
        channelBarcodeScan!!.setMethodCallHandler(IdataPlugin(registrar))
        check(channelRfid == null) { "You should not call registerWith more than once." }
        channelRfid = MethodChannel(registrar.messenger(), "idata_rfid_plugin")
        channelRfid!!.setMethodCallHandler(IdataPlugin(registrar))
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        TODO("Not yet implemented")
    }
}