unit tblDfeResumoNfe;

interface

Uses
      SysUtils, Classes, GenericEntity, CAtribEntity;

type
  [TableName('DFE_RESUMO_NFE')]
  TDfeResumoNfe = class(TGenericEntity)
  private
    FNSU: String;
    FChdfe: String;
    FCnpjCpf: String;
    FXNome: String;
    FIE: String;
    FDhEmi: TDateTime;
    FTpnf: String;
    FVnf: Double;
    FCsitDfe: String;

    procedure SetNSU(const Value: String);
    procedure SetChdfe(const Value: String);
    procedure SetCnpjCpf(const Value: String);
    procedure SetXNome(const Value: String);
    procedure SetIE(const Value: String);
    procedure SetDhEmi(const Value: TDateTime);
    procedure SetTpnf(const Value: String);
    procedure SetVnf(const Value: Double);
    procedure SetCsitDfe(const Value: String);

  public
    [KeyField('NSU')]
    [FieldName('NSU')]
    property NSU: String read FNSU write SetNSU;

    [FieldName('CHDFE')]
    property Chdfe: String read FChdfe write SetChdfe;

    [FieldName('CNPJCPF')]
    property CnpjCpf: String read FCnpjCpf write SetCnpjCpf;

    [FieldName('XNOME')]
    property XNome: String read FXNome write SetXNome;

    [FieldName('IE')]
    property IE: String read FIE write SetIE;

    [FieldName('DHEMI')]
    property DhEmi: TDateTime read FDhEmi write SetDhEmi;

    [FieldName('TPNF')]
    property Tpnf: String read FTpnf write SetTpnf;

    [FieldName('VNF')]
    property Vnf: Double read FVnf write SetVnf;

    [FieldName('CSITDFE')]
    property CsitDfe: String read FCsitDfe write SetCsitDfe;
  end;

implementation

{ TDfeResumoNfe }

procedure TDfeResumoNfe.SetChdfe(const Value: String);
begin
  FChdfe := Value;
end;

procedure TDfeResumoNfe.SetCnpjCpf(const Value: String);
begin
  FCnpjCpf := Value;
end;

procedure TDfeResumoNfe.SetCsitDfe(const Value: String);
begin
  FCsitDfe := Value;
end;

procedure TDfeResumoNfe.SetDhEmi(const Value: TDateTime);
begin
  FDhEmi := Value;
end;

procedure TDfeResumoNfe.SetIE(const Value: String);
begin
  FIE := Value;
end;

procedure TDfeResumoNfe.SetNSU(const Value: String);
begin
  FNSU := Value;
end;

procedure TDfeResumoNfe.SetTpnf(const Value: String);
begin
  FTpnf := Value;
end;

procedure TDfeResumoNfe.SetVnf(const Value: Double);
begin
  FVnf := Value;
end;

procedure TDfeResumoNfe.SetXNome(const Value: String);
begin
  FXNome := Value;
end;

end.

