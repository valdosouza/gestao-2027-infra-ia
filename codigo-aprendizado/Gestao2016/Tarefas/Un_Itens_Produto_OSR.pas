unit Un_Itens_Produto_OSR;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Itens_Produto, Actions, Vcl.ActnList, Data.DB, STQuery, Vcl.StdCtrls, Un_Fm_ListaEstoques, Vcl.DBCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Un_fm_ListaTributacao, Vcl.ComCtrls;

type
  TFr_Itens_Produto_OSR = class(TFr_Itens_Produto)
  private
    { Private declarations }
   protected
    function validaGravacao:Boolean;Override;
    function grava:Boolean;Override;

  public
    { Public declarations }
    It_Cd_Itens : Integer;
  end;

var
  Fr_Itens_Produto_OSR: TFr_Itens_Produto_OSR;

implementation

{$R *.dfm}

uses     RN_Cotacao;

{ TFr_Itens_Ficha_Tecnica_OSR }

function TFr_Itens_Produto_OSR.grava:Boolean;
begin
  if Fc_ExisteItemNaCotacao then
  Begin
    It_Cd_Itens := Fc_AtualizaItensCotacao(IntToStr(It_Cd_Itens),
                                           IntToStr(ItensCTC.Registro.Cotacao),
                                           'P',
                                           IntToStr(ItensNFL.Registro.CodigoProduto),
                                           E_Descricao.Text,
                                           E_Qt_Produto.Text,
                                           E_Vl_Unitario.Text,
                                           'S',
                                           E_Aq_Com.Text,
                                           E_VL_Desconto.Text,
                                           E_Aq_Desconto.Text,
                                           E_Aq_IPI.Text,
                                           E_Aq_Icms.Text,
                                           Fm_ListaEstoques.Dblcb_Estoque.KeyValue,
                                           Dblcb_Tabelas.KeyValue,
                                           E_CustoUnitario.Text,
                                           '',   //FC_MR_LUCRO,
                                           '',   //FC_ALIQ_CT_FINANCEIRO,
                                           '',   //FC_PRZ_PRATICADO,
                                           '',   //FC_VL_PRATICADO,
                                           '',   //FC_AQ_VENDEDOR,
                                           '',   //FC_TECIDO,
                                           '',   //FC_COR,
                                           IntToStr(ItensNFL.Registro.CodigoPedido));
    Pc_InsereServicoRelacionado(ItensNFL.Registro.CodigoProduto);
    Result := True;
  end
  else
  Begin
    Result := FAlse;
  End;
end;

function TFr_Itens_Produto_OSR.validaGravacao: Boolean;
begin
  Result := True;
  if not ValidacaoInicial then
  Begin
    result := False;
    exit;
  End;

end;

end.
