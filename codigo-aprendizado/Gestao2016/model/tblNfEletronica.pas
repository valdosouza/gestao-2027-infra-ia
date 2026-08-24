unit tblNfEletronica;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_NF_ELETRONICA')]
  TNfEletronica = Class(TGenericEntity)
    private
    FNFE_IDTOKEN: String;
    FNFE_EMAIL_CONTADOR: String;
    FNFE_DFE_DUP: String;
    FNFE_VERSAO: String;
    FNFE_POS_CANH: String;
    FNFE_DFE_COB: String;
    FNFE_DFE_FAT: String;
    FNFE_DFE_ORIENTACAO: String;
    FNFE_CODIGO: Integer;
    FNFE_DFE_VISUALIZAR: String;
    FNFE_TOKEN: String;
    FNFE_EMISSAO: String;
    FNFE_AMBIENTE: String;
    FNFE_REPOSITORIO: String;
    FNFE_CODEMP: Integer;
    FNFE_DFE_TIPO: String;
    FNFE_CERTIFICADO: String;
    FNFE_COPIA_EMAIL: String;
    FNFE_REPOSITORIO_NFCE: String;
    procedure setFNFE_AMBIENTE(const Value: String);
    procedure setFNFE_CERTIFICADO(const Value: String);
    procedure setFNFE_CODEMP(const Value: Integer);
    procedure setFNFE_CODIGO(const Value: Integer);
    procedure setFNFE_COPIA_EMAIL(const Value: String);
    procedure setFNFE_DFE_COB(const Value: String);
    procedure setFNFE_DFE_DUP(const Value: String);
    procedure setFNFE_DFE_FAT(const Value: String);
    procedure setFNFE_DFE_ORIENTACAO(const Value: String);
    procedure setFNFE_DFE_TIPO(const Value: String);
    procedure setFNFE_DFE_VISUALIZAR(const Value: String);
    procedure setFNFE_EMAIL_CONTADOR(const Value: String);
    procedure setFNFE_EMISSAO(const Value: String);
    procedure setFNFE_IDTOKEN(const Value: String);
    procedure setFNFE_POS_CANH(const Value: String);
    procedure setFNFE_REPOSITORIO(const Value: String);
    procedure setFNFE_REPOSITORIO_NFCE(const Value: String);
    procedure setFNFE_TOKEN(const Value: String);
    procedure setFNFE_VERSAO(const Value: String);

    protected
      procedure CreateDomains;Override;
      procedure CreateField;Override;
    public
      [FieldName('NFE_CODIGO')]
      property Codigo: Integer read FNFE_CODIGO write setFNFE_CODIGO;

      [KeyField('NFE_CODEMP')]
      [FieldName('NFE_CODEMP')]
      property Estabelecimento: Integer read FNFE_CODEMP write setFNFE_CODEMP;

      [FieldName('NFE_AMBIENTE')]
      property Ambiente: String read FNFE_AMBIENTE write setFNFE_AMBIENTE;

      [FieldName('NFE_EMISSAO')]
      property Emissao: String read FNFE_EMISSAO write setFNFE_EMISSAO;

      [FieldName('NFE_CERTIFICADO')]
      property Certificado: String read FNFE_CERTIFICADO write setFNFE_CERTIFICADO;

      [FieldName('NFE_REPOSITORIO')]
      property RepositorioNFE:String read FNFE_REPOSITORIO write setFNFE_REPOSITORIO;

      [FieldName('NFE_DFE_ORIENTACAO')]
      property Orientacao:String read FNFE_DFE_ORIENTACAO write setFNFE_DFE_ORIENTACAO;

      [FieldName('NFE_DFE_VISUALIZAR')]
      property VisualizarMensagem: String read FNFE_DFE_VISUALIZAR write setFNFE_DFE_VISUALIZAR;

      [FieldName('NFE_DFE_FAT')]
      property Faturamento: String read FNFE_DFE_FAT write setFNFE_DFE_FAT;

      [FieldName('NFE_DFE_DUP')]
      property Duplicata: String read FNFE_DFE_DUP write setFNFE_DFE_DUP;

      [FieldName('NFE_DFE_TIPO')]
      property Tipo: String read FNFE_DFE_TIPO write setFNFE_DFE_TIPO;

      [FieldName('NFE_DFE_COB')]
      property Cobranca: String read FNFE_DFE_COB write setFNFE_DFE_COB;

      [FieldName('NFE_EMAIL_CONTADOR')]
      property EmailContador: String read FNFE_EMAIL_CONTADOR write setFNFE_EMAIL_CONTADOR;

      [FieldName('NFE_COPIA_EMAIL')]
      property ReceberCopiaEmail:String  read FNFE_COPIA_EMAIL write setFNFE_COPIA_EMAIL;

      [FieldName('NFE_IDTOKEN')]
      property IDToken:String  read FNFE_IDTOKEN write setFNFE_IDTOKEN;

      [FieldName('NFE_TOKEN')]
      property Token:String  read FNFE_TOKEN write setFNFE_TOKEN;

      [FieldName('NFE_REPOSITORIO_NFCE')]
      property RepositorioNFCE:String  read FNFE_REPOSITORIO_NFCE write setFNFE_REPOSITORIO_NFCE;

      [FieldName('NFE_POS_CANH')]
      property PosicaoCanhoto: String  read FNFE_POS_CANH write setFNFE_POS_CANH;

      [FieldName('NFE_VERSAO')]
      property Versao: String  read FNFE_VERSAO write setFNFE_VERSAO;

  End;

implementation

{ TNfEletronica }

procedure TNfEletronica.CreateDomains;
begin
  inherited;

end;

procedure TNfEletronica.CreateField;
begin
  inherited;

end;

procedure TNfEletronica.setFNFE_AMBIENTE(const Value: String);
begin
  FNFE_AMBIENTE := Value;
end;

procedure TNfEletronica.setFNFE_CERTIFICADO(const Value: String);
begin
  FNFE_CERTIFICADO := Value;
end;

procedure TNfEletronica.setFNFE_CODEMP(const Value: Integer);
begin
  FNFE_CODEMP := Value;
end;

procedure TNfEletronica.setFNFE_CODIGO(const Value: Integer);
begin
  FNFE_CODIGO := Value;
end;

procedure TNfEletronica.setFNFE_COPIA_EMAIL(const Value: String);
begin
  FNFE_COPIA_EMAIL := Value;
end;

procedure TNfEletronica.setFNFE_DFE_COB(const Value: String);
begin
  FNFE_DFE_COB := Value;
end;

procedure TNfEletronica.setFNFE_DFE_DUP(const Value: String);
begin
  FNFE_DFE_DUP := Value;
end;

procedure TNfEletronica.setFNFE_DFE_FAT(const Value: String);
begin
  FNFE_DFE_FAT := Value;
end;

procedure TNfEletronica.setFNFE_DFE_ORIENTACAO(const Value: String);
begin
  FNFE_DFE_ORIENTACAO := Value;
end;

procedure TNfEletronica.setFNFE_DFE_TIPO(const Value: String);
begin
  FNFE_DFE_TIPO := Value;
end;

procedure TNfEletronica.setFNFE_DFE_VISUALIZAR(const Value: String);
begin
  FNFE_DFE_VISUALIZAR := Value;
end;

procedure TNfEletronica.setFNFE_EMAIL_CONTADOR(const Value: String);
begin
  FNFE_EMAIL_CONTADOR := Value;
end;

procedure TNfEletronica.setFNFE_EMISSAO(const Value: String);
begin
  FNFE_EMISSAO := Value;
end;

procedure TNfEletronica.setFNFE_IDTOKEN(const Value: String);
begin
  FNFE_IDTOKEN := Value;
end;

procedure TNfEletronica.setFNFE_POS_CANH(const Value: String);
begin
  FNFE_POS_CANH := Value;
end;

procedure TNfEletronica.setFNFE_REPOSITORIO(const Value: String);
begin
  FNFE_REPOSITORIO := Value;
end;

procedure TNfEletronica.setFNFE_REPOSITORIO_NFCE(const Value: String);
begin
  FNFE_REPOSITORIO_NFCE := Value;
end;

procedure TNfEletronica.setFNFE_TOKEN(const Value: String);
begin
  FNFE_TOKEN := Value;
end;

procedure TNfEletronica.setFNFE_VERSAO(const Value: String);
begin
  FNFE_VERSAO := Value;
end;

end.
