unit trayThumbs;

interface

uses
      System.SysUtils, System.Classes, System.JSON, TrayThumb;

type
  TTrayThumbs = class
  private
    FThumb30: TTrayThumb; // Renamed F30 to FThumb30 for clarity, maps to JSON '30'
    FThumb90: TTrayThumb; // Renamed F90 to FThumb90, maps to JSON '90'
    FThumb180: TTrayThumb; // Renamed F180 to FThumb180, maps to JSON '180'
  public
    property Thumb30: TTrayThumb read FThumb30 write FThumb30;
    property Thumb90: TTrayThumb read FThumb90 write FThumb90;
    property Thumb180: TTrayThumb read FThumb180 write FThumb180;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayThumbs }

constructor TTrayThumbs.Create;
begin
  inherited;
  FThumb30 := TTrayThumb.Create;
  FThumb90 := TTrayThumb.Create;
  FThumb180 := TTrayThumb.Create;
end;

destructor TTrayThumbs.Destroy;
begin
  FThumb30.Free;
  FThumb90.Free;
  FThumb180.Free;
  inherited;
end;

procedure TTrayThumbs.FromJSON(AJson: TJSONObject);
var
  JsonValue: TJSONValue;
begin
  if AJson.TryGetValue<TJSONValue>('30', JsonValue) and (JsonValue is TJSONObject) then
    FThumb30.FromJSON(TJSONObject(JsonValue));

  if AJson.TryGetValue<TJSONValue>('90', JsonValue) and (JsonValue is TJSONObject) then
    FThumb90.FromJSON(TJSONObject(JsonValue));

  if AJson.TryGetValue<TJSONValue>('180', JsonValue) and (JsonValue is TJSONObject) then
    FThumb180.FromJSON(TJSONObject(JsonValue));
end;

function TTrayThumbs.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('30', FThumb30.ToJSON);
  Result.AddPair('90', FThumb90.ToJSON);
  Result.AddPair('180', FThumb180.ToJSON);
end;

end.
