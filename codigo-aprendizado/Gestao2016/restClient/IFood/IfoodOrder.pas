unit IfoodOrder;

interface

uses     IfoodCoordinates, IfoodAddress, IfoodCustomer, IfoodMerchant, IfoodPayments, IfoodItem, System.Generics.Collections, IfoodDeliveryAddress, System.SysUtils;

Type
  TListaItem = TObjectList<TIFoodItem>;
  TListaPayments = TObjectList<TIFoodPayments>;

  TIfoodOrder = Class
  private
    Fpayments: TListaPayments;
    FdeliveryDateTime: String;
    FsubTotal: String;
    Fcustomer: TIFoodCustomer;
    Ftype_: String;
    Fitems: TListaItem;
    FdeliveryAddress: TIfoodDeliveryAddress;
    FshortReference: String;
    Fid: String;
    FtotalPrice: String;
    FcreatedAt: String;
    FpreparationTimeInSeconds: String;
    FdeliveryFee: String;
    Freference: String;
    Fmerchant: TIfoodMerchant;
    procedure setFcreatedAt(const Value: String);
    procedure setFcustomer(const Value: TIFoodCustomer);
    procedure setFdeliveryAddress(const Value: TIfoodDeliveryAddress);
    procedure setFdeliveryDateTime(const Value: String);
    procedure setFdeliveryFee(const Value: String);
    procedure setFid(const Value: String);
    procedure setFItem(const Value: TListaItem);
    procedure setFmerchant(const Value: TIfoodMerchant);
    procedure setFpayments(const Value: TListaPayments);
    procedure setFpreparationTimeInSeconds(const Value: String);
    procedure setFreference(const Value: String);
    procedure setFshortReference(const Value: String);
    procedure setFsubTotal(const Value: String);
    procedure setFtotalPrice(const Value: String);
    procedure setFtype_(const Value: String);

  public
    constructor Create;
    destructor Destroy;

    property id             : String read Fid write setFid;
    property reference      : String read Freference write setFreference;
    property shortReference : String read FshortReference write setFshortReference;
    property createdAt      : String read FcreatedAt write setFcreatedAt;
    property type_          : String read Ftype_ write setFtype_;
    property merchant       : TIfoodMerchant read Fmerchant write setFmerchant;
    property payments       : TListaPayments read Fpayments write setFpayments;
    property customer       : TIFoodCustomer read Fcustomer write setFcustomer;
    property items          : TListaItem read Fitems write setFItem;
    property subTotal       : String read FsubTotal write setFsubTotal;
    property totalPrice     : String read FtotalPrice write setFtotalPrice;
    property deliveryFee    : String read FdeliveryFee write setFdeliveryFee;
    property deliveryAddress : TIfoodDeliveryAddress read FdeliveryAddress write setFdeliveryAddress;
    property deliveryDateTime : String read FdeliveryDateTime write setFdeliveryDateTime;
    property preparationTimeInSeconds : String read FpreparationTimeInSeconds write setFpreparationTimeInSeconds;


  End;

implementation

{ TIfoodOrder }

constructor TIfoodOrder.Create;
begin
  Fpayments := TListaPayments.Create;
  Fcustomer := TIFoodCustomer.Create;
  Fitems    := TListaItem.Create;
  FdeliveryAddress  := TIfoodDeliveryAddress.Create;
  Fmerchant := TIfoodMerchant.Create;
end;

destructor TIfoodOrder.Destroy;
begin
  FreeAndNil(Fpayments);
  FreeAndNil(Fcustomer);
  FreeAndNil(Fitems);
  FreeAndNil(FdeliveryAddress);
  FreeAndNil(Fmerchant);
end;


procedure TIfoodOrder.setFcreatedAt(const Value: String);
begin
  FcreatedAt := Value;
end;

procedure TIfoodOrder.setFcustomer(const Value: TIFoodCustomer);
begin
  Fcustomer := Value;
end;

procedure TIfoodOrder.setFdeliveryAddress(const Value: TIfoodDeliveryAddress);
begin
  FdeliveryAddress := Value;
end;

procedure TIfoodOrder.setFdeliveryDateTime(const Value: String);
begin
  FdeliveryDateTime := Value;
end;

procedure TIfoodOrder.setFdeliveryFee(const Value: String);
begin
  FdeliveryFee := Value;
end;

procedure TIfoodOrder.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TIfoodOrder.setFItem(const Value: TListaItem);
begin
  Fitems := Value;
end;

procedure TIfoodOrder.setFmerchant(const Value: TIfoodMerchant);
begin
  Fmerchant := Value;
end;

procedure TIfoodOrder.setFpayments(const Value: TListaPayments);
begin
  Fpayments := Value;
end;

procedure TIfoodOrder.setFpreparationTimeInSeconds(const Value: String);
begin
  FpreparationTimeInSeconds := Value;
end;

procedure TIfoodOrder.setFreference(const Value: String);
begin
  Freference := Value;
end;

procedure TIfoodOrder.setFshortReference(const Value: String);
begin
  FshortReference := Value;
end;

procedure TIfoodOrder.setFsubTotal(const Value: String);
begin
  FsubTotal := Value;
end;

procedure TIfoodOrder.setFtotalPrice(const Value: String);
begin
  FtotalPrice := Value;
end;

procedure TIfoodOrder.setFtype_(const Value: String);
begin
  Ftype_ := Value;
end;

end.
