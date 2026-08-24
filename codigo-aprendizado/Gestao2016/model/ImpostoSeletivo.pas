unit ImpostoSeletivo;

interface

uses
      GenericEntity, CAtribEntity;

type
  // nome da classe de entidade
  [TableName('TB_IMPOSTO_SELETIVO')]
  TImpostoSeletivo = class(TGenericEntity)
  private
    FCSTIS: string;           // UB02: Código de Situção Tribut�ria do Imposto Seletivo
    FcClassTribIS: string;    // UB03: Código de Classificção Tribut�ria do Imposto Seletivo
    FvBCIS: Currency;         // UB05: Valor da Base de Cálculo do Imposto Seletivo
    FpIS: Double;             // UB06: Alíquota do Imposto Seletivo
    FpISEspec: Double;        // UB07: Alíquota espec�fica por unidade
    FuTrib: string;           // UB09: Unidade de Medida Tributável
    FqTrib: Double;           // UB10: Quantidade Tributável
    FvIS: Currency;           // UB11: Valor do Imposto Seletivo

    procedure setFCSTIS(const Value: string);
    procedure setFcClassTribIS(const Value: string);
    procedure setFvBCIS(const Value: Currency);
    procedure setFpIS(const Value: Double);
    procedure setFpISEspec(const Value: Double);
    procedure setFuTrib(const Value: string);
    procedure setFqTrib(const Value: Double);
    procedure setFvIS(const Value: Currency);

  public
    [FieldName('CSTIS')]
    property CSTIS: string read FCSTIS write setFCSTIS;

    [FieldName('ClassTribIS')]
    property ClassTribIS: string read FcClassTribIS write setFcClassTribIS;

    [FieldName('BCIS')]
    property BCIS: Currency read FvBCIS write setFvBCIS;

    [FieldName('pis')]
    property pIS: Double read FpIS write setFpIS;

    [FieldName('ISEspec')]
    property ISEspec: Double read FpISEspec write setFpISEspec;

    [FieldName('uTrib')]
    property uTrib: string read FuTrib write setFuTrib;

    [FieldName('qTrib')]
    property qTrib: Double read FqTrib write setFqTrib;

    [FieldName('UB11')]
    property vIS: Currency read FvIS write setFvIS;
  end;

implementation

{ TImpostoSeletivo }

procedure TImpostoSeletivo.setFCSTIS(const Value: string);
begin
  FCSTIS := Value;
end;

procedure TImpostoSeletivo.setFcClassTribIS(const Value: string);
begin
  FcClassTribIS := Value;
end;

procedure TImpostoSeletivo.setFvBCIS(const Value: Currency);
begin
  FvBCIS := Value;
end;

procedure TImpostoSeletivo.setFpIS(const Value: Double);
begin
  FpIS := Value;
end;

procedure TImpostoSeletivo.setFpISEspec(const Value: Double);
begin
  FpISEspec := Value;
end;

procedure TImpostoSeletivo.setFuTrib(const Value: string);
begin
  FuTrib := Value;
end;

procedure TImpostoSeletivo.setFqTrib(const Value: Double);
begin
  FqTrib := Value;
end;

procedure TImpostoSeletivo.setFvIS(const Value: Currency);
begin
  FvIS := Value;
end;

end.

implementation

end.
