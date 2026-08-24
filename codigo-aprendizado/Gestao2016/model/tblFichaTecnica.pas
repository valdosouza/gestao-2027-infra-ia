unit tblFichaTecnica;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_FICHA_TECNICA')]
  TFichaTecnica = Class(TGenericEntity)
  private
    FFTC_CODIGO: Integer;
    FFTC_CODICT: Integer;
    FFTC_CODITF: Integer;
    FFTC_TIPO: String;
    FFTC_CODVCL: Integer;
    FFTC_DESC_INSUMO: String;
    FFTC_UND: String;
    FFTC_VL_UNIT: Real;
    FFTC_CS_UNIT: Real;
    FFTC_TX_PARTIC: Real;
    FFTC_CODPRO: Integer;
    procedure setFFTC_CODIGO(const Value: Integer);
    procedure setFFTC_CODICT(const Value: Integer);
    procedure setFFTC_CODITF(const Value: Integer);
    procedure setFFTC_TIPO(const Value: String);
    procedure setFFTC_CODVCL(const Value: Integer);
    procedure setFFTC_DESC_INSUMO(const Value: String);
    procedure setFFTC_UND(const Value: String);
    procedure setFFTC_VL_UNIT(const Value: Real);
    procedure setFFTC_CS_UNIT(const Value: Real);
    procedure setFFTC_TX_PARTIC(const Value: Real);
    procedure setFFTC_CODPRO(const Value: Integer);
  public
    [KeyField('FTC_CODIGO')]
    [FieldName('FTC_CODIGO')]
    property Codigo: Integer read FFTC_CODIGO write setFFTC_CODIGO;

    [FieldName('FTC_CODICT')]
    property CodigoCotacaoItem: Integer read FFTC_CODICT write setFFTC_CODICT;

    [FieldName('FTC_CODITF')]
    property CodigoItemNfl: Integer read FFTC_CODITF write setFFTC_CODITF;

    [FieldName('FTC_TIPO')]
    property Tipo: String read FFTC_TIPO write setFFTC_TIPO;

    [FieldName('FTC_CODVCL')]
    property CodigoVcl: Integer read FFTC_CODVCL write setFFTC_CODVCL;

    [FieldName('FTC_DESC_INSUMO')]
    property DescricaoInsumo: String read FFTC_DESC_INSUMO write setFFTC_DESC_INSUMO;

    [FieldName('FTC_UND')]
    property Unidade: String read FFTC_UND write setFFTC_UND;

    [FieldName('FTC_VL_UNIT')]
    property ValorUnitario: Real read FFTC_VL_UNIT write setFFTC_VL_UNIT;

    [FieldName('FTC_CS_UNIT')]
    property CustoUnitario: Real read FFTC_CS_UNIT write setFFTC_CS_UNIT;

    [FieldName('FTC_TX_PARTIC')]
    property TaxaParticipacao: Real read FFTC_TX_PARTIC write setFFTC_TX_PARTIC;

    [FieldName('FTC_CODPRO')]
    property CodigoProduto: Integer read FFTC_CODPRO write setFFTC_CODPRO;
  End;

implementation

procedure TFichaTecnica.setFFTC_CODIGO(const Value: Integer);
begin
  FFTC_CODIGO := Value;
end;

procedure TFichaTecnica.setFFTC_CODICT(const Value: Integer);
begin
  FFTC_CODICT := Value;
end;

procedure TFichaTecnica.setFFTC_CODITF(const Value: Integer);
begin
  FFTC_CODITF := Value;
end;

procedure TFichaTecnica.setFFTC_TIPO(const Value: String);
begin
  FFTC_TIPO := Value;
end;

procedure TFichaTecnica.setFFTC_CODVCL(const Value: Integer);
begin
  FFTC_CODVCL := Value;
end;

procedure TFichaTecnica.setFFTC_DESC_INSUMO(const Value: String);
begin
  FFTC_DESC_INSUMO := Value;
end;

procedure TFichaTecnica.setFFTC_UND(const Value: String);
begin
  FFTC_UND := Value;
end;

procedure TFichaTecnica.setFFTC_VL_UNIT(const Value: Real);
begin
  FFTC_VL_UNIT := Value;
end;

procedure TFichaTecnica.setFFTC_CS_UNIT(const Value: Real);
begin
  FFTC_CS_UNIT := Value;
end;

procedure TFichaTecnica.setFFTC_TX_PARTIC(const Value: Real);
begin
  FFTC_TX_PARTIC := Value;
end;

procedure TFichaTecnica.setFFTC_CODPRO(const Value: Integer);
begin
  FFTC_CODPRO := Value;
end;

end.
