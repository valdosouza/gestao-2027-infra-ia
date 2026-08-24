unit trayProductSoldImage;

interface

uses
      System.SysUtils, System.Classes, System.JSON, TrayThumbs;

type
  TTrayProductSoldImage = class
  private
    FHttp: string;
    FHttps: string;
    FThumbs: TTrayThumbs;
  public
    property Http: string read FHttp write FHttp;
    property Https: string read FHttps write FHttps;
    property Thumbs: TTrayThumbs read FThumbs write FThumbs;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayProductSoldImage }

constructor TTrayProductSoldImage.Create;
begin
  inherited;
  FThumbs := TTrayThumbs.Create;
end;

destructor TTrayProductSoldImage.Destroy;
begin
  FThumbs.Free;
  inherited;
end;

procedure TTrayProductSoldImage.FromJSON(AJson: TJSONObject);
var
  JsonValue: TJSONValue;
begin
  if AJson.TryGetValue<string>('http', FHttp) then;
  if AJson.TryGetValue<string>('https', FHttps) then;

  if AJson.TryGetValue<TJSONValue>('thumbs', JsonValue) and (JsonValue is TJSONObject) then
    FThumbs.FromJSON(TJSONObject(JsonValue));
end;

function TTrayProductSoldImage.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('http', FHttp);
  Result.AddPair('https', FHttps);
  Result.AddPair('thumbs', FThumbs.ToJSON);
end;

end.
