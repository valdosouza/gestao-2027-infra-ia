unit Un_AreaTestes;

interface

uses
      Forms, Controls, SysUtils, STQuery, STStoredProc, STDatabase, ExtCtrls, Gauges, StdCtrls, classes, db, Mask, Grids, QRExport, Excel2000, QEdit_Setes, jpeg, ComObj, Windows, Messages, Variants, Graphics, Dialogs, ComCtrls, Buttons, StrUtils, DBCtrls, Menus;
type
  TFr_AreaTestes = class(TForm)
    Panel2: TPanel;
    Label4: TLabel;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    CB_Tipo: TComboBox;
    ChBx_Periodo: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Lb_Progresso: TLabel;
    Gg_Progresso: TGauge;
    DBLCB_Vendedor: TDBLookupComboBox;
    Label1: TLabel;
    ChBx_Formatacao: TCheckBox;
    Cb_Info_Grafico: TComboBox;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    arefas1: TMenuItem;
    Clientes1: TMenuItem;
    procedure Sb_ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CB_TipoChange(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
  private
    { Private declarations }
    It_Excel, It_Sheet : Variant;
    It_Top_Grafico1:Integer;
    It_Top_Grafico2:Integer;
    It_Seq_grafico:Integer;

    It_Coord_Inicial,It_Coord_Final : String;
  public
    { Public declarations }
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImagemBotao;
    procedure Pc_CriaAppExcel(Pc_Ws:String);
    procedure Pc_VendaDiaria(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
    procedure Pc_ResumoVenda(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
    function Fc_BuscaVendaDiaria(Pc_Qry:TSTQuery;fc_Data:String):TSTQuery;

    function Fc_BuscaTotalRecebidoAnterior(Pc_Qry:TSTQuery;Fc_Data:String):Real;
    function Fc_BuscaTotalRecebidoHoje(Pc_Qry:TSTQuery;Fc_Data:String):Real;
    function Fc_BuscaTotalAReceber(Pc_Qry:TSTQuery;Fc_Data:String):Real;
    function Fc_BuscaTotalDiaria(Pc_Qry:TSTQuery;Fc_Data:String):Real;
    function Fc_BuscaTotalVendaMensal(Pc_Qry:TSTQuery;Fc_Data:String):Real;
    function Fc_BuscaTotalServicoMensal(Pc_Qry:TSTQuery;Fc_Data:String):Real;

    function Fc_ValorPedidoDevolvido(Pc_Qry:TSTQuery;Fc_Cd_Pedido_Venda:Integer):real;
    function Fc_BuscaVendaPeriodo():TSTQuery;
    procedure Pc_BuscaProdutoMaiorValor(Pc_Consulta:TSTQuery;Fc_Cd_Pedido:Integer);
    //Recebimento
    function Fc_ListaFormaPagto():TSTQuery;
    procedure Pc_Recebimentos(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
    function Fc_BuscaMovimentoFinanceiro():TSTQuery;
    function Fc_BuscaMovimentoFinanceiroFormaPagto(Fc_Cd_FormaPagamento:Integer;Fc_DiaAtual:Boolean):Real;
    function Fc_FPagtoUtilRecebimento():TSTQuery;
    function Fc_ValorPedidoDevolvidoPeriodo(Pc_Qry:TSTQuery;Fc_Cd_Vendedor:Integer):real;
    //Caixa -Vendas do dia
    //procedure Pc_PreenceCelulaExcel(Pc_Sheet:Variant; Pc_Linha, Pc_ColIni,Pc_ColFim,Pc_ColWith:Integer;Pc_Aling:Integer;Pc_Formato:String; Pc_Valor:Variant);

    function Fc_FPagtoUtilCaixa():TSTQuery;
    function Fc_BuscaMovimentoVenda():TSTQuery;
    function Fc_BuscaMovimentoCaixa(Fc_Cd_NotaFiscal,Fc_FmaPagto:String):Real;
    function Fc_BuscaMovimentoReceber(Fc_Nr_Pedido,Fc_FmaPagto:String):Real;

    //Caixa -Vendas do dia - modelo 2
    procedure Pc_CaixaModelo2(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
    function Fc_FPagtoUtilPedidos():TSTQuery;
    function Fc_BuscaMovimentoReceberModelo2(Pc_Qry:TSTQuery; Fc_Nr_Pedido,Fc_FmaPagto:String):Real;
    function Fc_BuscaMovimentoCaixaModelo2(Lc_Qry:TSTQuery; Fc_Cd_NotaFiscal,Fc_FmaPagto:String):TSTQuery;
    procedure Pc_GeraGraficoVendaOrigemVenda;
    procedure Pc_GraficosOrigem(Pc_Progresso: TGauge; Pc_Acompanhamento: TLabel);


    function Pc_BuscarTotalVda: real;

    procedure Pc_BuscarListaVendedor(Pc_Qry:TSTQuery);

    procedure Pc_BuscarOrigemVenda(Pc_Qry:TSTQuery;Pc_Cd_Vendedor:Integer;Pc_Dt_Inicio,Pc_Dt_Fim:TDateTime);
    procedure Pc_BuscarOrigemCliente(Pc_Qry:TSTQuery;Pc_Cd_Vendedor:Integer;Pc_Dt_Inicio,Pc_Dt_Fim:TDateTime);
    procedure Pc_BuscarOrigemGeral(Pc_Qry:TSTQuery;Pc_Dt_Inicio,Pc_Dt_Fim:TDateTime);
    Function Fc_CriarAreaOrigemVenda(Fc_Qry:TSTQuery;Fc_Sheet:Variant; Fc_Linha:Integer;Fc_Cd_Vendedor:Integer;Fc_Dt_Inicio,Fc_Dt_Fim:TDateTime):Integer;
    Function Fc_CriarAreaOrigemCliente(Fc_Qry:TSTQuery;Fc_Sheet:Variant; Fc_Linha:Integer;Fc_Cd_Vendedor:Integer;Fc_Dt_Inicio,Fc_Dt_Fim:TDateTime):Integer;
    Function Fc_CriarAreaOrigemGeral(Fc_Qry:TSTQuery;Fc_Sheet:Variant; Fc_Linha:Integer;Fc_Dt_Inicio,Fc_Dt_Fim:TDateTime):Integer;
    procedure Pc_CriaGrafico(Pc_Sheet:Variant;Pc_Top,Pc_Left,Pc_Width,Pc_Height,Pc_Seq:Integer;Pc_Titulo,Pc_Inicio,Pc_Fim:String);
    procedure Pc_GraficosOrigem2(Pc_Progresso: TGauge; Pc_Acompanhamento: TLabel);
    //FEchamento Mensal
    function Fc_BuscaVendaFechamento(Pc_Qry:TSTQuery):TSTQuery;

    procedure Pc_FechamentoMensal(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);

    procedure Pc_ResumoVendasRecebimentos(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
    function Fc_BuscaResumoVendasRecebimentos(Pc_Qry:TSTQuery):TSTQuery;
    function Fc_BuscaItensPedido(Pc_Qry:TSTQuery;Pc_Cd_Pedido:Integer):TSTQuery;
    function Fc_BuscaFinanceiroPedido(Pc_Qry:TSTQuery;Pc_Cd_Pedido:Integer):TSTQuery;
  end;

var
  Fr_AreaTestes: TFr_AreaTestes;

implementation

uses     UN_Sistema, Un_Regra_Negocio, Un_DM, UN_Principal, env, Un_Funcoes, Un_Excel, Un_GF_VendasOrigemVenda, UN_MSG, Un_Pesq_Empresa, un_Padrao, UN_TabelasEmListas;
{$R *.dfm}
procedure TFr_AreaTestes.Pc_IniciaVariaveis;
Begin
  DsblControl( ChBx_Periodo);
  DsblControl( DBLCB_Vendedor);
  DsblControl( Cb_Info_Grafico);
  Cb_Tipo.ItemIndex:=0;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  DM_ListaConsultas.Pc_ListaVendedor;
end;


procedure TFr_AreaTestes.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph.Assign(Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_AreaTestes.Sb_ExportarClick(Sender: TObject);
begin
  Pc_ProcesoAguarde(Self,'I');
  Self.Enabled := False;
  try
    case CB_Tipo.ItemIndex of
      0:Pc_VendaDiaria(Gg_Progresso,Lb_Progresso);
      1:Pc_ResumoVenda(Gg_Progresso,Lb_Progresso);
      2:Pc_Recebimentos(Gg_Progresso,Lb_Progresso);
      3:Pc_CaixaModelo2(Gg_Progresso,Lb_Progresso);
      4:Pc_GraficosOrigem2(Gg_Progresso,Lb_Progresso);
      5:Pc_FechamentoMensal(Gg_Progresso,Lb_Progresso);
      6:Pc_ResumoVendasRecebimentos(Gg_Progresso,Lb_Progresso);
      end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

function TFr_AreaTestes.Fc_BuscaVendaDiaria(Pc_Qry:TSTQuery;Fc_Data:String):TSTQuery;
begin
  with Pc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select PED_CODIGO,PED_CODVDO,NFL_VL_TL_NOTA,CLB_NOME, EMP_NOME '+
            'from tb_pedido '+
            '  inner join tb_nota_fiscal '+
            '  on (NFL_CODPED = PED_CODIGO) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            'where (NFL_DT_EMISSAO =:DATAINI) and (PED_TIPO = 1) and (PED_FATURADO= ''S'') AND (NFL_STATUS = ''F'') '+
            //' and (ped_codvdo = 173)'+
            'order by CLB_NOME');
    ParamByName('DATAINI').AsString := Fc_Data;
    Active := True;
    end;
  result := Pc_Qry;
end;

function TFr_AreaTestes.Fc_BuscaTotalRecebidoAnterior(Pc_Qry:TSTQuery;Fc_Data:String):Real;
begin
  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT SUM(FIN_VL_PAGO) TOTAL '+
            'FROM TB_FINANCEIRO '+
            'WHERE TB_FINANCEIRO.FIN_DATA <:DATA AND TB_FINANCEIRO.FIN_DT_PAGTO =:DATA AND ((FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM''))');
    ParamByName('DATA').AsString := Fc_Data;
    Active := True;
    result := FieldByName('TOTAL').AsCurrency;
  end;
end;

function TFr_AreaTestes.Fc_BuscaTotalRecebidoHoje(Pc_Qry:TSTQuery;Fc_Data:String):Real;
begin
  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT SUM(FIN_VL_PAGO) TOTAL '+
            'FROM TB_FINANCEIRO '+
            'WHERE TB_FINANCEIRO.FIN_DATA =:DATA AND TB_FINANCEIRO.FIN_DT_PAGTO =:DATA');
    ParamByName('DATA').AsString := Fc_Data;
    Active := True;
    result := FieldByName('TOTAL').AsCurrency;
  end;
end;


function TFr_AreaTestes.Fc_BuscaTotalAReceber(Pc_Qry:TSTQuery;Fc_Data:String):Real;
begin
  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT SUM(FIN_VL_PARCELA) TOTAL '+
            'FROM TB_FINANCEIRO '+
            'WHERE TB_FINANCEIRO.FIN_DATA =:DATA AND FIN_BAIXA = ''N'' '+
            'and ( (fin_tipo = ''RA'') or (fin_tipo = ''RM'') )');

    ParamByName('DATA').AsString := Fc_Data;
    Active := True;
    result := FieldByName('TOTAL').AsCurrency;
  end;
end;

function TFr_AreaTestes.Fc_BuscaTotalDiaria(Pc_Qry:TSTQuery;Fc_Data:String):Real;
begin
  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select SUM(NFL_VL_TL_NOTA) TOTAL '+
            'from tb_pedido '+
            '  inner join tb_nota_fiscal '+
            '  on (NFL_CODPED = PED_CODIGO) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            'where (NFL_DT_EMISSAO =:DATAINI) and (PED_TIPO = 1) and (PED_FATURADO= ''S'') AND (NFL_STATUS = ''F'') ');
    ParamByName('DATAINI').AsString := Fc_Data;
    Active := True;
    result := FieldByName('TOTAL').AsCurrency;
  end;
end;

function TFr_AreaTestes.Fc_BuscaTotalVendaMensal(Pc_Qry:TSTQuery;Fc_Data:String):Real;
Var
  Lc_Dia,Lc_Mes,Lc_Ano:String;
  Lc_Dt_Inicio, Lc_Dt_Fim : String;
begin
  Lc_Dia := Copy(Fc_Data,1,2);
  Lc_Mes := Copy(Fc_Data,4,2);
  Lc_Ano := Copy(Fc_Data,7,4);
  Lc_Dt_Inicio := '01/' + Lc_Mes + '/' + Lc_Ano;
  Lc_Dt_Fim := Fc_Ult_Dia_Mes(E_Data_Ini.Date) + '/' + Lc_Mes + '/' + Lc_Ano;

  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select SUM(NFL_VL_TL_NOTA - NFL_VL_TL_SRV) TOTAL '+
            'from tb_pedido '+
            '  inner join tb_nota_fiscal '+
            '  on (NFL_CODPED = PED_CODIGO) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            'where (NFL_DT_EMISSAO  BETWEEN :DATAINI AND :DATAFIM) and (PED_TIPO = 1) and (PED_FATURADO= ''S'') AND (NFL_STATUS = ''F'') ');
    ParamByName('DATAINI').AsString := Lc_Dt_Inicio;
    ParamByName('DATAFIM').AsString := Lc_Dt_Fim;
    Active := True;
    result := FieldByName('TOTAL').AsCurrency;
  end;
end;

function TFr_AreaTestes.Fc_BuscaTotalServicoMensal(Pc_Qry:TSTQuery;Fc_Data:String):Real;
Var
  Lc_Dia,Lc_Mes,Lc_Ano:String;
  Lc_Dt_Inicio, Lc_Dt_Fim : String;
begin
  Lc_Dia := Copy(Fc_Data,1,2);
  Lc_Mes := Copy(Fc_Data,4,2);
  Lc_Ano := Copy(Fc_Data,7,4);
  Lc_Dt_Inicio := '01/' + Lc_Mes + '/' + Lc_Ano;
  Lc_Dt_Fim := Fc_Ult_Dia_Mes(E_Data_Ini.Date)+ '/' + Lc_Mes + '/' + Lc_Ano;

  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select SUM(NFL_VL_TL_SRV) TOTAL '+
            'from tb_pedido '+
            '  inner join tb_nota_fiscal '+
            '  on (NFL_CODPED = PED_CODIGO) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            'where (NFL_DT_EMISSAO  BETWEEN :DATAINI AND :DATAFIM) and (PED_TIPO = 1) and (PED_FATURADO= ''S'') AND (NFL_STATUS = ''F'') ');
    ParamByName('DATAINI').AsString := Lc_Dt_Inicio;
    ParamByName('DATAFIM').AsString := Lc_Dt_Fim;
    Active := True;
    result := FieldByName('TOTAL').AsCurrency;
  end;
end;

function TFr_AreaTestes.Fc_ValorPedidoDevolvidoPeriodo(Pc_Qry:TSTQuery;Fc_Cd_Vendedor:Integer):real;
Var
  Lc_Cd_Quitacao: String;
begin
  result := 0;
  with Pc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    active := False;
    sql.Clear;
    //PEga o codigo de quitação
    sql.Add('SELECT distinct FIN_CODQTC '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN tb_pedido '+
            '  ON (PED_CODIGO = FIN_CODPED) '+
            '  inner join tb_nota_fiscal '+
            '  on (NFL_CODPED = PED_CODIGO) '+
            'WHERE PED_CODVDO=:PED_CODVDO AND PED_TIPO = 1 AND FIN_CODQTC > 0 '+
            'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) and (PED_TIPO = 1) and (PED_FATURADO= ''S'') AND (NFL_STATUS = ''F'')');
    ParamByName('PED_CODVDO').AsInteger := Fc_Cd_Vendedor;
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;    
    Active := True;
    FetchAll;
    first;
    Lc_Cd_Quitacao := '';
    if (recordcount > 0) then
      Begin
      while not eof do
        Begin
        if (bof) then
          Lc_Cd_Quitacao := FieldByName('FIN_CODQTC').AsString
        else
          Lc_Cd_Quitacao := Lc_Cd_Quitacao + ',' + FieldByName('FIN_CODQTC').AsString;
        Application.ProcessMessages;
        next;
        end;
      end;
    //Verifica se houve credito
    if (Trim(Lc_Cd_Quitacao) <> '') then
      Begin
      active := False;
      sql.Clear;
      //Selecionar o valor de credito uasado para debitar da venda
      sql.Add('SELECT sum(FIN_VL_Pago) valor '+
              'FROM TB_FINANCEIRO '+
              'WHERE ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'') ) '+
              ' AND FIN_OPERACAO = ''D'' AND FIN_BAIXA = ''S'' '+
              ' AND FIN_CODQTC IN (' + Lc_Cd_Quitacao + ')');
      Active := True;
      FetchAll;
      if (recordcount > 0) then
        Result := FieldByName('valor').AsCurrency;
      Application.ProcessMessages;
      end;
    end;
end;

function TFr_AreaTestes.Fc_BuscaVendaPeriodo():TSTQuery;
begin
  Result := TSTQuery.Create(Fr_AreaTestes);
  with Result do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select PED_CODVDO,CLB_NOME, sum(NFL_VL_TL_NOTA) VALOR '+
            'from tb_pedido '+
            '  inner join tb_nota_fiscal '+
            '  on (NFL_CODPED = PED_CODIGO) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            'where (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) and (PED_TIPO = 1) and (PED_FATURADO= ''S'') AND (NFL_STATUS = ''F'') '+
            'GROUP BY 1,2 '+
            'order by CLB_NOME');
    ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
    Active := True;
    FetchAll;
    first;
    end;
end;

function TFr_AreaTestes.Fc_ValorPedidoDevolvido(Pc_Qry:TSTQuery;Fc_Cd_Pedido_Venda:Integer):real;
Var
  Lc_Cd_Quitacao: String;
begin
  result := 0;
  with Pc_Qry do
  Begin
    Database := Dm.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := TRue;
    active := False;
    sql.Clear;
    //PEga o codigo de quitação
    sql.Add('SELECT FIN_CODQTC '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN tb_pedido '+
            '  ON (PED_CODIGO = FIN_CODPED) '+
            'WHERE FIN_CODPED=:PED_CODIGO AND PED_TIPO = 1 AND FIN_CODQTC > 0 ');
    ParamByName('PED_CODIGO').AsInteger := Fc_Cd_Pedido_Venda;
    Active := True;
    FetchAll;
    first;
    Lc_Cd_Quitacao := '';
    if (recordcount > 0) then
    Begin
      while not eof do
      Begin
        if (bof) then
          Lc_Cd_Quitacao := FieldByName('FIN_CODQTC').AsString
        else
          Lc_Cd_Quitacao := Lc_Cd_Quitacao + ',' + FieldByName('FIN_CODQTC').AsString;
        next;
      end;
    end;
    //Verifica se houve credito
    if (Trim(Lc_Cd_Quitacao) <> '') then
    Begin
      active := False;
      sql.Clear;
      //Selecionar o valor de credito uasado para debitar da venda
      sql.Add('SELECT sum(FIN_VL_Pago) valor '+
              'FROM TB_FINANCEIRO '+
              'WHERE ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'') ) '+
              ' AND FIN_OPERACAO = ''D'' AND FIN_BAIXA = ''S'' '+
              ' AND FIN_CODQTC IN (' + Lc_Cd_Quitacao + ')');
      Active := True;
      FetchAll;
      if (recordcount > 0) then
        Result := FieldByName('valor').AsCurrency
    end;
  end;
end;

procedure TFr_AreaTestes.Pc_BuscaProdutoMaiorValor(Pc_Consulta:TSTQuery;Fc_Cd_Pedido:Integer);
begin
  with Pc_Consulta do
    Begin
    Active := False;
    sql.Clear;
    sql.Add('select FIRST 1 PRO_dESCRICAO, MAX(ITF_VL_UNIT * ITF_QTDE) VALOR '+
            'from tb_nota_fiscal '+
            '  INNER JOIN TB_ITENS_NFL '+
            '  ON (ITF_CODNFL = NFL_CODIGO) '+
            '  INNER JOIN TB_PRODUTO '+
            '  ON (PRO_CODIGO = ITF_CODPRO) '+
            'where NFL_CODPED =:PED_CODIGO '+
            'GROUP BY 1 '+
            'ORDER BY 2 DESC');
    ParamByName('PED_CODIGO').AsInteger := Fc_cd_pedido;
    Active := True;
  end;
end;

procedure TFr_AreaTestes.Pc_CriaAppExcel(Pc_Ws:String);
Begin
  //cria a aplicação
  It_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  It_Excel.WorkBooks.Add;
  //planilha recebendo variável nome
  It_Excel.WorkSheets[1].Name := Pc_Ws;
  //Repassando variável
  It_Sheet := It_Excel.WorkSheets[Pc_Ws];
  //Configura as Margens
  It_Sheet.PageSetup.LeftMargin := It_Excel.InchesToPoints(0.236220472440945);
  It_Sheet.PageSetup.RightMargin := It_Excel.InchesToPoints(0.118110236220472);
  It_Sheet.PageSetup.TopMargin := It_Excel.InchesToPoints(0.393700787401575);
  It_Sheet.PageSetup.BottomMargin := It_Excel.InchesToPoints(0.393700787401575);
  It_Sheet.PageSetup.HeaderMargin := It_Excel.InchesToPoints(0.393700787401575);
  It_Sheet.PageSetup.FooterMargin := It_Excel.InchesToPoints(0.393700787401575);
end;

procedure TFr_AreaTestes.Pc_VendaDiaria(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Cont_Ini : Integer;
  Lc_Cont_Fim : Integer;
  Lc_Texto : String;
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  Lc_Produto : TSTQuery;
  Lc_Vendedor : Integer;
  Lc_Contador : Integer;
  Lc_VL_Venda : Real;
  Lc_Vl_Total : Real;
  Lc_Cd_ItemPedidoDevolvido : Integer;
LAbel Volta;
begin
  //Consulta das Vendas diárias
  Lc_Qry := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Aux := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry := Fc_BuscaVendaDiaria(Lc_Qry,DateToStr(E_Data_Ini.Date));
  Lc_Qry.FetchAll;
  if (Lc_Qry.RecordCount > 0) then
  Begin
    Lc_Vl_Total := 0;
    //Propduto como maior valor vendido
    Application.ProcessMessages;
    Lc_Produto := TSTQuery.create(Fr_AreaTestes);
    Lc_Produto.Database := DM.IBD_Gestao;
    Lc_Produto.Transaction := Dm.IB_Transacao;
    Lc_Produto.ForcedRefresh := True;

    //Controla o acompanhamento
    Pc_Progresso.Progress := 0;
    Pc_Progresso.MinValue := 1;
    Pc_Progresso.MaxValue := 2 + Lc_Qry.RecordCount;
    Pc_Progresso.Visible := True;
    Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
    Pc_Acompanhamento.Visible := True;
    Application.ProcessMessages;


    //cria a aplicação
    Lc_Excel := CreateOleObject('Excel.Application');
    //adiciona pasta de trabalho
    Lc_Excel.WorkBooks.Add;
    //planilha recebendo variável nome
    Lc_Excel.WorkSheets[1].Name := 'Periodo';
    //Repassando variável
    Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
    //Configura as Margens
    Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
    Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
    Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);


    Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho.';
    Pc_Progresso.Progress := 1;
    Application.ProcessMessages;
    //Cabeçalho 1º Linha
    Lc_Sheet.Range['A1', 'E1'].Select;
    Lc_Sheet.Range['A1', 'E1'].Activate;
    //Lc_Sheet.Range['A1', 'E1'].Cells.ColumnWidth := 14.14;
    Lc_Sheet.Range['A1', 'E1'].Cells.RowHeight := 15;
    Lc_Sheet.Range['A1', 'E1'].Cells.WrapText := True;
    Lc_Sheet.Range['A1', 'E1'].Cells.VerticalAlignment := integer(xlTop);
    Lc_Sheet.Range['A1', 'E1'].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range['A1', 'E1'].Merge(xlAutomatic);
    Lc_Sheet.Range['A1', 'E1'].Orientation := 0;
    Lc_Sheet.Range['A1', 'E1'].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range['A1', 'A1'].Value := 'RELATÓRIO DE VENDAS DIÁRIAS';
    //data da Venda
    Lc_Sheet.Range['F1', 'F1'].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range['F1', 'F1'].Value2 := DateToStr(E_Data_Ini.Date);
    Lc_Linha := 2;
    with Lc_Qry do
    Begin
      Pc_Acompanhamento.Caption := 'Calculando movimento do Vendedor.';
      Pc_Progresso.Progress := 2;
      Application.ProcessMessages;
      Volta:
      Lc_VL_Venda := 0;
      Lc_Contador := 0;
      //Linha Nova
      inc(Lc_Linha);
      Lc_StrCell1 := 'A' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'VENDEDOR:';

      //Coluna Nova
      Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlLeft);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := FieldByname('CLB_NOME').AsString;

      // Linha Nova
      inc(Lc_Linha);
      Lc_StrCell1 := 'A' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'VALOR VENDA';

      // COLUNA NOVA
      Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlLeft);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'CLIENTE';

      // COLUNA NOVA
      Lc_StrCell1 := 'D' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'E' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlLeft);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'PRODUTOS';

      // COLUNA NOVA
      Lc_StrCell1 := 'F' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlLeft);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'VALOR ITEM';  //fecha a consulta

      Lc_Vendedor := FieldByName('PED_CODVDO').AsInteger;
      Application.ProcessMessages;
      while not eof do
      Begin
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Application.ProcessMessages;
        if (Lc_Vendedor = FieldByName('PED_CODVDO').AsInteger) then
        Begin
          inc(Lc_Linha);
          inc(Lc_Contador);
          // Valor do PEdido
          Lc_StrCell1 := 'A' + IntToStr(lc_Linha);
          Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].NumberFormat := '#.##0,00';
          Lc_Texto := FieldByName('EMP_NOME').AsString;

          Lc_VL_Venda := FieldByName('NFL_VL_TL_NOTA').AsCurrency;
          Lc_VL_Venda := Lc_VL_Venda - Fc_ValorPedidoDevolvido(Lc_Qry_Aux,FieldByName('PED_CODIGO').Asinteger);
          IF (Lc_VL_Venda < 0 ) then Lc_VL_Venda := 0;
          Lc_Vl_Total := Lc_Vl_Total + Lc_VL_Venda;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_VL_Venda;

          // Nome do Cliente
          Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
          Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlLeft);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := FieldByName('EMP_NOME').AsString;

          //Chama a pesquisa do produto com maior valor
          Pc_BuscaProdutoMaiorValor(Lc_Produto,FieldByName('PED_CODIGO').Asinteger);

          // Descricao do Produto
          Lc_StrCell1 := 'D' + IntToStr(lc_Linha);
          Lc_StrCell2 := 'E' + IntToStr(lc_Linha);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlLeft);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_Produto.FieldByName('PRO_DESCRICAO').AsString;

          // valor do Item
          Lc_StrCell1 := 'F' + IntToStr(lc_Linha);
          Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].NumberFormat := '#.##0,00';
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_Produto.FieldByName('VALOR').AsCurrency;
          next;
        end
        else
        begin
          prior;
          inc(Lc_Linha);
          // Preenche Rodape do Vendedor
          Lc_StrCell1 := 'A' + IntToStr(lc_Linha);
          Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)';

          // Cabeçalho 3º Linha
          Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
          Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
          Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'SUBTOTAL - ' + FieldByname('CLB_NOME').AsString ;
          next;
          inc(Lc_Linha);
          goto Volta;
        end;
      end;
      inc(Lc_Linha);
      // Preenche Rodape do Vendedor
      Lc_StrCell1 := 'A' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)';
      // Cabeçalho 3º Linha
      Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.RowHeight := 15;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'SUBTOTAL - ' + FieldByname('CLB_NOME').AsString ;
      //totalizador
      inc(Lc_Linha);
      Lc_StrCell1 := 'A' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'D' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Font.Name := 'Calibri';
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Font.Size := 18;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Font.Bold := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'TOTAL GERAL DE VENDAS DO DIA';
      // Cabeçalho 3º Linha
      Lc_StrCell1 := 'E' + IntToStr(lc_Linha);
      Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.ColumnWidth := 14.14;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Font.Name := 'Calibri';
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Font.Size := 18;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Font.Bold := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].NumberFormat := '#.##0,00';
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_Vl_Total; ;
    end;
    Pc_Acompanhamento.Caption := 'Processo Finalizado';
    Pc_Progresso.Progress := Pc_Progresso.MaxValue;
    Application.ProcessMessages;
    //Abre o excel
    Lc_Excel.Visible := true;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Application.ProcessMessages;
end;

procedure TFr_AreaTestes.Pc_ResumoVenda(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet, Chart : Variant;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  Lc_VL_Venda : Real;
  Lc_Vl_Devolvido : Real;
  Lc_Vl_Total : Real;
  Lc_Nr_Mes : Integer;
  Lc_Contador : Integer;
begin
  //Consulta das Vendas diárias
  Lc_Qry_Aux := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Aux.Database := DM.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux.ForcedRefresh := True;

  //Consulta das Vendas diárias
  Lc_Qry := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry := Fc_BuscaVendaPeriodo;
  Lc_Qry.FetchAll;
  if (Lc_Qry.RecordCount > 0) then
    Begin
    Lc_Vl_Total := 0;
    //Controla o acompanhamento
    Pc_Progresso.Progress := 0;
    Pc_Progresso.MinValue := 1;
    Pc_Progresso.MaxValue := 2 + Lc_Qry.RecordCount;
    Pc_Progresso.Visible := True;
    Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
    Pc_Acompanhamento.Visible := True;
    Application.ProcessMessages;


    //cria a aplicação
    Lc_Excel := CreateOleObject('Excel.Application');
    //adiciona pasta de trabalho
    Lc_Excel.WorkBooks.Add;
    //planilha recebendo variável nome
    Lc_Excel.WorkSheets[1].Name := 'Periodo';
    //Repassando variável
    Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
    //Configura as Margens
    Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
    Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
    Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

    Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho.';
    Pc_Progresso.Progress := 1;
    Application.ProcessMessages;
    //Cabeçalho 1º Linha
    Lc_Linha := 1;
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked, Lc_Sheet, Lc_Linha, 1,2,80, 2,'','RESUMO SEMANA - ' + Fc_DesMes(Lc_Nr_Mes,True) + ' de ' + Copy(DateToStr(E_Data_Ini.Date),1,5) + ' - ' + Copy(DateToStr(E_Data_Fim.Date),1,5));
    Lc_Linha := 2;
    with Lc_Qry do
      Begin
      Pc_Acompanhamento.Caption := 'Calculando movimento do Vendedor.';
      Pc_Progresso.Progress := 2;
      Application.ProcessMessages;
      Lc_VL_Venda := 0;
      //Nome do Vendedor
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,60, 1,'','NOME DO VENDEDOR:');
      //Valor da Venda
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 2,3,20, 1,'','VALOR DA VENDA');
      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Contador);
        Lc_VL_Venda := FieldByName('VALOR').AsCurrency;
        Lc_Vl_Devolvido := Fc_ValorPedidoDevolvidoPeriodo(Lc_Qry_Aux,FieldByName('PEd_CODVDO').AsInteger);
        Lc_Vl_Total := Lc_VL_Venda - Lc_Vl_Devolvido;
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Application.ProcessMessages;
        //Nome do Vendedor
        inc(Lc_Linha);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,60, 1,'',FieldByName('CLB_NOME').AsString);
        //Valor da Venda
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00',Lc_Vl_Total);
        next;
      until eof;
      //Label Valor Total
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,60, 1,'','TOTAL');
      //Valor TOTAL da Venda
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)');
      end;
    Pc_Acompanhamento.Caption := 'Processo Finalizado';
    Pc_Progresso.Progress := Pc_Progresso.MaxValue;
    Application.ProcessMessages;
    //Abre o excel
    Lc_Excel.Visible := true;

    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Application.ProcessMessages;
end;

function TFr_AreaTestes.Fc_FPagtoUtilRecebimento():TSTQuery;
Begin
  Result := TSTQuery.Create(Fr_AreaTestes);
  with Result do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT FPT_CODIGO, FPT_DESCRICAO,SUM(FIN_VL_PAGO) VALOR '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN tb_empresa '+
            '  ON (EMP_CODIGO = FIN_CODEMP) '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODIGO= FIN_CODNFL) '+
            '  LEFT OUTER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (tb_formapagto.fpt_codigo = tb_financeiro.fin_codfpg) '+
            'WHERE (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) '+
            'AND  (NFL_DT_EMISSAO < :DATAINI ) '+
            'AND ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'') ) '+
            'AND FIN_BAIXA = ''S'' '+
            'AND FIN_OPERACAO = ''C'' '+
            'GROUP BY 1,2 '+
            'HAVING SUM(FIN_VL_PAGO) >0');
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.Date;
    Active := True;
    end;
end;

function TFr_AreaTestes.Fc_BuscaMovimentoFinanceiro():TSTQuery;
var
  Lc_Contador : Integer;
Begin
  Result := TSTQuery.Create(Fr_AreaTestes);
  with Result do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT NFL_CODEMP, EMP_NOME, PED_NUMERO,FIN_CODFPG,SUM(FIN_VL_PAGO) VALOR '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN tb_empresa '+
            '  ON (EMP_CODIGO = FIN_CODEMP) '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODIGO= FIN_CODNFL) '+
            '  LEFT OUTER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            'WHERE (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) '+
            'AND  (NFL_DT_EMISSAO < :DATAINI ) '+
            'AND ( (FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM'') )'+
            'AND FIN_BAIXA = ''S'' '+
            'AND FIN_OPERACAO = ''C'' '+
            'GROUP BY 1,2,3,4 '+
            'HAVING SUM(FIN_VL_PAGO) >0 '+
            'ORDER BY EMP_NOME ');
    ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
    ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
    Active := True;
    FetchAll;
    Lc_Contador := RecordCount;
    end;
end;

function TFr_AreaTestes.Fc_BuscaMovimentoFinanceiroFormaPagto(Fc_Cd_FormaPagamento:Integer;Fc_DiaAtual:Boolean):Real;
var
  Lc_Contador : Integer;
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Fr_AreaTestes);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT SUM(FIN_VL_PAGO) VALOR '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN tb_empresa '+
            '  ON (EMP_CODIGO = FIN_CODEMP) '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODIGO= FIN_CODNFL) '+
            '  LEFT OUTER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            'WHERE (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) ');
    if not Fc_DiaAtual then
      sql.Add(' AND ( NFL_DT_EMISSAO < :DATAINI ) ');
    sql.Add(' AND ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'') ) '+
            ' AND ( FIN_BAIXA = ''S'' )'+
            ' AND ( FIN_OPERACAO = ''C'' ) '+
            ' AND (FIN_CODFPG =:FPT_CODIGO) '+
            'HAVING SUM(FIN_VL_PAGO) >0 ');
    ParamByName('FPT_CODIGO').AsInteger := Fc_Cd_FormaPagamento;
    ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
    ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
    Active := True;
    FetchAll;
    if (REcordCount>0) then
      Result := FieldByName('VALOR').AsCurrency
    else
      Result := 0;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function TFr_AreaTestes.Fc_ListaFormaPagto():TSTQuery;
Begin
  Result := TSTQuery.Create(Fr_AreaTestes);
  with Result do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT FPT_CODIGO, FPT_DESCRICAO '+
            'FROM tb_formapagto ');
    Active := True;
    end;
end;

procedure TFr_AreaTestes.Pc_Recebimentos(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_Contador : Integer;
  Lc_Nr_FormaPagto:Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Qry_Movimento : TSTQuery;
  Lc_Qry_FormaPagto : TSTQuery;
  Lc_Mtz_FormaPagto : array of array of String;
  Lc_Coluna: Integer;
  Lc_Valor : Real;
  Lc_Nr_Mes : Integer;
begin
  //Verifica as formas de pagamento
  Pc_Acompanhamento.Caption := 'Consultando Formas de pagamento Utilizadas no Período.';
  Pc_Acompanhamento.Visible := True;
  Application.ProcessMessages;  
  Lc_Qry_FormaPagto := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_FormaPagto := Fc_FPagtoUtilRecebimento;
  with Lc_Qry_FormaPagto do
    Begin
    FetchAll;
    First;
    if (RecordCount>0) then
      SetLength(Lc_Mtz_FormaPagto,2,RecordCount)
    else
      SetLength(Lc_Mtz_FormaPagto,2,1);
    Lc_Nr_FormaPagto := 0;
    while not eof do
      Begin
      Lc_Mtz_FormaPagto[0,Lc_Nr_FormaPagto] := FieldByname('FPT_CODIGO').AsString;
      Lc_Mtz_FormaPagto[1,Lc_Nr_FormaPagto] := FieldByname('FPT_DESCRICAO').AsString;
      inc(Lc_Nr_FormaPagto);
      next;
      end;
    end;
  //Consulta Movimento Financeiro
  Pc_Acompanhamento.Caption := 'Consultando Movimento Financeiro do Período.';
  Application.ProcessMessages;
  Lc_Qry_Movimento := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Movimento := Fc_BuscaMovimentoFinanceiro;


  //Controla o acompanhamento
  Pc_Progresso.Progress := 0;
  Pc_Progresso.MinValue := 1;
  Pc_Progresso.MaxValue := 2 + Lc_Qry_Movimento.RecordCount;
  Pc_Progresso.Visible := True;
  Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
  Application.ProcessMessages;

  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;
  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Periodo';
  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
  //Configura as Margens
  Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
  Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
  Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

  Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho';
  Pc_Progresso.Progress := 1;
  Application.ProcessMessages;
  //Cabeçalho 1º Linha
  lc_Linha := 1;
  Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,8,10, 1,'','CAIXA (ENTRADA FINANCEIRA) - USUÁRIO: '+ GB_Nm_Usuario + ' - COBRANÇASÀ RECEBER - DATA: '  + Copy(DateToStr(E_Data_Ini.Date),1,5));

  if (Lc_Qry_Movimento.RecordCount > 0) then
    Begin
    with Lc_Qry_Movimento do
      Begin
      Pc_Acompanhamento.Caption := 'Calculando Movimento Finaceiro.';
      Pc_Progresso.Progress := 2;
      Application.ProcessMessages;
      //Historico
      inc(Lc_Linha);
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,20, 1,'','CLIENTE');
      //Cabecalho forma de pagamento;
      Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho das Formas de Pagto.';
      Application.ProcessMessages;
      For Lc_Coluna := 0 to Lc_Nr_FormaPagto -1 do
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, Lc_Coluna +2,Lc_Coluna +2,13, 1,'',Lc_Mtz_FormaPagto[1,Lc_Coluna]);

      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Linha);
        inc(Lc_Contador);
        //Cliente
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,20, 1,'',Copy(FieldByName('EMP_NOME').AsString, 1, Pred(Pos(' ', FieldByName('EMP_NOME').AsString))) + ' - ' + FieldByName('NFL_CODEMP').AsString);
        //Valores por forma de pagamento
        Pc_Acompanhamento.Caption := 'Escrevendo os valores das Formas de Pagto.';
        Application.ProcessMessages;
        For Lc_Coluna:=0 to Lc_Nr_FormaPagto -1 do
          BEgin
          if (FieldByName('FIN_CODFPG').AsString = Lc_Mtz_FormaPagto[0,Lc_Coluna]) then
            Begin
            Lc_Valor := FieldByName('VALOR').AsCurrency;
            Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, Lc_Coluna +2,Lc_Coluna +2,13, 3,'#.##0,00',Lc_Valor);
            end
          else
            Begin
            Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, Lc_Coluna +2,Lc_Coluna +2,13, 3,'','');
            end;
          Application.ProcessMessages;
          end;
        next;
        Pc_Progresso.Progress := Pc_Progresso.Progress +1;
        Application.ProcessMessages;
      until (eof);
      inc(Lc_Linha);
      //Totalizador das colunas
      For Lc_Coluna := 0 to Lc_Nr_FormaPagto -1 do
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, Lc_Coluna +2,Lc_Coluna +2,13, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)');

      //Soma os totais das Colunas - "=SUM(RC[1]:RC[4])"
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,13, 3,'#.##0,00','=SUM(RC[1]:RC[' + IntToStr(Lc_Nr_FormaPagto)  +'])');
      end;

    //Totalizador geral por forma de pagamento
    //Cabeçalho dos recebimento e total
    inc(Lc_Linha);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 3,4,13, 2,'','TOTAL');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 6,7,13, 2,'','CAIXA');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 9,10,13, 2,'','RECEBIMENTO');
    //Cria a lista de Formas de pagamento
    Lc_Qry_FormaPagto := Fc_ListaFormaPagto();
    Lc_Qry_FormaPagto.First;
    repeat
      inc(Lc_Linha);
      //Forma de Pagamento
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,2,13, 1,'',Lc_Qry_FormaPagto.FieldByName('FPT_DESCRICAO').AsString);
      Application.ProcessMessages;
      //Totalizador do recebimento
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 3,4,13, 3,'#.##0,00','=RC[3]+RC[6]');
      Application.ProcessMessages;
      //Valores recebimentos no caixa
      Lc_Valor := Fc_BuscaMovimentoCaixa('',Lc_Qry_FormaPagto.FieldByName('FPT_DESCRICAO').AsString);
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 6,7,13, 3,'#.##0,00',Lc_Valor);
      Application.ProcessMessages;
      //Recebimento
      Lc_Valor := Fc_BuscaMovimentoFinanceiroFormaPagto(Lc_Qry_FormaPagto.FieldByName('FPT_CODIGO').asInteger,False);
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 9,10,13, 3,'#.##0,00',Lc_Valor);
      Application.ProcessMessages;
      Lc_Qry_FormaPagto.Next;
    until (Lc_Qry_FormaPagto.Eof);
    Pc_Acompanhamento.Caption := 'Processo Finalizado';
    Pc_Progresso.Progress := Pc_Progresso.MaxValue;
    Application.ProcessMessages;
    //Abre o excel
    Lc_Excel.Visible := true;
    end;
  Lc_Qry_FormaPagto.Close;
  FreeAndNil(Lc_Qry_FormaPagto);

  Lc_Qry_Movimento.Close;
  FreeAndNil(Lc_Qry_Movimento);
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Application.ProcessMessages;
end;
//Caixa


function TFr_AreaTestes.Fc_FPagtoUtilPedidos():TSTQuery;
Begin
  Result := TSTQuery.Create(Fr_AreaTestes);
  with Result do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT DISTINCT FPT_CODIGO, FPT_DESCRICAO '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODIGO= FIN_CODNFL) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (tb_formapagto.fpt_codigo = tb_financeiro.fin_codfpg) '+
            'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
            'AND ( FIN_DATA = FIN_DT_PAGTO ) '+
            'AND ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM''))');

    ParamByName('DATAINI').AsDateTime := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.Date;
    Active := True;
    end;
end;



function TFr_AreaTestes.Fc_BuscaMovimentoVenda():TSTQuery;
var
  Lc_Contador : Integer;
Begin
  Result := TSTQuery.Create(Fr_AreaTestes);
  with Result do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT distinct NFL_CODIGO, NFL_NUMERO, PED_NUMERO, EMP_NOME, fpt_descricao '+
            'FROM TB_NOTA_FISCAL '+
            '  INNER JOIN TB_FINANCEIRO '+
            '  ON (NFL_CODIGO = FIN_CODNFL) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (FPT_CODIGO = FIN_CODFPG) '+
            '  LEFT OUTER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
            'AND (PED_TIPO = 1) '+
            'ORDER by PED_NUMERO');
    ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
    ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
    Active := True;
    Application.ProcessMessages;
    FetchAll;
    Application.ProcessMessages;
    Lc_Contador := RecordCount;
    end;
end;

function TFr_AreaTestes.Fc_BuscaMovimentoCaixa(Fc_Cd_NotaFiscal,Fc_FmaPagto:String):Real;
var
  Lc_Contador : Integer;
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Fr_AreaTestes);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT sum(tb_financeiro.fin_vl_pago) valor '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODIGO = FIN_CODNFL) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (FPT_CODIGO = FIN_CODFPG) '+
            '  LEFT OUTER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = FIN_CODNFL) '+
            'WHERE (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) '+
            'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
            ' AND ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) '+
            'AND (FIN_BAIXA = ''S'') ');
    if (Trim(Fc_FmaPagto)<> '') then
      sql.Add('AND (fpt_descricao =:fpt_descricao) ');
    if (Trim(Fc_Cd_NotaFiscal)<> '') then
      sql.Add('AND (NFL_CODIGO =:NFL_CODIGO) ');
    //Passagem de Paarametros
    if (Trim(Fc_FmaPagto)<> '') then
      ParamByName('fpt_descricao').AsString := Fc_FmaPagto;
    if (Trim(Fc_Cd_NotaFiscal)<> '') then
      ParamByName('NFL_CODIGO').AsString := Fc_Cd_NotaFiscal;
    ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
    ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
    Active := True;
    if recordcount > 0 then
      Result := FieldByName('VALOR').AsCurrency
    else
      Result := 0;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


function TFr_AreaTestes.Fc_BuscaMovimentoCaixaModelo2(Lc_Qry:TSTQuery;Fc_Cd_NotaFiscal,Fc_FmaPagto:String):TSTQuery;
var
  Lc_Contador : Integer;
Begin
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT FIN_CODFPG,fpt_descricao, sum(tb_financeiro.fin_vl_pago) valor '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODIGO = FIN_CODNFL) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (FPT_CODIGO = FIN_CODFPG) '+
            'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
            'AND (FIN_DATA = FIN_DT_PAGTO) AND (FIN_DATA = NFL_DT_EMISSAO) '+
            'AND ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) ');
    if (Trim(Fc_FmaPagto)<> '') then
      sql.Add('AND (fpt_descricao =:fpt_descricao) ');
    if (Trim(Fc_Cd_NotaFiscal)<> '') then
      sql.Add('AND (NFL_CODIGO =:NFL_CODIGO) ');

    sql.Add('GROUP BY 1,2 ');
    //Passagem de Paarametros
    if (Trim(Fc_FmaPagto)<> '') then
      ParamByName('fpt_descricao').AsString := Fc_FmaPagto;
    if (Trim(Fc_Cd_NotaFiscal)<> '') then
      ParamByName('NFL_CODIGO').AsString := Fc_Cd_NotaFiscal;
    ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
    ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
    Active := True;
    end;
  result := Lc_Qry;
end;

procedure TFr_AreaTestes.Pc_GeraGraficoVendaOrigemVenda;
Var
  Lc_Form : TGF_VendasOrigemVenda;
begin
  IF (Trim(DBLCB_Vendedor.Text) ='') then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Campo Vendedor é obrigatório.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
          ['OK'], [bEscape], mpAlerta);
    CB_Tipo.SetFocus;
    exit;
  end;
  Lc_Form := TGF_VendasOrigemVenda.Create(nil);
  try
    Lc_Form.it_Ch_Periodo := ChBx_Periodo.Checked;
    Lc_Form.It_Dt_Ini     := DateToStr(E_Data_Ini.Date);
    Lc_Form.It_Dt_Fim     := DateToStr(E_Data_Fim.Date);
    IF Trim(DBLCB_Vendedor.Text) <> '' then
      Lc_Form.It_Cd_Vendedor := IntToStr(DBLCB_Vendedor.KeyValue);
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

function TFr_AreaTestes.Fc_BuscaMovimentoReceber(Fc_Nr_Pedido,Fc_FmaPagto:String):Real;
var
  Lc_Contador : Integer;
  Lc_Qry:TSTQuery;
Begin
  Application.ProcessMessages;
  Lc_Qry := TSTQuery.Create(Fr_AreaTestes);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT sum(tb_financeiro.fin_vl_parcela) valor '+
            'FROM tb_pedido '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODPED = PED_CODIGO) '+
            '  INNER JOIN TB_FINANCEIRO '+
            '  ON (FIN_CODNFL = NFL_CODIGO) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (FPT_CODIGO = FIN_CODFPG) '+
            'WHERE (PED_NUMERO =:PED_NUMERO) '+
            'AND (FIN_BAIXA = ''N'') ');
    if Trim(Fc_FmaPagto) <>'' then
      sql.Add('AND (fpt_descricao =:fpt_descricao) ')
    else
      sql.Add('AND ( (fpt_descricao <>''CHEQUE''  ) '+
              'AND   (fpt_descricao <>''CARTÃO''  ) '+
              'AND   (fpt_descricao <>''BOLETO''  ) '+
              'AND   (fpt_descricao <>''FICHA - CARTEIRA''   ) )' );

    if Trim(Fc_FmaPagto) <>'' then
      ParamByName('fpt_descricao').AsString := Fc_FmaPagto;
    ParamByName('PED_NUMERO').AsString := Fc_Nr_Pedido;
    Active := True;
    Application.ProcessMessages;
    if recordcount > 0 then
      Result := FieldByName('VALOR').AsCurrency
    else
      Result := 0;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;





function TFr_AreaTestes.Fc_FPagtoUtilCaixa():TSTQuery;
Begin
  Result := TSTQuery.Create(Fr_AreaTestes);
  with Result do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('SELECT FPT_CODIGO, FPT_DESCRICAO,SUM(FIN_VL_PAGO) VALOR '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN tb_empresa '+
            '  ON (EMP_CODIGO = FIN_CODEMP) '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODIGO= FIN_CODNFL) '+
            '  LEFT OUTER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (tb_formapagto.fpt_codigo = tb_financeiro.fin_codfpg) '+
            'WHERE (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) '+
            'AND  (NFL_DT_EMISSAO < :DATAINI ) '+
            'AND ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'') ) '+
            'AND FIN_BAIXA = ''S'' '+
            'AND FIN_OPERACAO = ''C'' '+
            'GROUP BY 1,2 '+
            'HAVING SUM(FIN_VL_PAGO) >0');
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.Date;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.Date;
    Active := True;
    end;
end;

function TFr_AreaTestes.Fc_BuscaMovimentoReceberModelo2(Pc_Qry:TSTQuery; Fc_Nr_Pedido,Fc_FmaPagto:String):Real;
var
  Lc_Contador : Integer;
  Lc_Fin_Numero : String;
Begin
  Application.ProcessMessages;
  with Pc_Qry do
    Begin
    active := False;
    sql.Clear;
    sql.Add('SELECT FIN_CODIGO, FIN_NUMERO,fin_vl_parcela '+
            'FROM tb_pedido '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODPED = PED_CODIGO) '+
            '  INNER JOIN TB_FINANCEIRO '+
            '  ON (FIN_CODNFL = NFL_CODIGO) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (FPT_CODIGO = FIN_CODFPG) '+
            'WHERE (PED_NUMERO =:PED_NUMERO) '+
            '  AND ( ( NFL_DT_EMISSAO < FIN_DT_PAGTO ) or ( FIN_DT_PAGTO IS NULL) ) '+
            ' AND ( (FIN_TIPO = ''RA'') OR  (FIN_TIPO = ''RM'') ) '+
            ' and (FIN_OPERACAO = ''C'')  '+
            'ORDER BY 2,1 ');
    if Trim(Fc_FmaPagto) <>'' then
      sql.Add('AND (fpt_descricao =:fpt_descricao) ');
    if Trim(Fc_FmaPagto) <>'' then
      ParamByName('fpt_descricao').AsString := Fc_FmaPagto;
      
    ParamByName('PED_NUMERO').AsString := Fc_Nr_Pedido;
    Active := True;
    Application.ProcessMessages;
    if recordcount > 0 then
      Begin
      first;
      Result := 0;
      Lc_Fin_Numero := '';//FieldByName('FIN_NUMERO').AsString;
      while not eof do
        Begin
        if Lc_Fin_Numero <> FieldByName('FIN_NUMERO').AsString then
          Begin
          Result := Result + FieldByName('fin_vl_parcela').AsCurrency;
          Lc_Fin_Numero := FieldByName('FIN_NUMERO').AsString;
          end;
        next;
        end;
      end
    else
      Result := 0;
    end;
end;

procedure TFr_AreaTestes.Pc_CaixaModelo2(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_Coluna : Integer;
  Lc_Contador : Integer;
  Lc_Qry_Movimento : TSTQuery;
  Lc_Qry_FpagtoPedido : TSTQuery;
  Lc_Qry_Mov_Caixa : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  Lc_Mtz_FormaPagto: Array of Array of String;
  Lc_Nr_FormaPagto : Integer;
  Lc_Nr_Mes : Integer;
  Lc_FmaPAgto : String;
  Lc_Valor:Real;
  Lc_Nr_Pedido : String;
  Lc_Cd_NotaFiscal : String;
  Lc_I,Lc_J : Integer;
  Lc_Col_CreditoLoja : Integer;
begin
  //Consulta Movimento Financeiro
  Lc_Qry_Movimento := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Movimento := Fc_BuscaMovimentoVenda;
  Lc_Qry_Mov_Caixa := TSTQuery.create(Fr_AreaTestes);
  //Query auxiliar
  Lc_Qry_Aux := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Aux.Database := DM.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  //Controla o acompanhamento
  Pc_Progresso.Progress := 0;
  Pc_Progresso.MinValue := 1;
  Pc_Progresso.MaxValue := 2 + Lc_Qry_Movimento.RecordCount;
  Pc_Progresso.Visible := True;
  Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
  Pc_Acompanhamento.Visible := True;
  Application.ProcessMessages;

  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;
  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Periodo';
  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
  //Configura as Margens
  Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
  Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
  Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

  Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho';
  Pc_Progresso.Progress := 1;
  Application.ProcessMessages;
  //Cabeçalho 1º Linha
  Lc_Linha := 1;

  if (Lc_Qry_Movimento.RecordCount > 0) then
    Begin
    with Lc_Qry_Movimento do
      Begin
      //Colunas Variaveis de formas a receber conforme pedidos do dia
      Lc_Qry_FpagtoPedido := TSTQuery.create(Fr_AreaTestes);
      Lc_Qry_FpagtoPedido := Fc_FPagtoUtilPedidos;
      Fc_FPagtoUtilPedidos.FetchAll;
      Lc_Nr_FormaPagto := Fc_FPagtoUtilPedidos.RecordCount;
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,9,10, 1,'','CAIXA (ENTRADAS FINANCEIRAS) - USUÁRIO: '+ GB_Nm_Usuario + ' - MOVIMENTAÇÃOO VENDAS DIA - DATA: '  + Copy(DateToStr(E_Data_Ini.Date),1,5));

      Pc_Acompanhamento.Caption := 'Calculando Movimento Finaceiro.';
      Pc_Progresso.Progress := 2;
      Application.ProcessMessages;
      //Cabecalho forma de pagamento;
      inc(Lc_Linha);
      inc(Lc_Linha);
      //Colunas Fixas
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,1,1,10,2,'', 'PEDIDO');
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,2,2,10,2,'', 'CLIENTE');

      with Lc_Qry_FpagtoPedido do
        Begin
        Lc_J := 3;
        FetchAll;
        First;
        if (RecordCount>0) then
          SetLength(Lc_Mtz_FormaPagto,3,RecordCount)
        else
          SetLength(Lc_Mtz_FormaPagto,3,1);
        Lc_Nr_FormaPagto := 0;
        while not eof do
          Begin
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,Lc_J,Lc_J,10,2,'', FieldByname('FPT_DESCRICAO').AsString);
          Lc_Mtz_FormaPagto[0,Lc_Nr_FormaPagto] := FieldByname('FPT_CODIGO').AsString;
          Lc_Mtz_FormaPagto[1,Lc_Nr_FormaPagto] := FieldByname('FPT_DESCRICAO').AsString;
          Lc_Mtz_FormaPagto[2,Lc_Nr_FormaPagto] := IntToStr(Lc_J);
          if (FieldByname('FPT_DESCRICAO').AsString = 'CREDITO LOJA') then
            Lc_Col_CreditoLoja := Lc_J;
          inc(Lc_Nr_FormaPagto);
          inc(Lc_J);
          next;
          end;
        end;
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,Lc_J,Lc_J,10,2,'', 'RECEBER');
      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Linha);
        inc(Lc_Contador);
        //Hisotorico
        Lc_Nr_Pedido := FieldByName('PED_NUMERO').AsString;
        Lc_Cd_NotaFiscal  := FieldByName('NFL_CODIGO').AsString;
        repeat
          Pc_Acompanhamento.Caption := 'Formantando células.';
          Lc_Valor := 0;
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,1,1,10,2,'', Lc_Nr_Pedido);
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,2,2,15,2,'', Copy(FieldByName('EMP_NOME').AsString, 1,Pred(Pos(' ', FieldByName('EMP_NOME').AsString))));
          Lc_FmaPAgto := Upper(FieldByName('fpt_descricao').AsString);
          Pc_Acompanhamento.Caption := 'Verificando valores do Pedido Número: ' + FieldByName('PED_NUMERO').AsString;
          Application.ProcessMessages;
          //Monta as colunas que são recebidas no dia
          Lc_Qry_Mov_Caixa := Fc_BuscaMovimentoCaixaModelo2(Lc_Qry_Mov_Caixa,Lc_Cd_NotaFiscal,'');
          Application.ProcessMessages;
          Lc_Col_CreditoLoja := 0;
          For Lc_J:=0 to Lc_Nr_FormaPagto -1 do
            Begin
            Lc_Valor := 0;
            Lc_Coluna := StrToInt( Lc_Mtz_FormaPagto[2,Lc_J] );
            Lc_Qry_Mov_Caixa.First;
            if Lc_Qry_Mov_Caixa.Locate('FIN_CODFPG',Lc_Mtz_FormaPagto[0,Lc_J],[]) then
              Begin
              Lc_Valor := Lc_Qry_Mov_Caixa.fieldByName('valor').AsCurrency;
              Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,Lc_Coluna,Lc_Coluna,10,3,'R$   #.##0,00', Lc_Valor)
              end
            else
              Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked, Lc_Sheet,Lc_Linha,Lc_Coluna,Lc_Coluna,10,1,'','');
            end;
          Lc_Qry_Mov_Caixa.Close;

            //Monta a coluna que será recebidas {todos em uma coluna}
            Lc_Coluna := Lc_Nr_FormaPagto + 3;
            Lc_Valor := Fc_BuscaMovimentoReceberModelo2(Lc_Qry_Aux,FieldByName('PED_NUMERO').AsString,'');
            Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked, Lc_Sheet,Lc_Linha,Lc_Coluna,Lc_Coluna,10,1,'','');
            if (Lc_Valor > 0) then
              Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,Lc_Coluna,Lc_Coluna,10,3,'R$   #.##0,00', Lc_Valor);
          next;
        until (Lc_Cd_NotaFiscal <> FieldByName('NFL_CODIGO').AsString) or (eof);
        Pc_Progresso.Progress := Pc_Progresso.Progress +1;
        Application.ProcessMessages;
      until (eof);
      inc(Lc_Linha);
      //Totalizador das colunas
      Pc_Acompanhamento.Caption := 'Totalizando o Relatório';
      Application.ProcessMessages;
      IF (Lc_Nr_FormaPagto > 0) then
        BEgin
        if Lc_Col_CreditoLoja = 0 then
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,1,2,10,2,'R$   #.##0,00', '=SUM(RC[2]:RC['+intToStr(Lc_Nr_FormaPagto + 2)+'])')
        else
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,1,2,10,2,'R$   #.##0,00', '=SUM(RC[2]:RC['+intToStr(Lc_Nr_FormaPagto)+'],RC['+intToStr(Lc_Nr_FormaPagto + 2)+'])');
        end
      else
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,1,2,10,2,'R$   #.##0,00', '=SUM(RC[2]:RC[2])');
      For Lc_J:=3 to Lc_Nr_FormaPagto +3 do
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet,Lc_Linha,Lc_J,Lc_J,10,3,'R$   #.##0,00', '=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)');
      end;

    Pc_Acompanhamento.Caption := 'Processo Finalizado';
    Pc_Progresso.Progress := Pc_Progresso.MaxValue;
    Application.ProcessMessages;
    //Abre o excel
    Lc_Excel.Visible := true;
    end;

  Lc_Qry_Movimento.Close;
  FreeAndNil(Lc_Qry_Movimento);
  Lc_Qry_Aux.Close;
  FreeAndNil(Lc_Qry_Aux);
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Application.ProcessMessages;
end;

procedure TFr_AreaTestes.FormShow(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
end;

procedure TFr_AreaTestes.SB_ImprimirClick(Sender: TObject);
begin
  Pc_ProcesoAguarde(Self,'I');
  Self.Enabled := False;
  try
    case CB_Tipo.ItemIndex of
      0:ShowMessage('Utilize o botão Exportar');
      1:ShowMessage('Utilize o botão Exportar');
      2:ShowMessage('Utilize o botão Exportar');
      3:ShowMessage('Utilize o botão Exportar');
      4:ShowMessage('Utilize o botão Exportar');
      5:ShowMessage('Utilize o botão Exportar');
      end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_AreaTestes.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_AreaTestes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
      VK_F3  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_AreaTestes.CB_TipoChange(Sender: TObject);
begin
  DsblControl( ChBx_Periodo);
  DsblControl( DBLCB_Vendedor);
  DsblControl( Cb_Info_Grafico);
  case Cb_Tipo.ItemIndex of
    0:begin//RELATÓRIO DE VENDAS DIÁRIAS
      EnblControl( ChBx_Periodo );
      ChBx_PeriodoClick(Self);
      end;
    1:begin//RESUMO DE VENDAS DA SEMANA
      EnblControl( ChBx_Periodo );
      ChBx_PeriodoClick(Self);
      end;
    2:begin//RELATORIO DE RECEBIMENTOS
      EnblControl( ChBx_Periodo );
      ChBx_PeriodoClick(Self);
      end;
    3:begin//RELATORIO DE CAIXA (modelo 2)
      EnblControl( ChBx_Periodo );
      ChBx_PeriodoClick(Self);
      end;
    4:begin//Grafico
      EnblControl( ChBx_Periodo );
      ChBx_PeriodoClick(Self);
      EnblControl( DBLCB_Vendedor );
      EnblControl( Cb_Info_Grafico);
      end;
    5:begin//Grafico
      EnblControl( ChBx_Periodo );
      ChBx_PeriodoClick(Self);
      end;
    end;

end;

procedure TFr_AreaTestes.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_AreaTestes.Clientes1Click(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Empresa;
begin
  Lc_Form := TFr_Pesq_Empresa.Create(Self);
  Try
    Lc_Form.TipoEmpresa := 1;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_AreaTestes.Pc_GraficosOrigem(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet, Chart : Variant;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  Lc_VL_Venda : Real;
  Lc_Vl_Devolvido : Real;
  Lc_Vl_Total : Real;
  Lc_Nr_Mes : Integer;
  Lc_Contador : Integer;
  Lc_Registros : Integer;
begin
{
  Lc_Qry_Aux := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Aux.Database := DM.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux.ForcedRefresh := True;


  //Consulta de Ogirem de Clientes
  Lc_Qry := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry := Pc_BuscarOrigemCliente;
  Lc_Qry.FetchAll;
  Lc_Registros := Lc_Qry.RecordCount;
  Lc_Qry.Close;
  Application.ProcessMessages;
  if Lc_Registros > 0 then
  Begin
    //Consulta Venda Geral
    Lc_Qry := Pc_BuscarOrigemGeral;
    Lc_Qry.FetchAll;
    Lc_Registros := Lc_Registros + Lc_Qry.RecordCount;
    Lc_Qry.Close;
    Application.ProcessMessages;

    // Consulta das Ogirem das Vendas
    Lc_Qry := Pc_BuscarOrigemVenda;
    Lc_Qry.FetchAll;
    Lc_Registros := Lc_Registros + Lc_Qry.RecordCount;

    Pc_Progresso.Progress := 0;
    Pc_Progresso.MinValue := 1;
    Pc_Progresso.MaxValue := 4 + Lc_Registros;
    Pc_Progresso.Visible := True;

    //Controla o acompanhamento
    Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
    Pc_Acompanhamento.Visible := True;
    Application.ProcessMessages;

    //cria a aplicação
    Lc_Excel := CreateOleObject('Excel.Application');
    //adiciona pasta de trabalho
    Lc_Excel.WorkBooks.Add;
    //planilha recebendo variável nome
    Lc_Excel.WorkSheets[1].Name := 'Origem Venda e Cliente';
    //Repassando variável
    Lc_Sheet := Lc_Excel.WorkSheets['Origem Venda e Cliente'];
    //Configura as Margens
    Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
    Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
    Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

    Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho.';
    Pc_Progresso.Progress := 1;
    Application.ProcessMessages;

    Lc_Vl_Total := 0;
    //------------------------ ORIGEM DAS VENDAS -------------------------------
    //Cabeçalho 1º Linha
    Lc_Linha := 1;
    Lc_VL_Venda := Pc_BuscarTotalVda;
    Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,2,80, 2,'',DM_ListaConsultas.Qr_ListaVendedor.FieldByname('CLB_NOME').AsString + ' '+ FormatFloat('#,##0.00',Lc_VL_Venda));
    Lc_Linha := 2;
    with Lc_Qry do
    Begin
      Pc_Acompanhamento.Caption := 'Calculando Origem da Venda.';
      Pc_Progresso.Progress := 2;
      Application.ProcessMessages;
      inc(Lc_Linha);
      // TIPO DA VENDA
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'','');
      //Valor da Venda
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'',FieldByName('DESCRIPTION').AsString+' R$'+FormatFloat('#,##0.00',FieldByName('SUM').AsFloat));
      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Contador);
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Application.ProcessMessages;
        inc(Lc_Linha);
        // TIPO DA VENDA
        Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'',FieldByName('DESCRIPTION').AsString+' R$'+FormatFloat('#,##0.00',FieldByName('SUM').AsFloat));
        //Valor da Venda
        Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00',FieldByName('SUM').AsFloat);
        next;
      until eof;

      Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
      //Label Valor Total
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'',' ');
      //Valor TOTAL da Venda
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'',' ');
      //Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)');
    end;
    Pc_Acompanhamento.Caption := 'Origem da Venda Finalizado';
    Application.ProcessMessages;

    // Cria Grafico
    Lc_Sheet.ChartObjects.Add(1,1,525,340); // Coordenadas (Left,Top,Width,Height)
    Chart := Lc_Sheet.ChartObjects(1); // Cria o Grafico
    Chart.Chart.ChartType := $00000005; // Tipo do Grafico
    Chart.Chart.ApplyLayout(1, Chart.Chart.ChartType);
    Chart.Chart.HasTitle := True;
    Chart.Chart.ChartTitle.Text := 'ORIGEM VENDA - '+DM_ListaConsultas.Qr_ListaVendedorCLB_NOME.AsString + ' '+ FormatFloat('#,##0.00',Lc_VL_Venda);
    Chart.Chart.SeriesCollection.Add(Lc_Sheet.Range['A3',Lc_StrCell1]);
    Application.ProcessMessages;
    //--------------------------- FIM ORIGEM DAS VENDAS ------------------------
    //--------------------------- ORIGEM DOS CLIENTES --------------------------
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
    //Consulta Origgem dos Clientes
    Lc_Qry := TSTQuery.create(Fr_AreaTestes);
    Lc_Qry := Pc_BuscarOrigemCliente;
    Lc_Qry.FetchAll;
    Lc_Vl_Total := 0;
    //Cabeçalho 1º Linha
    inc(Lc_Linha);
    Lc_VL_Venda := Pc_BuscarTotalVda;
    Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,2,80, 2,'',DM_ListaConsultas.Qr_ListaVendedorCLB_NOME.AsString + ' '+ FormatFloat('#,##0.00',Lc_VL_Venda));
    inc(Lc_Linha);
    with Lc_Qry do
    Begin
      Pc_Acompanhamento.Caption := 'Calculando Origem do Cliente.';
      Application.ProcessMessages;
      Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
      inc(Lc_Linha);
      // TIPO DA VENDA
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'','');
      //Valor da Venda
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'',FieldByName('DESCRIPTION').AsString+' R$'+FormatFloat('#,##0.00',FieldByName('SUM').AsFloat));
      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Contador);
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Application.ProcessMessages;
        inc(Lc_Linha);
        // TIPO DA VENDA
        Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'',FieldByName('DESCRIPTION').AsString+' R$'+FormatFloat('#,##0.00',FieldByName('SUM').AsFloat));
        //Valor da Venda
        Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00',FieldByName('SUM').AsFloat);
        next;
      until eof;
      Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
      //Label Valor Total
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'','TOTAL');
      //Valor TOTAL da Venda
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)');
    end;
    Pc_Acompanhamento.Caption := 'Origem do Cliente Finalizado';
    Application.ProcessMessages;

    // Cria Grafico
    Lc_Sheet.ChartObjects.Add(525,1,525,340); // Coordenadas (Left,Top,Width,Height)
    Chart := Lc_Sheet.ChartObjects(2); // Cria o Grafico
    Chart.Chart.ChartType := $00000005; // Tipo do Grafico
    Chart.Chart.ApplyLayout(1, Chart.Chart.ChartType);
    Chart.Chart.HasTitle := True;
    Chart.Chart.ChartTitle.Text := 'ORIGEM CLIENTE - '+DM_ListaConsultas.Qr_ListaVendedorCLB_NOME.AsString + ' '+ FormatFloat('#,##0.00',Lc_VL_Venda);
    Chart.Chart.SeriesCollection.Add(Lc_Sheet.Range[Lc_StrCell2,Lc_StrCell1]);
    Application.ProcessMessages;
    //------------------------------- FIM ORIGEM DOS CLIENTES ------------------

    //------------------------------- VISAO GERAL ------------------------------
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
    //Consulta Origgem dos Clientes
    Lc_Qry := TSTQuery.create(Fr_AreaTestes);
    Lc_Qry := Pc_BuscarOrigemGeral;
    Lc_Qry.FetchAll;
    Lc_Vl_Total := 0;
    //Cabeçalho 1º Linha
    inc(Lc_Linha);
    Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
    Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,2,80, 2,'','VENDA GERAL');
    inc(Lc_Linha);
    with Lc_Qry do
    Begin
      Pc_Acompanhamento.Caption := 'Calculando Venda Geral.';
      Application.ProcessMessages;
      inc(Lc_Linha);
      // TIPO DA VENDA
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'','COLABORADOR');
      //Valor da Venda
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'','VALOR DA VENDA');
      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Contador);
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Application.ProcessMessages;
        inc(Lc_Linha);
        // TIPO DA VENDA
        Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'',FieldByName('CLB_NOME').AsString+' R$'+FormatFloat('#,##0.00',FieldByName('SUM').AsFloat));
        //Valor da Venda
        Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00',FieldByName('SUM').AsFloat);
        next;
      until eof;
      Lc_StrCell1 := 'B' + IntToStr(lc_Linha);
      //Label Valor Total
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 1,1,60, 1,'','TOTAL');
      //Valor TOTAL da Venda
      Pc_PreenceCelulaExcel(Lc_Sheet, Lc_Linha, 2,2,20, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador) +']C:R[-1]C)');
    end;
    Pc_Acompanhamento.Caption := 'Venda Geral Finalizado';
    Application.ProcessMessages;

    // Cria Grafico
    Lc_Sheet.ChartObjects.Add(100,342,800,350); // Coordenadas (Left,Top,Width,Height)
    Chart := Lc_Sheet.ChartObjects(3); // Cria o Grafico
    Chart.Chart.ChartType := $00000005; // Tipo do Grafico
    Chart.Chart.ApplyLayout(1, Chart.Chart.ChartType);
    Chart.Chart.HasTitle := True;
    Chart.Chart.ChartTitle.Text := 'VENDA GERAL';
    Chart.Chart.SeriesCollection.Add(Lc_Sheet.Range[Lc_StrCell2,Lc_StrCell1]);
    Application.ProcessMessages;

    Lc_Excel.Visible := true;     //Abre o excel
    Lc_Excel.ActiveWindow.Zoom := 65;
    Lc_StrCell1 := fc_PegaLetraColuna(1) + IntToStr(1);
    Lc_StrCell2 := fc_PegaLetraColuna(20) + IntToStr(lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].font.size := 4;
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].borders.linestyle := 0;
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].font.color := clWhite; // esconte os dados
    Pc_Progresso.Progress := Pc_Progresso.MaxValue;

    //-------------------------------  FIM VISAO GERAL ------------------------

    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
    Lc_Qry_Aux.Close;
    FreeAndNil(Lc_Qry_Aux);
    Pc_Progresso.Progress := 0;
    Pc_Progresso.Visible := false;
    Pc_Acompanhamento.Visible := false;
    Application.ProcessMessages;
  end;
  }
end;


function TFr_AreaTestes.Pc_BuscarTotalVda():real;
var
  Lc_Qry_Aux : TSTQuery;
begin
  Lc_Qry_Aux := TSTQuery.create(Fr_AreaTestes);
  with Lc_Qry_Aux do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    Active := False;
    sql.clear;
    sql.add( ' select SUM(tb_nota_fiscal.nfl_vl_tl_nota) total '+
             ' from tb_nota_fiscal '+
             '  inner join tb_pedido '+
             '  on (ped_codigo = nfl_codped) '+
             '  inner join tb_colaborador '+
             '  on (clb_codigo = ped_codvdo) '+
             '  INNER JOIN tb_sale_origen '+
             '  ON (ID = ped_tp_contato) '+
             ' where (description is not null) '+
             'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
             'AND (PED_CODVDO =:PED_CODVDO) ');

    ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
    ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
    ParamByName('PED_CODVDO').AsString := DM_ListaConsultas.Qr_ListaVendedor.FieldByname('CLB_CODIGO').AsString;
    open;
    Result := fieldbyname('total').AsCurrency;
  end;
end;




function TFr_AreaTestes.Fc_BuscaVendaFechamento(Pc_Qry:TSTQuery):TSTQuery;
begin
  with Pc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select '+
            'PED_CODIGO, '+
            'PED_NUMERO, '+
            'NFL_DT_EMISSAO, '+
            'NFL_VL_TL_NOTA, '+
            'CLB_NOME, '+
            'sum(tb_itens_nfl.itf_vl_custo * tb_itens_nfl.itf_qtde) NFL_VL_CUSTO '+
            'FROM TB_PEDIDO '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODPED = PED_CODIGO) '+
            '  INNER JOIN TB_ITENS_NFL '+
            '  ON (NFL_CODIGO = ITF_CODNFL) '+
            '  INNER JOIN tb_colaborador '+
            '  ON (CLB_CODIGO = PED_CODVDO) '+
            'WHERE (PED_TIPO = 1) AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
            'GROUP BY 1,2,3,4,5');
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    Active := True;
    end;
  result := Pc_Qry;
end;

function TFr_AreaTestes.Fc_BuscaResumoVendasRecebimentos(Pc_Qry:TSTQuery):TSTQuery;
begin
  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select nfl_dt_emissao, PED_CODIGO, PED_NUMERO, NFL_NUMERO,nfl_vl_tl_nota, EMP_FANTASIA, CDD_DESCRICAO '+
            'from tb_nota_fiscal '+
            '  INNER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            '  INNER JOIN tb_empresa '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            '  INNER JOIN TB_ENDERECO '+
            '  ON (END_CODIGO = PED_CODEND) '+
            '  INNER JOIN TB_CIDADE '+
            '  ON (CDD_CODIGO = END_CODCDD) '+
            'where (NFL_DT_EMISSAO = :DATA) AND (PED_TIPO = 1) '+
            'UNION '+
            'select nfl_dt_emissao, PED_CODIGO, PED_NUMERO, NFL_NUMERO,nfl_vl_tl_nota, EMP_FANTASIA, CDD_DESCRICAO '+
            'from tb_nota_fiscal '+
            '  INNER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = NFL_CODPED) '+
            '  INNER JOIN tb_empresa '+
            '  ON (EMP_CODIGO = NFL_CODEMP) '+
            '  INNER JOIN TB_ENDERECO '+
            '  ON (END_CODIGO = PED_CODEND) '+
            '  INNER JOIN TB_CIDADE '+
            '  ON (CDD_CODIGO = END_CODCDD) '+
            '  INNER  JOIN TB_FINANCEIRO '+
            '  ON (FIN_CODNFL = NFL_CODIGO ) '+
            'where (tb_financeiro.fin_dt_pagto = :DATA) AND (PED_TIPO = 1) ');

    ParamByName('DATA').AsDateTime := E_Data_Ini.DateTime;
    Active := True;
  end;
  result := Pc_Qry;
end;

function TFr_AreaTestes.Fc_BuscaItensPedido(Pc_Qry:TSTQuery;Pc_Cd_Pedido:Integer):TSTQuery;
begin
  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select PRO_DESCRICAO,ITF_QTDE, ITF_VL_UNIT '+
            'from TB_PEDIDO '+
            '  INNER JOIN tb_itens_nfl '+
            '  ON (ITF_CODPED = PED_CODIGO) '+
            '  INNER JOIN TB_PRODUTO '+
            '  ON (PRO_CODIGO = ITF_CODPRO) '+
            'where ITF_CODPED =:PED_CODIGO '+
            'ORDER BY PRO_DESCRICAO ');

    ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
    Active := True;
  end;
  result := Pc_Qry;
end;

function TFr_AreaTestes.Fc_BuscaFinanceiroPedido(Pc_Qry:TSTQuery;Pc_Cd_Pedido:Integer):TSTQuery;
begin
  with Pc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    sql.Clear;
    sql.Add('select fpt_descricao,FIN_DT_VENCIMENTO,FIN_BAIXA,FIN_VL_PAGO '+
            'from TB_FINANCEIRO '+
            '  INNER JOIN TB_PEDIDO '+
            '  ON (PED_CODIGO = FIN_CODPED) '+
            '  INNER JOIN tb_formapagto '+
            '  ON (fpt_codigo = PED_codfpg) '+
            'where FIN_CODPED=:PED_CODIGO AND ( (fin_dt_pagto = :DATA) or ( (fin_dATA =:DATA) AND (fin_dt_pagto IS NULL) ) ) ');

    ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
    ParamByName('DATA').AsDateTime := E_Data_Ini.DateTime;
    Active := True;
  end;
  result := Pc_Qry;
end;

procedure TFr_AreaTestes.Pc_FechamentoMensal(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet, Chart : Variant;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  Lc_Contador : Integer;
  Lc_VL_Ajuste,Lc_VL_Custo:Real;
begin
  //Consulta das Vendas diárias
  Lc_Qry_Aux := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Aux.Database := DM.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux.ForcedRefresh := True;

  //Consulta das Vendas diárias
  Lc_Qry := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry := Fc_BuscaVendaFechamento(Lc_Qry);
  Lc_Qry.FetchAll;
  if (Lc_Qry.RecordCount > 0) then
  Begin
    //Controla o acompanhamento
    Pc_Progresso.Progress := 0;
    Pc_Progresso.MinValue := 1;
    Pc_Progresso.MaxValue := 2 + Lc_Qry.RecordCount;
    Pc_Progresso.Visible := True;
    Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
    Pc_Acompanhamento.Visible := True;
    Application.ProcessMessages;


    //cria a aplicação
    Lc_Excel := CreateOleObject('Excel.Application');
    //adiciona pasta de trabalho
    Lc_Excel.WorkBooks.Add;
    //planilha recebendo variável nome
    Lc_Excel.WorkSheets[1].Name := 'Periodo';
    //Repassando variável
    Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
    //Configura as Margens
    Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
    Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
    Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

    Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho.';
    Pc_Progresso.Progress := 1;
    Application.ProcessMessages;
    //Cabeçalho 1º Linha
    Lc_Linha := 1;
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,16,1,'','PEDIDO');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 2,2,16,1,'','DATA');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 3,3,16,1,'','VALOR NOTA');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,16,1,'','CONFERENCIA:');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 5,5,16,1,'','AJUSTE');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 6,6,16,1,'','CUSTO');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 7,7,16,1,'','LUCRO R$');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 8,8,16,1,'','LUCRO %');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 9,9,60,1,'','VENDEDOR');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 10,10,60,1,'','SUPERVISOR');

    with Lc_Qry do
    Begin
      Pc_Acompanhamento.Caption := 'Calculando movimento geral.';
      Pc_Progresso.Progress := 2;
      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Contador);
        inc(Lc_Linha);
        Lc_VL_Ajuste := 0;
        Lc_VL_Custo := 0;
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Pc_Acompanhamento.Caption := 'Pedido: ' + FieldByName('PED_NUMERO').AsString;
        Application.ProcessMessages;
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,16,1,'',FieldByName('PED_NUMERO').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 2,2,16,1,'mm/dd/aaaa',FieldByName('NFL_DT_EMISSAO').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 3,3,16,3,'0,00',FieldByName('NFL_VL_TL_NOTA').AsCurrency);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,16,1,'','');
        Lc_VL_Ajuste := Fc_ValorPedidoDevolvido(Lc_Qry_Aux,FieldByName('PED_CODIGO').AsInteger);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 5,5,16,3,'0,00',Lc_VL_Ajuste);
        Lc_VL_Custo := FieldByName('NFL_VL_CUSTO').AsCurrency;
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 6,6,16,3,'0,00',Lc_VL_Custo);
        IF (Lc_VL_Ajuste > 0 ) then
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 7,7,16,3,'0,00','=(RC[-4]-RC[-1])-(abs(RC[-2]-RC[-1]))')
        else
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 7,7,16,3,'0,00','=RC[-4]-RC[-1]');
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 8,8,16,3,'0,00%','=((RC[-1]*100)/RC[-2])/100');
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 9,9,60,1,'',FieldByName('CLB_NOME').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 10,10,60,1,'',FieldByName('CLB_NOME').AsString);
        Application.ProcessMessages;
        next;
      until eof;
    end;
    Pc_Acompanhamento.Caption := 'Processo Finalizado';
    Pc_Progresso.Progress := Pc_Progresso.MaxValue;
    Application.ProcessMessages;
    //Abre o excel
    Lc_Excel.Visible := true;


  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Application.ProcessMessages;
end;

procedure TFr_AreaTestes.Pc_ResumoVendasRecebimentos(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet, Chart : Variant;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  Lc_Qry_Aux_2 : TSTQuery;
  Lc_Contador : Integer;
  Lc_Valor_Aux:Real;
begin
  //Consulta Auziliar 1
  Lc_Qry_Aux := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Aux.Database := DM.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux.ForcedRefresh := True;

  //Consulta Auziliar 2
  Lc_Qry_Aux_2 := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry_Aux_2.Database := DM.IBD_Gestao;
  Lc_Qry_Aux_2.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux_2.ForcedRefresh := True;

  //Consulta das Vendas diárias
  Lc_Qry := TSTQuery.create(Fr_AreaTestes);
  Lc_Qry := Fc_BuscaResumoVendasRecebimentos(Lc_Qry);
  Lc_Qry.FetchAll;
  if (Lc_Qry.RecordCount > 0) then
    Begin
    //Controla o acompanhamento
    Pc_Progresso.Progress := 0;
    Pc_Progresso.MinValue := 1;
    Pc_Progresso.MaxValue := 2 + Lc_Qry.RecordCount;
    Pc_Progresso.Visible := True;
    Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
    Pc_Acompanhamento.Visible := True;
    Application.ProcessMessages;


    //cria a aplicação
    Lc_Excel := CreateOleObject('Excel.Application');
    //adiciona pasta de trabalho
    Lc_Excel.WorkBooks.Add;
    //planilha recebendo variável nome
    Lc_Excel.WorkSheets[1].Name := 'Periodo';
    //Repassando variável
    Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
    //Configura as Margens
    Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
    Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
    Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
    Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

    Pc_Acompanhamento.Caption := 'Escrevendo o Cabeçalho.';
    Pc_Progresso.Progress := 1;
    Application.ProcessMessages;
    //Cabeçalho 1º Linha
    Lc_Linha := 1;
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,5,16,1,'','VENDAS E RECEBIMENTOS DIÁRIOS');
    inc(Lc_Linha);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,16,1,'','DATA');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 2,2,16,1,'','PEDIDO');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 3,3,16,1,'','Nº NOTA');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,16,1,'','CLIENTE');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 5,5,16,1,'','CIDADE');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 6,6,16,1,'','PRODUTOS');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 7,7,16,1,'','QUANT');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 8,8,16,1,'','VL. UNIT');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 9,9,16,1,'','VL. TOTAL');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 10,10,14,1,'','FORMA PAGTO');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 11,11,13,1,'','VENCIMENTO');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 12,12,13,1,'','VL. RECEBIDO');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 13,13,13,1,'','VL. A RECEBER');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 14,14,10,1,'','QUITAÇÃO');

    with Lc_Qry do
    Begin
      Pc_Acompanhamento.Caption := 'Calculando movimento geral.';
      Pc_Progresso.Progress := 2;
      Application.ProcessMessages;
      Lc_Contador := 0;
      repeat
        inc(Lc_Contador);
        inc(Lc_Linha);
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Pc_Acompanhamento.Caption := 'Pedido: ' + FieldByName('PED_NUMERO').AsString;
        Application.ProcessMessages;
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,1,11,1,'mm/dd/aaaa',FieldByName('NFL_DT_EMISSAO').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 2,2,8,1,'',FieldByName('PED_NUMERO').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 3,3,9,1,'',FieldByName('NFL_NUMERO').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,1,'',FieldByName('EMP_FANTASIA').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 5,5,35,1,'',FieldByName('CDD_DESCRICAO').AsString);

        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 9,9,16,3,'0,00',FieldByName('nfl_vl_tl_nota').AsCurrency);
        //fINANCEIRO - oBSERVAR COLUNAS NÃO ESTÃO EM ORDEM
        Fc_BuscaFinanceiroPedido(Lc_Qry_Aux,FieldByName('PED_CODIGO').AsInteger);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 10,10,14,1,'',Lc_Qry_Aux.FieldByName('fpt_descricao').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 11,11,13,3,'mm/dd/aaaa',Lc_Qry_Aux.FieldByName('FIN_DT_VENCIMENTO').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 12,12,13,3,'0,00',Lc_Qry_Aux.FieldByName('FIN_VL_PAGO').AsCurrency);
        Lc_Valor_Aux := Fc_BuscaMovimentoReceberModelo2(Lc_Qry_Aux_2,FieldByName('PED_NUMERO').AsString,'');
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 13,13,13,3,'0,00',Lc_Valor_Aux);
        if (Lc_Qry_Aux.FieldByName('FIN_BAIXA').AsString = 'N') then
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 14,14,10,2,'','EM ABERTO')
        else
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 14,14,10,2,'','PAGO');

        //Preeche os itens dopedido
        Fc_BuscaItensPedido(Lc_Qry_Aux,FieldByName('PED_CODIGO').AsInteger);
        Lc_Qry_Aux.First;
        repeat
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 6,6,35,1,'',Lc_Qry_Aux.FieldByName('PRO_DESCRICAO').AsString);
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 7,7,16,3,'0,00',Lc_Qry_Aux.FieldByName('ITF_QTDE').AsFloat);
          Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 8,8,16,3,'0,00',Lc_Qry_Aux.FieldByName('ITF_VL_UNIT').AsCurrency);
          Lc_Qry_Aux.Next;
          if not Lc_Qry_Aux.eof then inc(Lc_Linha);
        until Lc_Qry_Aux.eof;
        Application.ProcessMessages;
        next;
      until eof;
    end;
    inc(Lc_Linha);
    //Cria a lista de Formas de pagamento
    Lc_Qry := Fc_ListaFormaPagto();
    Lc_Qry.First;
    Lc_Contador := 0;
    repeat
      inc(Lc_Linha);
      inc(Lc_Contador);
      //Forma de Pagamento
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,13, 1,'',Lc_Qry.FieldByName('FPT_DESCRICAO').AsString);
      Application.ProcessMessages;
      //Valores recebimentos no caixa
      Lc_Valor_Aux := Fc_BuscaMovimentoFinanceiroFormaPagto(Lc_Qry.FieldByName('FPT_CODIGO').AsInteger, True);
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,13, 3,'#.##0,00',Lc_Valor_Aux);
      Application.ProcessMessages;
      Application.ProcessMessages;
      Lc_Qry.Next;
    until (Lc_Qry.Eof);
    inc(Lc_Linha);
    //Forma de Pagamento
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,13, 1,'','Total de Forma de Pagamento');
    Application.ProcessMessages;
    //Valores recebimentos no caixa
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,13, 3,'','=SUM(R[-' + InttoStr(Lc_Contador) + ']C:R[-1]C)');
    Application.ProcessMessages;
    Application.ProcessMessages;
    inc(Lc_Linha);
    inc(Lc_Linha);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,11,1,'','RECEBIDOS DE VENDAS ANTERIORES: ');
    Lc_Valor_Aux := Fc_BuscaTotalRecebidoAnterior(Lc_Qry_Aux,DateToStr(E_Data_Ini.DateTime));
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,3,'0,00',Lc_Valor_Aux);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,11,1,'','RECEBIDOS DE VENDAS DE HOJE: ');
    Lc_Valor_Aux := Fc_BuscaTotalRecebidoHoje(Lc_Qry_Aux,DateToStr(E_Data_Ini.DateTime));
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,3,'0,00',Lc_Valor_Aux);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,11,1,'','EM ABERTO DE VENDAS DE HOJE:');
    Lc_Valor_Aux := Fc_BuscaTotalAReceber(Lc_Qry_Aux,DateToStr(E_Data_Ini.DateTime));
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,3,'0,00',Lc_Valor_Aux);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,11,1,'','TOTAL DA VENDA DIÁRIA:');
    Lc_Valor_Aux := Fc_BuscaTotalDiaria(Lc_Qry_Aux,DateToStr(E_Data_Ini.DateTime));
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,3,'0,00',Lc_Valor_Aux);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,11,1,'','TOTAL DO MÊS DE SERVIÇOS:');
    Lc_Valor_Aux := Fc_BuscaTotalServicoMensal(Lc_Qry_Aux,DateToStr(E_Data_Ini.DateTime));
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,3,'0,00',Lc_Valor_Aux);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,11,1,'','TOTAL DO MÊS DE VENDA:');
    Lc_Valor_Aux := Fc_BuscaTotalVendaMensal(Lc_Qry_Aux,DateToStr(E_Data_Ini.DateTime));
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,3,'0,00',Lc_Valor_Aux);
    inc(Lc_Linha);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 1,3,11,1,'','TOTAL GERAL:');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Lc_Sheet, Lc_Linha, 4,4,35,3,'','=SUM(R[-2]C:R[-1]C)');


    Pc_Acompanhamento.Caption := 'Processo Finalizado';
    Pc_Progresso.Progress := Pc_Progresso.MaxValue;
    Application.ProcessMessages;
    //Abre o excel
    Lc_Excel.Visible := true;


    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Application.ProcessMessages;



end;
procedure TFr_AreaTestes.Pc_BuscarListaVendedor(Pc_Qry:TSTQuery);
begin
  with Pc_Qry do
  Begin
    active := False;
    sql.Clear;
    sql.Add('SELECT DISTINCT CLB_CODIGO, CLB_NOME '+
            'FROM TB_PEDIDO '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (NFL_CODPED = PED_CODIGO) '+
            '  INNER JOIN TB_COLABORADOR tb_colaborador '+
            '  ON (CLB_CODIGO = PED_CODVDO) '+
            '  INNER JOIN TB_CARGO tb_cargo '+
            '  ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG) '+
            'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
            ' AND (CRG_DESCRICAO LIKE ''VENDEDOR%'') and (CLB_DEMISSAO IS NULL) '+
//            '-- AND (CLB_CODIGO = 16) '+
            'ORDER BY CLB_NOME');
    ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
    ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    Active := True;
    FetchAll;
    first;

  end;
end;

procedure TFr_AreaTestes.Pc_BuscarOrigemVenda(Pc_Qry:TSTQuery;Pc_Cd_Vendedor:Integer;Pc_Dt_Inicio,Pc_Dt_Fim:TDateTime);
begin
  with Pc_Qry do
  Begin
    Application.ProcessMessages;
    active := False;
    sql.Clear;
    sql.Add(' select clb_nome, DESCRIPTION,SUM(tb_nota_fiscal.nfl_vl_tl_nota) '+
            ' from tb_nota_fiscal '+
            '  inner join tb_pedido '+
            '  on (ped_codigo = nfl_codped) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            '  INNER JOIN tb_sale_origen '+
            '  ON (ID = PED_TP_CONTATO) '+
            ' where (description is not null) '+
            'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
            'AND (PED_CODVDO =:PED_CODVDO) '+
            'AND (PED_TIPO = 1) '+
            ' GROUP BY 1,2');

    ParamByName('DATAINI').AsDateTime := Pc_Dt_Inicio;
    ParamByName('DATAFIM').AsDateTime := Pc_Dt_Fim;
    ParamByName('PED_CODVDO').AsInteger := Pc_Cd_Vendedor;
    Active := True;
    FetchAll;
    first;
    Application.ProcessMessages;
  end;
end;

procedure TFr_AreaTestes.Pc_BuscarOrigemCliente(Pc_Qry:TSTQuery;Pc_Cd_Vendedor:Integer;Pc_Dt_Inicio,Pc_Dt_Fim:TDateTime);
begin
  with Pc_Qry do
  Begin
    active := False;
    sql.Clear;
    sql.Add(' select clb_nome, DESCRIPTION,SUM(tb_nota_fiscal.nfl_vl_tl_nota) '+
            ' from tb_nota_fiscal '+
            '  inner join tb_pedido '+
            '  on (ped_codigo = nfl_codped) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            '  INNER JOIN tb_customer_origen '+
            '  ON (ID = ped_tp_customer) '+
            ' where (description is not null) '+
            'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
            'AND (PED_CODVDO =:PED_CODVDO) '+
            'AND (PED_TIPO = 1) '+
            ' GROUP BY 1,2');

    ParamByName('DATAINI').AsDateTime := Pc_Dt_Inicio;
    ParamByName('DATAFIM').AsDateTime := Pc_Dt_Fim;
    ParamByName('PED_CODVDO').AsInteger := Pc_Cd_Vendedor;
    Active := True;
    FetchAll;
    first;
  end;
end;

procedure TFr_AreaTestes.Pc_BuscarOrigemGeral(Pc_Qry:TSTQuery;Pc_Dt_Inicio,Pc_Dt_Fim:TDateTime);
begin
  with Pc_Qry do
  Begin
    active := False;
    sql.Clear;
    sql.Add(' select clb_nome,SUM(tb_nota_fiscal.nfl_vl_tl_nota) '+
            ' from tb_nota_fiscal '+
            '  inner join tb_pedido '+
            '  on (ped_codigo = nfl_codped) '+
            '  inner join tb_colaborador '+
            '  on (clb_codigo = ped_codvdo) '+
            ' where (CLB_NOME is not null) '+
            'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM '+
            ' GROUP BY 1 ');
    ParamByName('DATAINI').AsString := DateToStr(E_Data_Ini.Date);
    ParamByName('DATAFIM').AsString := DateToStr(E_Data_Fim.Date);
    Active := True;
    FetchAll;
    first;
  end;
end;

Function TFr_AreaTestes.Fc_CriarAreaOrigemVenda(Fc_Qry:TSTQuery;Fc_Sheet:Variant;Fc_Linha:Integer;Fc_Cd_Vendedor:Integer;Fc_Dt_Inicio,Fc_Dt_Fim:TDateTime):Integer;
Var
  Lc_Contador:Integer;
  Lc_Valor : Real;
  Lc_Titulo:String;
Begin
  Pc_BuscarOrigemVenda(Fc_Qry,Fc_Cd_Vendedor,Fc_Dt_Inicio,Fc_Dt_Fim);
  Result := Fc_Linha;
  with Fc_Qry do
  BEgin
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 1,2,80, 1,'','Origem - Venda - '  + FieldByName('CLB_NOME').AsString);
    Result := Result + 2;
    It_Coord_Inicial := fc_PegaLetraColuna(1) + IntToStr(Result);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 1,1,60, 1,'','Origem do Cliente');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 2,2,20, 3,'','Valor');
    Result := Result + 1;
    Lc_Contador := 1;
    Lc_Valor := 0;
    Application.ProcessMessages;
    if recordCount > 0 then
    Begin
      while not eof do
      Begin
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 1,1,60, 1,'',FieldByName('DESCRIPTION').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 2,2,20, 3,'#.##0,00',FieldByName('SUM').AsFloat);
        Lc_Valor := Lc_Valor + FieldByName('SUM').AsFloat;
        Result := Result + 1;
        Lc_Contador := Lc_Contador  +1;
        Application.ProcessMessages;
        next;
      end;
    end
    else
    Begin
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 1,1,60, 1,'','Sem Informação');
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 2,2,20, 3,'#.##0,00',0);
      Lc_Valor := Lc_Valor + FieldByName('SUM').AsFloat;
      Result := Result + 1;
      Lc_Contador := Lc_Contador  +1;
      Application.ProcessMessages;
    end;
    It_Coord_Final := fc_PegaLetraColuna(2) + IntToStr(Result -1);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 2,2,20, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador-1) +']C:R[-1]C)');
    Lc_Titulo := 'Origem - Venda - '  + Copy(FieldByName('CLB_NOME').AsString,1,20) + ' - R$ ' + FloatToStrF(Lc_Valor,ffNumber,10,2);
    Pc_CriaGrafico(fc_Sheet,It_Top_Grafico1,1,520,340,It_Seq_grafico,Lc_titulo,It_Coord_Inicial,It_Coord_Final);
    It_Top_Grafico1 := It_Top_Grafico1 + 340;
    It_Seq_grafico := It_Seq_grafico + 1;
    Result := Result + 2;
    Application.ProcessMessages;
  end;
end;

Function TFr_AreaTestes.Fc_CriarAreaOrigemCliente(Fc_Qry:TSTQuery;Fc_Sheet:Variant; Fc_Linha:Integer;Fc_Cd_Vendedor:Integer;Fc_Dt_Inicio,Fc_Dt_Fim:TDateTime):Integer;
Var
  Lc_Contador:Integer;
  Lc_Titulo : String;
  Lc_Valor : real;
Begin
  Pc_BuscarOrigemCliente(Fc_Qry,Fc_Cd_Vendedor,Fc_Dt_Inicio,Fc_Dt_Fim);
  Result := Fc_Linha;
  with Fc_Qry do
  BEgin
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 4,5,80, 1,'','Origem Cliente - ' + FieldByName('CLB_NOME').AsString);
    Result := Result + 2;
    It_Coord_Inicial := fc_PegaLetraColuna(4) + IntToStr(Result);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 4,4,60, 1,'','Origem da Venda');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 5,5,20, 3,'','Valor');
    Result := Result + 1;
    Lc_Contador := 1;
    Application.ProcessMessages;
    if recordCount > 0 then
    Begin
      while not eof do
      Begin
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 4,4,60, 1,'',FieldByName('DESCRIPTION').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 5,5,20, 3,'#.##0,00',FieldByName('SUM').AsFloat);
        Lc_Valor := Lc_Valor + FieldByName('SUM').AsFloat;
        Result := Result + 1;
        Lc_Contador := Lc_Contador  +1;
        Application.ProcessMessages;
        next;
      end;
    end
    else
    Begin
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 4,4,60, 1,'','Sem Informação');
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 5,5,20, 3,'#.##0,00',0);
      Lc_Valor := Lc_Valor + FieldByName('SUM').AsFloat;
      Result := Result + 1;
      Lc_Contador := Lc_Contador  +1;
      Application.ProcessMessages;
    end;
    It_Coord_Final := fc_PegaLetraColuna(5) + IntToStr(Result -1);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 5,5,20, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador-1) +']C:R[-1]C)');
    Lc_Titulo := 'Origem Cliente - ' + Copy(FieldByName('CLB_NOME').AsString,1,20) + ' - R$ ' + FloatToStrF(Lc_Valor,ffNumber,10,2);
    Pc_CriaGrafico(fc_Sheet,It_Top_Grafico2,530,530,340,It_Seq_grafico,Lc_titulo,It_Coord_Inicial,It_Coord_Final);
    It_Top_Grafico2 := It_Top_Grafico2 + 340;
    It_Seq_grafico := It_Seq_grafico + 1;
    Result := Result + 2;
    Application.ProcessMessages;
  end;
end;

Function TFr_AreaTestes.Fc_CriarAreaOrigemGeral(Fc_Qry:TSTQuery;Fc_Sheet:Variant; Fc_Linha:Integer;Fc_Dt_Inicio,Fc_Dt_Fim:TDateTime):Integer;
Var
  Lc_Contador:Integer;
  Lc_Titulo : String;
  Lc_Valor : real;
Begin
  Pc_BuscarOrigemGeral(Fc_Qry,Fc_Dt_Inicio,Fc_Dt_Fim);
  Result := Fc_Linha;
  with Fc_Qry do
  BEgin
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 1,1,60, 1,'','Colaborador');
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 2,2,20, 3,'','Valor');
    Result := Result + 1;
    It_Coord_Inicial := fc_PegaLetraColuna(1) + IntToStr(Result);
    Lc_Contador := 1;
    Application.ProcessMessages;
    if recordCount > 0 then
    Begin
      while not eof do
      Begin
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 1,1,60, 1,'',FieldByName('CLB_NOME').AsString);
        Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 2,2,20, 3,'#.##0,00',FieldByName('SUM').AsFloat);
        Lc_Valor := Lc_Valor + FieldByName('SUM').AsFloat;
        Result := Result + 1;
        Lc_Contador := Lc_Contador  +1;
        Application.ProcessMessages;
        next;
      end;
    end
    else
    Begin
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 1,1,60, 1,'','Sem Informação');
      Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 2,2,20, 3,'#.##0,00',0);
      Lc_Valor := Lc_Valor + FieldByName('SUM').AsFloat;
      Result := Result + 1;
      Lc_Contador := Lc_Contador  +1;
      Application.ProcessMessages;
    end;
    It_Coord_Final := fc_PegaLetraColuna(2) + IntToStr(Result -1);
    Pc_PreenceCelulaExcel(ChBx_Formatacao.Checked,Fc_Sheet, Result, 5,5,20, 3,'#.##0,00','=SUM(R[-' + IntToStr(Lc_Contador-1) +']C:R[-1]C)');
    Lc_Titulo := 'Vendas Geral - R$ ' + FloatToStrF(Lc_Valor,ffNumber,10,2);
    Pc_CriaGrafico(fc_Sheet,It_Top_Grafico1,1,1060,680,It_Seq_grafico,Lc_titulo,It_Coord_Inicial,It_Coord_Final);
    Result := Result + 2;
    Application.ProcessMessages;
  end;
end;

procedure TFr_AreaTestes.Pc_CriaGrafico(Pc_Sheet:Variant;Pc_Top,Pc_Left,Pc_Width,Pc_Height,Pc_Seq:Integer; Pc_Titulo,Pc_Inicio,Pc_Fim:String);
var
  Chart : Variant;
BEgin
  // Cria Grafico
  Pc_Sheet.ChartObjects.Add(Pc_Left,Pc_Top,Pc_Width,Pc_Height); // Coordenadas (Left,Top,Width,Height)
  Chart := Pc_Sheet.ChartObjects(Pc_Seq); // Cria o Grafico
  Chart.Chart.ChartType := $00000005; // Tipo do Grafico
  Chart.Chart.ApplyLayout(Cb_Info_Grafico.itemIndex +1, Chart.Chart.ChartType);
  Chart.Chart.HasTitle := True;
  Chart.Chart.ChartTitle.Text := Pc_Titulo;
  Chart.Chart.SeriesCollection.Add(Pc_Sheet.Range[Pc_Inicio,Pc_Fim]);
  Application.ProcessMessages;
end;

procedure TFr_AreaTestes.Pc_GraficosOrigem2(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel);
var
  Lc_Excel, Lc_Sheet, Chart : Variant;
  Lc_Linha : Integer;
  Lc_Linha2 : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Qr_Lista_Vendedor : TSTQuery;
  Lc_Qr_Origem_Cliente : TSTQuery;
  Lc_Qr_Origem_Venda : TSTQuery;
  Lc_VL_Venda : Real;
  Lc_Vl_Devolvido : Real;
  Lc_Vl_Total : Real;
  Lc_Nr_Mes : Integer;
  Lc_Contador : Integer;
  Lc_Registros : Integer;

begin
  //Consulta de Lista de Clietne
  Lc_Qr_Lista_Vendedor := TSTQuery.create(Fr_AreaTestes);
  Lc_Qr_Lista_Vendedor.Database := DM.IBD_Gestao;
  Lc_Qr_Lista_Vendedor.Transaction := DM.IB_Transacao;
  Lc_Qr_Lista_Vendedor.ForcedRefresh := True;

  //Consulta de Origem Clientes
  Lc_Qr_Origem_Cliente := TSTQuery.create(Fr_AreaTestes);
  Lc_Qr_Origem_Cliente.Database := DM.IBD_Gestao;
  Lc_Qr_Origem_Cliente.Transaction := DM.IB_Transacao;
  Lc_Qr_Origem_Cliente.ForcedRefresh := True;

  //Consulta de Origem de Vendas
  Lc_Qr_Origem_Venda   := TSTQuery.create(Fr_AreaTestes);
  Lc_Qr_Origem_Venda.Database := DM.IBD_Gestao;
  Lc_Qr_Origem_Venda.Transaction := DM.IB_Transacao;
  Lc_Qr_Origem_Venda.ForcedRefresh := True;


  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;
  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Origem Venda e Cliente';
  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Origem Venda e Cliente'];
  //Configura as Margens
  Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
  Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
  Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

  Lc_Linha  := 1;
  Lc_Linha2 := 1;
  It_Top_Grafico1 := 1;
  It_Seq_grafico := 1;
  It_Top_Grafico2 := 1;
  Pc_Acompanhamento.visible := True;
  Pc_Progresso.visible := True;
  Pc_Acompanhamento.Caption := 'Listando Vendedores.';
  Application.ProcessMessages;
  Pc_BuscarListaVendedor(Lc_Qr_Lista_Vendedor);
  Pc_Progresso.Progress := 1;
  Pc_Progresso.MinValue := 1;
  Pc_Progresso.MaxValue := Lc_Qr_Lista_Vendedor.RecordCount;
  with Lc_Qr_Lista_Vendedor do
  Begin
    while not Eof do
    Begin
      Pc_Acompanhamento.Caption := 'Processando vendedor: ' + FieldByName('CLB_NOME').AsString;
      Application.ProcessMessages;
      Lc_Linha := Fc_CriarAreaOrigemVenda(Lc_Qr_Origem_Venda, Lc_Sheet, Lc_Linha,FieldByName('CLB_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
      Lc_Linha2 := Fc_CriarAreaOrigemCliente(Lc_Qr_Origem_Venda, Lc_Sheet, Lc_Linha2,FieldByName('CLB_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
      Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
      Application.ProcessMessages;
      Next;
    end;
  end;
  Pc_Acompanhamento.Caption := 'Processando Vendas Geral';
  Application.ProcessMessages;
  Fc_CriarAreaOrigemGeral(Lc_Qr_Origem_Venda,Lc_Sheet,Lc_Linha,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
  //Libera componentes da memoria
  Lc_Qr_Lista_Vendedor.Close;
  freeAndNil(Lc_Qr_Lista_Vendedor);
  Lc_Qr_Origem_Cliente.Close;
  freeAndNil(Lc_Qr_Origem_Cliente);
  Lc_Qr_Origem_Venda.Close;
  freeAndNil(Lc_Qr_Origem_Venda);
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Application.ProcessMessages;
  //Abre o excel
  Lc_Excel.ActiveWindow.Zoom := 65;
  Lc_Excel.Visible := true;
end;

end.
