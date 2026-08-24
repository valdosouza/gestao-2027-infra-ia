unit UN_RL_Lanca_Banco;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Lanca_Banco = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRGroup1: TQRGroup;
    QRDBText2: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    Detalhe: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    RodapeDiario: TQRBand;
    QRLabel2: TQRLabel;
    Qr_Movimentacao: TSTQuery;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_VL_Credito: TQRLabel;
    Lb_VL_Debito: TQRLabel;
    Lb_VL_Sld_Atual: TQRLabel;
    Qr_Acao: TSTQuery;
    QRLabel3: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel9: TQRLabel;
    QRBand2: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Historico: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeDiarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_VL_Credito: Currency;
    It_VL_Debito: Currency;
    It_VL_Sld_Ant: Currency;
    It_Linha : Integer;
  procedure Pc_Busca;
  procedure Pc_Parametros;

  end;

var
  RL_Lanca_Banco: TRL_Lanca_Banco;

implementation

uses     Un_DM, UN_Imp_Banco, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.dfm}

procedure TRL_Lanca_Banco.Pc_Busca;
VaR
  SqlTxt:String;
  Lc_Historico : Boolean;
begin
  Screen.Cursor:=crHourGlass;
  with Fr_Imp_Banco do
    Begin
    with Qr_Movimentacao do
      Begin
      It_Linha := 1;
      It_VL_Credito := 0;
      It_VL_Debito := 0;
      It_VL_Sld_Ant := 0;
      Close;
      SQL.Clear;
      SqlTxt:='SELECT MVF_CODIGO,MVF_CODCTB,MVF_DATA,MVF_CODHTB,MVF_CODPLC_C, MVF_CODPLC_D,MVF_VL_CREDITO,MVF_VL_DEBITO,MVF_HISTORISCO, '+
              'MVF_TIPO,MVF_CODQTC,MVF_CODUSU, MVF_CODMHA,  (EMP_NUMBCO || '' - '' || CTB_AGENCIA || '' - '' || CTB_CONTA) CTB_COMPLETO, '+
              'MVF_DT_ORIG,MVF_NR_DOC '+
              'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro '+
              '   INNER JOIN TB_CONTABANCARIA tb_contabancaria '+
              '   ON (tb_contabancaria.CTB_CODIGO = tb_movim_financeiro.MVF_CODCTB) '+
              '   INNER JOIN TB_EMPRESA tb_empresa '+
              '   ON (tb_empresa.EMP_CODIGO = tb_contabancaria.CTB_CODBCO) '+
              'WHERE (MVF_CODCTB > 0) ';

      if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
        Begin
        SqlTxt := SqlTxt + ' AND (MVF_CODMHA=:MVF_CODMHA) ';
        end;

      if E_Historico.Text ='' then Lc_Historico := False else Lc_Historico := True;
      if Lc_Historico then SqlTxt := SqlTxt +'AND (MVF_HISTORISCO LIKE :MVF_HISTORISCO) ';
      IF ChBx_Periodo.Checked THEN  SqlTxt := SqlTxt +'AND (MVF_DATA BETWEEN :DATAINI AND :DATAFIM)  ';
      if RG_Tipo.ItemIndex =0 then SqlTxt := SqlTxt + 'AND (MVF_VL_DEBITO =0 or MVF_VL_DEBITO IS NULL)';
      if RG_Tipo.ItemIndex =1 then SqlTxt := SqlTxt + 'AND (MVF_VL_CREDITO =0 or MVF_VL_CREDITO IS NULL)';

      SQL.Add(SqlTxt+' ORDER BY MVF_CODIGO, MVF_DATA, MVF_HISTORISCO ');
      if Lc_Historico then ParamByName('MVF_HISTORISCO').AsString:='%'+E_Historico.Text+'%';
      IF ChBx_Periodo.Checked THEN
        BEGIN
        ParamByName('DATAINI').AsDate := E_Data_INI.Date;
        ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
        END;

      if not Grb_MnhaEmpresa.Visible then
        Begin
        ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
        end
      else
        Begin
        if not chbx_Empresas.Checked then
          ParamByName('MVF_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
        end;
      Open;
      end;
    end;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Lanca_Banco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Lanca_Banco:=nil;
end;

procedure TRL_Lanca_Banco.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inc(It_Linha);
  if (It_Linha mod 2) = 0 then Detalhe.Color := clSilver else Detalhe.Color := clWhite;
  It_VL_Credito := It_VL_Credito + Qr_Movimentacao.FieldByname('MVF_VL_CREDITO').AsCurrency;
  It_VL_Debito := It_VL_Debito + Qr_Movimentacao.FieldByname('MVF_VL_DEBITO').AsCurrency;
end;

procedure TRL_Lanca_Banco.RodapeDiarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_VL_Debito.Caption := FloatToStrF(It_VL_Debito,ffFixed,10,2);
  Lb_VL_Credito.Caption := FloatToStrF(It_VL_Credito,ffFixed,10,2);
  Lb_VL_Sld_Atual.Caption := FloatToStrF(It_VL_Sld_Ant + It_VL_Credito-It_VL_Debito,ffFixed,10,2);
  It_VL_Credito := 0;
  It_VL_Debito := 0;  
end;

procedure TRL_Lanca_Banco.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Lanca_Banco.Pc_Parametros;
begin
  with Fr_Imp_Banco do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Crédito';
      1 : Lb_Tipo_Doc.Caption := 'Débito';
      2 : Lb_Tipo_Doc.Caption := 'Todos';
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
    // Verificação da descrição
    if E_Historico.Text = '' then
      Lb_Historico.Caption := ''
    else
      Lb_Historico.Caption := E_Historico.Text;
    end;
end;
end.


