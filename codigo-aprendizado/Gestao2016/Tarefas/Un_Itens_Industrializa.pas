unit Un_Itens_Industrializa;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, ComCtrls, Grids, DBGrids, STQuery, ActnList, QEdit_Setes, System.Actions, ControllerItensInd;

type
   TFr_Itens_Industrializa = class(TForm)
      Qr_Pesquisa: TSTQuery;
      Ds_Pesquisa: TDataSource;
    Qr_Tabela: TSTQuery;
      Ds_Tabela: TDataSource;
    Qr_Preco_Qtde: TSTQuery;
    Pnl_fundo: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    SB_Inserir: TBitBtn;
    SB_Gravar: TBitBtn;
    Sb_Pesquisar: TBitBtn;
    Sb_Sair_0: TBitBtn;
    E_CodPro: TEdit;
    E_Qt_Produto: TEdit_Setes;
    E_Vl_Unitario: TEdit_Setes;
    E_Descricao: TEdit;
    E_Unidade: TEdit;
    Sb_Limpar: TBitBtn;
    E_Vl_SubTotal: TPanel;
    ActionList1: TActionList;
    Action1: TAction;
      procedure SB_GravarClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure Sb_PesquisarClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure SB_InserirClick(Sender: TObject);
      procedure E_Vl_UnitarioExit(Sender: TObject);
      procedure E_Qt_ProdutoExit(Sender: TObject);
      procedure E_CodProExit(Sender: TObject);
      procedure E_DescricaoExit(Sender: TObject);
      procedure E_Vl_UnitarioEnter(Sender: TObject);
      procedure E_Qt_ProdutoEnter(Sender: TObject);
      procedure E_CodProEnter(Sender: TObject);
      procedure E_DescricaoEnter(Sender: TObject);
      procedure E_Qt_ProdutoChange(Sender: TObject);
      procedure FormShow(Sender: TObject);
    procedure Sb_LimparClick(Sender: TObject);
    procedure E_UnidadeEnter(Sender: TObject);
    procedure Sb_PesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Sb_Sair_0MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Sb_LimparMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Action1Execute(Sender: TObject);
   private
    { Private declarations }

   public
    { Public declarations }
      It_Cd_Industrializa: Integer;
      It_Pes_cod_barra:String;
      it_bt_pesquisa:Boolean;

      It_Inserir: Boolean;
      it_Cd_Empresa: integer;

      It_Cd_Itens: Integer;
      It_Cd_Produto: Integer;
      It_cd_Prod_ant :string;
            
      It_Disponivel: string;
      //TOTALIZADORES

      IT_CAMPOEDIT:STRING;
      It_Qt_Produto: Real;
      It_VL_Unitario: Currency;
      It_Vl_Subtotal: Currency;

      It_StateChange: Integer;
      IT_VL_Ant, It_Vl_Atual: Real;
      Function FC_Buscar(Pc_Tipo: char; Pc_Cd_Tabela:Integer; Pc_Codigo: string; Pc_Descricao: string):Integer;
      procedure Pc_MostraBusca;
      PROcedure Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Tabela :Integer; Pc_cd_Prod:String; Pc_Desc_prod:String);
      procedure Pc_PreencheTela(Pc_Cd_Tabela : Integer;
                                Pc_Codpro: string;
                                Pc_DESCRICAO: string;
                                Pc_VL_Venda: Real;
                                Pc_Custo: Real;
                                Pc_Unidade: string;
                                Pc_Aliq_Com: Real;
                                Pc_Qtde: Real);
      function Fc_ValidaCampos(): Boolean;
      procedure Pc_Totalizador;
      procedure Pc_LimpaCampos;

      procedure Pc_FormataTela;
      procedure Pc_IniciaVariaveis;
      procedure Pc_Fr_ItensIndustrializa;

      function Fc_EditaProduto(): Boolean;
      function Fc_Busca_Cod_barra(Pc_cod_barra:String): Integer;
      procedure Pc_StateChange(Pc_Tipo: integer);
   end;

var
   Fr_Itens_Industrializa: TFr_Itens_Industrializa;

implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, Un_Pesq_Produto, UN_Pedido_Cpa, Un_Fc_Sored_Procedures, Un_Liberacao;
{$R *.dfm}


function TFr_Itens_Industrializa.Fc_EditaProduto(): Boolean;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Qtde: Real;
   Lc_Escolha: Integer;
begin
{  //Cria a Consulta de Estoques Disponiveis
   Lc_Qry := TSTQuery.Create(Self);
   Lc_Qry.Database := DM.IBD_Gestao;
   Lc_Qry.Transaction := DM.IB_Transacao;
   Lc_Qry.Active := False;
   Lc_Qry.SQL.Clear;
   Lc_SqlTxt := 'SELECT PRO_CODIGOFOR, ITF_QTDE, ITF_CODIGO ' +
      ' FROM TB_ITENS_NFL Tb_itens_nfl ' +
      '    INNER JOIN TB_PRODUTO Tb_produto ' +
      '    ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) ' +
      ' WHERE PRO_CODIGO=:PRO_CODIGO AND (ITF_CODPED=:ITF_CODPED) and (ITF_OPER=:ITF_OPER) ';
   Lc_Qry.SQL.Add(Lc_SqlTxt);
   Lc_Qry.Active := False;
   Lc_Qry.ParamByName('ITF_OPER').AsString := It_Tp_Operacao;
   Lc_Qry.ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
   Lc_Qry.ParamByName('PRO_CODIGO').AsInteger := It_Cd_Produto;
   Lc_Qry.Active := True;
   Lc_Qry.FetchAll;
   Lc_Qry.First;

   if (Lc_Qry.RecordCount > 0) and (It_StateChange = 2) then
     begin
       Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                     'O Produto ' + E_Descricao.Text + ' já está no relação.' + EOLN + EOLN +
                                     'O que deseja fazer ?',
                                     ['Atualizar', 'Inserir','Cancelar'], [bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
       case Lc_Escolha of
          0:
            begin
            It_Cd_Itens := Lc_Qry.FieldByName('ITF_CODIGO').AsInteger;
            It_StateChange := 3;
            Lc_Qtde := StrToFloatDef(E_Qt_Produto.Text,0);
            E_Qt_Produto.Text := FloatToStrF(Lc_Qtde + Lc_Qry.FieldByName('ITF_QTDE').AsFloat, ffFixed, 10, 2);
            Result := true;
            end;
          1:
            begin
            Result := True;
            end;
          2:
            begin
            Result := False;
            end;
       end;
     end
   else
     begin
     Result := true;
     end;
}
end;

procedure TFr_Itens_Industrializa.Pc_FormataTela;
begin
  if E_CodPro.CanFocus then E_CodPro.SetFocus;
end;

procedure TFr_Itens_Industrializa.Pc_IniciaVariaveis;
begin
  It_cd_Prod_ant:=E_CodPro.Text;
  It_Pes_cod_barra:= Fc_Tb_Geral('L','GRL_G_PES_COD_BARRA','');
  it_bt_pesquisa:=FALSE;
end;


function TFr_Itens_Industrializa.FC_Buscar(Pc_Tipo: char; Pc_Cd_Tabela:Integer; Pc_Codigo: string; Pc_Descricao: string):Integer;
var
   Lc_SqlTxt: string;
   Lc_Codigo: boolean;
   Lc_Descricao: boolean;
   Lc_CodigoInteiro: Integer;
   Lc_Barras: Integer;
begin
  Lc_SqlTxt := '';
  It_Cd_Produto := 0;
  Screen.Cursor := crHourGlass;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;

  Lc_SqlTxt :=  'SELECT                                           '+
                '   PRO_CODIGO,                                   '+
                '   PRO_CODIGOFAB,                                '+
                '   PRO_CODIGOFOR,                                '+
                '   PRO_CODIGOBAR,                                   '+
                '   PRO_DESCRICAO,                                '+
                '   PRO_VL_CUSTO,                                 '+
                '   MED_ABREVIATURA,                              '+
                '   PRO_CAMPANHA,                                 '+
                '   PRO_PESO,                                    '+
                '   PRO_ATIVO                                     '+
                'FROM TB_PRODUTO tb_produto                       '+
                '   INNER JOIN TB_MEDIDA MED                      '+
                '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                'WHERE (PRO_CODIGO IS NOT NULL)                   ';

  if Pc_Codigo = '' then    Lc_Codigo := False else  Lc_Codigo := True;
  if Pc_Descricao = '' then Lc_Descricao := False  else Lc_Descricao := True;

  Lc_CodigoInteiro := StrToIntDef(Pc_Codigo, 0);
  Lc_Barras := Length(Pc_Codigo);
  IF Lc_Codigo THEN
  BEGIN
    if Pc_Tipo ='P' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODIGO =:PRO_CODIGO) '
    else
    IF (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') AND (Pc_Tipo = 'P') then
    BEGIN
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_CODIGO =:PRO_CODIGO) ';
    end
    else
    Begin
      IF (Fc_Aq_Geral('L', 'PRODUTO','PRO_P_COD_EXATO', 'S')='S') THEN
      BEGIN
        IF (Lc_CodigoInteiro>0) THEN
           Lc_SqlTxt := Lc_SqlTxt + ' AND ( (PRO_CODIGO =:PRO_CODIGO) OR (PRO_CODIGOFAB =:PRO_CODIGO))'
        ELSE
           Lc_SqlTxt := Lc_SqlTxt + ' and PRO_CODIGOFAB =:PRO_CODIGO';
      END
      ELSE
         If Lc_Barras > 8 then
           Lc_SqlTxt := Lc_SqlTxt + ' AND ((PRO_CODIGO LIKE :PRO_CODIGO) OR  (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) OR (PRO_CODIGOBAR LIKE :PRO_CODIGO))'
         else
           Lc_SqlTxt := Lc_SqlTxt + ' AND ((PRO_CODIGO LIKE :PRO_CODIGO) OR  (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO))';
    END;
  END;

  if Lc_Descricao then   Lc_SqlTxt := Lc_SqlTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

  Lc_SqlTxt := Lc_SqlTxt + ' and (PRO_TIPO =:PRO_TIPO)';

   if not GB_ProdCompartilha then   Lc_SqlTxt:=Lc_SqlTxt+ ' AND PRO_CODMHA = :PRO_CODMHA';

  Qr_Pesquisa.SQL.Add(Lc_SqlTxt);

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
  IF Lc_Descricao THEN  Qr_Pesquisa.ParamByName('PRO_DESCRICAO').AsString := '%' + copy(Pc_Descricao,1,98) + '%';
  Qr_Pesquisa.ParamByName('PRO_TIPO').AsString := 'P';
  if not GB_ProdCompartilha  then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result := Qr_Pesquisa.RecordCount;
  IF Result = 1 THEN
    It_Cd_Produto:= Qr_Pesquisa.FIELDBYNAME('PRO_CODIGO').AsInteger;
end;


procedure TFr_Itens_Industrializa.Pc_PreencheTela(Pc_Cd_Tabela : Integer;
                                            Pc_Codpro: string;
                                            Pc_DESCRICAO: string;
                                            Pc_VL_Venda: Real;
                                            Pc_Custo: Real;
                                            Pc_Unidade: string;
                                            Pc_Aliq_Com: Real;
                                            Pc_Qtde: Real);
var
   Lc_Codigo: integer;
begin
  E_CodPro.Text := Pc_Codpro;
  E_Descricao.Text := COPY(Pc_DESCRICAO,1,100);
  IF TRIM(It_cd_Prod_ant) <> TRIM(E_CodPro.Text) THEN
    Begin
    E_Vl_Unitario.Text := formatFloat('0.00####',Pc_VL_Venda);
    E_Unidade.Text := Pc_Unidade;
    if Pc_Qtde = 0 then Pc_Qtde := 1;
    E_Qt_Produto.Text := formatFloat('#,##0.##',Pc_Qtde);
    END;
  if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
  IF (It_Pes_cod_barra = 'S') and E_Qt_Produto.CanFocus THEN
    E_Qt_Produto.SetFocus;
end;

procedure TFr_Itens_Industrializa.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Try
    Lc_Form := TFr_Pesq_Produto.Create(nil);
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    Lc_Form.E_BuscaCodigo.Text := E_CodPro.Text;
    Lc_Form.E_BuscaDescricao.Text := E_Descricao.Text;
    Lc_Form.ShowModal;
  Finally
    //Depois que Fecha o Relatorio
    if Lc_Form.It_Visualizar then
    Begin
      E_CodPro.Text:= Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      E_Descricao.Text:='';
      E_Vl_Unitario.Text := '0';
      Pc_Tip_Busca('P',1,Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,'');
    end;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Itens_Industrializa.Pc_Totalizador;
begin
  It_Qt_Produto := StrToFloatdEF(E_Qt_Produto.Text, 0);
  It_VL_Unitario := StrToFloatDEf(E_Vl_Unitario.Text,0);
  It_Vl_Subtotal := It_Qt_Produto * It_VL_Unitario;
  E_Vl_SubTotal.Caption := FloatToStrF(It_Vl_Subtotal, ffFixed, 10, 2);
end;

procedure TFr_Itens_Industrializa.Pc_LimpaCampos;
begin
   E_CodPro.Text := '';
   E_Descricao.Clear;
   E_Vl_Unitario.Text := '0,00';
   E_Qt_Produto.Text := '1';
   E_Unidade.Clear;
   E_Vl_SubTotal.Caption := '0,00';
end;

function TFr_Itens_Industrializa.Fc_ValidaCampos(): Boolean;
begin
  Result := true;
  if not It_Inserir then exit;
  IF (E_Descricao.Text = '') or (E_Vl_Unitario.Text = '') or (E_Qt_Produto.Text = '') or (E_Vl_SubTotal.Caption = '') then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Favor Preencher Todos os Campos.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
    end;

  if (StrToFloatDEF(E_Vl_Unitario.Text,0) <= 0) then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Valor não Informado na Tabela de Preço.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
    exit;
    end;

  if (StrToFloatDef(E_Qt_Produto.Text, 0) = 0) then
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'A quantidade informada não é valida.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_Qt_Produto.CanFocus then E_Qt_Produto.SetFocus;
    Result := False;
    EXIT;
    end;
end;

procedure TFr_Itens_Industrializa.Pc_StateChange(Pc_Tipo: integer);
begin
   It_StateChange := Pc_Tipo;
   PC_LimpaCampos;
   case Pc_Tipo of
      1:
         begin //Normal
            E_CodPro.Enabled := False;
            E_Descricao.Enabled := False;
            E_Qt_Produto.Enabled := False;
            SB_Inserir.Enabled := True;
            SB_Gravar.Enabled := False;
            Sb_Pesquisar.Enabled := False;
         end;
      2:
         begin //Inserindo
            E_CodPro.Enabled := True;
            E_Descricao.Enabled := True;
            E_Qt_Produto.Enabled := True;
            SB_Inserir.Enabled := False;
            SB_Gravar.Enabled := True;
            Sb_Pesquisar.Enabled := True;
         end;
      3:
         begin //Alterando
            E_CodPro.Enabled := True;
            E_Descricao.Enabled := True;
            E_Qt_Produto.Enabled := True;
            SB_Inserir.Enabled := False;
            SB_Gravar.Enabled := True;
            Sb_Pesquisar.Enabled := True;
         end;
   end;
end;


procedure TFr_Itens_Industrializa.Pc_Fr_ItensIndustrializa;
var
   Lc_Oper_Reg: string;
   LcItensInd: TControllerItensInd;
begin
  Screen.Cursor := crHourGlass;
  LcItensInd := TControllerItensInd.Create(nil);
  try
    case It_StateChange of
      2:begin
        Lc_Oper_Reg := 'I';
        LcItensInd.Registro.Codigo := Fc_Generator('GN_ITENS_IND','TB_ITENS_IND','IIN_CODIGO');
        end;
      3:begin
        Lc_Oper_Reg := 'E';
        LcItensInd.Registro.Codigo := It_Cd_Itens;
        end;
      4:begin
        LcItensInd.Registro.Codigo := It_Cd_Itens;
        LcItensInd.delete;
        Exit;
        end;
      end;
    with LcItensInd.Registro do
    begin
      CodigoIndustrializa := It_Cd_Industrializa;
      CodigoPedido := 0;
      CodigoNota := 0;
      CodigoProduto := It_Cd_Produto;
      Quantidade := StrToFloatDef(E_Qt_Produto.Text,0);
      ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
    end;
    Try
      if Lc_Oper_Reg = 'I' then
        LcItensInd.migra
      else
        LcItensInd.update;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      Pc_StateChange(1);
    except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Um erro impossibilitou a gravação dos dados.' + EOLN +
                     'Entre em contato com o suporte técnico.' + EOLN,
                    ['OK'], [bEscape], mpErro);
      Screen.Cursor := crDefault;
      DM.IB_Transacao.RollbackRetaining;
    end;
  finally
    FreeAndNil(LcItensInd);
  end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Itens_Industrializa.SB_GravarClick(Sender: TObject);
begin
  IF not Fc_ValidaCampos then exit;
  if Fc_EditaProduto then
    begin
    Pc_Fr_ItensIndustrializa
    end;
  Pc_StateChange(1);
  SB_InserirClick(self);
end;

procedure TFr_Itens_Industrializa.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2:if SB_Inserir.Enabled then SB_InserirClick(Sender);
      VK_F5:if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F7:if SB_Pesquisar.Enabled then
              begin
              it_bt_pesquisa:=true;
              if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
              Pc_MostraBusca;
              end;
      VK_F8: if Sb_Limpar.Enabled then Sb_LimparClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then  Sb_Sair_0Click(Sender);
     end;
  end;

end;

procedure TFr_Itens_Industrializa.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not (ActiveControl is TDBMemo) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Itens_Industrializa.Sb_PesquisarClick(Sender: TObject);
begin
 it_bt_pesquisa:=true;
 Pc_MostraBusca;
end;

procedure TFr_Itens_Industrializa.Sb_Sair_0Click(Sender: TObject);
begin
   close;
end;

procedure TFr_Itens_Industrializa.SB_InserirClick(Sender: TObject);
begin
   Pc_StateChange(2);
   It_Cd_Produto := 0;
   E_CodPro.Text;
   E_Qt_Produto.Text := '1';
   if E_CodPro.CanFocus then E_CodPro.SetFocus;
   E_CodPro.SelectAll;
end;

procedure TFr_Itens_Industrializa.E_Vl_UnitarioExit(Sender: TObject);
var
   Lc_Valor: Real;
begin
  Lc_Valor := StrToFloatDef(E_Vl_Unitario.Text, 0);
  E_Vl_Unitario.Text := FormatFloat('0.00####', StrToFloatDef(E_Vl_Unitario.Text, 0));
  Pc_Totalizador;
end;

procedure TFr_Itens_Industrializa.E_Qt_ProdutoExit(Sender: TObject);
VAR
Lc_Qtde: Real;
begin
  Lc_Qtde := StrToFloatDef(E_Qt_Produto.Text, 0);
  Pc_Totalizador;
end;

procedure TFr_Itens_Industrializa.E_CodProExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
    begin
    IT_CAMPOEDIT:='C';
    if It_StateChange = 1 then  exit;
    IF (E_CodPro.Text = '') THEN
      begin
      if E_Descricao.CanFocus then E_Descricao.SetFocus;
      exit;
      end;
    if (E_CodPro.Text <> '') then
      E_Descricao.Text:=''
    else
      if (IntToStr(It_Cd_Produto) <> E_CodPro.Text) then  E_Vl_Unitario.Text := '0,00';
      if (E_CodPro.Text <> '') then
        begin
        E_Descricao.Text:='';
        end;
      IF It_StateChange = 3 THEN
        pc_Tip_Busca('P', 1, E_CodPro.text,'')
      ELSE
        pc_Tip_Busca('B', 1,E_CodPro.text,'')
      end;
    end;

Procedure TFr_Itens_Industrializa.Pc_Tip_Busca(Pc_Tipo:char; Pc_cd_Tabela :Integer; Pc_cd_Prod:String; Pc_Desc_prod:String);
Var
   Lc_Nr_Itens : Integer;
Begin
  IF (Pc_cd_Prod = '') and (Pc_Desc_prod = '') then exit;
  Lc_Nr_Itens:= Fc_Busca_Cod_barra(Pc_cd_Prod);
  if Lc_Nr_Itens > 1 then // houve duplicidade de codigo de barra
    begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Encontrado duplicidade de código de barra.' + EOLN +
                   'Verifique o cadastro e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    end;
  if Lc_Nr_Itens = 0 then  Lc_Nr_Itens := FC_Buscar(Pc_Tipo, Pc_cd_Tabela,Pc_cd_Prod,Pc_Desc_prod);  // nao encontrou codigo de baarra pesquisa normal
  case Lc_Nr_Itens of
    0:Begin
      It_Inserir := False;
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Produto não encontrado.'+EOLN+
                     'Verfique e tente novamente.'+EOLN,
                      ['OK'],[bEscape],mpErro);
      Screen.Cursor := crDefault;
      Pc_LimpaCampos;
      exit;
      end;
    1:Begin
      //vERIFICA SE O PRODUTO ESTA ATIVO
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
      Pc_PreencheTela(1,
                      Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,
                      Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString,
                      Qr_Pesquisa.FieldByName('PRO_PESO').AsFloat,
                      Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency,
                      Qr_Pesquisa.FieldByName('MED_ABREVIATURA').AsString,
                      0,
                      0);
      Pc_Totalizador;
      It_Inserir:=True;
      end;
    else
      Pc_MostraBusca;
    end;
   Screen.Cursor := crDefault;
end;

procedure TFr_Itens_Industrializa.E_DescricaoExit(Sender: TObject);
begin
  if not it_bt_pesquisa then  // se for falso nao foi clicando no pesquisado , nem apertado f7
    begin
    IT_CAMPOEDIT:='D';
    if It_StateChange = 1 then
      exit;
    IF (E_Descricao.Text = '') THEN
      begin
      if E_Vl_Unitario.CanFocus then E_Vl_Unitario.SetFocus;
      exit;
      end;
    Pc_Tip_Busca('B', 1,'',Copy(E_Descricao.Text,1,50))
    end;
end;

procedure TFr_Itens_Industrializa.E_Vl_UnitarioEnter(Sender: TObject);
begin
  E_Vl_Unitario.SelectAll;
  IT_VL_Ant := StrToFloatDef(E_Vl_Unitario.Text, 0);
end;

procedure TFr_Itens_Industrializa.E_Qt_ProdutoEnter(Sender: TObject);
begin
   E_Qt_Produto.SelectAll;
end;

procedure TFr_Itens_Industrializa.E_CodProEnter(Sender: TObject);
begin
 it_bt_pesquisa:=FALSE;
   E_CodPro.SelectAll;
end;

procedure TFr_Itens_Industrializa.E_DescricaoEnter(Sender: TObject);
begin
 it_bt_pesquisa:=FALSE;
 E_CodPro.Text:='';
end;

procedure TFr_Itens_Industrializa.E_Qt_ProdutoChange(Sender: TObject);
begin
  Pc_Totalizador;
end;

procedure TFr_Itens_Industrializa.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;

procedure TFr_Itens_Industrializa.Sb_LimparClick(Sender: TObject);
begin
  E_CodPro.Clear;
  E_Descricao.Clear;
  E_Vl_Unitario.Text := '0,00';
  E_Qt_Produto.Text := '1';
  E_Vl_SubTotal.Caption := '0,00';
  if E_CodPro.CanFocus then E_CodPro.SetFocus;
end;


procedure TFr_Itens_Industrializa.E_UnidadeEnter(Sender: TObject);
begin
 E_Unidade.SelectAll;
end;

procedure TFr_Itens_Industrializa.Sb_PesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Pesquisar.CanFocus then Sb_Pesquisar.SetFocus;
end;

function TFr_Itens_Industrializa.Fc_Busca_Cod_barra(Pc_cod_barra:String): integer;
var
   Lc_SqlTxt: string;
begin
  Lc_SqlTxt:='';
  Qr_Pesquisa.Active:=FALSE;
  Qr_Pesquisa.SQL.Clear;
  Result:=0;// ja comeco como falso so fica verdadeiro se encontra codigo de barra
  if It_Pes_cod_barra <> 'S' then
    begin
    exit;
    end;
  Lc_SqlTxt :=  'SELECT                                           '+
                '   PRO_CODIGO,                                   '+
                '   PRO_CODIGOFAB,                                '+
                '   PRO_CODIGOFOR,                                '+
                '   PRO_CODIGOBAR,                                   '+
                '   PRO_DESCRICAO,                                '+
                '   PRO_VL_CUSTO,                                 '+
                '   MED_ABREVIATURA,                              '+
                '   PRO_CAMPANHA,                                 '+
                '   PRO_ATIVO                                     '+
                'FROM TB_PRODUTO tb_produto                       '+
                '   INNER JOIN TB_MEDIDA MED                      '+
                '   ON  (MED.MED_CODIGO = tb_produto.PRO_CODMED)  '+
                ' WHERE (PRO_CODIGO IS NOT NULL)                  '+
                ' AND (PRO_CODIGOBAR =:PRO_CODIGOBAR)             ';
  if not GB_ProdCompartilha then   Lc_SqlTxt:=Lc_SqlTxt+ 'AND PRO_CODMHA = :PRO_CODMHA';
  Qr_Pesquisa.SQL.Add(Lc_SqlTxt);

  Qr_Pesquisa.ParamByName('PRO_CODIGOBAR').AsString := Copy(Pc_cod_barra,1,20);
  if not GB_ProdCompartilha  then  Qr_Pesquisa.ParamByName('PRO_CODMHA').AsInteger:=Gb_CodMha;

  Qr_Pesquisa.Active := True;
  Qr_Pesquisa.FetchAll;
  Result:=Qr_Pesquisa.RecordCount;
  IF Result = 1 THEN
    It_Cd_Produto:= Qr_Pesquisa.FIELDBYNAME('PRO_CODIGO').Value;
end;

procedure TFr_Itens_Industrializa.Sb_Sair_0MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Sair_0.CanFocus then Sb_Sair_0.SetFocus;
end;

procedure TFr_Itens_Industrializa.Sb_LimparMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  it_bt_pesquisa:=TRUE;
  if Sb_Limpar.CanFocus then Sb_Limpar.SetFocus;
end;

procedure TFr_Itens_Industrializa.Action1Execute(Sender: TObject);
Var
  Lc_Form :TFr_Liberacao;
Begin
  Lc_Form := TFr_Liberacao.Create(Fr_Itens_Industrializa);
  Lc_Form.It_Interface := 'Fr_Produtos';
  Lc_Form.It_Nome_Menu := 'Fr_Itens_Industrializa';
  Lc_Form.It_Privilegio := 'AUTORIZAR';
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;

end.



