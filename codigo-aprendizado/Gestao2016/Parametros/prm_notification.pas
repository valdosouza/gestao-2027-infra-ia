unit prm_notification;

interface

uses
      prm_dsk_base, tblNotification, System.SysUtils;

Type
  TPrmNotification = class(TPrmDskBase)
  private
    FFieldName: TNotification;
    procedure setFFieldName(const Value: TNotification);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TNotification read FFieldName write setFFieldName;
  end;


implementation

{ TPrmNotification }

procedure TPrmNotification.Clear;
begin
  inherited;
  clearObj(FFieldName);
end;

constructor TPrmNotification.Create;
begin
  FFieldName := TNotification.Create;
end;

destructor TPrmNotification.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmNotification.setFFieldName(const Value: TNotification);
begin
  FFieldName := Value;
end;

end.
