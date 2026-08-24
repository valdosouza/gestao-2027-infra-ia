unit UN_RL_Ord_Serv_Det;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery, frxClass, frxDBSet;

type
  TRL_Ord_Serv_Det = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel3: TQRLabel;
    Detalhe: TQRBand;
    QRDBVenda: TQRDBText;
    QRDBITV_LINHA: TQRDBText;
    QRDBITV_QTDE: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText14: TQRDBText;
    QRBand2: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    E_VL_TL_Servico: TQRLabel;
    E_VL_TL_Produtos: TQRLabel;
    E_VL_TL_Total: TQRLabel;
    RodapeGRupo: TQRBand;
    QRLabel17: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    E_VL_Servicos: TQRLabel;
    E_VL_Produtos: TQRLabel;
    E_VL_Total: TQRLabel;
    MM_Obs: TQRExprMemo;
    QRLabel23: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel16: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText6: TQRDBText;
    Qr_Servicos: TSTQuery;
    QRLabel26: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel20: TQRLabel;
    QRDBText5: TQRDBText;
    frxServicos: TfrxReport;
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeGRupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GrupoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    NrGrupo, NrItem:Integer;
  public
    { Public declarations }

  end;

var
  RL_Ord_Serv_Det: TRL_Ord_Serv_Det;

implementation

uses     Un_DM, UN_Imp_Servico, UN_Sistema, ComCtrls;
{$R *.dfm}


procedure TRL_Ord_Serv_Det.GrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  NrGrupo := NrGrupo + 1;
end;

procedure TRL_Ord_Serv_Det.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  if Qr_Servicos.FieldByName('PRO_TIPO').AsString='S' then
//    It_VL_Servico := It_VL_Servico + Qr_Servicos.FieldByName('ITF_VL_SUBTOTAL').AsFloat
//  else
//    It_VL_Produto := It_VL_Produto + Qr_Servicos.FieldByName('ITF_VL_SUBTOTAL').AsFloat;
//  NrItem := NrItem  + 1;
//  if RodapeGRupo.ForceNewPage = true then
//    RodapeGRupo.ForceNewPage := false;
end;

procedure TRL_Ord_Serv_Det.RodapeGRupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  E_VL_Servicos.Caption  := FloatToStrf(It_VL_Servico,ffNumber,18,2);
//  E_VL_Produtos.Caption := FloatToStrf(It_VL_Produto,ffNumber,18,2);
//  E_VL_Total.Caption    := FloatToStrf(It_VL_Produto + It_VL_Servico,ffNumber,18,2);
//  It_VL_TL_Servico := It_VL_TL_Servico + It_VL_Servico;
//  It_VL_TL_Produto := It_VL_TL_Produto + It_VL_Produto;
//  MM_Obs.Lines.Text:=Qr_Servicos.FieldByName('OBS').AsString;
//  It_VL_Servico := 0;
//  It_VL_Produto := 0;
end;

procedure TRL_Ord_Serv_Det.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  E_VL_TL_Servico.Caption  := FloatToStrf(It_VL_TL_Servico,ffNumber,18,2);
//  E_VL_TL_Produtos.Caption := FloatToStrf(It_VL_TL_Produto,ffNumber,18,2);
//  E_VL_TL_Total.Caption    := FloatToStrf(It_VL_TL_Produto + It_VL_TL_Servico,ffNumber,18,2);
end;


end.
