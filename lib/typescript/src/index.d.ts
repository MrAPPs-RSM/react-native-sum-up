export declare enum CurrencyCode {
    EUR = "EUR",
    USD = "USD"
}
declare type PaymentRequestData = {
    affiliateKey: string;
    title: string;
    totalAmount: string;
    customerEmail: string;
    customerPhoneNumber: string;
    currencyCode: CurrencyCode;
};
declare type SumUpType = {
    makePayment(request: PaymentRequestData): Promise<void>;
};
declare const _default: SumUpType;
export default _default;
