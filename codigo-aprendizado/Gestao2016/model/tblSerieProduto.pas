unit tblSerieProduto;

interface

Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_SERIE_PRODUTO')]
  TSerieProduto = Class(TGenericEntity)
  private
    FSRP_CODPRO: Integer;
    FSRP_OPERACAO: String;
    FSRP_CODENT: Integer;
    FSRP_DESCRICAO: String;
    FSRP_CODIGO: Integer;
    FSRP_NUMERO: String;
    FSRP_DISPON: String;
    FSRP_CODSAI: Integer;
    procedure setFSRP_CODENT(const Value: Integer);
    procedure setFSRP_CODPRO(const Value: Integer);
    procedure setFSRP_CODSAI(const Value: Integer);
    procedure setFSRP_DESCRICAO(const Value: String);
    procedure setFSRP_DISPON(const Value: String);
    procedure setFSRP_NUMERO(const Value: String);
    procedure setFSRP_OPERACAO(const Value: String);
    procedure setSRP_CODIGOF(const Value: Integer);

  public
    [KeyField('SRP_CODIGO')]
    [FieldName('SRP_CODIGO')]
    property Codigo:Integer   read FSRP_CODIGO write setSRP_CODIGOF;

    [FieldName('SRP_CODPRO')]
    property Produto:Integer   read FSRP_CODPRO write setFSRP_CODPRO;

    [FieldName('SRP_CODENT')]
    property Entrada: Integer  read FSRP_CODENT write setFSRP_CODENT;

    [FieldName('SRP_CODSAI')]
    property Saida: Integer  read FSRP_CODSAI write setFSRP_CODSAI;

    [FieldName('SRP_NUMERO')]
    property Numero: String  read FSRP_NUMERO write setFSRP_NUMERO;

    [FieldName('SRP_OPERACAO')]
    property Operacao : String   read FSRP_OPERACAO write setFSRP_OPERACAO;

    [FieldName('SRP_DISPON')]
    property Disponivel:String   read FSRP_DISPON write setFSRP_DISPON;

    [FieldName('SRP_DESCRICAO')]
    property Descricao: String   read FSRP_DESCRICAO write setFSRP_DESCRICAO;

  End;

implementation

{ TSerieProduto }

procedure TSerieProduto.setFSRP_CODENT(const Value: Integer);
begin
  FSRP_CODENT := Value;
end;

procedure TSerieProduto.setFSRP_CODPRO(const Value: Integer);
begin
  FSRP_CODPRO := Value;
end;

procedure TSerieProduto.setFSRP_CODSAI(const Value: Integer);
begin
  FSRP_CODSAI := Value;
end;

procedure TSerieProduto.setFSRP_DESCRICAO(const Value: String);
begin
  FSRP_DESCRICAO := Value;
end;

procedure TSerieProduto.setFSRP_DISPON(const Value: String);
begin
  FSRP_DISPON := Value;
end;

procedure TSerieProduto.setFSRP_NUMERO(const Value: String);
begin
  FSRP_NUMERO := Value;
end;

procedure TSerieProduto.setFSRP_OPERACAO(const Value: String);
begin
  FSRP_OPERACAO := Value;
end;

procedure TSerieProduto.setSRP_CODIGOF(const Value: Integer);
begin
  FSRP_CODIGO := Value;
end;

end.
