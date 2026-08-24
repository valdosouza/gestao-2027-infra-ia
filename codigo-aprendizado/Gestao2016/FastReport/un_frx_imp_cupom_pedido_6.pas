unit un_frx_imp_cupom_pedido_6;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, frxClass, frxExportPDF, Data.DB, STQuery, frxDBSet, frxExportXLS;

type
  TFrxImpCupomPedido6 = class(TFrxBaseReport)
    frxDataItens: TfrxDBDataset;
    Qr_Itens: TSTQuery;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    CodigoPedido : Integer;
    procedure IniciaVariaveis;Override;
  end;

var
  FrxImpCupomPedido6: TFrxImpCupomPedido6;

implementation

{$R *.dfm}

uses     UN_Sistema;
procedure TFrxImpCupomPedido6.FormCreate(Sender: TObject);
begin
  //  inherited;

end;

procedure TFrxImpCupomPedido6.IniciaVariaveis;
begin
  inherited;
  TfrxReportPage(frxBase.Pages[1]).PaperWidth := StrToFloatDef(Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80'),80);
  TfrxReportPage(frxBase.Pages[1]).RightMargin  := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO', '0'),0);
  TfrxReportPage(frxBase.Pages[1]).LeftMargin   := StrToFloatDef(Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO', '0'),0);
  if Qr_Consulta.Transaction.InTransaction then Qr_Consulta.Transaction.Commit;
  with Qr_Consulta do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
  End;
  with Qr_Itens do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
  End;
end;

end.
