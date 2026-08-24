unit UN_RL_Contas_Receber_P;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRCtrls;

type
  TRL_Contas_Receber_P = class(TForm)
    Qrpt: TQuickRep;
    QRExpr5: TQRExpr;
    Detalhe: TQRBand;
    SubTotal: TQRBand;
    Qr_CtasReceber: TSTQuery;
    PageHeaderBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    E_VL_Pago: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    E_Vl_Divida: TQRLabel;
    Grp_Cliente: TQRGroup;
    QRExpr2: TQRExpr;
    Grp_Regiao: TQRGroup;
    E_Cliente: TQRLabel;
    QRBand1: TQRBand;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SubTotalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Grp_RegiaoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  It_Vl_Divida: Currency;
  It_Vl_Credito: Currency;
  procedure Pc_Busca;
  procedure Pc_MultaJuros;
  procedure Pc_Parametros;
  end;

var
  RL_Contas_Receber_P: TRL_Contas_Receber_P;

implementation

uses     UN_Imp_CtasReceber, UN_DM, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.dfm}

procedure TRL_Contas_Receber_P.Pc_MultaJuros;
Var
  Lc_I : Integer;
  Lc_data : String;
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
  Lc_Carencia := StrToIntDef(Fc_Tb_Geral('L','FIN_G_CARENCIA',''),0);
  if Qr_CtasReceber.FieldByname('FIN_OPERACAO').AsString = 'C' then
  Begin
    if  (Qr_CtasReceber.FieldByname('FIN_DT_VENCIMENTO').AsDateTime + Lc_Carencia) < Date then
    Begin
      Lc_dias := Date - Qr_CtasReceber.FieldByname('FIN_DT_VENCIMENTO').AsDateTime;
      Lc_valor := Qr_CtasReceber.FieldByname('FIN_VL_PARCELA').AsCurrency;
      Lc_Multa := Lc_Multa + (Lc_valor * (StrToIntDef(Fc_Tb_Geral('L','FIN_G_MULTA',''),0)/100));
      Lc_juros := StrToFloatDef(Fc_Tb_Geral('L','FIN_G_JUROS',''),0) / 30;
      Lc_Vl_Juros := Lc_Vl_Juros + (Lc_valor * ((Lc_juros * Lc_dias)/100));
    end;
    It_Vl_Divida := Qr_CtasReceber.FieldByname('FIN_VL_PARCELA').AsCurrency + Lc_Vl_Juros + Lc_Multa;
  end
  else
  Begin
    It_Vl_Credito :=  Qr_CtasReceber.FieldByname('FIN_VL_PARCELA').AsCurrency;
  end;
end;

procedure TRL_Contas_Receber_P.Pc_Busca;
VaR
  SqlTxt:String;
  PCliente:Boolean;
  Dia,Mes,Ano:String;
begin
  with Fr_Imp_CtasReceber do
    Begin
    Screen.Cursor:=crHourGlass;
    It_Vl_Divida := 0;
    Qr_CtasReceber.Close;
    Qr_CtasReceber.SQL.Clear;
    Dia:=Copy(DateToStr(Now),1,2);
    Mes:=Copy(DateToStr(Now),4,2);
    Ano:=Copy(DateToStr(Now),7,4);

    SqlTxt:= ' SELECT DISTINCT FIN_CODQTC, FIN_DT_VENCIMENTO, FIN_DT_PAGTO, FIN_CODEMP, EMP_NOME, EMP_FANTASIA, END_FONE, '+
             ' END_REGIAO, FIN_NUMERO,FIN_VL_PARCELA, FIN_VL_PAGO, FIN_CODFPG, FIN_BAIXA, FIN_OPERACAO, '+
             ' FIN_CODMHA,FIN_CODPED,FIN_DATA '+
             ' FROM TB_FINANCEIRO Tb_financeiro '+
             '   INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
             '   ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
             '   INNER JOIN TB_EMPRESA Tb_empresa '+
             '   ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP) '+
             '   LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
             '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED ) '+
             '   LEFT JOIN TB_ENDERECO tb_endereco '+
             '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
             ' WHERE((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) and END_PRINCIPAL = ''S'' ';

    if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
      Begin
      SqlTxt := SqlTxt + ' AND (FIN_CODMHA =:FIN_CODMHA) ';
      end;

    if RG_Conta.ItemIndex = 0 then
      SqlTxt := SqlTxt + 'AND (FIN_BAIXA =''N'') AND (FIN_SITUACAO =''N'') ';
    if RG_Conta.ItemIndex = 1 then
      SqlTxt := SqlTxt + 'AND (FIN_BAIXA =''N'') AND (FIN_SITUACAO =''D'') ';
    if RG_Conta.ItemIndex = 2 then
      SqlTxt := SqlTxt + 'AND (FIN_BAIXA =''N'') AND ((FIN_SITUACAO =''D'') or (FIN_SITUACAO =''N''))';

    if ChBx_Periodo.Checked then SqlTxt := SqlTxt +'AND FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM  ';

    if DBLCB_Empresa.Text ='' then PCliente := False else PCliente := True;
    if PCliente then SqlTxt := SqlTxt +'AND FIN_CODEMP =:FIN_CODEMP ';

    if RG_Tipo.ItemIndex =0 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO >= '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';
    if RG_Tipo.ItemIndex =1 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO < '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';

    if Rb_Vend_Cliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       SqlTxt := SqlTxt +'AND (tb_empresa.EMP_CODVDOR =:EMP_CODVDOR) ';
    if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       SqlTxt := SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) ';
       
    Qr_CtasReceber.SQL.Add(SqlTxt+' ORDER BY END_REGIAO, EMP_FANTASIA ');
    if PCliente then Qr_CtasReceber.ParamByName('FIN_CODEMP').AsInteger := DBLCB_Empresa.KeyValue;
    if Fr_Imp_CtasReceber.ChBx_Periodo.Checked then
      begin
      Qr_CtasReceber.ParamByName('DATAINI').AsDate:=(E_Data_INI.Date);
      Qr_CtasReceber.ParamByName('DATAFIM').AsDate:=(E_Data_FIM.Date);
      end;

    if not Grb_MnhaEmpresa.Visible then
      Begin
      Qr_CtasReceber.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
      end
    else
      Begin
      if not chbx_Empresas.Checked then
        Qr_CtasReceber.ParamByName('FIN_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
      end;

    if Rb_Vend_Cliente.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       Qr_CtasReceber.ParamByName('EMP_CODVDOR').AsInteger := DBLCB_Vendedor.KeyValue;
    if Rb_Vend_Pedido.Checked and (Trim(DBLCB_Vendedor.Text) <> '') then
       Qr_CtasReceber.ParamByName('PED_CODVDO').AsInteger := DBLCB_Vendedor.KeyValue;
              
    Qr_CtasReceber.Open;
    Screen.Cursor:=crDefault;
    END;
end;

procedure TRL_Contas_Receber_P.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TRL_Contas_Receber_P.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Contas_Receber_P.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_MultaJuros;
end;

procedure TRL_Contas_Receber_P.SubTotalBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  IF Fr_Imp_CtasReceber.ChBx_Nome.Checked then E_Cliente.Caption := Copy(Qr_CtasReceber.FieldByname('EMP_NOME').AsString,1,25);
  IF Fr_Imp_CtasReceber.ChBx_Fantasia.Checked then E_Cliente.Caption := Copy(Qr_CtasReceber.FieldByname('EMP_FANTASIA').AsString,1,25);
  E_Vl_Divida.Caption := FloatToStrF(It_Vl_Divida - It_Vl_Credito ,ffFixed,10,2) + ' ';
end;

procedure TRL_Contas_Receber_P.Grp_RegiaoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Vl_Divida := 0;
  It_Vl_Credito := 0
end;

procedure TRL_Contas_Receber_P.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  It_Vl_Divida := 0 ;
  It_Vl_Credito := 0;
end;

procedure TRL_Contas_Receber_P.Pc_Parametros;
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
     // Verifica se o tipo do relatorio
    case LBx_TipoRelatorio.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'Vencimento';
      1 : Lb_Tipo_Rl.caption := 'Cliente';
      2 : Lb_Tipo_Rl.caption := 'Prancheta';
    end;
  end;
end;
end.
