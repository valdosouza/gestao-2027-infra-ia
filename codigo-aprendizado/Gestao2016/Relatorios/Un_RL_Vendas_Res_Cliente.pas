unit Un_RL_Vendas_Res_Cliente;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, STQuery;

type
  TRL_Vendas_Res_Cliente = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    DetalheVenda: TQRBand;
    QRBand4: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel18: TQRLabel;
    QRLabel7: TQRLabel;
    Qr_Vendas: TSTQuery;
    QRLabel8: TQRLabel;
    Grp_Data: TQRGroup;
    QRDBText6: TQRDBText;
    QRLabel1: TQRLabel;
    Qr_Itens: TSTQuery;
    E_Vl_Venda: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel11: TQRLabel;
    Lb_Nome_Emp: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel20: TQRLabel;
    Lb_Data_Ini: TQRLabel;
    Lb_Data_Fim: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Transportadora: TQRLabel;
    Lb_Tipo: TQRLabel;
    Lb_Vendedor: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_Tipo_Rl: TQRLabel;
    QRLabel19: TQRLabel;
    E_VL_TL_Total: TQRLabel;
    QRLabel16: TQRLabel;
    Qr_VendasEMP_NOME: TStringField;
    Qr_VendasTOTAL: TBCDField;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Qr_VendasAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    It_Vl_Venda, It_Vl_Custo,  It_Vl_Tl_Custo : Real;
  public
    { Public declarations }
    It_Mostra_Custo : Boolean;
    It_Cd_Estabelecimento:Integer;
    It_Cd_Pedido : Integer;
    It_PedidoAberto : boolean;
    It_PedidoFechado : boolean;
    It_NotaFiscal : boolean;
    It_PedidoNota : boolean;
    It_Periodo : Boolean;
    It_Dt_Inicio : TDate;
    It_Dt_Fim : TDate;
    It_Cd_Cliente : Integer;
    It_Nm_Cliente : String;
    It_Cd_Transportadora : Integer;
    it_Cd_VendedorCliente : Integer;
    it_Cd_VendedorPedido : Integer;
    It_End_Regiao :String;
    It_OrdenaNome : String;
    procedure Pc_Busca;
    procedure Pc_Parametros;
  end;

var
  RL_Vendas_Res_Cliente: TRL_Vendas_Res_Cliente;

implementation

uses      Un_DM, UN_Sistema, ComCtrls, StdCtrls, Un_Regra_Negocio, RN_Transportadora;
{$R *.dfm}



procedure TRL_Vendas_Res_Cliente.Pc_Busca;
VaR
  Lc_SqlTxt:String;
  Lc_Aux : String;
  LC_REGIAO,Lc_Cliente, Lc_Vendedor, Lc_transportadora:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  It_Vl_Venda := 0;
  IT_Vl_Custo := 0;
  It_Vl_Tl_Custo := 0;
  Qr_Vendas.Close;
  Qr_Vendas.SQL.Clear;

  Lc_SqlTxt :=  'SELECT DISTINCT tb_empresa.EMP_NOME, CAST(SUM(NFL_VL_TL_NOTA) AS NUMERIC(18, 2)) TOTAL '+
                'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                '    INNER JOIN TB_EMPRESA tb_empresa '+
                '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                '    INNER JOIN TB_PEDIDO tb_pedido '+
                '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                '    LEFT OUTER JOIN TB_EMPRESA tb_transportadora '+
                '    ON (tb_transportadora.EMP_CODIGO = tb_nota_fiscal.NFL_CODTRP) '+
                '    INNER JOIN tb_endereco tb_endereco '+
                '    ON (tb_endereco.end_codigo = tb_pedido.ped_codend) '+
                '    LEFT JOIN TB_CONSERTO TB_CONSERTO '+
                '    ON (TB_CONSERTO.CST_CODPED =tb_pedido.ped_codigo) '+
                'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') AND (PED_TIPO = 1) AND (NFL_STATUS = ''F'')    '+
                ' AND CST_CODIGO IS NULL  ';

  if (It_Cd_Estabelecimento > 0) then
    Begin
    Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
    end;
    //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
    Lc_Aux := Trim(Fc_codigosNegocio);
    If Length(Lc_Aux) > 0 then
      Lc_SqlTxt := Lc_SqlTxt + 'AND ((PED_CODNEG NOT IN (' + Lc_Aux + ')) or (PED_CODNEG IS NULL))';

  if It_Periodo then
    Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';

  if (Trim(It_End_Regiao) <> '') then Lc_SqlTxt := Lc_SqlTxt +'AND (END_REGIAO LIKE :END_REGIAO)';
  if It_Cd_Cliente >0 then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';

  if it_Cd_VendedorCliente > 0 then
    Lc_SqlTxt := Lc_SqlTxt +'AND (tb_empresa.EMP_CODVDOR =:EMP_CODVDOR) ';

  if (it_Cd_Vendedorpedido > 0) then
    Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) ';

  if (It_Cd_Transportadora > 0) then Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODTRP =:NFL_CODTRP) ';

  if It_PedidoFechado then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO ='''') or (NFL_NUMERO is null) )';
  if It_NotaFiscal then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (NFL_NUMERO <>'''') or (NFL_NUMERO is not null) )';

    Qr_Vendas.SQL.Add(Lc_SqlTxt +
                      ' GROUP BY 1 '+ 
                      ' ORDER BY 1 ');

  if (It_Cd_Cliente >0) then Qr_Vendas.ParamByName('NFL_CODEMP').AsInteger:= It_Cd_Cliente;
  if it_Cd_VendedorCliente>0 then Qr_Vendas.ParamByName('EMP_CODVDOR').AsInteger:= it_Cd_VendedorCliente;
  if it_Cd_VendedorPedido>0 then Qr_Vendas.ParamByName('PED_CODVDO').AsInteger:= it_Cd_VendedorPedido;
  if It_Cd_Transportadora >0 then Qr_Vendas.ParamByName('NFL_CODTRP').AsInteger := It_Cd_Transportadora;
  if (Trim(It_End_Regiao)<>'') then Qr_Vendas.ParamByName('END_REGIAO').AsString:= '%' + It_End_Regiao + '%';

  if It_Periodo then
    begin
    Qr_Vendas.ParamByName('DATAINI').AsDate := It_Dt_Inicio;
    Qr_Vendas.ParamByName('DATAFIM').AsDate := It_Dt_Fim;
    end;

  if (It_Cd_Estabelecimento >0) then Qr_Vendas.ParamByName('NFL_CODMHA').AsInteger := It_Cd_Estabelecimento;
  Qr_Vendas.Active := True;
  Qr_Vendas.FetchAll;
  Qr_Vendas.RecordCount;
  Screen.Cursor:=crDefault;
end;

procedure TRL_Vendas_Res_Cliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action:=caFree;
  RL_Vendas_Res_Cliente:=nil;
end;

procedure TRL_Vendas_Res_Cliente.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Vl_TL_Total.Caption     := FloatToStrF(It_Vl_Venda,ffNumber,18,2);
  Pc_Parametros;
end;

procedure TRL_Vendas_Res_Cliente.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Vl_Venda.Caption := FloatToStrF(Qr_Vendas.FieldByName('TOTAL').AsCurrency,ffNumber,18,2);
  It_Vl_Venda := It_Vl_Venda + Qr_Vendas.FieldByName('TOTAL').AsCurrency;
end;

procedure TRL_Vendas_Res_Cliente.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_AtivaEstabelecimento;
  It_Mostra_Custo := (Fc_Tb_Geral('L','VDA_CUSTO_REL_VDA','S') = 'S');
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_Vendas_Res_Cliente.Qr_VendasAfterOpen(DataSet: TDataSet);
begin
  Qr_Vendas.FetchAll;
  (Qr_Vendas.FieldByName('TOTAL') as TNumericField).DisplayFormat  := '#,##0.00';
end;

procedure TRL_Vendas_Res_Cliente.Pc_Parametros;
begin
  // Verifica qual localização cliente
  IF It_PedidoFechado then
    Lb_Tipo_Rl.Caption := 'Pedidos'
  else
  if It_NotaFiscal then
    Lb_Tipo_Rl.Caption := 'Notas'
  else
    Lb_Tipo_Rl.Caption := 'Todos';

  // Verifica data solicitada
  if It_Periodo then
    Begin
    Lb_Data_Ini.Caption := DateToStr( It_Dt_Inicio);
    Lb_Data_Fim.Caption := DateToStr( It_Dt_Fim);
    end
  else
    Begin
    Lb_Data_Ini.Caption := '';
    Lb_Data_Fim.Caption := '';
    end;
    // Verifica o nome do Cliente
    if It_Cd_Cliente = 0 then
      Lb_Nome_Emp.Caption := 'Todos'
    else
      Lb_Nome_Emp.Caption := 'Específico';
    //Verifica se a transportadora foi prenchida
    if It_Cd_Transportadora = 0 then
      Lb_Transportadora.Caption := 'Todos'
    else
      Lb_Transportadora.Caption := 'Específico';
    // Verificar o nome do Vendedor
    if (it_Cd_VendedorPedido >0) or (it_Cd_VendedorCliente >0) then
      Lb_Vendedor.Caption := 'Todos'
    else
      Lb_Vendedor.Caption := 'Específico';
end;

end.
