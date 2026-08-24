unit tas_lanca_item_produtos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, ComCtrls, Grids, DBGrids, STQuery, QEdit_Setes;

type
  TTasLancaItemProdutos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label13: TLabel;
    SB_Gravar: TBitBtn;
    Sb_Pesquisar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    E_CodPro: TEdit;
    E_Produto: TEdit;
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure E_CodProExit(Sender: TObject);
    procedure E_ProdutoExit(Sender: TObject);
    procedure E_CodProEnter(Sender: TObject);
    procedure E_ProdutoEner(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure E_Cons_UnitarioExit(Sender: TObject);
    procedure E_Cons_UnitarioEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_PesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }

  public
    { Public declarations }
    It_Bt_Pesquisa: Boolean;
    It_Visualizar: Boolean;
    It_Cs_Unitario : Real;
    It_StateChange : Integer;
    It_Tp_Produto:String;
    It_Tp_servico:String;
    It_Cd_Ficha : Integer;
    It_Cd_Produto : Integer;
    It_Cd_Vinculo : Integer;
    It_Tipo : String;
    It_unidade:String;
    It_Menu: String;
    procedure Pc_AtivarTabelas;
    function Fc_EditaProduto():Boolean;
    FUNCTION FC_Buscar(pc_TIPO:STRING;Pc_Codigo : String ; Pc_Descricao : String ): INTEGER;
    procedure Pc_MostraBusca;
    procedure Pc_PreencheTela(Pc_Codpro : String; Pc_DESCRICAO : String;
                              Pc_VL_Venda : Real ;Pc_Unidade : String;Pc_Aliq_Com : Real; Pc_VL_Atual : Real);
    function Fc_ValidaCampos():Boolean;
    procedure Pc_LimpaCampos;
    procedure Pc_Fr_FichaTecnica(Pc_tipo : String; Pc_Codvcl : Integer; Pc_cd_Produto : Integer; Pc_Produto : String; Pc_Unidade : String;
              Pc_Vl_Unit : real; Pc_Cs_Unit : real; Pc_Tx_Partic : real);

    procedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Prod:String; Pc_Desc_prod:String);
    function fc_Validagravacao:boolean;
    procedure Pc_ImagemBotao;
    procedure Pc_InserirNovoItem;
  end;

var
  TasLancaItemProdutos: TTasLancaItemProdutos;

implementation

uses
      Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, Un_Pesq_Produto, Un_Cotacao, Un_Pesq_Servico, Un_Fc_Sored_Procedures;

{$R *.dfm}

function TTasLancaItemProdutos.Fc_EditaProduto():Boolean;
Var
  Lc_Qtde : Real;
Begin
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('ITF_CODPED').AsInteger := 0;
  Qr_Itens.ParamByName('PRO_CODIGO').AsInteger := It_Cd_Vinculo;
  Qr_Itens.Active := True;
  Qr_Itens.First;

  if (Qr_Itens.RecordCount > 0) and (It_StateChange = 2) then
    Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'O Produto '+E_Produto.Text +' já está no relação.'+EOLN+EOLN+
                       'O que deseja fazer ?',
                      ['Atualizar','Cancelar'],[bNormal,bEscape],mpConfirmacao,clBtnFace) = mrBotao1) then
      begin
      It_StateChange := 3;
      Lc_Qtde := StrToFloatDef(E_Cons_Unitario.Text,0);
      E_Cons_Unitario.Text := FloatToStrF(Lc_Qtde + Qr_Itens.FieldByName('ITF_QTDE').AsFloat, ffFixed,10,2);
      Result := true;
      end
    else
      Begin
      Result := False;
      end;
    end
  else
    Begin
    Result := true;
    end;
end;

procedure TTasLancaItemProdutos.Pc_AtivarTabelas;
begin

end;

FUNCTION TTasLancaItemProdutos.fC_Buscar(pc_TIPO:STRING;Pc_Codigo : String ; Pc_Descricao : String ): INTEGER;
var
  Sqltxt:string;
  Lc_Codigo: boolean;
  Lc_Descricao: boolean;
  lc_I : Integer;
  Lc_VL_Poduto : Real;
  Lc_Ali_COm : Real;
  Lc_CodigoInteiro:Integer;
begin
  sqltxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  Sqltxt := ' SELECT PRO_CODIGO, PRO_CODIGOFAB, PRO_CODIGOFOR, PRO_DESCRICAO,          '+
            ' PRO_VL_CUSTO,  MED_ABREVIATURA, PRO_CAMPANHA, PRO_VL_CUSTOMED,PRO_ATIVO  '+
            ' FROM TB_PRODUTO tb_produto                                               '+
            ' inner JOIN tb_medida tb_medida                                           '+
            ' ON tb_medida.med_codigo = tb_produto.pro_codmed                          '+
            ' WHERE (PRO_CODIGO IS NOT NULL)                                           ';

  if Pc_Codigo = '' then Lc_Codigo:=False Else Lc_Codigo:=True;
  if Pc_Descricao = '' then Lc_Descricao:=False Else Lc_Descricao:=True;

  Lc_CodigoInteiro := StrToIntDef(Pc_Codigo,0);

  IF Lc_Codigo THEN
  BEGIN
    IF (Pc_Tipo = 'P') then
    BEGIN
      Sqltxt := Sqltxt + 'AND pRO_CODIGO =:PRO_CODIGO ';
    end
    else
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO', 'PRO_P_COD_EXATO', 'S')='S') THEN
      BEGIN
        IF (Lc_CodigoInteiro>0) THEN
           Sqltxt:= Sqltxt + 'AND ( (PRO_CODIGO =:PRO_CODIGO) OR (PRO_CODIGOFAB =:PRO_CODIGO))'
        ELSE
           Sqltxt := Sqltxt + 'and PRO_CODIGOFAB =:PRO_CODIGO';
      END
      ELSE
         Sqltxt := Sqltxt + 'AND ((PRO_CODIGO LIKE :PRO_CODIGO) OR  (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO))';
    END;
  END;

  if (It_Tp_Servico = 'S') then Sqltxt := Sqltxt + 'and (PRO_TIPO = ''S'') '
  else
  if (It_Tp_Produto <> '') then Sqltxt := Sqltxt + 'and (PRO_TIPO =:PRO_TIPO)'
  ELSE
    Sqltxt := Sqltxt + 'and (PRO_TIPO <> ''S'') ';


  if Lc_Descricao then Sqltxt:=Sqltxt+'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

  if not GB_ProdCompartilha then   Sqltxt:=Sqltxt+ 'AND PRO_CODMHA = :PRO_CODMHA';

  Qr_Pesquisa.SQL.Add(sqltxt + ' ORDER BY PRO_DESCRICAO');

//PASSAGEM de parametro
  IF Lc_Codigo THEN
  BEGIN
    IF (Pc_Tipo = 'P') then
    BEGIN
      Qr_Pesquisa.ParamByName('PRO_CODIGO').AsString := Pc_Codigo;
    end
    else
    Begin
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
  end;

  if (It_Tp_Produto <> '') then Qr_Pesquisa.ParamByName('PRO_TIPO').AsString := It_Tp_Produto;

  if Lc_Descricao then Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString :='%'+ Copy(Pc_Descricao,1,98)+'%';
  if not GB_ProdCompartilha then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;  

  Qr_Pesquisa.Open;
  It_unidade:= Qr_Pesquisa.fieldbyname('MED_ABREVIATURA').AsString;
  Qr_Pesquisa.FetchAll;
  Result:=Qr_Pesquisa.RecordCount;
end;


procedure TTasLancaItemProdutos.Pc_PreencheTela(Pc_Codpro : String; Pc_DESCRICAO : String;  Pc_VL_Venda : Real ;Pc_Unidade : String;Pc_Aliq_Com : Real; Pc_VL_Atual : Real);
var
  Lc_Codigo: integer;
  lc_Multiplicador : Real;
begin
  E_CodPro.Text    := Pc_Codpro;
  E_Produto.Text := Pc_DESCRICAO;
  Lc_Multiplicador := 1;

end;

procedure TTasLancaItemProdutos.Pc_MostraBusca;
Var
  Lc_Fr_Serv : TFr_Pesq_Servico;
  Lc_Fr_Prod : TFr_Pesq_Produto;
begin
  if It_Tp_servico = 'S' then
  Begin
    Lc_Fr_Serv := TFr_Pesq_Servico.Create(nil);
    Lc_Fr_Serv.E_BuscaCodigo.Text := E_CodPro.Text;
    Lc_Fr_Serv.E_BuscaDescricao.Text := E_Produto.Text;
    Lc_Fr_Serv.ShowModal;
    if Lc_Fr_Serv.It_Visualizar then
    Begin
      E_CodPro.Text:= Lc_Fr_Serv.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      E_Produto.Text:= Lc_Fr_Serv.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      Pc_Tip_Busca('P',Lc_Fr_Serv.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,'');
    end;
    FreeAndNil(Lc_Fr_Serv);
  end
  else
  Begin
    Lc_Fr_Prod := TFr_Pesq_Produto.Create(nil);
    Lc_Fr_Prod.it_Modalidade_preco := 'A';
    Lc_Fr_Prod.Pc_Tabelas_Disponiveis;
    Lc_Fr_Prod.E_BuscaCodigo.Text := E_CodPro.Text;
    Lc_Fr_Prod.E_BuscaDescricao.Text := E_Produto.Text;
    Lc_Fr_Prod.It_Tipo_Especifico := It_Tp_Produto;
    Lc_Fr_Prod.ShowModal;
    if Lc_Fr_Prod.It_Visualizar then
    Begin
      E_CodPro.Text:=  Lc_Fr_Prod.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      E_Produto.Text:= Lc_Fr_Prod.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
      Pc_Tip_Busca('P',Lc_Fr_Prod.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,'');
    end;
    FreeAndNil(Lc_Fr_Prod);
  end;
end;

procedure TTasLancaItemProdutos.Pc_LimpaCampos;
BEGIN
  E_CodPro.Text := '';
  E_Produto.Clear;
  E_Cons_Unitario.Text := '0';
end;

function TTasLancaItemProdutos.Fc_ValidaCampos():Boolean;
Var
  Lc_Result : Boolean;
Begin
  Lc_Result := True;
  if (E_CodPro.Text = '') or
     (E_Produto.Text = '') or
     (E_Cons_Unitario.Text = '') then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Favor Preencher Todos os Campos.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Lc_Result := False;
    end;
  Result := Lc_Result;

end;



procedure TTasLancaItemProdutos.Pc_Fr_FichaTecnica(Pc_tipo : String; Pc_Codvcl : Integer; Pc_cd_Produto : Integer; Pc_Produto : String; Pc_Unidade : String;
          Pc_Vl_Unit : real; Pc_Cs_Unit : real; Pc_Tx_Partic : real);
Var
  Lc_Oper_Reg : String;
Begin
  try
    Screen.Cursor := crHourGlass;
    case It_StateChange of
      2:Begin
        It_Cd_Ficha := Fc_Generator('GN_FICHA_TECNICA','TB_FICHA_TECNICA','FTC_CODIGO');
        Lc_Oper_Reg := 'I';
        end;
      3:Begin
        Lc_Oper_Reg := 'E';
        end;
      4:Begin
        Lc_Oper_Reg := 'A';
        end;
     end;
    Un_Fc_Sored_Procedures.Pc_Fr_FichaTecnica(Lc_Oper_Reg, It_Cd_Ficha, Pc_Tipo, 0, 0, Pc_CodVcl,
      Pc_Produto, Pc_Unidade, Pc_Vl_Unit, Pc_Cs_Unit, Pc_Tx_Partic, Pc_cd_Produto);

    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a gravação dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    DM.IB_Transacao.RollbackRetaining;
  end;
  Screen.Cursor := crDefault;
end;

// Procedures Internas

function TTasLancaItemProdutos.fc_Validagravacao:boolean;
Begin
  Result := True;
  if trim(E_Produto.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nome do Produto deve ser informado.'+EOLN+
                   'Preencha o Nome do produto.' +EOLN,
                   ['OK'], [bEscape], mpErro);
    E_Produto.SetFocus;
    Result := False;
    exit;
    end;

  if trim(E_Cons_Unitario.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O Consumo unitário deve ser informado.'+EOLN+
                   'Preencha o Consumo unitário.' +EOLN,
                   ['OK'], [bEscape], mpErro);
    E_Cons_Unitario.SetFocus;
    Result := False;
    exit;
    end;

end;

procedure TTasLancaItemProdutos.SB_GravarClick(Sender: TObject);
Begin
  E_Produto.SetFocus;
  if Fc_EditaProduto then
  Begin
    if Fc_ValidaCampos then
    Begin
      Pc_Fr_FichaTecnica(It_Tipo, It_Cd_Vinculo, It_Cd_Produto, e_produto.text, It_unidade, 0,StrToFloatDef(E_Cons_Unitario.Text,0),StrToFloatDef(E_Cons_Unitario.Text,0));
      It_StateChange := 1;
      Pc_LimpaCampos;
      Pc_InserirNovoItem;
    End;
  end;
end;

procedure TTasLancaItemProdutos.Pc_InserirNovoItem;
Begin
  It_StateChange := 2;
  E_CodPro.SetFocus;
  E_CodPro.SelectAll;
end;

procedure TTasLancaItemProdutos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TTasLancaItemProdutos.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TTasLancaItemProdutos.Sb_PesquisarClick(Sender: TObject);
begin
  E_CodPro.SetFocus;
  Pc_MostraBusca;
end;

procedure TTasLancaItemProdutos.Sb_Sair_0Click(Sender: TObject);
begin
  close;
end;


procedure TTasLancaItemProdutos.E_CodProExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
    begin
    if It_StateChange = 1 then
      exit;
    IF (E_CodPro.Text = '') THEN
      begin
      E_Produto.SetFocus;
      exit;
      end;
    Pc_Tip_Busca('B', E_CodPro.Text,'');
    end;
end;

procedure TTasLancaItemProdutos.E_ProdutoExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
    begin
    if It_StateChange = 1 then
      exit;
    IF (E_Produto.Text = '') THEN
      begin
      E_Cons_Unitario.SetFocus;
      exit;
      end;
    Pc_Tip_Busca('B', '',Copy(E_Produto.Text,1,50))
    end;
end;

procedure TTasLancaItemProdutos.E_CodProEnter(Sender: TObject);
begin
  it_bt_pesquisa:=FALSE;
  E_CodPro.SelectAll;
end;

procedure TTasLancaItemProdutos.E_ProdutoEner(Sender: TObject);
begin
  it_bt_pesquisa:=FALSE;
  E_Produto.SelectAll;
end;

procedure TTasLancaItemProdutos.TabSheet1Show(Sender: TObject);
begin
  Height:= 245 - 18;
  if (It_StateChange = 2) or (It_StateChange = 3)then E_CodPro.SetFocus;

end;

procedure TTasLancaItemProdutos.E_Cons_UnitarioExit(Sender: TObject);
begin
  It_Cs_Unitario :=StrToFloatDef(E_Cons_Unitario.Text,1);
end;

procedure TTasLancaItemProdutos.E_Cons_UnitarioEnter(Sender: TObject);
begin
  E_Cons_Unitario.SelectAll;
end;

procedure TTasLancaItemProdutos.Pc_Tip_Busca(Pc_Tipo: char; Pc_cd_Prod,
  Pc_Desc_prod: String);
Var
  Lc_Nr_Itens : Integer;
  Lc_Cd_Tabela : Integer;
  Lc_Ali_COm,  Lc_VL_Poduto : Real;  
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
        E_Produto.SetFocus;
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
      It_Cd_Vinculo := Qr_Pesquisa.FieldByName('PRO_CODIGO').AsInteger;
      Lc_VL_Poduto := Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency;
      Pc_PreencheTela(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,
                      Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString,
                      Lc_VL_Poduto,
                      Qr_Pesquisa.FieldByName('MED_ABREVIATURA').AsString,
                      Lc_Ali_COm,
                      Lc_VL_Poduto);
      E_Cons_Unitario.SetFocus;
      end;
    else
       Pc_MostraBusca;
    end;
   Screen.Cursor := crDefault;
end;

procedure TTasLancaItemProdutos.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Pesquisar.Glyph.Assign(Fc_CarregaImagemBotao('PESQUISAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TTasLancaItemProdutos.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  It_Bt_Pesquisa := False;
end;

procedure TTasLancaItemProdutos.Sb_PesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa := True;
  Sb_Pesquisar.SetFocus;
end;

end.


