unit tblOrdemServico;

interface

Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ORDEMSERVICO')]
  TOrdemServico = Class(TGenericEntity)
  private
    FORD_HR_SAIDA: String;
    FORD_PRISMA: String;
    FORD_OBS: String;
    FORD_DT_ENTRADA: TDate;
    FORD_KM: String;
    FORD_CODPED: Integer;
    FORD_CLIENTE: String;
    FORD_CODIGO: Integer;
    FORD_HR_ENTRADA: String;
    FORD_KM_ENTRADA: String;
    FORD_NVL_COMBT: String;
    FORD_NUMERO: String;
    FORD_CODMEC: Integer;
    FORD_DT_SAIDA: TDate;
    FORD_CODVEI: Integer;
    procedure setFORD_CLIENTE(const Value: String);
    procedure setFORD_CODIGO(const Value: Integer);
    procedure setFORD_CODMEC(const Value: Integer);
    procedure setFORD_CODPED(const Value: Integer);
    procedure setFORD_CODVEI(const Value: Integer);
    procedure setFORD_DT_ENTRADA(const Value: TDate);
    procedure setFORD_DT_SAIDA(const Value: TDate);
    procedure setFORD_HR_ENTRADA(const Value: String);
    procedure setFORD_HR_SAIDA(const Value: String);
    procedure setFORD_KM(const Value: String);
    procedure setFORD_KM_ENTRADA(const Value: String);
    procedure setFORD_NUMERO(const Value: String);
    procedure setFORD_NVL_COMBT(const Value: String);
    procedure setFORD_OBS(const Value: String);
    procedure setFORD_PRISMA(const Value: String);


  public
    [KeyField('ORD_CODIGO')]
    [FieldName('ORD_CODIGO')]
    property Codigo:Integer   read FORD_CODIGO write setFORD_CODIGO ;

    [FieldName('ORD_CODPED')]
    property Pedido:Integer   read FORD_CODPED write setFORD_CODPED ;

    [FieldName('ORD_NUMERO')]
    property Numero: String   read FORD_NUMERO write setFORD_NUMERO ;

    [FieldName('ORD_DT_ENTRADA')]
    property DataEntrada: TDate   read FORD_DT_ENTRADA write setFORD_DT_ENTRADA ;

    [FieldName('ORD_CLIENTE')]
    property Cliente:String   read FORD_CLIENTE write setFORD_CLIENTE ;

    [FieldName('ORD_CODVEI')]
    property Veiculo: Integer   read FORD_CODVEI write setFORD_CODVEI ;

    [FieldName('ORD_KM')]
    property km: String  read FORD_KM write setFORD_KM ;

    [FieldName('ORD_OBS')]
    property Observacao: String  read FORD_OBS write setFORD_OBS ;

    [FieldName('ORD_DT_SAIDA')]
    property DataSaida: TDate  read FORD_DT_SAIDA write setFORD_DT_SAIDA ;

    [FieldName('ORD_CODMEC')]
    property Mecanico: Integer  read FORD_CODMEC write setFORD_CODMEC ;

    [FieldName('ORD_KM_ENTRADA')]
    property KmEntrada: String  read FORD_KM_ENTRADA write setFORD_KM_ENTRADA ;

    [FieldName('ORD_NVL_COMBT')]
    property NivelCombustivel: String  read FORD_NVL_COMBT write setFORD_NVL_COMBT ;

    [FieldName('ORD_HR_SAIDA')]
    property HoraSaida: String   read FORD_HR_SAIDA write setFORD_HR_SAIDA ;

    [FieldName('ORD_HR_ENTRADA')]
    property HoraEntrada: String  read FORD_HR_ENTRADA write setFORD_HR_ENTRADA ;

    [FieldName('ORD_PRISMA')]
    property Prima: String  read FORD_PRISMA write setFORD_PRISMA ;

  End;

implementation

{ TOrdemServico }

procedure TOrdemServico.setFORD_CLIENTE(const Value: String);
begin
  FORD_CLIENTE := Value;
end;

procedure TOrdemServico.setFORD_CODIGO(const Value: Integer);
begin
  FORD_CODIGO := Value;
end;

procedure TOrdemServico.setFORD_CODMEC(const Value: Integer);
begin
  FORD_CODMEC := Value;
end;

procedure TOrdemServico.setFORD_CODPED(const Value: Integer);
begin
  FORD_CODPED := Value;
end;

procedure TOrdemServico.setFORD_CODVEI(const Value: Integer);
begin
  FORD_CODVEI := Value;
end;

procedure TOrdemServico.setFORD_DT_ENTRADA(const Value: TDate);
begin
  FORD_DT_ENTRADA := Value;
end;

procedure TOrdemServico.setFORD_DT_SAIDA(const Value: TDate);
begin
  FORD_DT_SAIDA := Value;
end;

procedure TOrdemServico.setFORD_HR_ENTRADA(const Value: String);
begin
  FORD_HR_ENTRADA := Value;
end;

procedure TOrdemServico.setFORD_HR_SAIDA(const Value: String);
begin
  FORD_HR_SAIDA := Value;
end;

procedure TOrdemServico.setFORD_KM(const Value: String);
begin
  FORD_KM := Value;
end;

procedure TOrdemServico.setFORD_KM_ENTRADA(const Value: String);
begin
  FORD_KM_ENTRADA := Value;
end;

procedure TOrdemServico.setFORD_NUMERO(const Value: String);
begin
  FORD_NUMERO := Value;
end;

procedure TOrdemServico.setFORD_NVL_COMBT(const Value: String);
begin
  FORD_NVL_COMBT := Value;
end;

procedure TOrdemServico.setFORD_OBS(const Value: String);
begin
  FORD_OBS := Value;
end;

procedure TOrdemServico.setFORD_PRISMA(const Value: String);
begin
  FORD_PRISMA := Value;
end;

end.
