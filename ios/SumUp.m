#import "SumUp.h"
#import <React/RCTConvert.h>
#import <SMPPayment/SMPPaymentRequest.h>

@implementation SumUp

- (NSString*)setPrefixIfNeeded: (NSString*)number
{
  if (number != nil && number.length == 10) {
      return [@"+39" stringByAppendingString:number];
  } else {
      return number;
  }
}


RCT_EXPORT_METHOD(makePayment:(NSDictionary *)request resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{

    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:[RCTConvert NSString:request[@"totalAmount"]]];
    NSString *title = [RCTConvert NSString:request[@"title"]];
    NSString *customerEmail = [RCTConvert NSString:request[@"customerEmail"]];
    
    NSString *customerPhoneNumber = [RCTConvert NSString:request[@"customerPhoneNumber"]];
    NSString *formattedPhoneNumber = [self setPrefixIfNeeded:(customerPhoneNumber)];
    NSString *currencyCode = [RCTConvert NSString:request[@"currencyCode"]];
    NSString *transactionId = [[NSUUID UUID] UUIDString];
    
    SMPPaymentRequest *paymentRequest = [SMPPaymentRequest
                                            paymentRequestWithAmount:total
                                            currency:currencyCode
                                            title:title
                                            affiliateKey:@"e721bf67-7393-4511-a398-02e3c79acfc9"];

    [paymentRequest setForeignTransactionID:transactionId];
    [paymentRequest setReceiptPhoneNumber:formattedPhoneNumber];
    [paymentRequest setReceiptEmailAddress:customerEmail];
    [paymentRequest setCallbackURLSuccess:[NSURL URLWithString:@"phome://result"]];
    [paymentRequest setCallbackURLFailure:[NSURL URLWithString:@"phome://result"]];

    [paymentRequest openSumUpMerchantApp];
}

RCT_EXPORT_MODULE();

@end
