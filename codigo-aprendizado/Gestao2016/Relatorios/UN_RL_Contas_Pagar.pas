unit UN_RL_Contas_Pagar;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRCtrls;

type
  TRL_Contas_Pagar = class(TForm)
    Qrpt: TQuickRep;
    PageHeaderBand1: TQRBand;
    Titulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    Grupo1: TQRGroup;
    QRDBText1: TQRDBText;
    QRExpr5: TQRExpr;
    Detalhe: TQRBand;
    E_Financeiro: TQRLabel;
    E_Nr_Parcela: TQRLabel;
    E_Vencimento: TQRLabel;
    E_VL_Parcela: TQRLabel;
    e_empresa: TQRLabel;
    SubTotal: TQRBand;
    QRLabel11: TQRLabel;
    Sumario: TQRBand;
    QRLabel13: TQRLabel;
    Qr_CtasPagar: TSTQuery;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel2: TQRLabel;
    E_Nota: TQRLabel;
    Lb_vl_Subtotal: TQRLabel;
    Lb_vl_Total: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Fornecedor: TQRLabel;
    QRLabel14: TQRLabel;
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
  procedure Pc_DefineCor;
  procedure Pc_Parametros;
  end;

var
  RL_Contas_Pagar: TRL_Contas_Pagar;

implementation

uses     UN_Imp_CtasPagar, Un_DM, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.dfm}


procedure TRL_Contas_Pagar.Pc_DefineCor;
Begin
  if Qr_CtasPagar.FieldByname('FIN_OPERACAO').AsString = 'D' then
    Begin
    E_EMPRESA.Font.Color := clBlack;
    E_Nota.Font.Color := clBlack;
    E_Nr_Parcela.Font.Color := clBlack;
    E_Financeiro.Font.Color := clBlack;
    E_VL_Parcela.Font.Color := clBlack;
    E_Vencimento.Font.Color := clBlack;
    end
  else
    Begin
    E_EMPRESA.Font.Color := clRed;
    E_Nota.Font.Color := clRed;
    E_Nr_Parcela.Font.Color := clRed;
    E_Financeiro.Font.Color := clRed;
    E_VL_Parcela.Font.Color := clRed;
    E_Vencimento.Font.Color := clRed;
    end;
end;
procedure TRL_Contas_Pagar.Pc_Busca;
VaR
  SqlTxt:String;
  PFornece:Boolean;
  Dia,Mes,Ano:String;
begin
  with Fr_Imp_CtasPagar do
    Begin
    Screen.Cursor:=crHourGlass;
    It_Vl_SubTotal := 0;
    It_Vl_Total := 0;
    It_Vl_Sub_Credito := 0;
    It_Vl_Ttal_Credito := 0;
    Qr_CtasPagar.Close;
    Qr_CtasPagar.SQL.Clear;
    Dia:=Copy(DateTostr(Now),1,2);
    Mes:=Copy(DateTostr(Now),4,2);
    Ano:=Copy(DateTostr(Now),7,4);

    SqlTxt:=  ' SELECT '+
              ' FIN_CODIGO, '+
              ' FIN_CODEMP, '+
              ' FIN_DATA, '+
              ' FIN_CODPED, '+
              ' FIN_CODNFL, '+
              ' FIN_CODFPG, '+
              ' FIN_DT_VENCIMENTO, '+
              ' FIN_NUMERO, '+
              ' FIN_VL_PARCELA, '+
              ' FIN_NR_PARCELA, '+
              ' FIN_VL_JUROS, '+
              ' FIN_VL_MORA, '+
              ' FIN_VL_DESCONTO, '+
              ' FIN_VL_PAGO, '+
              ' FIN_DT_PAGTO, '+
              ' FIN_DT_BAIXA, '+
              ' FIN_BAIXA, '+
              ' FIN_PRAZO, '+
              ' NFL_CODIGO, EMP_NOME, EMP_FANTASIA, NFL_NUMERO, FIN_OPERACAO '+
              ' FROM TB_FINANCEIRO tb_financeiro '+
              '    LEFT OUTER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
              '    ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
              '    INNER JOIN TB_EMPRESA tb_empresa '+
              '    ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
              ' WHERE (FIN_CODIGO >0) AND (FIN_BAIXA = ''N'') AND ((FIN_TIPO = ''PA'') OR (FIN_TIPO = ''PM'')) ';


    if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
      Begin
      SqlTxt := SqlTxt + ' AND (FIN_CODMHA =:FIN_CODMHA) ';
      end;

    if DBLCB_Empresa.Text ='' then PFornece := False else PFornece := True;


    if PFornece then SqlTxt := SqlTxt +'AND FIN_CODEMP =:CODFOR ';
    if ChBx_Periodo.Checked then SqlTxt := SqlTxt +'AND FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM  ';
    if RG_Tipo.ItemIndex =0 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO >= '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';
    if RG_Tipo.ItemIndex =1 then SqlTxt := SqlTxt + 'AND (FIN_DT_VENCIMENTO < '''+Mes+'/'+Dia+'/'+Ano+''') AND (FIN_BAIXA=''N'' ) ';
    if RG_Tipo.ItemIndex =2 then SqlTxt := SqlTxt + 'AND (FIN_BAIXA=''N'' )';

    if ChBx_Nome.Checked then
      Qr_CtasPagar.SQL.Add(SqlTxt+' ORDER BY FIN_DT_VENCIMENTO, EMP_NOME ')
    else
      Qr_CtasPagar.SQL.Add(SqlTxt+' ORDER BY FIN_DT_VENCIMENTO, EMP_FANTASIA ');
      
    if PFornece then Qr_CtasPagar.ParamByName('CODFOR').AsInteger:=DBLCB_Empresa.KeyValue;
    if ChBx_Periodo.Checked then
      begin
      Qr_CtasPagar.ParamByName('DATAINI').AsDate:=E_Data_INI.Date;
      Qr_CtasPagar.ParamByName('DATAFIM').AsDate:=E_Data_FIM.Date;
      end;

    if not Grb_MnhaEmpresa.Visible then
      Begin
      Qr_CtasPagar.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
      end
    else
      Begin
      if not chbx_Empresas.Checked then
        Qr_CtasPagar.ParamByName('FIN_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
      end;
      
    Qr_CtasPagar.Open;
    Screen.Cursor:=crDefault;
    end;
end;

procedure TRL_Contas_Pagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Contas_Pagar:=nil;
end;

procedure TRL_Contas_Pagar.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Contas_Pagar.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with Fr_Imp_CtasPagar do
    Begin
    Pc_DefineCor;
    IF ChBx_Nome.Checked then E_Empresa.Caption := Qr_CtasPagar.FieldByname('EMP_NOME').AsString;
    IF ChBx_Fantasia.Checked then E_Empresa.Caption := Qr_CtasPagar.FieldByname('EMP_FANTASIA').AsString;
    E_Nota.Caption := Qr_CtasPagar.FieldByname('NFL_NUMERO').AsString;
    E_Nr_Parcela.Caption := Qr_CtasPagar.FieldByname('FIN_NR_PARCELA').AsString;
    E_Financeiro.Caption := Qr_CtasPagar.FieldByname('FIN_NUMERO').AsString;
    E_Vencimento.Caption := Qr_CtasPagar.FieldByname('FIN_DT_VENCIMENTO').AsString;
    E_VL_Parcela.Caption := FloatToStrF(Qr_CtasPagar.FieldByname('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2);
    if Qr_CtasPagar.FieldByname('FIN_OPERACAO').AsString = 'D' then
      It_Vl_SubTotal := It_Vl_SubTotal + Qr_CtasPagar.FieldByname('FIN_VL_PARCELA').AsCurrency
    else
      It_Vl_Sub_Credito := It_Vl_Sub_Credito + Qr_CtasPagar.FieldByname('FIN_VL_PARCELA').AsCurrency;
    end;
end;

procedure TRL_Contas_Pagar.SubTotalBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_vl_Subtotal.Caption := FloatToStrF(It_Vl_SubTotal - It_Vl_Sub_Credito, ffFixed, 10, 2);
  It_Vl_Ttal_Credito := It_Vl_Ttal_Credito + It_Vl_Sub_Credito;
  It_Vl_Total := It_Vl_Total + It_Vl_SubTotal;
  It_Vl_Sub_Credito := 0;
  It_Vl_SubTotal := 0;
end;

procedure TRL_Contas_Pagar.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_vl_Total.Caption := FloatToStrF(It_Vl_Total - It_Vl_Ttal_Credito, ffFixed, 10, 2);
end;

procedure TRL_Contas_Pagar.Pc_Parametros;
begin
  with Fr_Imp_CtasPagar do
    begin // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0:Lb_Tipo_Doc.Caption := 'A Vencer';
      1:Lb_Tipo_Doc.Caption := 'Vencidos';
      2:Lb_Tipo_Doc.Caption := 'Todos';
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
    if Trim(DBLCB_Empresa.Text) = '' then
      Lb_Fornecedor.Caption := 'Todos'
    else
      Lb_Fornecedor.Caption := DBLCB_Empresa.Text;
    end;
end;


end.
