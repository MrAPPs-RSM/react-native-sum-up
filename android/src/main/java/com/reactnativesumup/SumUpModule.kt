package com.reactnativesumup

import android.content.Intent
import android.net.Uri
import androidx.core.content.ContextCompat
import com.facebook.react.bridge.*
import com.sumup.merchant.api.SumUpPayment
import java.lang.Exception
import java.math.BigDecimal
import java.math.RoundingMode
import java.util.*
import kotlin.collections.HashMap

class SumUpModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

  lateinit var mPaymentPromise: Promise
  var mReactContext: ReactContext
  val ITALIAN_NUMBER_PREFIX = "+39"
  var CALLBACK_HOST = "result"
  var CALLBACK_SCHEME = "phome"

  override fun getName(): String {
    return "SumUp"
  }

  init {
    mReactContext = reactContext
  }

  override fun getConstants(): MutableMap<String, Object> {
    val constants: MutableMap<String, Object> = HashMap()

    constants.plus(Pair("SMPCurrencyCodeEUR", SumUpPayment.Currency.EUR))
    constants.plus(Pair("SMPCurrencyCodeUSD", SumUpPayment.Currency.USD))

    return constants
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
          + "?affiliate-key="+ affiliateKey
          + "&app-id=" + appId
          + "&total=" + totalAmount
          + "&currency=" + currencyCode
          + "&title=" + title
          + "&receipt-mobilephone=" + customerPhoneNumber
          + "&receipt-email=" + customerEmail
          + "&foreign-tx-id=" + transactionId
          + "&callback=" + CALLBACK_SCHEME + "://" + CALLBACK_HOST))



      mReactContext.currentActivity?.startActivity(payIntent, null)

      mPaymentPromise.resolve(true)
    } catch (ex: Exception) {
      mPaymentPromise.reject(ex)
    }

  }
}
