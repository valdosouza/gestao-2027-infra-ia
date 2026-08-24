unit TrayOrder;

interface

uses
      System.SysUtils, System.Classes, System.Generics.Collections, System.JSON, TrayProductsSold, TrayPaymentWrapper, TrayOrderTransaction, TrayOrderStatus, TrayPaymentMethodMessage, TrayPaymentsNotification, TrayOrderUrls, TrayCustomer, TrayPayment;

type
  TListaProductsSold = TObjectList<TTrayProductsSold>;
  TListaPayment = TObjectList<TTrayPayment>;
  TTrayOrder = class
  private
    FStatus: string;
    FId: string;
    FDate: string;
    FHour: string;
    FCustomerId: string;
    FPartialTotal: string;
    FTaxes: string;
    FDiscount: string;
    FPointSale: string;
    FShipment: string;
    FShipmentValue: string;
    FShipmentDate: string;
    FDelivered: string;
    FDeliveredStatus: string;
    FShippingCancelled: string;
    FStoreNote: string;
    FCustomerNote: string;
    FPartnerId: string;
    FDiscountCoupon: string;
    FClientIp: string;
    FPaymentMethodRate: string;
    FInstallment: string;
    FValue1: string;
    FSendingCode: string;
    FSendingDate: string;
    FBillingAddress: string;
    FDeliveryTime: string;
    FPaymentMethodId: string;
    FPaymentMethod: string;
    FSessionId: string;
    FTotal: string;
    FPaymentDate: string;
    FAccessCode: string;
    FShipmentIntegrator: string;
    FModified: string;
    FPrinted: string;
    FInterest: string;
    FCartAdditionalValuesDiscount: string;
    FCartAdditionalValuesIncrease: string;
    FIdQuotation: string;
    FEstimatedDeliveryDate: string;
    FIsTraceable: string;
    FExternalCode: string;
    FTrackingUrl: string;
    FHasPayment: string;
    FHasShipment: string;
    FHasInvoice: string;
    FDeliveryDate: string;
    FTotalComissionUser: string;
    FTotalComission: string;
    FCost: string;
    FAppId: string;
    FStoreSegment: string;
    FPaymentMethodType: string;
    FInterestPaidBy: string;
    FPartnerName: string;
    FOrderStatus: TTrayOrderStatus;       // External type, name unchanged
    FCustomer: TTrayCustomer;           // External type, name unchanged
    FProductsSold: TListaProductsSold;
    FPayments: TListaPayment;
    FOrderTransactions: TObjectList<TTrayOrderTransaction>;
    FPaymentMethodMessage: TTrayPaymentMethodMessage;
    FPaymentsNotification: TTrayPaymentsNotification;
    FUrls: TTrayOrderUrls;
  public
    property Status: string read FStatus write FStatus;
    property Id: string read FId write FId;
    property Date: string read FDate write FDate;
    property Hour: string read FHour write FHour;
    property CustomerId: string read FCustomerId write FCustomerId;
    property PartialTotal: string read FPartialTotal write FPartialTotal;
    property Taxes: string read FTaxes write FTaxes;
    property Discount: string read FDiscount write FDiscount;
    property PointSale: string read FPointSale write FPointSale;
    property Shipment: string read FShipment write FShipment;
    property ShipmentValue: string read FShipmentValue write FShipmentValue;
    property ShipmentDate: string read FShipmentDate write FShipmentDate;
    property Delivered: string read FDelivered write FDelivered;
    property DeliveredStatus: string read FDeliveredStatus write FDeliveredStatus;
    property ShippingCancelled: string read FShippingCancelled write FShippingCancelled;
    property StoreNote: string read FStoreNote write FStoreNote;
    property CustomerNote: string read FCustomerNote write FCustomerNote;
    property PartnerId: string read FPartnerId write FPartnerId;
    property DiscountCoupon: string read FDiscountCoupon write FDiscountCoupon;
    property ClientIp: string read FClientIp write FClientIp;
    property PaymentMethodRate: string read FPaymentMethodRate write FPaymentMethodRate;
    property Installment: string read FInstallment write FInstallment;
    property Value1: string read FValue1 write FValue1; // Corresponds to 'value_1' in JSON
    property SendingCode: string read FSendingCode write FSendingCode;
    property SendingDate: string read FSendingDate write FSendingDate;
    property BillingAddress: string read FBillingAddress write FBillingAddress;
    property DeliveryTime: string read FDeliveryTime write FDeliveryTime;
    property PaymentMethodId: string read FPaymentMethodId write FPaymentMethodId;
    property PaymentMethod: string read FPaymentMethod write FPaymentMethod;
    property SessionId: string read FSessionId write FSessionId;
    property Total: string read FTotal write FTotal;
    property PaymentDate: string read FPaymentDate write FPaymentDate;
    property AccessCode: string read FAccessCode write FAccessCode;
    property ShipmentIntegrator: string read FShipmentIntegrator write FShipmentIntegrator;
    property Modified: string read FModified write FModified;
    property Printed: string read FPrinted write FPrinted;
    property Interest: string read FInterest write FInterest;
    property CartAdditionalValuesDiscount: string read FCartAdditionalValuesDiscount write FCartAdditionalValuesDiscount;
    property CartAdditionalValuesIncrease: string read FCartAdditionalValuesIncrease write FCartAdditionalValuesIncrease;
    property IdQuotation: string read FIdQuotation write FIdQuotation;
    property EstimatedDeliveryDate: string read FEstimatedDeliveryDate write FEstimatedDeliveryDate;
    property IsTraceable: string read FIsTraceable write FIsTraceable;
    property ExternalCode: string read FExternalCode write FExternalCode;
    property TrackingUrl: string read FTrackingUrl write FTrackingUrl;
    property HasPayment: string read FHasPayment write FHasPayment;
    property HasShipment: string read FHasShipment write FHasShipment;
    property HasInvoice: string read FHasInvoice write FHasInvoice;
    property DeliveryDate: string read FDeliveryDate write FDeliveryDate;
    property TotalComissionUser: string read FTotalComissionUser write FTotalComissionUser;
    property TotalComission: string read FTotalComission write FTotalComission;
    property Cost: string read FCost write FCost;
    property AppId: string read FAppId write FAppId;
    property StoreSegment: string read FStoreSegment write FStoreSegment;
    property PaymentMethodType: string read FPaymentMethodType write FPaymentMethodType;
    property InterestPaidBy: string read FInterestPaidBy write FInterestPaidBy;
    property PartnerName: string read FPartnerName write FPartnerName;
    property OrderStatus: TTrayOrderStatus read FOrderStatus write FOrderStatus;
    property Customer: TTrayCustomer read FCustomer write FCustomer;
    property ProductsSold: TListaProductsSold read FProductsSold write FProductsSold;
    property Payments: TListaPayment read FPayments write FPayments;
    property OrderTransactions: TObjectList<TTrayOrderTransaction> read FOrderTransactions write FOrderTransactions;
    property PaymentMethodMessage: TTrayPaymentMethodMessage read FPaymentMethodMessage write FPaymentMethodMessage;
    property PaymentsNotification: TTrayPaymentsNotification read FPaymentsNotification write FPaymentsNotification;
    property Urls: TTrayOrderUrls read FUrls write FUrls;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayOrder }

constructor TTrayOrder.Create;
begin
  inherited;
  FOrderStatus := TTrayOrderStatus.Create; // Assumes TTrayOrderStatus has Create and FromJSON/ToJSON
  FCustomer := TTrayCustomer.Create;       // Assumes TTrayCustomer has Create and FromJSON/ToJSON
  FProductsSold :=TListaProductsSold.Create(True);
  FPayments := TListaPayment.Create(True);
  FOrderTransactions := TObjectList<TTrayOrderTransaction>.Create(True);
  FPaymentMethodMessage := TTrayPaymentMethodMessage.Create;
  FPaymentsNotification := TTrayPaymentsNotification.Create;
  FUrls := TTrayOrderUrls.Create;
end;

destructor TTrayOrder.Destroy;
begin
  FOrderStatus.Free;
  FCustomer.Free;
  FProductsSold.Free;
  FPayments.Free;
  FOrderTransactions.Free;
  FPaymentMethodMessage.Free;
  FPaymentsNotification.Free;
  FUrls.Free;
  inherited;
end;

procedure TTrayOrder.FromJSON(AJson: TJSONObject);
var
  JsonValue, ItemValue, ProductJsonValue: TJSONValue; // Renamed inner JsonValue to ProductJsonValue for clarity
  JsonArray: TJSONArray;
  I: Integer;
  Product: TTrayProductsSold;
  PaymentWrapper: TTrayPaymentWrapper;
  Transaction: TTrayOrderTransaction;
begin
  if AJson.TryGetValue<string>('status', FStatus) then;
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('date', FDate) then;
  if AJson.TryGetValue<string>('hour', FHour) then;
  if AJson.TryGetValue<string>('customer_id', FCustomerId) then;
  if AJson.TryGetValue<string>('partial_total', FPartialTotal) then;
  if AJson.TryGetValue<string>('taxes', FTaxes) then;
  if AJson.TryGetValue<string>('discount', FDiscount) then;
  if AJson.TryGetValue<string>('point_sale', FPointSale) then;
  if AJson.TryGetValue<string>('shipment', FShipment) then;
  if AJson.TryGetValue<string>('shipment_value', FShipmentValue) then;
  if AJson.TryGetValue<string>('shipment_date', FShipmentDate) then;
  if AJson.TryGetValue<string>('delivered', FDelivered) then;
  if AJson.TryGetValue<string>('delivered_status', FDeliveredStatus) then;
  if AJson.TryGetValue<string>('shipping_cancelled', FShippingCancelled) then;
  if AJson.TryGetValue<string>('store_note', FStoreNote) then;
  if AJson.TryGetValue<string>('customer_note', FCustomerNote) then;
  if AJson.TryGetValue<string>('partner_id', FPartnerId) then;
  if AJson.TryGetValue<string>('discount_coupon', FDiscountCoupon) then;
  if AJson.TryGetValue<string>('client_ip', FClientIp) then;
  if AJson.TryGetValue<string>('payment_method_rate', FPaymentMethodRate) then;
  if AJson.TryGetValue<string>('installment', FInstallment) then;
  if AJson.TryGetValue<string>('value_1', FValue1) then; // JSON key is 'value_1'
  if AJson.TryGetValue<string>('sending_code', FSendingCode) then;
  if AJson.TryGetValue<string>('sending_date', FSendingDate) then;
  if AJson.TryGetValue<string>('billing_address', FBillingAddress) then;
  if AJson.TryGetValue<string>('delivery_time', FDeliveryTime) then;
  if AJson.TryGetValue<string>('payment_method_id', FPaymentMethodId) then;
  if AJson.TryGetValue<string>('payment_method', FPaymentMethod) then;
  if AJson.TryGetValue<string>('session_id', FSessionId) then;
  if AJson.TryGetValue<string>('total', FTotal) then;
  if AJson.TryGetValue<string>('payment_date', FPaymentDate) then;
  if AJson.TryGetValue<string>('access_code', FAccessCode) then;
  if AJson.TryGetValue<string>('shipment_integrator', FShipmentIntegrator) then;
  if AJson.TryGetValue<string>('modified', FModified) then;
  if AJson.TryGetValue<string>('printed', FPrinted) then;
  if AJson.TryGetValue<string>('interest', FInterest) then;
  if AJson.TryGetValue<string>('cart_additional_values_discount', FCartAdditionalValuesDiscount) then;
  if AJson.TryGetValue<string>('cart_additional_values_increase', FCartAdditionalValuesIncrease) then;
  if AJson.TryGetValue<string>('id_quotation', FIdQuotation) then;
  if AJson.TryGetValue<string>('estimated_delivery_date', FEstimatedDeliveryDate) then;
  if AJson.TryGetValue<string>('is_traceable', FIsTraceable) then;
  if AJson.TryGetValue<string>('external_code', FExternalCode) then;
  if AJson.TryGetValue<string>('tracking_url', FTrackingUrl) then;
  if AJson.TryGetValue<string>('has_payment', FHasPayment) then;
  if AJson.TryGetValue<string>('has_shipment', FHasShipment) then;
  if AJson.TryGetValue<string>('has_invoice', FHasInvoice) then;
  if AJson.TryGetValue<string>('delivery_date', FDeliveryDate) then;
  if AJson.TryGetValue<string>('total_comission_user', FTotalComissionUser) then;
  if AJson.TryGetValue<string>('total_comission', FTotalComission) then;
  if AJson.TryGetValue<string>('cost', FCost) then;
  if AJson.TryGetValue<string>('app_id', FAppId) then;
  if AJson.TryGetValue<string>('store_segment', FStoreSegment) then;
  if AJson.TryGetValue<string>('payment_method_type', FPaymentMethodType) then;
  if AJson.TryGetValue<string>('interest_paid_by', FInterestPaidBy) then;
  if AJson.TryGetValue<string>('partner_name', FPartnerName) then;

  // OrderStatus object
  if AJson.TryGetValue<TJSONValue>('OrderStatus', JsonValue) and (JsonValue is TJSONObject) then
    FOrderStatus.FromJSON(TJSONObject(JsonValue));

  // Customer object
  if AJson.TryGetValue<TJSONValue>('Customer', JsonValue) and (JsonValue is TJSONObject) then
    FCustomer.FromJSON(TJSONObject(JsonValue));

  // ProductsSold array
  if AJson.TryGetValue<TJSONValue>('ProductsSold', JsonValue) and (JsonValue is TJSONArray) then
  begin
    JsonArray := TJSONArray(JsonValue);
    for I := 0 to JsonArray.Count - 1 do
    begin
      ItemValue := JsonArray.Items[I];
      // Corrected logic for nested ProductsSold object
      if (ItemValue is TJSONObject) then
      begin
        if TJSONObject(ItemValue).TryGetValue<TJSONValue>('ProductsSold', ProductJsonValue) and (ProductJsonValue is TJSONObject) then
        begin
          Product := TTrayProductsSold.Create;
          Product.FromJSON(TJSONObject(ProductJsonValue));
          FProductsSold.Add(Product);
        end;
      end;
    end;
  end;

  // Payment array
  if AJson.TryGetValue<TJSONValue>('Payment', JsonValue) and (JsonValue is TJSONArray) then
  begin
    JsonArray := TJSONArray(JsonValue);
    for I := 0 to JsonArray.Count - 1 do
    begin
      ItemValue := JsonArray.Items[I];
      if ItemValue is TJSONObject then
      begin
        PaymentWrapper := TTrayPaymentWrapper.Create;
        PaymentWrapper.FromJSON(TJSONObject(ItemValue));
        FPayments.Add(PaymentWrapper.Payment);
      end;
    end;
  end;

  // OrderTransactions array
  if AJson.TryGetValue<TJSONValue>('OrderTransactions', JsonValue) and (JsonValue is TJSONArray) then
  begin
    JsonArray := TJSONArray(JsonValue);
    for I := 0 to JsonArray.Count - 1 do
    begin
      ItemValue := JsonArray.Items[I];
      if ItemValue is TJSONObject then
      begin
        Transaction := TTrayOrderTransaction.Create;
        Transaction.FromJSON(TJSONObject(ItemValue));
        FOrderTransactions.Add(Transaction);
      end;
    end;
  end;

  // PaymentMethodMessage object
  if AJson.TryGetValue<TJSONValue>('PaymentMethodMessage', JsonValue) and (JsonValue is TJSONObject) then
    FPaymentMethodMessage.FromJSON(TJSONObject(JsonValue));

  // payments_notification object
  if AJson.TryGetValue<TJSONValue>('payments_notification', JsonValue) and (JsonValue is TJSONObject) then
    FPaymentsNotification.FromJSON(TJSONObject(JsonValue));

  // urls object
  if AJson.TryGetValue<TJSONValue>('urls', JsonValue) and (JsonValue is TJSONObject) then
    FUrls.FromJSON(TJSONObject(JsonValue));
end;

function TTrayOrder.ToJSON: TJSONObject;
var
  I: Integer;
  ProductsArray, PaymentsArray, TransactionsArray: TJSONArray;
  ProductWrapperJSON: TJSONObject; // Renamed for clarity
begin
  Result := TJSONObject.Create;
  Result.AddPair('status', FStatus);
  Result.AddPair('id', FId);
  Result.AddPair('date', FDate);
  Result.AddPair('hour', FHour);
  Result.AddPair('customer_id', FCustomerId);
  Result.AddPair('partial_total', FPartialTotal);
  Result.AddPair('taxes', FTaxes);
  Result.AddPair('discount', FDiscount);
  Result.AddPair('point_sale', FPointSale);
  Result.AddPair('shipment', FShipment);
  Result.AddPair('shipment_value', FShipmentValue);
  Result.AddPair('shipment_date', FShipmentDate);
  Result.AddPair('delivered', FDelivered);
  Result.AddPair('delivered_status', FDeliveredStatus);
  Result.AddPair('shipping_cancelled', FShippingCancelled);
  Result.AddPair('store_note', FStoreNote);
  Result.AddPair('customer_note', FCustomerNote);
  Result.AddPair('partner_id', FPartnerId);
  Result.AddPair('discount_coupon', FDiscountCoupon);
  Result.AddPair('client_ip', FClientIp);
  Result.AddPair('payment_method_rate', FPaymentMethodRate);
  Result.AddPair('installment', FInstallment);
  Result.AddPair('value_1', FValue1);
  Result.AddPair('sending_code', FSendingCode);
  Result.AddPair('sending_date', FSendingDate);
  Result.AddPair('billing_address', FBillingAddress);
  Result.AddPair('delivery_time', FDeliveryTime);
  Result.AddPair('payment_method_id', FPaymentMethodId);
  Result.AddPair('payment_method', FPaymentMethod);
  Result.AddPair('session_id', FSessionId);
  Result.AddPair('total', FTotal);
  Result.AddPair('payment_date', FPaymentDate);
  Result.AddPair('access_code', FAccessCode);
  Result.AddPair('shipment_integrator', FShipmentIntegrator);
  Result.AddPair('modified', FModified);
  Result.AddPair('printed', FPrinted);
  Result.AddPair('interest', FInterest);
  Result.AddPair('cart_additional_values_discount', FCartAdditionalValuesDiscount);
  Result.AddPair('cart_additional_values_increase', FCartAdditionalValuesIncrease);
  Result.AddPair('id_quotation', FIdQuotation);
  Result.AddPair('estimated_delivery_date', FEstimatedDeliveryDate);
  Result.AddPair('is_traceable', FIsTraceable);
  Result.AddPair('external_code', FExternalCode);
  Result.AddPair('tracking_url', FTrackingUrl);
  Result.AddPair('has_payment', FHasPayment);
  Result.AddPair('has_shipment', FHasShipment);
  Result.AddPair('has_invoice', FHasInvoice);
  Result.AddPair('delivery_date', FDeliveryDate);
  Result.AddPair('total_comission_user', FTotalComissionUser);
  Result.AddPair('total_comission', FTotalComission);
  Result.AddPair('cost', FCost);
  Result.AddPair('app_id', FAppId);
  Result.AddPair('store_segment', FStoreSegment);
  Result.AddPair('payment_method_type', FPaymentMethodType);
  Result.AddPair('interest_paid_by', FInterestPaidBy);
  Result.AddPair('partner_name', FPartnerName);

  // OrderStatus object
  Result.AddPair('OrderStatus', FOrderStatus.ToJSON);

  // Customer object
  Result.AddPair('Customer', FCustomer.ToJSON);

  // ProductsSold array
  ProductsArray := TJSONArray.Create;
  for I := 0 to FProductsSold.Count - 1 do
  begin
    ProductWrapperJSON := TJSONObject.Create;
    ProductWrapperJSON.AddPair('ProductsSold', FProductsSold[I].ToJSON);
    ProductsArray.AddElement(ProductWrapperJSON);
  end;
  Result.AddPair('ProductsSold', ProductsArray);

  // Payment array
  PaymentsArray := TJSONArray.Create;
  for I := 0 to FPayments.Count - 1 do
    PaymentsArray.AddElement(FPayments[I].ToJSON);
  Result.AddPair('Payment', PaymentsArray);

  // OrderTransactions array
  TransactionsArray := TJSONArray.Create;
  for I := 0 to FOrderTransactions.Count - 1 do
    TransactionsArray.AddElement(FOrderTransactions[I].ToJSON);
  Result.AddPair('OrderTransactions', TransactionsArray);

  // PaymentMethodMessage object
  Result.AddPair('PaymentMethodMessage', FPaymentMethodMessage.ToJSON);

  // payments_notification object
  Result.AddPair('payments_notification', FPaymentsNotification.ToJSON);

  // urls object
  Result.AddPair('urls', FUrls.ToJSON);
end;

end.
