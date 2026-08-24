unit Un_RL_Fluxo_Cxa;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, ExtCtrls, QuickRpt, Qrctrls, STQuery;

type
  TRL_Fluxo_Cxa = class(TForm)
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
  RL_Fluxo_Cxa: TRL_Fluxo_Cxa;

implementation

uses      UN_Imp_Fluxo_Cxa, Un_DM, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.DFM}



procedure TRL_Fluxo_Cxa.Pc_Busca;
Var
  sqltxt,sqlSldAnt:String;
TCreditoA,TDebitoA:Currency;
SaldoA,SaldoF:String;
begin
  Screen.Cursor:=crHourGlass;
  with Fr_Imp_Fluxo_Cxa do
    Begin
    with Qr_Fluxo do
      Begin
      It_Sld_Anterior:=0;
      It_Sld_Diario:=0;
      It_Sld_Atual:=0;
      Active := False;
      SQL.Clear;
      SqlTxt := ' SELECT * '+
                ' FROM VW_FLUXO_CAIXA vw_fluxo_caixa '+
                'WHERE FLX_TIPO IS NOT NULL ';

      if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
        Begin
        SqlTxt := SqlTxt + ' AND (FLX_CODMHA=:FLX_CODMHA) ';
        end;

      if ChBx_Periodo.Checked then
        SqlTxt := SqlTxt + ' AND FLX_DATA BETWEEN :DATAINI AND :DATAFIM ' ;

      SQL.Add(SqlTxt + ' ORDER BY FLX_DATA,FLX_TIPO  ');

      if ChBx_Periodo.Checked then
        begin
        ParamByName('DATAINI').AsDate := E_Data_INI.Date;
        ParamByName('DATAFIM').AsDate := (E_Data_FIM.Date);
        end;

      if not Grb_MnhaEmpresa.Visible then
        Begin
        ParamByName('FLX_CODMHA').AsInteger := Gb_CodMha;
        end
      else
        Begin
        if not chbx_Empresas.Checked then
          ParamByName('FLX_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
        end;
      Active := True;
      end;
    end;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Fluxo_Cxa.Bd_DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Sld_Origem := It_Sld_Origem + Qr_Fluxo.FieldByname('FLX_SALDO').AsCurrency;
end;

procedure TRL_Fluxo_Cxa.Footer_DataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Sld_Atual := It_Sld_Atual + It_Sld_Diario;
  Lb_SaldoDiario.Caption:=FloatToStrF(It_Sld_Diario,ffNumber,10,2);
  Lb_SaldoAtual.Caption:=FloatToStrF(It_Sld_Atual,ffNumber,10,2);
  It_Sld_Diario := 0;
end;

procedure TRL_Fluxo_Cxa.Footer_OrigemBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_Fluxo_Cxa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Sumario.Caption:=FloatToStrF(It_Sld_Atual,ffNumber,10,2);
end;

procedure TRL_Fluxo_Cxa.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Fluxo_Cxa.Pc_Parametros;
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

procedure TRL_Fluxo_Cxa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Fluxo_Cxa:=nil;
end;

end.
