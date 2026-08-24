unit Un_Itens_Produto_Dev;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Actions, Vcl.ActnList, Data.DB, STQuery, Vcl.StdCtrls, Un_Fm_ListaEstoques, Vcl.DBCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Un_fm_ListaTributacao, Un_Itens_Produto;



type
  TFr_Itens_Produto_Dev = class(TFr_Itens_Produto)
  private
    { Private declarations }
   protected
   procedure Pc_formatatela;Override;
   procedure Pc_StateChange(Pc_Tipo: integer);Override;
   function validaGravacao:Boolean;Override;
   function grava:Boolean;Override;

  public
    { Public declarations }
  end;

var
  Fr_Itens_Produto_Dev: TFr_Itens_Produto_Dev;

implementation

{$R *.dfm}

uses     Un_DM, Un_Fc_Sored_Procedures, RN_Estoque;

{ TFr_Itens_Produto_Dev }

function TFr_Itens_Produto_Dev.grava:boolean;
Var
  Lc_Estoque : String;
Begin
  if Fc_ExisteItemNoPedido('D') then
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
      Operacao := 'D';
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
    //Baixa simples produto a produto
    with CtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := Self.Terminal;
      Vinculo     := 'P';
      Ordem       := ItensNFL.Registro.CodigoPedido;
      Item        := ItensNFL.Registro.Codigo;
      Estoque     := Fm_ListaEstoques.Dblcb_Estoque.Keyvalue;
      operacao    := 'E';
      Produto     := ItensNFL.Registro.CodigoProduto;
      Quantidade  := StrToFloatDef(E_Qt_Produto.Text,0);
      Data        := It_Dt_Operacao;
      Tipo        := 'Venda - Devolução';
      UpdateAt    := Now;
    End;
    CtrlEstoque.Registra;
    Result := True;
  end
  else
  Begin
    Result := FAlse;
  End;
end;

procedure TFr_Itens_Produto_Dev.Pc_formatatela;
begin
  inherited;
  tbs_tributacao.TabVisible := False;
end;

procedure TFr_Itens_Produto_Dev.Pc_StateChange(Pc_Tipo: integer);
begin
  inherited;
  case Pc_Tipo of
    2:Begin //Inserindo
        Height := 650;
      end;
    3:Begin //Alterando
        Height := 310;
      end;
   end;

end;

function TFr_Itens_Produto_Dev.validaGravacao: Boolean;
begin
  REsult := True;
  if not ValidacaoInicial then
  Begin
    result := False;
    exit;
  End;

  if not validaPreencheEstoque then
  Begin
    REsult := False;
    exit;
  End;
end;

end.
