unit TrayOrderUrls;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayOrderUrls = class
  private
    FPayment: string;
  public
    property Payment: string read FPayment write FPayment;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayOrderUrls }

constructor TTrayOrderUrls.Create;
begin
  inherited;
end;

destructor TTrayOrderUrls.Destroy;
begin
  inherited;
end;

procedure TTrayOrderUrls.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('payment', FPayment) then;
end;

function TTrayOrderUrls.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('payment', FPayment);
end;

end.
