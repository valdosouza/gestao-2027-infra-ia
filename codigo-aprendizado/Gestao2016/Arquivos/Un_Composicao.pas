unit Un_Composicao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, STQuery, Mask, QEdit_Setes;

type
  TFr_Composicao = class(TForm)
    Qr_Pesquisa: TSTQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Label4: TLabel;
    Label19: TLabel;
    Label1: TLabel;
    E_Descricao: TEdit;
    E_Qtde: TEdit_Setes;
    E_CodPro: TEdit;
    SB_Gravar: TBitBtn;
    Sb_Pesquisar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    procedure E_CodProEnter(Sender: TObject);
    procedure E_CodProExit(Sender: TObject);
    procedure E_DescricaoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure E_QtdeEnter(Sender: TObject);
    procedure E_QtdeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_PesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure E_DescricaoEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      It_Tp_servico: string;
      It_Tp_Produto: string;

    it_bt_pesquisa:Boolean;

    It_StateChange : Integer;
    It_Cd_composicao : Integer;
    It_Cd_Produto : Integer;
    It_Cd_Item : Integer;
    It_Inserir : boolean;
    It_Visualizar: Boolean;
    It_Cd_Prod_D : Integer;
    FUNCTION fC_Buscar(Pc_Tipo: char;Pc_Codigo : String ; Pc_Descricao : String):Integer;
    procedure Pc_CriaComposicao;
    procedure Pc_StateChange(Pc_Tipo:integer);
    PROcedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Prod:String; Pc_Desc_prod:String);
    pROCEDURE Pc_LimpaCampos;
    pROCEDURE Pc_PreencheTela;
    procedure Pc_MostraBusca;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_InserirNovoItem;
    procedure Pc_ImagemBotao;
  end;

var
  Fr_Composicao: TFr_Composicao;

implementation

uses     Un_DM, UN_Sistema, Un_Pesq_Produto, UN_MSG, UN_Principal, env;
{$R *.dfm}

procedure TFr_Composicao.Pc_CriaComposicao;
Var
  Lc_qry : TSTQuery;
  Lc_SqlTxt : String;
Begin
  Try
    Lc_qry := TSTQuery.Create(nil);
    with Lc_Qry do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IBT_Crud;
      Close;
      SQL.Clear;
      If It_StateChange = 2 then
      Begin
        Lc_SqlTxt := 'INSERT INTO TB_PROD_PROD ( '+
                     '  "PPD_CODPRO_M",          '+
                     '  "PPD_CODPRO_D",          '+
                     '  "PPD_QTDE")              '+
                     'VALUES(                    '+
                     ' :"PPD_CODPRO_M",          '+
                     ' :"PPD_CODPRO_D",          '+
                     ' :"PPD_QTDE")              ';
      end;

      If It_StateChange = 3 then
      Begin
        Lc_SqlTxt := 'update TB_PROD_PROD '+
                     'set '+
                     ' PPD_QTDE = :PPD_QTDE '+
                     ' where (PPD_CODPRO_M =:PPD_CODPRO_M) AND '+
                     '       (PPD_CODPRO_D =:PPD_CODPRO_D) ';
      end;

      If It_StateChange = 4 then
      Begin
        Lc_SqlTxt := 'DELETE FROM TB_PROD_PROD  '+
                     ' where (PPD_CODPRO_M =:PPD_CODPRO_M) AND '+
                     '       (PPD_CODPRO_D =:PPD_CODPRO_D) ';
      end;
      SQL.Add(Lc_SqlTxt);
      if not DM.IBT_Crud.InTransaction then DM.IBT_Crud.StartTransaction;
      
      If It_StateChange = 2 then
      Begin
        ParamByName('PPD_CODPRO_M').AsInteger := It_Cd_Produto;
        ParamByName('PPD_CODPRO_D').AsInteger := It_Cd_Prod_D;
        ParamByName('PPD_QTDE').AsFloat := StrToFloatDef(E_Qtde.Text,1);
      end;
      If It_StateChange = 3 then
      Begin
        ParamByName('PPD_CODPRO_M').AsInteger := It_Cd_Produto;
        ParamByName('PPD_CODPRO_D').AsInteger := It_Cd_Prod_D;
        ParamByName('PPD_QTDE').AsFloat := StrToFloatDef(E_Qtde.Text,1);
      end;
      If It_StateChange = 4 then
      Begin
        ParamByName('PPD_CODPRO_M').AsInteger := It_Cd_Produto;
        ParamByName('PPD_CODPRO_D').AsInteger := It_Cd_Prod_D;
      end;
      ExecSQL;
      if DM.IBT_Crud.InTransaction then DM.IBT_Crud.Commit;
    end;
  Finally
    Lc_Qry.close;
    FreeAndNil(Lc_Qry);
  End;
end;

procedure TFr_Composicao.Pc_StateChange(Pc_Tipo:integer);
begin
  It_StateChange := Pc_Tipo;
  E_CodPro.Clear;
  E_Descricao.Clear;
  E_Qtde.Text := '0,00';
  case Pc_Tipo of
    1:Begin   //Normal
      E_CodPro.Enabled := False;
      E_Descricao.Enabled := False;
      E_Qtde.Enabled := False;
      SB_Gravar.Enabled := False;
      Sb_Pesquisar.Enabled := False;
      end;
    2:Begin   //Inserindo
      E_CodPro.Enabled := True;
      E_Descricao.Enabled := True;
      E_Qtde.Enabled := True;
      SB_Gravar.Enabled := True;
      Sb_Pesquisar.Enabled := True;
      end;
    3:Begin   //Alterando
      E_CodPro.Enabled := True;
      E_Descricao.Enabled := True;
      E_Qtde.Enabled := True;
      SB_Gravar.Enabled := True;
      Sb_Pesquisar.Enabled := True;
      end;
  end;
end;

{Procedimentos de componentes}
procedure TFr_Composicao.E_CodProEnter(Sender: TObject);
begin
  it_bt_pesquisa:=FALSE;
  E_CodPro.SelectAll;
end;

procedure TFr_Composicao.E_CodProExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
    begin
    if It_StateChange = 1 then
      exit;
    IF (E_CodPro.Text = '') THEN
      begin
      E_Descricao.SetFocus;
      exit;
      end;
    Pc_Tip_Busca('B', E_CodPro.Text,'');
    end;
END;    

procedure TFr_Composicao.E_DescricaoExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
    begin
    if It_StateChange = 1 then
      exit;
    IF (E_Descricao.Text = '') THEN
      begin
      E_Qtde.SetFocus;
      exit;
      end;
    Pc_Tip_Busca('B', '',Copy(E_Descricao.Text,1,50))
    end;
end;

procedure TFr_Composicao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
      case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F7: if SB_Pesquisar.Enabled then
            begin
            it_bt_pesquisa:=true;
            Sb_Pesquisar.SetFocus;
            Pc_MostraBusca;
            end;
      VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
    end;
end;

procedure TFr_Composicao.Pc_InserirNovoItem;
begin
  Pc_StateChange(2);
  It_Cd_Prod_D := 0;
  E_CodPro.Text;
  E_Qtde.Text := '1';
  E_CodPro.SetFocus;
  E_CodPro.SelectAll;
end;

procedure TFr_Composicao.SB_GravarClick(Sender: TObject);
begin
  try
    Pc_CriaComposicao;
    Pc_StateChange(1);
    Pc_LimpaCampos;
    Pc_InserirNovoItem;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a inserção dos dados.'+EOLN+
                   'Verifique se o mesmo já consta na lista.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Composicao.Sb_PesquisarClick(Sender: TObject);
begin
  Pc_MostraBusca;
end;

procedure TFr_Composicao.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Composicao.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Composicao.FormCreate(Sender: TObject);
begin
  E_Qtde.Alignment := TAlignment(1);
  Pc_PermissaoBotao('Composição');
end;

procedure TFr_Composicao.E_QtdeEnter(Sender: TObject);
begin
  E_Qtde.SelectAll;
end;

procedure TFr_Composicao.E_QtdeExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Qtde.Text,1);
  E_Qtde.Text := FormatFloat('0.00####', Lc_Valor);
end;

procedure TFr_Composicao.Pc_Tip_Busca(Pc_Tipo: char; Pc_cd_Prod, Pc_Desc_prod: String);
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
        Pc_LimpaCampos;
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
      E_Qtde.SetFocus;
      It_Inserir:=True;
      end;
    else
       Pc_MostraBusca;
    end;
   Screen.Cursor := crDefault;
end;

function TFr_Composicao.FC_Buscar(Pc_Tipo: char; Pc_Codigo,
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

  if (It_Tp_Servico = 'S') then Sqltxt := Sqltxt + 'and (PRO_TIPO = ''S'') '
  else
  if (It_Tp_Produto <> '') then Sqltxt := Sqltxt + 'and (PRO_TIPO =:PRO_TIPO)'
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

  if (It_Tp_Produto <> '') then Qr_Pesquisa.ParamByName('PRO_TIPO').AsString := It_Tp_Produto;
  if not GB_ProdCompartilha  then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;    

  if DM.IBT_Estoque.InTransaction then DM.IBT_Estoque.Commit;
  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result:=Qr_Pesquisa.RecordCount;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Composicao.Pc_LimpaCampos;
begin
  It_Inserir := False;
  E_CodPro.Clear;
  E_Descricao.Clear;
  Screen.Cursor:=crDefault;
  exit;
end;

procedure TFr_Composicao.Pc_PreencheTela;
begin
  It_Cd_Prod_D := Qr_Pesquisa.FieldByName('PRO_CODIGO').AsInteger;
  E_CodPro.Text := Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
  E_Descricao.Text := Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
End;

procedure TFr_Composicao.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(nil);
  Try
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    if (E_Descricao.Text <> '') then
    begin
      Lc_Form.E_BuscaDescricao.Text := E_Descricao.Text;
    end
    else
    begin
      Lc_Form.E_BuscaDescricao.Clear;
    end;

    if (E_CodPro.Text <> '') and (It_StateChange = 2) then
      Lc_Form.E_BuscaCodigo.Text :=  E_CodPro.Text
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

procedure TFr_Composicao.FormShow(Sender: TObject);
begin
  it_bt_pesquisa:=FALSE;
  Pc_ImagemBotao;
end;

procedure TFr_Composicao.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Pesquisar.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;


procedure TFr_Composicao.Sb_PesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  Sb_Pesquisar.SetFocus;
end;

procedure TFr_Composicao.E_DescricaoEnter(Sender: TObject);
begin
  it_bt_pesquisa:=FALSE;
end;

procedure TFr_Composicao.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Inserir := True;
    It_Visualizar := True;
  end
  else
  begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
  end;
end;

end.

