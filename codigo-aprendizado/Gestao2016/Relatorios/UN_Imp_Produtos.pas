unit UN_Imp_Produtos;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, ExtCtrls, Buttons, DB, prmProdutos, Mask, STQuery, ComCtrls, ComObj, jpeg, Printers, OleServer, Excel2000, Gauges, Grids, DBGrids, QEdit_Setes, QuickRpt, QRPrntr, Un_Fm_ListaEstoques, Un_Fm_ListaMultiEmpresa, Un_RL_ReportProductPriceList, ControllerBase, ControllerMovimentoFinanceiro, Un_imp_produtos_movimento, ControllerCtrlEstoque, Un_RL_ReportVendasItensLucroBruto, prmVendas, CnXlsWriter, ControllerInventario, ControllerEstoque, base_frame_list;

type
  TFr_Imp_Produtos = class(TForm)
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Qr_Tabela: TSTQuery;
    Ds_Empresas: TDataSource;
    Qr_Produto: TSTQuery;
    Qr_Estoque: TSTQuery;
    Qr_Invetario: TSTQuery;
    Ds_Inventario: TDataSource;
    Qr_Del_Inventario: TSTQuery;
    Qr_Acao: TSTQuery;
    Qr_Movim_Custo: TSTQuery;
    Qr_Up_Custo: TSTQuery;
    Pg_Parametros: TPageControl;
    tbs_parametro: TTabSheet;
    Panel3: TPanel;
    TabSheet1: TTabSheet;
    Pnl_Estoque_Inventario: TPanel;
    Dbg_Inventario: TDBGrid;
    tbs_Ordenacao: TTabSheet;
    Panel4: TPanel;
    CB_Ordena: TComboBox;
    Label6: TLabel;
    Sb_Inventario: TSpeedButton;
    sb_estoque: TSpeedButton;
    ChBx_CustoMedio: TCheckBox;
    chbx_AuditoriaEstoque: TCheckBox;
    ChBx_Contagem: TCheckBox;
    Panel2: TPanel;
    Label11: TLabel;
    LBx_TipoRelatorio: TListBox;
    Fm_LME: TFm_ListaMultiEmpresa;
    tbs_parametros: TTabSheet;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    DBLCB_Marca: TDBLookupComboBox;
    DBLCB_Grupos: TDBLookupComboBox;
    DBLCB_SubGrupos: TDBLookupComboBox;
    ChBx_Periodo: TCheckBox;
    DBLCB_Tabela_Preco: TDBLookupComboBox;
    E_BuscaDescricaoProduto: TEdit;
    Grp_Mov_Empresa: TGroupBox;
    DBLCB_Empresa: TDBLookupComboBox;
    Rb_Empresa: TRadioButton;
    Rb_Produto: TRadioButton;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Grp_Vendedor: TGroupBox;
    Rb_Vend_Cliente: TRadioButton;
    Rb_Vend_Pedido: TRadioButton;
    dblcb_Vendedor: TDBLookupComboBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    E_Busca_Local: TEdit;
    Fm_ListaEstoques: TFm_ListaEstoques;
    SB_Cad_produto: TSpeedButton;
    Lb_Nr_Meses_CurvaABC: TLabel;
    ChBx_Est_Min: TCheckBox;
    ChBx_SemMov: TCheckBox;
    chbx_positivo: TCheckBox;
    Chbx_Inativos: TCheckBox;
    E_Curva_Nr_Mes: TEdit_Setes;
    Chbx_AlteracaoPrecoCompra: TCheckBox;
    ChBx_UltimaAlteracaoVenda: TCheckBox;
    Chbx_AnaliseMovimento: TCheckBox;
    Chbx_Vl_Venda_Maior_Zero: TCheckBox;
    chbx_negativo: TCheckBox;
    ChBx_InternetPublished: TCheckBox;
    Pnl_Progresso: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    Panel6: TPanel;
    chbx_zerado: TCheckBox;
    chbx_com_movimento: TCheckBox;
    Panel7: TPanel;
    Chbx_zerar_estoque: TCheckBox;
    E_BuscaCodigoProduto: TEdit;
    Panel8: TPanel;
    E_Dt_movim_Final: TDateTimePicker;
    E_Dt_movim_Inicial: TDateTimePicker;
    Chbx_Periodo_Movimento: TCheckBox;
    Chbx_LimparHistoricoEstoque: TCheckBox;
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_SubGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_GruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure sb_estoqueClick(Sender: TObject);
    procedure Dbg_InventarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_InventarioClick(Sender: TObject);
    procedure DBLCB_MarcaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dblcb_VendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_Cad_produtoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBLCB_EstoqueClick(Sender: TObject);
    procedure ChBx_CustoMedioClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure E_Curva_Nr_MesChange(Sender: TObject);
    procedure Chbx_AnaliseMovimentoClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure LBx_TipoRelatorioClick(Sender: TObject);
    procedure Fm_LMEDblcb_Mha_EmpresaClick(Sender: TObject);
    procedure chbx_AuditoriaEstoqueClick(Sender: TObject);
    procedure ChBx_ContagemClick(Sender: TObject);
    procedure Rb_EmpresaClick(Sender: TObject);
    procedure Rb_ProdutoClick(Sender: TObject);
    procedure Chbx_zerar_estoqueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_BuscaCodigoProdutoExit(Sender: TObject);
    procedure Chbx_Periodo_MovimentoClick(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure Chbx_LimparHistoricoEstoqueClick(Sender: TObject);
  private
    ThreadEstoque: TThread;
    FContagemInventario : Boolean;
    procedure Pc_ProdutosVendidosporMarca (Pc_Operacao,Pc_Caminho:String);
    procedure Pc_Lucratividade (Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ArquivoBalancaToledo(Pc_Operacao,Pc_Caminho:String);
    procedure ExportaArquivoBalancaToledo(Pc_Caminho:String);
    procedure Pc_ArquivoBalancaFilizola(Pc_Operacao,Pc_Caminho:String);
    procedure ExportaArquivoBalancaFilizola(Pc_Caminho:String);
    procedure Pc_ResultadoProdutos(Pc_Operacao,Pc_Caminho:String);
    procedure ExportaResultadoProdutos(Pc_Caminho:String);
    procedure Pc_ArquivoTerminalPreco(Pc_Caminho:String);

    function validarecontagem:Boolean;
    procedure recontagem;

    procedure ExportaConsultaCompras(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
    procedure ExportaConsultaVendas(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
    procedure ExportaConsultaST(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
    procedure ExportaConsultaICMS(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
    procedure ExportaConsultaComissao(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
    procedure ExportaConsultaImpostos(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
    { Private declarations }
  public
    { Public declarations }
    It_Visualizar:Boolean;
    It_Imprimir:Boolean;
    It_Exportar:Boolean;
    iT_INVENTARIAR:Boolean;
    It_estoque:Boolean;
    It_Cd_Inventario : Integer;
    It_Cd_Ult_Inventario : Integer;
    //Calculo do Custo Medio
    It_Cd_CRT : Integer;
    It_Data_Inicio : TDate;
    It_Saldo_Memoria: Currency;
    It_Custo_Memoria: Currency;
    It_Custo_Med_Memoria: Currency;
    CtrlEstoque : TControllerCtrlEstoque;
    Inventario : TControllerInventario;
    Estoque : TControllerEstoque;

    procedure Pc_ConsultaProduto;
    procedure Pc_AtualizaEstoque;
    procedure Pc_IniciaVariaveis;
    function Fc_validaInventario:boolean;

    procedure Pc_AtivarTabelas;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    //CALCULO DO CUSTO MEDIO

    procedure Pc_CadastrodeProdutos(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_SaldodoEstoque(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_Movimentacao(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_TabeladeProdutos(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_CurvaABC(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_Inventario(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_AnalisedeAlteracaodePreconaCompra(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ProdutosMaisVendidos(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ProdutosMaisVendidosVendedor(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_Reposicao(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ConferenciadeEstoque(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_AnalisedeAlteracaodePreconaVenda(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_InventarioFormatocodilheira(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_InventarioFormatoCaderno(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendasPorItem(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_VendaPorItemLucroBruto(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_EstoqueMovimento24Meses(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ExportaEstoqueMovimento24Meses(Pc_Caminho:String);

    procedure Pc_CadastroServicos(Pc_Operacao,Pc_Caminho:String);
    function Pc_ExportarTabelasPreco:Boolean;
    procedure Pc_ExportarAnaliseCompra;
    function Fc_AnaliseCompra():TSTQuery;
    function  Fc_TabelasMultiplas():TSTQuery;
    procedure Pc_TabelaProdutoAgrupada(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_AnaliseCompra(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_ExportaInventarioCordilheira;
    procedure Pc_ExportaItemCordilheira;
    procedure Pc_DefineParametroOrdenacao(Pc_Relatorio:Integer);
    procedure Pc_DefineInventario;
    procedure Pc_ControlaItensIterface;
    procedure Pc_ImagemBotao;
    function getParametros: TParamProdutos;
    function getParametrosVendas: TParamVendas;

    function InnerJoinSql(Parametros:TParamProdutos):String;
    function WhereSql(Parametros:TParamProdutos):String;
    procedure PassarParametros(Consulta:TSTQuery;Parametros:TParamProdutos);
    PROCEDURE ListarEmpresasRazao;
    PROCEDURE ListarEmpresasFantasia;
end;

var
  Fr_Imp_Produtos: TFr_Imp_Produtos;

implementation

uses     un_sistema, Un_DM, UN_RL_TabelaProdutos, UN_RL_CurvaABC, Un_Funcoes, Un_Excel, UN_MSG, UN_RL_Inventario, Un_RL_MovimentoProduto, UN_RL_ANAL_ALT_PRECO, un_RL_ProdutoMaisVendido, Un_RL_Reposicao, Un_rl_Conf_Estoque, Un_Produtos, Un_Pesq_Produto, UN_Principal, env, un_RL_ANAL_ALT_PRECO_VDA, un_Padrao, Un_Regra_Negocio, UN_RL_Inventario_Caderno, Un_RL_Venda_Item, UN_RL_Cadastro_Servicos, RN_Inventario, RN_Estoque, RN_Produto, RN_Compras, UN_RL_Produto_MaisVendido_Vendedor, RN_Empresa, UN_TabelasEmListas, Un_RL_ReportProductCadastro, Un_RL_ReportProductSaldo, un_RL_ReportLucratividade, prmLucratividade, Un_Fc_Sored_Procedures;
{$R *.dfm}


function TFr_Imp_Produtos.getParametros: TParamPRodutos;
begin
  Result := TParamProdutos.Create;
  with Result do
  Begin
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    if ( Fm_ListaEstoques.Dblcb_Estoque.Text <> '' ) then
      CodigoEstoque := Fm_ListaEstoques.Dblcb_Estoque.KeyValue
    else
      CodigoEstoque := 0;

    if ( DBLCB_Tabela_Preco.Text <> '' ) then
      CodigoTabelaPreco := DBLCB_Tabela_Preco.KeyValue
    else
      CodigoTabelaPreco := 0;

    if ( DBLCB_Grupos.Text <> '' ) then
      CodigoGrupo := DBLCB_Grupos.KeyValue
    else
      CodigoGrupo := 0;

    if ( DBLCB_SubGrupos.Text <> '' ) then
      CodigoSubGrupo := DBLCB_SubGrupos.KeyValue
    else
      CodigoSubGrupo := 0;

    if ( DBLCB_Marca.Text <> '' ) then
      CodigoMarca := DBLCB_Marca.KeyValue
    else
      CodigoMarca := 0;

    if ( E_BuscaDescricaoProduto.Text <> '' ) then
        DescricaoProduto := E_BuscaDescricaoProduto.Text
    else DescricaoProduto := '';

    if Rb_Empresa.Checked then TipoEmpresa := '1';
    if Rb_Produto.Checked then TipoEmpresa := '2';

    if Trim(DBLCB_Empresa.Text) <> '' then
      CodigoEmpresa := DBLCB_Empresa.KeyValue
    else
      CodigoEmpresa := 0;

    if Rb_Vend_Cliente.Checked then FiltroVendedor := 'C';

    if Rb_Vend_Pedido.Checked then FiltroVendedor := 'P';

    if Trim(dblcb_Vendedor.Text) <> '' then
      CodigoVendedor := dblcb_Vendedor.KeyValue
    else
      CodigoVendedor := 0;

    EstoqueMinimo := ChBx_Est_Min.Checked;
    EstoquePositivo := chbx_positivo.Checked;
    EstoqueNegativo := chbx_negativo.Checked;
    EstoqueZerado := chbx_zerado.Checked;
    ComMovimentacao := chbx_com_movimento.Checked;
    Inativos := Chbx_Inativos.Checked;

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      CodigoEstabelecimento := Fm_LME.Dblcb_Lista.KeyValue;

    InternetPublished := ChBx_InternetPublished.Checked;

    case CB_Ordena.ItemIndex of
      0:Ordenacao := 'PRO_DESCRICAO';
      1:Ordenacao := 'PRO_CODIGOFAB';
      2:Ordenacao := 'PRO_CODIGO';
    end;
  end;
end;


function TFr_Imp_Produtos.getParametrosVendas: TParamVendas;
begin
  Result := TParamVendas.Create;
  with Result do
  Begin
    TipoDocumento := 2;
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;

    if Fm_LME.chbx_Empresas.Checked then
      CodigoEstabelecimento := 0
    else
      CodigoEstabelecimento := Fm_LME.Dblcb_Lista.KeyValue;

    TipoItem := 'V';
    CodigoEstoque := 0;
    CodigoTabelaPreco := 0;

    if ( DBLCB_Grupos.Text <> '' ) then
      CodigoGrupo := DBLCB_Grupos.KeyValue
    else
      CodigoGrupo := 0;

    if ( DBLCB_SubGrupos.Text <> '' ) then
      CodigoSubGrupo := DBLCB_SubGrupos.KeyValue
    else
      CodigoSubGrupo := 0;

    if ( DBLCB_Marca.Text <> '' ) then
      CodigoMarca := DBLCB_Marca.KeyValue
    else
      CodigoMarca := 0;

    if ( E_BuscaDescricaoProduto.Text <> '' ) then
        DescricaoProduto := E_BuscaDescricaoProduto.Text
    else DescricaoProduto := '';

    if Rb_Empresa.Checked then TipoEmpresa := '1';
    if Rb_Produto.Checked then TipoEmpresa := '2';

    if Trim(DBLCB_Empresa.Text) <> '' then
      CodigoCliente := DBLCB_Empresa.KeyValue
    else
      CodigoCliente := 0;

    if Rb_Vend_Cliente.Checked then FiltroVendedor := 'C';

    if Rb_Vend_Pedido.Checked then FiltroVendedor := 'P';

    if dblcb_Vendedor.Text <> '' then
    Begin
      CodigoVendedorCliente := 0;
      CodigoVendedorPedido := 0;
      if Rb_Vend_Cliente.Checked then
        CodigoVendedorCliente := dblcb_Vendedor.KeyValue
      else
        CodigoVendedorPedido := dblcb_Vendedor.KeyValue;
    end;
  end;

end;

procedure TFr_Imp_Produtos.Pc_DefineInventario;
Begin
  with Qr_Invetario do
  Begin
    if DM.IBT_Consulta.InTransaction then DM.IBT_Consulta.Commit;
    if not DM.IBT_Consulta.InTransaction then DM.IBT_Consulta.StartTransaction;
    Active := False;
    ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
    Last;
  End;
end;


procedure TFr_Imp_Produtos.Pc_IniciaVariaveis;
Begin
  Pg_Parametros.ActivePage := tbs_parametros;
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  LBx_TipoRelatorio.ItemIndex:=0;
  LBx_TipoRelatorioClick(Self);
  DBLCB_Tabela_Preco.KeyValue := 1;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  E_Dt_movim_Inicial.Date := Date;
  E_Dt_movim_Final.Date := Date;
  Fm_ListaEstoques.AtivaLista(Gb_CodMha);
  Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque; //DM.Qr_Estoques.FIELDBYNAME('ETS_CODIGO').AsInteger;
  LBx_TipoRelatorioClick(Self);
end;

procedure TFr_Imp_Produtos.Pc_AtivarTabelas;
Begin
  DM.Qr_Estoques.Active:=True;
  DM.Qr_Tabelas.Active:=True;
  DBLCB_Tabela_Preco.KeyValue := DM.Qr_Tabelas.FieldByname('TPR_CODIGO').AsInteger;
  DM.Qr_Grupo.Active:=True;
  DM.Qr_SubGrupo.Active:=True;
  DM.Qr_MarcaProduto.Active:=True;
  Pc_DefineInventario;
  DM_ListaConsultas.Pc_ListaVendedor;
end;






function TFr_Imp_Produtos.Fc_validaInventario:boolean;
Var
  Lc_Sqltxt : String;
  Lc_TipoCusto : String;
  Lc_Arquivoerro:TextFile;
  Lc_caminhoErro:String;
  Lc_Aux : String;
Begin
  Result := True;
  exit;
  {
  IF trim(Fm_ListaEstoques.DBLCB_Estoque.Text)='' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor escolha um estoque para efetuar o inventário.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    exit;
  end;


  Dm.Qr_Acao.Active := False;
  Dm.Qr_Acao.SQL.clear;
  Lc_Sqltxt := 'SELECT PRO_CODIGO,PRO_CODIGOFAB,PRO_DESCRICAO '+
               'FROM TB_PRODUTO '+
               '  INNER JOIN TB_ESTOQUE '+
               '  ON (EST_CODPRO = PRO_CODIGO) '+
               'WHERE (EST_CODETS =:ETS_CODIGO) AND (EST_QTDE > 0) ';

  IF Fc_Tb_Geral('L','PRO_G_CUSTO_INVENTARIO','') = 'C' THEN
    Begin
    Lc_TipoCusto := 'Preço de Custo';
    Lc_Sqltxt := Lc_Sqltxt + ' AND (PRO_VL_CUSTO <= 0) ';
    end
  else
    Begin
    Lc_TipoCusto := 'Custo Real';
    Lc_Sqltxt := Lc_Sqltxt + ' AND (PRO_VL_CUSTOMED <= 0) ';
    end;
  Dm.Qr_Acao.sql.Add(Lc_Sqltxt);
  Dm.Qr_Acao.ParamByName('ETS_CODIGO').AsInteger := Fm_ListaEstoques.DBLCB_Estoque.KeyValue;
  Dm.Qr_Acao.Active := True;
  Dm.Qr_Acao.FetchAll;
  Dm.Qr_Acao.First;
  IF (Dm.Qr_Acao.recordcount > 0) then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Existem produtos com quantidade maior que Zero e '+EOLN+
                   'com o '+ Lc_TipoCusto + ' igual a Zero.'+EOLN+
                   'Por favor acerte estes valores antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    //Arquivo do Inventario sem o valor do custo
    Lc_caminhoErro := GbPathExe + '\ProdutoSemcustoQtde.txt';
    AssignFile (Lc_Arquivoerro, Lc_caminhoErro );
    Rewrite ( Lc_Arquivoerro);
    while not Dm.Qr_Acao.Eof do
      Begin
      //Código alfanumérico do item
      Lc_Aux := Copy(Dm.Qr_Acao.fieldbyname('PRO_CODIGOFAB').AsString,1,15);
      Lc_Aux := Fc_CriaEspaco(Lc_Aux,15);
      Write (Lc_Arquivoerro,Lc_Aux);
      //DESCRICAO DO PRODUTO
      Lc_Aux := Dm.Qr_Acao.fieldbyname('PRO_DESCRICAO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);
      Dm.Qr_Acao.Next;
      end;
    CloseFile(Lc_Arquivoerro);
    Pc_Executar_Arquivo(Lc_caminhoErro);
    Result:=false;
    exit;
    end;
  }
end;



procedure TFr_Imp_Produtos.Fm_LMEDblcb_Mha_EmpresaClick(Sender: TObject);
begin
  Fm_ListaEstoques.AtivaLista(DM.Qr_Estabelecimento.FieldByname('EMP_CODIGO').AsInteger);
  if Fm_ListaEstoques.Dblcb_Estoque.Text <> '' then
  Begin
    Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
    Pc_DefineInventario;
  End;
end;

procedure TFr_Imp_Produtos.Pc_AtualizaEstoque;
Var
  I,J : Integer;
  Lc_Saldo_Movimento    : Real;
  Lc_Saldo_Inventario : real;
  Lc_Saldo_Geral : Real;

begin
  Pnl_Progresso.Visible := True;
  CtrlEstoque.AjustaGenerator;

  CtrlEstoque.Grupo := 0;
  CtrlEstoque.SubGrupo := 0;
  CtrlEstoque.Marca := 0;
  CtrlEstoque.CodigoProduto := 0;
  CtrlEstoque.DescricaoProduto := '';

  Pc_DefineInventario;
  if (not Qr_Invetario.Active) or (Qr_Invetario.RecordCount = 0) then
    CtrlEstoque.CodigoInventario := 0
  else
    CtrlEstoque.CodigoInventario := Qr_Invetario.FieldByName('IVT_CODIGO').AsInteger;

  if DBLCB_Grupos.Text  <> '' then
    CtrlEstoque.Grupo := Fr_Imp_Produtos.DBLCB_Grupos.KeyValue;

  if DBLCB_SubGrupos.Text <> '' then
    CtrlEstoque.SubGrupo := Fr_Imp_Produtos.DBLCB_SubGrupos.KeyValue;

  if Fr_Imp_Produtos.DBLCB_Marca.Text <> '' then
    CtrlEstoque.Marca := Fr_Imp_Produtos.DBLCB_Marca.KeyValue;

  if E_BuscaCodigoProduto.Text <> '' then
    CtrlEstoque.CodigoProduto := StrToIntDef(E_BuscaCodigoProduto.Text,0);

  if E_BuscaDescricaoProduto.Text <> '' then
    CtrlEstoque.DescricaoProduto := E_BuscaDescricaoProduto.Text;

  CtrlEstoque.Estoque := Fm_ListaEstoques.Dblcb_Estoque.KeyValue;
  //Determina a Data Do ultuimo Inventario
  Inventario.DataUltimoInventario := StrToDate('01/01/1900');
  if Qr_Invetario.Active then
    if Qr_Invetario.RecordCount > 0 then
      Inventario.DataUltimoInventario := Qr_Invetario.FieldByName('IVT_DATA').AsDateTime;

  //Este bloco define quantos produtos seráo recontados dependendo da escolha
  //Desde o ultimo inventario
  //no intervalo do periodo escolhido
  //Depois dos produos selecionados contaremos toda a movimentação do produto, mas não de todos os produtos.
  if FContagemInventario then
  Begin
    //Aqui deve pegar todos os produtos para inventariar
    CtrlEstoque.getListaProdutoParaInventario;
  End
  else
  Begin
    if Chbx_Periodo_Movimento.Checked then
    Begin
      CtrlEstoque.DataInicial := E_Dt_movim_Inicial.Date;
      CtrlEstoque.DataFinal   := E_Dt_movim_Final.Date;
    End
    else
    Begin
      CtrlEstoque.DataInicial := Inventario.DataUltimoInventario;
      CtrlEstoque.DataFinal := StrToDate('31/12/9999');
    End;
    //Aqui pega a lista dos produtos que movimentaram
    CtrlEstoque.getListaProdutoSimples;
  End;


  Pnl_Progresso.Visible := True;
  Gg_Progresso.progress := 0;
  Gg_Progresso.MinValue := 0;
  Gg_Progresso.MaxValue := CtrlEstoque.ListaProdutoSimples.count;
  Gg_Progresso.Update;
  //SÓ desativa se não for contagem individual;
  if CtrlEstoque.ListaProdutoSimples.count > 1 then
    CtrlEstoque.DesativarTrighers;
  //Depois que pegou a lista de produtos ajustar as datas para pegar toda a movimentação de cada produto selecionado
  CtrlEstoque.DataInicial := Inventario.DataUltimoInventario;
  if FContagemInventario then
    CtrlEstoque.DataFinal := Date
  else
    CtrlEstoque.DataFinal := StrToDate('31/12/9999');

  For I := 0 to CtrlEstoque.ListaProdutoSimples.count -1 do
  Begin
    //if CtrlEstoque.ListaProdutoSimples[I].Codigo = 7052 then
    //Begin //INICIO DO LOOP PARA PRODUTO UNICO EM TESTE

      Lb_Processamento.Caption := concat('Processando produtos: ',I.ToString(), ' de ', Gg_Progresso.MaxValue.ToString());
      Lb_Processamento.Update;

      Inventario.CodigoProduto := CtrlEstoque.ListaProdutoSimples[I].Codigo;
      Inventario.CodigoEstoque := CtrlEstoque.ListaProdutoSimples[I].Estoque;
      Inventario.Estabelecimento := Gb_Codmha;
      //Pega o Saldo do Inventario
      Lc_Saldo_Inventario := Inventario.GetUltimoSaldo;

      if Chbx_LimparHistoricoEstoque.Checked then
      Begin
        CtrlEstoque.CodigoProduto := CtrlEstoque.ListaProdutoSimples[I].Codigo;
        CtrlEstoque.Estoque       := CtrlEstoque.ListaProdutoSimples[I].Estoque;
        CtrlEstoque.LimparTodoHistoricoByProduto;
        Pc_Log_Sistema(Gb_CodMha,
                       GB_Cd_Usuario,
                       Now,
                       'Recontagem Estoque',
                       0,
                       'Limpar todo histórico',
                       'Produto '+ CtrlEstoque.CodigoProduto.toString() );

      End;

      if chbx_AuditoriaEstoque.Checked then
      Begin
        //Delete a movimentação para que na proxima funcão seja totalmente preenchida
        CtrlEstoque.CodigoProduto := CtrlEstoque.ListaProdutoSimples[I].Codigo;
        CtrlEstoque.Estoque := CtrlEstoque.ListaProdutoSimples[I].Estoque;
        CtrlEstoque.DataInventario := Inventario.DataUltimoInventario;
        CtrlEstoque.RecontagemDeletarByProduto;

        //Garante que os itens do pedido estão na tabela de Estoque
        CtrlEstoque.CodigoProduto := CtrlEstoque.ListaProdutoSimples[I].Codigo;
        CtrlEstoque.Estoque := CtrlEstoque.ListaProdutoSimples[I].Estoque;
        CtrlEstoque.RecontagemListarMovimento;
        //Aqui grava a movimentação novamente conforme a lista de Movimento
        for J := 0 to CtrlEstoque.Lista.Count - 1 do
        Begin
          CtrlEstoque.ClonarObj(CtrlEstoque.Lista[J],CtrlEstoque.Registro);
         if (CtrlEstoque.ListaProdutoSimples[I].Composicao = '1') or
             (CtrlEstoque.ListaProdutoSimples[I].Composicao = '3') or
             (CtrlEstoque.ListaProdutoSimples[I].Composicao = '6') then
          Begin
           CtrlEstoque.Insert;
          End;
          if (CtrlEstoque.ListaProdutoSimples[I].Composicao = '2') or
             (CtrlEstoque.ListaProdutoSimples[I].Composicao = '3') then
          Begin
           CtrlEstoque.Recontagem;
          End;
        End;
        //Precisa lista o movimento por que não é deleta o avulso, mas a contagem deve conter os avulsos
        CtrlEstoque.ListarMovimento;
        Lc_Saldo_Movimento := CtrlEstoque.getSaldoByListarMovimento;
      end
      else
      Begin
        //Apenas Lista o Que está no banco sem excluir nada (Sem Auditoria)
        CtrlEstoque.CodigoProduto := CtrlEstoque.ListaProdutoSimples[I].Codigo;
        CtrlEstoque.Estoque := CtrlEstoque.ListaProdutoSimples[I].Estoque;
        CtrlEstoque.ListarMovimento;
        Lc_Saldo_Movimento := CtrlEstoque.getSaldoByListarMovimento;
      End;

      Lc_Saldo_Geral := Lc_Saldo_Movimento +  Lc_Saldo_Inventario;

      if Chbx_zerar_estoque.Checked then
      Begin
        Estoque.registro.QtdeDisp       := Lc_Saldo_Geral;
        Estoque.Registro.CodigoProduto  := CtrlEstoque.ListaProdutoSimples[I].Codigo;
        Estoque.Registro.CodigoEstoque  := CtrlEstoque.ListaProdutoSimples[I].Estoque;
        Estoque.ZerarEstoque;
        Lc_Saldo_Geral := 0;
      End;

      Estoque.Clear;
      Estoque.Registro.CodigoEstoque := CtrlEstoque.ListaProdutoSimples[I].Estoque;
      Estoque.Registro.CodigoProduto := CtrlEstoque.ListaProdutoSimples[I].Codigo;
      Estoque.Registro.QtdeDisp := Lc_Saldo_Geral ;
      Estoque.updateBalance;


    //End; //FIM DO LOOP PARA PRODUTO UNICO EM TESTE

    Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
    Application.ProcessMessages;
  end;
  Pc_AtivarTabelas;
  CtrlEstoque.AtivarTrighers;
  Pnl_Progresso.Visible := False;
  Application.ProcessMessages;
end;

procedure TFr_Imp_Produtos.Pc_ConsultaProduto;
VaR
  SqlTxt:String;
  PGrupo,PSubGrupo:Boolean;
Begin
  Qr_Tabela.Close;
  Qr_Tabela.SQL.Clear;
  SqlTxt:='SELECT Tb_produto.PRO_CODIGO, Tb_produto.PRO_DESCRICAO, '+
          'Tb_produto.PRO_CODGRUPO, Tb_produto.PRO_CODSUBGRUPO, '+
          'Tb_produto.PRO_VLVENDA, Tb_produto.PRO_VLVENDA_2,Tb_produto.PRO_VLVENDA_3,Tb_produto.PRO_VLVENDA_4,Tb_grupos.GRU_DESCRI, '+
          'Tb_subgrupos.SUB_DESCR '+
          'FROM TB_GRUPOS Tb_grupos '+
          '  INNER JOIN TB_SUBGRUPOS Tb_subgrupos '+
          '  ON  (Tb_subgrupos.SUB_CODGRUPO = Tb_grupos.GRU_CODIGO) '+
          '  INNER JOIN TB_PRODUTO Tb_produto '+
          '  ON  (Tb_produto.PRO_CODSUBGRUPO = Tb_subgrupos.SUB_CODIGO) '+
          'WHERE (PRO_ATIVO=''S'')';


  if Fr_Imp_Produtos.DBLCB_Grupos.Text ='' then PGrupo := False else PGrupo := True;
  if Fr_Imp_Produtos.DBLCB_SubGrupos.Text ='' then PSubGrupo := False else PSubGrupo := True;


  if PGrupo then SqlTxt := SqlTxt +'AND (PRO_CODGRUPO =:CODGRUPO) ';
  if PSubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSUBGRUPO =:CODSUBGRUPO) ';


  Qr_Tabela.SQL.Add(SqlTxt+' ORDER BY GRU_DESCRI,SUB_DESCR,PRO_DESCRICAO');
  if PGrupo then Qr_Tabela.ParamByName('CODGRUPO').AsInteger:=Fr_Imp_Produtos.DBLCB_Grupos.KeyValue;
  if PSubGrupo then Qr_Tabela.ParamByName('CODSUBGRUPO').AsInteger:=Fr_Imp_Produtos.DBLCB_SubGrupos.KeyValue;


  Qr_Tabela.Open;
  Qr_Tabela.Last;
  Qr_Tabela.RecordCount;
  Screen.Cursor:=crDefault;

end;

procedure TFr_Imp_Produtos.Pc_CadastrodeProdutos(Pc_Operacao,Pc_Caminho:String);
Var
  Form : TRL_ReportProductCadastro;
Begin
  Try
    Form := TRL_ReportProductCadastro.Create(Self);
    Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Qrpt.ReportTitle := 'CADASTRO DE PRODUTOS';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.Buscar;
      Fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;
end;

procedure TFr_Imp_Produtos.Pc_SaldodoEstoque(Pc_Operacao,Pc_Caminho:String);
Var
  Form : TRL_ReportProductSaldo;
  Lc_Escolha : Integer;
Begin
  Try
    Form := TRL_ReportProductSaldo.Create(nil);
    Form.Parametros := getParametros;
    Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                                'Defina o tipo do Custo.',
                              ['CUSTO REAL','PREÇO DE CUSTO','ULTIMO CUSTO'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    case Lc_Escolha of
      0:Form.Parametros.CampoCusto := 'PRO_VL_CUSTOMED AS PRO_VL_CUSTO';
      1:Form.Parametros.CampoCusto := 'PRO_VL_CUSTO AS PRO_VL_CUSTO';
      2:Form.Parametros.CampoCusto := 'PRO_VL_CUSTO_LAST AS PRO_VL_CUSTO';
    end;

    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Qrpt.ReportTitle := 'CADASTRO DE PRODUTOS';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.IniciaVariaveis;
      Form.Buscar;
      Fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;
end;

procedure TFr_Imp_Produtos.Pc_Movimentacao(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Escolha : Integer;
  Form : TFr_imp_produtos_movimento;
Begin
  Try
    Form := TFr_imp_produtos_movimento.Create(nil);
    Form.Rg_Tipo.ItemIndex := -1;
    Form.ShowModal;
    Lc_Escolha := Form.Rg_Tipo.ItemIndex;
  Finally
    FreeAndNil(Form);
  End;
  if Lc_Escolha >= 0 then
  Begin
    try
      if not Assigned(RL_MovimentoProduto) then Application.CreateForm(TRL_MovimentoProduto,RL_MovimentoProduto);
      RL_MovimentoProduto.DataInventario := StrToDate('01/01/1800');
      if Qr_Invetario.Active then
      Begin
        RL_MovimentoProduto.DataInventario := Qr_Invetario.FieldByName('IVT_DATA').AsDateTime;
      End;

      if Pc_Operacao = 'I' then
      Begin
        RL_MovimentoProduto.It_Tp_Movimento := Lc_Escolha;
        RL_MovimentoProduto.Qrpt.Preview;
      end
      else
      Begin
        RL_MovimentoProduto.It_Tp_Movimento := Lc_Escolha;
        RL_MovimentoProduto.Pc_Buscar;
        Fr_Excel.Pc_Excel(RL_MovimentoProduto.Qr_Produtos,Pc_CAminho);
      end;
    finally
      RL_MovimentoProduto.Close;
    end;
  end;
end;

procedure TFr_Imp_Produtos.Pc_TabeladeProdutos(Pc_Operacao,Pc_Caminho:String);
Var
  Form : TRL_ReportProductPriceList;
Begin
  Try
    Form := TRL_ReportProductPriceList.Create(Self);
    Form.Parametros := getParametros;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Qrpt.ReportTitle := 'TABELA DE PREÇO';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.Buscar;
      Fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;

end;

procedure TFr_Imp_Produtos.Pc_CurvaABC(Pc_Operacao,Pc_Caminho:String);
Begin
  try
    if not Assigned(RL_CurvaABC ) then Application.CreateForm(TRL_CurvaABC,RL_CurvaABC);
    if Pc_Operacao = 'I' then
      Begin
      RL_CurvaABC.Qrpt.Preview;
      end
    else
      Begin
      RL_CurvaABC.Pc_Buscar;
      Fr_Excel.Pc_Excel(RL_CurvaABC.Qr_ABC,Pc_CAminho);
      end;
  finally
    RL_CurvaABC.Close;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Imp_Produtos.Pc_Inventario;
Begin
  try
    if not Assigned(RL_Inventario ) then Application.CreateForm(TRL_Inventario,RL_Inventario);
    if Pc_Operacao = 'I' then
    Begin
      RL_Inventario.Qrpt.Preview;
    end
    else
    Begin
      RL_Inventario.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Inventario.Qr_Produtos,Pc_CAminho);
    end;
  Finally
    RL_Inventario.Close;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Imp_Produtos.Pc_AnalisedeAlteracaodePreconaCompra;
Begin
  try
    if not Assigned(RL_ANAL_ALT_PRECO ) then Application.CreateForm(TRL_ANAL_ALT_PRECO,RL_ANAL_ALT_PRECO);
    if Pc_Operacao = 'I' then
      Begin
      RL_ANAL_ALT_PRECO.Qrpt.Preview;
      end
    else
      Begin
      RL_ANAL_ALT_PRECO.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_ANAL_ALT_PRECO.Qr_Produtos,Pc_CAminho);
      end;
  Finally
    RL_ANAL_ALT_PRECO.Close;
    Screen.Cursor:=crDefault;
    Pc_AtivarTabelas;
  end;
end;

procedure TFr_Imp_Produtos.Pc_ProdutosMaisVendidos;
Var
  Lc_Escolha : Integer;
Begin
  Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                              'Escolha o Tipo de Ordenação.',
                              ['VALOR','QUANTIDADE','CANCELAR'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  if Lc_Escolha < 2 then
    Begin
    try
      if not Assigned(RL_Produto_MaisVendido ) then Application.CreateForm(TRL_Produto_MaisVendido,RL_Produto_MaisVendido);
      RL_Produto_MaisVendido.It_Tp_Ordenacao := Lc_Escolha;
      if Pc_Operacao = 'I' then
        Begin
        RL_Produto_MaisVendido.Qrpt.Preview;
        end
      else
        Begin
        RL_Produto_MaisVendido.Pc_Busca;
        Fr_Excel.Pc_Excel(RL_Produto_MaisVendido.Qr_Produtos,Pc_CAminho);
        end;
    Finally
        RL_Produto_MaisVendido.Close;
        Screen.Cursor:=crDefault;
    end;
    end;
end;

procedure TFr_Imp_Produtos.Pc_ProdutosMaisVendidosVendedor(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Escolha : Integer;
Begin
  Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                              'Escolha o Tipo de Ordenação.',
                              ['VALOR','QUANTIDADE','CANCELAR'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  if Lc_Escolha < 2 then
    Begin
    try
      if not Assigned(RL_Produto_MaisVendido_Vendedor ) then Application.CreateForm(TRL_Produto_MaisVendido_Vendedor,RL_Produto_MaisVendido_Vendedor);
      RL_Produto_MaisVendido_Vendedor.It_Tp_Ordenacao := Lc_Escolha;
      if Pc_Operacao = 'I' then
        Begin
        RL_Produto_MaisVendido_Vendedor.Qrpt.Preview;
        end
      else
        Begin
        RL_Produto_MaisVendido_Vendedor.Pc_Busca;
        Fr_Excel.Pc_Excel(RL_Produto_MaisVendido_Vendedor.Qr_Produtos,Pc_CAminho);
        end;
    Finally
        RL_Produto_MaisVendido_Vendedor.Close;
        Screen.Cursor:=crDefault;
    end;
    end;
end;

procedure TFr_Imp_Produtos.Pc_Reposicao(Pc_Operacao,Pc_Caminho:String);
Begin
  try
    if not Assigned(RL_Reposicao ) then Application.CreateForm(TRL_Reposicao,RL_Reposicao);
    if Pc_Operacao = 'I' then
      Begin
      RL_Reposicao.Qrpt.Preview;
      end
    else
      Begin
      RL_Reposicao.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Reposicao.Qr_Produtos,Pc_CAminho);
      end;
  Finally
      RL_Reposicao.Close;
      Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Imp_Produtos.Pc_ConferenciadeEstoque(Pc_Operacao,Pc_Caminho:String);
Begin
  try
    if not Assigned(RL_Conf_Estoque ) then Application.CreateForm(TRL_Conf_Estoque,RL_Conf_Estoque);
    if Pc_Operacao = 'I' then
      Begin
      RL_Conf_Estoque.Qrpt.Preview;
      end
    else
      Begin
      RL_Conf_Estoque.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Conf_Estoque.Qr_Produtos,Pc_CAminho);
      end;
  Finally
      RL_Conf_Estoque.Close;
      Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Imp_Produtos.Pc_AnalisedeAlteracaodePreconaVenda(Pc_Operacao,Pc_Caminho:String);
Begin
  try
    if not Assigned(RL_ANAL_ALT_PRECO_VDA ) then Application.CreateForm(TRL_ANAL_ALT_PRECO_VDA,RL_ANAL_ALT_PRECO_VDA);
    if Pc_Operacao = 'I' then
      Begin
      RL_ANAL_ALT_PRECO_VDA.Qrpt.Preview;
      end
    else
      Begin
      RL_ANAL_ALT_PRECO_VDA.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_ANAL_ALT_PRECO_VDA.Qr_Produtos,Pc_CAminho);
      end;
  Finally
    RL_ANAL_ALT_PRECO_VDA.Close;
    Screen.Cursor:=crDefault;
    Pc_AtivarTabelas;
  end;
end;

procedure TFr_Imp_Produtos.Pc_InventarioFormatocodilheira(Pc_Operacao,Pc_Caminho:String);
Begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                   'Este relatório só pode ser exportado.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end
  else
  Begin
    Pc_ExportaInventarioCordilheira;
    Pc_ExportaItemCordilheira;
    MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                   'Verifique os seguinte arquivos e envie-os ao Contador.'+EOLN+EOLN+
                   'C:\ESTOQUE.TXT'+EOLN+
                   'C:\ITEM.TXT'+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end;
end;

procedure TFr_Imp_Produtos.Pc_InventarioFormatoCaderno(Pc_Operacao,Pc_Caminho:String);
Begin
  try
    if not Assigned(RL_Inventario_Caderno ) then Application.CreateForm(TRL_Inventario_Caderno,RL_Inventario_Caderno);
    if Pc_Operacao = 'I' then
    Begin
      RL_Inventario_Caderno.Qrpt.Preview;
    end
    else
    Begin
      RL_Inventario_Caderno.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Inventario_Caderno.Qr_Produtos,Pc_CAminho);
    end;
  Finally
    RL_Inventario_Caderno.Close;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Imp_Produtos.Pc_VendaPorItemLucroBruto(Pc_Operacao,
  Pc_Caminho: String);
Var
  Form : TRL_ReportVendasItensLucroBruto;
begin
  Try
    Form  := TRL_ReportVendasItensLucroBruto.Create(Self);
    Form.Parametros := getParametrosVendas;
    if Pc_Operacao = 'I' then // IMPRIMIR
    Begin
      Form.Parametros.TipoItem := 'V';
      Form.Qrpt.ReportTitle := 'VENDA POR ITEM X LUCRO BRUTO';
      Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      Form.Buscar;
      fr_Excel.Pc_Excel(Form.Qr_Consulta,Pc_Caminho);
    end;
  finally
    Form.Close;
    FreeAndNil(Form);
  end;
end;

procedure TFr_Imp_Produtos.Pc_VendasPorItem(Pc_Operacao,Pc_Caminho:String);
Begin
  try
    if not Assigned(RL_Venda_Item ) then Application.CreateForm(TRL_Venda_Item,RL_Venda_Item);
    if Pc_Operacao = 'I' then
    Begin
      RL_Venda_Item.Qrpt.Preview;
    end
    else
    Begin
      RL_Venda_Item.Pc_BuscarProdutos;
      Fr_Excel.Pc_Excel(RL_Venda_Item.Qr_Vendas,Pc_CAminho);
    end;
  Finally
    RL_Venda_Item.Close;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_Imp_Produtos.Rb_EmpresaClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
    ListarEmpresasRazao
  else
    ListarEmpresasFantasia;
end;

procedure TFr_Imp_Produtos.Rb_ProdutoClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
    ListarEmpresasRazao
  else
    ListarEmpresasFantasia;
end;

procedure TFr_Imp_Produtos.recontagem;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    Pc_AtualizaEstoque;
    Fm_ListaEstoques.AtivaLista(Gb_CodMha);
    Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Processo concluído com sucesso.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_Imp_Produtos.Pc_CadastroServicos(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TForm;
begin
  Lc_Rel := TForm.Create(RL_Cadastro_Servicos);
  Application.CreateForm(TRL_Cadastro_Servicos, Lc_Rel);
  with TRL_Cadastro_Servicos(Lc_Rel) do
    Begin
    if Pc_Operacao = 'I' then
      Begin
      Qrpt.Preview;
      end
    else
      Begin
      Pc_Busca;
      Fr_Excel.Pc_Excel(Qr_Produtos,Pc_CAminho);
      end;
    end;
  FreeAndNil(Lc_Rel);
end;

function TFr_Imp_Produtos.Pc_ExportarTabelasPreco:Boolean;
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_Coluna: Integer;
  Lc_StrCell: string;
  Lc_Texto : String;
  Lc_Qry : TSTQuery;
begin
  Try
    Result := False;
    Lc_Qry := Fc_TabelasMultiplas;
    if Lc_Qry.RecordCount > 0 then
    Begin
      Result := TRue;
      //cria a aplicação
      Lc_Excel := CreateOleObject('Excel.Application');
      //adiciona pasta de trabalho
      Lc_Excel.WorkBooks.Add;

      //planilha recebendo variável nome
      Lc_Excel.WorkSheets[1].Name := 'Periodo';

      //Repassando variável
      Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
      Pc_AtivaEstabelecimento;
      //Cabeçalho
      Lc_StrCell := 'A1';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;

      Lc_StrCell := 'A2';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' + DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString;

      Lc_StrCell := 'A3';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' +
                                                       DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' +
                                                       DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString;
      Lc_StrCell := 'A4';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'FONE: '+ fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString) + ' - ' +
                                                       'FAX: '+ fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FAX').AsString);

      //Código
      Lc_StrCell := 'A6';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Font.Bold := true;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Interior.ColorIndex := -0.149998474074526;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'Código ';
      //Código de Fabrica
      Lc_StrCell := 'B6';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Font.Bold := true;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'Código de Fábrica';
      //Descrição
      Lc_StrCell := 'C6';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Font.Bold := true;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'Descrição ';
      //Grupo
      Lc_StrCell := 'D6';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Font.Bold := true;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'Grupo ';
      //Subgrupo
      Lc_StrCell := 'E6';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Font.Bold := true;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'SubGrupo ';
      //Medida
      Lc_StrCell := 'F6';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Font.Bold := true;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'Unidade ';

      Lc_Linha := 6;
      Lc_Coluna := 7;
      with DM.Qr_Tabelas do
      Begin
        First;
        while not eof do
        Begin
          //Tabela de Preço
          Lc_StrCell := Fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Lc_Linha);
          Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
          Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
          Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Font.Bold := true;
          Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('TPR_NOME').AsString;
          next;
          inc(Lc_Coluna);
        end;
      end;

      with Lc_Qry do
      Begin
        Active := True;
        FetchAll;
        Gg_Progresso.Progress := 0;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := RecordCount;
        Pnl_Progresso.Visible := true;
        Pnl_Progresso.Update;
        First;
        Lc_Linha := 7;
        while not Eof do
        begin
          //Tabela de Preços
          for Lc_Coluna := 1 to Fields.Count do
          begin
            try
              Lc_StrCell := fc_PegaLetraColuna(Lc_Coluna) + IntToStr(Lc_Linha);
              Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
              Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
              if (not Fields.Fields[Lc_Coluna].IsNull) then
              Begin
                if (Fields.Fields[Lc_Coluna].DataType = ftDate) or
                   (Fields.Fields[Lc_Coluna].DataType = ftDateTime) then
                Begin
                  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := AnsiString(DateTimeToStr(Fields.Fields[Lc_Coluna].AsDateTime));
                End
                else
                Begin
                  if  (Fields.Fields[Lc_Coluna].DataType = ftFloat) or
                      (Fields.Fields[Lc_Coluna].DataType = ftBCD) or
                      (Fields.Fields[Lc_Coluna].DataType = ftCurrency) or
                      (Fields.Fields[Lc_Coluna].DataType = ftFloat) or
                      (Fields.Fields[Lc_Coluna].DataType = ftFMTBcd) then
                  begin
                    Lc_Sheet.Range[Lc_StrCell, Lc_StrCell]. Value := Fields.Fields[Lc_Coluna - 1].AsFloat;
                  end
                  else
                  Begin
                    if (Fields.Fields[Lc_Coluna].DataType = ftInteger) or
                      (Fields.Fields[Lc_Coluna].DataType = ftSmallint) then
                      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value :=  Fields.Fields[Lc_Coluna - 1].AsInteger
                    else
                      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value :=  Fields.Fields[Lc_Coluna - 1].AsString;
                  End;
                End;
              end;
            except
              on E: Exception do
                ShowMessage('Erro: ' + E.Message + ' / '+ Fields.Fields[Lc_Coluna - 1].AsString);
            end;
          end;
          Inc(Lc_Linha);
          Next;
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Application.ProcessMessages;
        end;
        Pnl_Progresso.Visible := False;
      end;
      Lc_Excel.Visible := true;
    End;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry);
  End;
end;



function TFr_Imp_Produtos.Fc_TabelasMultiplas():TSTQuery;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo, Lc_Marca,Lc_Fornece, Lc_Produto: Boolean;
  Lc_I : Integer;
begin
  if DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
  if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
  if DBLCB_Marca.Text ='' then Lc_Marca := False else Lc_Marca := True;
  if DBLCB_Empresa.Text ='' then Lc_Fornece := False else Lc_Fornece := True;
  if E_BuscaDescricaoProduto.Text ='' then Lc_Produto := False else Lc_Produto := True;
  SqlTxt := 'SELECT distinct PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO,  GRP_DESCRICAO, SBG_DESCRICAO, MED_DESCRICAO ';
  Lc_I := 1;
  with DM.Qr_Tabelas do
  Begin
    First;
    while not eof do
      Begin
      SqlTxt := SqlTxt + ',TB_' + IntToStr(Lc_I) + '.prc_vl_vda preco_'+ IntToStr(Lc_I) + ' ';
      next;
      Inc(Lc_I);
      end;
    end;

  SqlTxt := SqlTxt +'FROM tb_produto '+
                    '    INNER JOIN TB_GRUPOS Tb_grupos '+
                    '    ON  (Tb_produto.PRO_CODGRP = Tb_grupos.GRP_CODIGO) '+
                    '    INNER JOIN TB_SUBGRUPOS Tb_subgrupos '+
                    '    ON  (Tb_produto.PRO_CODSBG = Tb_subgrupos.SBG_CODIGO) '+
                    '    INNER JOIN TB_MEDIDA Tb_medida '+
                    '    ON  (Tb_medida.MED_CODIGO = Tb_produto.PRO_CODMED) '+
                    '    INNER JOIN TB_ESTOQUE ET '+
                    '    ON (EST_CODPRO = PRO_CODIGO) '+
                    '    LEFT OUTER JOIN TB_EMBALAGEM Tb_embalagem '+
                    '    ON  (Tb_embalagem.EMB_CODIGO = Tb_produto.PRO_CODEMB) '+
                    '    LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn '+
                    '    ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) '+
                    '    LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor '+
                    '    ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
  Lc_I := 1;
  with DM.Qr_Tabelas do
    Begin
    First;
    while not eof do
      Begin
      SqlTxt := SqlTxt + '   left OUTER JOIN tb_preco TB_' + IntToStr(Lc_I) +
                         '   ON (TB_' + IntToStr(Lc_I) + '.prc_codpro = tb_produto.pro_codigo) and tb_' + IntToStr(Lc_I) + '.prc_codtpr = ' + FieldByName('TPR_CODIGO').AsString;
      next;
      Inc(Lc_I);
      end;
    end;

  if Lc_Fornece then
    Begin
    SqlTxt:= SqlTxt + '  INNER JOIN TB_PROD_FORN Tb_prod_forn '+
                      '   ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO) '+
                      '   INNER JOIN  TB_EMPRESA Tb_fornecedor '+
                      '   ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
    end;

  SqlTxt:= SqlTxt + ' WHERE (PRO_IMPRIME=''S'') AND ((PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C'') ) ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (PRO_CODMHA =:PRO_CODMHA) ' ;


  if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
  if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
  if Lc_Marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
  if Lc_Fornece then SqlTxt := SqlTxt +'AND (PFR_CODFOR =:PFR_CODFOR) ';
  if Lc_Produto then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

  if ChBx_Est_Min.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE <= PRO_QTDE_MIN)';
  if Chbx_Positivo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE > 0)';
  if chbx_negativo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE < 0)';
  if not Chbx_Inativos.Checked then SqlTxt := SqlTxt +'AND (PRO_ATIVO = ''S'') ';

  Result := CtrlEstoque.GeraQuery;
  with Result do
  Begin
    Active := False;
    SQL.Clear;
    if CB_Ordena.ItemIndex = 0 then
      SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO ')
    else
      if CB_Ordena.ItemIndex = 1 then
        SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB')
      else
        SQL.Add(SqlTxt+' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO');


    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      ParamByName('PRO_CODMHA').AsInteger:= Fm_LME.Dblcb_Lista.KeyValue;

    if Lc_Grupo then ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
    if Lc_SubGrupo then ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
    if Lc_Marca then ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
    if Lc_Fornece then ParamByName('PFR_CODFOR').AsInteger:=DBLCB_Empresa.KeyValue;
    if Lc_Produto then ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricaoProduto.Text,1,98) + '%';
    Open;
    FetchAll;
  end;
end;


procedure TFr_Imp_Produtos.Pc_TabelaProdutoAgrupada(Pc_Operacao,Pc_Caminho:String);
Var
  LcRes : Boolean;
  Lc_Qry : TSTQuery;
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Esta opção está disponivel para para Exportar.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  end
  else
  Begin
    try
      Lc_Qry := Fc_TabelasMultiplas;
      if (Lc_Qry.RecordCount > 0) then
      Begin
        Fr_Excel.Pc_Excel(Lc_Qry,Pc_Caminho);
      End
      else
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Não há dados para para exportar.'+EOLN+
                       'Tente com outros filtros.'+EOLN,
                       ['OK'],[bEscape],mpAlerta);
      End;
    finally
      CtrlEstoque.FinalizaQuery(Lc_Qry);
    end;
  end;

end;

function TFr_Imp_Produtos.Fc_AnaliseCompra():TSTQuery;
VaR
  SqlTxt:String;
  Lc_Grupo, Lc_SubGrupo, Lc_Marca, Lc_Fornece, Lc_Produto: Boolean;
begin
  Result := CtrlEstoque.GeraQuery;
  with Result do
  Begin
    if DBLCB_Grupos.Text ='' then Lc_Grupo := False else Lc_Grupo := True;
    if DBLCB_SubGrupos.Text ='' then Lc_SubGrupo := False else Lc_SubGrupo := True;
    if DBLCB_Marca.Text ='' then Lc_Marca := False else Lc_Marca := True;
    if E_BuscaDescricaoProduto.Text ='' then Lc_Produto := False else Lc_Produto := True;
    if DBLCB_Empresa.Text = '' then Lc_Fornece := False else Lc_Fornece := true;
    
    SqlTxt := 'select '+
              '  PRO_CODIGO, '+
              '  PRO_DESCRICAO, '+
              '  PRO_CODIGOFAB, '+
              '  MRC_DESCRICAO, '+
              '  EST_QTDE, '+
              '  SUM(ITF_QTDE) QT_VENDIDA, '+
              '  MAX(NFL_DT_EMISSAO) ULT_VENDA '+
              '  FROM tb_nota_fiscal '+
              '    INNER JOIN TB_ITENS_NFL '+
              '    ON (ITF_CODNFL = NFL_CODIGO) '+
              '    INNER JOIN TB_PRODUTO '+
              '    ON (PRO_CODIGO = ITF_CODPRO) '+
              '   INNER JOIN TB_ESTOQUE '+
              '   ON (EST_CODPRO = PRO_CODIGO) '+
              '   inner join tb_grupos '+
              '    on (GRP_CODIGO = PRO_CODGRP) '+
              '    INNER JOIN tb_subgrupos '+
              '    ON (SBG_CODIGO = PRO_CODSBG) '+
              '    INNER JOIN tb_marca_produto '+
              '    ON (MRC_CODIGO = PRO_CODMRC) '+
              'WHERE  ((PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'')OR (PRO_TIPO = ''C''))and (ITF_OPER = ''V'') ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      SqlTxt:= SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ' ;


    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      Sqltxt := Sqltxt + ' AND EST_CODETS = :ETS_CODIGO ';


    if Lc_Grupo then SqlTxt := SqlTxt +'AND (PRO_CODGRP =:PRO_CODGRP) ';
    if Lc_SubGrupo then SqlTxt := SqlTxt +'AND (PRO_CODSBG =:PRO_CODSBG) ';
    if Lc_Marca then SqlTxt := SqlTxt +'AND (PRO_CODMRC =:PRO_CODMRC) ';
    if Lc_Fornece then SqlTxt := SqlTxt +'AND (NFL_CODEMP = :EMP_CODIGO) ';
    if Lc_Produto then SqlTxt := SqlTxt +'AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if ChBx_Est_Min.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE <= PRO_QTDE_MIN)';
    if Chbx_Positivo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE > 0)';
    if chbx_negativo.Checked then SqlTxt := SqlTxt +'AND (EST_QTDE < 0)';
    if not Chbx_Inativos.Checked then  SqlTxt := SqlTxt +'AND (PRO_ATIVO = ''S'') ';


    if ChBx_Periodo.Checked then
      SqlTxt := SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';


    SqlTxt := SqlTxt + ' GROUP by 1,2,3,4,5 ';
    SqlTxt := SqlTxt + ' ORDER by 2,4';

    SQL.Add(SqlTxt);


    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
      ParamByName('NFL_CODMHA').AsInteger:= Fm_LME.Dblcb_Lista.KeyValue;

    if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) <> '' then
      ParamByName('ETS_CODIGO').AsInteger:= Fm_ListaEstoques.DBLCB_Estoque.KeyValue;

    if Lc_Grupo then ParamByName('PRO_CODGRP').AsInteger:=DBLCB_Grupos.KeyValue;
    if Lc_SubGrupo then ParamByName('PRO_CODSBG').AsInteger:=DBLCB_SubGrupos.KeyValue;
    if Lc_Marca then ParamByName('PRO_CODMRC').AsInteger:=DBLCB_Marca.KeyValue;
    if Lc_Fornece then ParamByName('EMP_CODIGO').AsInteger:=DBLCB_Empresa.KeyValue;
    if Lc_Produto then ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(E_BuscaDescricaoProduto.Text,1,98) + '%';
    if ChBx_Periodo.Checked then
      Begin
      ParamByName('DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('DATAFIM').AsDate := E_Data_Fim.Date;
      end;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Imp_Produtos.Pc_ExportarAnaliseCompra;
var
  Lc_Excel, Lc_Sheet : OleVariant;//Variant;
  Lc_Linha : Integer;
  Lc_Coluna: Integer;
  Lc_StrCell: string;
  Lc_Texto : String;
  Lc_Qry : TSTQuery;
begin
  Lb_Processamento.Caption := 'Abrindo o Excel';
  Lb_Processamento.Update;
  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;

  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Análise';

  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Análise'];

  //Cabeçalho
  Lb_Processamento.Caption := 'Formatando o Cabeçalho';
  Lb_Processamento.Update;

  Lc_StrCell := 'A1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'DESCRIÇÃO DO PRODUTO';

  Lc_StrCell := 'B1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'CÓDIGO FABRICANTE';

  Lc_StrCell := 'C1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'MARCA';

  Lc_StrCell := 'D1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'QTDE VENDIDA NO PERIODO';

  Lc_StrCell := 'E1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'ULTIMA VENDA';

  Lc_StrCell := 'F1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'MÉDIA MÊS';

  Lc_StrCell := 'G1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'MÉDIA 2 MESES';

  Lc_StrCell := 'H1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'MÉDIA 3 MESES';

  Lc_StrCell := 'I1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'ESTOQUE ';

  Lc_StrCell := 'J1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'COMPRAR 1 MÊS';


  Lc_StrCell := 'K1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'COMPRAR 2 MESES';

  Lc_StrCell := 'L1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'COMPRAR 3 MESES ';

  Lc_StrCell := 'M1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'ÚTIMA COMPRA ';

  Lc_StrCell := 'N1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'ÚTIMO VALOR PAGO ';

  Lc_StrCell := 'O1';
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].HorizontalAlignment := Integer(xlCenter);
  Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := 'CODIGO INTERNO ';

  Lb_Processamento.Caption := 'Criando a consulta';
  Lb_Processamento.Update;

  //Recebe a consulta
  Lc_Qry := Fc_AnaliseCompra;
  with Lc_Qry do
    Begin
    Lb_Processamento.Caption := 'Abrindo a consulta';
    Lb_Processamento.Update;

    Active := True;
    FetchAll;
    Gg_Progresso.Progress := 0;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.MaxValue := RecordCount;
    Pnl_Progresso.Visible := true;
    Pnl_Progresso.Update;
    First;
    Lc_Linha := 2;
    while not Eof do
      begin
      Lb_Processamento.Caption := 'Exportando dados - ' + FieldByName('PRO_DESCRICAO').AsString;
      Lb_Processamento.Update;

      Lc_StrCell := 'A' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('PRO_DESCRICAO').AsString;

      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '@';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('PRO_CODIGOFAB').AsString;

      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('MRC_DESCRICAO').AsString;


      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('QT_VENDIDA').AsString;

      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := 'dd/mm/aaaa';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('ULT_VENDA').AsDateTime;

      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '0,0000';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := '=RC[-2]/3';

      Lc_StrCell := 'G' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '0,0000';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := '=RC[-1]*2';

      Lc_StrCell := 'H' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '0,0000';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := '=RC[-2]*3';

      Lc_StrCell := 'I' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('EST_QTDE').AsFloat;

      Lc_StrCell := 'J' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '0';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := '=RC[-4]-RC[-1]';

      Lc_StrCell := 'K' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '0';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := '=RC[-4]-RC[-2]';

      Lc_StrCell := 'L' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '0';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := '=RC[-4]-RC[-3]';

      Lc_StrCell := 'M' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := 'dd/mm/aaaa';
      Lc_Texto := Fc_Dt_UltimaCompraProduto(FieldByName('PRO_CODIGO').AsInteger);
      if trim(Lc_Texto) <> '' then
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := StrToDateDef(Lc_Texto,Date);

      Lc_StrCell := 'N' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '0,00';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := Fc_UltimoValorUnitarioCompra(FieldByName('PRO_CODIGO').AsInteger);

      Lc_StrCell := 'O' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Select;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Activate;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].NumberFormat := '@';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value2 := FieldByName('PRO_CODIGO').AsString;

      Inc(Lc_Linha);
      Next;
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Application.ProcessMessages;
    end;
    Lb_Processamento.Caption := 'Processo concluído';
    Lb_Processamento.Update;
    Pnl_Progresso.Visible := False;
  end;

  Lc_Sheet.Range['A1','A1'].Cells.RowHeight := 30;
  Lc_Sheet.Range['A1','A1'].Cells.ColumnWidth := 70;
  Lc_Sheet.Range['B1','N1'].Cells.ColumnWidth := 14.29;
  Lc_Sheet.Range['A1',Lc_StrCell].WrapText := True;
  Lc_Sheet.Range['A1',Lc_StrCell].EntireColumn.AutoFit;
  Lc_Excel.Visible := true;

end;



procedure TFr_Imp_Produtos.Pc_AnaliseCompra(Pc_Operacao,Pc_Caminho:String);
Begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Esta opção está disponivel para para Exportar.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  end
  else
  Begin
    Pc_ExportarAnaliseCompra;
  end;
end;

procedure TFr_Imp_Produtos.Pc_EstoqueMovimento24Meses(Pc_Operacao,
  Pc_Caminho: String);
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                   'Este relatório só pode ser exportado.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  end
  else
  Begin
    Pc_ExportaEstoqueMovimento24Meses(Pc_Caminho);
  End;
end;

procedure TFr_Imp_Produtos.Pc_ExportaEstoqueMovimento24Meses(Pc_Caminho:String);
Var
  Lc_Sql_Txt : String;
  Lc_Param :TParamProdutos;
  Lc_Qry : TSTQuery;
begin
  Lc_Qry :=  CtrlEstoque.GeraQuery;
  Lc_Param := getParametros;
  Lc_Sql_Txt := concat(
                  'SELECT pro.PRO_CODIGO,pro.PRO_CODIGOFAB,pro.PRO_CODIGOFOR,pro.PRO_DESCRICAO, ',
                  'med.MED_DESCRICAO, PRO_DIVISOR, EMB_DESCRICAO, pro.PRO_CODGRP,grp.GRP_DESCRICAO, ',
                  'pro.PRO_CODSBG,sbg.SBG_DESCRICAO, pro.PRO_CODIGONCM,pro.pro_peso,mar.MRC_DESCRICAO, ',
                  'pro.pro_vl_fabrica,pro.pro_vl_customed, pro.PRO_VL_CUSTO,pre.PRC_VL_VDA ,pre.PRC_MAR_LRC, ',
                  ' pro.pro_comprimento, pro.pro_largura, pro.pro_altura, ',
                  'pro.PRO_CODIGOBAR,EST_QTDE,pro_est_neg, AVAILABLE,ADD_DAYS_AVAILABLE,PRO_ATIVO, ',
                  '(select sum(ITF_QTDE) ',
                  'FROM TB_ITENS_NFL I ',
                  '    INNER JOIN TB_NOTA_FISCAL N ',
                  '    ON (N.nfl_codigo = I.itf_codnfl) ',
                  '    INNER JOIN tb_pedido P ',
                  '    ON (P.ped_codigo = N.nfl_codped) ',
                  'WHERE N.nfl_status = ''F'' ',
                  'AND P.ped_tipo = 1 ',
                  'AND ITF_OPER = ''V'' ',
                  'AND ITF_CODPRO = pro.pro_codigo ',
                  'AND N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM )VALOR_TL_VENDAS, ',
                  '(SELECT AVG(SOMA) ',
                  'from ( ',
                  '    select  extract(MONTH from N.nfl_dt_emissao) MES, ',
                  '    extract(YEAR from N.nfl_dt_emissao) ANO, ',
                  '    sum(ITF_QTDE) SOMA ',
                  '    FROM TB_ITENS_NFL I ',
                  '        INNER JOIN TB_NOTA_FISCAL N ',
                  '        ON (N.nfl_codigo = I.itf_codnfl) ',
                  '        INNER JOIN tb_pedido P ',
                  '        ON (P.ped_codigo = N.nfl_codped) ',
                  '    WHERE N.nfl_status = ''F'' ',
                  '    AND P.ped_tipo = 1 ',
                  '    AND ITF_OPER = ''V'' ',
                  '    AND ITF_CODPRO = pro.pro_codigo ',
                  '    AND N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM ',
                  '    GROUP BY 2,1 ',
                  '    ORDER BY 2,1 ) ',
                  ') MEDIA_MENSAL ',
                  'FROM TB_PRODUTO pro ',
                  '    INNER JOIN TB_ESTOQUE est ',
                  '    ON (est.EST_CODPRO = pro.PRO_CODIGO) ',
                  '    INNER JOIN TB_GRUPOS grp ',
                  '    ON  (pro.PRO_CODGRP = grp.GRP_CODIGO) ',
                  '    INNER JOIN TB_SUBGRUPOS sbg ',
                  '    ON  (pro.PRO_CODSBG = sbg.SBG_CODIGO) ',
                  '    inner join tb_medida med ',
                  '    ON(med.med_codigo = pro.pro_codmed) ',
                  '    inner join tb_embalagem emb ',
                  '    ON(emb_codigo = pro.pro_codemb) ',
                  '    INNER JOIN TB_MARCA_PRODUTO mar ',
                  '    ON  (pro.PRO_CODMRC = mar.mrc_CODIGO) ',
                  '    INNER JOIN TB_PRECO PRE ',
                  '    ON (PRE.PRC_CODPRO = pro.PRO_CODIGO) ');

  with Lc_Param do
  Begin
    Lc_Sql_Txt := concat(
                    Lc_Sql_Txt,
                    'WHERE  ( (PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C'') ) ');

    if CodigoEstabelecimento > 0 then
      Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND PRO_CODMHA = :PRO_CODMHA ');

    if (CodigoEstoque > 0 ) then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND EST_CODETS = :ETS_CODIGO ');

    if (CodigoGrupo > 0 ) then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (PRO_CODGRP =:PRO_CODGRP) ');

    if (CodigosubGrupo > 0 ) then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (PRO_CODSBG =:PRO_CODSBG) ');

    if (CodigoMarca > 0 ) then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (PRO_CODMRC =:PRO_CODMRC) ');

    if (CodigoEmpresa > 0) and (TipoEmpresa = '2' ) then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (PFR_CODFOR =:PFR_CODFOR) ');

    if (DescricaoProduto <> '' ) then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ');

    if EstoqueMinimo then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND ( (EST_QTDE < PRO_QTDE_MIN) AND (PRO_QTDE_MIN > 0) )');

    if EstoquePositivo then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (EST_QTDE > 0)');

    if EstoqueNegativo then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (EST_QTDE < 0)');

    if EstoqueZerado then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (EST_QTDE = 0)');

    if not Inativos then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      ' AND (PRO_ATIVO = ''S'') ');

    if CodigoTabelaPreco > 0 then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      'AND (PRC_CODTPR=:PRC_CODTPR) ');

    if InternetPublished then
            Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      'AND ( PRO_INTERNET = ''S'' ) ');

    if Lc_Param.ComMovimentacao then
                  Lc_Sql_Txt := concat(
                      Lc_Sql_Txt,
                      'AND ( CET_DATA between :DATAINI AND :DATAFIM ) ') ;
  End;

  Lc_Sql_Txt := concat(
                  'select * ',
                  'from ( ',
                   Lc_Sql_Txt,
                  ' ) where (est_qtde >0 ) or (VALOR_TL_VENDAS > 0) ');

  Lc_Qry.SQL.Add(Lc_Sql_Txt);

  with Lc_Qry, Lc_Param do
  Begin
    if CodigoTabelaPreco > 0 then
      ParamByName('PRC_CODTPR').AsInteger:= CodigoTabelaPreco;

    if CodigoEstabelecimento > 0 then
      ParamByName('PRO_CODMHA').AsInteger:= CodigoEstabelecimento;

    if ( CodigoEstoque > 0 ) then
      ParamByName('ETS_CODIGO').AsInteger:= CodigoEstoque;

    if ( CodigoGrupo > 0 ) then
      ParamByName('PRO_CODGRP').AsInteger := CodigoGrupo;

    if ( CodigoSubGrupo > 0 ) then
      ParamByName('PRO_CODSBG').AsInteger:= CodigoSubGrupo;

    if ( CodigoMarca > 0 ) then
      ParamByName('PRO_CODMRC').AsInteger := CodigoMarca;

    if (CodigoEmpresa > 0) and (TipoEmpresa = '2') then
        ParamByName('PFR_CODFOR').AsInteger := CodigoEmpresa;

    if DescricaoProduto <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(DescricaoProduto,1,98) + '%';

    ParamByName('DATAINI').AsDateTime := DataInicial;
    ParamByName('DATAFIM').AsDateTime := DataFinal;

  end;
  Lc_Qry.Active := True;
  Fr_Excel.Pc_Excel(Lc_Qry,Pc_Caminho);
end;

procedure TFr_Imp_Produtos.Pc_ExportaInventarioCordilheira;
var
  Lc_Qry : TSTQuery;
  Lc_caminho,Lc_SqlTxt :String;
  Lc_sequencia:Integer;
  Lc_arquivo:TextFile;
  Lc_Arquivoerro:TextFile;
  Lc_caminhoErro:String;
  Lc_Aux :String;
  Lc_erros: boolean;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'select IVT_DATA,  IVT_CODPRO, PRO_DESCRICAO, PRO_CODIGOFAB, IVT_QT_ATUAL, IVT_VL_CUSTO '+
                   ' from TB_INVENTARIO '+
                   '   INNER JOIN tb_produto '+
                   '   ON (PRO_CODIGO = IVT_CODPRO) '+
                   ' WHERE IVT_DATA =:IVT_DATA AND (IVT_CODMHA =:IVT_CODMHA) ' +
                   'AND (IVT_QT_ATUAL > 0) ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_DATA').AsDateTime  := Qr_Invetario.FieldByName('IVT_DATA').AsDateTime;
      ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;

      Active:=true;
      FetchAll;
      First;
      if RecordCount >0 then
      begin
        lc_caminho:=  'C:\ESTOQUE.txt';
        Lc_caminhoErro := 'c:\Estoque_SemVl_Custo.txt';
        Pnl_Progresso.Visible := true;
        Gg_Progresso.Progress := 0;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := RecordCount;
        Pnl_Progresso.Update;
        //Arquivo do Inventario
        AssignFile (lc_arquivo, lc_caminho );
        Rewrite ( lc_arquivo );
        //Arquivo do Inventario sem o valor do custo
        Lc_erros := false;
        AssignFile (Lc_Arquivoerro, Lc_caminhoErro );
        Rewrite ( Lc_Arquivoerro);

        lc_sequencia:=1;
        while not Eof do
        begin
          if (fieldbyname('IVT_VL_CUSTO').AsCurrency > 0) then
          Begin
            //Código do item
            Write (lc_arquivo,(StrZero(StrToInt(copy(fieldbyname('IVT_CODPRO').AsString,1,10)),10,0)));
            //Data do Inventário
            Lc_Aux := Fc_RemoveCaracterInformado(fieldbyname('IVT_DATA').AsString,['/']);
            Write (lc_arquivo,Lc_Aux);
            //Saldo em estoque
            Lc_Aux := StrZero(fieldbyname('IVT_QT_ATUAL').AsFloat,15,4);
            Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux,[',']);
            Write (lc_arquivo,Lc_Aux);
            //Valor unitário de cada item
            Lc_Aux := StrZero(fieldbyname('IVT_VL_CUSTO').AsCurrency,13,2);
            Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux,[',']);
            Write (lc_arquivo,Lc_Aux);
            //Código de posse (observação abaixo)
            //1 - Item de propriedade do informante em seu poder
            //2 - Item de propriedade do informante em poder de terceiros
            //3 - Item de propriedade de terceiros em poder do informante
            Lc_Aux := '1';
            Write (lc_arquivo,Lc_Aux);
            //CNPJ ou CPF do detentor da posse. -somente para item 2 ou 3
            Lc_Aux := Fc_CriaEspaco('',18);
            Write (lc_arquivo,Lc_Aux);
            //Código alfanumérico do item
            Lc_Aux := Copy(fieldbyname('PRO_CODIGOFAB').AsString,1,15);
            Lc_Aux := Fc_CriaEspaco(Lc_Aux,15);
            Write (lc_arquivo,Lc_Aux);
            //Campo reservado. Gravar brancos.
            Lc_Aux := Fc_CriaEspaco('',16);
            Write (lc_arquivo,Lc_Aux);
            //Número sequencial do registro
            Lc_Aux := StrZero(Lc_sequencia,6,0);
            Writeln (lc_arquivo,Lc_Aux);
          end
          else
          Begin
            if not Lc_erros then  Lc_erros := true;
            //Código alfanumérico do item
            Lc_Aux := Copy(fieldbyname('PRO_CODIGOFAB').AsString,1,15);
            Lc_Aux := Fc_CriaEspaco(Lc_Aux,15);
            Write (Lc_Arquivoerro,Lc_Aux);
            //DESCRICAO DO PRODUTO
            Lc_Aux := fieldbyname('PRO_DESCRICAO').AsString;
            Writeln (Lc_Arquivoerro,Lc_Aux);
          end;
          Next;
          Lc_sequencia := Lc_sequencia + 1;
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Application.ProcessMessages;
        end;
        Pnl_Progresso.Visible := False;
        Pnl_Progresso.Update;
        CloseFile(lc_arquivo);
        CloseFile(Lc_Arquivoerro);
        if Lc_erros then
        Begin
          MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                         'Verifique o arquivo Estoque_SemVl_Custo.txt.'+EOLN+
                         'Hé produtos sem o valor de custo'+EOLN,
                         ['OK'], [bEscape], mpInformacao);
          Pc_Executar_Arquivo(Lc_caminhoErro);
        end;
      end
      else
      Begin
        MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                       'Não há inventário disponível.'+EOLN+EOLN,
                       ['OK'], [bEscape], mpInformacao);
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Imp_Produtos.Pc_ExportaItemCordilheira;
var
  Lc_Qry : TSTQuery;
  Lc_caminho,Lc_SqlTxt :String;
  Lc_sequencia:Integer;
  Lc_arquivo:TextFile;
  Lc_Aux :String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT PRO_CODIGO, PRO_CODIGOFAB,PRO_DESCRICAO,MED_ABREVIATURA,PRO_PESO, PRO_TIPO,PRO_CODIGONCM  '+
                   'FROM TB_INVENTARIO tb_inventario '+
                   '  inner join tb_produto tb_produto '+
                   '  on (tb_produto.pro_codigo = tb_inventario.IVT_CODPRO) '+
                   '  INNER JOIN TB_MEDIDA tb_medida '+
                   '  ON (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
                   '  where (IVT_DATA =:IVT_DATA ) AND (IVT_CODMHA =:IVT_CODMHA) ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_DATA').AsDateTime := Qr_Invetario.FieldByName('IVT_DATA').AsDateTime;
      ParamByName('IVT_CODMHA').AsInteger := Gb_CodMha;
      Active:=true;
      FetchAll;
      First;
      if RecordCount >0 then
      begin
        Lc_caminho:= 'C:\ITEM.txt';
        Pnl_Progresso.Visible := true;
        Gg_Progresso.Progress := 0;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := RecordCount;
        Pnl_Progresso.Update;
        AssignFile (lc_arquivo, lc_caminho );
        Rewrite ( lc_arquivo );
        lc_sequencia:=1;
        while not Eof do
        begin
          //Código do item
          Lc_Aux := StrZero(fieldbyname('PRO_CODIGO').AsFloat,10,0);
          Write (lc_arquivo,Lc_Aux);
          //Descrição do item
          Lc_Aux := Copy(fieldbyname('PRO_DESCRICAO').AsString,1,40);
          Lc_Aux := Fc_CriaEspaco(Lc_Aux,40);
          Write (lc_arquivo,Lc_Aux);
          //Código da Nomenclatura Comum do Mercosul do item
          Lc_Aux := Fc_CriaZero(fieldbyname('PRO_CODIGONCM').AsString,8);
          Write (lc_arquivo,Lc_Aux);
          //Unidade de medida
          Lc_Aux := Copy(fieldbyname('MED_ABREVIATURA').AsString,1,4);
          Lc_Aux := Fc_CriaEspaco(Lc_Aux,4);
          Write (lc_arquivo,Lc_Aux);
          //Peso do item
          Lc_Aux := StrZero(fieldbyname('PRO_PESO').AsFloat,10,3);
          Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux,[',']);
          Write (lc_arquivo,Lc_Aux);
          //Identificação do produto
          Lc_Aux := Copy(fieldbyname('PRO_CODIGOFAB').AsString,1,15);
          Lc_Aux := Fc_CriaEspaco(Lc_Aux,15);
          Write (lc_arquivo,Lc_Aux);
          //Identificação do tipo do produto, conforme tabela abaixo.
          IF fieldbyname('PRO_TIPO').AsString = 'P' then
          Begin
            Lc_Aux := StrZero(5,2,0);
            Write (lc_arquivo,Lc_Aux);
          end
          else
          Begin
            Lc_Aux := StrZero(2,2,0);
            Write (lc_arquivo,Lc_Aux);
          end;
          //Campo reservado.
          Lc_Aux := Fc_CriaEspaco('',12);
          Write (lc_arquivo,Lc_Aux);
          //Situação Tributária ICMS
          Write (lc_arquivo,'090');
          //Situação Tributária IPI
          Write (lc_arquivo,'049');
          //Situação Tributária PIS
          Write (lc_arquivo,'090');
          //Situação Tributária CONFINS
          Write (lc_arquivo,'099');
          //Campo Reservado
          Lc_Aux := Fc_CriaEspaco('',382);
          Write (lc_arquivo,Lc_Aux);
          //Número sequencial do registro.
          Lc_Aux := StrZero(Lc_sequencia,6,0);
          Writeln (lc_arquivo,Lc_Aux);
          Next;
          lc_sequencia:=lc_sequencia+1;
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Application.ProcessMessages;
        end;
        Pnl_Progresso.Visible := False;
        Pnl_Progresso.UPdate;
        CloseFile(lc_arquivo);
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Imp_Produtos.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    case LBx_TipoRelatorio.ItemIndex of
      0:Pc_CadastrodeProdutos('I','');
      1:Pc_SaldodoEstoque('I','');
      2:Pc_Movimentacao('I','');
      3:Pc_TabeladeProdutos('I','');
      4:Pc_CurvaABC('I','');
      5:Pc_Inventario('I','');
      6:Pc_AnalisedeAlteracaodePreconaCompra('I','');
      7:Pc_ProdutosMaisVendidos('I','');
      8:Pc_Reposicao('I','');
      9:Pc_ConferenciadeEstoque('I','');
     10:Pc_AnalisedeAlteracaodePreconaVenda('I','');
     11:Pc_InventarioFormatocodilheira('I','');
     12:Pc_InventarioFormatoCaderno('I','');
     13:Pc_VendasPorItem('I','');
     14:Pc_CadastroServicos('I','');
     15:Pc_TabelaProdutoAgrupada('I','');
     16:Pc_AnaliseCompra('I','');
     17:Pc_ProdutosMaisVendidosVendedor('I','');
     18:Pc_ProdutosVendidosporMarca('I','');
     19:Pc_Lucratividade('I','');
     20:Pc_ArquivoBalancaToledo('I','');
     21:Pc_ArquivoBalancaFilizola('I','');
     22:Pc_ResultadoProdutos('I','');
     24:Pc_VendaPorItemLucroBruto('I','');
     25:Pc_EstoqueMovimento24Meses('I','');
     end;
    DM.Qr_Grupo.Active := True;
    DM.Qr_SubGrupo.Active := True;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;


procedure TFr_Imp_Produtos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
      VK_F3  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_F4  : if sb_estoque.Enabled then sb_estoqueClick(Sender);
      VK_F5  : if Sb_Inventario.Enabled then Sb_InventarioClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Imp_Produtos.FormClose(Sender: TObject;
  var Action: TCloseAction);
BEGIN
  FreeAndNil(Estoque);
  FreeAndNil(CtrlEstoque);
  FreeAndNil(Inventario);
  Action:=caFree;
  Fr_Imp_Produtos:=nil;
end;

procedure TFr_Imp_Produtos.FormCreate(Sender: TObject);
begin
  CtrlEstoque := TControllerCtrlEstoque.create(Self);
  Inventario := TControllerInventario.create(Self);
  Estoque := TControllerEstoque.create(Self);
  FContagemInventario := False;
end;

procedure TFr_Imp_Produtos.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Empresa.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Produtos.DBLCB_SubGruposKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_SubGrupos.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Produtos.DBLCB_GruposKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Grupos.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Produtos.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Imp_Produtos.TabSheet1Show(Sender: TObject);
begin
  Pc_DefineInventario;
end;

function TFr_Imp_Produtos.validarecontagem: Boolean;
begin
  Result := true;
  if chbx_zerar_estoque.Checked then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Atenção a opção para zerar o estoque foi marcada?'+EOLN+EOLN+
                       'Esta opção não poderé ser desfeita.'+EOLN+
                       'Podemos continuar?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    Begin
      Result := False;
      exit;
    End;
  End;

  if Chbx_LimparHistoricoEstoque.Checked then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Atenção a opção para Limpar todo histórico do estoque foi marcada?'+EOLN+EOLN+
                       'Esta opção não poderé ser desfeita.'+EOLN+
                       'Podemos continuar?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    Begin
      Result := False;
      exit;
    End;
  End;

  if Chbx_Periodo_Movimento.Checked then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Atenção a opção vai recontar somente os produtos movimentados neste período?'+EOLN+EOLN+
                       'Podemos continuar?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    Begin
      Result := False;
      exit;
    End;
  End;


  if trim(Fm_ListaEstoques.DBLCB_Estoque.Text) =  '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Favor selecionar um Estoque para a contagem.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Recontar todos o estoque movimentado no Sistema?'+EOLN+EOLN+
                     'Isso pode levar vários Minutos. Confirma a Operação?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao2) then
  begin
    Result := False;
    exit;
  end;

end;

procedure TFr_Imp_Produtos.Sb_ExportarClick(Sender: TObject);
Var
  Lc_CAminho : String;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    case LBx_TipoRelatorio.ItemIndex of
      11:Pc_InventarioFormatocodilheira('E',Lc_CAminho);
      19:Pc_Lucratividade('I','');
    else
      Begin
        IF (Fr_Principal.SaveDialogo.Execute) then
        Begin
          if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
          Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
          Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
          case LBx_TipoRelatorio.ItemIndex of
            0:Pc_CadastrodeProdutos('E',Lc_CAminho);
            1:Pc_SaldodoEstoque('E',Lc_CAminho);
            2:Pc_Movimentacao('E',Lc_CAminho);
            3:Pc_TabeladeProdutos('E',Lc_CAminho);
            4:Pc_CurvaABC('E',Lc_CAminho);
            5:Pc_Inventario('E',Lc_CAminho);
            6:Pc_AnalisedeAlteracaodePreconaCompra('E',Lc_CAminho);
            7:Pc_ProdutosMaisVendidos('E',Lc_CAminho);
            8:Pc_Reposicao('E',Lc_CAminho);
            9:Pc_ConferenciadeEstoque('E',Lc_CAminho);
           10:Pc_AnalisedeAlteracaodePreconaVenda('E',Lc_CAminho);
           12:pc_InventarioFormatoCaderno('E',Lc_CAminho);
           13:Pc_VendasPorItem('E',Lc_CAminho);
           14:Pc_CadastroServicos('E','');
           15:Pc_TabelaProdutoAgrupada('E',Lc_CAminho);
           16:Pc_AnaliseCompra('E','');
           17:Pc_ProdutosMaisVendidosVendedor('E',Lc_CAminho);
           18:Pc_ProdutosVendidosporMarca('E',Lc_CAminho);
           20:Pc_ArquivoBalancaToledo('E',Lc_CAminho);
           21:Pc_ArquivoBalancaFilizola('E',Lc_CAminho);
           22:Pc_ResultadoProdutos('E',Lc_CAminho);
           23:Pc_ArquivoTerminalPreco(Lc_CAminho);
           24:Pc_VendaPorItemLucroBruto('E',Lc_CAminho);
           25:Pc_EstoqueMovimento24Meses('E',Lc_Caminho);
          end;
        end;
      End;
    end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Imp_Produtos.sb_estoqueClick(Sender: TObject);
Begin
  if validarecontagem then
    recontagem;
end;

procedure TFr_Imp_Produtos.Pc_DefineParametroOrdenacao(Pc_Relatorio:Integer);
Begin
  CB_Ordena.Enabled := true;
  case Pc_Relatorio of
    9:Begin
      CB_Ordena.Clear;
      CB_Ordena.Items.Add('DESCRIÇÃO');
      CB_Ordena.Items.Add('CÓDIGO FÁBRICA');
      CB_Ordena.Items.Add('CÓDIGO INTERNO');
      CB_Ordena.Items.Add('ENDEREÇO DE  ESTOQUE');
      CB_Ordena.ItemIndex := 0;
      end
    else
      Begin
      CB_Ordena.Clear;
      CB_Ordena.Items.Add('DESCRIÇÃO');
      CB_Ordena.Items.Add('CÓDIGO FÁBRICA');
      CB_Ordena.Items.Add('CÓDIGO INTERNO');
      CB_Ordena.ItemIndex := 0;
      end;
    end;
end;

procedure TFr_Imp_Produtos.Pc_ControlaItensIterface;
Begin
  {
  DsblControl(ChBx_Periodo);
  DsblControl(E_Data_Ini);
  DsblControl(E_Data_Fim);
  DsblControl(Fm_ListaEstoques.DBLCB_Estoque);
  DsblControl(DBLCB_Tabela_Preco);
  DsblControl(DBLCB_Grupos);
  DsblControl(DBLCB_SubGrupos);
  DsblControl(DBLCB_Marca);
  DsblControl(E_BuscaCodigoProduto);
  DsblControl(E_BuscaDescricaoProduto);
  DsblControl(E_Busca_Local);
  DsblControl(Rb_Empresa);
  DsblControl(Rb_Produto);
  DsblControl(ChBx_Nome);
  DsblControl(ChBx_Fantasia);
  DsblControl(DBLCB_Empresa);
  DsblControl(Rb_Vend_Cliente);
  DsblControl(Rb_Vend_Pedido);
  DsblControl(dblcb_Vendedor);
  DsblControl(ChBx_Contagem);
  DsblControl(chbx_AuditoriaEstoque);
  sb_estoque.Enabled := False;
  Sb_Inventario.Enabled := False;
  DsblControl(ChBx_SemMov);
  DsblControl(ChBx_Est_Min);
  DsblControl(chbx_positivo);
  DsblControl(chbx_negativo);
  DsblControl(Chbx_Inativos);
  DsblControl(Chbx_AlteracaoPrecoCompra);
  DsblControl(ChBx_UltimaAlteracaoVenda);
  DsblControl(Chbx_AnaliseMovimento);
  DsblControl(Chbx_Vl_Venda_Maior_Zero);
  DsblControl(E_Curva_Nr_Mes);
  }
  sb_estoque.Enabled := False;
  Sb_Inventario.Enabled := False;
  Pc_DefineParametroOrdenacao(0);
  Qr_Invetario.Active := False;
end;

procedure TFr_Imp_Produtos.Dbg_InventarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :  Begin
                  if (MensagemPadrao(TITULO_CONFIRMACAO,
                                     'Excluir inventátio da Data '+ Qr_Invetario.FieldByName('IVT_DATA').AsString +' de seus arquivos.'+EOLN+EOLN+
                                     'Confirmar a exclusão ?',
                                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
                  try
                    Qr_Del_Inventario.Active := False;
                    Qr_Del_Inventario.ParamByName('IVT_DATA').AsDate := Qr_Invetario.FieldByName('IVT_DATA').AsDateTime;
                    Qr_Del_Inventario.Active := True;
                    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.Commit;
                    Pc_AtivarTabelas;
                  except
                    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                                   'Entre em contato com o suporte técnico.'+EOLN,
                                  ['OK'],[bEscape],mpErro);
                    DM.IB_Transacao.RollbackRetaining;
                  end;
                end;
  end;
end;

procedure TFr_Imp_Produtos.Sb_InventarioClick(Sender: TObject);
var
  Lc_Qry_Produtos : TSTQuery;
  Lc_Cd_Estoque : Integer;
  Lc_Tp_Custo : String;
  Lc_VL_Custo : Real;
  Lc_SqlTxt : String;
  Lc_Cont_Ini : Integer;
  Lc_Cont_Fim : Integer;
  LcBase : TControllerBase;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Criar Inventario para a data de Hoje?'+EOLN+EOLN+
                     'Isso pode levar vários Minutos. Confirma a Operação?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    //Ajustar a Data dos pedidos em Aberto antes de fazer o Inventario;
    Pc_AjustarDataPedidoAberto(Date+1);
    FContagemInventario := True;
    if ChBx_Contagem.Checked then
      Pc_AtualizaEstoque;
    FContagemInventario := False;
    if Fc_validaInventario then
    Begin
      Try
        //Verifica o Estoque que sera inventariado
        if (trim(Fm_ListaEstoques.DBLCB_Estoque.Text)<> '') then
          Lc_Cd_Estoque := Fm_ListaEstoques.DBLCB_Estoque.KeyValue
        else
          Lc_Cd_Estoque := Gb_Estoque;

        //Define o tipo de custo que será usado
        IF Fc_Tb_Geral('L','PRO_G_CUSTO_INVENTARIO','') = 'C' THEN
          Lc_Tp_Custo := 'C'
        else
          Lc_Tp_Custo := 'R';
        //Cria componente para selecionar os produtos para inventario
        LcBase := TControllerBase.create(nil);
        Lc_Qry_Produtos := LcBase.GeraQuery;
        with Lc_Qry_Produtos do
        Begin
          //SQL de ~seleção dos itens
          SQL.Clear;
          Lc_SqlTxt := 'SELECT PRO_CODIGO, PRO_VL_CUSTO, PRO_VL_CUSTOMED, EST_QTDE '+
                       'FROM TB_ESTOQUE tb_estoque '+
                       '  INNER JOIN TB_PRODUTO tb_produto '+
                       '  ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
                       ' WHERE (EST_CODETS=:EST_CODETS) '+
                     //'   and (PRO_CODIGO =:PRO_CODIGO) '+
                       ' ORDER BY PRO_CODIGO ';
          SQL.Add(Lc_SqlTxt);
          ParamByName('EST_CODETS').AsInteger := Lc_cd_Estoque;
          //ParamByName('PRO_CODIGO').AsString := E_BuscaCodigoProduto.Text;
          Active := True;
          FetchAll;
          Lc_Cont_Fim := RecordCount;
          Pnl_Progresso.Visible := True;
          Gg_Progresso.Progress := 0;
          Gg_Progresso.MinValue := 0;
          Gg_Progresso.MaxValue := Lc_Cont_Fim;
          Pnl_Progresso.Update;
          First;
          for Lc_Cont_Ini := 1 to Lc_Cont_Fim do
          Begin
            if (Lc_Tp_Custo = 'C') then
              Lc_VL_Custo := FieldByName('PRO_VL_CUSTO').AsCurrency
            else
              Lc_VL_Custo := FieldByName('PRO_VL_CUSTOMED').AsCurrency;
            Inventario.Clear;
            Inventario.Registro.Codigo           := 0;
            Inventario.Registro.Estabelecimento  := Gb_CodMha;
            Inventario.Registro.Estoque          := Lc_Cd_Estoque;
            Inventario.Registro.Produto          := FieldByName('PRO_CODIGO').AsInteger;
            Inventario.Registro.QtdeAtual        := FieldByName('EST_QTDE').AsFloat;
            Inventario.Registro.Data             := Date;
            Inventario.Registro.ValorCusto       := Lc_VL_Custo;
            Inventario.salva;
            Next;
            Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
            Application.ProcessMessages;
          end;
        end;
        //Libera a Memoria
        LcBase.FinalizaQuery(Lc_Qry_Produtos);
        //Oculta o progresso
        Gg_Progresso.Progress := 0;
        Pnl_Progresso.Visible := False;
        Pnl_Progresso.Update;
        MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                       'Inventário criado com sucesso.'+EOLN,
                      ['OK'],[bEscape],mpInformacao);
      Finally
        FreeAndNil(LcBase);
        Pc_DefineInventario;
      End;

    end;
    Fm_ListaEstoques.AtivaLista(Gb_CodMha);
    Pc_DefineInventario;
end;
end;

procedure TFr_Imp_Produtos.DBLCB_MarcaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Marca.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Produtos.E_BuscaCodigoProdutoExit(Sender: TObject);
begin
  If E_BuscaCodigoProduto.Text <> '' then
    E_BuscaDescricaoProduto.Text := Fc_PegaProduto(E_BuscaCodigoProduto.Text,'');
end;

procedure TFr_Imp_Produtos.dblcb_VendedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Vendedor.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Imp_Produtos.SB_Cad_produtoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(Self);
  Lc_Form.Pc_Tabelas_Disponiveis;
  Lc_Form.it_Modalidade_preco := 'A';
  Lc_Form.ShowModal;
  //Depois que Fecha o Relatorio
  if Lc_Form.It_Visualizar then
  Begin
    E_BuscaCodigoProduto.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
    E_BuscaDescricaoProduto.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
    E_BuscaDescricaoProduto.SetFocus;
  end;
  FreeAndNil(Lc_Form);
end;

procedure TFr_Imp_Produtos.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    It_Exportar     := True;
    iT_INVENTARIAR  := True;
    It_estoque      := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar      := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');
    iT_INVENTARIAR   := Fc_HabilitaPermissao(Pc_Menu,'INVENTARIAR','S');
    It_estoque       := Fc_HabilitaPermissao(Pc_Menu,'ESTOQUE','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_Produtos.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_IniciaVariaveis;
  Pc_PermissaoBotao('Produtos');
  LBx_TipoRelatorioClick(Self);
  Pc_ImagemBotao;
end;

procedure TFr_Imp_Produtos.DBLCB_EstoqueClick(Sender: TObject);
begin
  Pc_DefineInventario;
end;

procedure TFr_Imp_Produtos.chbx_AuditoriaEstoqueClick(Sender: TObject);
begin
  if chbx_AuditoriaEstoque.Checked then
  Begin
    ChBx_Contagem.Checked := True;
  End;
end;

procedure TFr_Imp_Produtos.ChBx_ContagemClick(Sender: TObject);
begin
  if not ChBx_Contagem.Checked then
  Begin
    chbx_AuditoriaEstoque.Checked := False;
  End;
end;

procedure TFr_Imp_Produtos.ChBx_CustoMedioClick(Sender: TObject);
begin
  if ChBx_CustoMedio.Checked then
    Begin
    ChBx_Periodo.Checked := True;
    ChBx_Periodo.Enabled := True;
    E_Data_Ini.Enabled := True;
    E_Data_Fim.Enabled := True;
    end
  else
    Begin
    ChBx_Periodo.Checked := False;
    ChBx_Periodo.Enabled := False;
    E_Data_Ini.Enabled := False;
    E_Data_Fim.Enabled := False;
    end;
end;

procedure TFr_Imp_Produtos.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Produtos.Chbx_zerar_estoqueClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Atenção ao utilizar esta opção.'+EOLN+
                   'Esse processo vai zerar o estoque atual.'+EOLN+
                   'E não tem opção para desfazer o processo.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  End;
end;

procedure TFr_Imp_Produtos.Chbx_Periodo_MovimentoClick(Sender: TObject);
begin
  E_Dt_movim_Inicial.Enabled := TCheckBox(Sender).Checked;
  E_Dt_movim_Final.Enabled := TCheckBox(Sender).Checked;
end;

procedure TFr_Imp_Produtos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Imp_Produtos.E_Curva_Nr_MesChange(Sender: TObject);
begin
  if StrToIntDef(E_Curva_Nr_Mes.Text,1) = 1 then
    Lb_Nr_Meses_CurvaABC.Caption := 'Usar          mês no cálculo da Curva ABC'
  else
    Lb_Nr_Meses_CurvaABC.Caption := 'Usar          meses no cálculo da Curva ABC';

end;

procedure TFr_Imp_Produtos.Chbx_AnaliseMovimentoClick(Sender: TObject);
begin
  if Chbx_AnaliseMovimento.Checked then
  Begin
    ChBx_Periodo.Checked := true;
    ChBx_Periodo.Enabled := False;
    E_Data_Ini.Enabled := True;
    E_Data_Fim.Enabled := True;
  end
  else
  Begin
    ChBx_Periodo.Checked := true;
    ChBx_Periodo.Enabled := True;
    E_Data_Ini.Enabled := False;
    E_Data_Fim.Enabled := false;
  end;
end;

procedure TFr_Imp_Produtos.ChBx_NomeClick(Sender: TObject);
begin
  ListarEmpresasRazao;
end;

procedure TFr_Imp_Produtos.ChBx_FantasiaClick(Sender: TObject);
begin
  ListarEmpresasFantasia;
end;

procedure TFr_Imp_Produtos.Chbx_LimparHistoricoEstoqueClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Atenção ao utilizar esta opção.'+EOLN+
                   'Esse processo vai Limpar informações de controle do sistema.'+EOLN+
                   'E não tem opção para desfazer o processo.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  End;

end;

procedure TFr_Imp_Produtos.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Imp_Produtos.Pc_ProdutosVendidosporMarca (Pc_Operacao,Pc_Caminho:String);
Begin
  ShowMessage('Relatorio em desenvolvimento');
end;

procedure TFr_Imp_Produtos.Pc_Lucratividade(Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRL_ReportLucratividade;
  Lc_Param : TParamLucratividade;
begin
  Try
    Lc_Form := TRL_ReportLucratividade.create(nil);
    Lc_Param := TParamLucratividade.Create;
    with Lc_Param do
    Begin
      Periodo := ChBx_Periodo.Checked;
      DataInicial := E_Data_Ini.Date;
      DataFinal := E_Data_Fim.Date;
      CodigoCliente := 0;
      NomeCliente := '';
      CodigoTransportadora := 0;
      if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
        CodigoEstabelecimento := Fm_LME.Dblcb_Lista.KeyValue;
      if dblcb_Vendedor.Text <> '' then
      Begin
        if Rb_Vend_Cliente.Checked then
        Begin
          VendedorCliente := dblcb_Vendedor.KeyValue;
        End
        else
        Begin
          VendedorPedido := dblcb_Vendedor.KeyValue;
        End;
      end;
      NegociosEspecificos := '';
      NumeroDocumento := '';
      //Parametros para Produtos
      if DBLCB_Grupos.Text = '' then
        CodigoGrupo := 0
      else
        CodigoGrupo := DBLCB_Grupos.KeyValue;

      if DBLCB_SubGrupos.Text ='' then
        CodigoSubGrupo := 0
      else
        CodigoSubGrupo := DBLCB_SubGrupos.KeyValue;

      if DBLCB_Marca.Text = '' then
        CodigoMarca := 0
      else
        CodigoMarca := DBLCB_Marca.KeyValue;

      if StrtoIntdeF(E_BuscaCodigoProduto.text,0) >0 then
        CodigoProduto := StrtoIntdeF(E_BuscaCodigoProduto.text,0);

      if E_BuscaDescricaoProduto.Text ='' then
        DescricaoProduto := ''
      else
        DescricaoProduto := E_BuscaDescricaoProduto.Text;
      Lc_Form.Parametros := Lc_Param;
      Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE GERAL';
      Lc_Form.Qrpt.Preview;

    end;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Produtos.ExportaArquivoBalancaToledo(Pc_Caminho:String);
var
  Lc_Qr_sql :TSTQuery;
  lc_arquivo:TextFile;
  Lc_Aux : String;
  lC_DiasValidade : Integer;
  Lc_Pro_Campo : String;
begin
  Try
    Lc_Qr_sql := CtrlEstoque.GeraQuery;
    with Lc_Qr_sql do
    Begin
      if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N') = 'S') then
        Lc_Pro_Campo := 'PRO_CODIGOFAB'
      else
        Lc_Pro_Campo := 'PRO_CODIGO';

      sql.Add('SELECT PRO_CODGRP, ' + Lc_Pro_Campo + ' COD_PRODUTO, PRO_DESCRICAO, PRC_VL_VDA, PRO_DT_VENCIMENTO '+
              'FROM TB_PRODUTO '+
              '  INNER JOIN TB_MEDIDA '+
              '  ON (MED_CODIGO = PRO_CODMED) '+
              '  INNER JOIN TB_PRECO '+
              '  ON(prc_codpro = pro_codigo) and (prc_codtpr = 1) '+
              'where ( (MED_ABREVIATURA = ''kg'') OR (MED_ABREVIATURA = ''KG'') )'+
              ' AND (PRO_ATIVO = ''S'')' );
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
      Begin
        AssignFile (lc_arquivo, Pc_caminho );
        Rewrite ( lc_arquivo );
        Gg_Progresso.Visible := true;
        Gg_Progresso.Progress := 0;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := RecordCount;
        Gg_Progresso.Update;
        while not Eof do
        begin
          //Código do departamento
          Lc_Aux := '01';
          Write (lc_arquivo,Lc_Aux);
          //Etiqueta configurada no departamento
          Lc_Aux := '00';
          Write (lc_arquivo,Lc_Aux);
          //Tipo de produto: - [0] => Venda por peso
          Lc_Aux := '0';
          Write (lc_arquivo,Lc_Aux);
          //Código do item
          Lc_Aux := StrZero(fieldbyname('COD_PRODUTO').AsInteger,6,0);
          Write (lc_arquivo,Lc_Aux);
          //Preço/kg ou Preço/Unid. do item
          Lc_Aux := FloatToStrF(fieldbyname('PRC_VL_VDA').AsCurrency,ffFixed,10,2);
          Lc_Aux := StringReplace(Lc_Aux, ',', '',[rfReplaceAll, rfIgnoreCase]);
          Lc_Aux := Fc_CriaZero(Lc_Aux,6);
          Write (lc_arquivo,Lc_Aux);
          //Dias de validade do produto
          lC_DiasValidade := trunc(fieldbyname('PRO_DT_VENCIMENTO').AsFloat - Date ) + 1;
          if lC_DiasValidade > 0 then
            Lc_Aux := StrZero(lC_DiasValidade,3,0)
          else
            Lc_Aux := '007';
          Write (lc_arquivo,Lc_Aux);
          //Linha 1 do descritivo do produto
          Lc_Aux := Fc_CriaEspaco(Copy(FieldByName('PRO_DESCRICAO').asAnsiString,1,25),25);
          //Completando o arquivo com para chegar nos 320
          {
            Write (lc_arquivo,Lc_Aux);
            Lc_Aux := Fc_CriaEspaco('',275);
          }
          Writeln (lc_arquivo,Lc_Aux);
          Next;
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Application.ProcessMessages;
        end;
        Gg_Progresso.Visible := False;
        Gg_Progresso.Update;
        CloseFile(lc_arquivo);
      End;
    end;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qr_sql);
  End;
End;

procedure TFr_Imp_Produtos.ExportaArquivoBalancaFilizola(Pc_Caminho:String);
var
  Lc_Qr_sql :TSTQuery;
  lc_arquivo:TextFile;
  Lc_Aux : String;
  Lc_Pro_Campo : String;
  lC_DiasValidade : iNTEGER;
begin
  Try
    Lc_Qr_sql := CtrlEstoque.GeraQuery;
    with Lc_Qr_sql do
    Begin
      if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N') = 'S') then
        Lc_Pro_Campo := 'PRO_CODIGOFAB'
      else
        Lc_Pro_Campo := 'PRO_CODIGO';

      sql.Add('SELECT PRO_CODGRP, '  +Lc_Pro_Campo + ' COD_PRODUTO, '+
              'PRO_DESCRICAO, PRC_VL_VDA,PRO_DT_VENCIMENTO '+
              'FROM TB_PRODUTO '+
              '  INNER JOIN TB_MEDIDA '+
              '  ON (MED_CODIGO = PRO_CODMED) '+
              '  INNER JOIN TB_PRECO '+
              '  ON(prc_codpro = pro_codigo) and (prc_codtpr = 1) '+
              'where ( (MED_ABREVIATURA = ''kg'') OR (MED_ABREVIATURA = ''KG'') )'+
              ' AND (PRO_ATIVO = ''S'')'+
              ' and (pro_codigofab is not null) ');
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
      Begin
        AssignFile (lc_arquivo, Pc_caminho );
        Rewrite ( lc_arquivo );
        Gg_Progresso.Visible := true;
        Gg_Progresso.Progress := 0;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := RecordCount;
        Gg_Progresso.Update;
        while not Eof do
        begin
          //Códcódcódcódigo do produto com seis (6) caracteres numéricos
          Lc_Aux := StrZero(fieldbyname('COD_PRODUTO').AsInteger,6,0);
          Write (lc_arquivo,Lc_Aux);
          //Tipo do produto com um (1) caracter
          //O tipo somente pode ser 'P' (para indicar peso) ou'U' (para indicar unidade)
          Lc_Aux := 'P';
          Write (lc_arquivo,Lc_Aux);
          //Descrição do produto com vinte e dois (22) caracteres
          Lc_Aux := Fc_CriaEspaco(Copy(FieldByName('PRO_DESCRICAO').asAnsiString,1,22),22);
          Write (lc_arquivo,Lc_Aux);
          //Preço unitário com sete (7) caracteres numéricos, sem sinal de decimal
          //É implícito que ovalor possui duas casas decimais
          Lc_Aux := FloatToStrF(fieldbyname('PRC_VL_VDA').AsCurrency,ffFixed,10,2);
          Lc_Aux := StringReplace(Lc_Aux, ',', '',[rfReplaceAll, rfIgnoreCase]);
          Lc_Aux := Fc_CriaZero(Lc_Aux,7);
          Write (lc_arquivo,Lc_Aux);
          //Validade do produto com trás (3) caracteres numéricos (OPCIONAL).
          //A validade doproduto pode ser omitida, mas os demais campos sempre estão presentes
          lC_DiasValidade := trunc(fieldbyname('PRO_DT_VENCIMENTO').AsFloat - Date ) +1;
          if lC_DiasValidade > 0 then
            Lc_Aux := StrZero(lC_DiasValidade,3,0)
          else
            Lc_Aux := '000';
          Writeln (lc_arquivo,Lc_Aux);
          Next;
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Application.ProcessMessages;
        end;
        Gg_Progresso.Visible := False;
        Gg_Progresso.Update;
        CloseFile(lc_arquivo);
      End;
    end;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qr_sql);
  End;
End;


procedure TFr_Imp_Produtos.Pc_ArquivoBalancaToledo(Pc_Operacao,Pc_Caminho:String);
Begin
  if (Pc_Operacao = 'I') then
  Begin
    MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                   'Este relatório só pode ser exportado.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  End
  else
  Begin
    ExportaArquivoBalancaToledo(Pc_CAminho);
  End;
End;

procedure TFr_Imp_Produtos.Pc_ArquivoTerminalPreco(Pc_Caminho: String);
var
  Lc_Qr_sql :TSTQuery;
  lc_arquivo:TextFile;
  Lc_Aux : String;
  Lc_Pro_Campo : String;
begin
  Try
    Lc_Qr_sql := CtrlEstoque.GeraQuery;
    with Lc_Qr_sql do
    Begin
      sql.Add('SELECT PRO_CODIGOBAR, PRO_DESCRICAO, PRC_VL_VDA '+
              'FROM TB_PRODUTO '+
              '  INNER JOIN TB_PRECO '+
              '  ON(prc_codpro = pro_codigo) and (prc_codtpr = 1) '+
              'where ( (PRO_CODIGOBAR is not null) or (PRO_CODIGOBAR <> '''') )'+
              ' AND (PRO_ATIVO = ''S'')');
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
      Begin
        AssignFile (lc_arquivo, Pc_caminho );
        Rewrite ( lc_arquivo );
        Gg_Progresso.Visible := true;
        Gg_Progresso.Progress := 0;
        Gg_Progresso.MinValue := 0;
        Gg_Progresso.MaxValue := RecordCount;
        Gg_Progresso.Update;
        while not Eof do
        begin
          //Código de barra
          Lc_Aux := fieldbyname('PRO_CODIGOBAR').AsString + '|';
          Write (lc_arquivo,Lc_Aux);
          //Descrição do produto com vinte e dois (22) caracteres
          Lc_Aux := FieldByName('PRO_DESCRICAO').asAnsiString + '|';
          Write (lc_arquivo,Lc_Aux);
          //Preço unitário com sete (7) caracteres numéricos, sem sinal de decimal
          //É implícito que ovalor possui duas casas decimais
          Lc_Aux := FloatToStrF(fieldbyname('PRC_VL_VDA').AsCurrency,ffFixed,10,2) + '|';
          Writeln (lc_arquivo,Lc_Aux);
          Next;
          Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
          Application.ProcessMessages;
        end;
        Gg_Progresso.Visible := False;
        Gg_Progresso.Update;
        CloseFile(lc_arquivo);
      End;
    end;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qr_sql);
  End;

end;

procedure TFr_Imp_Produtos.Pc_ArquivoBalancaFilizola(Pc_Operacao,Pc_Caminho:String);
Begin
  if (Pc_Operacao = 'I') then
  Begin
    MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                   'Este relatório só pode ser exportado.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  End
  else
  Begin
    ExportaArquivoBalancaFilizola(Pc_CAminho);
  End;
End;

procedure TFr_Imp_Produtos.Pc_ResultadoProdutos(Pc_Operacao,Pc_Caminho:String);
Begin
  if (Pc_Operacao = 'I') then
  Begin
    MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O!.'+EOLN+EOLN+
                   'Este relatório só pode ser exportado.'+EOLN+EOLN,
                   ['OK'], [bEscape], mpInformacao);
  End
  else
  Begin
    ExportaResultadoProdutos(Pc_Caminho);
  End;
End;

function TFr_Imp_Produtos.InnerJoinSql(Parametros:TParamProdutos):String;
begin
  Result := '  INNER JOIN TB_ESTOQUE est '+
            '  ON (est.EST_CODPRO = pro.PRO_CODIGO) '+
            '  INNER JOIN TB_GRUPOS grp '+
            '  ON  (pro.PRO_CODGRP = grp.GRP_CODIGO) '+
            '  INNER JOIN TB_SUBGRUPOS sbg '+
            '  ON  (pro.PRO_CODSBG = sbg.SBG_CODIGO) '+
            '  inner join tb_medida med '+
            '  ON(med.med_codigo = pro.pro_codmed) '+
            '  INNER JOIN TB_MARCA_PRODUTO mar '+
            '  ON  (pro.PRO_CODMRC = mar.mrc_CODIGO) '+
            '  INNER JOIN TB_PRECO PRE '+
            '  ON (PRE.PRC_CODPRO = pro.PRO_CODIGO)' ;

  if (Parametros.CodigoEmpresa > 0 ) and ( Parametros.TipoEmpresa = '2' ) then
  Begin
    Result := Result +
                    '  INNER JOIN TB_PROD_FORN Tb_prod_forn  '+
                    '  ON  (Tb_prod_forn.PFR_CODPRO = pro.PRO_CODIGO) '+
                    '  INNER JOIN  TB_EMPRESA Tb_fornecedor '+
                    '  ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO) ';
  end;
end;

function TFr_Imp_Produtos.WhereSql(Parametros:TParamProdutos):String;
Begin
  with Parametros do
  Begin
    Result := 'WHERE  ( (PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C'') ) ';

    if CodigoEstabelecimento > 0 then
      Result := Result + ' AND PRO_CODMHA = :PRO_CODMHA ';

    if (CodigoEstoque > 0 ) then
      Result := Result + ' AND EST_CODETS = :ETS_CODIGO ';

    if (CodigoGrupo > 0 ) then
      Result := Result + ' AND (PRO_CODGRP =:PRO_CODGRP) ';

    if (CodigosubGrupo > 0 ) then
      Result := Result + ' AND (PRO_CODSBG =:PRO_CODSBG) ';

    if (CodigoMarca > 0 ) then
      Result := Result + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

    if (CodigoEmpresa > 0) and (TipoEmpresa = '2' ) then
      Result := Result + ' AND (PFR_CODFOR =:PFR_CODFOR) ';

    if (DescricaoProduto <> '' ) then
      Result := Result + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

    if EstoqueMinimo then
      Result := Result + ' AND (EST_QTDE <= PRO_QTDE_MIN)';

    if EstoquePositivo then
      Result := Result + ' AND (EST_QTDE > 0)';

    if EstoqueNegativo then
      Result := Result + ' AND (EST_QTDE < 0)';

    if not Inativos then
      Result := Result + ' AND (PRO_ATIVO = ''S'') ';

    if CodigoTabelaPreco > 0 then
      Result := Result + 'AND (PRC_CODTPR=:PRC_CODTPR) ';
  End;
End;



procedure TFr_Imp_Produtos.PassarParametros(Consulta:TSTQuery;Parametros:TParamProdutos);
begin
  inherited;
  with Consulta, Parametros do
  Begin
    if CodigoTabelaPreco > 0 then
      ParamByName('PRC_CODTPR').AsInteger:= CodigoTabelaPreco;

    if CodigoEstabelecimento > 0 then
      ParamByName('PRO_CODMHA').AsInteger:= CodigoEstabelecimento;

    if ( CodigoEstoque > 0 ) then
      ParamByName('ETS_CODIGO').AsInteger:= CodigoEstoque;

    if ( CodigoGrupo > 0 ) then
      ParamByName('PRO_CODGRP').AsInteger := CodigoGrupo;

    if ( CodigoSubGrupo > 0 ) then
      ParamByName('PRO_CODSBG').AsInteger:= CodigoSubGrupo;

    if ( CodigoMarca > 0 ) then
      ParamByName('PRO_CODMRC').AsInteger := CodigoMarca;

    if (CodigoEmpresa > 0) and (TipoEmpresa = '2') then
        ParamByName('PFR_CODFOR').AsInteger := CodigoEmpresa;

    if DescricaoProduto <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(DescricaoProduto,1,98) + '%';
  end;
end;

procedure TFr_Imp_Produtos.ExportaResultadoProdutos(Pc_Caminho:String);
Var
  Lc_Qry_Produtos : TSTQuery;
  Lc_Excel, Lc_Sheet, Chart : Variant;
  Lc_Linha : Integer;
  Lc_SqlTxt : String;
  Lc_Parametros : TParamProdutos;
  Lc_Formulatotal : String;
Begin
  Try
    Lc_Qry_Produtos := CtrlEstoque.GeraQuery;
    Lc_Parametros := TParamProdutos.Create;
    Lc_Parametros := getParametros;
    with Lc_Qry_Produtos do
    Begin
      Lc_SqlTxt := concat(
                      'select g.grp_descricao,s.sbg_descricao, pro.PRO_CODIGO, pro.PRO_DESCRICAO, pro.PRO_SUB_TRIB ',
                      'from tb_produto pro ',
                      '  inner join tb_grupos g ',
                      '  on (pro.pro_codgrp = g.grp_codigo) ',
                      '  inner join tb_subgrupos s ',
                      '  on (pro.pro_codsbg = s.sbg_codigo) ',
                      '  inner join tb_marca_produto m ',
                      '  on (m.mrc_codigo = pro.pro_codmrc)'
                      );
      Lc_SqlTxt := concat(Lc_SqlTxt,
                         InnerJoinSql(Lc_Parametros)
                         );
      Lc_SqlTxt := concat(Lc_SqlTxt,
                          WhereSql(Lc_Parametros)
                          );
      Lc_SqlTxt := concat(Lc_SqlTxt,
                          ' order by g.grp_descricao, s.sbg_descricao, m.mrc_descricao '
                          );
      SQL.Add(Lc_SqlTxt);
      PassarParametros(Lc_Qry_Produtos,Lc_Parametros);
      Active := True;
      First;
      //cria a aplicação
      Lc_Excel := CreateOleObject('Excel.Application');
      //adiciona pasta de trabalho
      Lc_Excel.WorkBooks.Add;
      //planilha recebendo variável nome
      Lc_Excel.WorkSheets[1].Name := 'Periodo';
      //Repassando variável
      Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
      //Cabeçalho 1º Linha
      Lc_Linha := 1;
      Pc_PreenceCelulaExcel(False,Lc_Sheet, Lc_Linha, 1,5,16,1,'','RESULTADO POR PRODUTO');
      inc(Lc_Linha);
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 1,1,50,1,'','Produto');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 2,2,16,1,'','Quantidade de Compra');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 3,3,16,1,'','Valor de Compra');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 4,4,16,1,'','Quantidade de Venda');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 5,5,16,1,'','Valor de Venda');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 6,6,16,1,'','% do produto Vendido');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 7,7,16,1,'','Custo produto Vendido');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 8,8,16,1,'','Valor de Comissão');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 9,9,16,1,'','Valor ICMS ST');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 10,10,16,1,'','Valor ICMS Próprio');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 11,11,16,1,'','PIS');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 12,12,16,1,'','COFINS');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 13,13,16,1,'','CONT. SIND');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 14,14,16,1,'','IRRPJ');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 15,15,16,1,'','Saldo de Estoque');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 16,16,16,1,'','Lucro');

      Lc_Qry_Produtos.first;
      Lc_Qry_Produtos.FetChall;
      while not Lc_Qry_Produtos.eof do
      Begin
        inc(Lc_Linha);
        Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 1,1,50,1,'',FieldByName('PRO_CODIGO').asAnsiString + ' - ' + FieldByName('PRO_DESCRICAO').asAnsiString );
        ExportaConsultaCompras(Lc_Sheet,Lc_Linha,FieldByName('PRO_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
        ExportaConsultaVendas(Lc_Sheet,Lc_Linha,FieldByName('PRO_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
        Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 6,6,16,3,'0,00%','=RC[-2]/RC[-4]');
        Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 7,7,16,3,'#.##0,00','=RC[-4]*RC[-1]');
        ExportaConsultaComissao(Lc_Sheet,Lc_Linha,FieldByName('PRO_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
        ExportaConsultaST(Lc_Sheet,Lc_Linha,FieldByName('PRO_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
        ExportaConsultaICMS(Lc_Sheet,Lc_Linha,FieldByName('PRO_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
        ExportaConsultaImpostos(Lc_Sheet,Lc_Linha,FieldByName('PRO_CODIGO').AsInteger,E_Data_Ini.DateTime,E_Data_Fim.DateTime);
        Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 15,15,16,3,'#.##0,00','=RC[-13]-RC[-11]');
        Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 16,16,16,3,'#.##0,00','=RC[-11]-RC[-9]-RC[-8]-RC[-6]-RC[-5]-RC[-4]-RC[-3]-RC[-2]');
        Lc_Qry_Produtos.next;
      End;
      //Totalizador
      Lc_Formulatotal := '=SUM(R[-' + IntToStr(Lc_Linha - 2) + ']C:R[-1]C)';
      inc(Lc_Linha);
      inc(Lc_Linha);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 2,2,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 3,3,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 4,4,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 5,5,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 6,6,16,3,'0,00%','=AVERAGE(R[-' + IntToStr(Lc_Linha - 2) + ']C:R[-1]C)');
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 7,7,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 8,8,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 9,9,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 10,10,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 11,11,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 12,12,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 13,13,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 14,14,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 15,15,16,3,'#.##0,00',Lc_Formulatotal);
      Pc_PreenceCelulaExcel(false,Lc_Sheet, Lc_Linha, 16,16,16,3,'',Lc_Formulatotal);
      Lc_Sheet.Range['A1','A1'].Select;
    End;
    //Abre o excel
    Lc_Excel.WorkBooks[1].Sheets[1].SaveAs(Pc_Caminho);
    Lc_Excel.Visible := true;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry_Produtos);
  End;

End;

procedure TFr_Imp_Produtos.ExportaConsultaCompras(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
Var
  Lc_Qry_compras : TSTQuery;
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Vl_Aux : String;
Begin
  Try
    Lc_Qry_compras := CtrlEstoque.GeraQuery;
    with Lc_Qry_compras do
    Begin
      SQL.Add('SELECT '+
              'I.ITF_QTDE, '+
              'I.ITF_VL_UNIT, '+
              'I.ITF_VL_CUSTO, '+
              'I.itf_vl_desc '+
              'FROM TB_ITENS_NFL I '+
              '   INNER JOIN tb_pedido P '+
              '   ON (P.ped_codigo = I.itf_codped) '+
              '   INNER JOIN tb_nota_fiscal N '+
              '   ON (N.nfl_codped = P.ped_codigo) '+
              'WHERE (ITF_OPER = ''C'') '+
              ' AND (I.ITF_CODPRO =:PRO_CODIGO) '+
              ' and (NFL_STATUS = ''F'' ) '+
              ' and (NFL_CODMHA =:NFL_CODMHA) '+
              ' and (ITF_ESTOQUE = ''S'') '+
              ' AND ( (NFL_TIPO = ''EI'') or (NFL_TIPO = ''EE'') ) ');
      if ChBx_Periodo.Checked then
        SQL.Add(' AND (N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM)');

      if DBLCB_Empresa.Text <> '' then
        SQL.Add(' AND (N.nfl_CODEMP =:EMP_CODIGO)');

      //Passagem de Parametros
      ParambyName('PRO_CODIGO').asInteger := CodigoProduto;
      ParambyName('NFL_CODMHA').asInteger := Gb_CodMha;

      if ChBx_Periodo.Checked then
      Begin
        ParambyName('DATAINI').asDateTime := DAtaInicial;
        ParambyName('DATAFIM').asDateTime := DataFinal;
      End;

      if DBLCB_Empresa.Text <> '' then
        ParambyName('EMP_CODIGO').asInteger := DBLCB_Empresa.KeyValue;

      Active := True;
      First;
      Lc_Qtde := 0;
      Lc_Valor := 0;
      while not eof do
      Begin
        Lc_Qtde := Lc_Qtde + FieldByName('ITF_QTDE').asfloat;
        Lc_Valor := Lc_Valor + ( (FieldByName('ITF_QTDE').asfloat * FieldByName('ITF_VL_CUSTO').AsCurrency) - FieldByName('itf_vl_desc').AsCurrency);
        next;
      End;
      Lc_Vl_Aux := FloatToStrF(Lc_Qtde,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 2,2,16,3,'#.##0,00',Lc_Qtde);
      Lc_Vl_Aux := FloatToStrF(Lc_Valor,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 3,3,16,3,'#.##0,00',Lc_Valor);
    End;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry_compras);
  End;
End;

procedure TFr_Imp_Produtos.ExportaConsultaVendas(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
Var
  Lc_Qry_Vendas : TSTQuery;
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Vl_Aux : String;
Begin
  Try
    Lc_Qry_Vendas := CtrlEstoque.GeraQuery;
    with Lc_Qry_Vendas do
    Begin
      SQL.Add('SELECT '+
              'I.ITF_QTDE, '+
              'I.ITF_VL_UNIT, '+
              'I.itf_vl_desc '+
              'FROM TB_ITENS_NFL I '+
              '   INNER JOIN tb_pedido P '+
              '   ON (P.ped_codigo = I.itf_codped) '+
              '   INNER JOIN tb_nota_fiscal N '+
              '   ON (N.nfl_codped = P.ped_codigo) '+
              'WHERE (ITF_OPER = ''V'') '+
              ' AND (I.ITF_CODPRO =:PRO_CODIGO) '+
              ' and (NFL_STATUS = ''F'' ) '+
              ' and (NFL_CODMHA =:NFL_CODMHA) '+
              ' AND ( (NFL_TIPO = ''SI'') or (NFL_TIPO = ''SE'') ) ');
      if ChBx_Periodo.Checked then
        sql.Add(' AND (N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM)');
      ParambyName('PRO_CODIGO').asInteger := CodigoProduto;
      ParambyName('NFL_CODMHA').asInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      Begin
        ParambyName('DATAINI').asDateTime := DAtaInicial;
        ParambyName('DATAFIM').asDateTime := DataFinal;
      End;
      Active := True;
      First;
      Lc_Qtde := 0;
      Lc_Valor := 0;
      while not eof do
      Begin
        Lc_Qtde := Lc_Qtde + FieldByName('ITF_QTDE').asfloat;
        Lc_Valor := Lc_Valor + ( (FieldByName('ITF_QTDE').asfloat * FieldByName('ITF_VL_UNIT').AsCurrency) - FieldByName('itf_vl_desc').AsCurrency); ;
        next;
      End;
      Lc_Vl_Aux := FloatToStrF(Lc_Qtde,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 4,4,16,3,'#.##0,00',Lc_Qtde);
      Lc_Vl_Aux := FloatToStrF(Lc_Valor,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 5,5,16,3,'#.##0,00',Lc_Valor);
    End;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry_Vendas);
  End;
End;

procedure TFr_Imp_Produtos.ExportaConsultaST(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
Var
  Lc_Qry_ST : TSTQuery;
  Lc_Valor : Real;
  Lc_Vl_Aux : String;
Begin
  Try
    Lc_Qry_ST := CtrlEstoque.GeraQuery;
    with Lc_Qry_ST do
    Begin
      SQL.Add('SELECT '+
              'C.icm_vl_st '+
              'FROM TB_ITENS_NFL I '+
              '   INNER JOIN tb_pedido P '+
              '   ON (P.ped_codigo = I.itf_codped) '+
              '   INNER JOIN tb_nota_fiscal N '+
              '   ON (N.nfl_codped = P.ped_codigo) '+
              '   INNER JOIN tb_itens_icms C '+
              '   ON (C.icm_coditf = I.itf_codigo) '+
              '   INNER JOIN TB_RETORNO_NFE '+
              '   ON (NFE_CODNFL = N.NFL_CODIGO) '+
              'WHERE (ITF_OPER = ''V'') '+
              ' AND (ITF_CODPRO =:PRO_CODIGO) '+
              ' and (NFL_STATUS = ''F'' ) '+
              ' and (NFL_CODMHA =:NFL_CODMHA) '+
              ' AND ( (NFL_TIPO = ''SI'') or (NFL_TIPO = ''SE'') ) '+
              ' AND ( (nfe_codigo IS NOT NULL) or (nfe_codsit = 2)  ) '+
              ' AND (C.icm_vl_st > 0)');

      if ChBx_Periodo.Checked then
        sql.Add(' AND (N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM) ');
      ParambyName('PRO_CODIGO').asInteger := CodigoProduto;
      ParambyName('NFL_CODMHA').asInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      BEgin
        ParambyName('DATAINI').asDateTime := DAtaInicial;
        ParambyName('DATAFIM').asDateTime := DataFinal;
      End;
      Active := True;
      First;
      Lc_Valor := 0;
      while not eof do
      Begin
        Lc_Valor := Lc_Valor + FieldByName('icm_vl_st').AsCurrency ;
        next;
      End;
      Lc_Vl_Aux := FloatToStrF(Lc_Valor,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 9,9,16,3,'#.##0,00',Lc_Valor);
    End;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry_ST);
  End;
End;

procedure TFr_Imp_Produtos.ExportaConsultaICMS(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
Var
  Lc_Qry_ST : TSTQuery;
  Lc_Valor : Real;
  Lc_Vl_Aux : String;
Begin
  Try
    Lc_Qry_ST := CtrlEstoque.GeraQuery;
    with Lc_Qry_ST do
    Begin
      SQL.Add('SELECT '+
              'C.ICM_VL_NR '+
              'FROM TB_ITENS_NFL I '+
              '   INNER JOIN tb_pedido P '+
              '   ON (P.ped_codigo = I.itf_codped) '+
              '   INNER JOIN tb_nota_fiscal N '+
              '   ON (N.nfl_codped = P.ped_codigo) '+
              '   INNER JOIN tb_itens_icms C '+
              '   ON (C.icm_coditf = I.itf_codigo) '+
              '   INNER JOIN TB_RETORNO_NFE '+
              '   ON (NFE_CODNFL = N.NFL_CODIGO) '+
              'WHERE (ITF_OPER = ''V'') '+
              ' AND (ITF_CODPRO =:PRO_CODIGO) '+
              ' and (NFL_STATUS = ''F'' ) '+
              ' and (NFL_CODMHA =:NFL_CODMHA) '+
              ' AND ( (NFL_TIPO = ''SI'') or (NFL_TIPO = ''SE'') ) '+
              ' AND ( (nfe_codigo IS NOT NULL) or (nfe_codsit = 2)  ) '+
              ' AND (C.ICM_VL_NR > 0)');
      if ChBx_Periodo.Checked then
        sql.Add(' AND (N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM) ');
      ParambyName('PRO_CODIGO').asInteger := CodigoProduto;
      ParambyName('NFL_CODMHA').asInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      BEgin
        ParambyName('DATAINI').asDateTime := DAtaInicial;
        ParambyName('DATAFIM').asDateTime := DataFinal;
      End;
      Active := True;
      First;
      Lc_Valor := 0;
      while not eof do
      Begin
        Lc_Valor := Lc_Valor + FieldByName('ICM_VL_NR').AsCurrency ;
        next;
      End;
      Lc_Vl_Aux := FloatToStrF(Lc_Valor,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 10,10,16,3,'#.##0,00',Lc_Valor);
    End;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry_ST);
  End;
End;

procedure TFr_Imp_Produtos.ExportaConsultaComissao(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
Var
  Lc_Qry_Comissao : TSTQuery;
  Lc_Valor : Real;
  Lc_Vl_Aux : String;
Begin
  Try
    Lc_Qry_Comissao := CtrlEstoque.GeraQuery;
    with Lc_Qry_Comissao do
    Begin
      SQL.Add('SELECT '+
              '( ( (I.ITF_QTDE * I.ITF_VL_UNIT) - I.itf_vl_desc ) * I.ITF_AQ_COM ) / 100 ITF_VL_COM '+
              'FROM TB_ITENS_NFL I '+
              '   INNER JOIN tb_pedido P '+
              '   ON (P.ped_codigo = I.itf_codped) '+
              '   INNER JOIN tb_nota_fiscal N '+
              '   ON (N.nfl_codped = P.ped_codigo) '+
              '   INNER JOIN tb_itens_icms C '+
              '   ON (C.icm_coditf = I.itf_codigo) '+
              'WHERE (ITF_OPER = ''V'') '+
              ' and (NFL_STATUS = ''F'' ) '+
              ' AND ( (NFL_TIPO = ''SI'') or (NFL_TIPO = ''SE'') ) '+
              ' and (NFL_CODMHA =:NFL_CODMHA) '+

              'and (I.itf_codpro =:PRO_CODIGO)');
      if ChBx_Periodo.Checked then
        sql.Add(' AND (N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM) ');
      ParambyName('PRO_CODIGO').asInteger := CodigoProduto;
      ParambyName('NFL_CODMHA').asInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      Begin
        ParambyName('DATAINI').asDateTime := DAtaInicial;
        ParambyName('DATAFIM').asDateTime := DataFinal;
      End;
      Active := True;
      First;
      Lc_Valor := 0;
      while not eof do
      Begin
        Lc_Valor := Lc_Valor + FieldByName('ITF_VL_COM').AsCurrency ;
        next;
      End;
      Lc_Vl_Aux := FloatToStrF(Lc_Valor,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 8,8,16,3,'#.##0,00',Lc_Valor);
    End;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry_Comissao);
  End;
End;

procedure TFr_Imp_Produtos.ExportaConsultaImpostos(Pc_Sheet:Variant;Pc_Linha:Integer;codigoProduto:Integer;DataInicial,DataFinal:TdateTime);
Var
  Lc_Qry_Comissao : TSTQuery;
  Lc_Valor : Real;
  Lc_Vl_Aux : String;
Begin
  Try
    Lc_Qry_Comissao := CtrlEstoque.GeraQuery;
    with Lc_Qry_Comissao do
    Begin
      SQL.Add('SELECT '+
              'I.ITF_QTDE, '+
              'I.ITF_VL_UNIT, '+
              'I.itf_vl_desc '+
              'FROM TB_ITENS_NFL I '+
              '   INNER JOIN tb_pedido P '+
              '   ON (P.ped_codigo = I.itf_codped) '+
              '   INNER JOIN tb_nota_fiscal N '+
              '   ON (N.nfl_codped = P.ped_codigo) '+
              '   INNER JOIN tb_itens_icms C '+
              '   ON (C.icm_coditf = I.itf_codigo) '+
              '   INNER JOIN TB_RETORNO_NFE '+
              '   ON (NFE_CODNFL = NFL_CODIGO) '+
              'WHERE (ITF_OPER = ''V'') '+
              ' and (NFL_STATUS = ''F'' ) '+
              ' AND ( (NFL_TIPO = ''SI'') or (NFL_TIPO = ''SE'') ) '+
              ' and (NFL_CODMHA =:NFL_CODMHA) '+

              ' AND ( (nfe_codigo IS not NULL) or (nfe_codsit = 2)  ) '+
              'and (I.itf_codpro =:PRO_CODIGO)');
      if ChBx_Periodo.Checked then
        sql.Add(' AND (N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM) ');
      ParambyName('PRO_CODIGO').asInteger := CodigoProduto;
      ParambyName('NFL_CODMHA').asInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      Begin
        ParambyName('DATAINI').asDateTime := DAtaInicial;
        ParambyName('DATAFIM').asDateTime := DataFinal;
      End;
      Active := True;
      First;
      Lc_Valor := 0;
      while not eof do
      Begin
        Lc_Valor := Lc_Valor + ( (FieldByName('ITF_QTDE').asfloat * FieldByName('ITF_VL_UNIT').AsCurrency) - FieldByName('itf_vl_desc').AsCurrency);
        next;
      End;
      Lc_Vl_Aux := FloatToStrF(Lc_Valor,ffGeneral,10,2);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 11,11,16,3,'#.##0,00',Lc_Valor * 0.0165);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 12,12,16,3,'#.##0,00',Lc_Valor * 0.03);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 13,13,16,3,'#.##0,00',Lc_Valor * 0.01);
      Pc_PreenceCelulaExcel(false,Pc_Sheet, Pc_Linha, 14,14,16,3,'#.##0,00',Lc_Valor * 0.025);
    End;
  Finally
    CtrlEstoque.FinalizaQuery(Lc_Qry_Comissao);
  End;
End;

procedure TFr_Imp_Produtos.LBx_TipoRelatorioClick(Sender: TObject);
begin
  //Desativatodos os componentes
  Pc_ControlaItensIterface;
  //Ativa conforme a entrada no Case
  case LBx_TipoRelatorio.ItemIndex of
    0:begin//Cadastro de Produtos
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(DBLCB_Marca);
        EnblControl(Grp_Mov_Empresa);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        EnblControl(ChBx_SemMov);
        EnblControl(ChBx_Est_Min);
        EnblControl(chbx_positivo);
        EnblControl(chbx_negativo);
        EnblControl(Chbx_Inativos);
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(Pnl_Estoque_Inventario);
        EnblControl(ChBx_InternetPublished);
      end;
    1:begin //Saldo do Estoque
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(DBLCB_Marca);
        EnblControl(Grp_Mov_Empresa);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        EnblControl(ChBx_SemMov);
        EnblControl(ChBx_Est_Min);
        EnblControl(chbx_positivo);
        EnblControl(chbx_negativo);
        EnblControl(Chbx_Inativos);
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(Pnl_Estoque_Inventario);
        EnblControl(ChBx_InternetPublished);
      end;
    2:begin//Movimentação
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(DBLCB_Marca);
        EnblControl(Chbx_AnaliseMovimento);
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        Pc_DefineInventario;
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(DBLCB_Empresa);
        EnblControl(Pnl_Estoque_Inventario);
        EnblControl(ChBx_Contagem);
        EnblControl(chbx_AuditoriaEstoque);
        EnblControl(E_BuscaCodigoProduto);
        EnblControl(E_BuscaDescricaoProduto);
        sb_estoque.Enabled := It_estoque;
      end;
    3:begin//Tabela de Produtos
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(Grp_Mov_Empresa);
        EnblControl(DBLCB_Marca);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        EnblControl(ChBx_SemMov);
        EnblControl(ChBx_Est_Min);
        EnblControl(chbx_positivo);
        EnblControl(chbx_negativo);
        EnblControl(Chbx_Inativos);
        EnblControl(Chbx_Vl_Venda_Maior_Zero);
        EnblControl(ChBx_InternetPublished);
      end;
    4:begin//Curva ABC
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(Grp_Mov_Empresa);
        EnblControl(DBLCB_Marca);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        Pc_DefineParametroOrdenacao(0);
        EnblControl(ChBx_Est_Min);
        EnblControl(chbx_positivo);
        EnblControl(chbx_negativo);
        EnblControl(E_Curva_Nr_Mes);
        EnblControl(E_Data_Fim);
      end;
    5:Begin//Inventario
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        Pc_DefineInventario;
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(DBLCB_Marca);
        EnblControl(Pnl_Estoque_Inventario);
        Sb_Inventario.Enabled := iT_INVENTARIAR;
        EnblControl(chbx_AuditoriaEstoque);
        EnblControl(ChBx_Contagem);
        EnblControl(chbx_positivo);
        EnblControl(E_BuscaCodigoProduto);
        EnblControl(E_BuscaDescricaoProduto);
      end;
    6:begin //Análise de Alteração de Preço
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(Chbx_AlteracaoPrecoCompra);
        EnblControl(DBLCB_Marca);
      end;
    7:begin//Produtos Mais Vendidos
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(ChBx_Periodo);
        EnblControl(ChBx_Periodo);
        EnblControl(Grp_Vendedor);
        EnblControl(DBLCB_Marca);
        EnblControl(Rb_Vend_Cliente);
        EnblControl(Rb_Vend_Pedido);
        EnblControl(dblcb_Vendedor);
        DM_ListaConsultas.Pc_ListaVendedor;
        EnblControl(Grp_Mov_Empresa);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        Pc_AbreListaEmpresa(-1,'EMP_NOME');
      end;
    8:begin//Reposição
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(DBLCB_Marca);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Empresa);
        EnblControl(ChBx_Est_Min);
        EnblControl(Chbx_Positivo);
        EnblControl(chbx_negativo);
        EnblControl(ChBx_SemMov);
        EnblControl(Chbx_Inativos);
      end;
    9:begin//Conferencia de Estoque
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        Pc_DefineParametroOrdenacao(9);
        EnblControl(Rb_Produto);
        EnblControl(chbx_positivo);
        EnblControl(chbx_negativo);
        EnblControl(Chbx_Inativos);
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        EnblControl(E_Busca_Local);
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(DBLCB_Marca);
        EnblControl(Pnl_Estoque_Inventario);
      end;
    10:Begin
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(ChBx_Periodo);
        EnblControl(ChBx_Periodo);
        EnblControl(E_Data_Ini);
        EnblControl(E_Data_Fim);
        EnblControl(ChBx_UltimaAlteracaoVenda);
       end;
    11:Begin
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        Pc_DefineInventario;
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(DBLCB_Marca);
        EnblControl(Pnl_Estoque_Inventario);
       end;
    12:Begin//Inventario
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        Pc_DefineInventario;
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(DBLCB_Marca);
        EnblControl(Pnl_Estoque_Inventario);
      end;
    13:begin//Venda por Item
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(ChBx_Periodo);
        EnblControl(ChBx_Periodo);
        EnblControl(Grp_Vendedor);
        EnblControl(Rb_Vend_Cliente);
        EnblControl(Rb_Vend_Pedido);
        EnblControl(dblcb_Vendedor);
        DM_ListaConsultas.Pc_ListaVendedor;
        EnblControl(Grp_Mov_Empresa);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        Pc_AbreListaEMpresa(-1,'EMP_NOME');
       end;
    14:begin//Cadastro de Serviços

       end;
    15:begin//Exportar Tabelas de Preço
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(DBLCB_Tabela_Preco);
        EnblControl(Grp_Mov_Empresa);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        EnblControl(ChBx_SemMov);
        EnblControl(ChBx_Est_Min);
        EnblControl(chbx_positivo);
        EnblControl(chbx_negativo);
        EnblControl(Chbx_Inativos);
       end;
    16:begin//Exportar Analise de compra
        EnblControl(ChBx_Periodo);
        EnblControl(ChBx_Periodo);
        EnblControl(Fm_ListaEstoques.DBLCB_Estoque);
        Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
        EnblControl(DBLCB_Grupos);
        EnblControl(DBLCB_SubGrupos);
        EnblControl(DBLCB_Marca);
        EnblControl(E_BuscaCodigoProduto);
        EnblControl(E_BuscaDescricaoProduto);
        EnblControl(Grp_Mov_Empresa);
        EnblControl(Rb_Empresa);
        EnblControl(Rb_Produto);
        EnblControl(Rb_Produto);
        EnblControl(DBLCB_Empresa);
        EnblControl(Chbx_Inativos);
       end;
    17: begin//Produtos Mais Vendidos
          EnblControl(ChBx_Periodo);
          EnblControl(ChBx_Periodo);
          EnblControl(DBLCB_Grupos);
          EnblControl(DBLCB_SubGrupos);
          EnblControl(Grp_Vendedor);
          EnblControl(Rb_Vend_Cliente);
          EnblControl(Rb_Vend_Pedido);
          EnblControl(dblcb_Vendedor);
          DM_ListaConsultas.Pc_ListaVendedor;
          EnblControl(Grp_Mov_Empresa);
          EnblControl(Rb_Produto);
          EnblControl(Rb_Produto);
          Pc_AbreListaEmpresa(-1,'EMP_NOME');
        end;
    18: begin //Produtos vendidos por marca {adr 19/09/14}
          EnblControl( ChBx_Periodo );
          EnblControl( E_Data_Ini );
          EnblControl( E_Data_Fim );
          EnblControl( Fm_ListaEstoques.DBLCB_Estoque );
          Fm_ListaEstoques.Dblcb_Estoque.KeyValue := Gb_Estoque;
          DsblControl( DBLCB_Tabela_Preco );
          DsblControl( DBLCB_Grupos );
          DsblControl( DBLCB_SubGrupos );
          EnblControl( DBLCB_Marca );
          EnblControl( E_BuscaCodigoProduto );
          EnblControl( E_BuscaDescricaoProduto );
          DsblControl( E_Busca_Local );
          DsblControl( Grp_Mov_Empresa );
          DsblControl( Grp_Vendedor );
          DsblControl( dblcb_Vendedor );
          DsblControl( DBLCB_Empresa );
          DsblControl( E_BuscaCodigoProduto );
        end;
    19: begin //Produtos vendidos por marca {adr 19/09/14}
          EnblControl( ChBx_Periodo );
          EnblControl( E_Data_Ini );
          EnblControl( E_Data_Fim );
          EnblControl( DBLCB_Grupos );
          EnblControl( DBLCB_SubGrupos );
          EnblControl( DBLCB_Marca );
          EnblControl( E_BuscaCodigoProduto );
          EnblControl( E_BuscaDescricaoProduto );
          EnblControl( E_Busca_Local );
        end;
    22: begin //Produtos vendidos por marca {adr 19/09/14}
          EnblControl( ChBx_Periodo );
          EnblControl( E_Data_Ini );
          EnblControl( E_Data_Fim );
          ListarEmpresasRazao;
        end;
    25: begin //Produtos vendidos por marca {adr 19/09/14}
          ChBx_Periodo.Checked := True;
          DsblControl( ChBx_Periodo );
          EnblControl( E_Data_Ini );
          EnblControl( E_Data_Fim );
        end;
    end;
end;

PROCEDURE TFr_Imp_Produtos.ListarEmpresasRazao;
begin
  if ( Rb_Empresa.checked ) then
    Pc_ListaEmpresaDbLookUpComboBox(1,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
  else
    Pc_ListaEmpresaDbLookUpComboBox(2,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

PROCEDURE TFr_Imp_Produtos.ListarEmpresasFantasia;
begin
  if ( Rb_Empresa.checked ) then
    Pc_ListaEmpresaDbLookUpComboBox(1,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
  else
    Pc_ListaEmpresaDbLookUpComboBox(2,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

end.

