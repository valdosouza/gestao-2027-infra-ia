unit UN_Pedido_Vda;

interface
uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ControllerBase, System.Math, ControllerPedido, ControllerCtrlLote, ControllerMovimentoLote, Un_Fm_ListaUsuarios, Actions, Vcl.ActnList, Vcl.Menus, Un_Fm_ListaTabelaPreco, Un_Fm_ListaMultiEmpresa, Un_Fm_ListaColaboradores, Un_Fm_FormaPagto, Vcl.ComCtrls, QEdit_Setes, Vcl.DBCtrls, Datasnap.DBClient, System.StrUtils, base_frame_list,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFr_Pedido_Vda = class(TForm)
    Pg_Pedido_Vda: TPageControl;
    tbs_pedido: TTabSheet;
    tbs_Pesquisa: TTabSheet;
    Ds_ItensVda: TDataSource;
    Pnl_Fundo: TPanel;
    Label2: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    SB_Cliente: TSpeedButton;
    DBLCB_Empresa: TDBLookupComboBox;
    Pnl_totalizador: TPanel;
    Label22: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    Label23: TLabel;
    E_VL_Frete: TEdit_Setes;
    E_Cd_Empresa: TEdit_Setes;
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    E_Nr_Parcelas: TEdit_Setes;
    E_Prazo: TMaskEdit;
    Qr_endereco: TSTQuery;
    Ds_endereco: TDataSource;
    Qr_ItensVda: TSTQuery;
    Qr_ItensSrv: TSTQuery;
    Ds_ItensSrv: TDataSource;
    Lb_Servico: TLabel;
    E_VL_Produto: TPanel;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    Label24: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Lb_Vl_Devedor: TLabel;
    Lb_Vl_predatado: TLabel;
    Lb_Vl_Devolvido: TLabel;
    E_Data: TDateTimePicker;
    Qr_Ordem: TSTQuery;
    Timer_deve: TTimer;
    Qr_Tecnicos: TSTQuery;
    Sb_Parcelamento: TSpeedButton;
    Lb_Vl_Credito: TLabel;
    Ds_ItensDev: TDataSource;
    Qr_ItensDev: TSTQuery;
    E_Vl_Servico: TPanel;
    DBLCB_Prazo: TDBLookupComboBox;
    qr_prazo_controlado: TSTQuery;
    dts_PrazoControlado: TDataSource;
    Label26: TLabel;
    E_Aq_Desconto: TEdit_Setes;
    E_VL_Desconto: TEdit_Setes;
    Label5: TLabel;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    lbl: TLabel;
    E_Vl_Despesa: TEdit_Setes;
    E_Nr_Pedido: TEdit_Setes;
    Pop_Produto: TPopupMenu;
    RegistraNmerodeSerie: TMenuItem;
    RegistraNmerodeLote: TMenuItem;
    Mnu_Controle: TMainMenu;
    Pnl_Botao: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    SB_Faturar: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    E_VL_Pedido: TPanel;
    ChBx_UsarCredito: TCheckBox;
    Pg_Observacao: TPageControl;
    tbs_obs: TTabSheet;
    Pnl_Observacao: TPanel;
    E_Observ: TMemo;
    tbs_dado_entrega: TTabSheet;
    Pnl_entrega: TPanel;
    Label20: TLabel;
    Label27: TLabel;
    Label7: TLabel;
    DBLCB_end_Entrega: TDBLookupComboBox;
    Cb_Retirada: TComboBox;
    TabSheet6: TTabSheet;
    Pnl_Informacoes: TPanel;
    CadastrodoProduto: TMenuItem;
    Pnl_Busca: TGroupBox;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBG_Pesquisa: TDBGrid;
    GroupBox1: TGroupBox;
    Label36: TLabel;
    Lb_Placa: TLabel;
    E_BuscaCliente: TEdit;
    E_BuscaPedido: TEdit_Setes;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Busca_Nome: TCheckBox;
    ChBx_Busca_Fantasia: TCheckBox;
    ChBx_Periodo: TCheckBox;
    E_BuscaNumero: TEdit;
    Mnu_Tarefas: TMenuItem;
    MnuLucratividade: TMenuItem;
    MnuSeparao: TMenuItem;
    Dblcb_Negocio: TDBLookupComboBox;
    Sb_Negocio: TSpeedButton;
    Label13: TLabel;
    Pop_Servico: TPopupMenu;
    MenuItem3: TMenuItem;
    InformarNmerodeCompra: TMenuItem;
    Label14: TLabel;
    Cb_Garantia: TComboBox;
    PG_Itens: TPageControl;
    Tbs_Produto: TTabSheet;
    Pnl_Produto: TPanel;
    DBG_Produtos: TDBGrid;
    Sb_Ins_Produto: TBitBtn;
    Sb_Alt_Produto: TBitBtn;
    Sb_Exc_Produto: TBitBtn;
    Sb_Vend_Comissao: TBitBtn;
    Tbs_Servico: TTabSheet;
    Pnl_Servico: TPanel;
    Sb_Ins_Servico: TSpeedButton;
    Sb_Alt_Servico: TSpeedButton;
    Sb_Exc_Servico: TSpeedButton;
    Sb_Servico: TSpeedButton;
    Sb_Tecnico: TSpeedButton;
    DBG_Servicos: TDBGrid;
    Tbs_Devolucao: TTabSheet;
    DBG_Devolucao: TDBGrid;
    Sb_Ins_Devolucao: TBitBtn;
    Sb_Alt_Devolucao: TBitBtn;
    Sb_Exc_Devolucao: TBitBtn;
    Sb_Fich_Fin: TSpeedButton;
    DadosdoNCM1: TMenuItem;
    Lb_TotalVenda: TLabel;
    E_TotalVenda: TLabel;
    Tbs_Troca: TTabSheet;
    DBG_Troca: TDBGrid;
    Sb_Ins_Troca: TBitBtn;
    Sb_Alt_Troca: TBitBtn;
    Sb_Exc_Troca: TBitBtn;
    Qr_ItensTro: TSTQuery;
    Ds_ItensTro: TDataSource;
    E_Vl_Troca: TPanel;
    E_Vl_Devolucao: TPanel;
    Lb_Vl_Devolucao: TLabel;
    Lb_troca: TLabel;
    Pop_ConfigLocal: TMenuItem;
    Pop_ConfigGlobal: TMenuItem;
    tbs_Config_Global: TTabSheet;
    tbs_Config_Local: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    GrBx_Ped_Imp: TRadioGroup;
    GroupBox10: TGroupBox;
    E_ItensPP: TEdit_Setes;
    GroupBox6: TGroupBox;
    E_PortaImpressao_vda: TEdit;
    E_SaltoImpressao_vda: TEdit_Setes;
    Cbx_TipoComp: TComboBox;
    cbx_estliloLase: TComboBox;
    chbx_Ctrl_Tabela_Prazo: TCheckBox;
    chk_contr_cliente: TCheckBox;
    Chbx_controle_venda: TCheckBox;
    ChBx_Libera_Comissao: TCheckBox;
    ChBx_Libera_Valor: TCheckBox;
    chk_contr_vendedor: TCheckBox;
    Chbx_Qtde_Venda_Promocao: TCheckBox;
    chbx_M2: TCheckBox;
    chbx_mostra_vendedor: TCheckBox;
    ChBx_LancaLoteAuto: TCheckBox;
    ChBx_Ctrl_Estoque_Pedido: TCheckBox;
    RG_TIPOPARCELAMENTO: TRadioGroup;
    GroupBox5: TGroupBox;
    Label25: TLabel;
    E_Aliq_Desconto: TEdit_Setes;
    grp_desc_vista: TGroupBox;
    Label28: TLabel;
    ed_desc_avista: TEdit_Setes;
    Btn_Ok_Global: TButton;
    Btn_Cn_Global: TButton;
    Btn_Ap_Global: TButton;
    Btn_Ok_Local: TButton;
    Btn_Cn_Local: TButton;
    Btn_Ap_Local: TButton;
    chbx_copiapedidovenda: TCheckBox;
    Chbx_Emite_Boleto: TCheckBox;
    ChBx_BaixaAutomaticaPedido: TCheckBox;
    ChBx_ComissaoProduto: TCheckBox;
    SpeedButton1: TSpeedButton;
    tbs_oper_Grupo: TTabSheet;
    Panel3: TPanel;
    StrGrd_Pedido: TStringGrid;
    Lb_DetalhePedido: TLabel;
    GroupBox2: TGroupBox;
    E_DataAlteraGRupo: TDateTimePicker;
    Sb_VoltaGrupo: TSpeedButton;
    Sb_Grp_Atualizar: TSpeedButton;
    MnuOperaesemGrupo: TMenuItem;
    SB_Add_Tudo: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    SpeedButton2: TSpeedButton;
    MnuEnviaPedido: TMenuItem;
    Cb_IndPresComprador: TComboBox;
    Label29: TLabel;
    chbx_aprovados: TCheckBox;
    Sb_Pesq_Cliente: TSpeedButton;
    ActionList1: TActionList;
    Action1: TAction;
    GroupBox4: TGroupBox;
    Label30: TLabel;
    e_Valida_Lucratividade: TEdit_Setes;
    Lucratividade1: TMenuItem;
    ChBx_BuscaPedidoAndroid: TCheckBox;
    Fm_FormaPagto: TFm_FormaPagto;
    E_Data_Entrega: TDateTimePicker;
    ChBx_Pecas: TCheckBox;
    ChBx_Status: TCheckBox;
    E_Qt_Produto: TPanel;
    E_VL_IPI: TPanel;
    E_VL_St: TEdit_Setes;
    Label3: TLabel;
    MnuCustodoPedido: TMenuItem;
    Fm_LME: TFm_ListaMultiEmpresa;
    ConsollidarCustoLucratividade1: TMenuItem;
    pop_troca: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem5: TMenuItem;
    ChBx_Ctrl_Preco_Tipo_Cliente: TCheckBox;
    AplicarLote1: TMenuItem;
    L_CodigoCliente: TLabel;
    E_Cd_Busca_Empresa: TEdit;
    AlteraTabeladePreo1: TMenuItem;
    Pnl_TabelaPreco: TPanel;
    Sb_Confirma_TabelaPreco: TButton;
    Sb_Cancela_TabelaPreco: TButton;
    Fm_ListaTabelaPreco: TFm_ListaTabelaPreco;
    InclusodeItemFormarpido1: TMenuItem;
    ActInclusaoRapidoProduto: TAction;
    Sb_InclusaoRapido: TBitBtn;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    Fm_VendedorPedido: TFm_ListaColaboradores;
    ChBx_preco_acima: TCheckBox;
    Qr_ItensVdaITF_CODIGO: TIntegerField;
    Qr_ItensVdaITF_SEQUENCIA: TIntegerField;
    Qr_ItensVdaITF_CODPED: TIntegerField;
    Qr_ItensVdaITF_CODNFL: TIntegerField;
    Qr_ItensVdaITF_CODPRO: TIntegerField;
    Qr_ItensVdaPRO_CODIGOFAB: TStringField;
    Qr_ItensVdaPRO_CODIGONCM: TStringField;
    Qr_ItensVdaPRO_DESCRICAO: TStringField;
    Qr_ItensVdaPRO_SERIE: TStringField;
    Qr_ItensVdaPRO_TIPO: TStringField;
    Qr_ItensVdaTPR_MODALIDADE: TStringField;
    Qr_ItensVdaEMB_ABREVIATURA: TStringField;
    Qr_ItensVdaTPR_NOME: TStringField;
    Qr_ItensVdaPRO_ORIGEM: TStringField;
    Qr_ItensVdaITF_QTDE: TBCDField;
    Qr_ItensVdaITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensVdaITF_VL_UNIT: TFMTBCDField;
    Qr_ItensVdaITF_AQ_COM: TBCDField;
    Qr_ItensVdaMED_ABREVIATURA: TStringField;
    Qr_ItensVdaITF_AQ_DESC: TBCDField;
    Qr_ItensVdaITF_VL_DESC: TBCDField;
    Qr_ItensVdaITF_AQ_IPI: TBCDField;
    Qr_ItensVdaITF_CODEST: TIntegerField;
    Qr_ItensVdaITF_CODTPR: TIntegerField;
    Qr_ItensVdaITF_ALTURA: TBCDField;
    Qr_ItensVdaITF_LARGURA: TBCDField;
    Qr_ItensVdaITF_NR_PECAS: TBCDField;
    Qr_ItensVdaITF_ESTOQUE: TStringField;
    Qr_ItensVdaITF_AQ_ICMS: TBCDField;
    Qr_ItensVdaPRO_VL_CUSTOMED: TFMTBCDField;
    Qr_ItensVdaITF_VL_IPI: TFloatField;
    Qr_ItensVdaITF_VL_SUBTOTAL: TFloatField;
    Qr_ItensVdaITF_VL_TOTAL: TFloatField;
    pnl_cfg_g_top: TPanel;
    chbx_nao_mostra_valor_usuario: TCheckBox;
    chbx_somente_vendedor_visualiza: TCheckBox;
    MnuAcompanhamento: TMenuItem;
    AuditoriadeEstoque: TMenuItem;
    Panel4: TPanel;
    ClientDataSet1: TClientDataSet;
    Qr_ItensVdaCFOP: TStringField;
    Qr_ItensVdaSET_FINANCIAL: TStringField;
    Qr_ItensVdaTEMFINANCEIRO: TStringField;
    Qr_ItensVdaPRO_LOCAL: TStringField;
    Corrigirsequnciadositens1: TMenuItem;
    Qr_ItensSrvITF_CODIGO: TIntegerField;
    Qr_ItensSrvITF_CODPED: TIntegerField;
    Qr_ItensSrvITF_CODNFL: TIntegerField;
    Qr_ItensSrvITF_CODPRO: TIntegerField;
    Qr_ItensSrvPRO_DESCRICAO: TStringField;
    Qr_ItensSrvEMB_ABREVIATURA: TStringField;
    Qr_ItensSrvITF_QTDE: TBCDField;
    Qr_ItensSrvITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensSrvITF_VL_UNIT: TFMTBCDField;
    Qr_ItensSrvITF_AQ_COM: TBCDField;
    Qr_ItensSrvMED_ABREVIATURA: TStringField;
    Qr_ItensSrvITF_AQ_DESC: TBCDField;
    Qr_ItensSrvITF_VL_DESC: TBCDField;
    Qr_ItensSrvITF_VL_SUBTOTAL: TFMTBCDField;
    Qr_ItensSrvITF_VL_TOTAL: TFMTBCDField;
    Qr_ItensSrvITF_CODTPR: TIntegerField;
    Qr_ItensDevITF_CODIGO: TIntegerField;
    Qr_ItensDevITF_CODPED: TIntegerField;
    Qr_ItensDevITF_CODNFL: TIntegerField;
    Qr_ItensDevITF_CODPRO: TIntegerField;
    Qr_ItensDevPRO_CODIGOFAB: TStringField;
    Qr_ItensDevPRO_DESCRICAO: TStringField;
    Qr_ItensDevITF_QTDE: TBCDField;
    Qr_ItensDevITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensDevITF_VL_UNIT: TFMTBCDField;
    Qr_ItensDevITF_ESTOQUE: TStringField;
    Qr_ItensDevITF_CODEST: TIntegerField;
    Qr_ItensDevITF_CODTPR: TIntegerField;
    Qr_ItensDevITF_AQ_COM: TBCDField;
    Qr_ItensDevMED_ABREVIATURA: TStringField;
    Qr_ItensDevITF_AQ_DESC: TBCDField;
    Qr_ItensDevITF_VL_DESC: TBCDField;
    Qr_ItensDevPRO_VL_CUSTOMED: TFMTBCDField;
    Qr_ItensDevITF_VL_IPI: TFloatField;
    Qr_ItensDevITF_VL_SUBTOTAL: TFMTBCDField;
    Qr_ItensTroITF_CODIGO: TIntegerField;
    Qr_ItensTroITF_CODPED: TIntegerField;
    Qr_ItensTroITF_CODNFL: TIntegerField;
    Qr_ItensTroITF_CODPRO: TIntegerField;
    Qr_ItensTroPRO_CODIGOFAB: TStringField;
    Qr_ItensTroPRO_DESCRICAO: TStringField;
    Qr_ItensTroITF_QTDE: TBCDField;
    Qr_ItensTroITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensTroITF_VL_UNIT: TFMTBCDField;
    Qr_ItensTroITF_ESTOQUE: TStringField;
    Qr_ItensTroITF_CODEST: TIntegerField;
    Qr_ItensTroITF_CODTPR: TIntegerField;
    Qr_ItensTroITF_AQ_COM: TBCDField;
    Qr_ItensTroMED_ABREVIATURA: TStringField;
    Qr_ItensTroITF_AQ_DESC: TBCDField;
    Qr_ItensTroITF_VL_DESC: TBCDField;
    Qr_ItensTroPRO_VL_CUSTOMED: TFMTBCDField;
    Qr_ItensTroITF_VL_IPI: TFloatField;
    Qr_ItensTroITF_VL_SUBTOTAL: TFMTBCDField;
    InformarContrato1: TMenuItem;
    InformaoCombustivel1: TMenuItem;
    Sb_Enviar: TSpeedButton;
    Chbx_Vendedor_Cliente: TCheckBox;
    MnuLiberarItensparaDespacho: TMenuItem;
    MnuCancelarDespacho: TMenuItem;
    procedure DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
      ShIft: TShIftState);
    procedure E_DataEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_ServicoClick(Sender: TObject);
    procedure SB_ClienteClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      ShIft: TShIftState);
    procedure tbs_PesquisaShow(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure Sb_Ins_ProdutoClick(Sender: TObject);
    procedure Sb_Alt_ProdutoClick(Sender: TObject);
    procedure Sb_Exc_ProdutoClick(Sender: TObject);
    procedure SB_FaturarClick(Sender: TObject);
    procedure DBLCB_EmpresaExit(Sender: TObject);
    procedure Sb_Ins_ServicoClick(Sender: TObject);
    procedure Sb_Alt_ServicoClick(Sender: TObject);
    procedure Sb_Exc_ServicoClick(Sender: TObject);
    procedure DBG_ServicosKeyDown(Sender: TObject; var Key: Word;
      ShIft: TShIftState);
    procedure tbs_pedidoShow(Sender: TObject);
    procedure Sb_TecnicoClick(Sender: TObject);
    procedure Qr_enderecoAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ChBx_Busca_FantasiaClick(Sender: TObject);
    procedure E_Cd_EmpresaExit(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      ShIft: TShIftState);
    procedure Sb_Fich_FinClick(Sender: TObject);
    procedure DBG_ProdutosDblClick(Sender: TObject);
    procedure DBG_ServicosDblClick(Sender: TObject);
    procedure Timer_deveTimer(Sender: TObject);
    procedure Sb_ParcelamentoClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure E_VL_DescontoExit(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure RegistraroNmerodeSrie1Click(Sender: TObject);
    procedure Sb_Vend_ComissaoClick(Sender: TObject);
    procedure Qr_ItensDevAfterOpen(DataSet: TDataSet);
    procedure ChBx_Busca_NomeClick(Sender: TObject);
    procedure E_Vl_DespesaExit(Sender: TObject);
    procedure E_VL_FreteExit(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure Qr_ItensVdaAfterOpen(DataSet: TDataSet);
    procedure Qr_ItensSrvAfterOpen(DataSet: TDataSet);
    procedure Sb_Ins_DevolucaoClick(Sender: TObject);
    procedure Sb_Alt_DevolucaoClick(Sender: TObject);
    procedure E_Nr_ParcelasExit(Sender: TObject);
    procedure DBLCB_PrazoClick(Sender: TObject);
    procedure Qr_PesquisaAfterOpen(DataSet: TDataSet);
    procedure RegistraNmerodeLoteClick(Sender: TObject);
    procedure Sb_Exc_DevolucaoClick(Sender: TObject);
    procedure DBG_DevolucaoKeyDown(Sender: TObject; var Key: Word;
      ShIft: TShIftState);
    procedure CadastrodoProdutoClick(Sender: TObject);
    procedure Ds_ItensDevStateChange(Sender: TObject);
    procedure MnuLucratividadeClick(Sender: TObject);
    procedure MnuSeparaoClick(Sender: TObject);
    procedure Sb_NegocioClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MenuItem3Click(Sender: TObject);
    procedure InformarNmerodeCompraClick(Sender: TObject);
    procedure E_Aq_DescontoExit(Sender: TObject);
    procedure DadosdoNCM1Click(Sender: TObject);
    procedure Sb_Ins_TrocaClick(Sender: TObject);
    procedure Sb_Alt_TrocaClick(Sender: TObject);
    procedure Sb_Exc_TrocaClick(Sender: TObject);
    procedure Qr_ItensTroAfterOpen(DataSet: TDataSet);
    procedure Pop_ConfigGlobalClick(Sender: TObject);
    procedure Pop_ConfigLocalClick(Sender: TObject);
    procedure Btn_Ap_LocalClick(Sender: TObject);
    procedure Btn_Cn_LocalClick(Sender: TObject);
    procedure Btn_Ok_LocalClick(Sender: TObject);
    procedure Btn_Ap_GlobalClick(Sender: TObject);
    procedure Btn_Cn_GlobalClick(Sender: TObject);
    procedure Btn_Ok_GlobalClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MnuOperaesemGrupoClick(Sender: TObject);
    procedure StrGrd_PedidoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure StrGrd_PedidoClick(Sender: TObject);
    procedure Sb_Grp_AtualizarClick(Sender: TObject);
    procedure Sb_VoltaGrupoClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure MnuEnviaPedidoClick(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);
    procedure Lucratividade1Click(Sender: TObject);
    procedure Tbs_DevolucaoShow(Sender: TObject);
    procedure Tbs_TrocaShow(Sender: TObject);
    procedure Tbs_ServicoShow(Sender: TObject);
    procedure Fm_FormaPagto1SB_FormaPagClick(Sender: TObject);
    procedure Fm_FormaPagto1DBLCB_FormaPagtoClick(Sender: TObject);
    procedure Fm_FormaPagtoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_VL_StExit(Sender: TObject);
    procedure Fm_VendedorPedidoSb_MedidaClick(Sender: TObject);
    procedure MnuCustodoPedidoClick(Sender: TObject);
    procedure ConsollidarCustoLucratividade1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure AplicarLote1Click(Sender: TObject);
    procedure AlteraTabeladePreo1Click(Sender: TObject);
    procedure Sb_Confirma_TabelaPrecoClick(Sender: TObject);
    procedure DBG_ProdutosTitleClick(Column: TColumn);
    procedure ActInclusaoRapidoProdutoExecute(Sender: TObject);
    procedure Sb_InclusaoRapidoClick(Sender: TObject);
    procedure Sb_Cancela_TabelaPrecoClick(Sender: TObject);
    procedure Qr_ItensVdaCalcFields(DataSet: TDataSet);
    procedure MnuAcompanhamentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AuditoriadeEstoqueClick(Sender: TObject);
    procedure Corrigirsequnciadositens1Click(Sender: TObject);
    procedure InformarContrato1Click(Sender: TObject);
    procedure InformaoCombustivel1Click(Sender: TObject);
    procedure SB_EnviarClick(Sender: TObject);
    procedure Fm_LMEchbx_EmpresasClick(Sender: TObject);
    procedure MnuLiberarItensparaDespachoClick(Sender: TObject);
    procedure MnuCancelarDespachoClick(Sender: TObject);

  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Faturar : Boolean;
    It_IMPRIMIR: Boolean;
    It_Supervisor: Boolean;
    it_ficha_financeira: Boolean;
    It_Visualizar : Boolean;
    It_Usa_Nfe : Boolean;
    It_NFCe : Boolean;
    It_Produto_Avulso : Boolean;
    It_Cli_Consumidor : Integer;
    It_Edicao_Ordem : String;
    CtrlLote : TControllerCtrlLote;
    FAbrirNovo: Boolean;
    FUtilizaVendedorCliente : Boolean;
    FDespachoByCodigoBarras : Boolean;
    procedure LucratividadePedidoAberto;

    function validaAcompanhamento:Boolean;
    procedure Pc_Abre_Config_Global;
    procedure Pc_Grava_Config_Global;
    procedure Pc_Abre_Config_Local;
    procedure Pc_Grava_Config_Local;
    procedure Pc_EstadoEdicaoOrdem;

    function EmEdicao:Boolean;
    function EmNavegacao:Boolean;
    procedure Pc_Gravar;
    procedure verificaBaseTroca;
    procedure Pc_FormataPanels;
    procedure EscolheTabela;
    procedure ControleElementos(Ativo:Boolean);
    Function ValidaTrocaTabela:Boolean;
    procedure TrocaTabela(pCodigoTabela:Integer);
    procedure Pc_grava_Perfil_Local;
    procedure AbrirOrdemServico;
    procedure AbrirOrdemServicoAutoCenter;
    procedure AbrirOrdemServicoExtintores;
    procedure AbrirOrdemServicoEletronicos;
    procedure AbrirOrdemServicoPetShop;
    procedure AbrirOrdemServicoMoveleiro;
    procedure AbrirOrdemServicoPrintShop;
    procedure setFAbrirNovo(const Value: Boolean);

    function valida_impressao:boolean;
    procedure Envia_impressao;
    function valida_email:boolean;
    function GeraCorpoEmail:String;
    procedure Envia_email;
    function valida_whatsApp:boolean;
    procedure Envia_whatsApp;

    function VerificaDespachadoLancado:Boolean;
    function ValidaEnvioPedidoParaDespacho:Boolean;
    procedure EnvioPedidoParaDespacho;

    function ValidaCancelaDespacho:boolean;
    procedure CancelarDespacho;

    function ValidaExluirPedido:boolean;
    procedure ExluirPedido;


  public
    { Public declarations }
    //Impressão
    Pedido : TControllerPedido;

    It_Plc_Debito: Integer;
    It_Plc_Credito: Integer;
    It_bloqueio : Boolean;
    It_vl_Credito, iT_Vl_Devedor,It_Vl_Chq_DEv, It_Vl_Chq_Pre: Real;

    It_Cd_Repres: Integer;
    It_Nm_Repres: String;
    It_Sql_Padrao : String;
    It_Fatura_Ok : Boolean;

    procedure Pc_AtivarTabelas;
    function validavisualizar:Boolean;
    procedure Pc_Visualizar;
    procedure Pc_Totalizador;
    procedure Pc_AtualizaCampos;
    procedure Pc_GeraNumeroPedido;
    function Fc_ValidasSeries:Boolean;
    function Fc_ValidasPrecoeParcelamento:Boolean;
    Function  Fc_ValidaFaturamento():Boolean;

    Function  Fc_ValidaGravacao():Boolean;
    function fc_ValidaComissao(): Boolean;


    Procedure Pc_Historico(Pc_Tipo:String;Pc_Cd_Cliente:Integer);
    function  Fc_Parcelamento():String;
    procedure Pc_FaturaRapido;
    procedure Pc_LimpaCampos;
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_FormataCasas;
    procedure PC_Sel_FormPagto(Pc_Bloquea_Pagto:Boolean);
    procedure PC_Sel_PrazoPagto(Pc_Bloquea_Pagto:Boolean);
    procedure Pc_Sel_Endereco(Pc_Cd_Cliente : Integer);
    procedure Pc_Valida_Info_cliente(Pc_Cd_Cliente : Integer);

    function FC_Valida_Itens_Vda:Boolean;
    Function FC_Valida_ImpostoAproximado:boolean;
    Function Fc_ValidaPrazo:Boolean;
    Function Fc_ValidaServico:Boolean;
    function Fc_ValidaParcelamentoPedido():boolean;
    function Fc_ValidaInfoOrigemVenda():Boolean;
    Function Fc_Valida_Cliente:Boolean;
    Function Fc_Valida_FormaPgto:Boolean;
    Procedure Pc_DefineSetfocus;

    pROCEDURE Pc_DinheiroFormaPgt;
    Procedure Pc_descontoAutomatico;
    Procedure Pc_controlaEdicaoCliente;
    Procedure Pc_controlaEdicaoVendedor;
    procedure Pc_Buscar;


    Procedure Pc_BuscaTelaAutoCenter;
    Procedure Pc_MontaGridTelaAutoCenter;
    Procedure Pc_BuscaTelaNormal;
    Procedure Pc_MontaGridTelaNormal;
    procedure Pc_EscolheFaturamento;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_UtitilzaCredito;
    procedure Pc_GravaCredito;

    Function Fc_DefineTabela():String;
    Function Fc_DefineTipoPessoa():String;

    procedure Pc_ImagemBotao;
    Function ValidaPedidoExistente:Boolean;
    Function ValidaEnvio():Boolean;
    Function Fc_ValidaCancelameto():Boolean;
    function  Fc_VerificaExistenciaItem():Boolean;
    procedure Pc_SomaPedidos;
    procedure Pc_AbrePedidoNovo;

    procedure Pc_FormataStrGrd_Pedido;
    procedure Pc_PreencherPedidoOperacaoGrupo;
    procedure Pc_AtualizaOperacaoGrupo_Data;

    function Fc_ValidaInfoOrigemCustomer():Boolean;
    Function Fc_ValidaInsereTecnicos():Boolean;
    procedure Pc_ChamaFatura;
    procedure Pc_ChamaFaturaVda;
    procedure Pc_ChamaFaturaSrv;
    procedure Pc_ChamaFaturaCupomFiscal;
    function Fc_ValidaAlteracao():Boolean;

    procedure Pc_AbrirPedido;
    procedure Pc_AbrirEndereco;
    procedure Pc_AbrirItensVenda;
    procedure Pc_AbrirItensServico;
    procedure Pc_AbrirItensDevolucao;
    procedure Pc_AbrirItensTroca;
    property AbrirNovo : Boolean read FAbrirNovo write setFAbrirNovo;
  end;

var
  Fr_Pedido_Vda: TFr_Pedido_Vda;

implementation

uses
  Un_DM, Un_Msg, UN_Principal, env, UN_Sistema, Un_Itens_Produto_Vda, Un_Funcoes,
  Un_Pesq_Produto, UN_Fatura_Vda, UN_RL_OrcaConserto, UN_RL_OrcaCst_Entg, Un_Liberacao,
  Un_Tecnicos, Un_Cotacao, Un_Clta_Csto, Un_Fich_Fin_Cli, Un_Parcelamento,
  Un_Produto_Series, Un_Vendedor, Un_Fc_Sored_Procedures, un_Padrao, Un_Cupom_Fiscal,
  UN_FormaPagto, Un_Imp_Mod_Impressao, Un_Regra_Negocio, Un_Produtos, DateUtils,
  reg_Service, Un_Info_Compra_Venda, Un_WebService, RN_Permissao, RN_Inventario,
  RN_Estoque, RN_Financeiro, RN_NotaFiscal, UN_NCM, Un_Itens_Servico,
  Un_Ctrl_Lote_Saida, RN_Lotes, RN_FormaPagto, Un_VehicleSo, RN_Pedido,
  Un_Info_Origen_Sale, Un_Info_Origen_Customer, RN_Cliente, RN_Empresa,
  Un_Pesq_Empresa, Un_Cliente, RN_NotaFiscalEletronica3X, UN_TabelasEmListas,
  Un_Fatura_Srv, RN_LUCRATIVIDADE, reg_custo_pedido, ControllerNotaFiscal,
  ControllerItensNFL, tblItensnfl, ControllerProduto, Un_Itens_Produto_Dev,
  Un_Itens_Produto_Tro, tas_order_elect_equip, un_RL_ReportLucratividadePedidoAberto,
  prmLucratividade, tas_contract_order, Un_envia_email, RN_Mailing, tas_followup,
  un_inclusao_rapida_produto, tas_order_print_shop, WhatsApp, tas_order_pet_shop,
  tas_furniture_os, tas_nfe_itens_fuel, sea_business, tributacao, ControllerDespacho;
{$R *.dfm}

procedure TFr_Pedido_Vda.Pc_AbrirPedido;
Begin
  Try
    with pedido.Registro do
    Begin
      E_Nr_Pedido.Text := IntToStr(Numero);
      E_Data.Date := Date;
      if Codigo > 0 then
      beGIN
        if Data <> null then
          E_Data.Date := Data
      End;
      Fm_VendedorPedido.ListaVendedor;
      Fm_VendedorPedido.Qr_ListaVendedor.First;
      Fm_VendedorPedido.Qr_ListaVendedor.Locate('CLB_CODIGO',Vendedor,[]);
      Fm_VendedorPedido.DBLCB_Vendedor.KeyValue := Vendedor;
      E_VL_ST.Text   := FloatToStrF(ValorSubstTributaria,ffFixed,10,2);
      E_VL_Frete.Text   := FloatToStrF(ValorFrete,ffFixed,10,2);
      E_Vl_Despesa.Text := FloatToStrF(ValorOutrasDEspesas,ffFixed,10,2);
      E_VL_Desconto.Text:= FloatToStrF(ValorDesconto,ffFixed,10,2);
      E_Aq_Desconto.Text:= FloatToStrF(AliqDesconto,ffFixed,10,2);

      Pc_AtualizaCampos;
      Pc_Totalizador;
      E_Cd_Empresa.Text := IntToStr(Empresa);
      DBLCB_Empresa.KeyValue := empresa;
      It_bloqueio := Fc_VerIficaBloqueioCliente(empresa);
      Pc_Sel_Endereco(Empresa);
      Pc_Valida_Info_cliente(Empresa);
      PC_Sel_FormPagto(It_bloqueio);
      PC_Sel_PrazoPagto(it_bloqueio);
      Pc_DinheiroFormaPgt;
      Pc_Historico('',Empresa);
      Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := FormaPagto;
      E_Nr_Parcelas.Text:=COPY( Prazo,0,Length(prazo));
      E_Nr_ParcelasExit(Self);
      E_Prazo.Text   := COPY( Prazo,7,Length(Prazo));
      Cb_Retirada.Text := Entrega;
      Cb_Garantia.Text := Garantia;
      Cb_IndPresComprador.ItemIndex := IndicaPresenca - 1;
      chbx_aprovados.Checked :=  (Aprovado = 'S');
      Dblcb_Negocio.KeyValue := Pedido.Registro.CodigoNegocio;
      DBLCB_End_Entrega.KeyValue := Pedido.Registro.Endereco;
      E_Data_Entrega.DateTime := DataEntrega;
      E_Observ.Text := Observacao;
    End;
  Except
    Pc_ErroCorrigirValores(Pedido.Registro.Codigo);
    Pc_AbrirPedido;
  end;
End;

procedure TFr_Pedido_Vda.Pc_AbrirEndereco;
Begin
  with Qr_endereco, Pedido.Registro do
  Begin
    Active:=False;
    ParamByName('EMP_CODIGO').AsInteger :=  Empresa;
    Active:=True;
  End;
end;

procedure TFr_Pedido_Vda.Pc_AbrirItensVenda;
Begin
  with Qr_ItensVda do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    Active:=False;
    paramByName('PED_CODIGO').AsInteger := Pedido.Registro.Codigo;
    Active:=True;
    Fetchall;
  End;
End;

procedure TFr_Pedido_Vda.Pc_AbrirItensServico;
Begin
  with Qr_ItensSrv do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    Active:=False;
    paramByName('PED_CODIGO').AsInteger := Pedido.Registro.Codigo;
    Active:=True;
    Fetchall;
  End;
End;

procedure TFr_Pedido_Vda.Pc_AbrirItensDevolucao;
Begin
  With Qr_ItensDev Do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    Active:=False;
    paramByName('PED_CODIGO').AsInteger := Pedido.Registro.Codigo;
    Active:=True;
    Fetchall;
  End;
End;

procedure TFr_Pedido_Vda.Pc_AbrirItensTroca;
Begin
  With Qr_ItensTro do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    Active:=False;
    paramByName('PED_CODIGO').AsInteger := Pedido.Registro.Codigo;
    Active:=True;
    Fetchall;
  End;
End;




procedure TFr_Pedido_Vda.Pc_Buscar;
begin
  If DM.IBT_Consulta.InTransaction THEN DM.IBT_Consulta.Commit;
  If (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S') then
    Pc_BuscaTelaAutoCenter
  else
    Pc_BuscaTelaNormal;
  Pnl_Busca.Caption := concat('Resultado da pesquisa : ' , IntTostr(Qr_Pesquisa.RecordCount) , ' registro(s)');
end;

Procedure TFr_Pedido_Vda.Pc_BuscaTelaAutoCenter;
Var
  Lc_Pedido : Boolean;
  Lc_numero : Boolean;
  Lc_Cliente : Boolean;
Begin
  It_Sql_Padrao := '';
  Screen.Cursor:=crHourGlass;
  If (E_BuscaPedido.Text = '') then Lc_Pedido := False else Lc_Pedido := True;
  If (E_BuscaNumero.Text = '') then Lc_numero := False else Lc_numero := True;
  If (E_BuscaCliente.Text = '') then Lc_Cliente := False else Lc_Cliente := True;
  
  If DM.IBT_Consulta.InTransaction then dm.IBT_Consulta.Commit;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  //Define Clausula Select
  If Lc_numero then
    It_Sql_Padrao := 'SELECT distinct PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA,     '+
                     ' PED_VL_PEDIDO, EMP_NOME, TB_VEHICLE_ID VEI_PLACA, PED_CODMHA,PED_CODVDO        '
  else
    It_Sql_Padrao := 'SELECT distinct PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA,     '+
                     ' PED_VL_PEDIDO, EMP_NOME, PED_CODMHA,PED_CODVDO                      ';


  //Define Clausula FROM
  If Lc_numero then
  Begin
    It_Sql_Padrao := It_Sql_Padrao +
                      'FROM TB_PEDIDO tb_pedido    '+
                      '  INNER JOIN TB_EMPRESA tb_empresa  '+
                      '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP )  '+
                      '  INNER JOIN TB_VEHICLE_SO OS '+
                      '  ON (OS.TB_ORDER_ID = tb_pedido.PED_CODIGO) '+
                      'WHERE (PED_FATURADO = ''N'') ';
      It_Sql_Padrao := It_Sql_Padrao + ' AND (PED_TIPO = 1) ';
  end
  else
  Begin
    It_Sql_Padrao := It_Sql_Padrao +
                      'FROM TB_PEDIDO tb_pedido    '+
                      '  INNER JOIN TB_EMPRESA tb_empresa                                          '+
                      '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP )                        '+
                      'WHERE (PED_FATURADO = ''N'')  ';
    It_Sql_Padrao := It_Sql_Padrao + ' AND (PED_TIPO = 1) ';
    end;

  if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
  Begin
    It_Sql_Padrao := It_Sql_Padrao + ' AND (PED_CODMHA =:PED_CODMHA) ';
  end;
    
  //Complementa a Clausula Where
  If ChBx_Periodo.Checked then
    It_Sql_Padrao := It_Sql_Padrao + 'AND (PED_DATA BETWEEN :PED_DATAINI AND :PED_DATAFIM) ';
    
  If Lc_Pedido  then It_Sql_Padrao := It_Sql_Padrao + 'AND (PED_NUMERO = :PED_NUMERO) ';
  If Lc_numero  then It_Sql_Padrao := It_Sql_Padrao + 'AND (OS.TB_VEHICLE_ID = :VEI_PLACA) ';
  If Lc_Cliente then It_Sql_Padrao := It_Sql_Padrao + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
   If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
    It_Sql_Padrao := It_Sql_Padrao + 'AND ((PED_CODVDO =:PED_CODVDO)) ';

  Qr_Pesquisa.SQL.Add(It_Sql_Padrao + ' ORDER BY EMP_FANTASIA ');

  Pc_MontaGridTelaAutoCenter;
  //Passsagem de Paramentos
   If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
    Qr_Pesquisa.ParamByName('PED_CODVDO').AsInteger := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;
        
  If ChBx_Periodo.Checked then
    Begin
    Qr_Pesquisa.ParamByName('PED_DATAINI').AsDate :=E_Data_Ini.date;
    Qr_Pesquisa.ParamByName('PED_DATAFIM').AsDate := E_Data_Fim.Date;
    end;
  If Lc_Pedido then Qr_Pesquisa.ParamByName('PED_NUMERO').AsString := E_BuscaPedido.Text;
  If Lc_numero then Qr_Pesquisa.ParamByName('VEI_PLACA').AsString := E_BuscaNumero.Text;
  If Lc_Cliente then Qr_Pesquisa.ParamByName('EMP_FANTASIA').AsString := '%'+E_BuscaCliente.Text+'%';

  if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
  Begin
    Qr_Pesquisa.ParamByName('PED_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;
  end;
      
  Qr_Pesquisa.Open;
  Qr_Pesquisa.FetchAll;
  Screen.Cursor:=crDefault;
  If ChBx_Busca_Nome.Checked then
    ChBx_Busca_NomeClick(SELF)
  else
  If ChBx_Busca_Fantasia.Checked then
    ChBx_Busca_FantasiaClick(SELF);  
end;

Procedure TFr_Pedido_Vda.Pc_MontaGridTelaAutoCenter;
Var
  Lc_numero : Boolean;
Begin
  Screen.Cursor:=crHourGlass;
  If (E_BuscaNumero.Text = '') then Lc_numero := False else Lc_numero := True;
  //Define colunas da Grid
  DBG_Pesquisa.Columns.Clear;
  If Lc_numero then
    Begin
    //Data do Pedido
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[0].Width := 64;
    DBG_Pesquisa.Columns[0].FieldName := 'PED_DATA';
    DBG_Pesquisa.Columns[0].Title.Caption := 'Data';
    //numero do Pedido
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[1].Width := 64;
    DBG_Pesquisa.Columns[1].FieldName := 'PED_NUMERO';
    DBG_Pesquisa.Columns[1].Title.Caption := 'Pedido';

    //Nome do Cliente
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[2].Width := 283;//342
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_NOME';
    DBG_Pesquisa.Columns[2].Title.Caption := 'Nome do Cliente';
    //numero da placa
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[3].Width := 59;
    DBG_Pesquisa.Columns[3].FieldName := 'VEI_PLACA';
    DBG_Pesquisa.Columns[3].Title.Caption := 'Placa';
    //Valor do Pedido
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[4].Width := 75;
    DBG_Pesquisa.Columns[4].FieldName := 'PED_VL_PEDIDO';
    DBG_Pesquisa.Columns[4].Title.Caption := 'Valor';
    if Gb_Nivel = 0 then
      DBG_Pesquisa.Columns[4].Visible := not ( Fc_Tb_Geral('L','VDA_G_NO_SHOW_VALUES','S') = 'S')
    else
        DBG_Pesquisa.Columns[4].Visible := True;
  end
  else
  Begin
    //Data do Pedido
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[0].Width := 64;
    DBG_Pesquisa.Columns[0].FieldName := 'PED_DATA';
    DBG_Pesquisa.Columns[0].Title.Caption := 'Data';
    //numero do Pedido
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[1].Width := 64;
    DBG_Pesquisa.Columns[1].FieldName := 'PED_NUMERO';
    DBG_Pesquisa.Columns[1].Title.Caption := 'Pedido';
    //Nome do Cliente
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[2].Width := 347;
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_NOME';
    DBG_Pesquisa.Columns[2].Title.Caption := 'Nome do Cliente';
    //Valor do Pedido
    DBG_Pesquisa.Columns.Add;
    DBG_Pesquisa.Columns[3].Width := 75;
    DBG_Pesquisa.Columns[3].FieldName := 'PED_VL_PEDIDO';
    DBG_Pesquisa.Columns[3].Title.Caption := 'Valor';

    if Gb_Nivel = 0 then
      DBG_Pesquisa.Columns[3].Visible := not ( Fc_Tb_Geral('L','VDA_G_NO_SHOW_VALUES','S') = 'S')
    else
        DBG_Pesquisa.Columns[3].Visible := True;
  end;

end;

Procedure TFr_Pedido_Vda.Pc_BuscaTelaNormal;
Var
  Lc_Pedido : Boolean;
  Lc_Cliente : Boolean;
  Lc_Cd_Cliente : Boolean;
Begin
  It_Sql_Padrao := '';
  Screen.Cursor:=crHourGlass;
  If (E_BuscaPedido.Text = '') then Lc_Pedido := False else Lc_Pedido := True;
  If (E_BuscaCliente.Text = '') then Lc_Cliente := False else Lc_Cliente := True;
  If (E_Cd_Busca_Empresa.Text = '') then Lc_Cd_Cliente := False else Lc_Cd_Cliente := True;

  If DM.IBT_Consulta.InTransaction then dm.IBT_Consulta.Commit;
  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;
  //Define Clausula Select
  It_Sql_Padrao := 'SELECT distinct PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA, '+
                   ' PED_VL_PEDIDO, EMP_NOME, PED_CODMHA, PED_NUMWEB,PED_CODVDO '+
                   'FROM TB_PEDIDO tb_pedido '+
                   '  INNER JOIN TB_EMPRESA tb_empresa '+
                   '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP ) '+
                   'WHERE (PED_FATURADO = ''N'')  ';

  It_Sql_Padrao := It_Sql_Padrao + ' AND (PED_TIPO = 1) ';

  if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
  Begin
    It_Sql_Padrao := It_Sql_Padrao + ' AND (PED_CODMHA =:PED_CODMHA) ';
  end;
                       
  //Complementa a Clausula Where
  If ChBx_Periodo.Checked then
    It_Sql_Padrao := It_Sql_Padrao + 'AND (PED_DATA BETWEEN :PED_DATAINI AND :PED_DATAFIM) ';
    
  If Lc_Pedido  then
    It_Sql_Padrao := It_Sql_Padrao + 'AND (PED_NUMERO = :PED_NUMERO) ';
  If Lc_cd_Cliente then
    It_Sql_Padrao := It_Sql_Padrao + 'AND ( PED_CODEMP =:PED_CODEMP ) ';
  If Lc_Cliente then
    It_Sql_Padrao := It_Sql_Padrao + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
  If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
    It_Sql_Padrao := It_Sql_Padrao + 'AND ( PED_CODVDO =:PED_CODVDO ) ';

  Qr_Pesquisa.SQL.Add(It_Sql_Padrao + ' ORDER BY EMP_FANTASIA ');

  Pc_MontaGridTelaNormal;
  //Passsagem de Paramentos
  If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
    Qr_Pesquisa.ParamByName('PED_CODVDO').AsInteger := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;

  If ChBx_Periodo.Checked then
    Begin
    Qr_Pesquisa.ParamByName('PED_DATAINI').AsDate :=E_Data_Ini.date;
    Qr_Pesquisa.ParamByName('PED_DATAFIM').AsDate := E_Data_Fim.Date;
    end;
  If Lc_Pedido then Qr_Pesquisa.ParamByName('PED_NUMERO').AsString := E_BuscaPedido.Text;
  If Lc_cd_Cliente then Qr_Pesquisa.ParamByName('PED_CODEMP').AsString := E_Cd_Busca_Empresa.Text;
  If Lc_Cliente then Qr_Pesquisa.ParamByName('EMP_FANTASIA').AsString := '%'+E_BuscaCliente.Text+'%';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Begin
      Qr_Pesquisa.ParamByName('PED_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;
    end;

  Qr_Pesquisa.Open;
  Qr_Pesquisa.FetchAll;
  Screen.Cursor:=crDefault;
  If ChBx_Busca_Nome.Checked then
    ChBx_Busca_NomeClick(SELF)
  else
  If ChBx_Busca_Fantasia.Checked then
    ChBx_Busca_FantasiaClick(SELF);  
end;

Procedure TFr_Pedido_Vda.Pc_MontaGridTelaNormal;
Begin
  DBG_Pesquisa.Columns.Clear;
  DBG_Pesquisa.Columns.Add;
  DBG_Pesquisa.Columns[0].Width := 64;
  DBG_Pesquisa.Columns[0].FieldName := 'PED_DATA';
  DBG_Pesquisa.Columns[0].Title.Caption := 'Data';
  //numero do Pedido
  DBG_Pesquisa.Columns.Add;
  DBG_Pesquisa.Columns[1].Width := 64;
  DBG_Pesquisa.Columns[1].FieldName := 'PED_NUMERO';
  DBG_Pesquisa.Columns[1].Title.Caption := 'Pedido';
  //Nome do Cliente
  DBG_Pesquisa.Columns.Add;
  DBG_Pesquisa.Columns[2].Width := 347;
  DBG_Pesquisa.Columns[2].FieldName := 'EMP_NOME';
  DBG_Pesquisa.Columns[2].Title.Caption := 'Nome do Cliente';
  //Valor do Pedido
  DBG_Pesquisa.Columns.Add;
  DBG_Pesquisa.Columns[3].Width := 75;
  DBG_Pesquisa.Columns[3].FieldName := 'PED_VL_PEDIDO';
  DBG_Pesquisa.Columns[3].Title.Caption := 'Valor';
  if Gb_Nivel = 0 then
    DBG_Pesquisa.Columns[3].Visible := not ( Fc_Tb_Geral('L','VDA_G_NO_SHOW_VALUES','S') = 'S')
  else
    DBG_Pesquisa.Columns[3].Visible := True;
  //Codigo do pedido na Web
  DBG_Pesquisa.Columns.Add;
  DBG_Pesquisa.Columns[4].Width := 75;
  DBG_Pesquisa.Columns[4].FieldName := 'PED_NUMWEB';
  DBG_Pesquisa.Columns[4].Title.Caption := 'Pedido Web';
end;


procedure TFr_Pedido_Vda.Pc_FormataTela;
Var
  Lc_X : Integer;
  Lc_Servico:Boolean;
  Lc_Devolucao:Boolean;
  Lc_Troca:Boolean;
Begin
  Pc_ImagemBotao;
  For Lc_X:=1 to Pg_Pedido_Vda.PageCount do Pg_Pedido_Vda.Pages[Lc_X-1].TabVisible:=False;
  PG_Itens.Pages[1].TabVisible := False;
  PG_Itens.Pages[2].TabVisible := False;
  MnuSeparao.Enabled := (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','')='S');
  //Ativa a Aba de Devolução
  Lc_Devolucao := (Fc_Tb_Geral('L','GRL_G_TAR_DEVOLUCAO','N') = 'S');
  Lb_Vl_Devolucao.Visible := Lc_Devolucao;
  E_Vl_Devolucao.Visible := Lc_Devolucao;
  PG_Itens.Pages[2].TabVisible := Lc_Devolucao;
  //Ativa a Aba de Troca
  Lc_Troca := (Fc_Tb_Geral('L','GRL_G_TAR_TROCA','N') = 'S');
  E_Vl_Troca.Visible := Lc_Troca;
  Lb_troca.Visible := Lc_Troca;
  PG_Itens.Pages[3].TabVisible := Lc_Troca;
  E_Vl_Troca.Visible := Lc_Troca;

  If (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S') then
  Begin
    Lb_Placa.Caption := 'Placa';
    E_BuscaNumero.Enabled := True;
    PG_Itens.Pages[1].TabVisible := True;
    E_Vl_Servico.Visible := True;
  end
  else
  Begin
    Lb_Placa.Caption := '';
    E_BuscaNumero.Enabled := False;
    E_BuscaNumero.Enabled := True;
    PG_Itens.Pages[1].TabVisible := False;
  end;

  If (Fc_Tb_Geral('L','VDA_G_CTRL_PARCELA','A') = 'A') then
  Begin
    E_Nr_Parcelas.Visible:=true;
    E_Prazo.Visible:=true;
    Sb_Parcelamento.Visible:=true;
    DBLCB_Prazo.Visible:=false;
  end
  else
  Begin
    DBLCB_Prazo.Top:=52;
    DBLCB_Prazo.Visible:=true;
    E_Nr_Parcelas.Visible:=False;
    E_Prazo.Visible:=False;
    Sb_Parcelamento.Visible:=False;
  end;
  // Abre arquivo de configuracao
  E_Data.Date := Date;
  PG_Itens.ActivePageIndex:=0;
  E_Data_Ini.Date := Date-30;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Pc_PermissaoBotao('Pedido de Venda');
  ChBx_Nome.Enabled := FALSE;
  Height := 655 - 20;
  //Configurações
  E_Aliq_Desconto.Alignment:= TAlignment(1);
  ed_desc_avista.Alignment:= TAlignment(1);
  PG_Itens.ActivePage := Tbs_Produto;

  ChBx_BuscaPedidoAndroid.Checked := False;
  if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
  Begin
    Case Gb_Cd_Wsr of
      2:ChBx_BuscaPedidoAndroid.Enabled := True
    else
      ChBx_BuscaPedidoAndroid.Enabled := False;
    End;
  End;
  It_Supervisor := Fc_VerificaPermissao('Fr_Nota_Fiscal','Notas Fiscais de Venda','SUPERVISOR',GB_Cd_Usuario,'N');
  if It_Supervisor then
  BEgin
    Lb_TotalVenda.Visible := True;
    E_TotalVenda.Visible := True;
  end
  else
  Begin
    Lb_TotalVenda.Visible := False;
    E_TotalVenda.Visible := False;
  end;
  //Menu dos Despacho
  FDespachoByCodigoBarras :=  ( Fc_Tb_Geral('L','DSP_BY_COD_BARRAS','N') = 'S');
  MnuLiberarItensparaDespacho.Visible  := FDespachoByCodigoBarras;
  MnuCancelarDespacho.Visible          := FDespachoByCodigoBarras;
end;

procedure TFr_Pedido_Vda.Pc_LimpaCampos;
Begin
  pedido.Clear;
  It_Vl_Chq_DEv :=0;
  It_Vl_Chq_Pre :=0;
  Lb_Vl_Credito.Caption := '0,00';
  Lb_Vl_Devedor.Caption := '0,00';
  Lb_Vl_predatado.Caption := '0,00';
  Lb_Vl_Devolvido.Caption := '0,00';
  E_Nr_Pedido.Clear;
  E_Cd_Empresa.Clear;
  E_Cd_EmpresaExit(Self);
  chbx_aprovados.Checked := False;
  E_VL_St.Text := '0,00';
  E_VL_IPI.Caption := '0,00';
  E_VL_Frete.Text := '0,00';
  E_Vl_Despesa.Text := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  E_Prazo.EditMask := '';
  E_Prazo.Text:='';
  E_Nr_Parcelas.Text := '000';
  E_Nr_ParcelasExit(Self);
  E_Data.Date := Date;
  E_Observ.Lines.Clear;
  DBLCB_end_Entrega.Keyvalue := Null;
  Fm_ListaVendedores.Dblcb_Vendedor.KeyValue := Null;



end;

procedure TFr_Pedido_Vda.Pc_FaturaRapido;
Begin
  If Fc_ValidaFaturamento then
    Begin
    If not Assigned(Fr_Fatura_Vda) then Application.CreateForm(TFr_Fatura_Vda,Fr_Fatura_Vda);
    with Fr_Fatura_Vda do
      Begin
      Pc_AtivarTabela;
      E_Dt_Emissao.Date := Date;
      E_Dt_Saida.Date := Date;
      If not fc_ValidaFaturamento then exit;
      Pc_GeraNumeroPedido;
      Pc_ImprimeCupom;

      Fc_Faturar_Normal;
      end;
    If Assigned(Fr_Clta_Csto) then  Fr_Clta_Csto.SB_BuscarClick(self);
    end;

end;

function TFr_Pedido_Vda.Fc_Parcelamento():String;
Var
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_I : Integer;
  Lc_Prazo : String;
  Lc_PArcelamento : String;
  Lc_Vl_Pedido : Real;
  Lc_Qt_Parcelas : Integer;
Begin

  Lc_Qt_Parcelas := StrToIntDef(E_Nr_Parcelas.Text,1);
  Lc_Vl_Pedido := StrToFloatDef(E_VL_Pedido.Caption,0);
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_St_Parcela := FloatToStrF((Lc_Vl_Pedido / Lc_Qt_Parcelas),ffFixed,10,2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
  Lc_PArcelamento := '';
  For Lc_I := 0 to (Lc_Qt_Parcelas-1) do
    Begin
    Lc_Prazo :=  Copy(E_Prazo.Text,((Lc_I * 4)+1),3);
    If (Lc_I = (Lc_Qt_Parcelas-1)) then
      Begin
      Lc_PArcelamento := Lc_PArcelamento + Copy(DateToStr(E_Data.Date + StrToIntDef(Lc_Prazo,0)),1,5) + ' - ' + Lc_St_Parcela;
      end
    else
      Begin
      Lc_PArcelamento := Lc_PArcelamento + Copy(DateToStr(E_Data.Date + StrToIntDef(Lc_Prazo,0)),1,5) + ' - ' + FloatToStrF((Lc_Vl_Pedido -(Lc_Vl_Parcela * (lc_Qt_Parcelas-1))),ffFixed,10,2) + ' / ' ;
      end;
    end;
 Result := Lc_PArcelamento;
end;

Procedure TFr_Pedido_Vda.Pc_Historico(Pc_Tipo:String;Pc_Cd_Cliente:Integer);
Var
  lc_obs,  Lc_TExto : String;
Begin
  If Pc_Cd_Cliente = 0 then exit;
  Lc_TExto := '';
  Lb_Vl_Credito.Caption := '0,00';
  Lb_Vl_Devedor.Caption := '0,00';
  Lb_Vl_predatado.Caption := '0,00';
  Lb_Vl_Devolvido.Caption := '0,00';

  //Cheque Devolvido
  It_Vl_Chq_DEv := Fc_SaldoChequeDevolvido(Pc_Cd_Cliente);
  If It_Vl_Chq_DEv > 0 then Lb_Vl_Devolvido.Caption := FloatToStrF(It_Vl_Chq_DEv,ffFixed, 10, 2);

  //Cheque Pre-Datado
  It_Vl_Chq_Pre := Fc_SaldoChequePreDatado(Pc_Cd_Cliente);
  If It_Vl_Chq_Pre > 0 then Lb_Vl_predatado.Caption := FloatToStrF(It_Vl_Chq_Pre,ffFixed, 10, 2) ;

  //Saldo Credor
  It_vl_Credito := Fc_SaldoCredorCliente(Pc_Cd_Cliente);
  If It_vl_Credito > 0 then Lb_Vl_Credito.Caption := FloatToStrF(It_vl_Credito,ffFixed, 10, 2);

  //Saldo Devedor
  iT_Vl_Devedor := Fc_SaldoDevedorCliente(Pc_Cd_Cliente);
  If iT_Vl_Devedor > 0 then Lb_Vl_Devedor.Caption := FloatToStrF(It_Vl_Devedor,ffFixed, 10, 2);
  If Gb_SaldoVencido then
  Begin
    Timer_deve.Enabled := true;
    Lb_Vl_Devedor.Font.Color := clred;
  end
  else
  Begin
    Lb_Vl_Devedor.Font.Color := clNavy;
    Timer_deve.Enabled := False;
  end;

  lc_obs:=Fc_Obs_Empresa(StrToIntDef(E_Cd_Empresa.Text,0));
  If Pc_Tipo = '1' then
  Begin
    If lc_obs  <> '' then
    Begin
      Lc_TExto := Lc_TExto +' '+ lc_obs;
      pedido.Registro.Observacao :=Lc_TExto;
      E_Observ.text := pedido.Registro.Observacao;
    end;
  end;
end;

function TFr_Pedido_Vda.Fc_ValidasPrecoeParcelamento:Boolean;
Var
  Lc_Msg : String;
Begin
  Result := True;
  if (Fc_Tb_Geral('L','VDA_G_CTRL_TABELA_X_PRAZO','') = 'S') then
    Begin
    if StrToIntDef(E_Nr_Parcelas.Text,0) > 0 then
      Begin
      if not Qr_ItensVda.active then Qr_ItensVda.active := True;

      Qr_ItensVda.First;
      Lc_Msg := '';
      while not Qr_ItensVda.Eof do
        Begin
        if Qr_ItensVda.FieldByName('TPR_MODALIDADE').AsString = 'V' then
          Lc_Msg := Lc_Msg + Qr_ItensVda.FieldByName('PRO_CODIGOFAB').AsString + ' - ' + Qr_ItensVda.FieldByName('PRO_DESCRICAO').AsString + #13#10;
        Qr_ItensVda.Next;
        end;

      if Trim(Lc_Msg) <> '' then
        Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Os seguinte produtos foram registrados com Tabela de Preço Vista.' + EOLN + EOLN +
                       Lc_Msg + EOLN +
                       'Esta operação não é permitida para pedidos é prazo.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result := False;
        end;
      end;
    end;
end;

function TFr_Pedido_Vda.Fc_ValidasSeries:Boolean;
Var
  Lc_SQLTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Label
  sai;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SQLTxt := 'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI  FROM TB_SERIE_PRODUTO  '+
                 'WHERE (SRP_CODSAI =:SRP_CODSAI)                       '+
                 '  AND (SRP_CODPRO=:SRP_CODPRO)                        ';

      SQL.Add(Lc_SQLTxt);
      Qr_ItensVda.Active := False;
      Qr_ItensVda.Active := True;
      Qr_ItensVda.First;
      while not Qr_ItensVda.Eof do
      Begin
        If (Qr_ItensVda.FieldByName('PRO_SERIE').AsString = 'S') then
        Begin
          Active := False;
          ParamByName('SRP_CODSAI').AsInteger := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
          ParamByName('SRP_CODPRO').AsInteger := Qr_ItensVda.FieldByName('ITF_CODPRO').AsInteger;
          Active := true;
          FetchAll;
          If (RecordCount <> Qr_ItensVda.FieldByName('ITF_QTDE').AsFloat) then
          Begin
            MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                           'Informe os número de séries conforme ' + EOLN +
                           'a quantidade de itens do produto '+ Qr_ItensVda.FieldByName('PRO_DESCRICAO').AsString + '.' + EOLN,
                           ['OK'], [bEscape], mpAlerta);
            Result := False;
          goto sai;
          end;
        end;
        Qr_ItensVda.Next;
      end;
      sai:
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

Function TFr_Pedido_Vda.Fc_ValidaFaturamento():Boolean;
var
  lc_prazo_controlado, LC_PRAZO_aberto:string;
  Lc_Cd_Aux : Integer;
Begin
  Result:=TRUE;
  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;

  if Pedido.verificaFaturado(True) then
  Begin
    Result := False;
    Sb_PesquisarClick(Self);
    exit;
  end;

  Pc_AtualizaCampos;
  Pc_Totalizador;
  Pc_Gravar;

  If trim(DBLCB_Empresa.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Campo Cliente não informado.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    Result:=FALSE;
    exit;
  end;

  If (Qr_ItensVda.RecordCount = 0) and (Qr_ItensSrv.RecordCount = 0)  and(StrToFloatDef(E_VL_Pedido.Caption,0) = 0) then
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Pedido sem Item. Não é possível faturar.' + EOLN +
                   'Incluar um item e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    Result:=false;
    exit;
  end;

  If not Fc_ValidasPrecoeParcelamento then //Verifica se a tabela usada no parcelamento é válida
  Begin
    Result := False;
    exit;
  end;

  //Verifica se o cliente é consumidor e se o imposto aproximado foi informado
  if ( Fc_Tb_Geral('L','GRL_G_IMPOSTO_APROX','S') = 'S') then
  Begin
    if DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_CONSUMIDOR').AsString = 'S' then
    Begin
      if not FC_Valida_ImpostoAproximado then
      Begin
        Result := False;
        exit;
      end;
    end;
  End;

  If not FC_Valida_Itens_Vda then
  Begin
    Result:=FALSE;
    exit;
  end;

  If not Fc_ValidaPrazo then
  Begin
    Result:=FALSE;
    EXIT;
  end;
  //Valida se tem serviço e se tem o veiculo cadastrado e se O tecnico foi preenchido
  If NOT Fc_ValidaServico THEN
  Begin
    Result:=FALSE;
    EXIT;
  end;

  //Valida preenchimento do endereco d entrega
  if Trim(DBLCB_end_Entrega.Text)='' then Lc_Cd_Aux := 0 else Lc_Cd_Aux := DBLCB_end_Entrega.KeyValue;
  If not Fc_Valida_enderecoPedido(Lc_Cd_Aux,DBLCB_end_Entrega.Text) then
    Begin
    Result:=FALSE;
    exit;
    end;

  If E_Nr_Parcelas.Visible = true then
    Begin
    LC_PRAZO_aberto:=E_Nr_Parcelas.Text;
    lc_prazo_controlado:= '000 - VISTA';
    end
  else
    Begin
    lc_prazo_controlado:= DBLCB_Prazo.Text;
    LC_PRAZO_aberto:='000';
    end;

  If trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) = '' then
    Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Campo forma de pagamento não informado.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    Result:=FALSE;
    exit;
    end;

  if not Cliente_Valida_Limite(pedido.Registro.Empresa,pedido.Registro.FormaPagto ,pedido.Registro.ValorPedido) then
  Begin
    Result:=FALSE;
    exit;
  end;
      
  If (DBLCB_Prazo.Visible = true) then
    Begin
    If DBLCB_Prazo.KeyValue = null then
      Begin
      Result:=FALSE;
      exit;
      end;
    end
  else
    Begin
    E_Prazo.Text
    end;

  If not Fc_ValidaParcelamentoPedido then
    Begin
    Result:=FALSE;
    exit;
    end;



  If not Fc_ValidasSeries then
    Begin
    Result:=FALSE;
    exit;
    end;

  IF not fc_ValidaComissao then
  Begin
    Result:=FALSE;
    exit;
  end;


end;


function TFr_Pedido_Vda.fc_ValidaComissao(): Boolean;
Var
  Lc_sqltxt : String;
  Lc_Msg : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    Result := true;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_sqltxt:= ' select CLB_COM_VDA '+
                  ' from tb_colaborador '+
                  'where  clb_codigo =:CLB_CODIGO ';
      SQL.Add(Lc_sqltxt);
      ParamByName('CLB_CODIGO').asinteger:= Pedido.Registro.Vendedor;
      Active:=True;

      if FieldByName('CLB_COM_VDA').AsString = 'S' then
      Begin
        IF (Fc_Tb_Geral('L','OSR_G_PDV_COM_PROD','S') = 'S') then
        Begin
          Lc_Msg := '';
          Qr_ItensVda.Active := false;
          Qr_ItensVda.Active := TRue;
          Qr_ItensVda.First;
          while not Qr_ItensVda.Eof do
          Begin
            if Qr_ItensVda.FieldByName('ITF_AQ_COM').AsFloat = 0 then
            Begin
              Lc_Msg := Lc_Msg + Qr_ItensVda.FieldByName('ITF_CODPRO').AsString + ' - ' + Qr_ItensVda.FieldByName('PRO_DESCRICAO').AsString +'.' + EOLN ;
            end;
            Qr_ItensVda.Next;
          end;

          If Trim(Lc_Msg) <> '' then
          Begin
            MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                          ' Este Vendedor recebe comissão por produto e o(s) item(ns)' + EOLN + EOLN +
                          Lc_Msg + EOLN +
                          'está(ão) sem comissão neste(s) lançamento(s).' + EOLN +
                           ' Verifique e tente novamente.' + EOLN,
                         ['OK'], [bEscape], mpAlerta);
            Result := False;
            exit;
          end;
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pedido_Vda.Pc_GeraNumeroPedido;
Begin
  with Pedido.Registro do
  Begin
    If (Numero = 0) then Pedido.nextNumber('T');
    E_Nr_Pedido.Text := IntToStr( Numero );
  End;
end;

procedure TFr_Pedido_Vda.Pc_AtivarTabelas;
Begin
  Fm_VendedorPedido.ListaVendedor;
  DM.Qr_Prazo.Active:=True;
  Pc_AbreListaCliente('EMP_NOME');
  DM.Qr_Negocio.Active:=True;
end;


procedure TFr_Pedido_Vda.Pc_Visualizar;
Begin
  Pedido.getbyId;
  Pedido.using('B');
  Pc_AtivarTabelas;
  Pc_AbrirEndereco;
  Pc_AbrirPedido;
  It_Edicao_Ordem := 'B';
  Pc_EstadoEdicaoOrdem;
  Pg_Pedido_Vda.ActivePageIndex := 0;
end;

procedure TFr_Pedido_Vda.Pc_AtualizaCampos;
Var
  Lc_Qt_Produto : Real;
  Lc_Vl_Produto : Real;
  Lc_VL_Servico : Real;
  Lc_Vl_IPI     : Real;
  Lc_Vl_Desconto:Real;
  Lc_VL_Devolucao : Real;
  Lc_VL_Troca : Real;
  LcNrCasa : Integer;
  Lc_Aux : Real;
Begin
  LcNrCasa := Length(Gb_Casa_Dec_Venda)-2;
  Lc_Qt_Produto := 0;
  Lc_Vl_Produto := 0;
  Lc_VL_Servico := 0;
  Lc_Vl_IPI := 0;
  Lc_Vl_Desconto:=0;
  Lc_VL_Devolucao :=0;
  Pc_AbrirItensVenda;

  Qr_ItensVda.First;
  while not Qr_ItensVda.Eof do
  Begin
    Lc_Vl_Produto := Lc_Vl_Produto + Qr_ItensVdaITF_VL_SUBTOTAL.AsCurrency;
    Lc_Qt_Produto := Lc_Qt_Produto + Qr_ItensVdaITF_QTDE.AsFloat;
    Lc_Vl_IPI := Lc_Vl_IPI + Qr_ItensVdaITF_VL_IPI.AsCurrency;
    Lc_Vl_Desconto := Lc_Vl_Desconto + Qr_ItensVdaITF_VL_DESC.AsCurrency;
    Qr_ItensVda.Next;
  end;
  //Servivo
  Pc_AbrirItensServico;
  Qr_ItensSrv.First;
  Lc_VL_Servico := 0;
  while not Qr_ItensSrv.Eof do
  Begin
    Lc_VL_Servico := Lc_VL_Servico + RoundTo(Qr_ItensSrvITF_VL_SUBTOTAL.AsCurrency,-2);
    Lc_Vl_Desconto := Lc_Vl_Desconto + Qr_ItensSrvITF_VL_DESC.AsCurrency;
    Qr_ItensSrv.Next;
  end;

  //Devolução
  Pc_AbrirItensDevolucao;
  Qr_ItensDev.First;
  Lc_VL_Devolucao := 0;
  while not Qr_ItensDev.Eof do
  Begin
    Lc_VL_Devolucao := Lc_VL_Devolucao + RoundTo(Qr_ItensDevITF_VL_SUBTOTAL.AsCurrency,-2);
    Qr_ItensDev.Next;
  end;

  //Troca
  Pc_AbrirItensTroca;
  Qr_ItensTro.First;
  Lc_VL_Troca := 0;
  while not Qr_ItensTro.Eof do
  Begin
    Lc_VL_Troca := Lc_VL_Troca + Roundto(Qr_ItensTroITF_VL_SUBTOTAL.AsCurrency,-2);
    Qr_ItensTro.Next;
  end;

  //Atualiza os campos no Formulario
  E_Qt_Produto.Caption := FloatToStrF(Lc_Qt_Produto,ffFixed,10,2);
  E_VL_Produto.Caption:= FloatToStrF(Lc_Vl_Produto,ffFixed,10,2);
  E_VL_Servico.Caption:= FloatToStrF(Lc_VL_Servico,ffFixed,10,2);
  E_VL_IPI.Caption:= FloatToStrF(Lc_Vl_IPI,ffFixed,10,2);
  E_Vl_Devolucao.Caption:= FloatToStrF(lc_VL_Devolucao,ffFixed,10,2);
  E_Vl_Troca.Caption:= FloatToStrF(Lc_VL_Troca,ffFixed,10,2);
  E_Vl_Desconto.Text:= FloatToStrF(lc_VL_Desconto,ffFixed,10,2);
  if (Lc_Vl_Produto + Lc_VL_Servico) > 0 then
  Begin
    Lc_Aux := (Lc_VL_Desconto / (Lc_Vl_Produto + Lc_VL_Servico)) * 100;
    Lc_Aux := RoundTo(Lc_Aux,-2);
    E_Aq_Desconto.Text := FloatToStrF(Lc_Aux,ffFixed,10,2);
  End
  else
    E_Aq_Desconto.Text := '0,00';

end;

procedure TFr_Pedido_Vda.Pc_Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
begin
  Lc_Vl_Total := 0;
  //PRodutos
  Lc_Vl_aux := StrToFloatDef(E_VL_Produto.Caption, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_Produto.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Servico
  Lc_Vl_aux := StrToFloatDef(E_Vl_Servico.Caption, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_Vl_Servico.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //IPI
  Lc_Vl_aux := StrToFloatDef(E_VL_IPI.Caption, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_IPI.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //ST
  Lc_Vl_aux := StrToFloatDef(E_VL_ST.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_ST.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Frete
  Lc_Vl_aux := StrToFloatDef(E_VL_Frete.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_Frete.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Despesa
  Lc_Vl_aux := StrToFloatDef(E_Vl_Despesa.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_Vl_Despesa.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Desconto
  Lc_Vl_aux := StrToFloatDef(E_VL_Desconto.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total - Lc_Vl_aux;
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Valor total
  E_VL_Pedido.Caption := FloatToStrF(Lc_Vl_Total, ffFixed, 10, 2);
end;


// Procedures Internas

{Ordem de Servico/Venda}


procedure TFr_Pedido_Vda.DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
  ShIft: TShIftState);
Begin
  If ShIft = [] then
  case Key of
    VK_delete  : If Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
  end;
end;

procedure TFr_Pedido_Vda.DBG_ProdutosTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Produtos, Column);
end;

procedure TFr_Pedido_Vda.E_DataEnter(Sender: TObject);
Begin
  E_Data.Date := Date;
end;

procedure TFr_Pedido_Vda.FormKeyPress(Sender: TObject; var Key: Char);
Begin
  If (Key = #13) and not (ActiveControl is TMemo) then
  Begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;


procedure TFr_Pedido_Vda.Pc_EstadoEdicaoOrdem;
Begin
  //Cabeçalho do Pedido
  Pnl_Fundo.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  //botos aba produto
  Sb_Ins_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (Qr_ItensVda.RecordCount > 0);
  Sb_Exc_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (Qr_ItensVda.RecordCount > 0);
  Sb_InclusaoRapido.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );

  //botos aba servico
  Sb_Ins_Servico.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Servico.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_ItensSrv.RecordCount > 0);
  Sb_Exc_Servico.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_ItensSrv.RecordCount > 0);
  Sb_Servico.Enabled       := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Tecnico.Enabled       := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_ItensSrv.RecordCount > 0);

  //botos aba DEVOLUCAO
  Sb_Ins_Devolucao.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Devolucao.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_ItensDev.RecordCount > 0);
  Sb_Exc_Devolucao.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_ItensDev.RecordCount > 0);

  //botos aba TROCA
  Sb_Ins_Troca.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Troca.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_ItensTro.RecordCount > 0);
  Sb_Exc_Troca.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_ItensTro.RecordCount > 0);

// botoes gerais
  SB_Inserir.Enabled       := (It_Edicao_Ordem = 'B') and It_Inserir;
  SB_Excluir.Enabled       := (It_Edicao_Ordem = 'B') and It_Excluir and (Pedido.Registro.Codigo > 0);
  Sb_Enviar.Enabled      := (It_Edicao_Ordem = 'B') and It_IMPRIMIR;
  SB_Faturar.Enabled       := (It_Edicao_Ordem = 'B') and It_Faturar;
  SB_Alterar.Enabled       := (It_Edicao_Ordem = 'B') and It_Alterar and (Pedido.Registro.Codigo > 0);
  SB_Gravar.Enabled        := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  SB_Cancelar.Enabled      := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Pesquisar.Enabled     := (It_Edicao_Ordem = 'B');
  Sb_Sair_0.Enabled        := (It_Edicao_Ordem = 'B');
  Sb_Vend_Comissao.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) And (Qr_ItensVda.RecordCount > 0);
  If  DBLCB_Prazo.Visible = true then DBLCB_Prazo.Enabled    :=  Fm_FormaPagto.DBLCB_FormaPagto.Enabled;
  Pc_controlaEdicaoCliente;
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) THEN Pc_controlaEdicaoVendedor;
  Pnl_Observacao.Enabled        := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_entrega.Enabled           := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_Informacoes.Enabled       := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  RegistraNmerodeLote.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  RegistraNmerodeSerie.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  InformarNmerodeCompra.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  MnuCustodoPedido.Enabled      := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  MnuAcompanhamento.Enabled      := ( It_Edicao_Ordem = 'B') ;
end;



procedure TFr_Pedido_Vda.SB_ServicoClick(Sender: TObject);
Begin
  if pedido.Registro.Codigo = 0 then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
  end;
  Pc_GeraNumeroPedido;
  AbrirOrdemServico;
end;

procedure TFr_Pedido_Vda.SB_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  If trim(DBLCB_Empresa.Text) <> '' then
  Begin
    Lc_Retorno := Fc_AbreTelaCliente(DBLCB_Empresa.KeyValue);
    Fm_VendedorPedido.ListaVendedor;
    if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
    begin
      E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
      DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
      Pedido.Registro.Empresa := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
      DBLCB_EmpresaExit(Self);
    end;
    if (Fm_VendedorPedido.DBLCB_Vendedor.CanFocus) then
    Begin
      Fm_VendedorPedido.DBLCB_Vendedor.SetFocus
    end
    else
    Begin
      if (Fm_FormaPagto.DBLCB_FormaPagto.CanFocus) then
        Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    end;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Confirma_TabelaPrecoClick(Sender: TObject);
begin
  if ValidaTrocaTabela then
  Begin
    TrocaTabela(Fm_ListaTabelaPreco.Dblcb_Lista.KeyValue);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    ControleElementos(True);
    Pc_Gravar;
  End;
end;

procedure TFr_Pedido_Vda.Sb_PesquisarClick(Sender: TObject);
Begin
  Pedido.using('L');
  Pc_AtivaEstabelecimento;
  Fm_ListaVendedores.ListaVendedor;
  Pc_Buscar;
  Pg_Pedido_Vda.ActivePageIndex := 1;      
end;

procedure TFr_Pedido_Vda.FormKeyDown(Sender: TObject; var Key: Word;
  ShIft: TShIftState);
Begin
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) then
  Begin
    case PG_Itens.ActivePageIndex of
      0:Begin
        If shIft = [] then
          Begin
            case Key of
            VK_F2  : If Sb_Ins_Produto.Enabled then Sb_Ins_ProdutoClick(Sender);
            VK_F3  : If Sb_Alt_Produto.Enabled then Sb_Alt_ProdutoClick(Sender);
            VK_F4  : If Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
            end;
          end;
        end;
      1:Begin
        If shIft = [] then
          Begin
            case Key of
            VK_F2  : If Sb_Ins_Servico.Enabled then Sb_Ins_ServicoClick(Sender);
            VK_F3  : If Sb_Alt_Servico.Enabled then Sb_Alt_ServicoClick(Sender);
            VK_F4  : If Sb_Exc_Servico.Enabled then Sb_Exc_ServicoClick(Sender);
            VK_F8  : If Sb_Servico.Enabled then SB_ServicoClick(Sender);
            VK_F9  : If Sb_Tecnico.Enabled then Sb_TecnicoClick(Sender)
            end;
          end;
        end;
     end;
    end;
 case Pg_Pedido_Vda.ActivePageIndex of
  0:Begin
    If shIft = [] then
      Begin
        case Key of
        VK_F2  : If SB_Inserir.Enabled then SB_InserirClick(Sender);
        VK_F3  : If SB_Alterar.Enabled then SB_AlterarClick(Sender);
        VK_F4  : If SB_Excluir.Enabled then SB_ExcluirClick(Sender);
        VK_F5  : If SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : If SB_Cancelar.Enabled then SB_CancelarClick(Sender);
        VK_F7  : If SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
        VK_F10  : If SB_Faturar.Enabled then SB_FaturarClick(Sender);
        VK_F11  : If Sb_Enviar.Enabled then Sb_EnviarClick(Sender);
        VK_Escape : If Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end
  else
    Begin
    If shIft = [] then
      Begin
      case Key of
      VK_F2  : If SB_Cadastrar.Enabled then SB_CadastrarClick(Sender);
      VK_F7  : If SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8 : If SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : If Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
      end;
    end;
  end;
end;

procedure TFr_Pedido_Vda.tbs_PesquisaShow(Sender: TObject);
Begin
  If E_BuscaPedido.CanFocus then E_BuscaPedido.SetFocus;
  E_BuscaPedido.SelectAll;
  Pop_ConfigLocal.Visible := True;
  Pop_ConfigGlobal.Visible := True;
  MnuLucratividade.Visible := False;
  MnuCustodoPedido.Visible := False;
  MnuAcompanhamento.Visible := False;
  MnuSeparao.Visible := False;
  MnuEnviaPedido.Visible := False;
  MnuOperaesemGrupo.Visible := True;
end;

procedure TFr_Pedido_Vda.Pc_AbrePedidoNovo;
Begin
  Pc_AtivarTabelas;
  Pedido.using('L');
  Pc_LimpaCampos;
  Pc_IniciaVariaveis;
  Fm_VendedorPedido.ListaVendedor;
  If Gb_Cd_Vendedor >0 then
    Fm_VendedorPedido.DBLCB_Vendedor.KeyValue := Gb_Cd_Vendedor
  else
    Fm_VendedorPedido.DBLCB_Vendedor.KeyValue := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_CODVDOR').AsInteger;
  Pc_AtualizaCampos;
  Pc_Totalizador;
  It_Edicao_Ordem := 'I';
  Pc_EstadoEdicaoOrdem;
  E_Cd_Empresa.SetFocus;
end;



procedure TFr_Pedido_Vda.SB_InserirClick(Sender: TObject);
Var
  Lc_Codigo : Integer;
Begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja mesmo abrir um novo Pedido.'+EOLN+EOLN+
                     'Confirmar a Abertura ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  Begin
    if (Fc_Tb_Geral('L','VDA_G_COPIA_PEDIDO', 'N') = 'S') then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Deseja efetuar uma cópia de Pedido/Nota existente.'+EOLN+EOLN+
                         'Confirmar a Cópia ?',
                        [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
      begin
        Lc_Codigo := Fc_CopiaPedidoNota(1);
        if Lc_codigo > 0 then
        Begin
          Pc_LimpaCampos;
          Pc_IniciaVariaveis;
          Pedido.Registro.codigo := Lc_Codigo;
          Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
          Pc_Visualizar;
        End;
      end
      else
      Begin
        Pc_AbrePedidoNovo;
      end;
    end
    else
    Begin
        Pc_AbrePedidoNovo;
    end;
    It_Edicao_Ordem := 'I';
    Pc_EstadoEdicaoOrdem;
  end;
end;

function TFr_Pedido_Vda.Fc_ValidaAlteracao():Boolean;
Begin
  Result := True;
  if Pedido.verificaFaturado(True) then
  Begin
    Result := False;
    exit;
  end;

  if Pedido.InconsistenciaFaturado(true) then
  BEgin
    Result := False;
    exit;
  end;

  if VerificaDespachadoLancado then
  Begin
    Result := False;
    Exit;
  End;

//  if (Pedido.Registro.Tipo = 4) then
//  Begin
//    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
//                   'Este Pedido foi feita na Loja Virtual ' + EOLN +
//                   'e não pode ser alterado' + EOLN,
//                   ['OK'], [bEscape], mpAlerta);
//    Result := False;
//  End;

end;


procedure TFr_Pedido_Vda.SB_AlterarClick(Sender: TObject);
Begin
  if Fc_ValidaAlteracao then
  Begin
    It_Edicao_Ordem := 'E';
    Pc_EstadoEdicaoOrdem;
    Pc_DefineSetfocus;
  end;
end;

procedure TFr_Pedido_Vda.SB_EnviarClick(Sender: TObject);
var
  Lc_Escolha : Integer;
begin
  if ValidaEnvio then
  Begin
    Try
      Self.Enabled := False;
      Pc_GeraNumeroPedido;
      Pc_GravaCredito;
      Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                    'Deseja enviar para?',
                                    [' IMPRESSORA ', ' E-MAIL ', ' CANCELA '], [bNormal, bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
      case Lc_Escolha of
        0:if valida_impressao then Envia_impressao;
        1:if valida_email then Envia_email;
      end;
    Finally
      Self.Enabled := True;
    End;
  End;
end;

procedure TFr_Pedido_Vda.SB_ExcluirClick(Sender: TObject);
Begin
  if ValidaExluirPedido then
    ExluirPedido;



end;

procedure TFr_Pedido_Vda.SB_GravarClick(Sender: TObject);
Begin
  If Fc_ValidaGravacao then
  Begin
    Screen.Cursor := crHourGlass;
    Pc_Totalizador;
    Pc_Gravar;
    verificaBaseTroca;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
    Screen.Cursor := crDefault;
  end;
end;

Function TFr_Pedido_Vda.Fc_ValidaCancelameto():Boolean;
Begin
  Result := True;
  if not Fc_ValidaParcelamentoPedido then
    Begin
    Result:=FALSE;
    exit;
    end;

  If E_Aq_Desconto.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;
  if E_VL_Desconto.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;
  If E_Nr_Parcelas.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;    
end;

procedure TFr_Pedido_Vda.SB_CancelarClick(Sender: TObject);
Begin
  if Fc_ValidaCancelameto then
  Begin
    It_Edicao_Ordem := 'B';
    if FAbrirNovo then
    Begin
      Self.Close;
    End
    else
    Begin
      If ( It_Edicao_Ordem = 'I' ) then
        Sb_PesquisarClick(sELF);
      Pc_EstadoEdicaoOrdem;
    End;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Cancela_TabelaPrecoClick(Sender: TObject);
begin
  ControleElementos(True);
end;

procedure TFr_Pedido_Vda.Sb_Sair_0Click(Sender: TObject);
Begin
  Close;
end;

procedure TFr_Pedido_Vda.SB_CadastrarClick(Sender: TObject);
Var
  Lc_Codigo : Integer;
Begin
  if (Fc_Tb_Geral('L','VDA_G_COPIA_PEDIDO', 'N') = 'S') then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja efetuar uma cópia de Pedido/Nota existente.'+EOLN+EOLN+
                       'Confirmar a Cópia ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
      Lc_Codigo := Fc_CopiaPedidoNota(1);
      if Lc_Codigo > 0 then
      BEgin
        Pc_LimpaCampos;
        Pc_IniciaVariaveis;
        Fm_VendedorPedido.ListaVendedor;
        Pedido.Registro.codigo := Lc_Codigo;
        Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
        Pc_Visualizar;
      End;
    end
    else
    Begin
      Pg_Pedido_Vda.ActivePage := tbs_pedido;
      Pc_AbrePedidoNovo;
    end;
  end
  else
  Begin
    Pg_Pedido_Vda.ActivePage := tbs_pedido;
    Pc_AbrePedidoNovo;
  end;
end;

procedure TFr_Pedido_Vda.SB_BuscarClick(Sender: TObject);
Begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    SB_Cadastrar.Enabled  := False;
    SB_Buscar.Enabled     := False;
    SB_Visualizar.Enabled := False;
    Sb_Sair_1.Enabled     := False;
    If DM.IBT_Consulta.InTransaction THEN DM.IBT_Consulta.Commit;
    Pc_Buscar;
    Pc_SomaPedidos;
  Finally
    ChBx_BuscaPedidoAndroid.Checked := False;
    Pc_ProcesoAguarde(Self,'F');
    SB_Cadastrar.Enabled  := It_Inserir;
    SB_Buscar.Enabled     := True;
    SB_Visualizar.Enabled := True;
    Sb_Sair_1.Enabled     := True;
  end;
end;

procedure TFr_Pedido_Vda.Pc_SomaPedidos;
Var
  Lc_Valor : Real;
Begin
  try
    DBG_Pesquisa.Visible := False;
    with Qr_Pesquisa do
    Begin
      Lc_Valor := 0;
      First;
      while not eof do
      Begin
        Lc_Valor := Lc_Valor + FieldByname('PED_VL_PEDIDO').AsCurrency;
        Next;
      end;
      E_TotalVenda.Caption := FloatToStrF(Lc_Valor,ffNumber,10,2);
      First;
    end;
  finally
    DBG_Pesquisa.Visible := True;
  end;
end;

procedure TFr_Pedido_Vda.SB_VisualizarClick(Sender: TObject);
Begin
  if validavisualizar then
  begin
    Pc_Visualizar;
    Pc_UtitilzaCredito;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Sair_1Click(Sender: TObject);
Begin
  Close;
end;

Function TFr_Pedido_Vda.Fc_DefineTabela():String;
Begin
  Result := 'A';
  if E_Nr_Parcelas.Visible = true then
  begin
    if E_Nr_Parcelas.Text = '000' then
      Result := 'V'
    else
      Result := 'P'
  end
  else
  Begin
    if (COPY(DBLCB_Prazo.Text,1,3) = '000') then
      Result := 'V'
    else
      Result := 'P'
  end;
end;

function TFr_Pedido_Vda.Fc_DefineTipoPessoa: String;
begin
  {Tipo de Combinação
      JR - Juridica Revenda
      JC - Juridica Consumidor
      FC - Consumidor
  }

  with DM_ListaConsultas do
  Begin
    if ( Qr_ListaCliente.FieldByName('EMP_PESSOA').AsString = 'J' ) then
    Begin
      if ( Qr_ListaCliente.FieldByName('EMP_CONSUMIDOR').AsString = 'S' ) then
        Result := 'C'
      else
        Result := 'R'
    End
    else
    Begin
      Result := 'C'
    End;
  End;
end;

procedure TFr_Pedido_Vda.Sb_Ins_ProdutoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_Vda;
begin
  If E_Cd_Empresa.Focused  then E_Cd_EmpresaExit(self);
  If DBLCB_Empresa.Focused then DBLCB_EmpresaExit(Self);
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao Then
    Begin
      Pc_Gravar;
      It_Edicao_Ordem := 'E';
    End
    else
      Exit;
  end;
  try
    //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_Vda.Create(nil);
    Lc_Form.it_Cd_Empresa := StrToIntDef(E_Cd_Empresa.text,0);
    Lc_Form.Pc_StateChange(2);
    if trim(Fm_VendedorPedido.DBLCB_Vendedor.Text)<>'' then
      Lc_Form.It_Cd_Vendedor := Fm_VendedorPedido.DBLCB_Vendedor.KeyValue;
    Lc_Form.It_MultiplicadorPreco :=  DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
    Lc_Form.ItensNFL.Registro.CodigoPedido := pedido.Registro.Codigo;
    Lc_Form.Terminal := pedido.Registro.Terminal;
    Lc_Form.E_Qt_Produto.Text := '1';
    Lc_Form.it_Modalidade_preco := Fc_DefineTabela;
    Lc_Form.it_TipoCliente := Fc_DefineTipoPessoa;
    Lc_Form.It_Dt_Operacao := E_Data.Date;
    Lc_Form.LoadItems(Qr_ItensVda);
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'S';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Pc_DinheiroFormaPgt;

    Pc_AtualizaCampos;
    Pc_Totalizador;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_descontoAutomatico;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Alt_ProdutoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_Vda;
begin
  try
  //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_Vda.Create(nil);
    Lc_Form.it_Cd_Empresa := StrToIntDef(E_Cd_Empresa.text,0);
    Lc_Form.Pc_StateChange(3);
    Lc_Form.It_Inserir := True;
    if trim(Fm_VendedorPedido.DBLCB_Vendedor.Text)<>'' then
      Lc_Form.It_Cd_Vendedor := Fm_VendedorPedido.DBLCB_Vendedor.KeyValue;
    Lc_Form.It_MultiplicadorPreco := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
    Lc_Form.ItensNFL.Registro.CodigoPedido := pedido.Registro.Codigo;
    Lc_Form.Terminal := pedido.Registro.Terminal;
    Lc_Form.Fm_ListaEstoques.AtivaLista(Gb_CodMha);

    Lc_Form.editItems(Qr_ItensVdaITF_CODIGO.AsInteger );
    Lc_Form.Pc_Totalizador;

    Lc_Form.Qr_Tabela.Active := True;
    Lc_Form.it_Modalidade_preco := Fc_DefineTabela;
    Lc_Form.it_TipoCliente := Fc_DefineTipoPessoa;
    Lc_Form.It_Dt_Operacao := E_Data.Date;
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'S';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);

    Pc_AtualizaCampos;
    Pc_Totalizador;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_descontoAutomatico;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Exc_ProdutoClick(Sender: TObject);
Var
  Lc_Lst_Lote:TStringList;
Begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+Qr_ItensVda.FieldByName('PRO_DESCRICAO').AsString +' desta venda.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Try
      Pc_Log_Sistema(Gb_CodMha,
                     GB_Cd_Usuario,
                     Now,
                     'Item do Pedido Venda',
                     Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger,
                     'Excluir Item',
                     'Produto '+ Qr_ItensVda.FieldByName('ITF_CODPRO').AsString +
                     ' do pedido Nº ' + IntToStr(pedido.Registro.Numero)  );

      CtrlLote.Movimento.Registro.Vinculo := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
      CtrlLote.Movimento.Registro.Tipo := 'VENDA';
      CtrlLote.Movimento.Registro.Sentido := 'E';
      CtrlLote.Movimento.deleteByVinculo;
      Pc_Delete_Estoque('P',0,Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger);
      //Atualiza estoque na internet
      if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
      Begin
         Case Gb_Cd_Wsr of
          2:Pc_Ws_Estoque('I',Fc_BuscaCodigoEstoqueProduto(Qr_ItensVda.fieldbyName('ITF_CODEST').AsInteger,Qr_ItensVda.fieldbyName('ITF_CODPRO').AsInteger));
         End;
      End;

      if (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') then
      Begin
        Pc_SeparacaoMercadoria(Qr_ItensVda.FieldByName('ITF_CODPED').AsInteger,
                               Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger,
                               Qr_ItensVda.FieldByName('ITF_CODPRO').AsInteger,
                               pedido.Registro.Data,
                               0);
      end;
      Pedido.Itens.BaseTroca.Registro.Item := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
      Pedido.Itens.BaseTroca.delete;

      Pedido.Itens.Registro.Codigo := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
      Pedido.Itens.delete;
      pedido.CorrigirSequenciaItens;
      Pc_AtualizaCampos;
      Pc_Totalizador;
      PC_Sel_PrazoPagto(It_bloqueio);
      Pc_Gravar;
      Pc_EstadoEdicaoOrdem;
    Finally
      FreeAndNil(Lc_Lst_Lote);
    End;
  end;
end;

function TFr_Pedido_Vda.ValidaCancelaDespacho: boolean;
begin
  Result := true;
  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;

  Pedido.Despacho.Registro.Pedido := Pedido.Registro.Codigo;
  if Pedido.Despacho.ItensDespachados then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este Pedido tem registro de itens despachados.' + EOLN +
                   'Para altera-lo é preciso retornar o despacho do item' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
  End;

end;

Function TFr_Pedido_Vda.ValidaEnvio():Boolean;
Begin
  Result := True;
  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;
  if not Fc_ValidasPrecoeParcelamento then
  Begin
    Result:=FALSE;
    exit;
  end;

end;

function TFr_Pedido_Vda.ValidaEnvioPedidoParaDespacho: Boolean;
begin
  REsult := true;
  //Verifica se o controle de de Despacho está ativado
  if (Fc_Tb_Geral('L','DSP_G_CTRL_DESPACHO','') <> 'S')  then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Módulo de despacho não configurado' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;

  if VerificaDespachadoLancado then
  Begin
    Result := False;
    Exit;
  End;
end;

function TFr_Pedido_Vda.ValidaExluirPedido: boolean;
begin
  Result := True;
  if VerificaDespachadoLancado then
  Begin
    Result := False;
    Exit;
  End;


  if Pedido.verificaFaturado(True) then
  Begin
    Result := False;
    Exit;
  End;

  If (MensagemPadrao(TITULO_CONFIRMACAO,
                    'Deseja realmente excluir este Pedido.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                     [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

end;

procedure TFr_Pedido_Vda.Sb_InclusaoRapidoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  If (E_Cd_Empresa.Focused) OR (DBLCB_Empresa.Focused) then exit;
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;
  Try
    Lc_Form := TFr_Pesq_Produto.Create(nil);
    Lc_Form.CodigoPedido := Pedido.Registro.Codigo;
    Lc_Form.It_Pedido_Vda := True;
    Lc_Form.it_TipoCliente := Fc_DefineTipoPessoa;
    Lc_Form.SB_Visualizar.Visible := False;
    Lc_Form.Pc_Tabelas_Disponiveis;
    Lc_Form.E_BuscaCodigo.clear;
    Lc_Form.E_BuscaDescricao.Clear;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    Pc_DinheiroFormaPgt;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_descontoAutomatico;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  End;
end;

procedure TFr_Pedido_Vda.Pc_ChamaFatura;
Begin
  Pc_ChamaFaturaVda;
  EXIT;
  if not Qr_ItensVda.active then Qr_ItensVda.active := True;
  Qr_ItensVda.FetchAll;
  if (Fc_Tb_Geral('L','OSR_G_NFSE_CONJ','N') = 'S') then
  Begin
    Pc_ChamaFaturaVda;
  end
  else
  Begin
    Qr_ItensVda.FetchAll;
    IF (Qr_ItensVda.RecordCount > 0) then Pc_ChamaFaturaVda;
    Qr_ItensSrv.FetchAll;
    IF (Qr_ItensSrv.RecordCount > 0) then Pc_ChamaFaturaSrv;
  end;
end;

procedure TFr_Pedido_Vda.Pc_ChamaFaturaVda;
Var
  Lc_Form : TFr_Fatura_Vda;
Begin
  Try
    Lc_Form := TFr_Fatura_Vda.Create(nil);
    Lc_Form.It_Dt_Entrega := pedido.Registro.Data;
    Lc_Form.It_Cd_Pedido := pedido.Registro.Codigo;
    Lc_Form.It_Nr_Pedido := E_Nr_Pedido.Text;
    Lc_Form.It_Vl_Devolucao  := StrToFloatDef(E_Vl_Devolucao.Caption,0);
    //Observação do Cliente que vai na Nota
    Lc_Form.E_Obs.Lines.Clear;
    Lc_Form.E_Obs.Lines.Add(Fc_ObsEmpresaNotaFiscal(pedido.Registro.Empresa));
    //Transportador padrão do cliente
    Lc_Form.DBLCB_Transportadora.KeyValue := Fc_Preenche_Transportadora(pedido.Registro.Empresa);
    //Totalizadores
    Lc_Form.E_VL_Bs_ICMS.Text := '0,00';
    Lc_Form.E_VL_ICMS.Text := '0,00';
    Lc_Form.E_Vl_Bs_Icms_St.Text := '0,00';
    Lc_Form.E_Vl_Icms_St.Text := '0,00';
    Lc_Form.E_VL_Produto.Caption := E_VL_Produto.Caption;
    Lc_Form.E_VL_Servico.Caption := E_Vl_Servico.Caption;
    Lc_Form.E_VL_Nota.Caption := E_VL_Pedido.Caption;
    Lc_Form.E_VL_Frete.Text := E_VL_Frete.Text;
    Lc_Form.E_Vl_Seguro.Text := '0,00';
    Lc_Form.E_Vl_Outras.Text := FloatToStrF( StrToFloatDef(E_Vl_Despesa.Text,0) + StrToFloatDef(E_Vl_St.Text,0) , ffFixed,10,2);
    Lc_Form.E_Vl_desconto.Caption := E_VL_Desconto.Text;
    Lc_Form.E_VL_IPI.Text := E_VL_IPI.Caption;
    Lc_Form.ShowModal;
    It_Fatura_Ok := Lc_Form.it_fatura_ok;

  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Pedido_Vda.Envia_Impressao;
Var
  Lc_Imp : TimpModImpressao;
Begin
  try
    Lc_Imp := TimpModImpressao.create(nil);
    Lc_Imp.Pc_Imp_Tipo(pedido.Registro.Tipo,pedido.Registro.Codigo,0);
  finally
    FreeAndNil(Lc_Imp);
  end;
end;

procedure TFr_Pedido_Vda.Pc_ChamaFaturaSrv;
Var
  Lc_Form : TFr_Fatura_Srv;
Begin
  Try
    Lc_Form := TFr_Fatura_Srv.Create(nil);
    Lc_Form.It_Cd_Pedido := pedido.Registro.Codigo;
    Lc_Form.It_Nr_Pedido := E_Nr_Pedido.Text;
    //Observação do Cliente que vai na Nota
    Lc_Form.E_Obs.Lines.Clear;
    Lc_Form.E_Obs.Lines.Add(Fc_ObsEmpresaNotaFiscal(pedido.Registro.Empresa));
    //Transportador padrão do cliente

    //Totalizadores
    Lc_Form.E_VL_Bs_ISS.Text := '0,00';
    Lc_Form.E_VL_ISS.Text := '0,00';
    Lc_Form.E_Vl_ISS_retido.Text := '0,00';
    Lc_Form.E_VL_Nota.Caption := E_Vl_Servico.Caption;
    Lc_Form.ShowModal;
    It_Fatura_Ok := Lc_Form.it_fatura_ok;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Pedido_Vda.SB_FaturarClick(Sender: TObject);
Begin
  If Fc_ValidaFaturamento then
  Begin
    It_Fatura_Ok := False;
    Pc_GeraNumeroPedido;
    If It_NFCe then //and not Gb_PAF_NFE_E then
    Begin
      Pc_EscolheFaturamento;
    end
    else
    Begin
      Pc_ChamaFatura;
    end;
    //VerIfica se o faturamento deu certo
    If It_Fatura_Ok then
    Begin
      Pg_Pedido_Vda.ActivePageIndex := 1;
      Timer_deve.Enabled := False;
      Pedido.using('L');
      Pc_LimpaCampos;
      Pc_IniciaVariaveis;
      SB_BuscarClick(Self);
    end
    else
    Begin
      Pc_AtivarTabelas;
      Pc_AbrirPedido;
      Pg_Pedido_Vda.ActivePageIndex := 0;
    end;
  end;
end;

procedure TFr_Pedido_Vda.DBLCB_EmpresaExit(Sender: TObject);
Begin
  If ( (It_Edicao_Ordem = 'I') or (It_Edicao_Ordem = 'E') ) then  //Inicio verIfica edição
  Begin
    If trim(DBLCB_Empresa.Text) <> '' THEN
    Begin
      E_Cd_Empresa.Text := IntToStr(DBLCB_Empresa.KeyValue);
      It_bloqueio := Fc_VerIficaBloqueioCliente(DBLCB_Empresa.KeyValue);
      Pc_Sel_Endereco(DBLCB_Empresa.KeyValue);
      Pc_Valida_Info_cliente(DBLCB_Empresa.KeyValue);
      PC_Sel_FormPagto(It_bloqueio);
      PC_Sel_PrazoPagto(It_bloqueio);
      Cliente_Valida_Limite(DBLCB_Empresa.KeyValue,Fm_FormaPagto.DBLCB_FormaPagto.KeyValue,StrtofloatDef(E_VL_Pedido.Caption,0));
      Pc_Historico('1',DBLCB_Empresa.KeyValue);
      Pc_Aniversario(DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_DT_FUNDA').AsString);
    end
    else
    Begin
      pedido.Registro.Empresa := 0;
      E_Cd_Empresa.Clear;
    end;
  end;
end;

procedure TFr_Pedido_Vda.Pc_Sel_Endereco(Pc_Cd_Cliente : Integer);
Begin
 //Posiciona o ponteiro no endereco do cliente
  with Qr_endereco do
  Begin
    Close;
    ParamByName('EMP_CODIGO').AsInteger := Pc_Cd_Cliente;
    Active := True;
    FetchAll;
    First;
    If  (It_Edicao_Ordem = 'I')  or (pedido.Registro.Empresa <> Pc_Cd_Cliente) or (DBLCB_end_Entrega.Text = '') then
    Begin
      pedido.Registro.Endereco := FieldByName('end_CODIGO').AsInteger;
      DBLCB_end_Entrega.KeyValue := pedido.Registro.Endereco;
    end;
  End;
end;

procedure TFr_Pedido_Vda.Pc_Valida_Info_cliente(Pc_Cd_Cliente : Integer);
Begin
  //Devolver verdadeiro se o cadastro estiver completo
  If Fc_VerIfica_Cadastro_Cliente(Pc_Cd_Cliente) then
  Begin
    If (It_Edicao_Ordem = 'I' ) then
    Begin
      if FUtilizaVendedorCliente then
        pedido.Registro.Vendedor := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_CODVDOR').AsInteger
      else
      If Gb_Cd_Vendedor >0 then
        pedido.Registro.Vendedor := Gb_Cd_Vendedor
      else
        pedido.Registro.Vendedor := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_CODVDOR').AsInteger;

     Fm_VendedorPedido.DBLCB_Vendedor.KeyValue := pedido.Registro.Vendedor;
    end;
  end;
  If Fm_VendedorPedido.DBLCB_Vendedor.CanFocus then Fm_VendedorPedido.DBLCB_Vendedor.SetFocus;
end;


procedure TFr_Pedido_Vda.Sb_Ins_ServicoClick(Sender: TObject);
Var
  Lc_FrVehicleSo : TFr_VehicleSo;
  Lc_FrItensServico : TFr_Itens_Servico;
Label
  InsOrdem;
begin
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      exit;
  end;
InsOrdem:
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('PED_CODIGO').AsInteger := Pedido.Registro.Codigo;
  Qr_Ordem.Active := True;
  Qr_Ordem.FetchAll;
  If (Fc_Tb_Geral('L', 'OSR_G_PREENCHE_VEI', 'S') = 'S') and (Qr_Ordem.RecordCount = 0) then
  Begin
    Lc_FrVehicleSo := TFr_VehicleSo.Create(nil);
    TRy
      with Lc_FrVehicleSo do
      begin
        with OrdemServico do
        Begin
          Registro.CodigoEstabelecimento := Gb_Codmha;
          Registro.CodigoCotacao := 0;
          Registro.CodigoPedido := Pedido.Registro.Codigo;
          with Vehicle do
          Begin
            Registro.CodigoEmpresa := Pedido.Registro.Empresa;
          End;
        End;
        ShowModal;
      End;
    Finally
      FreeAndNil(Lc_FrVehicleSo);
    End;
    goto InsOrdem;
  end;

  Lc_FrItensServico := TFr_Itens_Servico.create(self);
  Try
    if trim(Fm_VendedorPedido.DBLCB_Vendedor.Text)<>'' then
      Lc_FrItensServico.It_Cd_Vendedor := Fm_VendedorPedido.DBLCB_Vendedor.KeyValue;
    Lc_FrItensServico.It_Pedido_Vda := True;
    Lc_FrItensServico.it_Cd_Empresa := pedido.Registro.Empresa;
    Lc_FrItensServico.Pc_StateChange(2);
    If  (It_Edicao_Ordem = 'I')   then
    Begin
      Pc_Gravar;
    end;
    Lc_FrItensServico.It_MultiplicadorPreco := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
    Lc_FrItensServico.It_Cd_Pedido := pedido.Registro.Codigo;
    Lc_FrItensServico.It_Aliq_Comissao := 0;
    Lc_FrItensServico.E_Qt_Servico.Text := '1';
    Lc_FrItensServico.ShowModal;
  Finally
    FreeAndNil(Lc_FrItensServico);
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  End;
end;

procedure TFr_Pedido_Vda.Sb_Alt_ServicoClick(Sender: TObject);
Var
  Lc_Form:TForm;
begin
  //Cria O Formulario
  Lc_Form := TForm.Create(Fr_Itens_Servico);
  Application.CreateForm(TFr_Itens_Servico, Lc_Form);
  TFr_Itens_Servico(Lc_Form).It_Pedido_Vda := True;
  TFr_Itens_Servico(Lc_Form).Pc_StateChange(3);
  TFr_Itens_Servico(Lc_Form).It_Inserir := True;
  TFr_Itens_Servico(Lc_Form).It_MultiplicadorPreco := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
  TFr_Itens_Servico(Lc_Form).It_Cd_Pedido := pedido.Registro.Codigo;
  if trim(Fm_VendedorPedido.DBLCB_Vendedor.Text)<>'' then
    TFr_Itens_Servico(Lc_Form).It_Cd_Vendedor := Fm_VendedorPedido.DBLCB_Vendedor.KeyValue;
  TFr_Itens_Servico(Lc_Form).It_Cd_Itens := Qr_ItensSrv.FieldByName('ITF_CODIGO').AsInteger;
  TFr_Itens_Servico(Lc_Form).it_Cd_Empresa := Qr_ItensSrv.FieldByName('ITF_CODPRO').AsInteger;
  TFr_Itens_Servico(Lc_Form).E_Cd_Servico.Text := Qr_ItensSrv.FieldByName('ITF_CODPRO').AsString;
  TFr_Itens_Servico(Lc_Form).It_Cd_Servico := Qr_ItensSrv.FieldByName('ITF_CODPRO').AsInteger;
  TFr_Itens_Servico(Lc_Form).E_Descricao.Text := Qr_ItensSrv.FieldByName('PRO_DESCRICAO').AsString;
  TFr_Itens_Servico(Lc_Form).E_Vl_Unitario.Text := FloatToStrF(Qr_ItensSrv.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
  TFr_Itens_Servico(Lc_Form).E_Qt_Servico.Text := FloatToStr(Qr_ItensSrv.FieldByName('ITF_QTDE').AsFloat);
  TFr_Itens_Servico(Lc_Form).E_Unidade.Text := Qr_ItensSrv.FieldByName('MED_ABREVIATURA').AsString;
  TFr_Itens_Servico(Lc_Form).E_Aq_Com.Text := FloatToStrF(Qr_ItensSrv.FieldByName('ITF_AQ_COM').AsFloat,ffFixed,10,2);
  TFr_Itens_Servico(Lc_Form).E_Aq_Desconto.Text :=FloatToStrF(Qr_ItensSrv.FieldByName('ITF_AQ_DESC').AsFloat,ffFixed,10,2);
  TFr_Itens_Servico(Lc_Form).E_VL_Desconto.Text := FloatToStrF(Qr_ItensSrv.FieldByName('ITF_VL_DESC').AsCurrency,ffFixed,10,2);
  TFr_Itens_Servico(Lc_Form).Pc_Totalizador;
  Try
    TFr_Itens_Servico(Lc_Form).ShowModal;
  Finally
  FreeAndNil(Lc_Form);
  PC_Sel_PrazoPagto(It_bloqueio);
  Pc_AtualizaCampos;
  Pc_Totalizador;
  Pc_Gravar;
  Pc_EstadoEdicaoOrdem;
  End;
end;

procedure TFr_Pedido_Vda.Sb_Exc_ServicoClick(Sender: TObject);
Begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+Qr_ItensSrv.FieldByName('PRO_DESCRICAO').AsString +' desta venda.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
    Pedido.Itens.Registro.Codigo := Qr_ItensSrv.FieldByName('ITF_CODIGO').AsInteger;
    Pedido.Itens.delete;
    Qr_ItensSrv.Active := False;
    Qr_ItensSrv.paramByName('PED_CODIGO').AsInteger := pedido.Registro.Codigo;
    Qr_ItensSrv.Active := True;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Pedido_Vda.DBG_ServicosKeyDown(Sender: TObject;
  var Key: Word; ShIft: TShIftState);
Begin
  If ShIft = [] then
  case Key of
    VK_delete  : If Sb_Exc_Servico.Enabled then Sb_Exc_ServicoClick(Sender);
  end;
end;

procedure TFr_Pedido_Vda.tbs_pedidoShow(Sender: TObject);
Begin
  PG_Itens.ActivePageIndex := 0;
  Pg_Observacao.ActivePageIndex := 0;
  Pc_ControlaNumero(E_Nr_Pedido,'VDA_G_CTRL_SEQUENCIA');
  Pop_ConfigLocal.Visible := False;
  Pop_ConfigGlobal.Visible := False;
  MnuLucratividade.Visible := True;
  MnuAcompanhamento.Visible := True;
  MnuCustodoPedido.Visible := True;
  MnuEnviaPedido.Visible := True;
  if MnuSeparao.Enabled then MnuSeparao.Visible := True;
  MnuEnviaPedido.Visible := True;
  MnuOperaesemGrupo.Visible := False;
end;

Function TFr_Pedido_Vda.Fc_ValidaInsereTecnicos():Boolean;
Begin
  Result := True;
  if (It_Edicao_Ordem = 'I')   then
  begin
    if Fc_ValidaGravacao then
    Begin
      Pc_Gravar;
    end
    else
    Begin
      Result := False;
      exit;
    end;
  end;

  if Qr_ItensSrv.RecordCount = 0 then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não há serviço registrado para incluir técnico.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
    end;
end;

procedure TFr_Pedido_Vda.Sb_TecnicoClick(Sender: TObject);
Var
  Lc_Form : TFr_Tecnicos;
begin
  IF Fc_ValidaInsereTecnicos then
  Begin
    try
      Lc_Form := TFr_Tecnicos.Create(nil);
      Lc_Form.It_Cd_Pedido :=  pedido.Registro.Codigo;
      Lc_Form.It_Cd_Item := Qr_ItensSrv.FieldByName('ITF_CODIGO').AsInteger;
      Lc_Form.It_Tp_Vinculo := 'P';
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;

procedure TFr_Pedido_Vda.Qr_enderecoAfterOpen(DataSet: TDataSet);
Begin
  Qr_endereco.FetchAll;
end;

procedure TFr_Pedido_Vda.Pc_IniciaVariaveis;
Begin
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  It_Cli_Consumidor := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  It_Usa_Nfe := Fc_VerificaFormularioDisponivel('Fr_GeraNFe');
  It_NFCe := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_VDA_NFCE', 'N') = 'S');
  FUtilizaVendedorCliente := ( Fc_Tb_Geral('L','VDA_G_VENDEDOR_CLIENTE','N') = 'S');
  //Indicador de presença do comprador no estabelecimento comercial no momento da operação
  Cb_IndPresComprador.ItemIndex := 2;

end;

procedure TFr_Pedido_Vda.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(SB_Gravar,'GRAVAR');
    CarregaImagemBotao(SB_Cancelar,'CANCELAR');
    CarregaImagemBotao(SB_Pesquisar,'PESQUISAR');
    CarregaImagemBotao(SB_Faturar,'FATURAR');
    //CarregaImagemBotao(Sb_Enviar,'IMPRIMIR'); troquei o icone por uma image de email
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
    CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    CarregaImagemBotao(Sb_Sair_1,'SAIR');
    CarregaImagemBotao(Sb_VoltaGrupo,'VOLTAR');
  END;
end;

procedure TFr_Pedido_Vda.FormShow(Sender: TObject);
Begin
  Pc_FormataTela;
  Pc_FormataPanels;
  Pc_IniciaVariaveis;
  If (Pedido.Registro.Codigo > 0) then
  Begin
    Pedido.getbyId;
    Pedido.using('B');
    Pc_AtivarTabelas;
    Pc_AbrirEndereco;
    Pc_AbrirPedido;
    Pg_Pedido_Vda.ActivePageIndex := 0;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end
  else
  Begin
    if FAbrirNovo then
    Begin
      Pg_Pedido_Vda.ActivePage := tbs_pedido;
      Pc_AbrePedidoNovo;
    End
    else
    Begin
      Pg_Pedido_Vda.ActivePageIndex:=1;
      Fm_ListaVendedores.ListaVendedor;
    End;
  End;
end;

function TFr_Pedido_Vda.GeraCorpoEmail: String;
begin
  Pc_AtivaEstabelecimento;
  Result  :=  '<body> '+
              '<html> '+
              '<table width="689" border="0" cellspacing="0" cellpadding="0">'+
              '  <tr>' ;
              if Pedido.Endereco.Registro.Contato <> '' then
                Result  := Result + '    <td> Olá ' + Pedido.Endereco.Registro.Contato + '</td>'
              else
                Result  := Result + '    <td> Aos cuidados do responsável' + '</td>';

  Result  := Result +
               '  </tr>' +
               '  <tr>' +
               '    <td><font color="#FFFFFF" size="1">.</font></td>' +
               '  </tr>' +
               '  <tr>' +
               '    <td>Segue em anexo o pedido registrado </td>'+
               '  </tr> '+
               '  <tr>' +
               '    <td><font color="#FFFFFF" size="1">.</font></td>' +
               '  </tr>' +
               '</table>' +
               Fc_GeraAssinaturaEmail +
               '</body> ' +
               '</html> ' ;
end;

procedure TFr_Pedido_Vda.ChBx_Busca_FantasiaClick(Sender: TObject);
Begin
  If ChBx_Busca_Fantasia.Checked then
    Begin
    ChBx_Busca_Nome.Checked := False;
    if not Qr_Pesquisa.Active then exit;
    DBG_Pesquisa.Columns[2].Title.Caption := 'Nome Fantasia';
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_FANTASIA';
  end;
end;

procedure TFr_Pedido_Vda.E_Cd_EmpresaExit(Sender: TObject);
Begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_Cd_Empresa.Text,0);
  If DBLCB_Empresa.CanFocus then DBLCB_Empresa.SetFocus;
end;

procedure TFr_Pedido_Vda.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; ShIft: TShIftState);
Begin
  If ShIft = [] then
  case Key of
  VK_delete  :
  Begin
    DBLCB_Empresa.KeyValue:=Null;
  end;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Fich_FinClick(Sender: TObject);
Var
  Lc_Form : TFr_Fich_Fin_Cli;
begin
  If trim(DBLCB_Empresa.Text) <> '' then
  Begin
    Try
      Lc_Form := TFr_Fich_Fin_Cli.Create(nil);
      Lc_Form.It_Cd_Cliente := pedido.Registro.Empresa;
      Lc_Form.It_Nm_Cliente := DBLCB_Empresa.Text;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Pedido_Vda.DBG_ProdutosDblClick(Sender: TObject);
Begin
  If Sb_Alt_Produto.Enabled then Sb_Alt_ProdutoClick(Self);
end;

procedure TFr_Pedido_Vda.DBG_ServicosDblClick(Sender: TObject);
Begin
  If Sb_Alt_Servico.Enabled then Sb_Alt_ServicoClick(Self);
end;

procedure TFr_Pedido_Vda.Timer_deveTimer(Sender: TObject);
Begin
  If Lb_Vl_Devedor.Visible then Lb_Vl_Devedor.Visible := False else Lb_Vl_Devedor.Visible := true;
end;

procedure TFr_Pedido_Vda.TrocaTabela(pCodigoTabela:Integer);
Var
  I : Integer;
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('SELECT PRC_VL_VDA '+
              'FROM TB_PRECO '+
              'WHERE (PRC_CODTPR =:PRC_CODTPR) '+
              ' AND ( PRC_CODPRO =:PRC_CODPRO) ');
    End;
    if not Qr_ItensVda.active then Qr_ItensVda.active := True;
    with Qr_ItensVda do
    Begin
      while not eof do
      Begin
        Lc_Qry.Active := False;
        Lc_Qry.ParamByName('PRC_CODTPR').AsInteger := pCodigoTabela;
        Lc_Qry.ParamByName('PRC_CODPRO').AsInteger := Qr_ItensVda.FieldByNAme('ITF_CODPRO').asInteger;
        Lc_Qry.Active := True;
        Lc_Qry.FetchAll;
        //Altera o valor Unitario
        Pedido.Itens.Registro.Codigo := Qr_ItensVda.FieldByNAme('ITF_CODIGO').asInteger;
        Pedido.Itens.getById;
        Pedido.Itens.Registro.CodigoTabela := pCodigoTabela;
        Pedido.Itens.Registro.ValorUnitario := Lc_Qry.FieldByName('PRC_VL_VDA').AsCurrency;
        Pedido.Itens.atualiza;
        next;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function TFr_Pedido_Vda.validaAcompanhamento: Boolean;
begin
  Result := True;
  if Pg_Pedido_Vda.ActivePageIndex = 0 then
  BEgin
    if Pedido.Registro.Codigo = 0 then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Não há informações do pedido.'+EOLN +
                     'Verifique antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      Result:=false;
      exit;
    End;
  End
  else
  Begin
    if Qr_Pesquisa.RecordCount = 0 then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Não há registros para visualizar.'+EOLN +
                     'Verifique antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      Result:=false;
      exit;
    End;
  End;
end;

function TFr_Pedido_Vda.ValidaPedidoExistente: Boolean;
begin
  Result := True;
  if pedido.Registro.Codigo = 0 then
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Não há dados neste pedido para continuar esta operação.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    Result:=FALSE;
    exit;
  end;
end;

function TFr_Pedido_Vda.ValidaTrocaTabela: Boolean;
begin
  Result := True;
  if ( Fm_ListaTabelaPreco.Dblcb_Lista.Text = '' ) then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe uma tabela válida.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result:=false;
    exit;
  End;
end;

function TFr_Pedido_Vda.validavisualizar: Boolean;
begin
  Result := True;

  if not (Qr_Pesquisa.RecordCount > 0 ) then
  BEgin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não há registro para visualizar.' + EOLN +
                   'Verifique os parametros e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    result:=false;
    exit;
  End;

  Pedido.Registro.Codigo := Qr_Pesquisa.FieldByName('PED_CODIGO').AsInteger;
  If not Pedido.using('C') then
  Begin
    Pedido.Registro.Codigo := 0;
    result:=false;
    exit;
  end;


  if Gb_Nivel =0 then
  Begin
    if  ( Fc_Tb_Geral('L','VDA_G_SO_VENDEDOR_VISUALIZA','N') = 'S') then
    Begin
      if ( Qr_Pesquisa.FieldByNAme('PED_CODVDO').AsInteger <> GB_Cd_Vendedor ) and (GB_Cd_Vendedor>0)  then
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Somente o próprio vendedor pode visualizar este pedido.' + EOLN +
                       'Verifique antes para continuar.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        result:=false;
        exit;
      End;
    End;
  End;

end;

function TFr_Pedido_Vda.valida_email: boolean;
begin
  Result := True;
  Pedido.Empresa.Registro.Codigo := Pedido.Registro.Empresa;
  Pedido.Empresa.getById;

  if Length( Trim(Pedido.Empresa.Registro.Email)) = 0 then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'e-mail não ncontrato no cadastro do cliente.' + EOLN +
                   'Verifique o cadastro antes de continuar.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja enviar o pedido via Email.'+EOLN+EOLN+
                     'Confirmar o envio ?',
                     [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao2) then
  Begin
    Result := False;
    exit;
  End;
end;

function TFr_Pedido_Vda.valida_impressao: boolean;
begin
  Result := True;
end;

function TFr_Pedido_Vda.valida_whatsApp: boolean;
begin
  Result := True;
  Pedido.Endereco.Registro.Codigo := Pedido.Registro.Endereco;
  Pedido.Endereco.getById;

  if Length( Trim(Pedido.Endereco.Registro.Celular)) < 8 then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O número do celular parece estar errado.' + EOLN +
                   'Verifique o cadastro antes de continuar.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja enviar o pedido via WhtatApp.'+EOLN+EOLN+
                     'Confirmar o envio ?',
                     [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao2) then
  Begin
    Result := False;
    exit;
  End;
end;

procedure TFr_Pedido_Vda.verificaBaseTroca;
begin
  with Pedido.Itens do
  Begin
    Qr_ItensVda.First;
    while not Qr_ItensVda.Eof do
    Begin
      BaseTroca.Registro.Estabelecimento := Pedido.Registro.CodigoEstabelecimento;
      BaseTroca.Registro.Ordem := Pedido.Registro.Codigo;
      BaseTroca.Registro.Item := Qr_ItensVdaITF_CODIGO.AsInteger;
      BaseTroca.getByKey;
      if BaseTroca.exist then
      Begin
        BaseTroca.Registro.Usuario          := PEdido.Registro.Usuario;
        BaseTroca.Registro.Cliente          := PEdido.Registro.Empresa;
        BaseTroca.Registro.Vendedor         := Pedido.Registro.Vendedor;
        BaseTroca.Registro.Estabelecimento  := Pedido.Registro.CodigoEstabelecimento;
        BaseTroca.Registro.Ordem            := Pedido.Registro.Codigo;
        BaseTroca.Registro.Item             := Qr_ItensVdaITF_CODIGO.AsInteger;
        BaseTroca.updateExtra;
        BaseTroca.save;
      End;
      Qr_ItensVda.Next;
    end;
  End;
end;

function TFr_Pedido_Vda.VerificaDespachadoLancado: Boolean;
begin
  Result := False;

  if not FDespachoByCodigoBarras then exit;

  Pedido.Despacho.Registro.Pedido := Pedido.Registro.Codigo;
  if Pedido.Despacho.DespachoLancado then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este Pedido tem registro de despacho Lançado.' + EOLN +
                   'Para altera-lo é preciso cancelar o despacho' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := True;
  End;
end;

procedure TFr_Pedido_Vda.Sb_ParcelamentoClick(Sender: TObject);
Var
  Lc_Form : TFr_Parcelamento;
begin
  if (It_bloqueio) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Cliente está com a Situação bloqueada.'+EOLN+
                   'Não é permitido parcelamento.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    exit;
  End;
  If (StrToFloatDef(E_VL_Pedido.Caption,0) = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O pedido não pode ser zero para este acesso.'+EOLN+
                   'Defina o valor do pedido antes de Parcelar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    exit;
  end;
  Try
    Lc_Form := TFr_Parcelamento.Create(nil);
    Lc_Form.It_StrinPrazo       := E_Prazo.Text;
    Lc_Form.Pedido    := Pedido;
    Lc_Form.It_Desc_FormaPagto  := Fm_FormaPagto.DBLCB_FormaPagto.Text;
    Lc_Form.It_Bloqueio         := It_bloqueio;
    Lc_Form.E_Nr_PArcelas.Text  :=  IntToStr(StrToIntDef(E_Nr_Parcelas.Text,1));
    if Lc_Form.E_Nr_PArcelas.Text = '0' then Lc_Form.E_Nr_PArcelas.Text := '1';
    Lc_Form.ShowModal;
    if Lc_Form.Confirma then
    Begin
      E_Nr_Parcelas.Text := StrZero(Lc_Form.It_Qt_Parcelas,3,0);
      if ( Lc_Form.It_Qt_Parcelas > 0 ) then
      Begin
        E_Prazo.Clear;
        E_Prazo.EditMask := '';
        E_Prazo.Text := Lc_Form.It_StrinPrazo;
        E_Prazo.EditMask := Fc_MascaraPrazo(Lc_Form.It_Qt_Parcelas);
      End
      else
      Begin
        E_Nr_ParcelasExit(Sender);
      End;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Pedido_Vda.ChBx_PeriodoClick(Sender: TObject);
Begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Pedido_Vda.ConsollidarCustoLucratividade1Click(Sender: TObject);
Var
  LcNrNota : String;
  LcNrNota_Int : Integer;
  LcNota : TControllerNotaFiscal;
  LcCodPedido : Integer;
  LcItensPedido : TControllerItensNFL;
  LcItensNota : TControllerItensNFL;
  LcItens : TItensNFL;
  I: Integer;
  TaxaProporcional : Real;
  LcProduto : TControllerProduto;
  ValorCusto : Real;
begin
  LcNrNota := '';
  if not(InputQuery('Consolidar Custo /Lucratividade', 'Informe o Numero da Nota',LcNrNota)) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Informe um número de Nota ' + EOLN +
                   'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Exit;
  end;
  LcNrNota_Int := StrToIntDef(LcNrNota,0);
  if LcNrNota_Int = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Número de nota informado é inválido ' + EOLN +
                   'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  LcNrNota := StrZero(LcNrNota_Int,6,0);
  LcNota := TControllerNotaFiscal.create(self);
  LcNota.Registro.CodigoEstabelecimento := Gb_CodMha;
  LcNota.Registro.Numero := LcNrNota;
  LcNota.Registro.Tipo := 'P';
  LcCodPedido := LcNota.getCodigoPedidoByNota;

  if LcCodPedido = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Número de nota não encontrado.' + EOLN +
                   'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

   if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Deseja consolidar o custo desta venda?' + EOLN +
                      'Não tem como cancelar este processo.' + EOLN +
                      'Confirmar a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
  Begin
    LcItensPedido := TControllerItensNFL.create(self);
    LcItensNota := TControllerItensNFL.create(self);
    LcProduto := TControllerProduto.create(self);

    LcItensPedido.Registro.CodigoPedido := self.Pedido.Registro.Codigo;
    LcItensPedido.getList;
    for I := 0 to LcItensPedido.Lista.Count - 1 do
    Begin
      LcItens := LcItensPedido.Lista[I];
      //Busca o Itens da nota
      LcItensNota.Clear;
      LcItensNota.Registro.CodigoPedido := LcCodPedido;
      LcItensNota.Registro.CodigoProduto := LcItens.CodigoProduto;
      LcItensNota.getByProduct;

      //Proporção
      TaxaProporcional := (LcItens.ValorUnitario - LcItensNota.Registro.ValorUnitario ) / LcItens.ValorUnitario;
      //Valor Unitario atualizado
      LcItens.ValorUnitario :=  LcItens.ValorUnitario -  LcItensNota.Registro.ValorUnitario;
      //PEga o valor do custo
      LcProduto.Registro.Codigo := LcItens.CodigoProduto;
      ValorCusto := LcProduto.getCusto;
      //Atualiza Custo do pedido
      LcItens.ValorCusto := ValorCusto * TaxaProporcional;
      //Retira a atualização do Estoque
      LcItens.Estoque := 'N';
      //Atualiza Custo da nota
      LcItensNota.Registro.ValorCusto := ValorCusto * (1 - TaxaProporcional);
      //Atualiza o pedido
      LcItensPedido.Registro := LcItens;
      LcItensPedido.atualiza;
      //Atualiza a nota
      LcItensNota.atualiza;
    End;
    Pc_AtualizaCampos;
    FreeAndNil(LcItensPedido);
    FreeAndNil(LcItensNota);
    FreeAndNil(LcProduto);
  End;
end;

procedure TFr_Pedido_Vda.ControleElementos(Ativo: Boolean);
begin
  Pnl_Fundo.Enabled := Ativo;
  Pnl_Botao.Enabled := Ativo;
  Pnl_TabelaPreco.Visible := not Ativo;
end;

procedure TFr_Pedido_Vda.Corrigirsequnciadositens1Click(Sender: TObject);
begin
  if pedido.CorrigirSequenciaItens then
    Pc_AbrirItensVenda;
end;

procedure TFr_Pedido_Vda.MnuCustodoPedidoClick(Sender: TObject);
Var
  Form : TRegCustoPedido;
begin
  if not EmNavegacao then
  BEgin
    If  (It_Edicao_Ordem = 'I')  then
    Begin
      If Fc_ValidaGravacao THEN
        Pc_Gravar
      else
        Exit;
    end;
    Form := TRegCustoPedido.Create(nil);
    Try
      Form.CodigoPedido := Pedido.Registro.Codigo;
      Form.ShowModal;
    Finally
      FreeAndNil( Form );
    End;
  End;
end;

procedure TFr_Pedido_Vda.E_VL_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Pedido : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Pedido := StrtoFloatDef(E_VL_Produto.Caption,0) + StrtoFloatDef(E_Vl_Servico.Caption,0);
  Lc_VL_Desconto := StrtoFloatDef(E_VL_Desconto.Text,0);
  Lc_Aq_Desconto := (Lc_VL_Desconto / Lc_VL_Pedido)*100;
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  pedido.AplicarValorDescontoItens(pedido.Registro.Codigo,Lc_VL_Desconto);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_AtualizaCampos;
  Pc_totalizador;
end;

procedure TFr_Pedido_Vda.DBG_PesquisaTitleClick(Column: TColumn);
Begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Pedido_Vda.RegistraroNmerodeSrie1Click(Sender: TObject);
Begin
  if Fc_VerificaExistenciaItem then
    Begin
    If not Assigned(Fr_Produto_Serie) then
      Application.CreateForm(TFr_Produto_Serie, Fr_Produto_Serie);
    Fr_Produto_Serie.Tag := 2;
    Fr_Produto_Serie.It_cd_Item   := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
    Fr_Produto_Serie.It_cd_Produto := Qr_Itensvda.FieldByName('ITF_CODPRO').AsInteger;
    Fr_Produto_Serie.It_Qt_Produto := Qr_ItensVda.FieldByName('ITF_QTDE').AsFloat;
    Fr_Produto_Serie.ShowModal;
    end;
end;

procedure TFr_Pedido_Vda.Pc_FormataCasas;
Begin



end;


procedure TFr_Pedido_Vda.Pc_FormataPanels;
Var
  Lc_top,lc_left : Integer;
BEgin
  //Posiciona o Panel de Tabela de Preço
  IF Fc_Aq_Geral('L','PEDIDOVDA','CRB_TELA_MAXIM','N') = 'S' then
    WindowState := wsMaximized
  else
    WindowState := wsNormal;

  Pnl_TabelaPreco.Visible := False;
  Lc_top := trunc((Height - Pnl_TabelaPreco.Height)/2);
  lc_left := trunc((Width - Pnl_TabelaPreco.Width)/2);
  Pnl_TabelaPreco.Top := Lc_top;
  Pnl_TabelaPreco.Left := lc_left;
end;

procedure TFr_Pedido_Vda.Sb_Vend_ComissaoClick(Sender: TObject);
Begin
  If (Gb_Nivel = 1) THEN
    Begin
    If not Assigned(Fr_Vendedores) then
      Application.CreateForm(TFr_Vendedores, Fr_Vendedores);
    with Fr_Vendedores do
      Begin
      It_Cd_Pedido := pedido.Registro.Codigo;
      It_Cd_Item := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
      ShowModal;
      end;
    end
  else
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Esta operação só pode ser efetuada por Administrador.'+EOLN+
                   'Verifique suas permissães antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    end;
end;

procedure TFr_Pedido_Vda.PC_Sel_FormPagto(Pc_Bloquea_Pagto: Boolean);
Begin
  If (DBLCB_Empresa.KeyValue) > 0 THEN
  Begin
    Fm_FormaPagto.Pc_Listar(3,Pc_Bloquea_Pagto,DBLCB_Empresa.KeyValue);
    If pedido.Registro.Aprovado  = 'S' THEN
    Begin
      DBLCB_Prazo.Enabled:=True;
      E_Nr_Parcelas.Enabled := (NOT It_bloqueio);
      E_Prazo.Enabled := (NOT It_bloqueio);

    end
    else
    If (Pc_Bloquea_Pagto)  then
    Begin
      DBLCB_Prazo.Enabled:=False;
      E_Nr_Parcelas.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  and (not It_bloqueio);
      E_Prazo.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  and (not It_bloqueio);
      Sb_Parcelamento.Enabled:= ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  ;
    end
    else
    Begin
      DBLCB_Prazo.Enabled:=True;
      E_Nr_Parcelas.Enabled := (NOT It_bloqueio);
      E_Prazo.Enabled := (NOT It_bloqueio);
    end;
  end;
  If (It_Edicao_Ordem = 'I') THEN
    Fm_FormaPagto.DBLCB_FormaPagto.KeyValue:= Fc_PegaFormaPgto('CARTEIRA');
end;

procedure TFr_Pedido_Vda.PC_Sel_PrazoPagto(Pc_Bloquea_Pagto: Boolean);
var
  LC_TXT:string;
Begin
  lc_txt:='';
  with qr_prazo_controlado do
  Begin
    Active:=false;
    SQL.Clear;
    If ((Pc_Bloquea_Pagto) AND (DBLCB_Empresa.KeyValue>0)) OR (Pos('DINHEIRO',Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text))>0) then
    Begin
      lc_txt:= ' SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo '+
               ' WHERE prz_prazo like :prz_prazo ';
      SQL.Add(LC_TXT);
      ParamByName('prz_prazo').AsString:='%'+'VISTA'+'%';
      Active:=True;
      FetchAll;
      DBLCB_Prazo.KeyValue := FIELDBYNAME('PRZ_PRAZO').AsString;
    end
    else
    If (NOT Pc_Bloquea_Pagto) AND (DBLCB_Empresa.KeyValue>0) then
    Begin
      lc_txt:= ' SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo '+
               ' where prz_vl_minimo <= :prz_vl_minimo ';
      SQL.Add(LC_TXT);
      ParamByName('prz_vl_minimo').AsCurrency := StrToFloatDef(E_VL_Pedido.Caption,0);
      Active:=True;
      FetchAll;
      DBLCB_Prazo.KeyValue := pedido.Registro.Prazo;
    end;
  End;
end;

procedure TFr_Pedido_Vda.Qr_ItensDevAfterOpen(DataSet: TDataSet);
Begin
  if Qr_ItensDev.RecordCount > 0 then
  Begin
    (Qr_ItensDevITF_VL_UNIT as TNumericField).DisplayFormat     := '0.00######';
    (Qr_ItensDevITF_VL_SUBTOTAL as TNumericField).DisplayFormat := '0.00';
    (Qr_ItensDevITF_VL_SUBTOTAL as TNumericField).DisplayFormat := '0.00';
  End;
end;

Function TFr_Pedido_Vda.FC_Valida_Itens_Vda:boolean;
var
  lc_obs : TMemo;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  Result:=true;
  Try
    Lc_obs := TMemo.Create(Self);
    Lc_obs.Visible := false;
    Lc_obs.Parent := Self;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT PRO_CODIGO,PRO_EST_NEG,EST_QTDE FROM TB_PRODUTO tb_produto '+
              '  INNER JOIN TB_ESTOQUE tb_estoque  ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
              'WHERE (PRO_CODIGO =:PRO_CODIGO)  AND EST_CODETS = :EST_CODETS  ');
      Qr_ItensVda.Active := False;
      Qr_ItensVda.Active := True;
      Qr_ItensVda.FetchAll;
      If (Qr_ItensVda.RecordCount > 0) THEN
      Begin
        Qr_ItensVda.First;
        //Verifica se algum produto do Tipo materia prima foi incluido no Faturamento
        //Se a variavel for igual a P o cliente faz distinção entre produto acabado e materia prima
        if (Fc_Aq_Geral('L','PRODUTO','PRO_P_DISTG_PA_MP','S') = 'S') then
        Begin
          lc_obs.Clear;
          Qr_ItensVda.First;
          while not Qr_ItensVda.Eof do
          begin
            if Qr_ItensVda.FieldByName('PRO_TIPO').AsString = 'M' then
            Begin
              lc_obs.Lines.Add(Qr_ItensVda.FieldByName('ITF_CODPRO').AsString + ' - ' + Qr_ItensVda.FieldByName('PRO_DESCRICAO').AsString);
            end;
            Qr_ItensVda.Next;
          end;

          if (Length(lc_obs.Text) >0 ) then
          Begin
            MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                           'O(s) produto(s) relacionado(s) abaixo (são) do tipo matéria prima ' + EOLN +
                           'e foi configurado no sistema para para distingui-los de ' + EOLN +
                           'produtos acabados não permitindo sua venda.' + EOLN + EOLN +
                            lc_obs.Text + EOLN + EOLN +
                           'Verifique e tente novamente.' + EOLN,
                           ['OK'], [bEscape], mpErro);
            Result := False;
            exit;
          end;
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


Function TFr_Pedido_Vda.FC_Valida_ImpostoAproximado:boolean;
var
  lc_obs : TMemo;
  Lc_Imp_Aprox :TStringList;
Begin
  TRy
    Result:=true;
    Lc_Imp_Aprox := TStringList.Create;
    Lc_obs := TMemo.Create(Self);
    Lc_obs.Visible := false;
    Lc_obs.Parent := Self;
    if not Qr_ItensVda.active then Qr_ItensVda.active := True;
    Qr_ItensVda.FetchAll;
    If (Qr_ItensVda.RecordCount > 0) THEN
    Begin
      Qr_ItensVda.First;
      while not Qr_ItensVda.Eof do
      Begin
        Fc_ImpostoAproximado(Lc_Imp_Aprox,
                             Qr_ItensVda.FieldByName('PRO_CODIGONCM').AsString,
                             Qr_ItensVda.FieldByName('PRO_ORIGEM').AsString);
        if (StrToFloatDef(Lc_Imp_Aprox.Strings[3],0) = 0) then
        Begin
          Result := False;
          lc_obs.Lines.Add(Qr_ItensVda.FieldByName('ITF_CODPRO').AsString + ' - ' + Qr_ItensVda.FieldByName('PRO_DESCRICAO').AsString);
        end;
        Qr_ItensVda.Next;
      end;
      If not Result then
      Begin
        MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                       'Problemas com os as informações do N.C.M '+EOLN+
                       'Pode ser inexistente ou não está de acordo com com Lei 12.741/12.'+EOLN+
                       lc_obs.Text,
                       ['OK'],[bEscape],mpAlerta);
      end;
    end;
  Finally
    FreeAndNil(Lc_Imp_Aprox);
    FreeAndNil(Lc_obs);
  End;
end;



function TFr_Pedido_Vda.Fc_ValidaPrazo: Boolean;
Begin
  result:=true;
  If DBLCB_Prazo.Visible then
    Begin
    If DBLCB_Prazo.Text = '' then
      Begin
      Result := False;
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O Prazo não foi informado.'+EOLN+EOLN+
                     'Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                      ['OK'],[bEscape],mpErro);
      If DBLCB_Prazo.CanFocus then DBLCB_Prazo.SetFocus;
      end;
    end;
end;

function TFr_Pedido_Vda.Fc_ValidaServico: Boolean;
Begin
  Result:=TRUE;
  Qr_ItensSrv.Active := False;
  Qr_ItensSrv.paramByName('PED_CODIGO').AsInteger := pedido.Registro.Codigo;
  Qr_ItensSrv.Active := True;
  Qr_ItensSrv.FetchAll;
  If Qr_ItensSrv.RecordCount > 0 then
  Begin
    Qr_Ordem.Active := true;
    Qr_Ordem.FetchAll;
    If (Qr_Ordem.RecordCount = 0 ) and (Fc_Tb_Geral('L','OSR_G_PREENCHE_VEI','S') = 'S') then
    Begin
      Result := False;
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O Veículo não foi informado.'+EOLN+EOLN+
                     'Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                      ['OK'],[bEscape],mpErro);
      exit;
    end;
  end;

  Qr_ItensSrv.First;
  while not Qr_ItensSrv.Eof do
    Begin
    Qr_Tecnicos.Active := False;
    Qr_Tecnicos.ParamByName('TEC_CODITF').AsInteger := Qr_ItensSrv.FieldByName('ITF_CODIGO').AsInteger;
    Qr_Tecnicos.Active := true;
    Qr_Tecnicos.FetchAll;
    If (Qr_Tecnicos.RecordCount = 0)and (Fc_Tb_Geral('L','OSR_G_PREENCHE_TEC','S') = 'S') then
    Begin
      Result := False;
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O Técnico não foi informado.'+EOLN+EOLN+
                     'Verifique o serviço: ' + Qr_ItensSrv.FieldByName('PRO_DESCRICAO').AsString +EOLN+EOLN,
                      ['OK'],[bEscape],mpErro);
      exit;
      end;
    Qr_ItensSrv.Next;
    end;
end;


function TFr_Pedido_Vda.Fc_ValidaGravacao: Boolean;
Var
  Lc_Cd_Aux : Integer;
  Lc_Dt_Inventario : TDate;
  Lc_Valor : Real;
  Lc_Aux :String;
  Lc_permissao : Boolean;
Begin
  Result:=TRUE;
  if E_Cd_Empresa.Focused  then
  Begin
    E_Cd_EmpresaExit(Self);
    DBLCB_EmpresaExit(Self);
  end
  else
  Begin
    if DBLCB_Empresa.Focused then DBLCB_EmpresaExit(Self);
  end;
  If (StrToFloatDef(E_Aq_Desconto.Text,0) > 0) AND(E_Aq_Desconto.Focused) THEN E_Aq_DescontoExit(Self)
  else
  If (StrToFloatDef(E_VL_Desconto.Text,0) > 0) AND(E_VL_Desconto.Focused) THEN E_VL_DescontoExit(Self);
  If (StrToFloatDef(E_VL_Frete.Text,0) > 0) AND E_VL_Frete.Focused then E_VL_FreteExit(Self);

  //Verifica Inventario
  if not Fc_ValidaDataPedido(E_Data.DateTime) then
  Begin
    Result := FAlse;
    E_Data.SetFocus;
    E_Data.Date := Date;
    Exit;
  end;

  if It_Usa_Nfe then
  Begin
    //Não valida dados caso seja um cliente do tipo consumidor da frente de caixa
    if (It_Cli_Consumidor <> StrToIntDef(E_Cd_Empresa.Text,0)) then
    Begin
      if not Fc_Valida_Dados_Empresa_NFE(StrToIntDef(E_Cd_Empresa.Text,0)) then
      Begin
        Result :=False;
        exit;
      end;
    end;
  end;

  Lc_Valor := StrToFloatDef(E_VL_Produto.Caption,0) + StrToFloatDef(E_Vl_Servico.Caption,0);
  If DBLCB_Prazo.Visible then
    Lc_Aux := Copy(DBLCB_Prazo.Text,1,3)
  else
    Lc_Aux := Copy(E_Nr_Parcelas.Text,1,3);


  if not Fc_ValidaDesconto(Lc_Valor,StrToFloatDef(E_VL_Desconto.Text,0),Lc_Aux) then
  Begin
    E_Aq_Desconto.Text := '0,00';
    E_Aq_DescontoExit(Self);
    Result:=false;
    exit;
  end;

  If TRIM(Fm_VendedorPedido.DBLCB_Vendedor.Text) = '' then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Campo Vendedor é obrigatório.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
          ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
    end;

  If TRIM(E_Nr_Parcelas.Text) = '' then
    E_Nr_Parcelas.Text:='000';

  If Fc_Valida_Cliente = False then
  Begin
    Result:=FALSE;
    exit;
  end;

  //Valida preenchimento do endereco d entrega
  if Trim(DBLCB_end_Entrega.Text)='' then Lc_Cd_Aux := 0 else Lc_Cd_Aux := DBLCB_end_Entrega.KeyValue;
  If not Fc_Valida_enderecoPedido(Lc_Cd_Aux,DBLCB_end_Entrega.Text) then
  Begin
    Pg_Observacao.ActivePageIndex := 1;
    DBLCB_end_Entrega.SetFocus;
    Result:=FALSE;
    exit;
  end;

  If not Fc_Valida_FormaPgto then//Valida preenchimento dA FORMA DE PAGAMTNO
  Begin
    Result:=FALSE;
    exit;
  end;

  If not Fc_ValidaPrazo then
  Begin
    Result:=FALSE;
    exit;
  end;

  If ( E_Nr_Pedido.Text <>'' ) and (E_Nr_Pedido.Text <>'0') then
  Begin
    If not Fc_ValidaNumeroPedido(pedido.Registro.Codigo,StrToIntDef(E_Nr_Pedido.Text,0),1) then
    Begin
      pedido.Registro.Numero := 0;
      E_Nr_Pedido.Clear;
      Result:=FALSE;
      exit;
    end;
  end;

  if not Fc_ValidaParcelamentoPedido then
  Begin
    Result:=FALSE;
    exit;
  end;

  //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
  //Fc_AuditoriaEstoquePedido(Pedido.Registro.codigo,'N');

  //vERIFICA O ORIGEM DA vENDA
  if not Fc_ValidaInfoOrigemVenda then
  Begin
    Result:=FALSE;
    exit;
  end;

  //vERIFICA A ORIGEM DO CLIENTE
  if not Fc_ValidaInfoOrigemCustomer then
  Begin
    Result:=FALSE;
    exit;
  end;
  {
  if not Fc_ValidaLucratividadePedido then
  Begin
    Result:=FALSE;
    exit;
  end;
  }
end;

function TFr_Pedido_Vda.Fc_ValidaParcelamentoPedido():boolean;
Begin
  Result := True;
  if (Fc_Tb_Geral('L','VDA_G_CTRL_PARCELA','') = 'A') then
  Begin
    if ChBx_UsarCredito.Checked then
    Begin
      if not Pedido.ValidaParcelamento(It_vl_Credito) then
      Begin
        Result:=FALSE;
        exit;
      end;
    end
    else
    Begin
      if not Pedido.ValidaParcelamento(0) then
      Begin
        Result:=FALSE;
        exit;
      end;
    end;
  end;
end;

function TFr_Pedido_Vda.Fc_ValidaInfoOrigemVenda():Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Form : TFr_Info_Origen_Sale;
Begin
  Result := True;
  IF trim(pedido.Registro.TipoContato) = '' then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('select id FROM tb_sale_origen where (id > 0) ');
        Active := True;
        FetchAll;
        if recordCount > 0 then
        Begin
          Lc_Form := TFr_Info_Origen_Sale.Create(nil);
          Lc_Form.ShowModal;
          if (Lc_Form.It_cd_Sale_Origens = 0) then
          Begin
            Result := False;
            MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                           'Origem da venda não informada.'+EOLN+EOLN+
                           'Por favor escolha uma opção para continuar'+EOLN+EOLN,
                            ['OK'],[bEscape],mpAlerta);

          end
          else
            pedido.Registro.TipoContato := InttoStr(Lc_Form.It_cd_Sale_Origens);
          FreeAndNil(Lc_Form);
        end;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  end;
end;

function TFr_Pedido_Vda.Fc_Valida_Cliente: Boolean;
Begin
  Result:=true;
  If (DBLCB_Empresa.Text = '') then
  Begin
    Result := False;
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O Cliente não foi informado.'+EOLN+EOLN+
                     'Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                      ['OK'],[bEscape],mpErro);
    If DBLCB_Empresa.CanFocus then DBLCB_Empresa.SetFocus;
  end;
end;

function TFr_Pedido_Vda.Fc_Valida_FormaPgto: Boolean;
Begin
  Result:=true;
  If Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) ='' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'A forma de Pagamento não foi informado.'+EOLN+EOLN+
                   'Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                      ['OK'],[bEscape],mpErro);
    Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    Result:=FALSE;
    end;
end;

procedure TFr_Pedido_Vda.Pc_DefineSetfocus;
Begin
  If E_Nr_Pedido.Enabled = true then
  Begin
    If E_Nr_Pedido.CanFocus then E_Nr_Pedido.SetFocus;
  end
  else
  Begin
    If E_Data.CanFocus then E_Data.SetFocus;
  end;  
end;


procedure TFr_Pedido_Vda.ChBx_Busca_NomeClick(Sender: TObject);
Begin
  If ChBx_Busca_Nome.Checked then
    Begin
    ChBx_Busca_Fantasia.Checked := False;
    if not Qr_Pesquisa.Active then exit;
    DBG_Pesquisa.Columns[2].Title.Caption := 'Nome do Cliente';
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_NOME';
    end;
end;


procedure TFr_Pedido_Vda.E_Vl_DespesaExit(Sender: TObject);
Var
  Lc_Vl_Despesa : Real;
begin
  Lc_Vl_Despesa := StrtoFloatDef(E_Vl_Despesa.Text,0);
  E_Vl_Despesa.Text := FloatToStrF(Lc_Vl_Despesa,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Pedido_Vda.E_VL_FreteExit(Sender: TObject);
Var
  Lc_Vl_frete : Real;
begin
  Lc_Vl_frete := StrtoFloatDef(E_VL_Frete.Text,0);
  E_VL_Frete.Text := FloatToStrF(Lc_Vl_frete,ffFixed,10,2);
  Pc_totalizador;
end;


procedure TFr_Pedido_Vda.E_VL_StExit(Sender: TObject);
Var
  Lc_Vl_St : Real;
begin
  Lc_Vl_St := StrtoFloatDef(E_VL_st.Text,0);
  E_VL_ST.Text := FloatToStrF(Lc_Vl_St,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Pedido_Vda.ChBx_NomeClick(Sender: TObject);
Begin
  Pc_ListaClienteDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Pedido_Vda.ChBx_FantasiaClick(Sender: TObject);
Begin
  Pc_ListaClienteDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Pedido_Vda.Qr_ItensVdaAfterOpen(DataSet: TDataSet);
Begin
  if Qr_ItensVda.RecordCount > 0 then
  Begin
    (Qr_ItensVdaITF_VL_UNIT as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
    (Qr_ItensVdaITF_VL_DESC as TNumericField).DisplayFormat     := '0.00######';
    (Qr_ItensVdaITF_VL_SUBTOTAL as TNumericField).DisplayFormat := '0.00';
    (Qr_ItensVdaITF_AQ_COM as TNumericField).DisplayFormat := '0.00######';
    (Qr_ItensVdaITF_VL_TOTAL as TNumericField).DisplayFormat := '0.00';
    (Qr_ItensVdaITF_VL_IPI as TNumericField).DisplayFormat := '0.00######';
  End;
end;

procedure TFr_Pedido_Vda.Qr_ItensVdaCalcFields(DataSet: TDataSet);
Var
  LcValor : Real;
  LcStrValor : String;
begin
  with Qr_ItensVda do
  Begin
    LcValor := FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').AsFloat;
    LcValor := RoundTo( LcValor ,-2);
    LcStrValor := FloatToStrF(LcValor , ffFixed, 10, 2);
    FieldByName('ITF_VL_SUBTOTAL').AsCurrency := StrToFloatDef(LcStrValor,0);


    FieldByName('ITF_VL_TOTAL').AsCurrency :=
        FieldByName('ITF_VL_SUBTOTAL').AsCurrency - FieldByName('ITF_VL_DESC').AsCurrency;

    if ( FieldByName('SET_FINANCIAL').AsString = 'N' ) then
      FieldByName('TEMFINANCEIRO').AsString := 'N'
    else
      FieldByName('TEMFINANCEIRO').AsString := 'S';

  End;
end;

procedure TFr_Pedido_Vda.Qr_ItensSrvAfterOpen(DataSet: TDataSet);
Begin
  if Qr_ItensSrv.RecordCount > 0 then
  Begin
    (Qr_ItensSrvITF_VL_UNIT as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
    (Qr_ItensSrvITF_VL_DESC as TNumericField).DisplayFormat     := '0.00######';
    (Qr_ItensSrvITF_VL_SUBTOTAL as TNumericField).DisplayFormat := '0.00';
    (Qr_ItensSrvITF_AQ_COM as TNumericField).DisplayFormat := '0.00######';
    (Qr_ItensSrvITF_VL_TOTAL as TNumericField).DisplayFormat := '0.00';
  End;
end;

procedure TFr_Pedido_Vda.Sb_Ins_DevolucaoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_Dev;
begin
  If (E_Cd_Empresa.Focused) OR (DBLCB_Empresa.Focused) then exit;
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
    Begin
      Pc_Gravar;
    end;
  end;
  try
    //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_Dev.create(nil);
    Lc_Form.it_Cd_Empresa := Pedido.Registro.Empresa;
    Lc_Form.Terminal := Pedido.Registro.Terminal;
    Lc_Form.Pc_StateChange(2);
    Lc_Form.It_MultiplicadorPreco := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
    Lc_Form.ItensNFL.Registro.CodigoPedido := Pedido.Registro.codigo;
    Lc_Form.E_Qt_Produto.Text := '1';
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Qr_ItensDev.Active := False;
    Qr_ItensDev.Active := True;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_DinheiroFormaPgt;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_descontoAutomatico;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Alt_DevolucaoClick(Sender: TObject);
Var
  Lc_Form : TFr_Itens_Produto_Dev;
begin
  Try
    //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_Dev.Create(nil);
    Lc_Form.Pc_StateChange(3);
    Lc_Form.It_Inserir := True;
    Lc_Form.It_MultiplicadorPreco := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
    Lc_Form.ItensNFL.Registro.CodigoPedido := Pedido.Registro.Codigo;
    Lc_Form.Terminal := Pedido.Registro.Terminal;
    Lc_Form.editItems(Qr_ItensDev.FieldByName('ITF_CODIGO').AsInteger);
    Lc_Form.Pc_Totalizador;
    //Ativar Tabela de Estoque
    Lc_Form.Qr_Tabela.Active := True;
    Lc_Form.it_Modalidade_preco := Fc_DefineTabela;
    Lc_Form.it_TipoCliente := Fc_DefineTipoPessoa;
    Lc_Form.It_Dt_Operacao := E_Data.Date;
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'S';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    Qr_ItensDev.Active := False;
    Qr_ItensDev.Active := True;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_descontoAutomatico;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  End;
end;



procedure TFr_Pedido_Vda.Pc_DinheiroFormaPgt;
Begin
  if (Pos('DINHEIRO',Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text))>0) then
  Begin
    If E_Nr_Parcelas.Visible = TRUE THEN
    Begin
      E_Nr_Parcelas.Text:='000';
      E_Nr_ParcelasExit(Self);
      E_Nr_Parcelas.Enabled:=FALSE;
      E_Prazo.Enabled:=FALSE;
    end
    else
    Begin
      PC_Sel_PrazoPagto(It_bloqueio);
    end;
  end
  else
  Begin
      PC_Sel_PrazoPagto(It_bloqueio);
      E_Nr_Parcelas.Enabled:=TRUE;
      E_Prazo.Enabled:=TRUE;
  end;
end;

procedure TFr_Pedido_Vda.Pc_descontoAutomatico;
Var
  Lc_Aq_Desconto:Real;
  Lc_Vl_Pedido : Real;
  Lc_Vl_Desconto : Real;
begin
  Lc_Aq_Desconto := StrToFloatDef(Fc_Tb_Geral('L','VDA_G_DESC_PAGTO_VISTA',''),0);
  If Lc_Aq_Desconto > 0 then
  Begin
    Lc_Vl_Pedido := StrtoFloatDef(E_VL_Produto.Caption,0) + StrtoFloatDef(E_Vl_Servico.Caption,0);
    Lc_Vl_Desconto := (Lc_Vl_Pedido * (Lc_Aq_Desconto/100));
    Lc_Vl_Desconto := RoundTo( Lc_Vl_Desconto,-2);
    If DBLCB_Prazo.Visible then
    Begin
      If (DBLCB_Prazo.Text = '000 - VISTA') then
        pedido.AplicarValorDescontoItens(Pedido.Registro.Codigo, Lc_Vl_Desconto)
      else
      Begin
        Lc_Aq_Desconto := 0;
        E_Aq_Desconto.Text := '0,00';
        pedido.AplicarValorDescontoItens(Pedido.Registro.Codigo, Lc_Aq_Desconto);
      end;
    end
    else
    Begin
      If (E_Nr_Parcelas.Text = '000') then
        pedido.AplicarValorDescontoItens(Pedido.Registro.Codigo, Lc_Vl_Desconto)
      else
        Begin
        Lc_Aq_Desconto := 0;
        E_Aq_Desconto.Text := '0,00';
        pedido.AplicarValorDescontoItens(Pedido.Registro.Codigo, Lc_Aq_Desconto);
        end;
    end;
    E_Aq_Desconto.Text := FloatToStrf(Lc_Aq_Desconto,ffFixed,10,2);
    Pc_AtualizaCampos;
    Pc_Totalizador;
  end;
end;

procedure TFr_Pedido_Vda.Pc_controlaEdicaoCliente;
Begin
  If (It_Edicao_Ordem = 'E')  then
  Begin
    If (Fc_Tb_Geral('L','VDA_G_EDIT_CLIENTE_PEDIDO','') = 'S') then
    Begin
      If (Gb_Nivel <> 1) and (GB_Nm_Usuario <> Fm_VendedorPedido.DBLCB_Vendedor.Text) then
      Begin
        E_Cd_Empresa.Enabled    :=  false;
        DBLCB_Empresa.Enabled   :=  false;
        SB_Cliente.Enabled      :=  false;
        Sb_Pesq_Cliente.Enabled :=  false;
        DBLCB_EmpresaExit(Self);
      end
      else
      Begin
        E_Cd_Empresa.Enabled  :=  true;
        DBLCB_Empresa.Enabled :=  true;
        SB_Cliente.Enabled    :=  true;
      end;
    end;
  end
  else
  Begin
    E_Cd_Empresa.Enabled    :=  true;
    DBLCB_Empresa.Enabled   :=  true;
    SB_Cliente.Enabled      :=  true;
    Sb_Pesq_Cliente.Enabled :=  true;
  end;
end;

Procedure TFr_Pedido_Vda.Pc_controlaEdicaoVendedor;
Begin
  If Fc_Tb_Geral('L','VDA_G_EDIT_VendEDOR_PEDIDO','') = 'S' then
  Begin
    If (Length(Trim(E_Nr_Pedido.Text))= 0) or (Gb_Nivel = 1)  then
    Begin
      Fm_VendedorPedido.DBLCB_Vendedor.Enabled := True;
    end
    else
    Begin
      Fm_VendedorPedido.DBLCB_Vendedor.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND ((Gb_Nivel = 1)
                                         OR  (Fm_VendedorPedido.DBLCB_Vendedor.Text = ''))   ;
      //                                 OR (Gb_Cd_Vendedor = DBLCB_Vendedor.KeyValue) or (DBLCB_Vendedor.Text = ''))   ;
    end;
  end
  else
  Begin
    Fm_VendedorPedido.DBLCB_Vendedor.Enabled := True;
  end;
end;


procedure TFr_Pedido_Vda.E_Nr_ParcelasExit(Sender: TObject);
Begin
  If StrToIntDef(E_Nr_Parcelas.Text,0)> 0 then
  Begin
    E_Prazo.Clear;
    E_Prazo.EditMask := Fc_MascaraPrazo(StrToIntDef(E_Nr_Parcelas.Text,0));
  end
  else
  Begin
    E_Nr_Parcelas.Text:='000';
    E_Prazo.EditMask := '';
    E_Prazo.Text := Fc_MascaraPrazo(StrToIntDef(E_Nr_Parcelas.Text,0));
  end;
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
     Pc_descontoAutomatico;
end;

procedure TFr_Pedido_Vda.DBLCB_PrazoClick(Sender: TObject);
Begin
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
     Pc_descontoAutomatico;
end;

procedure TFr_Pedido_Vda.Qr_PesquisaAfterOpen(DataSet: TDataSet);
Begin
  (Qr_Pesquisa.FieldByName('PED_VL_PEDIDO') as TNumericField).DisplayFormat := '0.00';
end;

procedure TFr_Pedido_Vda.RegistraNmerodeLoteClick(Sender: TObject);
Var
  Lc_Form : TFr_Ctrl_Lote_Saida;
begin
  if Fc_VerificaExistenciaItem then
  Begin
    try
      Lc_Form := TFr_Ctrl_Lote_Saida.Create(nil);
      Lc_Form.It_Cd_Item := Qr_ItensVda.FieldByname('ITF_CODIGO').AsInteger;
      Lc_Form.It_Tipo := 'VENDA';
      Lc_Form.it_Cd_produto := Qr_ItensVda.FieldByname('ITF_CODPRO').AsInteger;
      Lc_Form.It_Cd_Empresa := StrToIntDef(E_Cd_Empresa.Text,1);
      Lc_Form.It_Qtde_Lote := Qr_ItensVda.FieldByname('ITF_QTDE').AsFloat;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;


procedure TFr_Pedido_Vda.Pc_ChamaFaturaCupomFiscal;
Var
  Lc_Form : TFr_Cupom_Fiscal;
Begin
  Try
    Lc_Form := TFr_Cupom_Fiscal.Create(nil);
    Lc_Form.It_Pizzaria := False;
    Lc_Form.It_Cd_Pedido := Pedido.Registro.Codigo;
    Lc_Form.It_Nr_Pedido := strToIntDef(E_Nr_Pedido.Text,0);
    Lc_Form.E_VL_Total.Text := E_VL_Pedido.Caption;
    Lc_Form.It_NFCe := It_NFCe;
    Lc_Form.ShowModal;
    It_Fatura_Ok := Lc_Form.it_fatura_ok;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;


procedure TFr_Pedido_Vda.Pc_EscolheFaturamento;
var
  Lc_Escolha: Integer;
Begin
  if  ((MensagemPadrao(TITULO_INFORMACAO,
                        'Deseja enviar para?',
                        ['NFC-e','NF-e','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace)) = 0) then
  Begin
    if Gb_PAF_NFE_E then
    Begin
      if ValidatePafNfceForcedClosure then
      Begin
        exit;
      end;
    end;
    Pc_ChamaFaturaCupomFiscal;
  end
  else
  Begin
    Pc_ChamaFatura;
  end;
end;

procedure TFr_Pedido_Vda.Pc_PermissaoBotao(Pc_Menu: string);
Begin
  If Gb_Nivel = 1 then
    Begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Faturar := True;
    It_Visualizar := True;
    It_IMPRIMIR   := true;
    it_ficha_financeira:=true;
    end
  else
    Begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Faturar    := Fc_HabilitaPermissao(Pc_Menu,'FATURAR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    It_IMPRIMIR   := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    it_ficha_financeira:= Fc_HabilitaPermissao(Pc_Menu,'FICHA FINANCEIRA','S');
    end;
  SB_Cadastrar.Enabled := It_Inserir;
  Sb_Fich_Fin.Enabled := it_ficha_financeira
end;

procedure TFr_Pedido_Vda.Pc_UtitilzaCredito;
Begin
  If Qr_ItensDev.RecordCount > 0 THEN
    Begin
    ChBx_UsarCredito.Checked := false;
    ChBx_UsarCredito.Enabled := false;
    end
  else
    Begin
    If (Fc_Tb_Geral('L','FIN_G_ATIVA_CREDITO','') <> 'S') THEN
      Begin
      ChBx_UsarCredito.Checked := false;
      ChBx_UsarCredito.Enabled := true;
      end
    else
      Begin
      ChBx_UsarCredito.Checked := true;
      ChBx_UsarCredito.Enabled := false;
      end;
    end;
end;

procedure TFr_Pedido_Vda.Pc_GravaCredito;
Begin
  if ChBx_UsarCredito.Checked and (StrToFloatDef(Lb_Vl_Credito.Caption,0)>0)then
  Begin
    Pedido.GravaCredito;
  end;
end;

procedure TFr_Pedido_Vda.Pc_Gravar;
begin
  with pedido.Registro do
  Begin
    if (Codigo = 0) or (Hora = 0)  then
      Hora := Time;
    if not (Terminal >0 ) then
      Terminal := Gb_Terminal;
    EmUso := Fc_NomeComputador;
    if (It_Edicao_Ordem = 'I') then
      Tipo := 1;
    Faturado := 'N';
    Numero := StrToIntDef( E_Nr_Pedido.Text,0 );
    Usuario := Gb_Cd_Usuario;
    If (Fc_Tb_Geral('L','VDA_G_CTRL_PARCELA','')  = 'A') then
     Prazo := E_Nr_Parcelas.Text + ' - ' + E_Prazo.Text
    else
      Prazo := DBLCB_Prazo.Text;
    Empresa := DBLCB_Empresa.KeyValue;
    Vendedor := Fm_VendedorPedido.DBLCB_Vendedor.KeyValue;
    FormaPagto := Fm_FormaPagto.DBLCB_FormaPagto.keyvalue;
    QtdeProdutos := StrToFloatDef(E_Qt_Produto.Caption,0);
    ValorProdutos := StrToFloatDef(E_VL_Produto.Caption,0);
    ValorServico := StrToFloatDef(E_VL_Servico.Caption,0);
    ValorIPI := StrToFloatDef(E_VL_IPI.Caption,0);
    ValorSubstTributaria := StrToFloatDef(E_VL_St.Text,0);
    ValorFrete := StrToFloatDef(E_VL_Frete.Text,0);
    AliqDesconto := StrToFloatDef(E_Aq_Desconto.Text,0);
    ValorOutrasDEspesas := StrToFloatDef(E_Vl_Despesa.Text,0);
    ValorDesconto := StrToFloatDef(E_VL_Desconto.Text,0);
    ValorPedido := StrToFloatDef(E_VL_Pedido.Caption,0);
    Data := E_Data.Date;
    CodigoEstabelecimento := Gb_CodMha;
    Entrega := Cb_Retirada.Text;
    Garantia := Cb_Garantia.Text;
    IndicaPresenca := Cb_IndPresComprador.ItemIndex + 1;
    IF chbx_aprovados.Checked then
      Aprovado := 'S'
    else
      Aprovado := 'N';
    Endereco := DBLCB_end_Entrega.KeyValue;
    Observacao := E_Observ.Text;
    DataEntrega := E_Data_Entrega.DateTime;
    if Dblcb_Negocio.Text <> '' then
      CodigoNegocio := Dblcb_Negocio.KeyValue
    else
      CodigoNegocio := 0;
  End;
  Pedido.Salva;
end;

procedure TFr_Pedido_Vda.Sb_Exc_DevolucaoClick(Sender: TObject);
Begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+Qr_ItensDev.FieldByName('PRO_DESCRICAO').AsString +' desta venda.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
    Pc_Delete_Estoque('P',0,Qr_ItensDev.FieldByName('ITF_CODIGO').AsInteger);
    Pedido.Itens.Registro.Codigo := Qr_ItensDev.FieldByName('ITF_CODIGO').AsInteger;
    Pedido.Itens.delete;
    Qr_ItensDev.Active := False;
    Qr_ItensDev.Active := True;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;

end;



procedure TFr_Pedido_Vda.DBG_DevolucaoKeyDown(Sender: TObject;
  var Key: Word; ShIft: TShIftState);
Begin
  If ShIft = [] then
  case Key of
    VK_delete  : If Sb_Exc_Devolucao.Enabled then Sb_Exc_DevolucaoClick(Sender);
  end;
end;

procedure TFr_Pedido_Vda.CadastrodoProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Produtos.Create(nil);
      Lc_Form.Produto.Registro.Codigo := Qr_ItensVda.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil( Lc_Form );
      Qr_ItensVda.Active := False;
      Qr_ItensVda.Active := true;
    End;
  end;
end;

procedure TFr_Pedido_Vda.CancelarDespacho;
Var
  Lc_Despacho : TControllerDespacho;
begin
  Lc_Despacho := TControllerDespacho.Create(Nil);
  Try
    Lc_Despacho.Registro.Pedido       := Pedido.Registro.Codigo;
    Lc_Despacho.deleteByPedido;
  Finally
    FreeAndNil( Lc_Despacho );
  End;
end;

procedure TFr_Pedido_Vda.MnuCancelarDespachoClick(Sender: TObject);
begin
  if ValidaCancelaDespacho then
  Begin
    CancelarDespacho;
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Despacho cancelado com sucesso',
                   ['OK'], [bEscape], mpAlerta);
  End;
end;

procedure TFr_Pedido_Vda.Ds_ItensDevStateChange(Sender: TObject);
begin
  Pc_UtitilzaCredito;
end;

function TFr_Pedido_Vda.EmEdicao:Boolean;
Begin
  Result := False;
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                  'Grave o Pedido antes de continuar. '+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := True;
  end;
End;

function TFr_Pedido_Vda.EmNavegacao: Boolean;
begin
  Result := False;
  If (It_Edicao_Ordem = 'B')   then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                  'Você precisa estar em modo de Edição. '+EOLN+
                  'Clique em Alterar para continuar. '+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := True;
  end;
end;

procedure TFr_Pedido_Vda.Envia_email;
Var
  Lc_Destinatario : TStringList;
  Lc_Anexo        : TStringList;
  Lc_Imp : TimpModImpressao;
  LcEnviaemail : TFr_envia_email;
Begin
  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Lc_Imp.SalvaPDF := True;
    Lc_Imp.NomePDF := 'pedido.pdf';
    Lc_Imp.CodigoPedido := Pedido.Registro.Codigo;
    Lc_Imp.Pc_Imp_Vda_JatoLaser;
    Lc_Anexo        := TStringList.Create;
    Lc_Anexo.Add(GbPathExe + Lc_Imp.NomePDF);
    Lc_Destinatario := TStringList.Create;
    Lc_Destinatario.Add(' '+Pedido.Empresa.Registro.Email);
    LcEnviaemail := TFr_envia_email.create(nil);
    with LcEnviaemail do
    Begin
      It_Tipo_Envio := 'S';
      It_Assunto := 'Pedido Nº ' + Pedido.Registro.Numero.ToString;
      It_Destino := Lc_Destinatario;
      It_Corpo   := GeraCorpoEmail;
      It_Anexo   := lc_anexo;
      ShowModal;
    end;
  Finally
    FreeAndNil(Lc_Imp);
    FreeAndNil(Lc_Destinatario);
    FreeAndNil(Lc_Anexo);
    FreeAndNil(LcEnviaemail);
  End;
end;

procedure TFr_Pedido_Vda.Envia_WhatsApp;
Var
  LcW : TWhatsApp;
  Lc_Imp : TimpModImpressao;
begin
  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Lc_Imp.SalvaPDF := True;
    Lc_Imp.NomePDF := 'pedido.pdf';
    Lc_Imp.CodigoPedido := Pedido.Registro.Codigo;
    Lc_Imp.Pc_Imp_Vda_JatoLaser;

    LcW := TWhatsApp.create(nil);
    LcW.Mensagem := 'Ola, Confira o pedido que foi soliitado, segue em anexo.';
    LcW.ReceiverNumber := PEdido.Endereco.Registro.Celular;
    //Agora Envia o Anexo
    LcW.Arquivo := GbPathExe + Lc_Imp.NomePDF;
    LcW.RegisterMessage;
    LcW.Send;
  Finally
    FreeAndNil(LcW);
    FreeAndNil(Lc_Imp);
  End;
end;

procedure TFr_Pedido_Vda.EnvioPedidoParaDespacho;
Var
  Lc_Despacho : TControllerDespacho;
begin
  Lc_Despacho := TControllerDespacho.Create(Nil);
  Try
    if not Qr_ItensVda.Active then Qr_ItensVda.active := true;
    with Qr_ItensVda do
    Begin
      First;
      while not eof do
      Begin
        Lc_Despacho.Clear;
        Lc_Despacho.Registro.Codigo       := 0;
        Lc_Despacho.Registro.ItemPedido   := FieldByName('ITF_CODIGO').asInteger;
        Lc_Despacho.Registro.DataPrevista := Date;
        Lc_Despacho.Registro.Qtde         := FieldByName('ITF_QTDE').asfloat;
        Lc_Despacho.Registro.Pedido       := FieldByName('ITF_CODPED').asInteger;
        Lc_Despacho.Registro.Produto      := FieldByName('ITF_CODPRO').asInteger;
        Lc_Despacho.Registro.Situacao     := 'P';
        Lc_Despacho.Registro.Impresso     := 'N';
        Lc_Despacho.Registro.Conferido    := 0;
        Lc_Despacho.Insert;
        Next;
      End;
    End;
  Finally
    FreeAndNil( Lc_Despacho );
  End;
end;

procedure TFr_Pedido_Vda.MnuLucratividadeClick(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Pedido_Vda','Pedido de Venda','LUCRATIVIDADE',GB_Cd_Usuario,'S') then
  Begin
    if Pg_Pedido_Vda.ActivePageIndex = 0 then
    Begin
      if EmEdicao then
      Begin
        exit;
      end;
    end;
    Pc_GeraNumeroPedido;
    LucratividadePedidoAberto;
  end;
end;

procedure TFr_Pedido_Vda.MnuSeparaoClick(Sender: TObject);
Var
  Lc_Cd_Pedido : Integer;
  Lc_Cd_Modelo : Integer;
  Lc_Imp: TimpModImpressao;
begin
  
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Grave o Pedido antes de continuar. '+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    exit;
    end;

  If (Qr_ItensVda.RecordCount = 0) then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não há itens para separação. '+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    exit;
    end;

  Lc_Cd_Pedido := Pedido.Registro.Codigo;

  if not Fc_VerificaExistenciaSeparacaoMercadoria(Lc_Cd_Pedido,'A') then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não há itens para separação. '+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    exit;
    end;


  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja realmente solicitar a separação dos itens deste Pedido?.'+EOLN+EOLN+
                     'Confirmar a operação ?',
                    [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clBtnFace) = mrBotao1) then
    Begin
    try
      Lc_Imp := TimpModImpressao.create(Nil);
      Pc_GeraNumeroPedido;
      Pc_LiberarSeparacaoMercadoria(Lc_Cd_Pedido);
      Lc_cd_Modelo := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_MOD_IMPRESSAO', ''),1);
      case Lc_cd_Modelo of
        1:Begin
          if (Fc_Tb_Geral('L','DSP_P_IMP_AUTO_SEP','')='S') then
            Lc_Imp.Pc_Imp_Cupom_Dsp_Separacao(Lc_Cd_Pedido);
          end;
        2:Begin
          Lc_Imp.Pc_Imp_Conferencia(Lc_Cd_Pedido);
          end;
      end;
    finally
      FreeandNil(Lc_Imp);
    end;
   end;
end;

procedure TFr_Pedido_Vda.Sb_NegocioClick(Sender: TObject);
Var
  Lc_Form : TSeaBusiness;
begin
  Lc_Form := TSeaBusiness.create(nil);
  try
    IF Trim(Dblcb_Negocio.Text) <> '' then
      Lc_Form.CodigoRegistro := Dblcb_Negocio.KeyValue;
    Lc_Form.ShowModal;
  finally
    DM.Qr_Negocio.Active := False;
    DM.Qr_Negocio.Active := True;
    Dblcb_Negocio.KeyValue := Lc_Form.CodigoRegistro;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Pedido_Vda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Pedido);
  FreeAndNil(CtrlLote);
  Pc_grava_Perfil_Local;
end;

procedure TFr_Pedido_Vda.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O pedido está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes de sair da tela.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end
  else
  Begin
    Pedido.using('L');
  end;
end;

procedure TFr_Pedido_Vda.FormCreate(Sender: TObject);
begin
  FAbrirNovo := False;
  Pedido := TControllerPedido.create(Self);
  CtrlLote := TControllerCtrlLote.create(Self);

end;

procedure TFr_Pedido_Vda.MenuItem2Click(Sender: TObject);
Var
  Lc_Form : TFr_Ctrl_Lote_Saida;
begin
  if Fc_VerificaExistenciaItem then
  Begin
    try
      Lc_Form := TFr_Ctrl_Lote_Saida.Create(nil);
      Lc_Form.It_Cd_Item := Qr_ItensTro.FieldByname('ITF_CODIGO').AsInteger;
      Lc_Form.It_Tipo := 'TROCA';
      Lc_Form.it_Cd_produto := Qr_ItensTro.FieldByname('ITF_CODPRO').AsInteger;
      Lc_Form.It_Cd_Empresa := StrToIntDef(E_Cd_Empresa.Text,1);
      Lc_Form.It_Qtde_Lote := Qr_ItensTro.FieldByname('ITF_QTDE').AsFloat;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  End;
end;

procedure TFr_Pedido_Vda.MenuItem3Click(Sender: TObject);
Var
  Lc_Form : TRegService;
begin
  Lc_Form := TRegService.Create(nil);
  Try
    Lc_Form.CodigoRegistro := Qr_ItensSrv.FieldByName('ITF_CODPRO').AsInteger;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Pedido_Vda.MenuItem5Click(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Produtos.Create(nil);
      Lc_Form.Produto.Registro.Codigo := Qr_ItensTRo.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil( Lc_Form );
      Qr_ItensVda.Active := False;
      Qr_ItensVda.Active := true;
    End;
  end;
end;

function  TFr_Pedido_Vda.Fc_VerificaExistenciaItem():Boolean;
Begin
  Result := True;
  If Qr_ItensVda.RecordCount = 0 then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor insira um item antes de continuar.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;



end;

procedure TFr_Pedido_Vda.Fm_FormaPagto1DBLCB_FormaPagtoClick(Sender: TObject);
begin
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) then
    Pc_descontoAutomatico;
end;

procedure TFr_Pedido_Vda.Fm_FormaPagtoExit(Sender: TObject);
begin
 If DM_ListaConsultas.Qr_ListaCliente.FieldByname('EMP_STCRED').AsString = 'B' then
    Begin
    If Fm_FormaPagto.DBLCB_FormaPagto.Text = 'CARTEIRA' then
      Begin
      ShowMessage('Forma de Pagamento indisponivel'+#13+
                  'para este Cliente, selecione outra!!');
      If Fm_FormaPagto.DBLCB_FormaPagto.CanFocus then  Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
      end;
    end;
  Pc_DinheiroFormaPgt;
end;

procedure TFr_Pedido_Vda.Fm_LMEchbx_EmpresasClick(Sender: TObject);
begin
  Fm_LME.chbx_EmpresasClick(Sender);

end;

procedure TFr_Pedido_Vda.Fm_VendedorPedidoSb_MedidaClick(Sender: TObject);
begin
  Fm_VendedorPedido.Sb_CadastroClick(Sender);

end;

procedure TFr_Pedido_Vda.Fm_FormaPagto1SB_FormaPagClick(Sender: TObject);
begin
  Fm_FormaPagto.SB_FormaPagClick(Sender);
  Pedido.Registro.FormaPagto :=Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
  PC_Sel_FormPagto(It_bloqueio);
end;

procedure TFr_Pedido_Vda.InformaoCombustivel1Click(Sender: TObject);
Var
  Form : TTasNfeItensFuel;
begin
  try
    Form := TTasNfeItensFuel.create(nil);
    Form.CodigoRegistro := Qr_ItensVdaITF_CODIGO.AsInteger;
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Pedido_Vda.InformarContrato1Click(Sender: TObject);
Var
  Lc_Form : TTasContractOrder;
begin
  if Pedido.Registro.Codigo > 0 then
  Begin
    try
      Lc_Form := TTasContractOrder.create(nil);
      Lc_Form.CodigoRegistro := Pedido.Registro.Codigo;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  End;
end;

procedure TFr_Pedido_Vda.InformarNmerodeCompraClick(Sender: TObject);
Var
  Lc_Form : TFr_Info_Compra_Venda;
  Lc_I : Integer;
begin
  if Fc_VerificaExistenciaItem then
  Begin
    Try
      Lc_Form := TFr_Info_Compra_Venda.Create(nil);
      Lc_Form.It_Cd_Pedido := Pedido.Registro.Codigo;
      Lc_Form.It_Cd_Item := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Pedido_Vda.EscolheTabela;
begin
  ControleElementos(false);
  Qr_ItensVda.First;
  Fm_ListaTabelaPreco.Listar(Qr_ItensVda.FieldByName('ITF_CODTPR').asinteger);
  Fm_ListaTabelaPreco.Dblcb_Lista.SetFocus;
  Application.ProcessMessages
end;

procedure TFr_Pedido_Vda.ExluirPedido;
Var
  Lc_Lst_Lote : TStringList;
begin
  Try
    Pc_Delete_Estoque('P',pedido.Registro.Codigo,0);
    if not Qr_ItensVda.active then Qr_ItensVda.active := True;
    Qr_ItensVda.First;
    Lc_Lst_Lote := TStringList.Create;
    Lc_Lst_Lote.Clear;
    while not Qr_ItensVda.Eof do
    Begin
      CtrlLote.Movimento.Registro.Vinculo := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
      CtrlLote.Movimento.Registro.Tipo := 'VENDA';
      CtrlLote.Movimento.Registro.Sentido := 'S';
      CtrlLote.Movimento.deleteByVinculo;
      //Deletar itens da base de troca
      pedido.Itens.BaseTroca.Registro.Item := Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger;
      pedido.Itens.BaseTroca.delete;
      Qr_ItensVda.Next;
    End;
    if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
    Begin
      Case Gb_Cd_Wsr of
        2:Begin
            while not Qr_ItensVda.Eof do
            Begin
              Pc_Ws_Estoque('I',Fc_BuscaCodigoEstoqueProduto(Qr_ItensVda.fieldbyName('ITF_CODEST').AsInteger,Qr_ItensVda.fieldbyName('ITF_CODPRO').AsInteger));
              Qr_ItensVda.Next;
            end;
        End;
      End;
    end;
    pedido.enviaLixeira;
    Pc_Log_Sistema( Gb_CodMha,
                    GB_Cd_Usuario,
                    now,
                    'Pedido de Venda',
                    Pedido.Registro.Codigo,
                   'Exclusão do Pedido de venda',
                   'PEDIDO NUMERO: ' + IntToStr(Pedido.Registro.Numero));
    Pedido.using('L');
    Pc_Buscar;
    Pg_Pedido_Vda.ActivePageIndex := 1;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  Finally
    FreeAndNil(Lc_Lst_Lote);
  End;

end;

procedure TFr_Pedido_Vda.E_Aq_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Pedido : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Pedido := StrtoFloatDef(E_VL_Produto.Caption,0) + StrtoFloatDef(E_Vl_Servico.Caption,0);
  Lc_Aq_Desconto := StrToFloatDef(E_Aq_Desconto.Text,0);

  Lc_VL_Desconto := ((Lc_Vl_Pedido * Lc_Aq_Desconto) /100 );
  Lc_VL_Desconto := RoundTo(Lc_VL_Desconto,-2);
  pedido.AplicarValorDescontoItens(pedido.Registro.Codigo,Lc_VL_Desconto);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  E_VL_Desconto.Text := FloatToStrF(Lc_VL_Desconto,ffFixed,10,2);
  Pc_AtualizaCampos;
  Pc_totalizador;
end;

procedure TFr_Pedido_Vda.DadosdoNCM1Click(Sender: TObject);
Var
  Lc_Form : TFr_ncm;
begin
  Try
    Lc_Form := TFr_ncm.Create(nil);
    Lc_Form.It_Cd_Ncm := Qr_ItensVda.FieldByName('PRO_CODIGONCM').AsString;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Pedido_Vda.Sb_Ins_TrocaClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_Tro;
begin
  If (E_Cd_Empresa.Focused) OR (DBLCB_Empresa.Focused) then exit;
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
  Begin
    If Fc_ValidaGravacao THEN
    Begin
      Pc_Gravar;
    end;
  end;
  try
    //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_Tro.Create(nil);
    Lc_Form.it_Cd_Empresa := Pedido.Registro.Empresa;
    Lc_Form.Terminal := Pedido.Registro.Terminal;
    Lc_Form.Pc_StateChange(2);
    Lc_Form.It_MultiplicadorPreco := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
    Lc_Form.ItensNFL.Registro.CodigoPedido := Pedido.Registro.Codigo;
    Lc_Form.E_Qt_Produto.Text := '1';
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Qr_ItensDev.Active := False;
    Qr_ItensDev.Active := True;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_DinheiroFormaPgt;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_descontoAutomatico;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Alt_TrocaClick(Sender: TObject);
Var
  Lc_Form : TFr_Itens_Produto_Tro;
begin
  try
    //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_Tro.Create(nil);
    Lc_Form.Pc_StateChange(3);
    Lc_Form.It_Inserir := True;
    Lc_Form.It_MultiplicadorPreco := DM_ListaConsultas.Qr_ListaCliente.FieldByName('EMP_MULTIPLICADOR').AsFloat;
    Lc_Form.ItensNFL.Registro.CodigoPedido := Pedido.Registro.Codigo;
    Lc_Form.Terminal := Pedido.Registro.Terminal;
    Lc_Form.editItems(Qr_ItensTro.FieldByName('ITF_CODIGO').AsInteger);
    Lc_Form.Pc_Totalizador;
    //Ativar Tabela de Estoque
    Lc_Form.Qr_Tabela.Active := True;
    Lc_Form.it_Modalidade_preco := Fc_DefineTabela;
    Lc_Form.it_TipoCliente := Fc_DefineTipoPessoa;
    Lc_Form.It_Dt_Operacao := E_Data.Date;
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'S';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;

  finally
    FreeAndNil(Lc_Form);
    Qr_ItensTro.Active := False;
    Qr_ItensTro.Active := True;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_descontoAutomatico;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Vda.Sb_Exc_TrocaClick(Sender: TObject);
begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+Qr_ItensTro.FieldByName('PRO_DESCRICAO').AsString +' desta venda.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
    Pc_Delete_Estoque('P',0,Qr_ItensTro.FieldByName('ITF_CODIGO').AsInteger);
    //Atualiza estoque na internet
    if (Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','') = 'S') then
    BEgin
      Case Gb_Cd_Wsr of
        2:Pc_Ws_Estoque('I',Fc_BuscaCodigoEstoqueProduto(Qr_ItensVda.fieldbyName('ITF_CODEST').AsInteger,Qr_ItensVda.fieldbyName('ITF_CODPRO').AsInteger));
      End;
    End;
    Pedido.Itens.Registro.Codigo := Qr_ItensTro.FieldByName('ITF_CODIGO').AsInteger;
    Pedido.Itens.delete;
    Qr_ItensTro.Active := False;
    Qr_ItensTro.Active := True;
    PC_Sel_PrazoPagto(It_bloqueio);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Pedido_Vda.Qr_ItensTroAfterOpen(DataSet: TDataSet);
begin
  if Qr_ItensTro.RecordCount > 0 then
  Begin
    (Qr_ItensTroITF_VL_UNIT as TNumericField).DisplayFormat     := '0.00######';
    (Qr_ItensTroITF_VL_SUBTOTAL as TNumericField).DisplayFormat := '0.00';
    (Qr_ItensTroITF_VL_SUBTOTAL as TNumericField).DisplayFormat := '0.00';
  End;
end;





procedure TFr_Pedido_Vda.Pc_Abre_Config_Global;
Begin
  chbx_Ctrl_Tabela_Prazo.Checked := Fc_Tb_Geral('L','VDA_G_CTRL_TABELA_X_PRAZO','') = 'S';
  chk_contr_cliente.Checked      :=  Fc_Tb_Geral('L','VDA_G_EDIT_CLIENTE_PEDIDO','') = 'S';
  chk_contr_vendedor.Checked      :=  Fc_Tb_Geral('L','VDA_G_EDIT_VENDEDOR_PEDIDO','') = 'S';
  Chbx_controle_venda.Checked := (Fc_Tb_Geral('L','VDA_G_CTRL_SEQUENCIA','S') = 'S');
  ChBx_Libera_Comissao.Checked   := Fc_Tb_Geral('L','VDA_G_EDIT_AQ_COM','S') = 'S';
  ChBx_Libera_Valor.Checked   := Fc_Tb_Geral('L','VDA_G_EDIT_VL_UNIT','S') = 'S';
  Chbx_Qtde_Venda_Promocao.Checked := (Fc_Tb_Geral('L','VDA_G_PROMOCAO_QUANTIDADE','S') = 'S');
  chbx_M2.Checked :=  (Fc_Tb_Geral('L','VDA_G_CALCULO_METRO_QUADRADO', '')='S');
  chbx_mostra_vendedor.Checked := (Fc_Tb_Geral('L','VDA_G_MOSTRA_VENDEDOR','S') ='S');
  ChBx_LancaLoteAuto.Checked   := (Fc_Tb_Geral('L','VDA_G_LANCALOTEAUTO','S') = 'S');
  ChBx_Ctrl_Estoque_Pedido.Checked  := (Fc_Tb_Geral('L','VDA_G_CTRL_EST_PEDIDO','S') = 'S');


  ChBx_Ctrl_Preco_Tipo_Cliente.Checked := ( Fc_Tb_Geral('L','VDA_G_CTRL_TB_TP_CLIENTE','N') = 'S');

  //tipo de parcelmento
  if Fc_Tb_Geral('L','VDA_G_CTRL_PARCELA','') = 'A' THEN
    RG_TIPOPARCELAMENTO.ItemIndex := 0
  else
    RG_TIPOPARCELAMENTO.ItemIndex := 1;

  //desconto max pedido
  E_Aliq_Desconto.Text := Fc_Tb_Geral('L','VDA_G_DESC_MAX_GERAL',E_Aliq_Desconto.Text);

  //desconto pagamento a vista
  ed_desc_avista.Text:=   Fc_Tb_Geral('L','VDA_G_DESC_PAGTO_VISTA','');

  chbx_copiapedidovenda.Checked := (Fc_Tb_Geral('L','VDA_G_COPIA_PEDIDO', 'N') = 'S');

  Chbx_Emite_Boleto.Checked := (Fc_Tb_Geral('L','VDA_G_EMITE_BOLETO', 'N') = 'S');

  ChBx_BaixaAutomaticaPedido.Checked := (Fc_Tb_Geral('L','VDA_G_BAIXA_PED_AUTO','N') = 'S');

  ChBx_ComissaoProduto.Checked := (Fc_Tb_Geral('L','OSR_G_PDV_COM_PROD','S') = 'S');
  //Valida Lucratividade
  e_Valida_Lucratividade.Text := Fc_Tb_Geral('L','VDA_G_VAL_LUCRATIVIDADE','0');

  ChBx_preco_acima.Checked := (Fc_Tb_Geral('L','VDA_G_PRECO_ACIMA','S') = 'S');

  chbx_nao_mostra_valor_usuario.Checked := ( Fc_Tb_Geral('L','VDA_G_NO_SHOW_VALUES','N') = 'S');

  chbx_somente_vendedor_visualiza.Checked := ( Fc_Tb_Geral('L','VDA_G_SO_VENDEDOR_VISUALIZA','N') = 'S');

  Chbx_Vendedor_Cliente.Checked := ( Fc_Tb_Geral('L','VDA_G_VENDEDOR_CLIENTE','N') = 'S');


end;

procedure TFr_Pedido_Vda.Pc_Grava_Config_Global;
Begin
  if chbx_Ctrl_Tabela_Prazo.Checked  then
    Fc_Tb_Geral('G','VDA_G_CTRL_TABELA_X_PRAZO','S')
  else
    Fc_Tb_Geral('G','VDA_G_CTRL_TABELA_X_PRAZO','N');

  if chk_contr_cliente.Checked = true then
    Fc_Tb_Geral('G','VDA_G_EDIT_CLIENTE_PEDIDO','S')
  else
    Fc_Tb_Geral('G','VDA_G_EDIT_CLIENTE_PEDIDO','N');

  if chk_contr_vendedor.Checked = true then
    Fc_Tb_Geral('G','VDA_G_EDIT_VENDEDOR_PEDIDO','S')
  else
    Fc_Tb_Geral('G','VDA_G_EDIT_VENDEDOR_PEDIDO','N');

  if Chbx_controle_venda.Checked then
    Fc_Tb_Geral('G','VDA_G_CTRL_SEQUENCIA','S')
  else
    Fc_Tb_Geral('G','VDA_G_CTRL_SEQUENCIA','N');

  if ChBx_Libera_Comissao.Checked then
    Fc_Tb_Geral('G','VDA_G_EDIT_AQ_COM','S')
  else
    Fc_Tb_Geral('G','VDA_G_EDIT_AQ_COM','N');

  if ChBx_Libera_Valor.Checked then
    Fc_Tb_Geral('G','VDA_G_EDIT_VL_UNIT','S')
  else
    Fc_Tb_Geral('G','VDA_G_EDIT_VL_UNIT','N');

  if Chbx_Qtde_Venda_Promocao.Checked then
    Fc_Tb_Geral('G','VDA_G_PROMOCAO_QUANTIDADE','S')
  else
    Fc_Tb_Geral('G','VDA_G_PROMOCAO_QUANTIDADE','N');

  if chbx_M2.Checked then
    Fc_Tb_Geral('G','VDA_G_CALCULO_METRO_QUADRADO','S')
  else
    Fc_Tb_Geral('G','VDA_G_CALCULO_METRO_QUADRADO','N');

  if chbx_mostra_vendedor.Checked   then
    Fc_Tb_Geral('G','VDA_G_MOSTRA_VENDEDOR','S')
  else
    Fc_Tb_Geral('G','VDA_G_MOSTRA_VENDEDOR','N');

  if ChBx_LancaLoteAuto.Checked   then
    Fc_Tb_Geral('G','VDA_G_LANCALOTEAUTO','S')
  else
    Fc_Tb_Geral('G','VDA_G_LANCALOTEAUTO','N');

  if ChBx_Ctrl_Estoque_Pedido.Checked then
    Fc_Tb_Geral('G','VDA_G_CTRL_EST_PEDIDO','S')
  else
    Fc_Tb_Geral('G','VDA_G_CTRL_EST_PEDIDO','N');

  //tipo de parcelmaneto
  if RG_TIPOPARCELAMENTO.ItemIndex = 0 then
    Fc_Tb_Geral('G','VDA_G_CTRL_PARCELA','A')
  ELSE
    Fc_Tb_Geral('G','VDA_G_CTRL_PARCELA','C');

  //desconto max pedido
  Fc_Tb_Geral('G','VDA_G_DESC_MAX_GERAL',E_Aliq_Desconto.Text);

  //desconto pagamento a vista
  Fc_Tb_Geral('G','VDA_G_DESC_PAGTO_VISTA', ed_desc_avista.Text);

  if chbx_copiapedidovenda.Checked then
    Fc_Tb_Geral('G','VDA_G_COPIA_PEDIDO', 'S')
  else
    Fc_Tb_Geral('G','VDA_G_COPIA_PEDIDO', 'N');

  if Chbx_Emite_Boleto.Checked then
    Fc_Tb_Geral('G','VDA_G_EMITE_BOLETO', 'S')
  else
    Fc_Tb_Geral('G','VDA_G_EMITE_BOLETO', 'N');


  if ChBx_BaixaAutomaticaPedido.Checked then
    Fc_Tb_Geral('G','VDA_G_BAIXA_PED_AUTO','S')
  else
    Fc_Tb_Geral('G','VDA_G_BAIXA_PED_AUTO','N');

  if ChBx_ComissaoProduto.Checked then
    Fc_Tb_Geral('G','OSR_G_PDV_COM_PROD','S')
  else
    Fc_Tb_Geral('G','OSR_G_PDV_COM_PROD','N');

  //Valida Lucratividade
  Fc_Tb_Geral('G','VDA_G_VAL_LUCRATIVIDADE',e_Valida_Lucratividade.Text);

  if ChBx_Ctrl_Preco_Tipo_Cliente.Checked then
    Fc_Tb_Geral('G','VDA_G_CTRL_TB_TP_CLIENTE','S')
  else
    Fc_Tb_Geral('G','VDA_G_CTRL_TB_TP_CLIENTE','N');


  if ChBx_preco_acima.Checked then
    Fc_Tb_Geral('G','VDA_G_PRECO_ACIMA','S')
  else
    Fc_Tb_Geral('G','VDA_G_PRECO_ACIMA','N');

  if chbx_nao_mostra_valor_usuario.Checked then
    Fc_Tb_Geral('G','VDA_G_NO_SHOW_VALUES','S')
  else
    Fc_Tb_Geral('G','VDA_G_NO_SHOW_VALUES','N');

  if chbx_somente_vendedor_visualiza.Checked then
    Fc_Tb_Geral('G','VDA_G_SO_VENDEDOR_VISUALIZA','S')
  else
    Fc_Tb_Geral('G','VDA_G_SO_VENDEDOR_VISUALIZA','N');

  if Chbx_Vendedor_Cliente.Checked then
    Fc_Tb_Geral('G','VDA_G_VENDEDOR_CLIENTE','S')
  else
    Fc_Tb_Geral('G','VDA_G_VENDEDOR_CLIENTE','N');
  FUtilizaVendedorCliente := Chbx_Vendedor_Cliente.Checked;
end;

procedure TFr_Pedido_Vda.Pc_Abre_Config_Local;
Begin
  //imprimi pedido impressora
  GrBx_Ped_Imp.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_IMPRESSORA',''),0);

  E_PortaImpressao_vda.Text := Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_PORTA',E_PortaImpressao_vda.Text);
  E_SaltoImpressao_vda.Text :=Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO','0');

  //modelo de impressao estilo matricial
  Cbx_TipoComp.ItemIndex :=   StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_MOD_MATRICIAL', ''),1)-1;

  //modelo de impressao estilo lase
  cbx_estliloLase.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_MOD_JATOLASER', ''),1)-1;

  //Ites por folha
  E_ItensPP.Text := Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA','');



end;

procedure TFr_Pedido_Vda.Pc_Grava_Config_Local;
Begin
  //imprimi pedido impressora
  Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_IMPRESSORA',IntToStr(GrBx_Ped_Imp.ItemIndex));

  Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_PORTA',E_PortaImpressao_vda.Text);
  Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_SALTO',E_SaltoImpressao_vda.Text);

  //modelo de impressao estilo matricial
  Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_MOD_MATRICIAL', IntToStr(Cbx_TipoComp.ItemIndex+1));

  //modelo de impressao estilo lase
  Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_MOD_JATOLASER', IntToStr(cbx_estliloLase.ItemIndex+1));


  //Ites por folha
  Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA',E_ItensPP.Text);


end;

procedure TFr_Pedido_Vda.Pc_grava_Perfil_Local;
begin
  if (WindowState = wsNormal) then
    Fc_Aq_Geral('G','PEDIDOVDA','CRB_TELA_MAXIM','N')
  else
    Fc_Aq_Geral('G','PEDIDOVDA','CRB_TELA_MAXIM','S');
end;

procedure TFr_Pedido_Vda.Pop_ConfigGlobalClick(Sender: TObject);
begin
  if Gb_Nivel = 1 then
    Begin
    Pg_Pedido_Vda.ActivePage := tbs_Config_Global;
    Pc_Abre_Config_Global;
    end
  else
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'As configurações Globais são permitidas apenas' + EOLN +
                   'para usuários administradores pois influenciam todo o sistema.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    end;
end;

procedure TFr_Pedido_Vda.Pop_ConfigLocalClick(Sender: TObject);
begin
  Pg_Pedido_Vda.ActivePage := tbs_Config_Local;
  Pc_Abre_Config_Local
end;

procedure TFr_Pedido_Vda.Btn_Ap_LocalClick(Sender: TObject);
begin
  Pc_Grava_Config_Local;
end;

procedure TFr_Pedido_Vda.Btn_Cn_LocalClick(Sender: TObject);
begin
  Pg_Pedido_Vda.ActivePage := tbs_Pesquisa;
end;

procedure TFr_Pedido_Vda.Btn_Ok_LocalClick(Sender: TObject);
begin
  Pc_Grava_Config_Local;
  Pg_Pedido_Vda.ActivePage := tbs_Pesquisa;
end;

procedure TFr_Pedido_Vda.AlteraTabeladePreo1Click(Sender: TObject);
begin
  if not EmNavegacao then
  Begin
    EscolheTabela;
  end;
end;

procedure TFr_Pedido_Vda.AplicarLote1Click(Sender: TObject);
Var
  LcRes : Boolean;
  LcMsg : String;
begin
  if Pedido.Registro.Codigo > 0 then
  Begin
    try
      Self.Enabled := False;
      //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
      Fc_AuditoriaEstoquePedido(Pedido.Registro.Codigo,'N');

      LcRes := CtrlLote.AplicaLotePedido(Pedido.Registro.Codigo);
      if LcRes then
        LcMsg := 'Lote Aplicado devidamente conforme disponibilidade.'
      else
        LcMsg := 'Lote já aplicado anteriormente ou não há lote disponivel';
    finally

      Self.Enabled := True;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Processo Finalizado com Sucesso' + EOLN +
                     LcMsg + EOLN,
                     ['OK'], [bEscape], mpAlerta);
    end;
  End;
end;

procedure TFr_Pedido_Vda.AuditoriadeEstoqueClick(Sender: TObject);
begin
  if Pedido.Registro.Codigo > 0 then
  Begin
    try
      Self.Enabled := False;
      //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
      Fc_AuditoriaEstoquePedido(Pedido.Registro.Codigo,'N');
    finally
      Self.Enabled := True;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Audtioria de estoque finalizada com Sucesso' + EOLN + EOLN,
                     ['OK'], [bEscape], mpAlerta);
    end;
  End;
end;

procedure TFr_Pedido_Vda.Btn_Ap_GlobalClick(Sender: TObject);
begin
  Pc_Grava_Config_Global;
end;

procedure TFr_Pedido_Vda.Btn_Cn_GlobalClick(Sender: TObject);
begin
  Pg_Pedido_Vda.ActivePage := tbs_Pesquisa;
end;

procedure TFr_Pedido_Vda.Btn_Ok_GlobalClick(Sender: TObject);
begin
  Pc_Grava_Config_Global;
  Pg_Pedido_Vda.ActivePage := tbs_Pesquisa;
end;

procedure TFr_Pedido_Vda.SpeedButton1Click(Sender: TObject);
Var
  Lc_Form : TFr_Info_Origen_Sale;
begin
  Try
    Lc_Form := TFr_Info_Origen_Sale.Create(nil);
    Lc_Form.ShowModal;
    if (Lc_Form.It_cd_Sale_Origens > 0) then
      Pedido.Registro.TipoContato :=  InttoStr(Lc_Form.It_cd_Sale_Origens);
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Pedido_Vda.Pc_FormataStrGrd_Pedido;
Var
  Lc_X:Integer;
Begin
  //Definir tamanho Da grade de Parcelas
  with StrGrd_Pedido do
    Begin
    ColWidths[0] := 17;
    ColWidths[1] := -1;
    ColWidths[2] := 54;
    ColWidths[3] := 64;
    ColWidths[4] := 70;
    ColWidths[5] := 295;
    ColWidths[6] := 74;
    ColWidths[7] := -1;
    Cols[2].Add('Selecionar');
    Cols[3].Add('Data');
    Cols[4].Add('Pedido');
    Cols[5].Add('Nome');
    Cols[6].Add('Valor');
    end;
end;

procedure TFr_Pedido_Vda.Pc_PreencherPedidoOperacaoGrupo;
VAr
   Lc_I, Lc_J, Lc_registro: Integer;
BEgin
  Screen.Cursor := crHourGlass;
  Lc_registro := 0;
  with Qr_Pesquisa,StrGrd_Pedido do
    Begin
    First;
    while not Eof do
      begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      Cells[1, Lc_registro] := FieldByName('PED_CODIGO').AsString;
      Cells[3, Lc_registro] := FieldByName('PED_DATA').AsString;
      Cells[4, Lc_registro] := FieldByName('PED_NUMERO').AsString;
      Cells[5, Lc_registro] := FieldByName('EMP_FANTASIA').AsString;
      Cells[5, Lc_registro] := FieldByName('EMP_FANTASIA').AsString;
      Cells[6, Lc_registro] := FloatToStrF(FieldByName('PED_VL_PEDIDO').AsCurrency, ffFixed, 10, 2);
      Next;
      end;
    Repaint;
    IF RecordCount > 0 THEN
      Begin
      SB_Add_Tudo.Enabled:= True;
      SB_Retirar_Tudo.Enabled:= True;
      end
    ELSE
      Begin
      SB_Add_Tudo.Enabled:= False;
      SB_Retirar_Tudo.Enabled:= False;
      end;
    end;
  Screen.Cursor := crDefault;
end;

procedure TFr_Pedido_Vda.Pc_AtualizaOperacaoGrupo_Data;
Var
  Lc_Qry : TSTQuery;
  Lc_I:Integer;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('update "TB_PEDIDO set '+
              ' PED_DATA = :PED_DATA '+
              'where PED_CODIGO=:PED_CODIGO');
      For Lc_I:= 1 to StrGrd_Pedido.RowCount do
      Begin
        IF StrGrd_Pedido.Cells[7,Lc_I]= 'X' then
        Begin
          Active := False;
          ParamByName('PED_DATA').AsDateTime := E_DataAlteraGRupo.DateTime;
          ParamByName('PED_CODIGO').AsInteger := StrToIntDef(StrGrd_Pedido.Cells[1,Lc_I],0);
          ExecSQL;
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

procedure TFr_Pedido_Vda.MnuOperaesemGrupoClick(Sender: TObject);
begin
  if Qr_Pesquisa.RecordCount > 0 then
    Begin
    Pg_Pedido_Vda.ActivePage := tbs_oper_Grupo;
    Pc_FormataStrGrd_Pedido;
    Pc_LimpaStringGrid(StrGrd_Pedido);
    Pc_PreencherPedidoOperacaoGrupo;
    end
  else
    Begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Nenhum registo para operação.'+EOLN+
                   ' Verifique os filtros e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    end;

end;

procedure TFr_Pedido_Vda.StrGrd_PedidoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with StrGrd_Pedido do
    Begin
    if (ACol = 2)and(ARow>0) Then
      begin
      if (Cells[1,ARow] <> '') then
        Begin
        if (Cells[7,ARow] = 'X') then
          DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
        else
          DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
        end;
      end
    else
      Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
        Begin
        if (Cells[7,ARow] = '') then
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
          end
        else
          Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
          end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da célula
        Texto := Cells[acol, ARow];

        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);

        // Calcula a posição horizontal do início do texto
        if  (ACol = 4) or (ACol = 5) then // esquerda
          X := Rect.Left + 2
        else
        if  (ACol = 3)   then // Centro
          X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
        else // Direita
          X := Rect.Right - LarguraTexto - 2;

        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
        end;
      end;
    end;

end;

procedure TFr_Pedido_Vda.Tbs_ServicoShow(Sender: TObject);
begin
  Pc_AbrirItensServico
end;

procedure TFr_Pedido_Vda.Tbs_TrocaShow(Sender: TObject);
begin
  Pc_AbrirItensTroca
end;

procedure TFr_Pedido_Vda.Tbs_DevolucaoShow(Sender: TObject);
begin
  Pc_AbrirItensDevolucao
end;

procedure TFr_Pedido_Vda.SB_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Pedido do
    Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[7,Lc_I] := 'X';
      end;
    Repaint;
    end;

end;

procedure TFr_Pedido_Vda.SB_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Pedido do
    Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[7,Lc_I] := '';
      end;
    Repaint;
    end;

end;

procedure TFr_Pedido_Vda.StrGrd_PedidoClick(Sender: TObject);
begin
  with StrGrd_Pedido do
    Begin
    IF Cells[7,Row]= 'X' then
      Cells[7,Row] := ''
    else
      Cells[7,Row] := 'X';
    Repaint;
    end;
end;

procedure TFr_Pedido_Vda.Sb_Grp_AtualizarClick(Sender: TObject);
begin
  if Fc_VerificaItemGridSelecionado(StrGrd_Pedido,7) then
    Begin
    try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      Pc_AtualizaOperacaoGrupo_Data;
      MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                     ' Operação realiada com sucesso.'+EOLN,
                     ['OK'],[bEscape],mpInformacao);
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    end;
    end;
end;

procedure TFr_Pedido_Vda.Sb_VoltaGrupoClick(Sender: TObject);
begin
  Pc_LimpaStringGrid(StrGrd_Pedido);
  Pg_Pedido_Vda.ActivePage := tbs_Pesquisa;
end;

procedure TFr_Pedido_Vda.setFAbrirNovo(const Value: Boolean);
begin
  FAbrirNovo := Value;
end;

procedure TFr_Pedido_Vda.SpeedButton2Click(Sender: TObject);
Var
  Lc_Form : TFr_Info_Origen_Customer;
begin
  Try
    Lc_Form := TFr_Info_Origen_Customer.Create(nil);
    Lc_Form.ShowModal;
    if (Lc_Form.It_cd_Customer_Origens > 0) then
      Pedido.Registro.Tipo := Lc_Form.It_cd_Customer_Origens;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

function TFr_Pedido_Vda.Fc_ValidaInfoOrigemCustomer():Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Form : TFr_Info_Origen_Customer;
  Lc_cd_Customer_Origens : String;
Begin
  Result := True;
  IF Pedido.Registro.Tipo = 0 then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('select id FROM tb_customer_origen where (id>0) ');
        Active := True;
        FetchAll;
        if recordCount > 0 then
        Begin
          Lc_Form := TFr_Info_Origen_Customer.Create(nil);
          Lc_Form.ShowModal;
          if (Lc_Form.It_cd_Customer_Origens = 0) then
          Begin
            Result := False;
            MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                           'Origem do Cliente não informado.'+EOLN+EOLN+
                           'Por favor escolha uma opção para continuar'+EOLN+EOLN,
                            ['OK'],[bEscape],mpAlerta
                            );

          end
          else
          Begin
            Pedido.Registro.Tipo := Lc_Form.It_cd_Customer_Origens
          end;
          FreeAndNil(Lc_Form);
        end;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  end;
end;

procedure TFr_Pedido_Vda.MnuEnviaPedidoClick(Sender: TObject);
begin
  if (trim(Fc_Tb_Geral('L','PED_G_BANCO_DESTINO', '')) <> '') then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja efetuar uma cópia de Pedido/Nota existente para outro Banco de Dados.'+EOLN+EOLN+
                       'Confirmar a Cópia ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
      Fc_EnviaPedidoNota(1);
    end;
  end
  else
  Begin
    MensagemPadrao(TITULO_CONFIRMACAO, ATENCAO + EOLN + EOLN +
                   'O Caminho do Banco de Destino não está configurado.' + EOLN + EOLN +
                   'Para Configurar vá no menu Administração - Configurações,' + EOLN +
                   'e dentro do módulo Configurações Gerais clique em Pedido(s) e informe o caminho do Banco de Destino.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_Pedido_Vda.MnuAcompanhamentoClick(Sender: TObject);
Var
  Form : TTasFollowup;
begin
  Try
    Form := TTasFollowup.Create(nil);
    if Pg_Pedido_Vda.ActivePageIndex = 0 then
      Form.CodigoRegistro := Pedido.Registro.Codigo
    ELSE
      Form.CodigoRegistro := Qr_Pesquisa.FieldByName('PEd_CODIGO').AsInteger;
    Form.ShowModal;
  Finally
    FreeAndNil(form);
  End;

end;

procedure TFr_Pedido_Vda.AbrirOrdemServico;
Var
  LcModulo : String;
begin
  LcModulo := Fc_Tb_Geral('L','OSR_G_TIPO_MODULO','AUTO CENTER');
  case AnsiIndexStr(LcModulo, ['AUTO CENTER','EQUIPAMENTOS ELETRÔNICOS','PET SHOP','MOVELEIRO','GRÁFICA']) of
    0:AbrirOrdemServicoAutoCenter;
    1:AbrirOrdemServicoExtintores;
    2:AbrirOrdemServicoEletronicos;
    3:AbrirOrdemServicoPetShop;
    4:AbrirOrdemServicoMoveleiro;
    5:AbrirOrdemServicoPrintShop;
    else
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Nenhum módulo específico de serviço foi ativado' + EOLN + EOLN ,
                     ['OK'], [bEscape], mpAlerta);
    End;
  end;
end;

procedure TFr_Pedido_Vda.AbrirOrdemServicoAutoCenter;
Var
  Lc_Form : TFr_VehicleSo;
begin
  TRy
    Lc_Form := TFr_VehicleSo.Create(nil);
    with Lc_Form do
    begin
      with OrdemServico do
      Begin
        Registro.CodigoEstabelecimento := Gb_Codmha;
        Registro.CodigoCotacao := 0;
        Registro.CodigoPedido := Self.Pedido.Registro.Codigo;
        Vehicle.Registro.CodigoEmpresa := Self.Pedido.Registro.Empresa;
      End;
      ShowModal;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Pedido_Vda.AbrirOrdemServicoEletronicos;
Var
  LcForm : TTasOrderElectEquip;
begin
  try
    LcForm := TTasOrderElectEquip.Create(nil);
    LcForm.Conserto.Registro.Codped := Pedido.Registro.Codigo;
    LcForm.Conserto.getByPedido;
    if LcForm.Conserto.exist then
      LcForm.CodigoRegistro := LcForm.Conserto.Registro.Codigo
    else
      LcForm.CodigoRegistro := 0;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;


procedure TFr_Pedido_Vda.AbrirOrdemServicoExtintores;
begin
  ShowMessage('Módulo Desativado');
end;

procedure TFr_Pedido_Vda.AbrirOrdemServicoMoveleiro;
Var
  LcForm : TTasFurnitureOS;
begin
  try
    LcForm := TTasFurnitureOS.Create(nil);
    LcForm.CodigoRegistro := Pedido.Registro.Codigo;
    LcForm.FurnitureOS.Registro.Pedido := Pedido.Registro.Codigo;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Pedido_Vda.AbrirOrdemServicoPetShop;
Var
  LcForm : TTasOrderPetShop;
begin
  try
    LcForm := TTasOrderPetShop.Create(nil);
    LcForm.CodigoRegistro := Pedido.Registro.Codigo;
    LcForm.Cliente := Pedido.Registro.Empresa;
    LcForm.Atendimento.Registro.Pedido := Pedido.Registro.Codigo;

    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Pedido_Vda.AbrirOrdemServicoPrintShop;
Var
  LcForm : TTasOrderPrintShop;
begin
  try
    LcForm := TTasOrderPrintShop.Create(nil);
    LcForm.PrintShop.Registro.Ordem := Pedido.Registro.Codigo;
    LcForm.PrintShop.Registro.Estabelecimento := Gb_CodMha;
    LcForm.PrintShop.getByPedido;
    if LcForm.PrintShop.exist then
      LcForm.CodigoRegistro := LcForm.PrintShop.Registro.Codigo
    else
      LcForm.CodigoRegistro := 0;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Pedido_Vda.ActInclusaoRapidoProdutoExecute(Sender: TObject);
Var
  Lc_Form : TFr_InclusaoRapidaProduto;
begin
  if Pg_Pedido_Vda.ActivePage = tbs_pedido then
  Begin
    if Pedido.Registro.Codigo > 0 then
    Begin
      TRy
        Lc_Form := TFr_InclusaoRapidaProduto.create(nil);
        Lc_Form.It_Cd_Pedido := Pedido.Registro.Codigo;
        Lc_Form.ShowModal;
      Finally
        FreeAndNil(Lc_Form);
        Pc_DinheiroFormaPgt;
        Pc_AtualizaCampos;
        Pc_Totalizador;
        PC_Sel_PrazoPagto(It_bloqueio);
        Pc_descontoAutomatico;
        Pc_Gravar;
      End;
    End;
  End;
end;

procedure TFr_Pedido_Vda.Action1Execute(Sender: TObject);
Var
  Lc_Form:TFr_Liberacao;
begin
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
  Begin
    Lc_Form := TFr_Liberacao.Create(nil);
    Lc_Form.Liberado := False;
    Lc_Form.It_Interface := 'Fr_Pedido_Vda';
    Lc_Form.It_Nome_Menu := 'Pedido de Venda';
    Lc_Form.It_Privilegio := 'AUTORIZAR';
    Lc_Form.ShowModal;
    FreeandNil(Lc_Form);
  end;
end;

procedure TFr_Pedido_Vda.Sb_Pesq_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  Fm_VendedorPedido.ListaVendedor;
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
    DBLCB_EmpresaExit(Sender);
  end;
end;

procedure TFr_Pedido_Vda.MnuLiberarItensparaDespachoClick(Sender: TObject);
begin
  if ValidaEnvioPedidoParaDespacho then
  Begin
    EnvioPedidoParaDespacho;
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   ' Itens libeados para despacho com sucesso',
                   ['OK'], [bEscape], mpAlerta);
  End;
end;

procedure TFr_Pedido_Vda.Lucratividade1Click(Sender: TObject);
begin
  if Qr_ItensVda.RecordCount >0 then
  Begin
    Fc_AbreTelaLucratividade(pedido.Registro.Codigo,Qr_ItensVda.FieldByName('ITF_CODIGO').AsInteger);
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   '   Nenhum item selecinado.' + EOLN + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_Pedido_Vda.LucratividadePedidoAberto;
Var
  Lc_Form : TRL_ReportLucratividadePedidoAberto;
  Lc_Param : TParamLucratividade;
begin
  Try
    Lc_Form := TRL_ReportLucratividadePedidoAberto.create(nil);
    Lc_Param := TParamLucratividade.Create;
    Lc_Param.Periodo := False;
    Lc_Param.NumeroDocumento := Pedido.Registro.Numero.ToString;
    Lc_Form.Parametros := Lc_Param;
    Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE - PEDIDO EM ABERTO';
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

end.













