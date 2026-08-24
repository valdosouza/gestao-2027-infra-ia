unit UN_RL_ComprasDetalhada;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, ExtCtrls, DB, STQuery, QRCtrls;

type
  TRL_ComprasDetalhada = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel8: TQRLabel;
    QRGroup2: TQRGroup;
    E_DATA: TQRDBText;
    E_CODCOMPRA: TQRDBText;
    QRDBText3: TQRDBText;
    E_Empresa: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand5: TQRBand;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    Ft_Vendas: TQRBand;
    QRLabel6: TQRLabel;
    Lb_Tl_Dia: TQRLabel;
    QRBand6: TQRBand;
    QRLabel15: TQRLabel;
    Lb_VL_Desconto: TQRLabel;
    QRLabel19: TQRLabel;
    Lb_Tl_Total: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Sbt_Vendas: TQRLabel;
    QRBand7: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Compras: TSTQuery;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Doc: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    Lb_Fornecedor: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Ft_VendasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_VL_Desconto, IT_Vl_Venda, It_Vl_Total : Real;

  procedure Pc_Busca;
  procedure Pc_Parametros;
  end;

var
  RL_ComprasDetalhada: TRL_ComprasDetalhada;

implementation

uses     UN_Imp_Compras, UN_DM, DBCtrls, UN_Sistema, ComCtrls, Un_Principal, env;
{$R *.dfm}



procedure TRL_ComprasDetalhada.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  Lc_Cliente:Boolean;
begin
  with Fr_Imp_Compras do
    Begin
    Screen.Cursor:=crHourGlass;
    IF ChBx_Nome.Checked then E_Empresa.DataField := 'EMP_NOME';
    IF ChBx_Fantasia.Checked then E_Empresa.DataField := 'EMP_FANTASIA';
    It_VL_Desconto := 0;
    IT_Vl_Venda := 0;
    It_Vl_Total := 0;
    Qr_Compras.Close;
    Qr_Compras.SQL.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT '+
              '    NFL_CODIGO, '+
              '    NFL_DT_EMISSAO, '+
              '    PED_NUMERO, '+
              '    PED_VL_DESCONTO, '+
              '    NFL_NUMERO, '+
              '    EMP_NOME, '+
              '    EMP_FANTASIA, '+
              '    NFL_VL_TL_NOTA, '+
              '    PRO_CODIGOFAB, '+
              '    PRO_DESCRICAO, '+
              '    ITF_CODIGO, '+
              '    ITF_CODNFL, '+
              '    ITF_CODPRO, '+
              '    MED_ABREVIATURA, '+
              '    ITF_QTDE, '+
              '    ITF_VL_UNIT, '+
              '    ITF_AQ_COM, '+
              '    NFL_CODMHA,  '+
              '    (tb_itens_nfl.ITF_QTDE)*(tb_itens_nfl.ITF_VL_UNIT) as ITF_Subtotal   '+
              'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
              '    INNER JOIN TB_EMPRESA tb_empresa  '+
              '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
              '    LEFT OUTER JOIN TB_PEDIDO tb_pedido  '+
              '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
              '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
              '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
              '    LEFT JOIN TB_ESTOQUE Tb_estoque '+
              '    ON  (Tb_estoque.EST_CODIGO = Tb_itens_nfl.ITF_CODPRO) '+
              '    INNER JOIN TB_PRODUTO Tb_produto '+
              '    ON  (Tb_produto.PRO_CODIGO = TB_ITENS_NFL.ITF_CODPRO) '+
              '    INNER JOIN TB_MEDIDA tb_medida  '+
              '    ON (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
              'WHERE (ITF_CODIGO IS NOT NULL)  AND (NFL_TIPO = ''EE'') ';

    if (not Grb_MnhaEmpresa.Visible) or (not chbx_Empresas.Checked) then
      Begin
      Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
      end;
                    
    if DBLCB_Empresa.Text ='' then Lc_Cliente := False else Lc_Cliente := True;


    if Lc_Cliente then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';

    if ChBx_Periodo.Checked then  Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
    if RG_Tipo.ItemIndex =0 then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO IS NULL) ';
    if RG_Tipo.ItemIndex =1 then Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO IS NOT NULL) ';

    IF ChBx_Nome.Checked then
      Qr_Compras.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_NOME ')
    ELSE
      Qr_Compras.SQL.Add(Lc_SqlTxt+'ORDER BY  NFL_DT_EMISSAO,NFL_NUMERO, EMP_FANTASIA ');

    if Lc_Cliente then Qr_Compras.ParamByName('NFL_CODEMP').AsInteger:=DBLCB_Empresa.KeyValue;
    if ChBx_Periodo.Checked then
      begin
      Qr_Compras.ParamByName('DATAINI').AsDate:=(E_Data_INI.Date);
      Qr_Compras.ParamByName('DATAFIM').AsDate:=(E_Data_FIM.Date);
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

procedure TRL_ComprasDetalhada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_ComprasDetalhada:=nil;
end;

procedure TRL_ComprasDetalhada.FormCreate(Sender: TObject);
begin
  with Fr_Imp_Compras do
    Begin
    IF ChBx_Nome.Checked then e_Empresa.DataField := ('EMP_NOME');
    if ChBx_Fantasia.Checked then e_Empresa.DataField := ('EMP_FANTASIA');
    end;
end;

procedure TRL_ComprasDetalhada.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    IT_Vl_Venda := IT_Vl_Venda + Qr_Compras.FieldByname('NFL_VL_TL_NOTA').AsCurrency;
    It_VL_Desconto := It_VL_Desconto + Qr_Compras.FieldByname('PED_VL_DESCONTO').AsCurrency;
end;

procedure TRL_ComprasDetalhada.Ft_VendasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Tl_Dia.Caption := FloatToStrF(IT_Vl_Venda,ffNumber,18,2);
  It_Vl_Total := It_Vl_Total + IT_Vl_Venda;
  IT_Vl_Venda := 0;

end;

procedure TRL_ComprasDetalhada.QRBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Sbt_Vendas.Caption:=FloatToStrF(It_Vl_Total,ffNumber,18,2);
  Lb_VL_Desconto.Caption:=FloatToStrF(It_VL_Desconto,ffNumber,18,2);
  Lb_Tl_Total.Caption:=FloatToStrF(It_Vl_Total - It_VL_Desconto,ffNumber,18,2);
end;

procedure TRL_ComprasDetalhada.QrptBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
  Pc_Parametros;
end;

procedure TRL_ComprasDetalhada.Pc_Parametros;
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
    // Verifica se o tipo do relatorio
    case Cb_Tipo.ItemIndex of
      0 : Lb_Tipo_Rl.Caption := 'Normal';
      1 : Lb_Tipo_Rl.caption := 'Detalhado';
    end;
  end;
end;


end.
