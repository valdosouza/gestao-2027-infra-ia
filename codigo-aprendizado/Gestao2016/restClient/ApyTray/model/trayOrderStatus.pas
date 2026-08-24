unit trayOrderStatus;

interface

uses
      System.JSON;

type
  TTrayOrderStatus = class
  private
    FId: string;
    FDefault: string;
    FType: string;
    FShowBackoffice: string;
    FAllowEditOrder: string;
    FDescription: string;
    FStatus: string;
    FShowStatusCentral: string;
    FBackground: string;
    FDisplayName: string;
    FFontColor: string;
  public
    property Id: string read FId write FId;
    property Default: string read FDefault write FDefault;
    property StatusType: string read FType write FType;
    property ShowBackoffice: string read FShowBackoffice write FShowBackoffice;
    property AllowEditOrder: string read FAllowEditOrder write FAllowEditOrder;
    property Description: string read FDescription write FDescription;
    property Status: string read FStatus write FStatus;
    property ShowStatusCentral: string read FShowStatusCentral write FShowStatusCentral;
    property Background: string read FBackground write FBackground;
    property DisplayName: string read FDisplayName write FDisplayName;
    property FontColor: string read FFontColor write FFontColor;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayOrderStatus }

constructor TTrayOrderStatus.Create;
begin
  inherited;
end;

destructor TTrayOrderStatus.Destroy;
begin
  inherited;
end;

procedure TTrayOrderStatus.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('default', FDefault) then;
  if AJson.TryGetValue<string>('type', FType) then;
  if AJson.TryGetValue<string>('show_backoffice', FShowBackoffice) then;
  if AJson.TryGetValue<string>('allow_edit_order', FAllowEditOrder) then;
  if AJson.TryGetValue<string>('description', FDescription) then;
  if AJson.TryGetValue<string>('status', FStatus) then;
  if AJson.TryGetValue<string>('show_status_central', FShowStatusCentral) then;
  if AJson.TryGetValue<string>('background', FBackground) then;
  if AJson.TryGetValue<string>('display_name', FDisplayName) then;
  if AJson.TryGetValue<string>('font_color', FFontColor) then;
end;

function TTrayOrderStatus.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('id', FId);
  Result.AddPair('default', FDefault);
  Result.AddPair('type', FType);
  Result.AddPair('show_backoffice', FShowBackoffice);
  Result.AddPair('allow_edit_order', FAllowEditOrder);
  Result.AddPair('description', FDescription);
  Result.AddPair('status', FStatus);
  Result.AddPair('show_status_central', FShowStatusCentral);
  Result.AddPair('background', FBackground);
  Result.AddPair('display_name', FDisplayName);
  Result.AddPair('font_color', FFontColor);
end;

end.
