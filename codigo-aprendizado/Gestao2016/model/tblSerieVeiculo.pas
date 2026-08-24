unit tblSerieVeiculo;

interface

Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_SERIE_VEICULO')]
  TSerieVeiculo = Class(TGenericEntity)
  private
    FSRV_TIPO_COMB: String;
    FSRV_PESO_BRT: String;
    FSRV_POT_MOTOR: String;
    FSRV_CHASSI: String;
    FSRV_CODRTV: Integer;
    FSRV_DISTEIXO: String;
    FSRV_VIN: String;
    FSRV_CMT: String;
    FSRV_CODIGO: Integer;
    FSRV_CODEPV: Integer;
    FSRV_SERIE: String;
    FSRV_DESC_COR: String;
    FSRV_COND_VEIC: Integer;
    FSRV_ANO_FAB: Real;
    FSRV_LOTA: Integer;
    FSRV_NUM_MOTOR: String;
    FSRV_CODITF: Integer;
    FSRV_PESO_LIQ: String;
    FSRV_CODTPV: Integer;
    FSRV_TIPO_PINTURA: String;
    FSRV_CODMOD: Integer;
    FSRV_CILINDRADA: String;
    FSRV_CODCOR: Integer;
    FSRV_CODICOR: String;
    FSRV_TIPO_OPER: String;
    FSRV_ANO_MOD: Real;
    procedure setFSRV_ANO_FAB(const Value: Real);
    procedure setFSRV_ANO_MOD(const Value: Real);
    procedure setFSRV_CHASSI(const Value: String);
    procedure setFSRV_CILINDRADA(const Value: String);
    procedure setFSRV_CMT(const Value: String);
    procedure setFSRV_CODCOR(const Value: Integer);
    procedure setFSRV_CODEPV(const Value: Integer);
    procedure setFSRV_CODICOR(const Value: String);
    procedure setFSRV_CODIGO(const Value: Integer);
    procedure setFSRV_CODITF(const Value: Integer);
    procedure setFSRV_CODMOD(const Value: Integer);
    procedure setFSRV_CODRTV(const Value: Integer);
    procedure setFSRV_CODTPV(const Value: Integer);
    procedure setFSRV_COND_VEIC(const Value: Integer);
    procedure setFSRV_DESC_COR(const Value: String);
    procedure setFSRV_DISTEIXO(const Value: String);
    procedure setFSRV_LOTA(const Value: Integer);
    procedure setFSRV_NUM_MOTOR(const Value: String);
    procedure setFSRV_PESO_BRT(const Value: String);
    procedure setFSRV_PESO_LIQ(const Value: String);
    procedure setFSRV_POT_MOTOR(const Value: String);
    procedure setFSRV_SERIE(const Value: String);
    procedure setFSRV_TIPO_COMB(const Value: String);
    procedure setFSRV_TIPO_OPER(const Value: String);
    procedure setFSRV_TIPO_PINTURA(const Value: String);
    procedure setFSRV_VIN(const Value: String);


  public
    [KeyField('SRV_CODIGO')]
    [FieldName('SRV_CODIGO')]
    property Codigo: Integer  read FSRV_CODIGO write setFSRV_CODIGO ;

    [FieldName('SRV_CODITF')]
    property Item:Integer   read FSRV_CODITF write setFSRV_CODITF ;

    [FieldName('SRV_TIPO_OPER')]
    property TipoOperacao: String  read FSRV_TIPO_OPER write setFSRV_TIPO_OPER ;

    [FieldName('SRV_CHASSI')]
    property Chassi: String  read FSRV_CHASSI write setFSRV_CHASSI ;

    [FieldName('SRV_CODICOR')]
    property CodiCor: String  read FSRV_CODICOR write setFSRV_CODICOR ;

    [FieldName('SRV_DESC_COR')]
    property DescricaoCor: String   read FSRV_DESC_COR write setFSRV_DESC_COR ;

    [FieldName('SRV_POT_MOTOR')]
    property PotenciaMotor: String   read FSRV_POT_MOTOR write setFSRV_POT_MOTOR ;

    [FieldName('SRV_CILINDRADA')]
    property Cilindrada: String   read FSRV_CILINDRADA write setFSRV_CILINDRADA ;

    [FieldName('SRV_PESO_LIQ')]
    property PesoLiquido: String   read FSRV_PESO_LIQ write setFSRV_PESO_LIQ ;

    [FieldName('SRV_PESO_BRT')]
    property PesoBruto: String   read FSRV_PESO_BRT write setFSRV_PESO_BRT ;

    [FieldName('SRV_SERIE')]
    property Serie: String   read FSRV_SERIE write setFSRV_SERIE ;

    [FieldName('SRV_TIPO_COMB')]
    property TipoCombutivel: String  read FSRV_TIPO_COMB write setFSRV_TIPO_COMB ;

    [FieldName('SRV_NUM_MOTOR')]
    property NumeroMotor : String read FSRV_NUM_MOTOR write setFSRV_NUM_MOTOR ;

    [FieldName('SRV_CMT')]
    property CMT: String   read FSRV_CMT write setFSRV_CMT ;

    [FieldName('SRV_DISTEIXO')]
    property DistanciaEixo :String   read FSRV_DISTEIXO write setFSRV_DISTEIXO ;

    [FieldName('SRV_ANO_MOD')]
    property AnoModelo : Real  read FSRV_ANO_MOD write setFSRV_ANO_MOD ;

    [FieldName('SRV_ANO_FAB')]
    property AnoFabricacao : Real   read FSRV_ANO_FAB write setFSRV_ANO_FAB ;

    [FieldName('SRV_TIPO_PINTURA')]
    property TipoPintura: String   read FSRV_TIPO_PINTURA write setFSRV_TIPO_PINTURA ;

    [FieldName('SRV_CODTPV')]
    property TipoVeiculo: Integer   read FSRV_CODTPV write setFSRV_CODTPV ;

    [FieldName('SRV_CODEPV')]
    property CodigoEPV : Integer  read FSRV_CODEPV write setFSRV_CODEPV ;

    [FieldName('SRV_VIN')]
    property CodigoVin : String  read FSRV_VIN write setFSRV_VIN ;

    [FieldName('SRV_COND_VEIC')]
    property CondicaoVeiculo : Integer  read FSRV_COND_VEIC write setFSRV_COND_VEIC ;

    [FieldName('SRV_CODMOD')]
    property CodigoModelo: Integer  read FSRV_CODMOD write setFSRV_CODMOD ;

    [FieldName('SRV_CODCOR')]
    property CodCor: Integer  read FSRV_CODCOR write setFSRV_CODCOR ;

    [FieldName('SRV_LOTA')]
    property Lota:Integer read FSRV_LOTA write setFSRV_LOTA ;

    [FieldName('SRV_CODRTV')]
    property CodRTV : Integer  read FSRV_CODRTV write setFSRV_CODRTV ;



  End;

implementation

{ TSerieVeiculo }

procedure TSerieVeiculo.setFSRV_ANO_FAB(const Value: Real);
begin
  FSRV_ANO_FAB := Value;
end;

procedure TSerieVeiculo.setFSRV_ANO_MOD(const Value: Real);
begin
  FSRV_ANO_MOD := Value;
end;

procedure TSerieVeiculo.setFSRV_CHASSI(const Value: String);
begin
  FSRV_CHASSI := Value;
end;

procedure TSerieVeiculo.setFSRV_CILINDRADA(const Value: String);
begin
  FSRV_CILINDRADA := Value;
end;

procedure TSerieVeiculo.setFSRV_CMT(const Value: String);
begin
  FSRV_CMT := Value;
end;

procedure TSerieVeiculo.setFSRV_CODCOR(const Value: Integer);
begin
  FSRV_CODCOR := Value;
end;

procedure TSerieVeiculo.setFSRV_CODEPV(const Value: Integer);
begin
  FSRV_CODEPV := Value;
end;

procedure TSerieVeiculo.setFSRV_CODICOR(const Value: String);
begin
  FSRV_CODICOR := Value;
end;

procedure TSerieVeiculo.setFSRV_CODIGO(const Value: Integer);
begin
  FSRV_CODIGO := Value;
end;

procedure TSerieVeiculo.setFSRV_CODITF(const Value: Integer);
begin
  FSRV_CODITF := Value;
end;

procedure TSerieVeiculo.setFSRV_CODMOD(const Value: Integer);
begin
  FSRV_CODMOD := Value;
end;

procedure TSerieVeiculo.setFSRV_CODRTV(const Value: Integer);
begin
  FSRV_CODRTV := Value;
end;

procedure TSerieVeiculo.setFSRV_CODTPV(const Value: Integer);
begin
  FSRV_CODTPV := Value;
end;

procedure TSerieVeiculo.setFSRV_COND_VEIC(const Value: Integer);
begin
  FSRV_COND_VEIC := Value;
end;

procedure TSerieVeiculo.setFSRV_DESC_COR(const Value: String);
begin
  FSRV_DESC_COR := Value;
end;

procedure TSerieVeiculo.setFSRV_DISTEIXO(const Value: String);
begin
  FSRV_DISTEIXO := Value;
end;

procedure TSerieVeiculo.setFSRV_LOTA(const Value: Integer);
begin
  FSRV_LOTA := Value;
end;

procedure TSerieVeiculo.setFSRV_NUM_MOTOR(const Value: String);
begin
  FSRV_NUM_MOTOR := Value;
end;

procedure TSerieVeiculo.setFSRV_PESO_BRT(const Value: String);
begin
  FSRV_PESO_BRT := Value;
end;

procedure TSerieVeiculo.setFSRV_PESO_LIQ(const Value: String);
begin
  FSRV_PESO_LIQ := Value;
end;

procedure TSerieVeiculo.setFSRV_POT_MOTOR(const Value: String);
begin
  FSRV_POT_MOTOR := Value;
end;

procedure TSerieVeiculo.setFSRV_SERIE(const Value: String);
begin
  FSRV_SERIE := Value;
end;

procedure TSerieVeiculo.setFSRV_TIPO_COMB(const Value: String);
begin
  FSRV_TIPO_COMB := Value;
end;

procedure TSerieVeiculo.setFSRV_TIPO_OPER(const Value: String);
begin
  FSRV_TIPO_OPER := Value;
end;

procedure TSerieVeiculo.setFSRV_TIPO_PINTURA(const Value: String);
begin
  FSRV_TIPO_PINTURA := Value;
end;

procedure TSerieVeiculo.setFSRV_VIN(const Value: String);
begin
  FSRV_VIN := Value;
end;

end.
