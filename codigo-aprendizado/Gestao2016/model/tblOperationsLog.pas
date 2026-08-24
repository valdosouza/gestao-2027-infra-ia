unit tblOperationsLog;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_LOG_OPERACAO')]
  TOperationsLog = Class(TGenericEntity)
  private
    FLOG_OPERACAO: String;
    FLOG_REGISTRO: integer;
    FLOG_TIMESTAMP: TDateTime;
    FLOG_INTERFACE: String;
    FLOG_CODMHA: integer;
    FLOG_DESCRICAO: String;
    FLOG_CODIGO: Integer;
    FLOG_CODUSU: integer;
    procedure setFLOG_CODIGO(const Value: Integer);
    procedure setFLOG_CODMHA(const Value: integer);
    procedure setFLOG_CODUSU(const Value: integer);
    procedure setFLOG_DESCRICAO(const Value: String);
    procedure setFLOG_INTERFACE(const Value: String);
    procedure setFLOG_OPERACAO(const Value: String);
    procedure setFLOG_REGISTRO(const Value: integer);
    procedure setFLOG_TIMESTAMP(const Value: TDateTime);
  public

    [KeyField('LOG_CODIGO')]
    [FieldName('LOG_CODIGO')]
    property Codigo: Integer read FLOG_CODIGO write setFLOG_CODIGO;

    [FieldName('LOG_DESCRICAO')]
    property Descricao: String read FLOG_DESCRICAO write setFLOG_DESCRICAO;

    [FieldName('LOG_CODMHA')]
    property CodMha: integer read FLOG_CODMHA write setFLOG_CODMHA;  //INTEGER NOT NULL,

    [FieldName('LOG_CODUSU')]
    property CodUsu: integer read FLOG_CODUSU write setFLOG_CODUSU;

    [FieldName('LOG_TIMESTAMP')]
    property Hora: TDateTime read FLOG_TIMESTAMP write setFLOG_TIMESTAMP; //TIMESTAMP

    [FieldName('LOG_INTERFACE')]
    property InterfaceLog: String read FLOG_INTERFACE write setFLOG_INTERFACE;  //VARCHAR(30),

    [FieldName('LOG_REGISTRO')]
    property Registro: integer read FLOG_REGISTRO write setFLOG_REGISTRO;

    [FieldName('LOG_OPERACAO')]
    property Operacao: String read FLOG_OPERACAO write setFLOG_OPERACAO; //ARCHAR(30),

  End;

implementation

{ TOperationsLog }

procedure TOperationsLog.setFLOG_CODIGO(const Value: Integer);
begin
  FLOG_CODIGO := Value;
end;

procedure TOperationsLog.setFLOG_CODMHA(const Value: integer);
begin
  FLOG_CODMHA := Value;
end;

procedure TOperationsLog.setFLOG_CODUSU(const Value: integer);
begin
  FLOG_CODUSU := Value;
end;

procedure TOperationsLog.setFLOG_DESCRICAO(const Value: String);
begin
  FLOG_DESCRICAO := Value;
end;

procedure TOperationsLog.setFLOG_INTERFACE(const Value: String);
begin
  FLOG_INTERFACE := Value;
end;

procedure TOperationsLog.setFLOG_OPERACAO(const Value: String);
begin
  FLOG_OPERACAO := Value;
end;

procedure TOperationsLog.setFLOG_REGISTRO(const Value: integer);
begin
  FLOG_REGISTRO := Value;
end;

procedure TOperationsLog.setFLOG_TIMESTAMP(const Value: TDateTime);
begin
  FLOG_TIMESTAMP := Value;
end;

end.

