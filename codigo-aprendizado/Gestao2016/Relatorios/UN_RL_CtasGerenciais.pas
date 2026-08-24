unit UN_RL_CtasGerenciais;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, ExtCtrls, QuickRpt, STQuery, StdCtrls, QRCtrls;

type
  TRL_CtasGerenciais = class(TForm)
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    Qr_Contas: TSTQuery;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand1: TQRBand;
    E_Descricao: TQRLabel;
    E_Vl_Credito: TQRLabel;
    E_VL_Debito: TQRLabel;
    E_Cd_Plano: TQRLabel;
    QRGroup1: TQRGroup;
    QRBand2: TQRBand;
    QRLabel14: TQRLabel;
    Label1: TQRLabel;
    Lb_ContaInicial: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Label2: TQRLabel;
    Lb_ContaFinal: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_I : Integer;
    it_Linha : Boolean;
    procedure Pc_Buscar;
    procedure Pc_Parametros;
  end;

var
  RL_CtasGerenciais: TRL_CtasGerenciais;

implementation

uses     Un_DM, UN_Imp_CtasGerenciais, UN_Sistema;
{$R *.dfm}

procedure TRL_CtasGerenciais.Pc_Buscar;
Var
  Lc_SqlTxt : String;
Begin
  With Fr_Imp_CtasGerenciais do
    Begin
    Qr_Contas.Active := False;
    Qr_Contas.SQL.Clear;
    Lc_SqlTxt := 'SELECT PLC_CODPLANO, PLC_DESCRICAO, MVF_DATA, MVF_HISTORISCO, MVF_VL_CREDITO, MVF_VL_DEBITO '+
                 'FROM TB_MOVIM_FINANCEIRO tb_movimento '+
                 '   INNER JOIN TB_PLANOCONTAS tb_planocontas '+
                 '   ON  (tb_planocontas.PLC_CODIGO = tb_movimento.MVF_CODPLC_D)'+
                 'where MVF_CODIGO IS NOT NULL ';

    if Trim(Fm_CentroCustoInicial.DBLCB_Plano.Text)<>'' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_CODPLANO >=:PLANOINI) ';

    if Trim(Fm_CentroCustoFinal.DBLCB_Plano.Text)<>'' then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (PLC_CODPLANO <=:PLANOFIM) ';

    Qr_Contas.SQL.Add(Lc_SqlTxt + ' ORDER BY PLC_CODPLANO ');
    //Passagem de Parametros
    if Trim(Fm_CentroCustoInicial.DBLCB_Plano.Text)<>'' then
      Qr_Contas.ParamByName('PLANOINI').Value := Fm_CentroCustoInicial.DBLCB_Plano.KeyValue;

    if Trim(Fm_CentroCustoFinal.DBLCB_Plano.Text)<>'' then
      Qr_Contas.ParamByName('PLANOFIM').Value := Fm_CentroCustoFinal.DBLCB_Plano.KeyValue;
    Qr_Contas.Active := True;
    end;
end;

procedure TRL_CtasGerenciais.Pc_Parametros;
Begin
  with Fr_Imp_CtasGerenciais do
  Begin
    Lb_Tipo_Rl.Caption      := CB_Tipo.Text;
    Lb_Data_Ini.Caption     :=  DateToStr(E_Data_Ini.Date);
    Lb_Data_Fim.Caption     :=  DateToStr(E_Data_Fim.Date);
    Lb_ContaInicial.Caption := Fm_CentroCustoInicial.DBLCB_Plano.Text;
    Lb_ContaFinal.Caption   := Fm_CentroCustoFinal.DBLCB_Plano.Text;
  end;
end;

procedure TRL_CtasGerenciais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_CtasGerenciais:=nil;
end;

procedure TRL_CtasGerenciais.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
end;

end.
