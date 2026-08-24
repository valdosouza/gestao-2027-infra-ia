unit Un_Itens_Produto_Cpa;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Itens_Produto, Actions, Vcl.ActnList, Data.DB, STQuery, Vcl.StdCtrls, Un_Fm_ListaEstoques, Vcl.DBCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Un_fm_ListaTributacao;

type
  TFr_Itens_Produto_Cpa = class(TFr_Itens_Produto)
    procedure E_Vl_UnitarioExit(Sender: TObject);
    procedure E_CustoUnitarioExit(Sender: TObject);
  private
    { Private declarations }
    procedure   ListaTributacao;
   protected
    procedure Pc_DefineCasaDecimalLocal;Override;
    function validaGravacao:Boolean;Override;
    function grava:Boolean;Override;
    procedure LoadItems(Items:TSTQuery);Override;
    procedure Pc_FormataTela;override;
  protected
    procedure DefineValoresEspecificos(Pc_Cd_Tabela : Integer);Override;
    procedure Pc_IniciaVariaveis;Override;
  public
    { Public declarations }
    procedure Pc_StateChange(Pc_Tipo: integer);override;
  end;

var
  Fr_Itens_Produto_Cpa: TFr_Itens_Produto_Cpa;

implementation

{$R *.dfm}

uses     Un_DM, Un_Fc_Sored_Procedures, RN_Compras, UN_Sistema, Un_Msg, env;
procedure TFr_Itens_Produto_Cpa.DefineValoresEspecificos(Pc_Cd_Tabela : Integer);
begin
  inherited;
  //Verifica se a tela em questão é de Ajuste e mostra o o ultimo valor unitario de compra para a devolução ou garantia
  ItensNFL.Registro.CodigoProduto := Qr_Pesquisa.FieldByName('PRO_CODIGO').AsInteger;
  ItensNFL.Registro.ValorUnitario := Fc_UltimoValorUnitarioCompra(ItensNFL.Registro.CodigoProduto);
  IF ItensNFL.Registro.ValorUnitario = 0 then
    ItensNFL.Registro.ValorUnitario := Qr_Pesquisa.FieldByName('PRO_VL_CUSTO').AsCurrency;
end;

procedure TFr_Itens_Produto_Cpa.E_CustoUnitarioExit(Sender: TObject);
var
  Lc_VL_Custo: Real;
  Lc_VL_Unitario: Real;
Begin
  Lc_VL_Custo := StrToFloatDef(E_CustoUnitario.Text, 0);
  E_CustoUnitario.Text := FormatFloat(It_Casa_Decimal, Lc_VL_Custo);
  if Lc_VL_Custo <= 0 then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O Valor Informado não é valido.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_CustoUnitario.CanFocus then E_CustoUnitario.SetFocus;
    exit;
  end;

  Lc_VL_unitario := StrToFloatDef(E_VL_Unitario.Text, 0);
  if ( Lc_VL_Custo < Lc_VL_unitario ) then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Este campo não pode ter valor menor do que o ' + EOLN +
                   'campo Valor Unitario'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_CustoUnitario.CanFocus then E_CustoUnitario.SetFocus;
    E_CustoUnitario.Text := FormatFloat(It_Casa_Decimal, Lc_VL_Unitario);
    exit;
  end;

  Pc_Totalizador;

end;

procedure TFr_Itens_Produto_Cpa.E_Vl_UnitarioExit(Sender: TObject);
begin
  inherited;
  E_CustoUnitario.Text := E_Vl_Unitario.Text;
end;

function TFr_Itens_Produto_Cpa.grava:boolean;
Var
  Lc_Estoque : String;
Begin

  if Fc_ExisteItemNoPedido('C') then
  Begin
    if Chbx_Estoque.Checked then Lc_Estoque := 'S' else Lc_Estoque := 'N';
    with ItensNFL.Registro do
    Begin
      CodigoPedido := ItensNFL.Registro.CodigoPedido;
      CodigoProduto := It_Cd_Produto;
      Quantidade := StrToFloatDef(E_Qt_Produto.Text,0);

      ValorCusto := StrToFloatDef(E_CustoUnitario.Text,0);
      ValorUnitario := StrToFloatDef(E_Vl_Unitario.Text,0);
      AliqDesconto := StrToFloatDef(E_Aq_Desconto.Text,0);
      ValorDesconto := StrToFloatDef(E_VL_Desconto.Text,0);
      AliqComissao := StrToFloatDef(E_Aq_Com.Text,0);
      Operacao := 'C';
      Estoque := Lc_Estoque;
      Despachar := 'S';
      AliqIPI := StrToFloatDef(E_Aq_IPI.Text,0);
      AliqICMS := StrToFloatDef(E_Aq_Icms.Text,0);
      CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
      CodigoTabela := Dblcb_Tabelas.KeyValue;
      Largura := StrtoFloatDef(e_Largura.Text,0);
      Altura := StrtoFloatDef(e_Altura.Text,0);
      NumeroPecas := StrtoFloatDef(E_Nr_Peca.Text,0);
    End;
    ItensNFL.salva;
    Result := True;
  end
  else
  Begin
    Result := FAlse;
  End;
end;

procedure TFr_Itens_Produto_Cpa.ListaTributacao;
begin
 fm_ListaTributacao.Estado := SElf.Estado;
  fm_ListaTributacao.Sentido := 'E';
  fm_ListaTributacao.Listar;
end;

procedure TFr_Itens_Produto_Cpa.LoadItems(Items: TSTQuery);
begin
  inherited;
  (cds_items.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Compra;
  (cds_items.FieldByName('ITF_VL_DESC') as TNumericField).DisplayFormat     := '0.00######';
  (cds_items.FieldByName('ITF_VL_SUBTOTAL') as TNumericField).DisplayFormat := Gb_Casa_Dec_Compra;
  (cds_items.FieldByName('ITF_AQ_COM') as TNumericField).DisplayFormat := '0.00';
  (cds_items.FieldByName('ITF_VL_TOTAL') as TNumericField).DisplayFormat := Gb_Casa_Dec_Compra;
end;

procedure TFr_Itens_Produto_Cpa.Pc_DefineCasaDecimalLocal;
begin
  It_Casa_Decimal := Gb_Casa_Dec_Compra;
end;

procedure TFr_Itens_Produto_Cpa.Pc_FormataTela;
Var
  I:Integer;
begin
  inherited;
  if (Fc_Tb_Geral('L','CPA_G_OPER_COMPRA_NFE','N') = 'N') then
  begin
    For I:=1 to Pg_Main.PageCount do Pg_Main.Pages[I-1].TabVisible:=False;
  end;
  Pg_Main.ActivePage :=tbs_item;
end;

procedure TFr_Itens_Produto_Cpa.Pc_IniciaVariaveis;
begin
  inherited;
  CampoCusto := 'PRO_VL_CUSTO';
  ListaTributacao;
end;

procedure TFr_Itens_Produto_Cpa.Pc_StateChange(Pc_Tipo: integer);
begin
  inherited;
  case Pc_Tipo of
    2:Begin //Inserindo
        pnl_botao_lista.Visible := TRue;
        DBG_Produtos.Visible := TRue;
        Height := 650;
      end;
    3:Begin //Alterando
        pnl_botao_lista.Visible := False;
        DBG_Produtos.Visible := False;
        Height := 311;
      end;
   end;
end;

function TFr_Itens_Produto_Cpa.validaGravacao: Boolean;
begin
  Result := True;
  if E_Vl_Unitario.Focused then
    E_Vl_UnitarioExit(Self);
  if not ValidacaoInicial then
  Begin
    result := False;
    exit;
  End;

  //Valida o limite de compra mensal
  if not Fc_ValidaLimiteCompraMensal(0, ItensNFL.Registro.Codigo,0,StrToFloatDef(E_Vl_SubTotal.Caption,0), It_Dt_Operacao) then
  Begin
    Result := FAlse;
    Exit;
  end;
  if not validaPreencheEstoque then
  Begin
    REsult := False;
    exit;
  End;
  if not validaPreencheCodigo then
  Begin
    REsult := False;
    exit;
  End;
end;

end.



