unit un_rl_resumo_forma_pagamento;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRl_RESUMO_FORMA_Pagto = class(TForm)
    Qr_CtasReceber: TSTQuery;
    Qr_CtasReceberFPT_DESCRICAO: TStringField;
    Qr_CtasReceberFIN_OPERACAO: TStringField;
    Qr_CtasReceberSUM: TBCDField;
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel12: TQRLabel;
    QRBand4: TQRBand;
    QRLabel14: TQRLabel;
    Grupo1: TQRGroup;
    QRExpr5: TQRExpr;
    QRBand5: TQRBand;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRBand6: TQRBand;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRBand7: TQRBand;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Cliente: TQRLabel;
    QRLabel42: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    QRLabel44: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    lb_form_pagto: TQRLabel;
    QRLabel47: TQRLabel;
    QRBand8: TQRBand;
    QRSysData3: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel15: TQRLabel;
    QRDBText4: TQRDBText;
    lbl_operacao: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    lbl_saldo: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_vl_credito, it_vl_debito:Double;
    procedure Pc_busca;
    procedure Pc_Parametros;
  end;

var
  Rl_RESUMO_FORMA_Pagto: TRl_RESUMO_FORMA_Pagto;

implementation

{$R *.dfm}
uses     UN_Imp_CtasReceber, UN_DM, UN_Sistema, ComCtrls, Un_Principal, env;
procedure TRl_RESUMO_FORMA_Pagto.Pc_busca;
VaR
  SqlTxt:String;
  PCliente,PFormaPagto :Boolean;
  Dia,Mes,Ano:String;
begin
  with Fr_Imp_CtasReceber do
    Begin
   Screen.Cursor:=crHourGlass;
    Qr_CtasReceber.Close;
    Qr_CtasReceber.SQL.Clear;
    Dia:=Copy(DateToStr(Now),1,2);
    Mes:=Copy(DateToStr(Now),4,2);
    Ano:=Copy(DateToStr(Now),7,4);

    SqlTxt:= 'SELECT sum(FIN_VL_parcela),FPT_DESCRICAO,fin_operacao '+
             ' FROM TB_FINANCEIRO tb_financeiro '+
             '   INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
             '   ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
             '   INNER JOIN TB_EMPRESA Tb_empresa '+
             '   ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP) '+
             '   LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
             '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED ) '+
             '   LEFT JOIN TB_ENDERECO tb_endereco '+
             '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
             '    INNER JOIN TB_FORMAPAGTO tb_formapagto '+
             '    ON (tb_formapagto.FPT_CODIGO = tb_financeiro.FIN_CODFPG) '+
             '    LEFT OUTER JOIN TB_BOLETO tb_boleto '+
             '    ON (tb_boleto.BLT_CODQTC = tb_financeiro.FIN_CODQTC) '+
             '    LEFT OUTER JOIN TB_CONTABANCARIA tb_contabancaria '+
             '    ON (tb_contabancaria.CTB_CODIGO = tb_boleto.BLT_CODCTB) '+
             '    LEFT OUTER JOIN TB_EMPRESA tb_banco '+
             '    ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO) '+
             ' WHERE((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) AND (END_PRINCIPAL = ''S'') AND (FIN_CODMHA=:FIN_CODMHA) ';

    if DBLCB_Empresa.Text ='' then PCliente := False else PCliente := True;
    if Fm_FormaPagto.DBLCB_FormaPagto.Text ='' then PFormaPagto := False else PFormaPagto := True;

    if PCliente then SqlTxt := SqlTxt +'AND FIN_CODEMP =:FIN_CODEMP ';
    if PFormaPagto then SqlTxt := SqlTxt + 'AND FIN_CODFPG=:FIN_CODFPG ';

    if ChBx_Periodo.Checked then SqlTxt := SqlTxt +'AND FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM  ';
    SqlTxt := SqlTxt +'AND FIN_BAIXA = ''N'' ';
    if RG_Tipo.ItemIndex = 0 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO >= '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';
    if RG_Tipo.ItemIndex = 1 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO < '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';

    Qr_CtasReceber.SQL.Add(SqlTxt + ' group by  FPT_DESCRICAO,fin_operacao ORDER BY FPT_DESCRICAO ');
    if PCliente then Qr_CtasReceber.ParamByName('FIN_CODEMP').AsInteger:= DBLCB_Empresa.KeyValue;
    if PFormaPagto then Qr_CtasReceber.ParamByName('FIN_CODFPG').AsInteger := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
    if ChBx_Periodo.Checked then
      begin
      Qr_CtasReceber.ParamByName('DATAINI').AsDate:=E_Data_INI.Date;
      Qr_CtasReceber.ParamByName('DATAFIM').AsDate:=E_Data_FIM.Date;

      Qr_CtasReceber.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
      end;

    if Rb_Vend_Cliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       Qr_CtasReceber.ParamByName('EMP_CODVDOR').AsInteger := DBLCB_Vendedor.KeyValue;
    if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       Qr_CtasReceber.ParamByName('PED_CODVDO').AsInteger := DBLCB_Vendedor.KeyValue;

    Qr_CtasReceber.Open;
    Qr_CtasReceber.RecordCount;
    Screen.Cursor:=crDefault;
    END;
end;

procedure TRl_RESUMO_FORMA_Pagto.Pc_Parametros;
begin
  with Fr_Imp_CtasReceber do
  begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'A Vencer';
      1 : Lb_Tipo_Doc.Caption := 'Vencidos';
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
    // Verifica se o campo cliente foi preenchido
    if trim(DBLCB_Empresa.Text) = '' then
      Lb_Cliente.Caption := 'Todos'
    else
      Lb_Cliente.Caption := DBLCB_Empresa.Text;

//verifica forma de pagamento
    if trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) = '' then
      lb_form_pagto.Caption := 'Todos'
    else
      lb_form_pagto.Caption := Fm_FormaPagto.DBLCB_FormaPagto.Text;

     // Verifica se o tipo do relatorio
    case LBx_TipoRelatorio.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'Vencimento';
      1 : Lb_Tipo_Rl.caption := 'Cliente';
      2 : Lb_Tipo_Rl.caption := 'Prancheta';
    end;
  end;
end;

procedure TRl_RESUMO_FORMA_Pagto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRl_RESUMO_FORMA_Pagto.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 IF Qr_CtasReceberFIN_OPERACAO.AsString = 'C' THEN
   BEGIN
   LBL_OPERACAO.Caption:= 'Crédito';
   LBL_OPERACAO.Font.Color:=clBlack;
   It_vl_credito:=Qr_CtasReceberSUM.AsFloat;
   QRDBText5.Font.Color:=clBlack;
   END
 ELSE
   BEGIN
   LBL_OPERACAO.Caption:= 'DÊdito';
   LBL_OPERACAO.Font.Color:=clRed;
   QRDBText5.Font.Color:=clRed;
   it_vl_debito:=Qr_CtasReceberSUM.AsFloat;
   END;
end;

procedure TRl_RESUMO_FORMA_Pagto.QRBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbl_saldo.Caption:=FormatFloat('#,##0.00', It_vl_credito - it_vl_debito);
  It_vl_credito:=0;
  it_vl_debito:=0;  
end;

procedure TRl_RESUMO_FORMA_Pagto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

end.
