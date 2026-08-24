unit UN_RL_Compras;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRCtrls;

type
  TRL_Compras = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    DetalheVenda: TQRBand;
    QRBand4: TQRBand;
    QRLabel10: TQRLabel;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Compras: TSTQuery;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    Lb_Tl_Total: TQRLabel;
    Ftr_Data: TQRBand;
    Grp_Data: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    Eq_Empresa: TQRDBText;
    QRLabel9: TQRLabel;
    Lb_Tl_Dia: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Fornecedor: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_Tl_SubTotal: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Tl_Desconto: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Ftr_DataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    IT_Vl_Venda, It_Vl_Total, It_Vl_Desconto : Real;
  public
    { Public declarations }

  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_Compras: TRL_Compras;

implementation

uses     UN_Imp_Compras, Un_DM, UN_Backup, UN_Sistema, ComCtrls, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}



procedure TRL_Compras.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  Lc_Cliente, Lc_Vendedor :Boolean;
begin
  with Fr_Imp_Compras do
    Begin
    Screen.Cursor:=crHourGlass;
    IF ChBx_Nome.Checked then Eq_Empresa.DataField := 'EMP_NOME';
    IF ChBx_Fantasia.Checked then Eq_Empresa.DataField := 'EMP_FANTASIA';
    IT_Vl_Venda := 0;
    It_Vl_Total := 0;
    It_Vl_Desconto := 0;
    Qr_Compras.Close;
    Qr_Compras.SQL.Clear;

    Lc_SqlTxt := ' SELECT DISTINCT NFL_CODIGO, NFL_DT_EMISSAO, PED_NUMERO, NFL_NUMERO,   '+
              ' EMP_NOME,EMP_FANTASIA, NFL_VL_TL_NOTA, NFL_CODMHA,PED_VL_DESCONTO '+
              ' FROM TB_NOTA_FISCAL tb_nota_fiscal '+
              '    INNER JOIN TB_EMPRESA tb_empresa '+
              '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
              '    INNER JOIN TB_PEDIDO tb_pedido '+
              '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
              ' WHERE (NFL_CODIGO IS NOT NULL) AND (PED_TIPO = 2) ';

    if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
      Begin
      Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
      end;              

    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;

    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';

    if ChBx_Periodo.Checked then Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
    if RG_Tipo.ItemIndex =0 then Lc_SqlTxt := Lc_SqlTxt + 'AND ( (NFL_NUMERO IS NULL) OR (NFL_NUMERO ='''') ) ';
    if RG_Tipo.ItemIndex =1 then Lc_SqlTxt := Lc_SqlTxt + 'AND ( (NFL_NUMERO IS NOT NULL) AND (NFL_NUMERO <>'''') ) ';


    IF ChBx_Nome.Checked then
      Qr_Compras.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_NOME ')
    ELSE
      Qr_Compras.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_FANTASIA ');

    if Lc_Cliente then Qr_Compras.ParamByName('NFL_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;
      if ChBx_Periodo.Checked then
        begin
        Qr_Compras.ParamByName('DATAINI').AsDate:=E_Data_INI.Date;
        Qr_Compras.ParamByName('DATAFIM').AsDate:=E_Data_FIM. date;
        end;

    if not Grb_MnhaEmpresa.Visible then
      Begin
      Qr_Compras.ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      end
    else
      Begin
      if not chbx_Empresas.Checked then
        Qr_Compras.ParamByName('NFL_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
      end;

    Qr_Compras.Open;
    Screen.Cursor:=crDefault;
    end;
end;

procedure TRL_Compras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Compras:=nil;
end;

procedure TRL_Compras.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_SubTotal.Caption:=FloatToStrF(It_Vl_Total,ffNumber,18,2);
  Lb_Tl_Desconto.Caption:=FloatToStrF(It_Vl_Desconto,ffNumber,18,2);
  Lb_Tl_Total.Caption:=FloatToStrF(It_Vl_Total - It_Vl_Desconto,ffNumber,18,2);
end;

procedure TRL_Compras.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   IT_Vl_Venda := IT_Vl_Venda + Qr_Compras.FieldByname('NFL_VL_TL_NOTA').AsCurrency;
   It_Vl_Desconto := It_Vl_Desconto + Qr_Compras.FieldByname('PED_VL_DESCONTO').AsCurrency;
end;

procedure TRL_Compras.FormCreate(Sender: TObject);
begin
  Pc_AtivaEstabelecimento;
  with Fr_Imp_Compras do
    Begin
    IF ChBx_Nome.Checked then
      Eq_Empresa.DataField := ('EMP_NOME');

    if ChBx_Fantasia.Checked then
      Eq_Empresa.DataField := ('EMP_FANTASIA');
    end;
end;

procedure TRL_Compras.Ftr_DataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 Lb_Tl_Dia.Caption := FloatToStrF(IT_Vl_Venda,ffNumber,18,2);
 It_Vl_Total := It_Vl_Total + IT_Vl_Venda;
 IT_Vl_Venda := 0;
end;

procedure TRL_Compras.QrptBeforePrint(Sender: TCustomQuickRep;
var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_Compras.Pc_Parametros;
begin
  with Fr_Imp_Compras do
    begin
    // Verifica tipos de documento
    case RG_Tipo.ItemIndex of
      0 : Lb_Tipo_Doc.Caption := 'Pedido';
      1 : Lb_Tipo_Doc.Caption := 'Notas';
      2 : Lb_Tipo_Doc.Caption := 'Todos';
    end;
    // Verifica data solicitada
    Lb_Data_Ini.Caption := DateToStr( E_Data_Ini.Date);
    Lb_Data_Fim.Caption := DateToStr( E_Data_Fim.Date);
    // Verifica se o campo cliente foi preenchido
    if Trim(DBLCB_Empresa.Text) = '' then
      Lb_Fornecedor.Caption := 'Todos'
    else
      Lb_Fornecedor.Caption := DBLCB_Empresa.Text;
    // Verifica se o tipo do relatorio
    case Cb_Tipo.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'Normal';
      1 : Lb_Tipo_Rl.caption := 'Detalhado';
    end;
  end;
end;


end.
