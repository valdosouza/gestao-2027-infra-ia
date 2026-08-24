unit UN_RL_VendaMensal;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_VendaMensal = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Vendas: TSTQuery;
    Lb_Titulo: TQRLabel;
    Grp_Data: TQRGroup;
    QRLabel1: TQRLabel;
    QRStringsBand1: TQRStringsBand;
    Lb_Mes: TQRLabel;
    Lb_Vl_Venda: TQRLabel;
    QRBand1: TQRBand;
    QRLabel9: TQRLabel;
    Lb_Tl_Anual: TQRLabel;
    Lb_Cliente: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRStringsBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
      It_Dia : Integer;
      It_Mes : Integer;
      It_Ano : String;
      It_Vl_Anual: Currency;
  public
    { Public declarations }
    procedure Pc_Busca(Pc_DataIni : String; Pc_DataFim:String);
  end;

var
  RL_VendaMensal: TRL_VendaMensal;

implementation

uses     UN_Imp_Vendas, Un_DM, UN_Backup, UN_Sistema, Un_Funcoes, StdCtrls, Un_Regra_Negocio;
{$R *.dfm}



procedure TRL_VendaMensal.Pc_Busca(Pc_DataIni : String; Pc_DataFim:String);
VaR
  Lc_SqlTxt :String;
  LC_REGIAO,  Lc_Cliente, Lc_Vendedor:Boolean;
begin
  Screen.Cursor:=crHourGlass;

  Qr_Vendas.Close;
  Qr_Vendas.SQL.Clear;

  Lc_SqlTxt := 'SELECT SUM(NFL_VL_TL_NOTA) VDA_VL_TOTAL                                   '+
            'FROM TB_NOTA_FISCAL tb_nota_fiscal                                        '+
            '    INNER JOIN TB_EMPRESA tb_empresa                                      '+
            '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)                '+
            '    INNER JOIN TB_PEDIDO tb_pedido                                        '+
            '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)                 '+
            ' INNER JOIN tb_endereco tb_endereco                                       '+
            ' ON (tb_endereco.end_codigo = tb_pedido.ped_codend)                       '+
            'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') AND (PED_TIPO = 1) AND (NFL_STATUS = ''F'')    ';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( NFL_CODMHA =:NFL_CODMHA ) ';

  Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
  if Fr_Imp_Vendas.DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;
  if Fr_Imp_Vendas.DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;
  if Fr_Imp_Vendas.DBLCB_Regiao.Text ='' then LC_REGIAO := False else LC_REGIAO := True;

  if LC_REGIAO then Lc_SqlTxt := Lc_SqlTxt + 'AND (END_REGIAO LIKE :END_REGIAO)';
  if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND ((EMP_NOME LIKE :EMP_NOME)OR (EMP_FANTASIA LIKE :EMP_NOME)) ';
  if Lc_vendedor then
    Begin
    if Fr_Imp_Vendas.Rb_Vend_Clliente.Checked then
      Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODVDOR =:PED_CODVDO) '
    else
      Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) '
    end;

  if Fr_Imp_Vendas.RG_Tipo.ItemIndex =0 then Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO ='''') or (NFL_NUMERO is null) ) ';
  if Fr_Imp_Vendas.RG_Tipo.ItemIndex =1 then Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO <>'''') or (NFL_NUMERO is not null) ) ';

  Qr_Vendas.SQL.Add(Lc_SqlTxt);
  if Lc_Cliente then Qr_Vendas.ParamByName('EMP_NOME').AsString:='%'+Fr_Imp_Vendas.E_Empresa.Text+'%';

  Qr_Vendas.ParamByName('DATAINI').AsString:=Pc_DataIni;
  Qr_Vendas.ParamByName('DATAFIM').AsString:=Pc_DataFim;
  if LC_REGIAO then Qr_Vendas.ParamByName('END_REGIAO').AsString:= '%' + Fr_Imp_Vendas.DBLCB_Regiao.Text + '%';

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
  Begin
    Qr_Vendas.ParamByName('NFL_CODMHA').AsInteger :=  Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;
  End;

  Qr_Vendas.Open;
  Screen.Cursor:=crDefault;
end;

procedure TRL_VendaMensal.FormCreate(Sender: TObject);
begin
  Pc_AtivaEstabelecimento;
end;

procedure TRL_VendaMensal.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_Dia := 0;
  It_Mes := 0;
  It_Ano := Copy(DateToStr(Fr_Imp_Vendas.E_Data_Ini.Date),7,4);
  Lb_Titulo.Caption := 'Relatório de Vendas do Ano de ' + It_Ano;
  It_Vl_Anual := 0;
  Pc_Cab_Relatorio(Qrpt);
  Lb_Cliente.Caption := Fr_Imp_Vendas.E_Empresa.Text;

end;

procedure TRL_VendaMensal.QRStringsBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_DataIni:String;
  Lc_DataFim:String;
begin
  Inc(It_Mes);
  It_Dia := UltDiaDoMes(StrToDate('01/'+ IntToStr(It_Mes) + '/'+ It_Ano));
  Lc_DataIni := '01/' + IntToStr(It_Mes) + '/'+ It_Ano;
  Lc_DataFim := IntToStr(It_Dia) + '/' + IntToStr(It_Mes) + '/'+ It_Ano;
  Pc_Busca(Lc_DataIni,Lc_DataFim);
  case It_Mes of
    1:Lb_Mes.Caption := 'Janeiro';
    2:Lb_Mes.Caption := 'Fevereiro';
    3:Lb_Mes.Caption := 'Mar�o';
    4:Lb_Mes.Caption := 'Abril';
    5:Lb_Mes.Caption := 'Maio';
    6:Lb_Mes.Caption := 'Junho';
    7:Lb_Mes.Caption := 'Julho';
    8:Lb_Mes.Caption := 'Agosto';
    9:Lb_Mes.Caption := 'Setembro';
    10:Lb_Mes.Caption := 'Outubro';
    11:Lb_Mes.Caption := 'Novembro';
    12:Lb_Mes.Caption := 'Dezembro';
  end;
  Lb_Vl_Venda.Caption := FloatToStrF(Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency,ffNumber,10,2);
  It_Vl_Anual := It_Vl_Anual + Qr_Vendas.FieldByName('VDA_VL_TOTAL').AsCurrency;
end;

procedure TRL_VendaMensal.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_Anual.Caption := FloatToStrF(It_Vl_Anual,ffNumber,10,2);
end;

end.
