unit prm_general_taxes;

interface

uses
      prm_dsk_base, tblImpostos, System.SysUtils;

Type
  TPrmGeneralTaxes = class(TPrmDskBase)
  private
    FFieldName: TImpostos;
    procedure setFFieldName(const Value: TImpostos);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TImpostos read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmGeneralTaxes.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmGeneralTaxes.Create;
begin
  inherited;
  FFieldName := TImpostos.Create;
end;

destructor TPrmGeneralTaxes.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmGeneralTaxes.setFFieldName(const Value: TImpostos);
begin
  FFieldName := Value;
end;

end.
