unit un_rl_pedido_pendente;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery, System.Math;

type
  Trl_pedido_pendente = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;                                                                                    
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    DetalheVenda: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    E_Vl_Venda: TQRLabel;
    QRBand4: TQRBand;
    QRLabel14: TQRLabel;
    QRLabel11: TQRLabel;
    Lb_Nome_Emp: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Ftr_Data: TQRBand;
    Grp_Data: TQRGroup;
    Lb_VL_Rec_Bruta: TQRLabel;
    Qr_Vendas: TSTQuery;
    QRLabel19: TQRLabel;
    E_VL_TL_Total: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    It_Vl_Venda, It_Vl_Tl_Venda: Real;
  public
    { Public declarations }
    procedure Pc_Busca;
    procedure Pc_Parametros;        
  end;

var
  rl_pedido_pendente: Trl_pedido_pendente;

implementation

uses     UN_Imp_Vendas, UN_Sistema, ComCtrls, Un_DM, DBCtrls, Un_Regra_Negocio, un_principal, env;
{$R *.dfm}

{ Trl_pedido_pendente }

procedure Trl_pedido_pendente.Pc_Busca;
var
  Lc_SqlTxt:String;
  Lc_Aux : String;
  LC_REGIAO,Lc_Cliente, Lc_Vendedor:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  It_Vl_Venda := 0;
  It_Vl_Tl_Venda := 0;

  Qr_Vendas.Close;
  Qr_Vendas.SQL.Clear;
  Qr_Vendas.SQL.Add(' SELECT DISTINCT PED_CODIGO,PED_DATA,PED_NUMERO,PED_VL_PEDIDO, tb_empresa.EMP_NOME                ');
  Qr_Vendas.SQL.Add(' FROM TB_PEDIDO tb_pedido                                                                         ');
  Qr_Vendas.SQL.Add(' LEFT JOIN tb_nota_fiscal tb_nota_fiscal    ON (tb_nota_fiscal.nfl_codped = tb_pedido.ped_codigo) ');
  Qr_Vendas.SQL.Add(' INNER JOIN TB_EMPRESA tb_empresa       ON (tb_empresa.EMP_CODIGO = tb_pedido.ped_codemp)         ');
  Qr_Vendas.SQL.Add(' INNER JOIN tb_endereco tb_endereco  ON (tb_endereco.end_codigo = tb_pedido.ped_codend)           ');
  Qr_Vendas.SQL.Add(' wHERE (PED_CODIGO IS NOT NULL) AND (PED_TIPO = 1)                                                ');
  Qr_Vendas.SQL.Add(' AND PED_FATURADO = ''N''                                           ');

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
    Qr_Vendas.SQL.Add(' AND ( Ped_CODMHA =:Ped_CODMHA)' );

    //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
    Lc_Aux := Trim(Fc_codigosNegocio);
    If Length(Lc_Aux) > 0 then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ((PED_CODNEG NOT IN (' + Lc_Aux + ')) or (PED_CODNEG IS NULL))';

  if Fr_Imp_Vendas.DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;
  if Fr_Imp_Vendas.DBLCB_Vendedor.Text ='' then Lc_Vendedor := False else Lc_Vendedor := True;
  if Fr_Imp_Vendas.DBLCB_Regiao.Text ='' then LC_REGIAO := False else LC_REGIAO := True;  

  if LC_REGIAO then Lc_SqlTxt := Lc_SqlTxt +'AND (END_REGIAO LIKE :END_REGIAO)';
  if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODEMP =:PED_CODEMP) ';
  if Lc_vendedor then
    Begin
    if Fr_Imp_Vendas.Rb_Vend_Clliente.Checked then
      Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODVDOR =:PED_CODVDO) '
    else
      Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) '
    end;
  if Fr_Imp_Vendas.ChBx_Periodo.Checked then Lc_SqlTxt := Lc_SqlTxt +'AND PED_DATA BETWEEN :DATAINI AND :DATAFIM  ';

  Qr_Vendas.SQL.Add(Lc_SqlTxt +'ORDER BY  PED_DATA, EMP_NOME ');
  if Lc_Cliente then Qr_Vendas.ParamByName('PED_CODEMP').AsInteger:=Fr_Imp_Vendas.DBLCB_Empresa.KeyValue;
  if Lc_Vendedor then Qr_Vendas.ParamByName('PED_CODVDO').AsInteger:=Fr_Imp_Vendas.DBLCB_Vendedor.KeyValue;
  if LC_REGIAO then Qr_Vendas.ParamByName('END_REGIAO').AsString  := '%' + Fr_Imp_Vendas.DBLCB_Regiao.Text + '%';

  if Fr_Imp_Vendas.ChBx_Periodo.Checked then
  begin
    Qr_Vendas.ParamByName('DATAINI').AsDate:=Fr_Imp_Vendas.E_Data_INI.Date;
    Qr_Vendas.ParamByName('DATAFIM').AsDate:=Fr_Imp_Vendas.E_Data_FIM.Date;
  end;

  if NOT Fr_Imp_Vendas.Fm_LME.chbx_Empresas.Checked then
  Begin
    Qr_Vendas.ParamByName('Ped_CODMHA').AsInteger :=  Fr_Imp_Vendas.Fm_LME.Dblcb_Lista.KeyValue;
  End;
  Qr_Vendas.Open;
  Qr_Vendas.RecordCount;  
  Screen.Cursor:=crDefault;      
 
end;

procedure Trl_pedido_pendente.Pc_Parametros;
begin
  with Fr_Imp_Vendas do
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
    // Verificar o nome do Vendedor
    if trim(DBLCB_Vendedor.Text) = '' then
      Lb_Vendedor.Caption := 'Todos'
    else
      Lb_Vendedor.Caption := DBLCB_Vendedor.Text;
  end;

end;

procedure Trl_pedido_pendente.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure Trl_pedido_pendente.DetalheVendaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  E_Vl_Venda.Caption := FloatToStrF(Qr_Vendas.FieldByName('PED_VL_PEDIDO').AsCurrency,ffNumber,18,2);
  It_Vl_Venda := Qr_Vendas.FieldByName('PED_VL_PEDIDO').AsCurrency;
  It_Vl_Tl_Venda := It_Vl_Tl_Venda + It_Vl_Venda;
  It_Vl_Venda := 0;
end;

procedure Trl_pedido_pendente.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Vl_TL_Total.Caption     := FloatToStrF(It_Vl_Tl_Venda ,ffNumber,18,2);
end;

procedure Trl_pedido_pendente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  rl_pedido_pendente:=nil;
end;

end.
