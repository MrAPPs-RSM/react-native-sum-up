#import "SumUp.h"
#import <React/RCTConvert.h>
#import <SMPPayment/SMPPaymentRequest.h>

@implementation NSDictionary (WKDictionary)

- (id)objectForKeyNotNull:(id)key {
    
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}
@end


@implementation SumUp


- (NSDictionary *)constantsToExport
{
    return @{
              @"SMPCurrencyCodeEUR" : @"EUR",
              @"SMPCurrencyCodeUSD" : @"USD"};
}

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
    NSString *customerPhoneNumber = nil;
    NSString *formattedPhoneNumber = nil;
    
    if(![request[@"customerPhoneNumber"]isEqual:[NSNull null]])
    {
      customerPhoneNumber = [RCTConvert NSString:request[@"customerPhoneNumber"]];
    }
    
    if (customerPhoneNumber != nil) {
      formattedPhoneNumber = [self setPrefixIfNeeded:(customerPhoneNumber)];
    }

    NSString *currencyCode = [RCTConvert NSString:request[@"currencyCode"]];
    NSString *affiliateKey = [RCTConvert NSString:request[@"affiliateKey"]];
    NSString *transactionId = [[NSUUID UUID] UUIDString];
    
    SMPPaymentRequest *paymentRequest = [SMPPaymentRequest
                                            paymentRequestWithAmount:total
                                            currency:currencyCode
                                            title:title
                                            affiliateKey:affiliateKey];

    [paymentRequest setForeignTransactionID:transactionId];
    
    if (customerPhoneNumber != nil) {
    [paymentRequest setReceiptPhoneNumber:formattedPhoneNumber];
    }

    [paymentRequest setReceiptEmailAddress:customerEmail];
    [paymentRequest setCallbackURLSuccess:[NSURL URLWithString:@"phome://result"]];
    [paymentRequest setCallbackURLFailure:[NSURL URLWithString:@"phome://result"]];

    [paymentRequest openSumUpMerchantApp];
}

RCT_EXPORT_MODULE();

@end
