#import "SumUp.h"
#import <SMPPayment/SMPPaymentRequest.h>

@implementation SumUp

RCT_EXPORT_METHOD(makePayment:(NSString *)key resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{

    SMPPaymentRequest *request;
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"10.00"];

    request = [SMPPaymentRequest paymentRequestWithAmount:amount
                                                 currency:@"EUR"
                                                    title:@"My title"
                                             affiliateKey:@"e721bf67-7393-4511-a398-02e3c79acfc9"];

    [request setCallbackURLSuccess:[NSURL URLWithString:@"phome://result"]];
    [request setCallbackURLFailure:[NSURL URLWithString:@"phome://result"]];
    

    /* This will open the following URL
     * sumupmerchant://pay/1.0?amount=10.00&currency=EUR&affiliate-key=YOUR-AFFILIATE-KEY
     * &title=My%20title
     * &callbackfail=samplepaymentapp%3A%2F%2F
     * &callbacksuccess=samplepaymentapp%3A%2F%2F
     */

    /* Optionally: Setting the option to skip success screens
     * to add skip-screen-success=true to the URL
     * Supported by SumUp app version 1.69 and later.
     * [request setSkipScreenOptions:SMPSkipScreenOptionSuccess];
     */

    [request openSumUpMerchantApp];
}

RCT_EXPORT_MODULE();

@end
