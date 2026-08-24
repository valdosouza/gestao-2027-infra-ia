unit TrayOrderWrapper;

interface

uses
      System.SysUtils, System.Classes, System.JSON, TrayOrder;

type
  TTrayOrderWrapper = class
  private
    FOrder: TTrayOrder;
  public
    property Order: TTrayOrder read FOrder write FOrder;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJsonStr: string); overload;
    procedure FromJSON(AJson: TJSONObject); overload;
    function ToJSON: TJSONObject;
    function ToJSONString: string;
  end;

implementation

{ TTrayOrderWrapper }

constructor TTrayOrderWrapper.Create;
begin
  inherited;
  FOrder := TTrayOrder.Create;
end;

destructor TTrayOrderWrapper.Destroy;
begin
  FOrder.Free;
  inherited;
end;

procedure TTrayOrderWrapper.FromJSON(AJsonStr: string);
var
  JsonValue: TJSONValue;
begin
  JsonValue := TJSONObject.ParseJSONValue(AJsonStr);
  try
    if JsonValue is TJSONObject then
      FromJSON(TJSONObject(JsonValue));
  finally
    JsonValue.Free;
  end;
end;

procedure TTrayOrderWrapper.FromJSON(AJson: TJSONObject);
var
  OrderNode: TJSONValue;
begin
  // Verifica se o objeto JSON raiz contém uma chave "Order"
  if AJson.TryGetValue('Order', OrderNode) and (OrderNode is TJSONObject) then
  begin
    // Se sim, popula FOrder a partir deste sub-objeto "Order"
    Self.FOrder.FromJSON(OrderNode as TJSONObject);
  end
  else
  begin
    // Se não houver a chave "Order", assume que o pr�prio objeto JSON raiz s�o os dados do pedido
    Self.FOrder.FromJSON(AJson);
  end;
end;

function TTrayOrderWrapper.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Order', FOrder.ToJSON);
end;

function TTrayOrderWrapper.ToJSONString: string;
var
  Json: TJSONObject;
begin
  Json := ToJSON;
  try
    Result := Json.ToString;
  finally
    Json.Free;
  end;
end;

end.
