unit tblAssistenciaItens;

interface

Uses     GenericEntity, CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_ASS')]
  TAssistenciaItens = Class(TGenericEntity)
  private
    FIAS_CODSIT: Integer;
    FIAS_DT_REALIZADA: TDate;
    FIAS_VL_CUSTO: Real;
    FIAS_HOUR: String;
    FIAS_CODIGO: Integer;
    FIAS_VL_CLIENTE: Real;
    FIAS_DESCRITIVO: String;
    FIAS_CODASS: Integer;
    FIAS_DT_PREVISTA: TDAte;
    FIAS_ETAPA: Integer;
    FIAS_DATA: TDAte;
    FSituacaoDesc: String;
    procedure setFIAS_CODASS(const Value: Integer);
    procedure setFIAS_CODIGO(const Value: Integer);
    procedure setFIAS_CODSIT(const Value: Integer);
    procedure setFIAS_DATA(const Value: TDAte);
    procedure setFIAS_DESCRITIVO(const Value: String);
    procedure setFIAS_DT_PREVISTA(const Value: TDAte);
    procedure setFIAS_DT_REALIZADA(const Value: TDate);
    procedure setFIAS_ETAPA(const Value: Integer);
    procedure setFIAS_HOUR(const Value: String);
    procedure setFIAS_VL_CLIENTE(const Value: Real);
    procedure setFIAS_VL_CUSTO(const Value: Real);
    procedure setFSituacaoDesc(const Value: String);

  public

    [KeyField('IAS_CODIGO')]
    [FieldName('IAS_CODIGO')]
    property Codigo: Integer  read FIAS_CODIGO write setFIAS_CODIGO;

    [FieldName('IAS_CODASS')]
    property Assistencia: Integer  read FIAS_CODASS write setFIAS_CODASS;

    [FieldName('IAS_ETAPA')]
    property Etapa: Integer read FIAS_ETAPA write setFIAS_ETAPA;

    [FieldName('IAS_DATA')]
    property Data: TDAte  read FIAS_DATA write setFIAS_DATA;

    [FieldName('IAS_DESCRITIVO')]
    property Descritivo:String   read FIAS_DESCRITIVO write setFIAS_DESCRITIVO;

    [FieldName('IAS_DT_PREVISTA')]
    property DataPrevista:TDAte  read FIAS_DT_PREVISTA write setFIAS_DT_PREVISTA;

    [FieldName('IAS_VL_CLIENTE')]
    property ValorCliente: Real read FIAS_VL_CLIENTE write setFIAS_VL_CLIENTE;

    [FieldName('IAS_VL_CUSTO')]
    property ValorCusto: Real read FIAS_VL_CUSTO write setFIAS_VL_CUSTO;

    [FieldName('IAS_DT_REALIZADA')]
    property DataRealizada: TDate  read FIAS_DT_REALIZADA write setFIAS_DT_REALIZADA;

    [FieldName('IAS_CODSIT')]
    property SituacaoId:Integer  read FIAS_CODSIT write setFIAS_CODSIT;

    [FieldName('IAS_HOUR')]
    property Hora: String  read FIAS_HOUR write setFIAS_HOUR;

    property SituacaoDesc : String read FSituacaoDesc write setFSituacaoDesc;
  End;


implementation

{ TAssistenciaItens }

procedure TAssistenciaItens.setFIAS_CODASS(const Value: Integer);
begin
  FIAS_CODASS := Value;
end;

procedure TAssistenciaItens.setFIAS_CODIGO(const Value: Integer);
begin
  FIAS_CODIGO := Value;
end;

procedure TAssistenciaItens.setFIAS_CODSIT(const Value: Integer);
begin
  FIAS_CODSIT := Value;
end;

procedure TAssistenciaItens.setFIAS_DATA(const Value: TDAte);
begin
  FIAS_DATA := Value;
end;

procedure TAssistenciaItens.setFIAS_DESCRITIVO(const Value: String);
begin
  FIAS_DESCRITIVO := Value;
end;

procedure TAssistenciaItens.setFIAS_DT_PREVISTA(const Value: TDAte);
begin
  FIAS_DT_PREVISTA := Value;
end;

procedure TAssistenciaItens.setFIAS_DT_REALIZADA(const Value: TDate);
begin
  FIAS_DT_REALIZADA := Value;
end;

procedure TAssistenciaItens.setFIAS_ETAPA(const Value: Integer);
begin
  FIAS_ETAPA := Value;
end;

procedure TAssistenciaItens.setFIAS_HOUR(const Value: String);
begin
  FIAS_HOUR := Value;
end;

procedure TAssistenciaItens.setFIAS_VL_CLIENTE(const Value: Real);
begin
  FIAS_VL_CLIENTE := Value;
end;

procedure TAssistenciaItens.setFIAS_VL_CUSTO(const Value: Real);
begin
  FIAS_VL_CUSTO := Value;
end;

procedure TAssistenciaItens.setFSituacaoDesc(const Value: String);
begin
  FSituacaoDesc := Value;
end;

end.
