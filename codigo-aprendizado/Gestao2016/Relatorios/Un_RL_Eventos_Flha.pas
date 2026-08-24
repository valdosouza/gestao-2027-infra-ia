unit Un_RL_Eventos_Flha;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Eventos_Flha = class(TForm)
    Qrpt: TQuickRep;
    DetalheVenda: TQRBand;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText4: TQRDBText;
    Vendedor: TQRGroup;
    QRDBText6: TQRDBText;
    QRLabel10: TQRLabel;
    QRBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    QRBand2: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel12: TQRLabel;
    QRBand4: TQRBand;
    QRLabel8: TQRLabel;
    Qr_Eventos: TSTQuery;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    Qr_EventosFPT_CODIGO: TIntegerField;
    Qr_EventosFPT_CODCLB: TIntegerField;
    Qr_EventosFPT_DATA: TDateField;
    Qr_EventosFPT_MES: TIntegerField;
    Qr_EventosFPT_ANO: TIntegerField;
    Qr_EventosFPT_HISTORICO: TStringField;
    Qr_EventosFPT_VL_CREDITO: TBCDField;
    Qr_EventosFPT_VL_DEBITO: TBCDField;
    Qr_EventosCLB_NOME: TStringField;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Colaborador: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_Eventos_Flha: TRL_Eventos_Flha;

implementation

uses      Mask, Un_DM, UN_Sistema, UN_Imp_Eventos, ComCtrls;
{$R *.dfm}

procedure TRL_Eventos_Flha.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Usuario:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Qr_Eventos.Close;
  Qr_Eventos.SQL.Clear;
  SqlTxt:='SELECT FPT_CODIGO, FPT_CODCLB, CLB_NOME, FPT_DATA, FPT_MES, FPT_ANO, FPT_HISTORICO, FPT_VL_CREDITO, FPT_VL_DEBITO '+
          'FROM TB_FOLHAPAGTO tb_folhapagto '+
          '   INNER JOIN TB_COLABORADOR tb_colaborador '+
          '   ON (tb_colaborador.CLB_CODIGO = tb_folhapagto.FPT_CODCLB) '+
          'WHERE (FPT_CODIGO IS NOT NULL) ';


  if Fr_Imp_Eventos.Dblcb_Vendedor.Text ='' then LC_Usuario := False else LC_Usuario := True;
  if LC_Usuario then SqlTxt := SqlTxt +'AND FPT_CODCLB =:FPT_CODCLB ';
  if Fr_Imp_Eventos.ChBx_Periodo.Checked then SqlTxt := SqlTxt +'AND FPT_DATA BETWEEN :DATAINI AND :DATAFIM  ';
  if Fr_Imp_Eventos.RG_Tipo.ItemIndex =0 then SqlTxt := SqlTxt + 'AND (FPT_VL_CREDITO > 0 ) ';
  if Fr_Imp_Eventos.RG_Tipo.ItemIndex =1 then SqlTxt := SqlTxt + 'AND (FPT_VL_DEBITO > 0 ) ';

  Qr_Eventos.SQL.Add(SqlTxt+' ORDER BY CLB_NOME, FPT_DATA ');
  if LC_Usuario then Qr_Eventos.ParamByName('FPT_CODCLB').AsInteger:=Fr_Imp_Eventos.Dblcb_Vendedor.KeyValue;
  if Fr_Imp_Eventos.ChBx_Periodo.Checked then
    begin
    Qr_Eventos.ParamByName('DATAINI').AsDate:=Fr_Imp_Eventos.E_Data_INI.Date;
    Qr_Eventos.ParamByName('DATAFIM').AsDate:=Fr_Imp_Eventos.E_Data_FIM.Date;
    end;
  Qr_Eventos.Open;
  Screen.Cursor:=crDefault;


end;

procedure TRL_Eventos_Flha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Eventos_Flha:=nil;
end;

procedure TRL_Eventos_Flha.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Eventos_Flha.Pc_Parametros;
begin
  with Fr_Imp_Eventos do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Crédito';
      1 : Lb_Tipo_Doc.Caption := 'Débito';
      2 : Lb_Tipo_Doc.Caption := 'Todas';
    end;
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
    // Verifica se o campo cliente foi preenchido
    if trim(DBLCB_Vendedor.Text) = '' then
      Lb_Colaborador.Caption := 'Todos'
    else
      Lb_Colaborador.Caption := Dblcb_Vendedor.Text;
  end;
end;

end.
