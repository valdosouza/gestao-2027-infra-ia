unit Un_Produtos;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, StrUtils, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, synacode, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Un_Pesq_Empresa, ACBrValidador, ControllerProduto, IniFiles, ControllerProductUfBenef, tblProductUfBenef, ControllerProductSimilar, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls, Vcl.DBCtrls, Un_Fm_ListaMedida, QEdit_Setes, STDatabase, ControllerLojaTray, ControllerTributacao;


type

  TCustomGridHelper = class helper for TCustomGrid
  public
    procedure DelRow(ARow: Integer);
  end;

  TFr_Produtos = class(TForm)
    Ds_Prod_Forn: TDataSource;
    Ds_MarcaProduto: TDataSource;
    Qr_Insere: TSTQuery;
    Ds_Servico: TDataSource;
    Ds_Estoque: TDataSource;
    Qr_Prod_Prod: TSTQuery;
    Ds_Prod_Prod: TDataSource;
    Qr_Acao: TSTQuery;
    Qr_CopiaProduto: TSTQuery;
    Qr_CopiaBase: TSTQuery;
    Qr_CopiaBaseFTC_CODIGO: TIntegerField;
    Qr_CopiaBaseFTC_CODICT: TIntegerField;
    Qr_CopiaBaseFTC_CODITF: TIntegerField;
    Qr_CopiaBaseFTC_TIPO: TStringField;
    Qr_CopiaBaseFTC_CODVCL: TIntegerField;
    Qr_CopiaBasePRO_DESCRICAO: TStringField;
    Qr_CopiaBaseFTC_CODPRO: TIntegerField;
    Qr_CopiaBaseFTC_CS_UNIT: TFloatField;
    Qr_CopiaBasePRO_CODMED: TIntegerField;
    Qr_CopiaBasePRO_VL_CUSTOMED: TFloatField;
    Qr_botao: TSTQuery;
    Ds_botao: TDataSource;
    Qr_botaoBTN_CODIGO: TIntegerField;
    Qr_botaoBTN_DESCRICAO: TStringField;
    Qr_botaoIBT_SEQUENCIA: TIntegerField;
    Qr_botaoBTN_ALTURA: TIntegerField;
    Qr_botaoBTN_LARGURA: TIntegerField;
    Qr_botaoBTN_LABEL: TStringField;
    Qr_botaoBTN_IMAGEM: TBlobField;
    Qr_botaoBTN_MRG_SUP: TIntegerField;
    Qr_Series: TSTQuery;
    Ds_Series: TDataSource;
    Qr_SeriesSRP_CODIGO: TIntegerField;
    Qr_SeriesSRP_NUMERO: TStringField;
    Qr_SeriesPED_ORIGEM: TIntegerField;
    Qr_SeriesPED_ENTRADA: TIntegerField;
    Qr_SeriesPED_DESTINO: TIntegerField;
    Qr_SeriesPED_SAIDA: TIntegerField;
    Qr_SeriesSRP_ORIGEM: TStringField;
    Qr_SeriesSRP_DESTINO: TStringField;
    Pop_Serie: TPopupMenu;
    LiberarNmerodeSrie1: TMenuItem;
    Qr_Servico: TSTQuery;
    Qr_Prod_Forn: TSTQuery;
    qrProducao: TSTQuery;
    dsProducao: TDataSource;
    MainMenu1: TMainMenu;
    TarefaImagens: TMenuItem;
    ImagensdeProdutos1: TMenuItem;
    Qr_ServicoPSI_CODIGO: TIntegerField;
    Qr_ServicoPSI_CODPRO: TIntegerField;
    Qr_ServicoPSI_CODSRV: TIntegerField;
    Qr_ServicoPRO_DESCRICAO: TStringField;
    Qr_ServicoPRC_VL_VDA: TFMTBCDField;
    Qr_Product_Similar: TSTQuery;
    Ds_Product_Similar: TDataSource;
    ds_tabela_preco_2: TDataSource;
    Cds_Tabela_Preco: TClientDataSet;
    Cds_Tabela_PrecoPRC_AQ_COM: TBCDField;
    Cds_Tabela_PrecoPRC_VL_VDA: TFMTBCDField;
    Cds_Tabela_PrecoPRC_MAR_LRC: TFMTBCDField;
    Cds_Tabela_PrecoPRC_QT_MIN: TBCDField;
    Cds_Tabela_PrecoTPR_NOME: TWideStringField;
    Cds_Tabela_PrecoTPR_MAR_LRC: TFMTBCDField;
    Cds_Tabela_PrecoTPR_CASA_DECIMAL: TIntegerField;
    Cds_Tabela_PrecoPRC_CODTPR: TIntegerField;
    Cds_Tabela_PrecoPRC_CODIGO: TIntegerField;
    abeladePreo1: TMenuItem;
    cds_Estoque: TClientDataSet;
    cds_EstoqueETS_DESCRICAO: TWideStringField;
    cds_EstoqueEST_CODIGO: TIntegerField;
    cds_EstoqueEST_QTDE: TFMTBCDField;
    cds_EstoqueEST_QTDE_MIN: TBCDField;
    cds_EstoqueETS_CODIGO: TIntegerField;
    cds_EstoqueETS_PRINCIPAL: TWideStringField;
    cds_EstoqueEST_CODPRO: TIntegerField;
    Cds_Tabela_PrecoTPR_MAR_PRIORITARIA: TStringField;
    VariaodeProdutos1: TMenuItem;
    Qr_Impostos: TSTQuery;
    Qr_ImpostosTRB_CODIGO: TIntegerField;
    Qr_ImpostosNAT_CFOP: TStringField;
    Qr_ImpostosUFE_SIGLA: TStringField;
    Qr_ImpostosTRB_CONSUMIDOR: TStringField;
    Qr_ImpostosTRB_MICRO: TStringField;
    Qr_ImpostosTRB_ORIGEM: TStringField;
    Qr_ImpostosTRB_CST: TStringField;
    Qr_ImpostosTRB_CSOSN: TStringField;
    Qr_ImpostosTRB_ST_ICMS: TStringField;
    Qr_ImpostosTRB_AQ_ICMS: TBCDField;
    Qr_ImpostosTRB_RD_AQ_ICMS: TBCDField;
    Qr_ImpostosTRB_RD_BS_ICMS: TBCDField;
    Qr_ImpostosOBS_DESCRICAO: TStringField;
    Ds_Impostos: TDataSource;
    Panel1: TPanel;
    PG_Informacoes: TPageControl;
    tbs_estoque: TTabSheet;
    Panel8: TPanel;
    Label31: TLabel;
    Label6: TLabel;
    Lb_Peso: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label32: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label22: TLabel;
    Sb_revestimento: TSpeedButton;
    Label21: TLabel;
    Sb_Embalagem: TSpeedButton;
    Label4: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    Label46: TLabel;
    DBGrid3: TDBGrid;
    Rdg_Composicao: TGroupBox;
    RB_Cps_Sem_Uso: TRadioButton;
    RB_Cps_Som_Itens: TRadioButton;
    RB_Cps_Cascata_Qtde: TRadioButton;
    RB_Cps_Lanca_Item: TRadioButton;
    RB_Cps_Qtde_Item: TRadioButton;
    E_Local: TEdit;
    E_QtdeMinima: TEdit;
    E_Peso: TEdit;
    E_PrecoCusto: TEdit;
    E_CustoFab: TEdit;
    E_custoReal: TEdit;
    E_Largura: TEdit;
    E_Comprimento: TEdit;
    E_Altura: TEdit;
    DBLCB_Revestimento: TDBLookupComboBox;
    DBLCB_Embalagem: TDBLookupComboBox;
    E_Divisor: TEdit;
    Cb_Origem: TComboBox;
    Cb_Tipo_Produto: TComboBox;
    Fm_UnidadeComercial: TFm_ListaMedida;
    Cb_available: TComboBox;
    E_Days_to_available: TEdit;
    E_Pro_Sequencia: TEdit;
    E_PrecoTroca: TEdit;
    tbs_observacao: TTabSheet;
    Pnl_obs: TPanel;
    ChBx_Estoque: TCheckBox;
    ChBx_ativo: TCheckBox;
    ChBx_Impressao: TCheckBox;
    Chbx_Destaque: TCheckBox;
    Chbx_Series: TCheckBox;
    ChBx_exclusivo: TCheckBox;
    ChBx_Internet: TCheckBox;
    Chbx_ForaLinha: TCheckBox;
    ChBx_indEscala: TCheckBox;
    E_Observacao: TMemo;
    Chbx_Promocao: TCheckBox;
    Panel4: TPanel;
    Sb_Html: TSpeedButton;
    Chbx_Send_Internet: TCheckBox;
    tbs_tbpreco: TTabSheet;
    Pnl_Tabela_Preco: TPanel;
    DBG_Preco: TDBGrid;
    Chbx_fixed_rate: TCheckBox;
    tbs_fornecedor: TTabSheet;
    pnl_fornecedor: TPanel;
    SB_exc_fornec: TSpeedButton;
    SB_Ins_fornec: TSpeedButton;
    tbs_impostos: TTabSheet;
    Pnl_Imposto: TPanel;
    Label2: TLabel;
    Label19: TLabel;
    RG_SUBTRIB: TRadioGroup;
    Cb_Finalid_Tributa: TComboBox;
    Fm_UnidadeTributavel: TFm_ListaMedida;
    E_Qtde_Trib: TEdit;
    pnl_regra_tributacao: TPanel;
    Label45: TLabel;
    SB_Impostos: TSpeedButton;
    DBG_Impostos: TDBGrid;
    tbs_instalacao: TTabSheet;
    Panel7: TPanel;
    SB_INS_SERV: TSpeedButton;
    SB_EXC_SERV: TSpeedButton;
    Label18: TLabel;
    grid_instalacao: TDBGrid;
    E_PrecoInstala: TEdit_Setes;
    tbs_composicao: TTabSheet;
    Pnl_Composicao: TPanel;
    Sb_Ins_Produto: TSpeedButton;
    Sb_Alt_Produto: TSpeedButton;
    Sb_Exc_Produto: TSpeedButton;
    dbg_composicao: TDBGrid;
    Tbs_Aplicacao: TTabSheet;
    Panel10: TPanel;
    E_Aplicacao: TMemo;
    tbs_botao: TTabSheet;
    Pnl_Botao: TPanel;
    Sb_Exc_Botao: TSpeedButton;
    Sb_Alt_botao: TSpeedButton;
    Sb_Ins_botao: TSpeedButton;
    Label14: TLabel;
    Label17: TLabel;
    Label25: TLabel;
    DBEdit2: TEdit;
    E_Desc_botao: TEdit;
    E_Sequencia: TEdit;
    GroupBox2: TGroupBox;
    Sb_Amostra: TSpeedButton;
    tbs_series: TTabSheet;
    Pnl_Series: TPanel;
    Sb_Ins_Serie: TSpeedButton;
    Sb_alt_Serie: TSpeedButton;
    Sb_Exc_Serie: TSpeedButton;
    Dbg_serie: TDBGrid;
    tbs_Internet: TTabSheet;
    Pnl_Internet: TPanel;
    Label42: TLabel;
    Sb_Category: TSpeedButton;
    Label47: TLabel;
    Trw_Cadastro: TTreeView;
    E_Cd_Produto_Tray: TEdit;
    tbs_Producao: TTabSheet;
    Panel2: TPanel;
    Sb_exc_producao: TSpeedButton;
    Sb_alt_producao: TSpeedButton;
    Sb_ins_producao: TSpeedButton;
    dbProducao: TDBGrid;
    tbs_product_similar: TTabSheet;
    Panel3: TPanel;
    DBG_Product_Similar: TDBGrid;
    Panel5: TPanel;
    Sb_Ins_Product_Similar: TSpeedButton;
    Sb_Exc_Product_Similar: TSpeedButton;
    Panel24: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    SB_Gravar: TSpeedButton;
    pnl_fundo: TPanel;
    Label3: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    SB_Grupos: TSpeedButton;
    Label30: TLabel;
    Sb_Marca: TSpeedButton;
    Label1: TLabel;
    lbl_nr_fabricacao: TLabel;
    lbl_cd_forn: TLabel;
    lbl_cd_barra: TLabel;
    Label39: TLabel;
    Sb_Classificacao: TSpeedButton;
    Label27: TLabel;
    Label37: TLabel;
    Label43: TLabel;
    Sb_Cest: TSpeedButton;
    Label16: TLabel;
    E_DescricaoProduto: TEdit;
    DBLCB_Grupo: TDBLookupComboBox;
    DBLCB_SubGrupo: TDBLookupComboBox;
    DBLCB_Marca: TDBLookupComboBox;
    E_Fabricante: TEdit;
    E_Codigo: TEdit;
    E_CodigoFor: TEdit;
    E_Barras: TEdit;
    E_CodClasfiscal: TEdit;
    E_Dt_Ultima_compra: TMaskEdit;
    E_Dt_Ultima_Venda: TMaskEdit;
    E_CEST: TEdit;
    E_DT_Vencimento: TDateTimePicker;
    E_Custo_Last: TEdit;
    DBG_Fornecedor: TDBGrid;
    pnl_beneficio_fiscal: TPanel;
    Label44: TLabel;
    Sb_Exc_Beneficio: TSpeedButton;
    Sb_Ins_Beneficio: TSpeedButton;
    Strgrd_Benefi_UF: TStringGrid;
    RB_Cps_auto_reposicao: TRadioButton;
    L_QtdeMinAutoReposicao: TLabel;
    E_QtdeMinAutoReposicao: TEdit;
    tbs_reposicao: TTabSheet;
    pnl_reposicao: TPanel;
    Sb_ins_reposicao: TSpeedButton;
    Sb_edi_reposicao: TSpeedButton;
    Sb_del_reposicao: TSpeedButton;
    Dbg_reposicao: TDBGrid;
    Ds_reposicao: TDataSource;
    Cds_reposicao: TClientDataSet;
    Cds_reposicaoPPD_CODPRO_M: TIntegerField;
    Cds_reposicaoPPD_CODPRO_D: TIntegerField;
    Cds_reposicaoPRO_CODIGOFAB: TStringField;
    Cds_reposicaoPRO_DESCRICAO: TStringField;
    Cds_reposicaoPPD_QTDE: TFloatField;
    Cds_reposicaoPPD_METODO: TStringField;
    Cds_reposicaoPPD_QTDE_USED: TFloatField;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_GruposClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure DBG_FornecedorKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure SB_ImpostosClick(Sender: TObject);
    procedure Sb_MarcaClick(Sender: TObject);
    procedure E_LocalExit(Sender: TObject);
    procedure E_CustoFabExit(Sender: TObject);
    procedure E_BarrasExit(Sender: TObject);
    procedure grid_instalacaoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Sb_Ins_ProdutoClick(Sender: TObject);
    procedure Sb_Alt_ProdutoClick(Sender: TObject);
    procedure Sb_Exc_ProdutoClick(Sender: TObject);
    procedure Sb_EmbalagemClick(Sender: TObject);
    procedure SB_exc_fornecClick(Sender: TObject);
    procedure SB_INS_SERVClick(Sender: TObject);
    procedure SB_EXC_SERVClick(Sender: TObject);
    procedure Sb_ClassificacaoClick(Sender: TObject);
    procedure Qr_botaoAfterOpen(DataSet: TDataSet);
     procedure tbs_botaoShow(Sender: TObject);
    procedure tbs_seriesShow(Sender: TObject);
    procedure Sb_Ins_SerieClick(Sender: TObject);
    procedure Chbx_SeriesClick(Sender: TObject);
    procedure Sb_alt_SerieClick(Sender: TObject);
    procedure Sb_Exc_SerieClick(Sender: TObject);
    procedure Qr_SeriesCalcFields(DataSet: TDataSet);
    procedure LiberarNmerodeSrie1Click(Sender: TObject);
    procedure Dbg_serieTitleClick(Column: TColumn);
    procedure E_custoRealExit(Sender: TObject);
    procedure E_PrecoCustoExit(Sender: TObject);
    procedure dbg_composicaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure E_CodClasfiscalKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Sb_revestimentoClick(Sender: TObject);
    procedure Sb_CategoryClick(Sender: TObject);
    procedure tbs_InternetShow(Sender: TObject);
    procedure Trw_CadastroClick(Sender: TObject);
    procedure Sb_ins_producaoClick(Sender: TObject);
    procedure Sb_alt_producaoClick(Sender: TObject);
    procedure Sb_exc_producaoClick(Sender: TObject);
    procedure tbs_ProducaoShow(Sender: TObject);
    procedure ImagensdeProdutos1Click(Sender: TObject);
    procedure tbs_fornecedorShow(Sender: TObject);
    procedure tbs_composicaoShow(Sender: TObject);
    procedure tbs_instalacaoShow(Sender: TObject);
    procedure Sb_CestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBG_FornecedorDblClick(Sender: TObject);

    procedure SB_Ins_fornecClick(Sender: TObject);
    procedure Sb_Exc_BeneficioClick(Sender: TObject);
    procedure Sb_Ins_BeneficioClick(Sender: TObject);
    procedure tbs_product_similarShow(Sender: TObject);
    procedure Sb_Ins_Product_SimilarClick(Sender: TObject);
    procedure Sb_Exc_Product_SimilarClick(Sender: TObject);
    procedure abeladePreo1Click(Sender: TObject);
    procedure DBG_PrecoKeyPress(Sender: TObject; var Key: Char);
    procedure DBLCB_GrupoExit(Sender: TObject);
    procedure VariaodeProdutos1Click(Sender: TObject);
    procedure ChBx_InternetClick(Sender: TObject);
    procedure tbs_impostosShow(Sender: TObject);
    procedure AjustarPreoporEscala1Click(Sender: TObject);
    procedure Sb_HtmlClick(Sender: TObject);
    procedure Sb_ins_reposicaoClick(Sender: TObject);
    procedure Sb_edi_reposicaoClick(Sender: TObject);
    procedure Sb_del_reposicaoClick(Sender: TObject);
    procedure tbs_reposicaoShow(Sender: TObject);
   private
    { Private declarations }
    It_Inserir: Boolean;
    It_Alterar: Boolean;
    It_Excluir: Boolean;
    It_Visualizar: Boolean;
    fCodItem: String ;
    It_Edicao_Ordem : String;
    ProdutoVeiculo : Boolean;
    procedure EstadoEdicao;
    procedure EstadoEdicaoFornecedor;
    procedure EstadoEdicaoTabelaPreco;
    procedure EstadoEdicaoInstalacao;
    procedure EstadoEdicaoComposicao;
    procedure EstadoEdicaoProducao;
    procedure EstadoEdicaoBotao;
    procedure EstadoEdicaoSerie;
    procedure EstadoEdicaoInternet;
    procedure EstadoEdicaoSimilar;
    procedure EstadoEdicaoReposicao;


    procedure Pc_ExecutaNovoProduto;
    procedure Pc_ExecutaCopiaProduto;
    procedure Pc_PreencheComboTipoProduto(Tipo:String);

    function ValidaDelete:Boolean;

    procedure showdata;
    procedure showNodata;
    procedure setProduto;
    procedure ShowProduto;
    procedure SAveProduto;
    procedure ShowTray;

    procedure ShowPriceList;
    procedure SavePriceList;

    procedure SaveReposicao;

    procedure ShowStockList;
    procedure SaveStockList;

    procedure ProductTray;

    procedure ChangePriceByMargem(Sender: TField);
    procedure ChangePriceByValor(Sender: TField);

    procedure ListaSubgrupo;

    procedure abreProducao;
    procedure AbrePRodutoSimilar;
    procedure AbreSerie;
    procedure AbreBotao;
    procedure AbreComposicao;
    procedure AbreReposicao;
    procedure AbreServico;
    procedure AbreImposto;
    procedure AbreFornecedores;
    function ValidaAlteracaoDescricao:Boolean;
    function CopiarTributacao(produtoIdOld,produtoIdNew: Integer):Integer;
   public
    { Public declarations }
      Produto : TControllerProduto;
      TrayLoja : TControllerLojaTray;
      It_Vl_Venda_Anterior:Currency;
      It_Ds_Cadastro : String;
      It_Cd_Prod_Prod: Integer;
      It_Cd_Prod_D: Integer;
      It_Cd_Botao : Integer;
      It_Servico: string;
      It_CodSrv: Integer;
      It_StatusTabela: Integer;
      It_Captura: String;
      It_Num_NCM: String;
      ProdutoMultiEmpresa : Boolean;
      procedure Pc_NomeLabel;
      procedure Pc_AtivarTabelas;


      procedure Pc_ProcuraLocalizacao;
      procedure Pc_ProcuraCodigoBarras;

      Procedure Pc_Define_aba;

      function Fc_ValidaGravacao(): boolean;
      function Fc_Pre_ValidaGravacao(): boolean;
      Function Fc_ValidaAlteracao():Boolean;
      function Fc_ValidaCancelamento(): boolean;
      function Fc_validaAliquotaComissao(Fc_aq_Com:real):Boolean;
      Procedure Pc_CopiaProduto;
      procedure Pc_Valor_Campanha(Pc_Cod_Produto: Integer; Pc_Tabela: Integer; Pc_Preco: Double);
      FUNCTION Fc_Verifica_Forn(Fc_Cd_Fornece:Integer):Boolean;
      function Fc_VerificaGravacaoComplementar():Boolean;
      procedure Pc_AtualizaItensInstalacao(Pc_Operacao:String;Pc_Codigo,Pc_Cd_Produto,Pc_Cd_servico:Integer);

      procedure Pc_AtualizaComposicao;
      procedure Pc_AtualizaInstalacao;
      procedure Pc_AtualizaProducao;


      function existeCodigoCodFabrica:Boolean;

      PROCEDURE Pc_F2;
      procedure Pc_f3;
      procedure Pc_f4;
      procedure Pc_PermissaoBotao(Pc_Menu: string);
      procedure Pc_FormataTela;
      procedure Pc_ImagemBotao;
      function Fc_ValidaCadastroSeries:Boolean;
      procedure Pc_LiberarNumeroSerie;
      procedure Pc_ImagemPermissao;
      Procedure Pc_AtualizaTabelaVendasPelaMargem(Pc_Vl_custo:Real);
      procedure Pc_ControleFocoEdicao();
      function Fc_NivelHierarquico( const fc_s : String ) : integer;
      procedure Pc_PreencherTreeView(Pc_Query : TDataset; Pc_tv : TTreeView; Pc_Pai : TTreeNode );
      Function Fc_PosicionaNoCategoria (Fc_Tipo: Byte;Fc_Tree : TTreeView; Fc_Value:Integer; Fc_Visible: Boolean): TTreeNode;


      Function Fc_VerificaProdutoGravado:Boolean;

      Property CodItem: String Read fCodItem Write fCodItem;
      procedure ListaEstadosBeneficios;
      procedure SalvaEstadosBeneficios;


   end;

var
   Fr_Produtos: TFr_Produtos;

implementation

uses     Un_DM, Un_Msg, sea_group, UN_Sistema, sea_taxation, tas_html_editor, sea_product_brand, UN_FotoProduto, Un_Funcoes, reg_produto_reposicao, sea_service, Un_JPEGImageExt, Un_FTP, Un_Pesq_Produto, Un_Composicao, Un_Tabela_Preco, UN_Fatura_Cpa, Un_Base_Produtos, sea_measure, sea_package, Un_Fc_Sored_Procedures, Un_Pesq_NCM, Un_Configuracao, sea_button_image, UN_Pedido_Cpa, Un_WebService, Un_Produto_Series, UN_Principal, env, UN_Pedido_Vda, UN_Pedido_Ajt, Un_Regra_Negocio, sea_coating, sea_category, Un_Cotacao, RN_Estoque, RN_Produto, Un_Ctrl_Lote_Saida, Un_Img_Site_Produto, RN_Permissao, UN_TabelasEmListas, Un_Pesq_CEST, RN_Fornecedor, tblTabelaPreco, tblproduto, cad_product_variant, tas_change_price_by_scale;
{$R *.dfm}

procedure TFr_Produtos.Pc_ControleFocoEdicao();
Begin
  if E_Barras.CanFocus then E_BarrasExit(self);
  if E_Local.CanFocus then  E_LocalExit(self);
  E_Fabricante.SetFocus;
end;

procedure TFr_Produtos.Pc_ImagemPermissao;
Begin
  with fr_principal do
    Begin
    //Geral;
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(SB_Gravar,'GRAVAR');
    CarregaImagemBotao(SB_Cancelar,'CANCELAR');
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
    //Fornecedor
    CarregaImagemBotao(SB_Ins_fornec,'INSERIR');
    CarregaImagemBotao(SB_exc_fornec,'EXCLUIR');
    //Instalação
    CarregaImagemBotao(SB_INS_SERV,'INSERIR');
    CarregaImagemBotao(SB_EXC_SERV,'EXCLUIR');
    //Composicao
    CarregaImagemBotao(Sb_Ins_Produto,'INSERIR');
    CarregaImagemBotao(Sb_alt_Produto,'ALTERAR');
    CarregaImagemBotao(Sb_Exc_Produto,'EXCLUIR');
    //Botão
    CarregaImagemBotao(Sb_Ins_botao,'INSERIR');
    CarregaImagemBotao(Sb_Alt_botao,'ALTERAR');
    CarregaImagemBotao(Sb_Exc_botao,'EXCLUIR');
    //Série
    CarregaImagemBotao(Sb_Ins_Serie,'INSERIR');
    CarregaImagemBotao(Sb_Alt_Serie,'ALTERAR');
    CarregaImagemBotao(Sb_Exc_Serie,'EXCLUIR');
    //Produção
    CarregaImagemBotao(Sb_ins_producao,'INSERIR');
    CarregaImagemBotao(Sb_Alt_producao,'ALTERAR');
    CarregaImagemBotao(Sb_Exc_producao,'EXCLUIR');
    //Similar
    CarregaImagemBotao(Sb_Ins_Product_Similar,'INSERIR');
    CarregaImagemBotao(Sb_Exc_Product_Similar,'EXCLUIR');
    //Reposicação
    CarregaImagemBotao(Sb_ins_reposicao,'INSERIR');
    CarregaImagemBotao(Sb_edi_reposicao,'ALTERAR');
    CarregaImagemBotao(Sb_del_reposicao,'EXCLUIR');

    END;
end;

procedure TFr_Produtos.Pc_LiberarNumeroSerie;
Var
  Lc_SQLTxt : String;
Begin
  if Gb_Nivel = 1 then
  Begin
    with Qr_Acao do
    Begin
      if (not Transaction.InTransaction) then Transaction.StartTransaction;
      Active := False;
      Transaction := DM.IB_Transacao;
      SQL.Clear;
      //Verifica se o Cancelamento e Nota Fiscal Eletronica
      Lc_SQLTxt := 'UPDATE TB_SERIE_PRODUTO SET     '+
                   'SRP_CODSAI =0                  '+
                   'WHERE (SRP_CODIGO =:SRP_CODIGO) ';
      SQL.Add(Lc_SQLTxt);
      ParamByName('SRP_CODIGO').AsInteger := Qr_SeriesSRP_CODIGO.AsInteger;
      ExecSQL;
      if Transaction.InTransaction then Transaction.CommitRetaining;
    End;
    AbreSerie;
  end
  else
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Esta liberação só pode ser feita por usuário Administrador.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Produtos.Pc_AtualizaComposicao;
var
  Lc_Vl_Custo,Lc_Vl_Custo_Medio: real;
begin
  if Qr_Prod_Prod.RecordCount > 0 then
  Begin
    Lc_Vl_Custo := 0;
    Lc_Vl_Custo_Medio := 0;
    while not Qr_Prod_Prod.Eof do
    begin
      Lc_Vl_Custo := Lc_Vl_Custo + (Qr_Prod_Prod.FieldByName('PRO_VL_CUSTO').AsCurrency * Qr_Prod_Prod.FieldByName('PPD_QTDE').AsFloat);
      Lc_Vl_Custo_Medio := Lc_Vl_Custo_Medio + (Qr_Prod_Prod.FieldByName('PRO_VL_CUSTOMED').AsCurrency * Qr_Prod_Prod.FieldByName('PPD_QTDE').AsFloat);
      Qr_Prod_Prod.Next;
    end;
    if Lc_Vl_Custo <> Produto.Registro.ValorCusto then
    begin
      if It_Edicao_Ordem <> 'I' then
      Begin
        PRoduto.registro.ValorFabrica := Lc_Vl_Custo;
        PRoduto.registro.ValorCusto := Lc_Vl_Custo;
        PRoduto.registro.ValorCustoMedio := Lc_Vl_Custo_Medio;
        E_custoFAb.Text := FloatToStrF(Lc_Vl_Custo,ffFixed,10,2);
        E_PrecoCusto.Text := FloatToStrF(Lc_Vl_Custo,ffFixed,10,2);
        E_custoReal.Text := FloatToStrF(Lc_Vl_Custo_Medio,ffFixed,10,2);
        Produto.update;
      End;
    end;
  End;
end;


procedure TFr_Produtos.Pc_ProcuraLocalizacao;
Var
  LcEscolha : Integer;
begin
  if ( Trim(E_Local.Text) <> '' ) then
  BEgin
    With Qr_Acao do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT PRO_CODIGO FROM TB_PRODUTO WHERE (PRO_LOCAL =:PRO_LOCAL) AND (PRO_CODIGO <>:PRO_CODIGO) ');
      ParamByName('PRO_CODIGO').AsString := E_Codigo.Text;
      ParamByName('PRO_LOCAL').AsString := E_Local.Text;
      Active := True;
      Transaction := DM.IB_Transacao;
      FetchAll;
      if RecordCount > 0 then
      begin
        LcEscolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                      'JÁ existe Produto cadastrado neste local: ' + E_Local.Text + '.' + EOLN + EOLN +
                      'Deseja Visualiza-lo agora ?',
                      [SIM, NAO,'Continuar'], [bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
        case LcEscolha of
          0:begin
              Pc_AtivarTabelas;
              Produto.Registro.Codigo := Qr_Acao.FieldByName('PRO_CODIGO').AsInteger;
              Produto.getbyId;
              SB_AlterarClick(Self);
            end;
          1:begin
              E_Local.Clear;
              E_Local.SetFocus;
          end
          else
            E_peso.Setfocus;
        end;
      end;
    End;
  End;
end;


procedure TFr_Produtos.Pc_ProcuraCodigoBarras;
begin
  Produto.Registro.Codigo := StrtoIntDef(E_Codigo.Text,0);
  Produto.Registro.CodigoBarras := E_Barras.Text;
  if ProdutoMultiEmpresa then
    Produto.Registro.CodigoEstabelecimento := 0
  else
    Produto.Registro.CodigoEstabelecimento := Gb_CodMha;
  Produto.getbyBarCode;
  if Produto.exist then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'JÁ existe Produto cadastrado com o codigo ' + E_Barras.Text + '.' + EOLN + EOLN +
                     'Deseja Visualiza-lo agora ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      showdata;
      It_Edicao_Ordem := 'E';
      EstadoEdicao;
    End
    else
    Begin
       E_Barras.Clear;
       E_Barras.SetFocus;
    end;
  end;
end;

procedure TFr_Produtos.Pc_AtivarTabelas;
begin
  DM.Qr_Grupo.Active := True;
  DM.Qr_MarcaProduto.Active := True;
  DM.Qr_Revestimento.Active := True;
  DM.Qr_Embalagem.Active := True;
  Fm_UnidadeComercial.Pc_ListaMedida('','');
  Fm_UnidadeTributavel.Pc_ListaMedida('','');
end;



procedure TFr_Produtos.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;


procedure TFr_Produtos.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if (shift = []) then
  begin
    case Key of
      VK_F2:Pc_F2;
      VK_F3:Pc_f3;
      VK_F4:pc_f4;
      VK_F5: if SB_Gravar.Enabled then   SB_GravarClick(Sender);
      VK_F6: if SB_Cancelar.Enabled then   SB_CancelarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then  Sb_Sair_0Click(Sender);
    end;
  end;
end;


procedure TFr_Produtos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Produto);
  FreeAndNil(TrayLoja);
  Pc_Log_Sistema( Gb_CodMha,
                  GB_Cd_Usuario,
                  (Now),
                  'Cadastro de Produtos',
                  GB_Cd_Usuario,
                  'Saida do cadastro', concat('Fim ás',DateTimeToStr(Now)));
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
end;


procedure TFr_Produtos.SB_GruposClick(Sender: TObject);
Var
  Lc_Form : TSeaGroup;
begin
  Try
    Lc_Form := TSeaGroup.Create(nil);
    Lc_Form.ShowModal;
  Finally
    DM.Qr_Grupo.Active := False;
    DM.Qr_Grupo.Active := True;
    ListaSubgrupo;
    DBLCB_Grupo.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
    DBLCB_SubGrupo.KeyValue := Lc_Form.cds_searchcodigo_subgrupo.AsInteger;
    DBLCB_SubGrupo.SetFocus;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Produtos.Sb_HtmlClick(Sender: TObject);
Var
  Lc_form : TTasHtmlEditor;
begin
  try
    Lc_form := TTasHtmlEditor.create(nil);
    Lc_form.Conteudo := E_Observacao.Text;
    Lc_form.ShowModal;
    E_Observacao.Text := Lc_form.Conteudo;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TFr_Produtos.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if ( (Key = #13) and (not (ActiveControl is TMemo)) )  and
    ( (Key = #13) and (not (ActiveControl is TDBGrid)) ) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Produtos.SpeedButton6Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Produtos.Pc_ExecutaNovoProduto;
Begin
  It_Edicao_Ordem := 'I';
  EstadoEdicao;
  showNodata;
  Pc_AtivarTabelas;
end;

procedure TFr_Produtos.Pc_ExecutaCopiaProduto;
Begin
  if Produto.Registro.Codigo > 0 then
  Begin
    Pc_Log_Sistema( Gb_CodMha,
                    GB_Cd_Usuario,
                    now,
                    'Cadastro de Produtos',
                    Produto.Registro.Codigo,
                    'Cópia de Produto',
                    'Código Produto: ' + Produto.Registro.Codigo.ToString);
    Pc_CopiaProduto;
  end
  else
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por Favor Selecione um produto para Copiar.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Produtos.Pc_PreencheComboTipoProduto(Tipo:String);
Begin
  with Cb_Tipo_Produto.Items do
  Begin
    Clear;
    Add('Produto Acabado');
    Add('Materia Prima');
    Add('Produto Consumo');
    if Tipo = 'A' then
      Add('Automático');
  end;
end;

procedure TFr_Produtos.SB_InserirClick(Sender: TObject);
Var
  Lc_escolha : Integer;
begin
  Lc_escolha :=  (MensagemPadrao(TITULO_CONFIRMACAO,
                                 'Qual operação executar?'+EOLN+EOLN,
                                 ['Novo','Cópia','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_escolha of
    0:Pc_ExecutaNovoProduto;
    1:Pc_ExecutaCopiaProduto;
  end;
end;

Function TFr_Produtos.Fc_ValidaAlteracao():Boolean;
Begin
  REsult := True;
  if (Produto.Registro.Tipo = 'A') then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Este produto foi criado automaticamente pelo Sistema.'+EOLN+
                   'Não pode ser Alterado.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;


procedure TFr_Produtos.SalvaEstadosBeneficios;
Var
  LcB : TControllerProductUfBenef;
  I : Integer;
begin
  try
    LcB := TControllerProductUfBenef.create(SELF);
    LcB.Registro.Produto    := Produto.Registro.Codigo;
    LcB.deleteAllProduct;
    for I := 1 to Strgrd_Benefi_UF.RowCount -1 do
    Begin
      if Trim(Strgrd_Benefi_UF.Cells[1,I]) <> '' then
      Begin
        LcB.Registro.Estado     := Upper( Strgrd_Benefi_UF.Cells[1,I] );
        LcB.Registro.Beneficio  := Upper( Strgrd_Benefi_UF.Cells[2,I] );
        LcB.Registro.CST        := Upper( Strgrd_Benefi_UF.Cells[3,I] );
        LcB.insere;
      End;
    End;
  finally
    FreeAndNil (LcB);
  end;
end;

procedure TFr_Produtos.SavePriceList;
begin
  Try
    Cds_Tabela_Preco.First;
    while not Cds_Tabela_Preco.eof do
    Begin
      Produto.TabelaPreco.Preco.Registro.CodigoTabela     := Cds_Tabela_Preco.FieldByName('PRC_CODTPR').AsInteger;
      Produto.TabelaPreco.Preco.Registro.Codigo           := Cds_Tabela_Preco.FieldByName('PRC_CODIGO').AsInteger;
      Produto.TabelaPreco.Preco.Registro.CodigoProduto    := Produto.Registro.Codigo;
      Produto.TabelaPreco.Preco.Registro.Valor            := Cds_Tabela_Preco.FieldByName('PRC_VL_VDA').AsCurrency;
      Produto.TabelaPreco.Preco.Registro.MargemLucro      := Cds_Tabela_Preco.FieldByName('PRC_MAR_LRC').AsFloat;
      Produto.TabelaPreco.Preco.Registro.AliComissao      := Cds_Tabela_Preco.FieldByName('PRC_AQ_COM').AsFloat;
      Produto.TabelaPreco.Preco.Registro.QtdeMinima       := Cds_Tabela_Preco.FieldByName('PRC_QT_MIN').AsFloat;
      if Cds_Tabela_Preco.FieldByName('PRC_CODIGO').AsInteger= 0 then
      Begin
        Produto.TabelaPreco.Preco.salva;
        Cds_Tabela_Preco.Edit;
        Cds_Tabela_Preco.FieldByName('PRC_CODIGO').AsInteger := Produto.TabelaPreco.Preco.Registro.Codigo;
        Cds_Tabela_Preco.Post;
      End
      else
        Produto.TabelaPreco.Preco.update;
      Cds_Tabela_Preco.next;
    End;
  Finally
    Cds_Tabela_Preco.MergeChangeLog;
  End;
end;

procedure TFr_Produtos.ProductTray;
Var
  LcCdWeb : Integer;
begin
  LcCdWeb := StrToIntDef(E_Cd_Produto_Tray.Text,0);
  TrayLoja.Registro.Tabela := 'TB_PRODUTO';
  TrayLoja.Registro.Codigo := Produto.Registro.Codigo;
  if LcCdWeb > 0 then
  Begin
    TrayLoja.Registro.WebID := LcCdWeb;
    TrayLoja.save;
  End
  else
  Begin
    TrayLoja.deleteById;
  End;
end;

procedure TFr_Produtos.SAveProduto;
begin
  produto.Registro.Codigo := StrToIntDef(E_Codigo.Text,0);
  produto.Registro.CodigoEstabelecimento := Gb_CodMha;
  produto.Registro.CodigoFabrica := E_Fabricante.Text;
  produto.Registro.CodigoBarras := E_Barras.Text;
  produto.Registro.CodigoFornecedor := E_CodigoFor.Text;
  produto.Registro.CodigoNCM := E_CodClasfiscal.Text;
  produto.Registro.Descricao := Copy(E_DescricaoProduto.Text,1,100);
  produto.Registro.CEST := Copy(trim(E_CEST.Text),1,7);
  produto.Registro.CodigoGrupo := DBLCB_Grupo.KeyValue;
  produto.Registro.CodigoSubgrupo := DBLCB_SubGrupo.KeyValue;
  produto.Registro.CodigoMarca := DBLCB_Marca.KeyValue;
  produto.Registro.PrecoInstalado := StrToFloatDef(E_PrecoInstala.Text,0);
  //aba Estoque
  produto.Registro.CodigoEmbalagem := DBLCB_Embalagem.KeyValue;
  produto.Registro.Divisor := StrToIntDef(E_Divisor.Text,0);
  produto.Registro.MedidaComercial := Fm_UnidadeComercial.Dblcb_Medida.KeyValue;

  case Cb_Tipo_Produto.ItemIndex of
    0:produto.Registro.Tipo := 'P';
    1:produto.Registro.Tipo := 'M';
    2:produto.Registro.Tipo := 'C';
  end;

  if DBLCB_Revestimento.Text <> '' then
    Produto.Registro.Revestimento     := DBLCB_Revestimento.KeyValue
  else
    Produto.Registro.Revestimento     := 0;
  Produto.registro.Sequencia        := StrToIntDef( E_Pro_Sequencia.Text,0);
  Produto.registro.Localizacao      := E_Local.Text;
  Produto.registro.PEso             := StrToFloatDef( E_Peso.Text,0);
  Produto.registro.LArgura          := StrToFloatDef( E_Largura.Text,0);
  Produto.registro.Comprimento      := StrToFloatDef( E_Comprimento.Text,0);
  Produto.registro.Altura           := StrToFloatDef( E_Altura.Text,0);

  Produto.registro.ValorFabrica     := StrToFloatDef( E_CustoFab.Text,0);
  Produto.registro.ValorCustoMedio  := StrToFloatDef( E_custoReal.Text,0);
  Produto.registro.ValorCusto       := StrToFloatDef( E_PrecoCusto.Text,0);
  Produto.registro.ValorBaseTroca   := StrToFloatDef( E_PrecoTroca.Text,0);
  Produto.registro.QtdeMinima       := StrToFloatDef( E_QtdeMinima.Text,0);

  produto.Registro.Disponibilidade          := Cb_available.ItemIndex;
  produto.Registro.DiasParaDisponibilidade  := StrToIntDEf(E_Days_to_available.Text,0);

  //Aba preço
  produto.Registro.PrecoVEndaFixo := ifthen(Chbx_fixed_rate.Checked,'S','N');

  Produto.Registro.Origem := IntToStr(Cb_Origem.ItemIndex);

  if RB_Cps_Sem_Uso.Checked         then Produto.Registro.Composicao := '1'; //não utilizar este recurso
  if RB_Cps_Som_Itens.Checked       then Produto.Registro.Composicao := '2'; //LAncar somente itens
  if RB_Cps_Cascata_Qtde.Checked    then Produto.Registro.Composicao := '3';  //Estoque em Cascata por quantidade
  if RB_Cps_Qtde_Item.Checked       then Produto.Registro.Composicao := '4'; //Quantidade por numero de Itens
  if RB_Cps_Lanca_Item.Checked      then Produto.Registro.Composicao := '5'; //Lançar somente os itens no pedido
  if RB_Cps_auto_reposicao.Checked  then Produto.Registro.Composicao := '6'; //Reposição automatica de produtos pelo uso de abertura de pacotes/caixa

  //aba observação
  produto.Registro.Detalhes := E_Observacao.Text;
  produto.Registro.Aplicacao := EncodeBase64(E_Aplicacao.Text);
  produto.Registro.EstoqueNegativo := ifthen(ChBx_Estoque.Checked,'S','N');

  produto.Registro.EstoqueNegativo := ifthen(ChBx_Estoque.Checked,'S','N');

  produto.Registro.Ativo := ifthen(ChBx_ativo.Checked,'S','N');

  produto.Registro.ForaLinha := ifthen( Chbx_ForaLinha.Checked,'S','N');

  produto.Registro.Imprime := ifthen( ChBx_Impressao.Checked,'N','S');

  produto.Registro.Internet := ifthen( ChBx_Internet.Checked,'S','N');

  produto.Registro.EnviarParaInternet := ifthen( Chbx_Send_Internet.Checked,'S','N');

  produto.Registro.IndicacaoEscala := ifthen( ChBx_indEscala.Checked,'S','N');

  produto.Registro.Campanha := ifthen( Chbx_Promocao.Checked,'S','N');

  produto.Registro.Destaque := ifthen( Chbx_Destaque.Checked,'S','N');

  produto.Registro.UtilizaSerie := ifthen( Chbx_Series.Checked,'S','N');

  produto.Registro.Exclusivo := ifthen( ChBx_exclusivo.Checked,'S','N');

  //Aba TRibutação
  if RG_SUBTRIB.ItemIndex = 0 then
    produto.Registro.SubsTrib := 'S'
  else
    produto.Registro.SubsTrib := 'N';

  produto.Registro.FinalidadeTributacao := IntToStr( Cb_Finalid_Tributa.ItemIndex + 1);
  if Fm_UnidadeTributavel.Dblcb_Medida.Text <> '' then
    produto.Registro.MedidaTributavel := Fm_UnidadeTributavel.Dblcb_Medida.KeyValue
  else
    produto.Registro.MedidaTributavel := Fm_UnidadeComercial.Dblcb_Medida.KeyValue;

  if Produto.Registro.Categoria = 0 then
     Produto.Registro.Categoria := 2;

  Produto.Registro.DataVencimento := E_DT_Vencimento.DateTime;
  Produto.Registro.IAT := 'A';
  Produto.Registro.QtdeMinAutoReposicao := StrToFloatDef(E_QtdeMinAutoReposicao.text,0);

  Produto.save;


  E_Codigo.Text := produto.Registro.Codigo.toString;
  E_Fabricante.Text := produto.Registro.CodigoFabrica;
  if (It_Edicao_Ordem = 'I') then
  BEgin
    Pc_Log_Sistema( Gb_CodMha,
                    GB_Cd_Usuario,
                    now,
                    'Cadastro de Produtos',
                    produto.Registro.Codigo,
                    'Inserção de Produto',
                    'CÓDIGO PRODUTO: ' + produto.Registro.Codigo.ToString);
  End;
end;

procedure TFr_Produtos.SaveReposicao;
Var
  LcOperacao : String;
  cds_temp : TClientDataSet;
begin
  if Cds_reposicao.ChangeCount > 0 then
  Begin
    cds_temp := TClientDataSet.Create(nil);
    Try
      cds_temp.CloneCursor( Cds_reposicao,true,true);
      cds_temp.StatusFilter := [usModified, usInserted, usDeleted];
      cds_temp.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        with Produto do
        Begin
          Reposicao.Registro.produtoMaster  := Registro.Codigo;
          Reposicao.Registro.produtodetalhe := cds_temp.FieldByName('PPD_CODPRO_D').AsInteger;
          Reposicao.Registro.Qtde           := cds_temp.FieldByName('PPD_QTDE').AsFloat;
          Reposicao.Registro.Tipo           := 'REPOSICAO';
          Reposicao.Registro.Metodo         := cds_temp.FieldByName('PPD_METODO').AsString;
          Reposicao.Registro.QtdeUsada      := cds_temp.FieldByName('PPD_QTDE_USED').AsFloat;
            case cds_temp.UpdateStatus of
              usInserted: Reposicao.insert;
              usModified: Reposicao.update;
              usDeleted: Reposicao.Delete;
            end;
          cds_temp.Next
        End;
      End;
    Finally
      FreeAndNil(cds_temp);
      Cds_reposicao.MergeChangeLog;
    End;
  End;
end;

procedure TFr_Produtos.SaveStockList;
begin
  Produto.Estoque.SaldoEstoque.CriaRegistroAutomatico(Produto.Registro.Codigo);
end;

procedure TFr_Produtos.SB_AlterarClick(Sender: TObject);
begin
  if Fc_ValidaAlteracao then
  Begin
    It_Edicao_Ordem := 'E';
    EstadoEdicao;
    It_Captura := '';
  end;
end;

procedure TFr_Produtos.SB_ExcluirClick(Sender: TObject);
begin
  if ValidaDelete then
  Begin
    Produto.Registro.Ativo := 'N';
    Produto.update;
    Close;
  end;
end;


procedure TFr_Produtos.SB_GravarClick(Sender: TObject);
begin
  Pc_ControleFocoEdicao;
  if Fc_ValidaGravacao then
  Begin
    TRY
      Enabled := False;
      Pc_ProcesoAguarde(Self,'I');
      try
        Screen.Cursor := crHourGlass;
        SaveProduto;
        SalvaEstadosBeneficios;
        SaveStockList;
        ShowStockList;
        SavePriceList;
        SaveReposicao;
        ProductTray;
        It_Edicao_Ordem := 'B';
        EstadoEdicao;
        Screen.Cursor := crDefault;
      except
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                       'Um erro impossibilitou a gravação dos dados.' + EOLN +
                       'Entre em contato com o suporte técnico.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Screen.Cursor := crDefault;
      end;
    Finally
      Pc_ProcesoAguarde(Self,'F');
      Enabled := True;
    end;
  end;
end;

procedure TFr_Produtos.SB_CancelarClick(Sender: TObject);
begin
  if Fc_ValidaCancelamento then
  Begin
    Pc_ControleFocoEdicao;
    if (It_Edicao_Ordem = 'I') then
    BEGIN
      Produto.clear;
      //Muda o Status para poder sair
      It_Edicao_Ordem := 'B';
      Close;
    END
    else
    Begin
      It_Edicao_Ordem := 'B';
      EstadoEdicao;
    End;
  end;
end;

procedure TFr_Produtos.Pc_FormataTela;
var
   Lc_Crt : Integer;
Begin
  Pc_Define_aba;

  Pc_AtivaEstabelecimento;
  Lc_Crt := StrToIntDef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);
  if ( Lc_Crt = 2) or ( Lc_Crt = 3) then
  Begin
    DBG_Impostos.Columns[2].Title.Caption := 'C.S.T.';
    DBG_Impostos.Columns[2].FieldName := 'TRB_CST';
  end
  else
  Begin
    DBG_Impostos.Columns[2].Title.Caption := 'C.S.O.S.N.';
    DBG_Impostos.Columns[2].FieldName := 'TRB_CSOSN';
  end;
  Pc_LimpaStringGrid(Strgrd_Benefi_UF);
  with Strgrd_Benefi_UF do
  Begin
    ColWidths[0]:=17;
    Cols[1].Add('Estado');
    ColWidths[1]:=40;
    Cols[2].Add('Benefócio');
    ColWidths[2]:=80;
    Cols[3].Add('CST');
    ColWidths[3]:=70;
  End;
  //Só mostra a reposição se for ativada na configuração
  RB_Cps_auto_reposicao.Visible := ( Fc_Tb_Geral('L','EST_AUTO_REPOSICAO','N') = 'S' );
  L_QtdeMinAutoReposicao.Visible := RB_Cps_auto_reposicao.Visible;
  E_QtdeMinAutoReposicao.Visible := RB_Cps_auto_reposicao.Visible;
  tbs_reposicao.TabVisible := RB_Cps_auto_reposicao.Visible;
end;

function TFr_Produtos.CopiarTributacao(produtoIdOld,produtoIdNew: Integer): Integer;
Var
  LcTrib : TControllerTributacao;
  I : Integer;
begin
  try
    LcTrib := TControllerTributacao.create(nil);
    LcTrib.Registro.Produto := produtoIdOld;
    LcTrib.getList;
    for I := 0 to LcTrib.Lista.Count -1 do
    Begin
      LcTrib.clear;
      LcTrib.ClonarObj(LcTrib.Lista[I],LcTrib.Registro);
      LcTrib.Registro.codigo := 0;
      LcTrib.Registro.Produto := produtoIdNew;
      LcTrib.Insert;
    End;
  finally
    FreeAndNil(LcTrib);
  end;
end;



procedure TFr_Produtos.setProduto;
begin
  Pc_AtivarTabelas;
  Produto.getbyId;
  showdata;
end;

procedure TFr_Produtos.showdata;
begin
  ShowProduto;
  AbreComposicao;
  AbreReposicao;
  AbreServico;
  abreProducao;
  AbreImposto;
  ListaEstadosBeneficios;
  ShowStockList;
  ShowPriceList;
  Chbx_SeriesClick(Self);
  ShowTray;
end;

procedure TFr_Produtos.showNodata;
begin
  Produto.clear;
  E_Codigo.clear;
  E_Fabricante.clear;
  E_Barras.clear;
  E_CodigoFor.clear;
  E_CodClasfiscal.clear;
  E_DescricaoProduto.clear;
  E_CEST.clear;
  DBLCB_Grupo.KeyValue              := null;
  DBLCB_SubGrupo.KeyValue           := null;
  DBLCB_Marca.KeyValue              := null;
  E_Dt_Ultima_compra.clear;
  E_Dt_Ultima_Venda.clear;
  E_PrecoInstala.clear;
  //aba Estoque
  DBLCB_Embalagem.KeyValue          := null;
  E_Divisor.clear;
  Fm_UnidadeComercial.Dblcb_Medida.KeyValue := null;
  Pc_PreencheComboTipoProduto('P');
  Cb_Tipo_Produto.ItemIndex := 0;
  if produto.Registro.Tipo = 'A' then
    DM_ListaConsultas.Pc_ListaMedida(SIM,'')
  else
    DM_ListaConsultas.Pc_ListaMedida('','');

  DBLCB_Revestimento.KeyValue       := null;
  E_Local.clear;
  E_Peso.clear;
  E_Largura.clear;
  E_Comprimento.clear;
  E_Altura.Clear;

  PG_Informacoes.ActivePage := tbs_estoque;

  E_PrecoCusto.Text := '0,00';
  E_CustoFab.Text := '0,00';
  E_custoReal.Text := '0,00';
  E_PrecoTroca.Text := '0,00';
  E_QtdeMinima.Text := '0';

  Cb_Origem.ItemIndex := 0;

  RB_Cps_Sem_Uso.Checked      := True;
  RB_Cps_Som_Itens.Checked    := False;
  RB_Cps_Cascata_Qtde.Checked := False;
  RB_Cps_Qtde_Item.Checked    := false;
  RB_Cps_Lanca_Item.Checked  := False;
  RB_Cps_auto_reposicao.Checked  := False;
  Cb_available.ItemIndex := 0;
  E_Days_to_available.Text := '0';
  //aba observação
  E_Observacao.clear;
  E_Aplicacao.clear;
  Chbx_Promocao.Checked   := False;
  Chbx_Destaque.Checked   := False;
  ChBx_ativo.Checked      := True;
  Chbx_ForaLinha.Checked  := False;
  ChBx_Impressao.Checked  := False;
  ChBx_Estoque.Checked    := False;
  Chbx_Series.Checked     := False;
  ChBx_exclusivo.Checked  := FAlse;
  ChBx_Internet.Checked   := False;
  Chbx_Send_Internet.Checked   := False;
  ChBx_indEscala.Checked  := True;

  //Aba TRibutação
  RG_SUBTRIB.ItemIndex := 1;
  Cb_Finalid_Tributa.ItemIndex := 0;
  Fm_UnidadeTributavel.Dblcb_Medida.KeyValue := 0;
  ShowStockList;
  ShowPriceList;
  Pc_AtivarTabelas;
end;

procedure TFr_Produtos.ShowPriceList;
Var
  I : Integer;
begin
  TRy
    //produto.TabelaPreco.Preco
    Cds_Tabela_PrecoPRC_MAR_LRC.OnChange := nil;
    Cds_Tabela_PrecoPRC_VL_VDA.OnChange := nil;
    Produto.TabelaPreco.Registro.Estabelecimento := Gb_CodMha;
    Produto.TabelaPreco.getList;
    cds_tabela_preco.DisableControls;
    with self.cds_tabela_preco  do
    Begin
      Active := False;
      CreateDataSet;
      LogChanges := False;
      EmptyDataSet;
      for I := 0 to Produto.TabelaPreco.Lista.Count - 1 do
      Begin
        Append;
        FieldByName('TPR_NOME').AsString            := Produto.TabelaPreco.Lista[I].Descricao;
        FieldByName('TPR_CASA_DECIMAL').Asfloat     := Produto.TabelaPreco.Lista[I].CasaDecimal;
        FieldByName('TPR_MAR_LRC').AsFloat          := Produto.TabelaPreco.Lista[I].MargemLucro;
        FieldByName('TPR_MAR_PRIORITARIA').AsString := Produto.TabelaPreco.Lista[I].MargemPrioritaria;
        //Dados da Tabela
        Produto.TabelaPreco.Preco.Registro.CodigoTabela  := Produto.TabelaPreco.Lista[I].Codigo;
        Produto.TabelaPreco.Preco.Registro.CodigoProduto := Produto.registro.codigo;
        Produto.TabelaPreco.Preco.getbyId;
        IF Produto.TabelaPreco.Preco.EXIST and ( Produto.registro.codigo > 0 ) THEN //2 criterio salva guarda de erros no banco
        Begin
          FieldByName('PRC_VL_VDA').AsCurrency   := Produto.TabelaPreco.Preco.Registro.Valor;
          FieldByName('PRC_MAR_LRC').AsFloat  := Produto.TabelaPreco.Preco.Registro.MargemLucro;
          FieldByName('PRC_AQ_COM').AsFloat   := Produto.TabelaPreco.Preco.Registro.AliComissao;
          FieldByName('PRC_QT_MIN').AsFloat   := Produto.TabelaPreco.Preco.Registro.QtdeMinima;
          FieldByName('PRC_CODTPR').AsInteger := Produto.TabelaPreco.Preco.Registro.CodigoTabela;
          FieldByName('PRC_CODIGO').AsInteger := Produto.TabelaPreco.Preco.Registro.Codigo;
        End
        else
        Begin
          FieldByName('PRC_VL_VDA').AsCurrency   := 0;
          FieldByName('PRC_MAR_LRC').AsFloat  := Produto.TabelaPreco.Lista[I].MargemLucro;
          FieldByName('PRC_AQ_COM').AsFloat   := 0;
          FieldByName('PRC_QT_MIN').AsFloat   := 0;
          FieldByName('PRC_CODTPR').AsInteger := Produto.TabelaPreco.Lista[I].Codigo;
          FieldByName('PRC_CODIGO').AsInteger := 0;
        End;
        Post;
      End;

    End;
  Finally
    cds_tabela_preco.EnableControls;
    Cds_Tabela_Preco.LogChanges := True;
    Cds_Tabela_PrecoPRC_MAR_LRC.OnChange := ChangePriceByMargem;
    Cds_Tabela_PrecoPRC_VL_VDA.OnChange := ChangePriceByValor;
  End;
end;

procedure TFr_Produtos.ShowProduto;
begin
  E_Codigo.Text                     := produto.Registro.Codigo.tostring;
  E_Fabricante.Text                 := produto.Registro.CodigoFabrica;
  E_Barras.Text                     := produto.Registro.CodigoBarras;
  E_CodigoFor.Text                  := produto.Registro.CodigoFornecedor;
  E_CodClasfiscal.Text              := produto.Registro.CodigoNCM;
  E_DescricaoProduto.Text           := produto.Registro.Descricao;
  E_CEST.Text                       := produto.Registro.CEST;
  DBLCB_Grupo.KeyValue              := produto.Registro.CodigoGrupo;
  ListaSubgrupo;
  DBLCB_SubGrupo.KeyValue           := produto.Registro.CodigoSubgrupo;
  DBLCB_Marca.KeyValue              := produto.Registro.CodigoMarca;
  E_Dt_Ultima_compra.Text           := Fc_Dt_UltimaCompraProduto( produto.Registro.Codigo );
  E_Dt_Ultima_Venda.Text            :=Fc_Dt_UltimaVendaProduto( produto.Registro.Codigo );
  E_PrecoInstala.Text               := FloatToStrF( produto.Registro.PrecoInstalado,ffFixed,10,2);
  //aba Estoque
  DBLCB_Embalagem.KeyValue          := produto.Registro.CodigoEmbalagem;
  E_Divisor.Text                    := produto.Registro.Divisor.ToString;
  Fm_UnidadeComercial.Dblcb_Medida.KeyValue := produto.Registro.MedidaComercial;
  Pc_PreencheComboTipoProduto(produto.Registro.Tipo);
  Cb_Tipo_Produto.ItemIndex := AnsiIndexStr(UpperCase(produto.Registro.Tipo), ['P', 'M','C','A']);
  if produto.Registro.Tipo = 'A' then
    DM_ListaConsultas.Pc_ListaMedida(SIM,'')
  else
    DM_ListaConsultas.Pc_ListaMedida('','');

  E_Pro_Sequencia.Text              := Produto.registro.Sequencia.ToString;
  DBLCB_Revestimento.KeyValue       := Produto.Registro.Revestimento;
  E_Local.Text                      := Produto.registro.Localizacao;
  E_Peso.Text                       := FloattostrF(Produto.registro.PEso,ffFixed,10,2);
  E_Largura.Text                    := FloattostrF(Produto.registro.LArgura,ffFixed,10,2);
  E_Comprimento.Text                := FloattostrF(Produto.registro.Comprimento,ffFixed,10,2);
  E_Altura.Text                     := FloattostrF(Produto.registro.Altura,ffFixed,10,2);

  E_Custo_Last.Text                 := formatFloat(Gb_Casa_Dec_Compra,Produto.registro.UltimoCusto);
  E_CustoFab.Text                   := formatFloat(Gb_Casa_Dec_Compra,Produto.registro.ValorFabrica);
  E_custoReal.Text                  := formatFloat(Gb_Casa_Dec_Compra,Produto.registro.ValorCustoMedio);
  E_PrecoCusto.Text                 := formatFloat(Gb_Casa_Dec_Compra,Produto.registro.ValorCusto);
  E_PrecoTroca.Text                 := formatFloat(Gb_Casa_Dec_Compra,Produto.registro.ValorBaseTroca);
  E_QtdeMinima.Text                 := FloattostrF(Produto.registro.QtdeMinima,ffFixed,10,2);


  Cb_Origem.ItemIndex := StrToIntDef( Produto.Registro.Origem ,0);

  RB_Cps_Sem_Uso.Checked        := (Produto.Registro.Composicao = '1'); //não utilizar este recurso
  RB_Cps_Som_Itens.Checked      := (Produto.Registro.Composicao = '2'); //LAncar somente itens
  RB_Cps_Cascata_Qtde.Checked   := (Produto.Registro.Composicao = '3');  //Estoque em Cascata por quantidade
  RB_Cps_Qtde_Item.Checked      := (Produto.Registro.Composicao = '4'); //Quantidade por numero de Itens
  RB_Cps_Lanca_Item.Checked     := (Produto.Registro.Composicao = '5'); //Lançar somente os itens no pedido
  RB_Cps_auto_reposicao.Checked := (Produto.Registro.Composicao = '6'); //Lançar somente os itens no pedido

  Cb_available.ItemIndex := produto.Registro.Disponibilidade;
  E_Days_to_available.Text := produto.Registro.DiasParaDisponibilidade.ToString;
  //aba observação
  E_Observacao.Text       := produto.Registro.Detalhes;
  E_Aplicacao.Text        := DEcodeBase64( produto.Registro.Aplicacao);
  ChBx_Estoque.Checked    := ( produto.Registro.EstoqueNegativo = 'S');
  ChBx_ativo.Checked      := ( produto.Registro.Ativo = 'S');
  Chbx_ForaLinha.Checked  := ( produto.Registro.ForaLinha = 'S');

  ChBx_Impressao.Checked  := ( produto.Registro.Imprime = 'N');
  ChBx_Internet.Checked   := ( produto.Registro.Internet = 'S');
  Chbx_Send_Internet.Checked := ( produto.Registro.EnviarParaInternet = 'S');
  ChBx_indEscala.Checked  := ( produto.Registro.IndicacaoEscala = 'S');
  Chbx_Promocao.Checked   := ( produto.Registro.Campanha = 'S');
  Chbx_Destaque.Checked   := ( produto.Registro.Destaque = 'S');
  Chbx_Series.Checked     := ( produto.Registro.UtilizaSerie = 'S');
  ChBx_exclusivo.Checked  :=  ( produto.Registro.Exclusivo = 'S');
  //Aba Preco
  Chbx_fixed_rate.Checked := ( produto.Registro.PrecoVEndaFixo = 'S');
  //Aba TRibutação
  if produto.Registro.SubsTrib = 'S' then
    RG_SUBTRIB.ItemIndex := 0
  else
    RG_SUBTRIB.ItemIndex := 1;
  Cb_Finalid_Tributa.ItemIndex := StrToIntDef( produto.Registro.FinalidadeTributacao,1)-1;
  Fm_UnidadeTributavel.Dblcb_Medida.KeyValue := produto.Registro.MedidaTributavel;
  E_DT_Vencimento.DateTime := Produto.Registro.DataVencimento;
  E_QtdeMinAutoReposicao.text := FloatToStrF(Produto.Registro.QtdeMinAutoReposicao,fffixed,10,2);
end;

procedure TFr_Produtos.ShowStockList;
Var
  I : Integer;
begin
  TRy
    Produto.Estoque.Registro.Estabelecimento := Gb_CodMha;
    Produto.Estoque.getList;
    cds_Estoque.DisableControls;
    with cds_Estoque, Produto.Estoque  do
    Begin
      Active := False;
      CreateDataSet;
      LogChanges := False;
      EmptyDataSet;
      for I := 0 to Lista.Count - 1 do
      Begin
        Append;
        FieldByName('ETS_DESCRICAO').AsString := Lista[I].Descricao;
        FieldByName('ETS_CODIGO').AsInteger   := Lista[I].Codigo;
        FieldByName('ETS_PRINCIPAL').AsString := Lista[I].Principal;

        SaldoEstoque.Registro.CodigoEstoque :=  Lista[I].Codigo;
        SaldoEstoque.Registro.CodigoProduto := Produto.Registro.Codigo;
        SaldoEstoque.getbyId;
        if SaldoEstoque.exist then
        Begin
          FieldByName('EST_QTDE').AsFloat       := SaldoEstoque.Registro.QtdeDisp;
          FieldByName('EST_QTDE_MIN').AsFloat   := SaldoEstoque.Registro.QtdeMinima;
          FieldByName('EST_CODIGO').AsInteger   := SaldoEstoque.Registro.Codigo;
          FieldByName('EST_CODPRO').AsInteger   := SaldoEstoque.Registro.CodigoProduto;
        End
        else
        Begin
          FieldByName('EST_QTDE').AsFloat       := 0;
          FieldByName('EST_QTDE_MIN').AsFloat   := 0;
          FieldByName('EST_CODIGO').AsInteger   := 0;
          FieldByName('EST_CODPRO').AsInteger   := 0;
        End;
        Post;
      End;
    End;
  Finally
    cds_Estoque.First;
    cds_Estoque.EnableControls;
  End;

end;

procedure TFr_Produtos.ShowTray;
begin
  TrayLoja.Registro.Tabela := 'TB_PRODUTO';
  TrayLoja.Registro.Codigo := Produto.Registro.Codigo;
  TrayLoja.getByID;
  if TrayLoja.exist then
    E_Cd_Produto_Tray.Text := TrayLoja.Registro.WebID.ToString()
  else
    E_Cd_Produto_Tray.Clear;
end;

procedure TFr_Produtos.DBG_FornecedorDblClick(Sender: TObject);
begin
  Fc_AbreTelaFornecedor(Qr_Prod_Forn.FieldByName('PFR_CODFOR').AsInteger);
end;

procedure TFr_Produtos.DBG_FornecedorKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    if Key = VK_delete then
      SB_exc_fornecClick(Sender);
end;

procedure TFr_Produtos.SB_ImpostosClick(Sender: TObject);
Var
  LcForm : TSeaTaxation;
begin
  IF Fc_VerificaGravacaoComplementar then
  Begin
    LcForm := TSeaTaxation.create(nil);
    try
      LcForm.Produto := Produto.registro.codigo;
      LcForm.Empresa := 0;
      LcForm.ShowModal;
    finally
      FreeAndNil(LcForm);
      setProduto;
      AbreImposto;
    end;
  End;
end;

procedure TFr_Produtos.Sb_MarcaClick(Sender: TObject);
Var
  Lc_Form : TSeaProductBrand;
begin
  Lc_Form := TSeaProductBrand.Create(nil);
  Try
    if (Trim(DBLCB_Marca.Text) <> '') then
      Lc_Form.CodigoRegistro:= DBLCB_Marca.KeyValue;
    Lc_Form.ShowModal;
  Finally
    DM.Qr_MarcaProduto.Active := False;
    DM.Qr_MarcaProduto.Active := True;
    DBLCB_Marca.KeyValue := Lc_Form.CodigoRegistro;
    FreeAndNil(Lc_Form);
  End;
end;




procedure TFr_Produtos.E_LocalExit(Sender: TObject);
begin
  if ( It_Edicao_Ordem <> 'B' ) then
    Pc_ProcuraLocalizacao;
end;

procedure TFr_Produtos.E_CustoFabExit(Sender: TObject);
begin
  E_CustoFab.Text := FormatFloat(Gb_Casa_Dec_Compra, StrToFloatDef(E_CustoFab.Text, 0));
  if (It_Edicao_Ordem = 'I') then
  begin
    E_custoReal.Text := E_CustoFab.Text;
    E_PrecoCusto.Text := E_CustoFab.Text;
  end;
end;

procedure TFr_Produtos.E_BarrasExit(Sender: TObject);
begin
  if not PRodutoVeiculo then
  Begin
   if ( It_Edicao_Ordem <> 'B' ) AND (TRIM(E_Barras.Text) <>'') then
     Pc_ProcuraCodigoBarras;
  End;
end;

procedure TFr_Produtos.grid_instalacaoKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if Shift = [] then
      case Key of
      VK_delete: if SB_EXC_SERV.Enabled then SB_EXC_SERVClick(Sender);
      end;
end;


procedure TFr_Produtos.DBG_PrecoKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
    if TDBGrid(Sender).Columns.Grid.SelectedIndex < TDBGrid(Sender).Columns.Count - 1 then
      TDBGrid(Sender).Columns[TDBGrid(Sender).Columns.grid.SelectedIndex + 1].Field.FocusControl
    else
    begin
      Cds_Tabela_Preco.Next;
      TDBGrid(Sender).Columns[0].field.FocusControl;
    end;
  end;
end;

procedure TFr_Produtos.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  PRodutoVeiculo := (Fc_Tb_Geral('L','PRO_G_LABEL_PRO','') = 'S');
  ProdutoMultiEmpresa := ( Fc_Tb_Geral('L','PRO_G_COMPARTILHA','N') ='S' );
  Pc_Define_CasasDecimais;
  Pc_PermissaoBotao('Cadastro Produtos');
  Pc_ImagemPermissao;
  It_Edicao_Ordem := 'N';
  Pc_NomeLabel;
  if (Produto.Registro.Codigo > 0) then
  begin
    Pc_Prod_Inativo(Produto.Registro.codigo, (Date - StrToIntdef(Fc_Tb_Geral('L','PRO_P_INATIVIDADE',''), 0)));
    setProduto;
    It_Edicao_Ordem := 'B';
  end
  else
  bEGIN
    showNodata;
    It_Edicao_Ordem := 'I';
  end;
  EstadoEdicao;
end;

procedure TFr_Produtos.Pc_Define_aba;
begin
  if (Fc_Tb_Geral('L','PRO_G_ABA_FORNECEDOR','S') = 'S')  then tbs_fornecedor.tabVisible:=true else tbs_fornecedor.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_IMPOSTO','S') = 'S')     then tbs_impostos.tabVisible:=true else tbs_impostos.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_TABELA','S') = 'S')      then tbs_tbpreco.tabVisible:=true else tbs_tbpreco.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_INSTALACAO','S') = 'S')  then tbs_instalacao.tabVisible:=true else tbs_instalacao.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_ESTOQUE','S') = 'S')     then tbs_estoque.tabVisible:=true else tbs_estoque.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_COMPOSICAO','S') = 'S')  then tbs_composicao.tabVisible:=true else tbs_composicao.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_APLICACAO','S') = 'S')   then Tbs_Aplicacao.tabVisible:=true else Tbs_Aplicacao.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_BOTOES','S') = 'S')      then tbs_botao.tabVisible:=true else tbs_botao.tabVisible :=false;
  if (Fc_Tb_Geral('L','PRO_G_ABA_INSUMO_PROD','S') = 'S') then tbs_Producao.tabVisible:=true else tbs_Producao.tabVisible :=false;
end;

procedure TFr_Produtos.EstadoEdicao;
begin
  pnl_fundo.Enabled:=  ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  //ABA DE OBSERVAÇÃO
  Pnl_obs.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  //ABA DE IMPOSTOS
  Pnl_Imposto.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  //ABA DE ESTOQUE
  Panel8.Enabled:=( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Rdg_Composicao.Enabled:=( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );

  EstadoEdicaoFornecedor;
  EstadoEdicaoTabelaPreco;
  EstadoEdicaoInstalacao;
  EstadoEdicaoComposicao;
  EstadoEdicaoProducao;
  EstadoEdicaoBotao;
  EstadoEdicaoSerie;
  EstadoEdicaoInternet;
  EstadoEdicaoSimilar;
  EstadoEdicaoReposicao;
end;

procedure TFr_Produtos.Sb_Ins_Product_SimilarClick(Sender: TObject);
var
  LcProd : TControllerProductSimilar;
  Lc_Form : TFr_Pesq_Produto;
begin
  Try
    LcProd := TControllerProductSimilar.create(nil);
    Lc_Form := TFr_Pesq_Produto.Create(nil);
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    Lc_Form.ShowModal;
    //Depois que Fecha o Relatorio
    if TFr_Pesq_Produto(Lc_Form).It_Visualizar then
    Begin
      LcProd.Registro.Master  := Produto.Registro.Codigo;
      LcProd.Registro.Similar := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsInteger;
      if ( LcProd.Registro.Master <> LcProd.Registro.Similar ) then
      Begin
        LcProd.salva;
      End
      else
      Begin
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                       'Não é possivel informar o mesmo produto como Similar.' + EOLN +
                       'Verifique o produto escolhido e tente novamente.' + EOLN,
                        ['OK'], [bEscape], mpErro);
      End;
    end;
  Finally
    FreeAndNil (LcProd);
    FreeAndNil(Lc_Form) ;
    AbrePRodutoSimilar
  End;
end;

procedure TFr_Produtos.Sb_Ins_ProdutoClick(Sender: TObject);
begin
  if Fc_VerificaGravacaoComplementar then
  Begin
    if not Assigned(Fr_Composicao) then
      Application.CreateForm(TFr_Composicao, Fr_Composicao);
    Try
      Fr_Composicao.It_Cd_Produto := Produto.Registro.Codigo;
      Fr_Composicao.Pc_StateChange(2);
      Fr_Composicao.It_Tp_servico:='';
      Fr_Composicao.It_Tp_Produto:='';
      Fr_Composicao.It_Cd_Prod_D := 0;
      Fr_Composicao.E_Qtde.Text := '1';
      Fr_Composicao.ShowModal;
    Finally
      AbreComposicao;
      Pc_AtualizaComposicao;
      EstadoEdicao;
    End;
  End;
end;

procedure TFr_Produtos.Sb_ins_reposicaoClick(Sender: TObject);
Var
  Lc_form : TRegProdutoReposicao;
begin
  if Fc_VerificaGravacaoComplementar then
  Begin
    Lc_form := TRegProdutoReposicao.create(Self);
    Try
      Lc_form.Dataset := Cds_reposicao;
      Lc_form.Dataset.Append;
      Lc_form.Dataset.FieldByName('PPD_CODPRO_M').AsInteger := Produto.Registro.Codigo;
      Lc_form.StateChange := 'I';
      Lc_form.Showmodal;
    Finally
      FreeAndNil(Lc_form);
    End;
  End;
end;

procedure TFr_Produtos.Sb_Alt_ProdutoClick(Sender: TObject);
begin
   if not Assigned(Fr_Composicao) then
      Application.CreateForm(TFr_Composicao, Fr_Composicao);
  Fr_Composicao.Pc_StateChange(3);
  Fr_Composicao.It_Inserir := True;
  Fr_Composicao.It_Tp_servico:='';
  Fr_Composicao.It_Tp_Produto:='';
  Fr_Composicao.It_Cd_Produto := Produto.Registro.Codigo;
  Fr_Composicao.It_Cd_Prod_D := Qr_Prod_Prod.FieldByName('PPD_CODPRO_D').AsInteger;
  Fr_Composicao.E_CodPro.Text := Qr_Prod_Prod.FieldByName('PPD_CODPRO_D').AsString;
  Fr_Composicao.E_Descricao.Text := Qr_Prod_Prod.FieldByName('PRO_DESCRICAO').AsString;
  Fr_Composicao.E_Qtde.Text :=  FloatToStrf(Qr_Prod_Prod.FieldByName('PPD_QTDE').AsFloat,ffFixed,10,6);
  Fr_Composicao.ShowModal;
  AbreComposicao;
  Pc_AtualizaComposicao;
  EstadoEdicao;
end;

procedure TFr_Produtos.Sb_Exc_Product_SimilarClick(Sender: TObject);
var
  LcProd : TControllerProductSimilar;
begin
  Try
    LcProd := TControllerProductSimilar.create(nil);
    LcProd.Registro.Master  := Produto.Registro.Codigo;
    LcProd.Registro.Similar := Qr_Product_Similar.FieldByName('TB_PRODUCT_ID_SIMILAR').AsInteger;
    LcProd.delete;
  Finally
    FreeAndNil (LcProd);
    AbrePRodutoSimilar
  End;
end;

procedure TFr_Produtos.Sb_Exc_ProdutoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
     'Retirar o produto ' + Qr_Prod_Prod.FieldByName('PRO_DESCRICAO').AsString + ' de seus arquivos.' + EOLN + EOLN +
     'Confirmar a retirada ?',
     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
    try
      if not Assigned(Fr_Composicao) then
        Application.CreateForm(TFr_Composicao, Fr_Composicao);
      Fr_Composicao.It_Cd_Produto := Qr_Prod_Prod.FieldByname('PPD_CODPRO_M').AsInteger;
      Fr_Composicao.It_Cd_Prod_D := Qr_Prod_Prod.FieldByname('PPD_CODPRO_D').AsInteger;
      Fr_Composicao.Pc_StateChange(4);
      Fr_Composicao.Pc_CriaComposicao;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Fr_Composicao.Close;
      AbreComposicao;
      Pc_AtualizaComposicao;
    except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Um erro impossibilitou a retirada do produto.' + EOLN +
      'Entre em contato com o suporte técnico.' + EOLN,
      ['OK'], [bEscape], mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
end;

procedure TFr_Produtos.Sb_EmbalagemClick(Sender: TObject);
Var
  Lc_Form : TSeaPackage;
begin
  try
    Lc_Form := TSeaPackage.Create(Self);
    Lc_Form.ShowModal;
    DM.Qr_Embalagem.Active := False;
    DM.Qr_Embalagem.Active := True;
    DBLCB_Embalagem.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

function TFr_Produtos.Fc_ValidaGravacao: boolean;
Begin
  Result := true;
  if not Fc_Pre_ValidaGravacao then
  Begin
    Result := False;
    exit;
  End;

  if not ValidaAlteracaoDescricao then
  Begin
    Result := False;
    exit;
  End;

  if not Fc_validaAliquotaComissao(Cds_Tabela_Preco.FieldByName('PRC_MAR_LRC').AsFloat) then
  Begin
    Result := False;
    exit;
  End;

  if RB_Cps_auto_reposicao.Checked THEN // dentro da funcao ele verifica a configuracao se controla a duplicacao
  Begin
    if Cds_reposicao.RecordCount = 0 then
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Com a opção Reposição automatica'+EOLN+
                     'È obrigatório algun item na aba composição'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      PG_Informacoes.ActivePage := tbs_reposicao;
      exit;
    End;

    if StrToFloatDef(E_QtdeMinAutoReposicao.Text,0) = 0 then
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Com a opção Reposição automatica'+EOLN+
                     'È obrigatório infomar a quantidade minima para a reposição'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      PG_Informacoes.ActivePage := tbs_estoque;
      E_QtdeMinAutoReposicao.SetFocus;
      exit;
    End;
  end;
end;

function TFr_Produtos.Fc_ValidaCancelamento(): boolean;
Begin
  Result := True;
  //Valida se a aliquota de comissão foi preenchida
  if Produto.Registro.codigo > 0 then
  Begin
    Cds_Tabela_Preco.Active := true;
    Cds_Tabela_Preco.First;
    while not Cds_Tabela_Preco.Eof do
    Begin
      if not Fc_validaAliquotaComissao(Cds_Tabela_Preco.FieldByName('PRC_MAR_LRC').AsFloat) then abort;
      Cds_Tabela_Preco.Next;
    end;
  end;
end;

procedure TFr_Produtos.abeladePreo1Click(Sender: TObject);
Var
  Lc_Form:TFr_Tabela_Preco;
begin
  Lc_Form := TFr_Tabela_Preco.Create(self);
  Lc_Form.ShowModal;
  ShowPriceList;
  FreeAndNil(Lc_Form);
end;

procedure TFr_Produtos.AbreBotao;
begin
  with Qr_botao do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Produto.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Produtos.AbreComposicao;
begin
  with Qr_Prod_Prod do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Produto.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Produtos.AbreFornecedores;
begin
  with Qr_Prod_Forn do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    if Transaction.InTransaction then Transaction.Commit;
    Qr_Prod_Forn.close;
    //Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Produto.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Produtos.AbreImposto;
begin
  with Qr_Impostos do
  Begin
    if Transaction.InTransaction then Transaction.CommitRetaining;
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    ParamByName('TRB_CODPRO').AsInteger := Produto.Registro.Codigo;
    ParamByName('TRB_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
  End;
end;

procedure TFr_Produtos.abreProducao;
begin
  with qrproducao do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Produto.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Produtos.AbrePRodutoSimilar;
begin
  with Qr_Product_Similar do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Produto.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Produtos.AbreReposicao;
Var
  I : Integer;
begin
  with Produto  do
  Begin
    reposicao.Parametros.FieldName.produtoMaster := Produto.Registro.Codigo;
    reposicao.Search;
    if not Cds_reposicao.Active then Cds_reposicao.CreateDataSet;
    Cds_reposicao.EmptyDataSet;
    Cds_reposicao.LogChanges := False;
    for I := 0 to reposicao.Lista.Count -1 do
    Begin
      Cds_reposicao.Append;
      Cds_reposicaoPPD_CODPRO_M.AsInteger := reposicao.Lista[i].produtoMaster;
      Cds_reposicaoPPD_CODPRO_D.AsInteger := reposicao.Lista[i].produtodetalhe;
      Cds_reposicaoPRO_DESCRICAO.AsString := reposicao.Lista[i].produto;
      Cds_reposicaoPRO_CODIGOFAB.AsString := reposicao.Lista[i].CodigoFabrica;
      Cds_reposicaoPPD_QTDE.AsFloat       := reposicao.Lista[i].Qtde;
      Cds_reposicaoPPD_METODO.AsString    := reposicao.Lista[i].Metodo;
      Cds_reposicaoPPD_QTDE_USED.AsFloat  := reposicao.Lista[i].QtdeUsada;
      Cds_reposicao.Post;
    End;
    Cds_reposicao.LogChanges := True;
  End;
end;

procedure TFr_Produtos.AbreSerie;
begin
  with Qr_Series do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Produto.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Produtos.AbreServico;
begin
  with Qr_Servico do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    ParamByName('PRO_CODIGO').AsInteger := Produto.Registro.Codigo;
    Active := True;
    FetchAll;
    First;
  End;
end;

procedure TFr_Produtos.AjustarPreoporEscala1Click(Sender: TObject);
Var
  Lc_Form : TTasChangePriceByScale;
begin
  Try
    Lc_Form := TTasChangePriceByScale.create(nil);
    Lc_Form.Produto := Produto.Registro.Codigo;
    Lc_Form.ValorCusto := Produto.Registro.ValorCustoMedio;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    ShowPriceList;
  End;
end;

procedure TFr_Produtos.Pc_CopiaProduto;
Var
  Lc_I : Integer;
  LcCodigoAnterior : Integer;

Begin
  LcCodigoAnterior := produto.Registro.Codigo;
  PG_Informacoes.ActivePageIndex := 0;
  produto.Registro.Codigo := 0;
  produto.Registro.CodigoFabrica := '';
  produto.Registro.CodigoBarras := '';
  produto.Registro.CodigoFornecedor := '';
  produto.insert;

  produto.TabelaPreco.Preco.CopiaTabela( produto.Registro.Codigo,LcCodigoAnterior);

  //Estoque
  produto.Estoque.SaldoEstoque.CriaRegistroAutomatico(produto.Registro.Codigo);

  Pc_copia_ProdForn( produto.Registro.Codigo ,LcCodigoAnterior);
  Pc_Copia_ProdServico(produto.Registro.Codigo,LcCodigoAnterior);
  Pc_Copia_ProdComposicao(produto.Registro.Codigo,LcCodigoAnterior);
  Pc_Copia_ProdAVIAMENTO(produto.Registro.Codigo,LcCodigoAnterior);
  Pc_Copia_ProdMaoObra(produto.Registro.Codigo,LcCodigoAnterior);
  Pc_Copia_ProdbORDADO(produto.Registro.Codigo,LcCodigoAnterior);
  Pc_Copia_ProdEstampa(produto.Registro.Codigo,LcCodigoAnterior);
  CopiarTributacao(LcCodigoAnterior,produto.Registro.Codigo);
  setProduto;
  It_Edicao_Ordem := 'E';
  EstadoEdicao;

end;

procedure TFr_Produtos.Pc_Valor_Campanha(Pc_Cod_Produto: Integer; Pc_Tabela: Integer; Pc_Preco: Double);
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
begin
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    Active := False;
    SQL.Clear;

    Lc_Txt := 'SELECT PRC_CODIGO, PRC_CODTPR, '+
              '  PRC_CODPRO, PRC_VL_VDA       '+
              'FROM TB_PRECO                  '+
              'WHERE PRC_CODTPR =:PRC_CODTPR  '+
              '  AND PRC_CODPRO =:PRC_CODPRO  ';
    SQL.Add(Lc_Txt);
    ParamByName('PRC_CODTPR').AsInteger := Pc_Tabela;
    ParamByName('PRC_CODPRO').AsInteger := Pc_Cod_Produto;
    Active := True;

    if ( Produto.Registro.Campanha = 'S') then
    begin
      if FieldByName('PRC_VL_VDA').AsCurrency > Pc_Preco then
      begin
        ShowMessage('Valor da Promoção maior que o valor de Venda...');
      end;
    end;
  end;
  Lc_Qry.close;
  FreeandNil(Lc_Qry);
end;



Procedure TFr_Produtos.Pc_AtualizaTabelaVendasPelaMargem(Pc_Vl_custo:Real);
Var
  Lc_Aq_Margem : real;
  Lc_Vl_Preco : Real;
Begin
  if not Cds_Tabela_Preco.Active then Cds_Tabela_Preco.Active := True;
  Cds_Tabela_Preco.First;
  Cds_Tabela_PrecoPRC_MAR_LRC.OnChange := nil;
  Cds_Tabela_PrecoPRC_VL_VDA.OnChange := nil;
  while not Cds_Tabela_Preco.Eof do
  Begin
    Lc_Aq_Margem := 0;
    if ( Cds_Tabela_Preco.FieldByName('TPR_MAR_PRIORITARIA').AsString = 'S' ) then
      Lc_Aq_Margem := Cds_Tabela_Preco.FieldByName('TPR_MAR_LRC').AsFloat;

    if Lc_Aq_Margem = 0 then
      Lc_Aq_Margem := Cds_Tabela_Preco.FieldByName('PRC_MAR_LRC').AsFloat;

    if Lc_Aq_Margem > 0 then
    Begin
      Lc_Vl_Preco := Fc_CalcularPrecoPelaMargemLucro(
                                                    Pc_Vl_custo,
                                                    Lc_Aq_Margem,
                                                    Cds_Tabela_PrecoTPR_CASA_DECIMAL.AsInteger);
      {
      desativado em 21/04/2020 - por que se é por margem, pressupoe que deve ter a margem
      Lc_Aq_Margem := Fc_CalcularMargemPeloPreco(
                                                Pc_Vl_custo,
                                                Lc_Vl_Preco,
                                                2);//calculo pela margem sempre com duas casas
      }
      Cds_Tabela_Preco.edit;
      Cds_Tabela_PrecoPRC_VL_VDA.AsCurrency  := Lc_Vl_Preco;
      Cds_Tabela_PrecoPRC_MAR_LRC.AsCurrency := Lc_Aq_Margem;
      Cds_Tabela_Preco.Post;
    end;
    Cds_Tabela_Preco.Next;
  end;
  Cds_Tabela_PrecoPRC_MAR_LRC.OnChange := ChangePriceByMargem;
  Cds_Tabela_PrecoPRC_VL_VDA.OnChange := ChangePriceByValor;
end;


function TFr_Produtos.Fc_Verifica_Forn(Fc_Cd_Fornece:Integer): Boolean;
var
  Lc_Qry:TSTQuery;
begin
  result:=true;
  Lc_Qry:= TSTQuery.Create(self);
  with Lc_Qry do
    Begin
    Database:=DM.IBD_Gestao;
    Transaction:=DM.IB_Transacao;
    Active:=false;
    SQL.Clear;
    SQL.Add(' SELECT DISTINCT PFR_CODFOR FROM TB_PROD_FORN '+
            ' WHERE (PFR_CODFOR = :PFR_CODFOR) '+
            '   AND (PFR_CODPRO = :PFR_CODPRO) ');
    ParamByName('PFR_CODFOR').AsInteger:= Fc_Cd_Fornece;
    ParamByName('PFR_CODFOR').AsInteger:= Produto.Registro.Codigo;
    Active:=true;
    FetchAll;
    First;
    Result := not (RecordCount > 0);
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_Produtos.Pc_AtualizaItensInstalacao(Pc_Operacao:String;Pc_Codigo,Pc_Cd_Produto,Pc_Cd_servico:Integer);
var
  Lc_Qry :TSTQuery;
begin
  Try
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry do
    Begin
      Database:=DM.IBD_Gestao;
      Transaction:=DM.IBT_Crud;
      if not Transaction.InTransaction then Transaction.StartTransaction;
      Active:=false;
      SQL.Clear;
      if Pc_Operacao = 'U' then
      Begin
        SQL.Add('UPDATE OR INSERT INTO TB_PROD_SERV (PSI_CODIGO, PSI_CODPRO, PSI_CODSRV) '+
                '                VALUES (:PSI_CODIGO, :PSI_CODPRO, :PSI_CODSRV) '+
                '               MATCHING (PSI_CODPRO, PSI_CODSRV) ');
        ParamByName('PSI_CODIGO').AsInteger:= Pc_Codigo;
        ParamByName('PSI_CODPRO').AsInteger:= Pc_Cd_Produto;
        ParamByName('PSI_CODSRV').AsInteger:= Pc_Cd_servico;
        ExecSQL;
      end
      else
      Begin
        SQL.Add('DELETE FROM TB_PROD_SERV '+
               'WHERE (PSI_CODPRO =:PSI_CODPRO) AND (PSI_CODSRV =:PSI_CODSRV) ');
        ParamByName('PSI_CODPRO').AsInteger:= Pc_Cd_Produto;
        ParamByName('PSI_CODSRV').AsInteger:= Pc_Cd_servico;
        ExecSQL;
      end;
      if Transaction.InTransaction then Transaction.Commit;
    end;
  Finally
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);

  End;
end;

procedure TFr_Produtos.Pc_AtualizaProducao;
var
  Lc_Vl_Custo,Lc_Vl_Custo_Medio: real;
begin
  if qrProducao.RecordCount > 0 then
  Begin
    Lc_Vl_Custo := 0;
    Lc_Vl_Custo_Medio := 0;
    while not qrProducao.Eof do
    begin
      Lc_Vl_Custo := Lc_Vl_Custo + (qrProducao.FieldByName('PRO_VL_CUSTO').AsCurrency * qrProducao.FieldByName('FTC_CS_UNIT').AsFloat);
      Lc_Vl_Custo_Medio := Lc_Vl_Custo_Medio + (qrProducao.FieldByName('PRO_VL_CUSTOMED').AsCurrency * qrProducao.FieldByName('FTC_CS_UNIT').AsFloat);
      qrProducao.Next;
    end;
    if Lc_Vl_Custo <> Produto.Registro.ValorCusto then
    begin
      if It_Edicao_Ordem <> 'I' then
      Begin
        PRoduto.registro.ValorCusto := Lc_Vl_Custo;
        PRoduto.registro.ValorCustoMedio := Lc_Vl_Custo_Medio;
        E_PrecoCusto.Text := FloatToStrF(Lc_Vl_Custo,ffFixed,10,2);
        E_custoReal.Text := FloatToStrF(Lc_Vl_Custo_Medio,ffFixed,10,2);
        Produto.update;
      End;
    end;
  End;
end;

procedure TFr_Produtos.Pc_AtualizaInstalacao;
var
   lc_Valor: Real;
begin
  if Qr_Servico.RecordCount > 0 then
  Begin
    Lc_Valor := 0;
    while not Qr_Servico.Eof do
    begin
      Lc_Valor := Lc_Valor + Qr_Servico.FieldByName('PRC_VL_VDA').AsCurrency;
      Qr_Servico.Next;
    end;
    if lc_Valor <> Produto.Registro.PRecoInstalado then
    begin
      if It_Edicao_Ordem <> 'I' then
      Begin
        Produto.update;
        E_PrecoInstala.Text := FloatToStrF(Lc_Valor, ffFixed, 10, 2);
      End;
    end;
  End;
end;

function TFr_Produtos.Fc_VerificaGravacaoComplementar():Boolean;
Begin
  Result := True;
  if ( It_Edicao_Ordem = 'I' ) then
  Begin
    if not Fc_Pre_ValidaGravacao then
    Begin
      Result := False;
      exit;
    end;
    SAveProduto;
  end;
end;

procedure TFr_Produtos.SB_exc_fornecClick(Sender: TObject);
begin
  if Qr_Prod_Forn.RecordCount > 0 then
  begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Excluir ' + Qr_Prod_Forn.FieldByname('EMP_FANTASIA').AsString + ' de seus arquivos.' + EOLN + EOLN +
                       'Confirmar a exclusão ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    Begin
      Pc_DesvincularCodigoProdutoFornecedor(Qr_Prod_Forn.FieldByname('PFR_CODPRO').AsString,
                                            Qr_Prod_Forn.FieldByname('PFR_CODFOR').AsString);
      AbreFornecedores;
    end
  end;
end;

procedure TFr_Produtos.SB_INS_SERVClick(Sender: TObject);
Var
  Lc_Form : TSeaService;
  Lc_Codigo : Integer;
begin
  if Fc_VerificaGravacaoComplementar then
  Begin
    Lc_Form := TSeaService.Create(nil);
    Try
      Lc_Form.ShowModal;
      if (Lc_Form.cds_searchcodigo.AsInteger > 0) then
        Begin
        if (MensagemPadrao(' Mensagem de Confirmação',
                           ' Confirma a inclusão deste serviço na instalção do produto.' + EOLN + EOLN +
                           ' Confirmar a inclusão ?',
                            [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
          Begin
          Lc_Codigo :=  Fc_Generator('GN_PROD_SERV','TB_PROD_SERV','PSI_CODIGO');
          Pc_AtualizaItensInstalacao('U',
                                     Lc_Codigo,
                                     PRoduto.Registro.codigo,
                                     Lc_Form.cds_searchcodigo.AsInteger);
          end;
        end;
    Finally
      FreeAndNil(Lc_Form);
    End;
    AbreServico;
    Pc_AtualizaInstalacao;
  end;
end;

procedure TFr_Produtos.SB_EXC_SERVClick(Sender: TObject);
begin
  if Qr_Servico.RecordCount > 0 then
  begin
    if (MensagemPadrao(' Mensagem de Confirmação',
                       ' Excluir ' + Qr_Servico.FieldByName('PRO_DESCRICAO').AsString + ' de seus arquivos.' + EOLN + EOLN +
                       ' Confirmar a exclusão ?',
                        [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    Begin
      Pc_AtualizaItensInstalacao('D',
                                 0,
                                 Qr_Servico.FieldByName('PSI_CODPRO').AsInteger,
                                 Qr_Servico.FieldByName('PSI_CODSRV').AsInteger);
    end;
    AbreServico;
    Pc_AtualizaInstalacao;
  END;
end;

procedure TFr_Produtos.Pc_F2;
begin
  if SB_Inserir.Enabled then
    SB_InserirClick(SELF)
  ELSE
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage = tbs_fornecedor)  then
   SB_Ins_fornecClick(self)
  else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage =tbs_instalacao) then
    SB_INS_SERVClick(Self)
  else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage =tbs_composicao) then
    Sb_Ins_ProdutoClick(Self)
 else
   if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage = tbs_Producao ) then
    sb_Ins_ProducaoClick(Self)
 else
   if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage = tbs_product_similar ) then
    Sb_Ins_Product_SimilarClick(Self);


end;

procedure TFr_Produtos.Pc_f3;
begin
  if SB_Alterar.Enabled then
    SB_AlterarClick(Self)
  else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage =tbs_composicao) and (Qr_Prod_Prod.RecordCount > 0) then
   Sb_Alt_Produtoclick(Self)
  else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage =tbs_Producao) and (qrproducao.RecordCount > 0) then
   sb_Alt_ProducaoClick(Self);
end;

procedure TFr_Produtos.Pc_f4;
begin
  if SB_Excluir.Enabled then
    SB_ExcluirClick(Self)
  else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage = tbs_fornecedor) and (Qr_Prod_Forn.RecordCount > 0) then
   SB_exc_fornecClick(self)
  else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage =tbs_composicao) and (Qr_Prod_Prod.RecordCount > 0) then
   Sb_exc_Produtoclick(Self)
   else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage =tbs_Producao) and (qrproducao.RecordCount > 0) then
   sb_Exc_ProducaoClick(Self)
   else
  if ( It_Edicao_Ordem <> 'B' ) and (PG_Informacoes.ActivePage =tbs_product_similar) and (Qr_Product_Similar.RecordCount > 0) then
   Sb_Exc_Product_SimilarClick(Self);

end;

function TFr_Produtos.existeCodigoCodFabrica(): Boolean;
VAR
 lc_qr_aux:TSTQuery;
begin
  Result:= False;
  if (Length( Trim(E_Fabricante.Text)) >0 ) then
  Begin
    if Fc_Tb_Geral('L','PRO_G_VAL_CODIGOFAB','N') ='S' then
    Begin
      Try
        lc_qr_aux:= TSTQuery.Create(self);
        with lc_qr_aux do
        Begin
          Database:=DM.IBD_Gestao;
          Transaction:=dm.IB_Transacao;
          Active:=False;
          SQL.Clear;
          SQL.Add(concat(
                    ' select pro_codigo from tb_produto  ',
                    ' where  pro_codigofab = :pro_codigofab ',
                    ' AND PRO_CODIGO <> :PRO_CODIGO      ',
                    ' AND (PRO_TIPO <> ''S'') '
                    ));
          ParamByName('pro_codigofab').AsString:= E_Fabricante.Text;
          ParamByName('pro_codigo').AsInteger:= Produto.Registro.Codigo;
          Active:=true;
          FetchAll;
          if not lc_qr_aux.IsEmpty then
            Result:= True;
        End;
      Finally
        lc_qr_aux.Close;
        FreeAndNil(lc_qr_aux);
      End;
    END;
  End;
end;

procedure TFr_Produtos.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Inserir:= True;
    It_Alterar:=True;
    It_Excluir:=True;
    It_Visualizar:=True;
  end
  else
  begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
  end;
end;

procedure TFr_Produtos.Sb_ClassificacaoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_NCM;
begin
  Try
    Lc_Form := TFr_Pesq_NCM.Create(Self);
    Lc_Form.It_Visualizar := False;
    Lc_Form.ShowModal;
    if Lc_Form.It_Visualizar then
      E_CodClasfiscal.Text := Lc_Form.Qr_Pesquisa.FieldByName('NCM_N_NCM').AsString;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;


procedure TFr_Produtos.Sb_del_reposicaoClick(Sender: TObject);
begin
  if TMsgSetes.Excluir then
  Begin
    Cds_reposicao.Delete;
  End;
end;

procedure TFr_Produtos.Sb_edi_reposicaoClick(Sender: TObject);
Var
  Lc_form : TRegProdutoReposicao;
begin
  if ( Cds_reposicao.RecordCount > 0 ) then
  Begin
    Lc_form := TRegProdutoReposicao.create(Self);
    Try
      Lc_form.Dataset := Cds_reposicao;
      Lc_form.Dataset.Edit;
      Lc_form.StateChange := 'E';
      Lc_form.Showmodal;
    Finally
      FreeAndNil(Lc_form);
    End;
  End;
end;

procedure TFr_Produtos.Pc_NomeLabel;
begin
  if ProdutoVeiculo then
  begin
    lbl_nr_fabricacao.Caption:='Chassi';
    lbl_cd_barra.Caption:= 'Placa';
    lbl_cd_forn.Caption:='Renavan';
  end
  else
  begin
    lbl_nr_fabricacao.Caption:='Nº Fabricação / Montadora';
    lbl_cd_barra.Caption:= 'Código de Barras';
    lbl_cd_forn.Caption:='Código do Fornecedor';
  end
end;

procedure TFr_Produtos.Qr_botaoAfterOpen(DataSet: TDataSet);
begin
  Sb_Alt_botao.Enabled := (Qr_botao.RecordCount > 0);
  Sb_Exc_botao.Enabled := (Qr_botao.RecordCount > 0);
  E_Sequencia.Text := Qr_botaoIBT_SEQUENCIA.AsString;
  Pc_ImagemBotao;
end;

procedure TFr_Produtos.Pc_ImagemBotao;
var
  St_Image:TStream;
  Jp_IMage: TBitmap; // sem a unit 'jpeg' essa classe não existiria
Begin
  Jp_IMage := nil;
  St_Image := Qr_Botao.CreateBlobStream(Qr_Botao.FieldByName('BTN_IMAGEM'),bmRead);
  if St_Image.Size > 0 then
  begin
    Jp_IMage := TBitmap.Create;
    Jp_IMage.LoadFromStream(St_Image);
    Sb_Amostra.Glyph.Assign( Jp_IMage );
    SB_Amostra.Height := Qr_botaoBTN_ALTURA.AsInteger;
    SB_Amostra.Width  := Qr_botaoBTN_LARGURA.AsInteger;
    SB_Amostra.Caption  := Qr_botaoBTN_LABEL.Text;
    SB_Amostra.Margin := StrToIntDef(Qr_botaoBTN_MRG_SUP.AsString,0);
  end
  else
  Begin
    FreeAndNil(Jp_IMage);
    FreeAndNil(St_Image);
  end;
end;

procedure TFr_Produtos.Sb_Ins_BeneficioClick(Sender: TObject);
begin
  Strgrd_Benefi_UF.RowCount := Strgrd_Benefi_UF.RowCount + 1
end;

procedure TFr_Produtos.SB_Ins_fornecClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Empresa;
begin
  Lc_Form := TFr_Pesq_Empresa.Create(nil);
  try
    Lc_Form.TipoEmpresa := 2;
    Lc_Form.ShowModal;
    if (Lc_Form.Qr_Pesquisa.RecordCount > 0) then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Vincular este Fornecedor a este produto.'+EOLN+EOLN+
                         'Confirmar a operação?',
                          [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
      Begin
        Pc_VincularCodigoProdutoFornecedor(Produto.Registro.Codigo.toString,
                                           Lc_Form.Qr_Pesquisa.FieldByName('EMP_CODIGO').AsString,
                                           '');
        AbreFornecedores;
      End;
    End;
  finally
    FreeAndNil(Lc_Form);
  end;

end;


procedure TFr_Produtos.Sb_Exc_BeneficioClick(Sender: TObject);
begin
  if Strgrd_Benefi_UF.RowCount <= 2 then
  Begin
    Strgrd_Benefi_UF.Cells[1,1] := '';
    Strgrd_Benefi_UF.Cells[2,1] := '';
    Strgrd_Benefi_UF.Cells[3,1] := '';
  End
  else
    Strgrd_Benefi_UF.DelRow(Strgrd_Benefi_UF.Row);
end;

procedure TFr_Produtos.tbs_botaoShow(Sender: TObject);
begin
  AbreBotao;
end;

procedure TFr_Produtos.tbs_seriesShow(Sender: TObject);
begin
  AbreSerie;
end;

function TFr_Produtos.Fc_ValidaCadastroSeries:Boolean;
Begin
  Result := True;
  AbreSerie;
  If (Qr_Series.RecordCount >= cds_Estoque.FieldByName('EST_QTDE').AsInteger) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não há Quantidade de estoque suficiente para informar Número de Séries.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;
end;

procedure TFr_Produtos.Sb_Ins_SerieClick(Sender: TObject);
begin
  if not Fc_ValidaCadastroSeries then exit;
  if not Assigned(Fr_Produto_Serie) then Application.CreateForm(TFr_Produto_Serie, Fr_Produto_Serie);
  Fr_Produto_Serie.Tag := 3;
  Fr_Produto_Serie.It_cd_Serie := 0;
  Fr_Produto_Serie.It_cd_Item := 0;
  Fr_Produto_Serie.It_cd_Produto := Produto.Registro.Codigo;
  Fr_Produto_Serie.It_Qt_Produto := cds_Estoque.FieldByName('EST_QTDE').AsInteger;
  Fr_Produto_Serie.ShowModal;
  AbreSerie;
end;

procedure TFr_Produtos.Chbx_SeriesClick(Sender: TObject);
begin
  if Chbx_Series.Checked then
  Begin
    tbs_series.TabVisible := Visible;
  end
  else
  Begin
    AbreSerie;
    if Qr_Series.RecordCount >0 then
    Begin
      Chbx_Series.Checked := true;
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Existe(m) série(s) registrada(s) neste produto.'+EOLN+
                     'Não é possivel desabilitar está opção.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    end
    else
      tbs_series.TabVisible := not Visible;
  end;
end;

procedure TFr_Produtos.Sb_alt_SerieClick(Sender: TObject);
begin
  if not Assigned(Fr_Produto_Serie) then Application.CreateForm(TFr_Produto_Serie, Fr_Produto_Serie);
  Fr_Produto_Serie.Tag := 3;
  Fr_Produto_Serie.It_cd_Serie := Qr_Series.FieldByName('SRP_CODIGO').AsInteger;
  Fr_Produto_Serie.It_cd_Item := 0;
  Fr_Produto_Serie.It_cd_Produto := Produto.Registro.Codigo;
  Fr_Produto_Serie.It_Qt_Produto := cds_Estoque.FieldByName('EST_QTDE').AsInteger;
  Fr_Produto_Serie.ShowModal;
  AbreSerie;
end;

procedure TFr_Produtos.Sb_Exc_SerieClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir a série '+Qr_SeriesSRP_NUMERO.AsString +'do cadastro?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
    Qr_Acao.Active := False;
    Qr_Acao.Transaction := DM.IB_Transacao;
    Qr_Acao.SQL.Clear;
    Qr_Acao.SQL.Add('DELETE FROM TB_SERIE_PRODUTO '+
                    'WHERE SRP_CODIGO =:SRP_CODIGO ' );
    Qr_Acao.ParamByName('SRP_CODIGO').AsInteger := Qr_SeriesSRP_CODIGO.AsInteger;
    Qr_Acao.ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    AbreSerie;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Produtos.Qr_SeriesCalcFields(DataSet: TDataSet);
begin
  case Qr_SeriesPED_ORIGEM.AsInteger of
    2:Qr_SeriesSRP_ORIGEM.AsString := 'Pedido de Compra: ' + Qr_SeriesPED_ENTRADA.AsString;
    3:Qr_SeriesSRP_ORIGEM.AsString := 'Pedido de Ajuste: ' + Qr_SeriesPED_ENTRADA.AsString;
  end;

  case Qr_SeriesPED_DESTINO.AsInteger of
    1:Qr_SeriesSRP_DESTINO.AsString := 'Pedido de Venda: ' + Qr_SeriesPED_SAIDA.AsString;
    3:Qr_SeriesSRP_DESTINO.AsString := 'Pedido de Ajuste: ' + Qr_SeriesPED_SAIDA.AsString;
  end;

end;

procedure TFr_Produtos.LiberarNmerodeSrie1Click(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja realmente liberar o número de série ' + Qr_SeriesSRP_NUMERO.AsString +'.'+ EOLN+
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    Begin
    Pc_LiberarNumeroSerie;
    end;
end;

procedure TFr_Produtos.ListaEstadosBeneficios;
Var
  LcB : TControllerProductUfBenef;
  I : Integer;
  LcItem : TProductUfBenef;
  LcNrITem : Integer;
begin
  try
    LcB := TControllerProductUfBenef.create(self);
    LcB.Registro.Produto := Produto.Registro.Codigo;
    LcB.getlist;
    Pc_LimpaStringGrid(Strgrd_Benefi_UF);
    LcNrITem := 0;
    for I := 0 to LcB.Lista.Count - 1 do
    Begin
      LcItem := TProductUfBenef.create;
      LcItem := LcB.Lista[I];
      inc(LcNrITem);
      Strgrd_Benefi_UF.RowCount  := LcNrITem + 1;
      Strgrd_Benefi_UF.Cells[1,LcNrITem]  := LcItem.Estado;
      Strgrd_Benefi_UF.Cells[2,LcNrITem]  := LcItem.Beneficio;
      Strgrd_Benefi_UF.Cells[3,LcNrITem]  := LcItem.CST;
    End;
  finally
    FreeAndNil (LcB);
  end;
end;

procedure TFr_Produtos.ListaSubgrupo;
begin
  DM.Qr_SubGrupo.Active := False;
  DM.Qr_SubGrupo.Active := True;
end;

procedure TFr_Produtos.Dbg_serieTitleClick(Column: TColumn);
begin
   Pc_Pintar_Grid_Ordenar(Dbg_serie, Column);
end;


procedure TFr_Produtos.DBLCB_GrupoExit(Sender: TObject);
begin
  ListaSubGRupo;
end;

procedure TFr_Produtos.EstadoEdicaoBotao;
begin
  Sb_Ins_botao.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_botao.Enabled := ( ( ( It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_botao.RecordCount > 0));
  Sb_Exc_botao.Enabled := ( ( ( It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )AND (Qr_botao.RecordCount > 0));
  Pnl_Botao.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );

end;

procedure TFr_Produtos.EstadoEdicaoComposicao;
begin
  Sb_Ins_Produto.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Produto.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_Prod_Prod.RecordCount > 0));
  Sb_Exc_Produto.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_Prod_Prod.RecordCount > 0));
end;

procedure TFr_Produtos.EstadoEdicaoFornecedor;
begin
  SB_Ins_fornec.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  SB_exc_fornec.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_Prod_Forn.RecordCount > 0);
end;

procedure TFr_Produtos.EstadoEdicaoInstalacao;
begin
  SB_INS_SERV.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  SB_exc_SERV.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (Qr_Servico.RecordCount>0));
end;

procedure TFr_Produtos.EstadoEdicaoInternet;
begin
  Pnl_Internet.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E'));
end;

procedure TFr_Produtos.EstadoEdicaoProducao;
begin
  Sb_ins_producao.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_alt_producao.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (qrproducao.RecordCount > 0));
  Sb_exc_producao.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (qrproducao.RecordCount > 0));

end;

procedure TFr_Produtos.EstadoEdicaoReposicao;
begin
  if not Cds_reposicao.Active then Cds_reposicao.CreateDataSet;
  Sb_ins_reposicao.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_edi_reposicao.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Cds_reposicao.RecordCount > 0));
  Sb_del_reposicao.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Cds_reposicao.RecordCount > 0));
end;

procedure TFr_Produtos.EstadoEdicaoSerie;
begin
  Sb_Ins_Serie.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Serie.Enabled :=( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E')) AND (Qr_Series.RecordCount > 0));
  Sb_Exc_Serie.Enabled :=( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E')) AND (Qr_Series.RecordCount > 0));
  Pnl_Series.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E'));
end;

procedure TFr_Produtos.EstadoEdicaoSimilar;
begin
  Sb_Ins_Product_Similar.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E'));
  Sb_Exc_Product_Similar.Enabled := ( ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E')) AND (Qr_Product_Similar.RecordCount > 0));

   SB_Inserir.Enabled := ( It_Edicao_Ordem = 'B' )   and It_Inserir ;
   SB_Excluir.Enabled := ( It_Edicao_Ordem = 'B' )   and It_Excluir and
      ( Produto.Registro.Codigo > 0);
   SB_Alterar.Enabled := ( It_Edicao_Ordem = 'B' ) and It_Alterar and
      ( Produto.Registro.codigo > 0);
   SB_Gravar.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E'));
   SB_Cancelar.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E'));
   SB_Sair_0.Enabled := ( It_Edicao_Ordem = 'B' ) ;
end;

procedure TFr_Produtos.EstadoEdicaoTabelaPreco;
begin
  Pnl_Tabela_Preco.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
end;

procedure TFr_Produtos.E_custoRealExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  E_custoReal.Text := FormatFloat(Gb_Casa_Dec_Compra, StrToFloatDef(E_custoReal.Text, 0));
  IF (Fc_Tb_Geral('L','PRO_G_CALCULO_AUTO_PRECOVENDA','S') = 'S') then
  Begin
    Lc_Valor := StrToFloatDef(E_custoReal.Text,0);
    if Lc_Valor > 0 then
    Begin
      Pc_Define_FormatoRegional;
      if (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','R') = 'R') then
      Begin
        //if (Tb_Produto.FieldByName('PRO_CODIGO').AsInteger>0) then
          Pc_AtualizaTabelaVendasPelaMargem(Lc_Valor);
      end;
    end;
  end;
end;

procedure TFr_Produtos.E_PrecoCustoExit(Sender: TObject);
Var
  Lc_Valor : real;
begin
  E_PRecoCusto.Text := FormatFloat(Gb_Casa_Dec_Compra, StrToFloatDef(E_PrecoCusto.Text, 0));
  IF (Fc_Tb_Geral('L','PRO_G_CALCULO_AUTO_PRECOVENDA','S') = 'S') then
  Begin
    Lc_Valor := StrToFloatDef(E_PrecoCusto.Text,0);
    if Lc_Valor > 0 then
    Begin
      Pc_Define_FormatoRegional;
      if (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','C') = 'C') then
      Begin
        //if (Tb_Produto.FieldByName('PRO_CODIGO').AsInteger>0) then
          Pc_AtualizaTabelaVendasPelaMargem(Lc_Valor);
      end;
    end;
  end;
end;

procedure TFr_Produtos.dbg_composicaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If ShIft = [] then
    case Key of
    VK_delete  : If Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
    end;
end;

procedure TFr_Produtos.E_CodClasfiscalKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8),',']) then Key:= #0;
end;


function TFr_Produtos.Fc_validaAliquotaComissao(Fc_aq_Com:real):Boolean;
Var
  Lc_Aux_Str : String;
Begin
  Result := True;
  IF Fc_Tb_Geral('L','PRO_VALIDA_AQ_COM','')='S' Then
  begin
    Cds_Tabela_Preco.Active := true;
    Cds_Tabela_Preco.First;
    while not Cds_Tabela_Preco.Eof do
    Begin
      Lc_Aux_Str := FloatToStrF(Cds_Tabela_Preco.FieldByName('PRC_MAR_LRC').AsFloat,ffFixed,10,2);
      if (Lc_Aux_Str = '0,00') then
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Alíquota de comissão não pode ser (0,00) Zero.' + EOLN +
                       'Digite o percentual para comissão desse produto.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        PG_Informacoes.ActivePage := tbs_tbpreco;
        Result := False;
        exit;
      End;
      Cds_Tabela_Preco.Next;
    end;
  end;
end;

procedure TFr_Produtos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ( It_Edicao_Ordem = 'I' ) or ( It_Edicao_Ordem = 'E' ) then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O cadastro está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes de sair da tela.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_Produtos.FormCreate(Sender: TObject);
begin
  Produto := TControllerProduto.create(Self);
  TrayLoja := TControllerLojaTray.create(Self);
  PG_Informacoes.ActivePage := tbs_estoque;
  Pc_Log_Sistema( Gb_CodMha,
                  GB_Cd_Usuario,
                  (Now),
                  'Cadastro de Produtos',
                  GB_Cd_Usuario,
                  'Acesso ao cadastro', concat('Inicio ás',DateTimeToStr(Now)));

end;

procedure TFr_Produtos.Sb_revestimentoClick(Sender: TObject);
Var
  Lc_Form : TSeaCoating;
begin
  Lc_Form := TSeaCoating.Create(nil);
  try
    Lc_Form.ShowModal;
  finally
    DM.Qr_Revestimento.Active := False;
    DM.Qr_Revestimento.Active := True;
    DBLCB_Revestimento.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Produtos.Sb_CategoryClick(Sender: TObject);
Var
  Lc_Form : TSeaCategory;
  Lc_I : Integer;
begin
  Lc_Form := TSeaCategory.Create(nil);
  Try
    Lc_Form.ShowModal;
    Produto.Registro.Categoria := Lc_Form.cds_searchcodigo.AsInteger;
    with DM.qr_category do
    Begin
      Trw_Cadastro.Items.Count;
      Active := False;
      Active := True;
      try
        For lc_I:= Trw_Cadastro.Items.Count-1 downto 0 do
          Trw_Cadastro.Items.Item[Lc_I].Delete;
        Pc_PreencherTreeView(DM.qr_category,Trw_Cadastro,nil);
        Fc_PosicionaNoCategoria(1,Trw_Cadastro,Produto.Registro.Categoria, TRUE);
      except
        Abort;
      end;
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

function TFr_Produtos.Fc_NivelHierarquico( const fc_s : String ) : integer;
Var
  Lc_Teste : integer;
begin
  Lc_Teste :=Length( StringReplace( fc_s, '.', '', [rfReplaceAll]));
  // Descobre o nivel hierarquico através do número de pontos do igo
  Result := Length( fc_s )- Lc_Teste ;
end;


procedure TFr_Produtos.Pc_PreencherTreeView(Pc_Query : TDataset; Pc_tv : TTreeView; Pc_Pai : TTreeNode );
var
  Lc_NivelAtual, Lc_NovoNivel, Lc_I : Byte;
  Lc_Descricao : ShortString;
  Lc_NovoNo : TTreeNode;
begin

  Lc_NivelAtual := Fc_NivelHierarquico( Pc_Query.Fields[3].AsString );

  repeat
  Lc_Descricao :=  Pc_Query.Fields[2].AsString;
  Lc_NovoNivel := Fc_NivelHierarquico( Pc_Query.Fields[3].AsString );
  if Lc_NovoNivel = Lc_NivelAtual then
    begin
    Lc_NovoNo := Pc_tv.Items.AddChild( Pc_Pai, lc_Descricao );
    Lc_NovoNo.ImageIndex := Pc_Query.Fields[0].AsInteger;
    Lc_NovoNo.SelectedIndex := Lc_NivelAtual * 2;
    end
  else
    begin
    if ( Lc_NovoNivel < Lc_NivelAtual ) then
      begin
      for Lc_I := 1 to Lc_NivelAtual - Lc_NovoNivel do
      Pc_Pai := Pc_Pai.Parent
      end
    else
      begin
      Pc_Pai := Lc_NovoNo;
      end;
    Pc_PreencherTreeView( Pc_Query, Pc_tv, Pc_Pai );
    end;
  Pc_Query.Next;
  Application.ProcessMessages;
  until Pc_Query.EOF;
//  It_Qtde_Items := Trw_Cadastro.Items.Count
end;

Function TFr_Produtos.Fc_PosicionaNoCategoria (Fc_Tipo: Byte;Fc_Tree : TTreeView; Fc_Value:Integer; Fc_Visible: Boolean): TTreeNode;
var
  Node: TTreeNode;
begin
  Result := nil;
  if Fc_Tree.Items.Count = 0 then Exit;
  Node := Fc_Tree.Items[0];
  while Node <> nil do
    begin

   //if  Pos(UpperCase(Fc_Value), UpperCase(Node.Text)) > 0  then
   if  (Fc_Value = Node.ImageIndex)  then
      begin
      Result := Node;
      if Visible then
        BEgin
        Result.MakeVisible;
        Result.Selected := True;
        end;
      if Fc_Tipo > 0 then  Break; //Para parar no primeiro que acha;
      end;
    Node := Node.GetNext;
    end;
end;

function TFr_Produtos.Fc_Pre_ValidaGravacao: boolean;
Var
  Lc_Aux : String;
  Lc_ValidaEANGTIN : TACBrValidador;
begin
  Result:=true;
  if not PRodutoVeiculo then
  Begin
    //DEMONSTRAR DE FORMA POSITIVA QUE NÃO QUER VALIDAR O CODIGO
    if ( Fc_Tb_Geral('L','PRO_G_NAO_VALIDA_EAN','N') = 'N') then
    Begin
      if (Length(Trim( E_Barras.Text) ) > 0) then
      BEgin
        Try
          Lc_ValidaEANGTIN := TACBrValidador.Create(nil);
          Lc_ValidaEANGTIN.TipoDocto := docGTIN;
          Lc_ValidaEANGTIN.Documento := TRIM(E_Barras.Text);
          if not Lc_ValidaEANGTIN.Validar then
          Begin
            MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                           'O código EAN/GTIN está incorreto.' + EOLN +
                           'Verifique e tente novamente.' + EOLN,
                           ['OK'], [bEscape], mpErro);
            Result := False;
            exit;
          end;
        Finally
          FreeAndNil(Lc_ValidaEANGTIN);
        End;
      end;
    End;
  End;

  if TRIM(E_DescricaoProduto.Text) = '' then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Descrição não informado.'+EOLN+
                   'Preencha a descrição deste Produto.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    E_DescricaoProduto.SetFocus;
    exit;
  end;

  if TRIM(DBLCB_Embalagem.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Embalagem não informado.'+EOLN+
                   'Preencha a embalagem deste Produto.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result:=false;
    PG_Informacoes.ActivePage := tbs_estoque;
    DBLCB_Embalagem.SetFocus;
    exit;
  end;

  if trim(Fm_UnidadeComercial.Dblcb_Medida.Text) =  '' THEN
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                    'Campo Unidade não informado.'+EOLN+
                    'Preencha a Unidade deste Produto.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    PG_Informacoes.ActivePage := tbs_estoque;
    Fm_UnidadeComercial.Dblcb_Medida.SetFocus;
    Exit;
  end;

  if trim(DBLCB_Grupo.Text) =  '' then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo Grupo não informado.'+EOLN+
                   'Preencha o Grupo deste Produto.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    DBLCB_Grupo.SetFocus;
    exit;
  end;

  if trim(DBLCB_SubGrupo.Text) =  '' THEN
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo SubGrupo não informado.'+EOLN+
                   'Preencha o SubGrupo deste Produto.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    DBLCB_SubGrupo.SetFocus;
    exit;
  end;

  if trim(DBLCB_Marca.Text) =  '' THEN
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo Marca não informado.'+EOLN+
                   'Preencha a Marca deste Produto.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    DBLCB_Marca.SetFocus;
    exit;
  end;

  if existeCodigoCodFabrica THEN // dentro da funcao ele verifica a configuracao se controla a duplicacao
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Código Fábrica já existe.'+EOLN+
                   'Digite outro ou desative o Controle em Configurações(Aba Produto).'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    E_Fabricante.SetFocus;
    exit;
  end;

  if Fc_VerificaPermissao('Fr_Nota_Fiscal_3_X','Nota Fiscal Eletrônica 3.x','VISUALIZAR',GB_Cd_Usuario,'S') or
      Fc_VerificaFormularioDisponivel('Fr_GeraNFe') then
  begin
    if trim(E_CodClasfiscal.Text) =  '' THEN
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Campo Class. Fiscal(NCM) o não informado.'+EOLN+
                     'Preencha o NCM deste Produto.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      E_CodClasfiscal.SetFocus;
      exit;
    end;
    Lc_Aux := trim(E_CodClasfiscal.Text);
    Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-']);
    if trim(Lc_Aux) =  '' THEN
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'O Número de Class. Fiscal(NCM) deve ter 8 dígitos.'+EOLN+
                     'Preencha corretamente para cotinuar.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      E_CodClasfiscal.SetFocus;
      exit;
    end;
    Lc_Aux := trim(E_CEST.Text);
    Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-']);
    if Length(trim(Lc_Aux)) > 0 THEN
    Begin
      RG_SUBTRIB.ItemIndex := 0;
    end;
    if (RG_SUBTRIB.ItemIndex = 0) and ( (trim(Lc_Aux) =  '') or (Length(trim(Lc_Aux))<7) ) THEN
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'O Código Especificador da S.T. deve ter 7 dígitos.'+EOLN+
                     'Preencha corretamente para cotinuar.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      E_cest.SetFocus;
      exit;
    End;
  end;

end;

procedure TFr_Produtos.tbs_InternetShow(Sender: TObject);
Var
  Lc_I: Integer;
begin
  with DM.qr_category do
  Begin
    Active := True;
    Trw_Cadastro.Items.Count;
    Active := False;
    Active := True;
    try
      For lc_I:= Trw_Cadastro.Items.Count-1 downto 0 do
        Trw_Cadastro.Items.Item[Lc_I].Delete;
      Pc_PreencherTreeView(DM.qr_category,Trw_Cadastro,nil);
      Fc_PosicionaNoCategoria(1,Trw_Cadastro,Produto.Registro.Categoria, TRUE);
    except
      Abort;
    end;
  end;
  EstadoEdicaoInternet;
end;

procedure TFr_Produtos.Trw_CadastroClick(Sender: TObject);
begin
  IF Trw_Cadastro.Selected <> NIL then
  Begin
    Produto.Registro.Categoria := Trw_Cadastro.Selected.ImageIndex;
  end;
end;

function TFr_Produtos.ValidaAlteracaoDescricao: Boolean;
begin
  Result := True;
  if (Produto.Registro.Descricao <> E_DescricaoProduto.Text) and (Produto.Registro.Descricao <> '' ) then
  Begin
    if produto.temmovimento then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                          'Atenção existe movimentação deste Produto.' + EOLN +
                          'A alteração da descrição pode descaracterizar o produto.'+ EOLN +
                          'E compromentendo o histórico de Compra e Venda no Estoque.'+ EOLN +
                          'Confirmar a Atualização?',
                          [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
      Begin
        Result := False;
        Exit;
      End;
    End;
  End;
end;

function TFr_Produtos.ValidaDelete: Boolean;
begin
  REsult := TRue;
  {27/09/2021 - Foi comentado pois decidi não escluir os produtos....pensando na sincronia com a internet
  Quando excluir será inativado o produto
  if produto.temmovimento then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Existe movimentação deste produto.' + EOLN +
                   'Não é possível excluir, uma opção é desativá-lo.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  End;
  }
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Excluir ' + Produto.Registro.Descricao + ' de seus arquivos.' + EOLN + EOLN +
                      'Confirmar a exclusão ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;
end;

procedure TFr_Produtos.VariaodeProdutos1Click(Sender: TObject);
Var
  Lc_Form : TCadProductVariant;
begin
  if Fc_VerificaProdutoGravado then
  Begin
    try
      Lc_Form := TCadProductVariant.Create(nil);
      Lc_Form.CodigoRegistro := Produto.Registro.Codigo;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  End;
end;

procedure TFr_Produtos.Sb_ins_producaoClick(Sender: TObject);
begin
  IF Fc_VerificaGravacaoComplementar then
  Begin
    if not Assigned(Fr_Base_Produtos) then
       Application.CreateForm(TFr_Base_Produtos,Fr_Base_Produtos);
    Fr_Base_Produtos.It_Cd_Produto := Produto.Registro.Codigo;
    Fr_Base_Produtos.It_Tp_Produto := 'M';
    Fr_Base_Produtos.It_Tp_servico := '';
    Fr_Base_Produtos.It_Cd_Vinculo := 0;
    Fr_Base_Produtos.It_Cd_Ficha := qrproducao.FieldByName('FTC_CODIGO').AsInteger;
    Fr_Base_Produtos.It_Tipo := 'F';
    Fr_Base_Produtos.It_StateChange := 2;
    Fr_Base_Produtos.ShowModal;
    abreProducao;
    Pc_AtualizaProducao;
    EstadoEdicao;
  End;
end;

procedure TFr_Produtos.Sb_alt_producaoClick(Sender: TObject);
begin
  IF qrproducao.RecordCount = 0 THEN
    Exit;

  if not Assigned(Fr_Base_Produtos) then Application.CreateForm(TFr_Base_Produtos,Fr_Base_Produtos);
  Fr_Base_Produtos.It_StateChange := 3;
  Fr_Base_Produtos.It_Tp_Produto := 'M';
  Fr_Base_Produtos.It_Tp_servico := '';
  Fr_Base_Produtos.It_Cd_Ficha := qrproducao.FieldByName('FTC_CODIGO').AsInteger;
  Fr_Base_Produtos.It_Cd_Produto := Produto.Registro.Codigo;
  Fr_Base_Produtos.It_Cd_Vinculo := qrproducao.FieldByName('FTC_CODVCL').AsInteger;
  Fr_Base_Produtos.E_CodPro.Text := qrproducao.FieldByName('FTC_CODVCL').AsString;
  Fr_Base_Produtos.E_Produto.Text := qrproducao.FieldByName('PRO_DESCRICAO').AsString;
  Fr_Base_Produtos.It_Tipo := 'F';
  Fr_Base_Produtos.E_Cons_Unitario.Text := FloatToStrF(qrproducao.FieldByName('FTC_CS_UNIT').AsFloat,ffNumber,10,2);
  Fr_Base_Produtos.ShowModal;
  abreProducao;
  Pc_AtualizaProducao;
  EstadoEdicao;
end;

procedure TFr_Produtos.Sb_exc_producaoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+qrproducao.FieldByName('PRO_DESCRICAO').AsString +' desta Cotação.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
    Pc_Fr_FichaTecnica('A',qrproducao.FieldByName('FTC_CODIGO').AsInteger,'',0,0,0,'','', 0,0,0,0);
    abreProducao;
    Pc_AtualizaProducao;
    EstadoEdicao;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Produtos.tbs_ProducaoShow(Sender: TObject);
begin
  abreProducao;
  EstadoEdicaoProducao;
end;

procedure TFr_Produtos.tbs_product_similarShow(Sender: TObject);
begin
  AbrePRodutoSimilar;
  EstadoEdicaoSimilar;
end;

procedure TFr_Produtos.tbs_reposicaoShow(Sender: TObject);
begin
  AbreReposicao;
  EstadoEdicaoReposicao;
end;

Function TFr_Produtos.Fc_VerificaProdutoGravado:Boolean;
Begin
  Result := True;
  if ( It_Edicao_Ordem <> 'B') then
  Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                    'Por favor grave o cadastro '+EOLN+
                    'do produto antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if ( Produto.Registro.Codigo = 0 )  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Produto não encontrado.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

procedure TFr_Produtos.ImagensdeProdutos1Click(Sender: TObject);
Var
  Lc_Form : TFr_Img_Site_Produto;
begin
  if Fc_VerificaProdutoGravado then
  Begin
    self.Enabled := False;
    Lc_Form := TFr_Img_Site_Produto.Create(Fr_Produtos);
    Lc_Form.It_Cd_Table := Produto.Registro.codigo;
    Lc_Form.Pc_PermissaoBotao(it_Inserir,It_alterar, true);
    try
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
      self.Enabled := True;
    end;
  end;
end;

procedure TFr_Produtos.ChangePriceByMargem(Sender: TField);
Var
  Lc_Vl_Margem : real;
begin
  Try
    Cds_Tabela_PrecoPRC_VL_VDA.OnChange := nil;
    Produto.Registro.ValorCustoMedio := StrToFloatDef(E_custoReal.Text,0);
    Produto.Registro.ValorCusto := StrToFloatDef(E_PrecoCusto.Text,0);
    IF (Fc_Tb_Geral('L','PRO_G_CALCULO_AUTO_PRECOVENDA','S') = 'S') then
    Begin
      Lc_Vl_Margem := sender.DataSet.FieldByName('PRC_MAR_LRC').AsFloat;
      if Lc_Vl_Margem > 0 then
      Begin
        Pc_Define_FormatoRegional;
        if (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','R') = 'R') then
        Begin
          Cds_Tabela_PrecoPRC_VL_VDA.AsCurrency :=  Fc_CalcularPrecoPelaMargemLucro(
                                                                          Produto.Registro.ValorCustoMedio,
                                                                          Lc_Vl_Margem,
                                                                          Cds_Tabela_PrecoTPR_CASA_DECIMAL.AsInteger);
        end
        else
        Begin
          Cds_Tabela_PrecoPRC_VL_VDA.AsCurrency := Fc_CalcularPrecoPelaMargemLucro(
                                                                          Produto.Registro.ValorCusto,
                                                                          Lc_Vl_Margem,
                                                                          Cds_Tabela_PrecoTPR_CASA_DECIMAL.AsInteger);
        end;
      end;
    end;
  Finally
    Cds_Tabela_PrecoPRC_VL_VDA.OnChange := ChangePriceByValor;
  End;
end;

procedure TFr_Produtos.ChangePriceByValor(Sender: TField);
Var
  Lc_Valor : real;
begin
  Try
    Cds_Tabela_PrecoPRC_MAR_LRC.OnChange := nil;
    Produto.Registro.ValorCusto       := StrToFloatDef(E_PrecoCusto.Text,0);
    Produto.Registro.ValorCustoMedio  := StrToFloatDef(E_custoReal.Text,0);
    IF (Fc_Tb_Geral('L','PRO_G_CALCULO_AUTO_PRECOVENDA','S') = 'S') then
    Begin
      Lc_Valor := sender.DataSet.FieldByName('PRC_VL_VDA').AsCurrency;
      if Lc_Valor > 0 then
      Begin
        Pc_Define_FormatoRegional;
        if (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','R') = 'R') then
        Begin
          sender.DataSet.FieldByName('PRC_MAR_LRC').AsFloat := Fc_CalcularMargemPeloPreco(
                                                                    Produto.Registro.ValorCustoMedio,
                                                                    Lc_Valor,
                                                                    2);
        end
        else
        BEgin
          sender.DataSet.FieldByName('PRC_MAR_LRC').AsFloat := Fc_CalcularMargemPeloPreco(
                                                                      Produto.Registro.ValorCusto,
                                                                      Lc_Valor,
                                                                      2);
        end;
      end;
    end;
  Finally
    Cds_Tabela_PrecoPRC_MAR_LRC.OnChange := ChangePriceByMargem;
  End;
end;



procedure TFr_Produtos.ChBx_InternetClick(Sender: TObject);
begin
  if ( TCheckBox(Sender).Checked)  then
    Chbx_Send_Internet.Checked := True;
end;

procedure TFr_Produtos.tbs_fornecedorShow(Sender: TObject);
begin
  AbreFornecedores;
  EstadoEdicaoFornecedor;
end;

procedure TFr_Produtos.tbs_composicaoShow(Sender: TObject);
begin
  AbreComposicao;
  EstadoEdicaoComposicao;
end;

procedure TFr_Produtos.tbs_impostosShow(Sender: TObject);
begin
  AbreImposto;

end;

procedure TFr_Produtos.tbs_instalacaoShow(Sender: TObject);
begin
  AbreServico;
  EstadoEdicaoInstalacao;
end;

procedure TFr_Produtos.Sb_CestClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_CEST;
begin
  Try
    Lc_Form := TFr_Pesq_CEST.Create(Self);
    Lc_Form.It_Visualizar := False;
    Lc_Form.ShowModal;
    if Lc_Form.It_Visualizar then
      E_CEST.Text := Lc_Form.Qr_Pesquisa.FieldByName('CEST').AsString;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;


{ TCustomGridHelper }

procedure TCustomGridHelper.DelRow(ARow: Integer);
begin
  Self.DeleteRow(ARow);
end;

end.

