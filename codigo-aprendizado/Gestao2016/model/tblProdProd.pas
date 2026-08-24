unit tblProdProd;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_PROD_PROD')]
  TProdProd = Class(TGenericEntity)
    private
    FPPD_METODO: String;
    FPPD_QTDE_USED: Real;
    FPRO_CODIGO: Integer;
    FPPD_QTDE: Real;
    FPPD_CODPRO_D: Integer;
    FPPD_TIPO: String;
    FProduto: String;
    FCodigoFabrica: String;
    FComposicao: String;
    procedure setFPPD_CODPRO_D(const Value: Integer);
    procedure setFPPD_METODO(const Value: String);
    procedure setFPPD_QTDE(const Value: Real);
    procedure setFPPD_QTDE_USED(const Value: Real);
    procedure setFPPD_TIPO(const Value: String);
    procedure setFPRO_CODIGO(const Value: Integer);
    procedure setFCodigoFabrica(const Value: String);
    procedure setFProduto(const Value: String);
    procedure setFComposicao(const Value: String);

    protected
      procedure CreateDomains;Override;
      procedure CreateField;Override;
    public

      [KeyField('PPD_CODPRO_M')]
      [FieldName('PPD_CODPRO_M')]
      property produtoMaster:Integer read FPRO_CODIGO write setFPRO_CODIGO;

      [KeyField('PPD_CODPRO_D')]
      [FieldName('PPD_CODPRO_D')]
      property produtodetalhe:Integer read FPPD_CODPRO_D write setFPPD_CODPRO_D;

      [FieldName('PPD_QTDE')]
      property Qtde :Real read FPPD_QTDE write setFPPD_QTDE;

      [FieldName('PPD_TIPO')]
      property Tipo:String read FPPD_TIPO write setFPPD_TIPO;

      [FieldName('PPD_METODO')]
      property Metodo :String read FPPD_METODO write setFPPD_METODO;

      [FieldName('PPD_QTDE_USED')]
      property QtdeUsada :Real read FPPD_QTDE_USED write setFPPD_QTDE_USED;

      property Produto :String read FProduto write setFProduto;
      property CodigoFabrica :String read FCodigoFabrica write setFCodigoFabrica;
      property Composicao :String read FComposicao write setFComposicao;
  end;


implementation


{ TProdProd }


procedure TProdProd.CreateDomains;
begin
  if not existDomain('Descricao_20') then
  Begin
    RunScript('CREATE DOMAIN "Descricao_20" AS VARCHAR(20) CHARACTER SET WIN1252 COLLATE WIN_PTBR;');
  End;

  if not existDomain('Numeric102') then
  Begin
    RunScript('CREATE DOMAIN "Numeric102" AS NUMERIC(10,2);');
  End;

end;

procedure TProdProd.CreateField;
begin
  if not existField('TB_PROD_PROD','PPD_TIPO') then
  Begin
    RunScript('ALTER TABLE TB_PROD_PROD ADD PPD_TIPO "Descricao_20";');
  End;

  if not existField('TB_PROD_PROD','PPD_METODO') then
  Begin
    RunScript('ALTER TABLE TB_PROD_PROD ADD PPD_METODO "Descricao_20";');
  End;

  if not existField('TB_PROD_PROD','PPD_QTDE_USED') then
  Begin
    RunScript('ALTER TABLE TB_PROD_PROD ADD PPD_QTDE_USED "Numeric102";');
  End;

end;


procedure TProdProd.setFCodigoFabrica(const Value: String);
begin
  FCodigoFabrica := Value;
end;

procedure TProdProd.setFComposicao(const Value: String);
begin
  FComposicao := Value;
end;

procedure TProdProd.setFPPD_CODPRO_D(const Value: Integer);
begin
  FPPD_CODPRO_D := Value;
end;

procedure TProdProd.setFPPD_METODO(const Value: String);
begin
  FPPD_METODO := Value;
end;

procedure TProdProd.setFPPD_QTDE(const Value: Real);
begin
  FPPD_QTDE := Value;
end;

procedure TProdProd.setFPPD_QTDE_USED(const Value: Real);
begin
  FPPD_QTDE_USED := Value;
end;

procedure TProdProd.setFPPD_TIPO(const Value: String);
begin
  FPPD_TIPO := Value;
end;

procedure TProdProd.setFProduto(const Value: String);
begin
  FProduto := Value;
end;

procedure TProdProd.setFPRO_CODIGO(const Value: Integer);
begin
  FPRO_CODIGO := Value;
end;


end.
