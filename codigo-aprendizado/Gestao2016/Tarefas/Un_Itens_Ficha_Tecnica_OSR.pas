unit Un_Itens_Ficha_Tecnica_OSR;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Itens_Produto, System.Actions, Vcl.ActnList, Data.DB, STQuery, Vcl.StdCtrls, Un_Fm_ListaEstoques, Vcl.DBCtrls, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient, Un_fm_ListaTributacao, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFr_Itens_Ficha_Tecnica_OSR = class(TFr_Itens_Produto)
  private
    { Private declarations }
   protected
    function validaGravacao:Boolean;Override;
    function grava:Boolean;Override;

  public
    { Public declarations }
  end;

var
  Fr_Itens_Ficha_Tecnica_OSR: TFr_Itens_Ficha_Tecnica_OSR;

implementation

{$R *.dfm}

uses     RN_Cotacao;

{ TFr_Itens_Ficha_Tecnica_OSR }

function TFr_Itens_Ficha_Tecnica_OSR.grava:Boolean;
begin
  if Fc_ExisteItemNaCotacao then
  Begin
    It_Cd_Itens := Fc_AtualizaItensCotacao(IntToStr(It_Cd_Itens),
                                           IntToStr(It_Cd_Cotacao),
                                           'P',
                                           IntToStr(It_Cd_Produto),
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
                                           IntToStr(It_Cd_Pedido));
    Pc_InsereServicoRelacionado(It_Cd_Produto);
    Result := True;
  end
  else
  Begin
    Result := FAlse;
  End;

end;

function TFr_Itens_Ficha_Tecnica_OSR.validaGravacao: Boolean;
begin
  inherited;
end;

end.
