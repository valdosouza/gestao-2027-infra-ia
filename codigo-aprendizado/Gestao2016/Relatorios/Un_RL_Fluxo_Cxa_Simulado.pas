unit Un_RL_Fluxo_Cxa_Simulado;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, ExtCtrls, QuickRpt, Qrctrls, STQuery;

type
  TRL_Fluxo_Cxa_Simulado = class(TForm)
    Qrpt: TQuickRep;
    Grp_Data: TQRGroup;
    Bd_Detalhe: TQRBand;
    QRDBText2: TQRDBText;
    QRLabel6: TQRLabel;
    Bd_CAbeca: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel9: TQRLabel;
    Grp_Origem: TQRGroup;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel2: TQRLabel;
    QRBand1: TQRBand;
    QRLabel3: TQRLabel;
    Footer_Data: TQRBand;
    Lb_SaldoDiario: TQRLabel;
    Footer_Origem: TQRBand;
    Lb_SaldoOrigem: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_Sumario: TQRLabel;
    Lb_Tipo: TQRLabel;
    Lb_SaldoAtual: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Fluxo: TSTQuery;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel14: TQRLabel;
    procedure Bd_DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Footer_DataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Footer_OrigemBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    It_Sld_Anterior,It_Sld_Origem, It_Sld_Diario,It_Sld_Atual :Real;
  public
    { Public declarations }
  procedure Pc_Busca;
  procedure Pc_Parametros;

  end;

var
  RL_Fluxo_Cxa_Simulado: TRL_Fluxo_Cxa_Simulado;

implementation

uses      UN_Imp_Fluxo_Cxa, Un_DM, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.DFM}



procedure TRL_Fluxo_Cxa_Simulado.Pc_Busca;
Var
  sqltxt,sqlSldAnt:String;
TCreditoA,TDebitoA:Currency;
SaldoA,SaldoF:String;
begin
  Screen.Cursor:=crHourGlass;
  It_Sld_Anterior:=0;
  It_Sld_Diario:=0;
  It_Sld_Atual:=0;
  Qr_Fluxo.Active := False;
  Qr_Fluxo.SQL.Clear;
  Qr_Fluxo.SQL.Add('  SELECT *                          ');
  Qr_Fluxo.SQL.Add(' FROM VW_FLUXO_CAIXA vw_fluxo_caixa ');
  Qr_Fluxo.SQL.Add(' WHERE                              ');
  Qr_Fluxo.SQL.Add(' FLX_CODMHA=:FLX_CODMHA             ');

  if Fr_Imp_Fluxo_Cxa.ChBx_Periodo.Checked then
    Qr_Fluxo.SQL.Add(' AND FLX_DATA BETWEEN :DATAINI AND :DATAFIM');

  Qr_Fluxo.SQL.Add('ORDER BY FLX_DATA,FLX_TIPO  ');

  if Fr_Imp_Fluxo_Cxa.ChBx_Periodo.Checked then
    begin
    Qr_Fluxo.ParamByName('DATAINI').AsDate := Fr_Imp_Fluxo_Cxa.E_Data_INI.Date;
    Qr_Fluxo.ParamByName('DATAFIM').AsDate := (Fr_Imp_Fluxo_Cxa.E_Data_FIM.Date);
    end;
  Qr_Fluxo.ParamByName('FLX_CODMHA').AsInteger := Gb_CodMha;
  Qr_Fluxo.Active := True;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Fluxo_Cxa_Simulado.Bd_DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Sld_Origem := It_Sld_Origem + Qr_Fluxo.FieldByname('FLX_SALDO').AsCurrency;
end;

procedure TRL_Fluxo_Cxa_Simulado.Footer_DataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Sld_Atual := It_Sld_Atual + It_Sld_Diario;
  Lb_SaldoDiario.Caption:=FloatToStrF(It_Sld_Diario,ffNumber,10,2);
  Lb_SaldoAtual.Caption:=FloatToStrF(It_Sld_Atual,ffNumber,10,2);
  It_Sld_Diario := 0;
end;

procedure TRL_Fluxo_Cxa_Simulado.Footer_OrigemBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  case Qr_Fluxo.FieldByname('FLX_TIPO').AsInteger of
    1:Begin
      Lb_Tipo.Caption := 'Contasá Receber';
      It_Sld_Diario := It_Sld_Diario + It_Sld_Origem;
      end;
    2:Begin
      Lb_Tipo.Caption := 'Contas É Pagar';
      It_Sld_Diario := It_Sld_Diario - It_Sld_Origem;
      end;
    5:Begin
      Lb_Tipo.Caption := 'Cheques Pré-Datados Recebidos';
      It_Sld_Diario := It_Sld_Diario - It_Sld_Origem;
      end;
    6:Begin
      Lb_Tipo.Caption := 'Cheques Pré-Datados Emitidos';
      It_Sld_Diario := It_Sld_Diario - It_Sld_Origem;
      end;
  end;
  Lb_SaldoOrigem.Caption:=FloatToStrF(It_Sld_Origem,ffNumber,10,2);
  It_Sld_Origem := 0;
end;

procedure TRL_Fluxo_Cxa_Simulado.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Sumario.Caption:=FloatToStrF(It_Sld_Atual,ffNumber,10,2);
end;

procedure TRL_Fluxo_Cxa_Simulado.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Fluxo_Cxa_Simulado.Pc_Parametros;
begin
  with Fr_Imp_Fluxo_Cxa do
  begin
    // Verifica data solicitada
    if ChBx_Periodo.Checked then
      Begin
      Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
      Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
      end
    else
      Begin
      Lb_Data_Ini.Caption := '';
      Lb_Data_Fim.Caption := '';
      end;
  end;
end;

procedure TRL_Fluxo_Cxa_Simulado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Fluxo_Cxa_Simulado:=nil;
end;

end.
