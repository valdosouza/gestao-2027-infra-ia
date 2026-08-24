unit Un_RL_Cto_RecSaldo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery;

type
  TRL_Cto_RecSaldo = class(TForm)
    Qr_Contas: TSTQuery;
    Qrpt: TQuickRep;
    Titulo: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel9: TQRLabel;
    Detalhe: TQRBand;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    E_Empresa: TQRDBText;
    Sumario: TQRBand;
    QRLabel11: TQRLabel;
    E_VL_Total: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Nome_Emp: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel4: TQRLabel;
    PageHeaderBand1: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Ds_Contas: TDataSource;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    E_Telefone: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    lb_form_pagto: TQRLabel;
    QRLabel19: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Qr_ContasAfterOpen(DataSet: TDataSet);
  private
    procedure Pc_Parametros;
    { Private declarations }
  public
    { Public declarations }
    It_Valor: Currency;
    procedure Pc_Busca;
  end;

var
  RL_Cto_RecSaldo: TRL_Cto_RecSaldo;

implementation

uses     UN_Imp_CtasReceber, UN_Sistema, Un_DM, Un_Principal, env;
{$R *.dfm}

procedure TRL_Cto_RecSaldo.Pc_Busca;
VaR
  Lc_SqlTxt_1 :String;
  Lc_SqlTxt_2 :String;
  Lc_SqlTxt_3 :String;
  Lc_Criterio : String;
  Lc_Cliente, Lc_Forma :Boolean;
  Lc_Dia,Lc_Mes,Lc_Ano:String;
Begin
  It_Valor:=0;
  Screen.Cursor:=crHourGlass;
  Lc_Dia:=Copy(DateTostr(Now),1,2);
  Lc_Mes:=Copy(DateTostr(Now),4,2);
  Lc_Ano:=Copy(DateTostr(Now),7,4);

  Qr_Contas.Active := False;
  Qr_Contas.SQL.Clear;

  if Fr_Imp_CtasReceber.Fm_FormaPagto.DBLCB_FormaPagto.Text ='' then Lc_Forma := False else Lc_Forma := True;

  Lc_SqlTxt_2 :=  'SELECT COALESCE(SUM(FIN_VL_PARCELA),0 ) FIN_DEBITO           '+
                  '  FROM TB_FINANCEIRO Tb_financeiro                           '+
                  '    INNER JOIN TB_EMPRESA Tb_empresa                         '+
                  '    ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP)   '+
                  '    LEFT JOIN TB_ENDERECO tb_endereco                        '+
                  '    ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)      '+
                  'WHERE((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) and        '+
                  '         END_PRINCIPAL = ''S'' AND                           '+
                  '         FIN_OPERACAO = ''D'' AND                            '+
                  '         FIN_BAIXA = ''N'' AND                               '+
                  '         FIN_CODEMP = Tb_financeiro_1.FIN_CODEMP AND         '+
                  '         FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM     ';


  Lc_SqlTxt_1 :=  'SELECT Tb_financeiro_1.FIN_CODEMP, EMP_NOME, EMP_FANTASIA, END_FONE, SUM(FIN_VL_PARCELA) - ( ' + Lc_SqlTxt_2 +' ) as FIN_TOTAL          '+
                  '  FROM TB_FINANCEIRO Tb_financeiro_1                         '+
                  '    INNER JOIN TB_EMPRESA Tb_empresa                         '+
                  '    ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro_1.FIN_CODEMP) '+
                  '    LEFT JOIN TB_ENDERECO tb_endereco                        '+
                  '    ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)      ';

  if Lc_Forma then Lc_SqlTxt_1 := Lc_SqlTxt_1 +'    INNER JOIN TB_FORMAPAGTO Tb_formapagto                   '+
                                               '    ON  (Tb_formapagto.FPT_CODIGO = Tb_financeiro_1.FIN_CODFPG)   ';

  Lc_SqlTxt_3 :=  '  WHERE((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) and      '+
                  '         END_PRINCIPAL = ''S'' AND                           '+
                  '         FIN_OPERACAO = ''C'' AND                            '+
                  '         FIN_BAIXA = ''N'' AND                               '+
                  '         FIN_CODMHA=:FIN_CODMHA AND                          '+
                  '         FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM     ';

  Lc_SqlTxt_1 := Lc_SqlTxt_1 + Lc_SqlTxt_3;
  if Fr_Imp_CtasReceber.DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;
  if Lc_Cliente then Lc_SqlTxt_1 := Lc_SqlTxt_1 +'AND FIN_CODEMP =:FIN_CODEMP ';

  if Fr_Imp_CtasReceber.Fm_FormaPagto.DBLCB_FormaPagto.Text ='' then Lc_Forma := False else Lc_Forma := True;
  if Lc_Forma then Lc_SqlTxt_1 := Lc_SqlTxt_1 +'AND FIN_CODFPG =:FIN_CODFPG ';

  if Fr_Imp_CtasReceber.RG_Tipo.ItemIndex =1 then Lc_SqlTxt_1 := Lc_SqlTxt_1 + 'AND (FIN_DT_VENCIMENTO < '''+Lc_Mes+'/'+Lc_Dia+'/'+Lc_Ano+''' ) ';

    Lc_SqlTxt_1 := Lc_SqlTxt_1 + 'GROUP BY FIN_CODEMP, EMP_NOME, EMP_FANTASIA, END_FONE ';

  if Fr_Imp_CtasReceber.ChBx_Nome.Checked then
    Qr_Contas.SQL.Add(Lc_SqlTxt_1 + ' ORDER BY EMP_NOME ')
  else
    Qr_Contas.SQL.Add(Lc_SqlTxt_1 + ' ORDER BY EMP_FANTASIA ');

  if Lc_Cliente then Qr_Contas.ParamByName('FIN_CODEMP').AsInteger := Fr_Imp_CtasReceber.DBLCB_Empresa.KeyValue;
  if Lc_Forma then Qr_Contas.ParamByName('FIN_CODFPG').AsInteger := Fr_Imp_CtasReceber.Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
  Qr_Contas.ParamByName('DATAINI').AsDate := Fr_Imp_CtasReceber.E_Data_INI.Date;
  Qr_Contas.ParamByName('DATAFIM').AsDate := Fr_Imp_CtasReceber.E_Data_FIM.Date;

  Qr_Contas.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
  Qr_Contas.Active := True;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Cto_RecSaldo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;


procedure TRL_Cto_RecSaldo.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Cto_RecSaldo.Pc_Parametros;
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
      Lb_Nome_Emp.Caption := 'Todos'
    else
      Lb_Nome_Emp.Caption := DBLCB_Empresa.Text;


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

procedure TRL_Cto_RecSaldo.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_VL_Total.Caption := FloatToStrF(It_Valor ,ffFixed,10,2)
end;

procedure TRL_Cto_RecSaldo.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Telefone.Caption := fc_MascaraFone(Qr_Contas.FieldByName('END_FONE').AsString);
  It_Valor := It_Valor + Qr_Contas.FieldByName('FIN_TOTAL').AsCurrency;
end;

procedure TRL_Cto_RecSaldo.Qr_ContasAfterOpen(DataSet: TDataSet);
begin
  (Qr_Contas.FieldByName('FIN_TOTAL') as TNumericField).DisplayFormat        := '0.00##';
end;

end.
