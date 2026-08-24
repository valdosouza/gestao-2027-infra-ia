unit TrayCustomerAddressWrapper;

interface

uses
      System.SysUtils, System.Classes, System.JSON, TrayCustomerAddress;

type

  TTrayCustomerAddressWrapper = class
  private
    FCustomerAddress: TTrayCustomerAddress;
  public
    property CustomerAddress: TTrayCustomerAddress read FCustomerAddress write FCustomerAddress;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation


{ TTrayCustomerAddressWrapper }

constructor TTrayCustomerAddressWrapper.Create;
begin
  inherited;
  FCustomerAddress := TTrayCustomerAddress.Create; // Assumes TTrayCustomerAddress has a parameterless constructor
end;

destructor TTrayCustomerAddressWrapper.Destroy;
begin
  FCustomerAddress.Free;
  inherited;
end;

procedure TTrayCustomerAddressWrapper.FromJSON(AJson: TJSONObject);
var
  JsonValue: TJSONValue;
begin
  if AJson.TryGetValue<TJSONValue>('CustomerAddress', JsonValue) and (JsonValue is TJSONObject) then
    FCustomerAddress.FromJSON(TJSONObject(JsonValue)); // Assumes TTrayCustomerAddress has FromJSON
end;

function TTrayCustomerAddressWrapper.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('CustomerAddress', FCustomerAddress.ToJSON); // Assumes TTrayCustomerAddress has ToJSON
end;

end.
