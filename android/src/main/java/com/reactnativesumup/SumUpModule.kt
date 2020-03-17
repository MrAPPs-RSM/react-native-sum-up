package com.reactnativesumup

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.sumup.merchant.api.SumUpAPI
import com.sumup.merchant.api.SumUpPayment

class SumUpModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "SumUp"
    }

  override fun getConstants(): MutableMap<String, Object> {
    val  constants: MutableMap<String, Object> = HashMap()

    constants.plus(Pair("SMPCurrencyCodeEUR", SumUpPayment.Currency.EUR))
    constants.plus(Pair("SMPCurrencyCodeUSD", SumUpPayment.Currency.USD))

    return constants
  }
}
