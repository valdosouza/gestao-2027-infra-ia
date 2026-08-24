unit trayStock;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayStock = class
  private
    FId: string;
    FName: string;
  public
    property Id: string read FId write FId;
    property Name: string read FName write FName;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayStock }

constructor TTrayStock.Create;
begin
  inherited;
end;

destructor TTrayStock.Destroy;
begin
  inherited;
end;

procedure TTrayStock.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('name', FName) then;
end;

function TTrayStock.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('id', FId);
  Result.AddPair('name', FName);
end;

end.
