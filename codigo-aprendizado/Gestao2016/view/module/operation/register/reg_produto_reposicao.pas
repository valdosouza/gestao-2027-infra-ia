unit reg_produto_reposicao;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.Mask, QEdit_Setes, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Datasnap.DBClient, STQuery, System.StrUtils;

type
  TRegProdutoReposicao = class(TFr_Base)
    Panel2: TPanel;
    L_Descricao: TLabel;
    L_pacote_grande: TLabel;
    L_CodPro: TLabel;
    E_Descricao: TEdit;
    E_pacote_grande: TEdit_Setes;
    E_CodPro: TEdit;
    Panel1: TPanel;
    SB_Gravar: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair: TSpeedButton;
    L_pacote_pequeno: TLabel;
    E_pacote_pequeno: TEdit_Setes;
    CB_METODO: TComboBox;
    L_Metodo: TLabel;
    Qr_Pesquisa: TSTQuery;
    Cds_reposicao: TClientDataSet;
    Cds_reposicaoPPD_CODPRO_M: TIntegerField;
    Cds_reposicaoPPD_CODPRO_D: TIntegerField;
    Cds_reposicaoPRO_CODIGOFAB: TStringField;
    Cds_reposicaoPRO_DESCRICAO: TStringField;
    Cds_reposicaoPPD_QTDE: TFloatField;
    Cds_reposicaoPPD_METODO: TStringField;
    Cds_reposicaoPPD_QTDE_USED: TFloatField;
    procedure E_CodProEnter(Sender: TObject);
    procedure Sb_SairClick(Sender: TObject);
    procedure E_pacote_grandeEnter(Sender: TObject);
    procedure E_pacote_pequenoEnter(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
  private
    FStateChange : String;
    FDataset: TClientDataSet;
    FTipoServico: string;
    FTipoProduto: string;
    FInserir : boolean;
    FVisualizar: Boolean;

    procedure ExitFieldCodpro(Sender: TObject);
    procedure ExitFieldDescricao(Sender: TObject);
    procedure setFDataset(const Value: TClientDataSet);
    FUNCTION fC_Buscar(Pc_Tipo: char;Pc_Codigo : String ; Pc_Descricao : String):Integer;
    PROcedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Prod:String; Pc_Desc_prod:String);
    procedure Pc_MostraBusca;
    function ValidateSave:Boolean;
    procedure Save;
    pROCEDURE Limpa;
    pROCEDURE Pc_PreencheTela;
    procedure setFStateChange(const Value: String);
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ShowData;

  public
    property Dataset : TClientDataSet read FDataset write setFDataset;
    property StateChange : String read FStateChange write setFStateChange;
  end;

var
  RegProdutoReposicao: TRegProdutoReposicao;

implementation

{$R *.dfm}

uses     Un_DM, Un_Sistema, env, Un_Pesq_Produto, un_msg;
procedure TRegProdutoReposicao.CriarVariaveis;
begin
  inherited;
  E_CodPro.OnExit := ExitFieldCodpro;
  E_Descricao.OnExit := ExitFieldDescricao;
end;

procedure TRegProdutoReposicao.ExitFieldCodpro(Sender: TObject);
begin
  if FStateChange = 'I' then
  Begin
    IF (E_CodPro.Text <> '') THEN
      Pc_Tip_Busca('B', E_CodPro.Text,'');
  End;
end;

procedure TRegProdutoReposicao.ExitFieldDescricao(Sender: TObject);
begin
  if FStateChange = 'I' then
  Begin
    IF (E_CodPro.Text <> '') THEN
      Pc_Tip_Busca('B', '',Copy(E_Descricao.Text,1,50));
  End;
end;

procedure TRegProdutoReposicao.E_CodProEnter(Sender: TObject);
begin
  E_CodPro.SelectAll;
end;

procedure TRegProdutoReposicao.E_pacote_grandeEnter(Sender: TObject);
begin
  E_pacote_grande.SelectAll;
end;

procedure TRegProdutoReposicao.E_pacote_pequenoEnter(Sender: TObject);
begin
  E_pacote_Pequeno.SelectAll;
end;

function TRegProdutoReposicao.fC_Buscar(Pc_Tipo: char; Pc_Codigo,
  Pc_Descricao: String): Integer;
var
  Sqltxt:string;
  Lc_Codigo: boolean;
  Lc_Descricao: boolean;
  Lc_SubGrupo : boolean;
  Lc_CodigoInteiro : Integer;
begin

  sqltxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;

  Sqltxt := 'SELECT DISTINCT PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO, PRO_ATIVO '+
            'FROM TB_PRODUTO tb_produto '+
            '  INNER JOIN TB_ESTOQUE tb_estoque '+
            '  ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
            'WHERE (PRO_CODIGO IS NOT NULL)  ';

  if Pc_Codigo = '' then Lc_Codigo:=False Else Lc_Codigo:=True;
  if Pc_Descricao = '' then Lc_Descricao:=False Else Lc_Descricao:=True;

  Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);

  IF Lc_Codigo THEN
  BEGIN
    if Pc_Tipo ='P' then
      Sqltxt := Sqltxt + 'AND (PRO_CODIGO =:PRO_CODIGO) '
    ELSE
    if (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') or (Pc_Tipo = 'P') then
      Sqltxt:=Sqltxt+'AND ( (PRO_CODIGO =:PRO_CODIGO) OR  (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO)) '
    else
      Sqltxt:=Sqltxt+'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) OR  (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO)) ';
    end;

  if (FTipoServico = 'S') then Sqltxt := Sqltxt + 'and (PRO_TIPO = ''S'') '
  else
  if (FTipoProduto <> '') then Sqltxt := Sqltxt + 'and (PRO_TIPO =:PRO_TIPO)'
  ELSE
    Sqltxt := Sqltxt + 'and (PRO_TIPO <> ''S'') ';

   if Lc_Descricao then Sqltxt:=Sqltxt+'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';
   if not GB_ProdCompartilha  then   Sqltxt:=Sqltxt+ 'AND PRO_CODMHA = :PRO_CODMHA';

  Qr_Pesquisa.SQL.Add(sqltxt + ' ORDER BY PRO_DESCRICAO');

//PASSAGEM DE PARAMETRO
  IF Lc_Codigo THEN
  BEGIN
    IF (Pc_Tipo = 'P') then
    BEGIN
      Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo;
    end
    else
      IF (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S') = 'S') THEN
      BEGIN
        if (Lc_CodigoInteiro >0) THEN
          Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo
        ELSE
          Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := '%' + Pc_Codigo + '%';
      END
      ELSE
        Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := '%' + Pc_Codigo + '%';
    end;

  IF Lc_Descricao THEN  Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Pc_Descricao,1,98) + '%';

  if (FTipoProduto <> '') then Qr_Pesquisa.ParamByName('PRO_TIPO').AsString := FTipoProduto;
  if not GB_ProdCompartilha  then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  if DM.IBT_Estoque.InTransaction then DM.IBT_Estoque.Commit;
  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result:=Qr_Pesquisa.RecordCount;
  Screen.Cursor:=crDefault;

end;

procedure TRegProdutoReposicao.FinalizaVariaveis;
begin
  inherited;
end;

procedure TRegProdutoReposicao.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(Sb_Pesquisar,'BUSCAR');
  CarregaImagemBotao(Sb_Sair,'SAIR');
end;

procedure TRegProdutoReposicao.IniciaVariaveis;
begin
  inherited;
  ShowData;
end;

procedure TRegProdutoReposicao.Save;
begin
  FDataset.FieldByName('PPD_CODPRO_D').AsString := E_CodPro.Text;
  FDataset.FieldByName('PRO_DESCRICAO').AsString  := E_Descricao.Text;
  FDataset.FieldByName('PPD_QTDE_USED').AsFloat   := StrtoFloatDef(E_pacote_grande.Text,0);
  FDataset.FieldByName('PPD_QTDE').AsFloat        := StrtoFloatDef(E_pacote_pequeno.Text,0);
  FDataset.FieldByName('PPD_METODO').AsString     := CB_METODO.Text;
  FDataset.Post;
end;


procedure TRegProdutoReposicao.Limpa;
begin

end;

procedure TRegProdutoReposicao.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(nil);
  Try
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    if (E_Descricao.Text <> '') then
      Lc_Form.E_BuscaDescricao.Text := E_Descricao.Text
    else
      Lc_Form.E_BuscaDescricao.Clear;

    if (E_Codpro.Text <> '') then
      Lc_Form.E_BuscaCodigo.Text := E_CodPro.Text
    else
      Lc_Form.E_BuscaCodigo.Clear;

    Lc_Form.ShowModal;
    //Depois que Fecha o Relatorio
    if Lc_Form.It_Visualizar then
    Begin
      E_CodPro.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      Pc_Tip_Busca('P',Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,'');
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TRegProdutoReposicao.Pc_PreencheTela;
begin
  E_CodPro.OnExit := Nil;
  E_Descricao.OnExit := Nil;

  E_CodPro.Text := Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
  E_Descricao.Text := Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
  E_pacote_grande.SetFocus;

  E_CodPro.OnExit := ExitFieldCodpro;
  E_Descricao.OnExit := ExitFieldDescricao;
end;

procedure TRegProdutoReposicao.Pc_Tip_Busca(Pc_Tipo: char; Pc_cd_Prod,
  Pc_Desc_prod: String);
Var
   Lc_Nr_Itens : Integer;
   Lc_Cd_Tabela : Integer;
   Lc_Vl_Produto : Real;
   Lc_Qt_Minima : real;
Begin
  IF (Pc_cd_Prod = '') and (Pc_Desc_prod = '') then exit;
  Lc_Nr_Itens :=  FC_Buscar(Pc_Tipo, Pc_cd_Prod,Pc_Desc_prod);
  case Lc_Nr_Itens of
    0:Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Produto não encontrado.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                        ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        Limpa;
        E_Descricao.SetFocus;
        exit;
      end;
    1:Begin
      if Qr_Pesquisa.FieldByName('PRO_ATIVO').AsString <> 'S' then
        Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Este produto está inativo.'+EOLN+
                       'Verfique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpErro);
        Screen.Cursor := crDefault;
        E_CodPro.Clear;
        exit;
        end;
      Pc_PreencheTela;
      E_pacote_grande.SetFocus;
      FInserir:=True;
      end;
    else
       Pc_MostraBusca;
  end;
  Screen.Cursor := crDefault;
end;

procedure TRegProdutoReposicao.SB_GravarClick(Sender: TObject);
begin
  if ValidateSave then
  Begin
    Save;
    Close;
  end;
end;

procedure TRegProdutoReposicao.Sb_PesquisarClick(Sender: TObject);
begin
  Pc_MostraBusca;
end;

procedure TRegProdutoReposicao.Sb_SairClick(Sender: TObject);
begin
  FDataset.Cancel;
  Close;
end;

procedure TRegProdutoReposicao.setFDataset(const Value: TClientDataSet);
begin
  FDataset := Value;
end;

procedure TRegProdutoReposicao.setFStateChange(const Value: String);
begin
  FStateChange := Value;
end;

procedure TRegProdutoReposicao.ShowData;
begin
  E_CodPro.Text         := FDataset.FieldByName('PPD_CODPRO_D').AsString;
  E_Descricao.Text      := FDataset.FieldByName('PRO_DESCRICAO').AsString;
  E_pacote_grande.Text  := FloatToStrF( FDataset.FieldByName('PPD_QTDE_USED').AsFloat,ffFixed,10,2);
  E_pacote_pequeno.Text := FloatToStrF( FDataset.FieldByName('PPD_QTDE').AsFloat,ffFixed,10,2);
  CB_METODO.ItemIndex := AnsiIndexStr(UpperCase(FDataset.FieldByName('PPD_METODO').AsString), ['NEGATIVO', 'CASCATA','SORTIDO'])
end;

function TRegProdutoReposicao.ValidateSave: Boolean;
begin
  Result := True;
  if (E_Descricao.Text = '') then
  Begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    Exit;
  End;

  if (StrToIntDef(E_CodPro.Text,0) = 0) then
  Begin
    TMsgSetes.ValidaPreenchimentoCampo(L_CodPro.Caption);
    Result := False;
    Exit;
  End;

  if (StrToFloatDef(E_pacote_grande.Text,0) = 0) then
  Begin
    TMsgSetes.ValidaPreenchimentoCampo(L_pacote_grande.Caption);
    Result := False;
    Exit;
  End;

  if (StrToFloatDef(E_pacote_pequeno.Text,0) = 0) then
  Begin
    TMsgSetes.ValidaPreenchimentoCampo(L_pacote_pequeno.Caption);
    Result := False;
    Exit;
  End;

  if (CB_METODO.Text = '') then
  Begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Metodo.Caption);
    Result := False;
    Exit;
  End;

end;

end.
