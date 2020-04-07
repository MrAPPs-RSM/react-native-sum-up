package com.reactnativesumup

import android.content.Intent
import android.net.Uri
import androidx.core.content.ContextCompat.startActivity
import com.facebook.react.ReactPackage
import com.facebook.react.bridge.*
import com.facebook.react.uimanager.ViewManager
import java.lang.Exception
import java.math.BigDecimal
import java.math.RoundingMode
import java.util.*

class SumUpPackage : ReactPackage {

  lateinit var mPaymentPromise: Promise
  lateinit var mReactContext: ReactContext
  val ITALIAN_NUMBER_PREFIX = "+39"
  var AFFILIATE_KEY = "e721bf67-7393-4511-a398-02e3c79acfc9"
  var CALLBACK_SCHEME = "phome"

  override fun createNativeModules(reactContext: ReactApplicationContext): List<NativeModule> {
    mReactContext = reactContext
    return listOf<NativeModule>(SumUpModule(reactContext))
  }

  override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> {
    return emptyList()
  }

  fun setPrefixIfNeeded(number: String?): String? {
    if (number?.length == 10) {
      return ITALIAN_NUMBER_PREFIX + number
    } else {
      return number
    }
  }

  @ReactMethod
  fun makePayment(request: ReadableMap, promise: Promise) {

    mPaymentPromise = promise

    try {

      var transactionId = UUID.randomUUID().toString()
      var title = request.getString("title")
      var affiliateKey = request.getString("affiliateKey");
      var totalAmount = BigDecimal(request.getString("totalAmount")).setScale(2, RoundingMode.HALF_EVEN)
      var customerEmail = request.getString("customerEmail")
      var customerPhoneNumber = setPrefixIfNeeded(request.getString("customerPhoneNumber"))
      var appId = mReactContext.packageName
      var currencyCode = request.getString("currencyCode")

      var payIntent = Intent(Intent.ACTION_VIEW, Uri.parse(
        "sumupmerchant://pay/1.0"
          + "?affiliate-key=\"" + affiliateKey + "\""
          + "&app-id=" + appId
          + "&total=" + totalAmount
          + "&currency=" + currencyCode
          + "&title=" + title
          + "&receipt-mobilephone=" + customerPhoneNumber
          + "&receipt-email=" + customerEmail
          + "&foreign-tx-id=" + transactionId
          + "&callback=" + CALLBACK_SCHEME + "://result"))

      startActivity(mReactContext, payIntent, null)

      mPaymentPromise.resolve(true)
    } catch (ex: Exception) {
      mPaymentPromise.reject(ex)
    }

  }
}
