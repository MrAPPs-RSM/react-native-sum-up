import { NativeModules } from 'react-native';

export enum CurrencyCode {
  EUR = 'EUR',
  USD = 'USD',
}

type PaymentRequestData = {
  affiliateKey: string;
  title: string;
  totalAmount: string;
  customerEmail: string;
  customerPhoneNumber: string;
  currencyCode: CurrencyCode;
};

// var title = request.getString("title")
// var totalAmount = BigDecimal(request.getString("totalAmount")).setScale(2, RoundingMode.HALF_EVEN)
// var customerEmail = request.getString("customerEmail")
// var customerPhoneNumber = setPrefixIfNeeded(request.getString("customerPhoneNumber"))
// var appId = mReactContext.packageName
// var currencyCode = request.getString("currencyCode")
type SumUpType = {
  makePayment(request: PaymentRequestData): Promise<void>;
};

const { SumUp } = NativeModules;

export default SumUp as SumUpType;
