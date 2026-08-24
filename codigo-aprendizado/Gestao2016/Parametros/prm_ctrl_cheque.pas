unit prm_ctrl_cheque;

interface

uses
      prm_dsk_base, tblCheque, System.SysUtils;

Type
  TPrmCtrlCheque = class(TPrmDskBase)
  private
    FFieldName: TCheque;
    procedure setFFieldName(const Value: TCheque);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TCheque read FFieldName write setFFieldName;
  end;

implementation

{ TPrmCtrlCheque }

procedure TPrmCtrlCheque.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCtrlCheque.Create;
begin
  inherited;
  FFieldName := TCheque.Create;
end;

destructor TPrmCtrlCheque.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCtrlCheque.setFFieldName(const Value: TCheque);
begin
  FFieldName := Value;
end;

end.
