unit trayUrl;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayUrl = class
  private
    FHttp: string;
    FHttps: string;
  public
    property Http: string read FHttp write FHttp;
    property Https: string read FHttps write FHttps;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayUrl }

constructor TTrayUrl.Create;
begin
  inherited;
end;

destructor TTrayUrl.Destroy;
begin
  inherited;
end;

procedure TTrayUrl.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('http', FHttp) then;
  if AJson.TryGetValue<string>('https', FHttps) then;
end;

function TTrayUrl.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('http', FHttp);
  Result.AddPair('https', FHttps);
end;

end.
