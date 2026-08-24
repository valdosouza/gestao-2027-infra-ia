unit TrayPayment;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayPayment = class
  private
    FCreated: string;
    FModified: string;
    FId: string;
    FOrderId: string;
    FPaymentMethodId: string;
    FMethod: string;
    FPaymentPlace: string;
    FValue: string;
    FDate: string;
    FNote: string;
    FUniqueNumber: string;
  public
    property Created: string read FCreated write FCreated;
    property Modified: string read FModified write FModified;
    property Id: string read FId write FId;
    property OrderId: string read FOrderId write FOrderId;
    property PaymentMethodId: string read FPaymentMethodId write FPaymentMethodId;
    property Method: string read FMethod write FMethod;
    property PaymentPlace: string read FPaymentPlace write FPaymentPlace;
    property Value: string read FValue write FValue;
    property Date: string read FDate write FDate;
    property Note: string read FNote write FNote;
    property UniqueNumber: string read FUniqueNumber write FUniqueNumber;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayPayment }

constructor TTrayPayment.Create;
begin
  inherited;
end;

destructor TTrayPayment.Destroy;
begin
  inherited;
end;

procedure TTrayPayment.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('created', FCreated) then;
  if AJson.TryGetValue<string>('modified', FModified) then;
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('order_id', FOrderId) then;
  if AJson.TryGetValue<string>('payment_method_id', FPaymentMethodId) then;
  if AJson.TryGetValue<string>('method', FMethod) then;
  if AJson.TryGetValue<string>('payment_place', FPaymentPlace) then;
  if AJson.TryGetValue<string>('value', FValue) then;
  if AJson.TryGetValue<string>('date', FDate) then;
  if AJson.TryGetValue<string>('note', FNote) then;
  if AJson.TryGetValue<string>('unique_number', FUniqueNumber) then;
end;

function TTrayPayment.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('created', FCreated);
  Result.AddPair('modified', FModified);
  Result.AddPair('id', FId);
  Result.AddPair('order_id', FOrderId);
  Result.AddPair('payment_method_id', FPaymentMethodId);
  Result.AddPair('method', FMethod);
  Result.AddPair('payment_place', FPaymentPlace);
  Result.AddPair('value', FValue);
  Result.AddPair('date', FDate);
  Result.AddPair('note', FNote);
  Result.AddPair('unique_number', FUniqueNumber);
end;

end.
