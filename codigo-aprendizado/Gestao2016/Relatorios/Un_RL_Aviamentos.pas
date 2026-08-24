unit Un_RL_Aviamentos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery, QRPDFFilt, StdCtrls;

type
  TRL_Aviamentos = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRBand1: TQRBand;
    QRLabel13: TQRLabel;
    StrBnd_Aviamentos: TQRStringsBand;
    QRMemo29: TQRMemo;
    QRMemo31: TQRMemo;
    QRMemo34: TQRMemo;
    Lb_Avi_Unid: TQRLabel;
    QRMemo36: TQRMemo;
    QRMemo37: TQRMemo;
    Lb_Avi_Con_Unit: TQRLabel;
    Lb_Avi_Cons_Total: TQRLabel;
    Lb_Avi_Item: TQRLabel;
    Lb_Avi_Descricao: TQRLabel;
    QRLabel63: TQRLabel;
    QRMemo69: TQRMemo;
    QRMemo70: TQRMemo;
    QRMemo72: TQRMemo;
    QRMemo75: TQRMemo;
    QRLabel64: TQRLabel;
    QRMemo77: TQRMemo;
    QRMemo78: TQRMemo;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    QRBand3: TQRBand;
    Qr_Aviamentos: TSTQuery;
    QRMemo45: TQRMemo;
    QRMemo47: TQRMemo;
    QRLabel37: TQRLabel;
    Lb_Tl_Av_Vl_Total: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    Qr_Ordem: TSTQuery;
    Qr_OrdemCTC_CODIGO: TIntegerField;
    Qr_OrdemCTC_NUMERO: TStringField;
    Qr_OrdemCTC_DATA: TDateField;
    Qr_OrdemEMP_NOME: TStringField;
    Qr_OrdemEMP_FANTASIA: TStringField;
    Qr_OrdemEMP_CODIGO: TIntegerField;
    Qr_OrdemEND_ENDER: TStringField;
    Qr_OrdemEND_CEP: TStringField;
    Qr_OrdemEND_FONE: TStringField;
    Qr_OrdemEND_BAIRRO: TStringField;
    Qr_OrdemEND_CELULAR: TStringField;
    Qr_OrdemEND_FAX: TStringField;
    Qr_OrdemEMP_CNPJ: TStringField;
    Qr_OrdemCTC_QT_PRODUTO: TBCDField;
    Qr_OrdemCTC_VL_FRETE: TBCDField;
    Qr_OrdemCTC_VL_DESCONTO: TBCDField;
    Qr_OrdemCTC_VL_COTACAO: TBCDField;
    QRLabel3: TQRLabel;
    E_Descricao: TQRLabel;
    Qr_AviamentosFTC_CODIGO: TIntegerField;
    Qr_AviamentosFTC_CODICT: TIntegerField;
    Qr_AviamentosFTC_CODITF: TIntegerField;
    Qr_AviamentosFTC_TIPO: TStringField;
    Qr_AviamentosFTC_CODVCL: TIntegerField;
    Qr_AviamentosFTC_DESC_INSUMO: TStringField;
    Qr_AviamentosFTC_UND: TStringField;
    Qr_AviamentosFTC_VL_UNIT: TFloatField;
    Qr_AviamentosFTC_CS_UNIT: TFloatField;
    Qr_OrdemCDD_DESCRICAO: TStringField;
    Qr_OrdemUFE_SIGLA: TStringField;
    Qr_OrdemCTC_PRAZO: TStringField;
    Qr_OrdemCTC_PRZ_ENTREGA: TStringField;
    Qr_OrdemCTC_OBS: TBlobField;
    Qr_OrdemEMP_INSC_EST: TStringField;
    Qr_OrdemEMP_EMAIL: TStringField;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StrBnd_AviamentosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_Itens : Integer;
    It_qt_Itens : Integer;
    It_Descricao : String;
    It_Item : Integer;
    It_Vl_total: Currency;
  end;

var
  RL_Aviamentos: TRL_Aviamentos;

implementation

uses     Un_Cotacao, Un_Funcoes, UN_Sistema, Un_DM;
{$R *.dfm}


procedure TRL_Aviamentos.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_I:Integer;
begin
  Pc_Cab_Relatorio(Qrpt);
  Lc_dia := Copy(Fr_Cotacao.TB_CotacaoCTC_DATA.AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Fr_Cotacao.TB_CotacaoCTC_DATA.AsDateTime),True);
  Lc_Ano := Copy(Fr_Cotacao.TB_CotacaoCTC_DATA.AsString,7,4);

  Qr_Aviamentos.Active := False;
  Qr_Aviamentos.ParamByName('FTC_CODICT').AsInteger := It_Cd_Itens;
  Qr_Aviamentos.Active := True;
  Qr_Aviamentos.FetchAll;
  Qr_Aviamentos.First;
  StrBnd_Aviamentos.Items.Clear;
  For Lc_I := 1 to Qr_Aviamentos.RecordCount do StrBnd_Aviamentos.Items.Add(IntToStr(Lc_I));
  It_Vl_total := 0;

end;

procedure TRL_Aviamentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Qrpt.Destroy;
  RL_Aviamentos := nil;
end;

procedure TRL_Aviamentos.StrBnd_AviamentosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Inc(It_Item);
  Lb_Avi_Item.Caption := IntToStr(It_Item);
  Lb_Avi_Descricao.Caption := Qr_AviamentosFTC_DESC_INSUMO.AsString;
  Lb_Avi_Unid.Caption := Qr_AviamentosFTC_UND.AsString;
  Lb_Avi_Con_Unit.Caption := FloatToStrF((Qr_AviamentosFTC_CS_UNIT.AsFloat),ffFixed,10,3);
  Lb_Avi_Cons_Total.Caption := FloatToStrF((Qr_AviamentosFTC_CS_UNIT.AsFloat * It_qt_Itens),ffFixed,10,2);
  It_Vl_total := It_Vl_total + (Qr_AviamentosFTC_CS_UNIT.AsFloat * It_qt_Itens);
  Qr_Aviamentos.Next;
end;

procedure TRL_Aviamentos.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Descricao.Caption := IntToStr(It_qt_Itens) + ' - ' + It_Descricao;
end;

procedure TRL_Aviamentos.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_Av_Vl_Total.Caption := FloatToStrF(It_Vl_total,ffFixed,10,2);
end;

end.
