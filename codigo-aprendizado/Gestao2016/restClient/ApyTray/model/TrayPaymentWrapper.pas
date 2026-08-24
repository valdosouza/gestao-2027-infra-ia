unit TrayPaymentWrapper;

interface

uses
      System.SysUtils, System.Classes, System.JSON, TrayPayment;

type
  TTrayPaymentWrapper = class
  private
    FPayment: TTrayPayment;
  public
    property Payment: TTrayPayment read FPayment write FPayment;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayPaymentWrapper }

constructor TTrayPaymentWrapper.Create;
begin
  inherited;
  FPayment := TTrayPayment.Create;
end;

destructor TTrayPaymentWrapper.Destroy;
begin
  FPayment.Free;
  inherited;
end;

procedure TTrayPaymentWrapper.FromJSON(AJson: TJSONObject);
var
  JsonValue: TJSONValue;
begin
  if AJson.TryGetValue<TJSONValue>('Payment', JsonValue) and (JsonValue is TJSONObject) then
    FPayment.FromJSON(TJSONObject(JsonValue));
end;

function TTrayPaymentWrapper.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Payment', FPayment.ToJSON);
end;

end.
