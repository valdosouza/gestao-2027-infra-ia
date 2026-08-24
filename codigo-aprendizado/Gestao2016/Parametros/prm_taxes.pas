unit prm_taxes;

interface

uses
      prm_dsk_base, tblTaxes, System.SysUtils;

Type
  TPrmTaxes = class(TPrmDskBase)
  private
    FFieldName: TTaxes;
    procedure setFFieldName(const Value: TTaxes);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TTaxes read FFieldName write setFFieldName;
  end;

implementation

{ TPrmTaxes }

procedure TPrmTaxes.Clear;
begin
  inherited;
  clearObj(FFieldName);
end;

constructor TPrmTaxes.Create;
begin
  inherited;
  FFieldName := TTaxes.Create;
end;

destructor TPrmTaxes.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxes.setFFieldName(const Value: TTaxes);
begin
  FFieldName := Value;
end;

end.
