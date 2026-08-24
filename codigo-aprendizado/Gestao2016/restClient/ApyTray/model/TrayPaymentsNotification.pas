unit TrayPaymentsNotification;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayPaymentsNotification = class
  private
    FNotification: string;
  public
    property Notification: string read FNotification write FNotification;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayPaymentsNotification }

constructor TTrayPaymentsNotification.Create;
begin
  inherited;
end;

destructor TTrayPaymentsNotification.Destroy;
begin
  inherited;
end;

procedure TTrayPaymentsNotification.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('notification', FNotification) then;
end;

function TTrayPaymentsNotification.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('notification', FNotification);
end;

end.
