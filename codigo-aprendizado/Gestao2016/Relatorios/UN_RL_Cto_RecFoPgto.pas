unit UN_RL_Cto_RecFoPgto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Cto_RecFoPgto = class(TForm)
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRBand1: TQRBand;
    Grupo1: TQRGroup;
    QRDBText1: TQRDBText;
    QRExpr5: TQRExpr;
    Detalhe: TQRBand;
    E_EMPRESA: TQRLabel;
    SubTotal: TQRBand;
    Sumario: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    E_Vencimento: TQRLabel;
    QRLabel2: TQRLabel;
    E_Fone: TQRLabel;
    Qr_CtasReceber: TSTQuery;
    E_Emissao: TQRLabel;
    QRLabel5: TQRLabel;
    E_Pedido: TQRLabel;
    Lb_Vl_Parcela: TQRLabel;
    Lb_vl_Subtotal: TQRLabel;
    Lb_vl_Total: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Cliente: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRLabel12: TQRLabel;
    E_Pagto: TQRLabel;
    E_Detalhes: TQRLabel;
    QRLabel15: TQRLabel;
    lb_form_pagto: TQRLabel;
    QRLabel19: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SubTotalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  It_Vl_SubTotal: Currency;
  It_Vl_Total: Currency;
  It_Vl_Sub_Credito: Currency;
  It_Vl_Ttal_Credito: Currency;
  procedure Pc_Busca;
  procedure Pc_MultaJuros;
  procedure Pc_DefineCor;
  procedure Pc_Parametros;
  end;

var
  RL_Cto_RecFoPgto: TRL_Cto_RecFoPgto;

implementation

uses     UN_Imp_CtasReceber, UN_DM, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.dfm}

procedure TRL_Cto_RecFoPgto.Pc_DefineCor;
Begin
  if Qr_CtasReceber.FieldByName('FIN_OPERACAO').AsString = 'C' then
    Begin
    E_EMPRESA.Font.Color := clBlack;
    E_Fone.Font.Color := clBlack;
    E_Emissao.Font.Color := clBlack;
    E_Pedido.Font.Color := clBlack;
    E_Vencimento.Font.Color := clBlack;
    Lb_Vl_Parcela.Font.Color := clBlack;
    end
  else
    Begin
    E_EMPRESA.Font.Color := clRed;
    E_Fone.Font.Color := clRed;
    E_Emissao.Font.Color := clRed;
    E_Pedido.Font.Color := clRed;
    E_Vencimento.Font.Color := clRed;
    Lb_Vl_Parcela.Font.Color := clRed;
    end;
end;


procedure TRL_Cto_RecFoPgto.Pc_MultaJuros;
Var
  Lc_I : Integer;
  Lc_Carencia : Integer;
  Lc_valor : Real;
  Lc_Multa : Real;
  Lc_juros : Real;
  Lc_dias : Real;
  Lc_Vl_Juros : Real;
Begin
  Lc_Multa := 0;
  Lc_juros := 0;
  Lc_dias := 0;
  Lc_Vl_Juros := 0;
  Lc_Carencia := StrToIntDef(Fc_Tb_Geral('L','FIN_CARENCIA',''),0);
  if  (Qr_CtasReceber.FieldByName('FIN_DT_VENCIMENTO').AsDateTime + Lc_Carencia) < Date then
    Begin
    Lc_dias := Date - Qr_CtasReceber.FieldByName('FIN_DT_VENCIMENTO').AsDateTime;
    Lc_valor := Qr_CtasReceber.FieldByName('FIN_VL_PARCELA').AsCurrency;
    Lc_Multa := Lc_Multa + (Lc_valor * (StrToIntDef(Fc_Tb_Geral('L','FIN_MULTA',''),0)/100));
    Lc_juros := StrToFloatDef(Fc_Tb_Geral('L','FIN_JUROS',''),0) / 30;
    Lc_Vl_Juros := Lc_Vl_Juros + (Lc_valor * ((Lc_juros * Lc_dias)/100));
    end;
  Lb_Vl_Parcela.Caption := FloatToStrF(Qr_CtasReceber.FieldByName('FIN_VL_PARCELA').AsCurrency + Lc_Vl_Juros + Lc_Multa, ffFixed, 10, 2);
  It_Vl_SubTotal := It_Vl_SubTotal + Qr_CtasReceber.FieldByName('FIN_VL_PARCELA').AsCurrency + Lc_Vl_Juros + Lc_Multa;
  It_Vl_Total := It_Vl_Total  + Qr_CtasReceber.FieldByName('FIN_VL_PARCELA').AsCurrency + Lc_Vl_Juros + Lc_Multa;
end;

procedure TRL_Cto_RecFoPgto.Pc_Busca;
VaR
  SqlTxt:String;
  PCliente,PFormaPagto :Boolean;
  Dia,Mes,Ano:String;
begin
  with Fr_Imp_CtasReceber do
    Begin
    Screen.Cursor:=crHourGlass;

    It_Vl_SubTotal := 0;
    It_Vl_Total := 0;
    It_Vl_Sub_Credito := 0;
    It_Vl_Ttal_Credito := 0;
    Qr_CtasReceber.Close;
    Qr_CtasReceber.SQL.Clear;
    Dia:=Copy(DateToStr(Now),1,2);
    Mes:=Copy(DateToStr(Now),4,2);
    Ano:=Copy(DateToStr(Now),7,4);

    SqlTxt:= 'SELECT DISTINCT '+
             '    FIN_CODQTC, '+
             '    FIN_DT_VENCIMENTO, '+
             '    FIN_DT_PAGTO, '+
             '    FIN_CODEMP, '+
             '    tb_empresa.EMP_NOME, '+
             '    tb_empresa.EMP_FANTASIA, '+
             '    END_FONE, '+
             '    END_REGIAO, '+
             '    FIN_NUMERO, '+
             '    FIN_VL_PARCELA, '+
             '    FIN_VL_PAGO, '+
             '    FIN_CODFPG, '+
             '    FIN_BAIXA, '+
             '    FIN_OPERACAO, '+
             '    FIN_CODMHA, '+
             '    FIN_CODPED, '+
             '    FIN_DATA, '+
             '    FPT_DESCRICAO, '+
             '    tb_banco.EMP_NOME ||''  AG.''|| tb_contabancaria.CTB_AGENCIA ||''  CC. ''|| tb_contabancaria.CTB_CONTA AS BANCO  '+
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

             ' WHERE((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) AND (END_PRINCIPAL = ''S'') AND (FIN_CODMHA=:FIN_CODMHA)          ';


    if DBLCB_Empresa.Text ='' then PCliente := False else PCliente := True;
    if Fm_FormaPagto.DBLCB_FormaPagto.Text ='' then PFormaPagto := False else PFormaPagto := True;

    if PCliente then SqlTxt := SqlTxt +'AND FIN_CODEMP =:FIN_CODEMP ';
    if PFormaPagto then SqlTxt := SqlTxt + 'AND FIN_CODFPG=:FIN_CODFPG ';

    if ChBx_Periodo.Checked then SqlTxt := SqlTxt +'AND FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM  ';
    SqlTxt := SqlTxt +'AND FIN_BAIXA = ''N'' ';
    if RG_Tipo.ItemIndex = 0 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO >= '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';
    if RG_Tipo.ItemIndex = 1 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO < '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';

    if Rb_Vend_Cliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       SqlTxt := SqlTxt +'AND (tb_empresa.EMP_CODVDOR =:EMP_CODVDOR) ';
    if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       SqlTxt := SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) ';

    Qr_CtasReceber.SQL.Add(SqlTxt+' ORDER BY FIN_DT_VENCIMENTO, EMP_NOME ');
    if PCliente then Qr_CtasReceber.ParamByName('FIN_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;
    if PFormaPagto then Qr_CtasReceber.ParamByName('FIN_CODFPG').AsInteger := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
    if ChBx_Periodo.Checked then
      begin
      Qr_CtasReceber.ParamByName('DATAINI').AsDate:=(E_Data_INI.Date);
      Qr_CtasReceber.ParamByName('DATAFIM').AsDate:=(E_Data_FIM.Date);

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

procedure TRL_Cto_RecFoPgto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TRL_Cto_RecFoPgto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Cto_RecFoPgto.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  Lc_Empresa:string;
begin
  Lc_Empresa := E_EMPRESA.Caption;
  Qr_CtasReceber.RecordCount;
  Pc_DefineCor;

  IF Fr_Imp_CtasReceber.ChBx_Nome.Checked then E_Empresa.Caption := Qr_CtasReceber.FieldByName('EMP_NOME').AsString;
  IF Fr_Imp_CtasReceber.ChBx_Fantasia.Checked then E_Empresa.Caption := Qr_CtasReceber.FieldByName('EMP_FANTASIA').AsString;

  E_Fone.Caption := Qr_CtasReceber.FieldByName('END_FONE').AsString;
  E_Emissao.Caption := Qr_CtasReceber.FieldByName('FIN_DATA').AsString;
  E_Pedido.Caption := Qr_CtasReceber.FieldByName('FIN_NUMERO').AsString;
  E_Vencimento.Caption := Qr_CtasReceber.FieldByName('FIN_DT_VENCIMENTO').AsString;
  E_Pagto.Caption := Qr_CtasReceber.FieldByName('FPT_DESCRICAO').AsString;
  E_Detalhes.Caption := Qr_CtasReceber.FieldByName('BANCO').AsString;
  if Qr_CtasReceber.FieldByName('FIN_OPERACAO').AsString = 'C' then
    Begin
    Pc_MultaJuros;
    end
  else
    Begin
    Lb_Vl_Parcela.Caption := FloatToStrF(Qr_CtasReceber.FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2);
    It_Vl_Sub_Credito := It_Vl_Sub_Credito + Qr_CtasReceber.FieldByName('FIN_VL_PARCELA').AsCurrency;
    end;
end;

procedure TRL_Cto_RecFoPgto.SubTotalBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_vl_Subtotal.Caption := FloatToStrF(It_Vl_SubTotal - It_Vl_Sub_Credito, ffFixed, 10, 2);
  It_Vl_Ttal_Credito := It_Vl_Ttal_Credito + It_Vl_Sub_Credito;
  It_Vl_Sub_Credito := 0;
  It_Vl_SubTotal := 0;
end;

procedure TRL_Cto_RecFoPgto.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_vl_Total.Caption := FloatToStrF(It_Vl_Total - It_Vl_Ttal_Credito, ffFixed, 10, 2);
end;

procedure TRL_Cto_RecFoPgto.Pc_Parametros;
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
      3 : Lb_Tipo_Rl.caption := 'Forma de Pagamento';
      4 : Lb_Tipo_Rl.caption := 'Resumo Saldo';
    end;
  end;
end;


end.
