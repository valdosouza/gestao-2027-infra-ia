unit Un_Cotacao;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Vcl.Forms, Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, Buttons, ComCtrls, STStoredProc, STQuery, Printers, jpeg, QEdit_Setes, Menus, System.Math, ActnList, Actions, Un_Fm_FormaPagto, un_Fm_ListaColaboradores, ControllerPedido, Un_Fm_ListaTabelaPreco, ControllerCotacao, Un_Fm_ListaMultiEmpresa, ControllerCliente, ControllerBase, Un_Fm_ListaMarcaProduto, Un_Fm_ListaProdutos, base_frame_list,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
   TFr_Cotacao = class(TForm)
      Pg_Cotacao: TPageControl;
      tbs_cotacao: TTabSheet;
      tbs_pesquisa: TTabSheet;
      PrintDialog: TPrintDialog;
      Pnl_Fundo: TPanel;
      PG_Itens: TPageControl;
      TS_Produto: TTabSheet;
      GroupBox1: TGroupBox;
      Label36: TLabel;
      E_BuscaCliente: TMaskEdit;
      E_BuscaCotacao: TMaskEdit;
    pnl_Totalizar: TPanel;
      Label22: TLabel;
      Label11: TLabel;
      Label12: TLabel;
      Label7: TLabel;
      Label8: TLabel;
      Label26: TLabel;
    E_VL_Desconto: TEdit_Setes;
    E_Qt_Produto: TEdit_Setes;
    E_Aq_Desconto: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
      Pnl_Produto: TPanel;
      DBG_Produtos: TDBGrid;
      Qr_Pesquisa: TSTQuery;
      Ds_Pesquisa: TDataSource;
      Ds_Usuario: TDataSource;
      Ds_FormaPagto: TDataSource;
      Qr_Itens_Pro: TSTQuery;
      Qr_Acao: TSTQuery;
      Lb_Opcional: TLabel;
      Ds_Itens_Pro: TDataSource;
      Ds_Itens_Srv: TDataSource;
      Qr_Itens_Srv: TSTQuery;
    TabSh_Servico: TTabSheet;
      Pnl_Servico: TPanel;
      DBGrid2: TDBGrid;
      Qr_Itens: TSTQuery;
      TabSheet5: TTabSheet;
    E_obs: TMemo;
      E_VL_Produto: TPanel;
    ChBx_BuscaNome: TCheckBox;
    ChBx_BuscaFantasia: TCheckBox;
      E_Data_Ini: TDateTimePicker;
      E_Data_Fim: TDateTimePicker;
      Qr_Ordem: TSTQuery;
      ChBx_Periodo: TCheckBox;
    Sb_Ins_Produto: TBitBtn;
    Sb_Alt_Produto: TBitBtn;
    Sb_Exc_Produto: TBitBtn;
    E_Vl_Servico: TPanel;
    E_VL_Cotacao: TPanel;
    Pnl_Botao: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    SB_Pedido: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    SB_Enviar: TSpeedButton;
    dts_PrazoControlado: TDataSource;
    qr_prazo_controlado: TSTQuery;
    qr_prazo_controladoPRZ_PRAZO: TStringField;
    qr_prazo_controladoPRZ_CODIGO: TIntegerField;
    Label27: TLabel;
    E_Dt_Entrega: TEdit;
    Label3: TLabel;
    E_Garantia: TEdit;
    Validade: TLabel;
    E_Validade: TEdit;
    Grp_Pesquisa: TGroupBox;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    Pop_Produto: TPopupMenu;
    CadastrodoProduto: TMenuItem;
    Pop_Servico: TPopupMenu;
    MenuItem1: TMenuItem;
    Mnu_Controle: TMainMenu;
    Mnu_Tarefas: TMenuItem;
    popLucratividade: TMenuItem;
    Label5: TLabel;
    E_Vl_Adicional: TEdit_Setes;
    ActionList1: TActionList;
    Action1: TAction;
    tbs_Config_Global: TTabSheet;
    tbs_Config_Local: TTabSheet;
    Panel1: TPanel;
    Label15: TLabel;
    Panel2: TPanel;
    Label14: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Btn_Ok_Local: TButton;
    Btn_Cn_Local: TButton;
    Btn_Ap_Local: TButton;
    Label17: TLabel;
    Label18: TLabel;
    Label39: TLabel;
    rdg_PedOrc_Imp: TRadioGroup;
    GroupBox19: TGroupBox;
    e_porta_ImpOrc: TEdit;
    e_salto_Orc: TEdit_Setes;
    GroupBox21: TGroupBox;
    e_itens_oRC: TEdit_Setes;
    Cbx_TipoMatric: TComboBox;
    Cbx_TipoLaser: TComboBox;
    Cb_InterfaceCotacao: TComboBox;
    GroupBox20: TGroupBox;
    chbx_dias_Orc: TCheckBox;
    E_dias_Orc: TEdit_Setes;
    Rg_Parcela_Orca: TRadioGroup;
    Chbx_controle_orcamento: TCheckBox;
    Chbx_Comp_Orcamentos: TCheckBox;
    ChBx_Manipula_Orc: TCheckBox;
    ChBx_Libera_Valor: TCheckBox;
    Pop_ConfigLocal: TMenuItem;
    Pop_ConfigGlobal: TMenuItem;
    AlteraTabeladePreo: TMenuItem;
    Pnl_TabelaPreco: TPanel;
    Sb_Confirma_TabelaPreco: TButton;
    Sb_Cancela_TabelaPreco: TButton;
    Fm_ListaTabelaPreco: TFm_ListaTabelaPreco;
    Fm_LME: TFm_ListaMultiEmpresa;
    MnuCustodoPedido: TMenuItem;
    pnl_cfg_g_top: TPanel;
    chbx_nao_mostra_valor_usuario: TCheckBox;
    chbx_somente_vendedor_altera: TCheckBox;

    Label13: TLabel;
    E_BuscaEmail: TMaskEdit;
    Label42: TLabel;
    Label23: TLabel;
    Label47: TLabel;
    E_BuscaEstado: TMaskEdit;
    E_BuscaCidade: TMaskEdit;
    E_BuscaFone: TEdit_Setes;
    chbx_Alerta_Estoque: TCheckBox;
    Sb_InclusaoRapido: TBitBtn;
    pnl_Produto_item: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    SB_Cliente: TSpeedButton;
    Lb_Numero: TLabel;
    Label6: TLabel;
    Sb_Parcelamento: TSpeedButton;
    Label10: TLabel;
    Sb_Pesq_Cliente: TSpeedButton;
    E_Cd_Empresa: TEdit;
    E_Contato: TEdit;
    E_Data: TDateTimePicker;
    E_Nr_Parcelas: TMaskEdit;
    E_Prazo: TMaskEdit;
    E_email: TEdit;
    Cb_Empresa: TComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Fm_FormaPagto: TFm_FormaPagto;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    Fm_VendedorCotacao: TFm_ListaColaboradores;
    Fm_ListaAuxiliarVenda: TFm_ListaColaboradores;
    DBLCB_Prazo: TDBLookupComboBox;
    Pnl_Calculo_Custo: TPanel;
    Label16: TLabel;
    E_Mrg_Lucro: TEdit_Setes;
    Button1: TButton;
    Qr_Itens_ProPRO_CODIGOFAB: TStringField;
    Qr_Itens_ProPRO_VL_CUSTO: TFMTBCDField;
    Qr_Itens_ProPRO_DIVISOR: TIntegerField;
    Qr_Itens_ProTPR_MODALIDADE: TStringField;
    Qr_Itens_ProICT_CODIGO: TIntegerField;
    Qr_Itens_ProICT_CODCTC: TIntegerField;
    Qr_Itens_ProICT_TIPO: TStringField;
    Qr_Itens_ProICT_CODVCL: TIntegerField;
    Qr_Itens_ProICT_DESCRICAO: TStringField;
    Qr_Itens_ProICT_QTDE: TBCDField;
    Qr_Itens_ProICT_VL_UNIT: TFMTBCDField;
    Qr_Itens_ProICT_AQ_COM: TBCDField;
    Qr_Itens_ProICT_VL_DESC: TBCDField;
    Qr_Itens_ProICT_AQ_DESC: TBCDField;
    Qr_Itens_ProICT_AQ_IPI: TBCDField;
    Qr_Itens_ProICT_AQ_ICMS: TBCDField;
    Qr_Itens_ProICT_CODEST: TIntegerField;
    Qr_Itens_ProICT_CODTPR: TIntegerField;
    Qr_Itens_ProPRO_CODIGO: TIntegerField;
    Qr_Itens_ProICT_VL_CUSTO: TBCDField;
    Qr_Itens_ProICT_VL_SUBTOTAL: TFMTBCDField;
    Qr_Itens_ProTPR_NOME: TStringField;
    pnl_Botao_Vertical: TPanel;
    Qr_Itens_SrvICT_CODIGO: TIntegerField;
    Qr_Itens_SrvICT_CODCTC: TIntegerField;
    Qr_Itens_SrvICT_TIPO: TStringField;
    Qr_Itens_SrvICT_CODVCL: TIntegerField;
    Qr_Itens_SrvICT_DESCRICAO: TStringField;
    Qr_Itens_SrvICT_QTDE: TBCDField;
    Qr_Itens_SrvICT_VL_UNIT: TFMTBCDField;
    Qr_Itens_SrvICT_AQ_COM: TBCDField;
    Qr_Itens_SrvICT_VL_DESC: TBCDField;
    Qr_Itens_SrvICT_AQ_DESC: TBCDField;
    Qr_Itens_SrvICT_AQ_IPI: TBCDField;
    Qr_Itens_SrvICT_AQ_ICMS: TBCDField;
    Qr_Itens_SrvICT_CODEST: TIntegerField;
    Qr_Itens_SrvICT_CODTPR: TIntegerField;
    Qr_Itens_SrvICT_VL_SUBTOTAL: TFMTBCDField;
    Qr_Itens_ProPRO_LOCAL: TStringField;
    Fm_ListaProdutos: TFm_ListaProdutos;
    Fm_ListaMarca_Produto: TFm_ListaMarcaProduto;
    Pg_Busca: TPageControl;
    tbs_busca_cotacao: TTabSheet;
    DBG_Pesquisa: TDBGrid;
    tbs_busca_cotacao_itens: TTabSheet;
    DBG_Pesquisa_Itens: TDBGrid;
    Qr_Pesquisa_itens: TSTQuery;
    Ds_Pesquisa_itens: TDataSource;
    Chbx_somente_produto_cadastrado: TCheckBox;
    Panel4: TPanel;
    Sb_Ins_Servico: TBitBtn;
    Sb_Alt_Servico: TBitBtn;
    Sb_Exc_Servico: TBitBtn;
    Sb_Servico: TBitBtn;
    Sb_Tecnico: TBitBtn;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure SB_VoltarClick(Sender: TObject);
      procedure DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure SB_ClienteClick(Sender: TObject);
      procedure Sb_PesquisarClick(Sender: TObject);
      procedure E_VL_FreteExit(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure tbs_pesquisaShow(Sender: TObject);
      procedure SB_InserirClick(Sender: TObject);
      procedure SB_AlterarClick(Sender: TObject);
      procedure SB_ExcluirClick(Sender: TObject);
      procedure SB_GravarClick(Sender: TObject);
      procedure SB_CancelarClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure SB_BuscarClick(Sender: TObject);
      procedure SB_VisualizarClick(Sender: TObject);
      procedure Sb_Sair_1Click(Sender: TObject);
      procedure E_Aq_DescontoExit(Sender: TObject);
      procedure E_VL_DescontoExit(Sender: TObject);
      procedure Sb_Ins_ProdutoClick(Sender: TObject);
      procedure Sb_Alt_ProdutoClick(Sender: TObject);
      procedure Sb_Exc_ProdutoClick(Sender: TObject);
      procedure DBG_ProdutosDrawColumnCell(Sender: TObject;
         const Rect: TRect; DataCol: Integer; Column: TColumn;
         State: TGridDrawState);
      procedure E_Cd_EmpresaExit(Sender: TObject);
      procedure SB_PedidoClick(Sender: TObject);
      procedure SB_EnviarClick(Sender: TObject);

      procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormShow(Sender: TObject);
      procedure ChBx_BuscaNomeClick(Sender: TObject);
      procedure ChBx_BuscaFantasiaClick(Sender: TObject);
      procedure DBG_ProdutosDblClick(Sender: TObject);
      procedure DBGrid2DblClick(Sender: TObject);
      procedure ChBx_PeriodoClick(Sender: TObject);
      procedure tbs_cotacaoShow(Sender: TObject);
      procedure Sb_ParcelamentoClick(Sender: TObject);
      procedure E_Nr_ParcelasExit(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure Button1Click(Sender: TObject);
    procedure Qr_Itens_ProCalcFields(DataSet: TDataSet);
    procedure DBLCB_FormaPagtoExit(Sender: TObject);
    procedure Sb_Ins_ServicoClick(Sender: TObject);
    procedure Sb_Alt_ServicoClick(Sender: TObject);
    procedure Sb_Exc_ServicoClick(Sender: TObject);
    procedure Sb_ServicoClick(Sender: TObject);
    procedure Sb_TecnicoClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure Cb_EmpresaExit(Sender: TObject);
    procedure CadastrodoProdutoClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure popLucratividadeClick(Sender: TObject);
    procedure E_Vl_AdicionalExit(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);
    procedure Btn_Ok_LocalClick(Sender: TObject);
    procedure Btn_Cn_LocalClick(Sender: TObject);
    procedure Btn_Ap_LocalClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Pop_ConfigLocalClick(Sender: TObject);
    procedure Pop_ConfigGlobalClick(Sender: TObject);
    procedure chbx_dias_OrcClick(Sender: TObject);
    procedure AlteraTabeladePreoClick(Sender: TObject);
    procedure Sb_Confirma_TabelaPrecoClick(Sender: TObject);
    procedure Sb_Cancela_TabelaPrecoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure MnuCustodoPedidoClick(Sender: TObject);
    procedure Sb_InclusaoRapidoClick(Sender: TObject);
    procedure DBG_Pesquisa_ItensTitleClick(Column: TColumn);
   private
    { Private declarations }
      FWhatsAppNumber : String;
      It_Inserir, It_Alterar, It_Excluir, It_Visualizar: Boolean;
      It_Pedido, It_Enviar: Boolean;
      It_Compar_Orcamento : Boolean;
      It_Edicao_Ordem : String;
      Cliente : TControllerCliente;
      Base : TControllerBase;
      prmCotacao,prmCliente: Boolean;

      PrmEstado,PrmCidade,Prmemail,PrmFone :Boolean;
      PrmCdProduto,PrmDescProduto, PrmMarca : Boolean;

      procedure Pc_Abre_Config_Global;
      procedure Pc_Grava_Config_Global;
      procedure Pc_Abre_Config_Local;
      procedure Pc_Grava_Config_Local;
      procedure ControleElementos(Ativo:Boolean);
      Function ValidaTrocaTabela:Boolean;
      procedure EscolheTabela;
      procedure TrocaTabela(pCodigoTabela:Integer);
      procedure Pc_Gravar;

      function EmEdicao:Boolean;
      function EmNavegacao:Boolean;
      procedure Pc_AbrirCotacao;
      procedure Pc_AbrirItensVenda;
      procedure Pc_AbrirItensServico;


      procedure Pc_FormataPanels;
      Function  Fc_ValidaAlteracao:Boolean;

      Function Fc_ValidaCancelameto():Boolean;
      function VerificaProdutoSemEstoque:Boolean;
      procedure VerifyParameters;
      procedure PC_Buscar;
      procedure PC_Buscar_Resumo_Itens;
      function InnerSQL:String;
      function whereSQL:String;
      procedure PassarParametros(Qry:TSTQuery);
   public
    { Public declarations }
      It_Desativado: boolean;
      It_Email_cliente: boolean;
      It_Email_tecnico: boolean;
      It_Contas_pagar: boolean;
      It_Cd_Pesquisa: Integer;
      it_Tipo, it_tipo_Atual: string;
      It_Operacao: string;
      It_CodCli: Integer;
      It_Aliq_Comissao: Currency;
      It_StateChange: Integer;
      It_Cd_Repres: Integer;
      It_Nm_Repres: String;
      It_bloqueio : Boolean;
      It_MultiplicadorPreco: Currency;
      Cotacao : TControllerCotacao;
      Pedido : TControllerPedido;
      procedure Pc_AbreCotacaoNovo;
      procedure Pc_AtivarTabelas;

      function validaVisualizar:Boolean;
      procedure Pc_Visualizar;
      procedure Pc_Totalizador;
      procedure Pc_AtualizaCampos;
      function Fc_VerificaCadastroProduto():Boolean;
      function Fc_VerificaSaldoProduto():Boolean;
      function Fc_VerificaCadastroServico():Boolean;
      function Fc_ValidaFaturamento(): Boolean;
      function PreGeracaoPEdido(Fc_cd_Pedido:Integer): Integer;
      function Fc_GeraPedido(Fc_cd_Pedido:Integer): string;

      procedure PC_GeraNumero;
      function Fc_GeraEmail_Cotacao(): String;
      function Fc_GeraEmail_CotacaoComAnexo(): String;
      function Fc_Historico(pc_Tipo: Char): string;

      procedure Pc_FormataTela;
      procedure Pc_IniciaVariaveis;
      procedure Pc_Recalcula_Auto(Pc_Aq_Margem:Real);
      function Fc_ValidaGravacao: boolean;
      function validaPedidoExiste:Boolean;
      procedure Pc_PermissaoBotao(Pc_Menu: string);
      PROCEDURE Pc_Limpa_campo_buscar;
      PROCEDURE Pc_Limpa_campos;
      PROCEDURE Pc_Limpa_campos_Cliente;
      procedure PC_Sel_FormPagto(Pc_Bloquea_Pagto: Boolean);
      procedure Pc_DinheiroFormaPgt;
      procedure PC_Sel_PrazoPagto(Pc_Bloquea_Pagto: Boolean);
      Procedure Pc_Chama_Impressora;
      procedure Pc_Envia_Email_Sem_Anexo;
      procedure Pc_Envia_Email_Com_Anexo;
      procedure Pc_Envia_WhatsApp;
      function ValidaEnvioWhatsApp:Boolean;
      function  Fc_ValidasPrecoeParcelamento:Boolean;
      Function Fc_DefineTabela():String;
      Function Fc_DefineTipoPessoa():String;
      procedure Pc_DefineMultiplicadorPreco(Pc_cd_Cliente:Integer);
      procedure Pc_ImagemBotao;
      procedure Pc_ChamaCadastroCliente(Pc_cd_Cliente:String);


      procedure Pc_AtualizaStatusInterface();
      procedure Pc_PreencheDadosCliente;
      Function Fc_ValidaInsereTecnicos():Boolean;
      procedure Pc_PosicionaCliente(Pc_Campo,Pc_Valor:String);
      procedure Pc_EstadoEdicaoOrdem;
   end;

var
   Fr_Cotacao: TFr_Cotacao;

implementation

uses  Un_Pesq_Produto, Un_Funcoes, Un_DM, UN_TabelasEmListas, UN_Sistema, UN_MSG,
      UN_RL_Cotacao, UN_RL_OrcaCst_Entg, QRCtrls, UN_Pedido_Vda, Un_Liberacao,
      UN_Lanca_Pagto, DateUtils, Un_Parcelamento, Un_Tecnicos, Un_Fc_Sored_Procedures,
      un_Padrao, RN_Pedido, WhatsApp, reg_custo_pedido, Un_envia_email, Un_Imp_Mod_Impressao,
      Un_Regra_Negocio, UN_Principal, env, Un_Produtos, reg_service, RN_Permissao, RN_Estoque,
      RN_Financeiro, Un_Itens_Servico, RN_FormaPagto, Un_VehicleSo, Un_Cliente, Un_Pesq_Empresa,
      RN_Crud, RN_Cliente, RN_Empresa, RN_Mailing, Un_Itens_Produto_CTC_Vda,
      un_RL_ReportLucratividadeOrcamento, prmLucratividade;

{$R *.dfm}

procedure TFr_Cotacao.PassarParametros(Qry: TSTQuery);
begin
  with Qry do
  Begin
    if not Fm_LME.chbx_Empresas.Checked then
      ParamByName('CTC_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;

    if ChBx_Periodo.Checked then
    begin
      ParamByName('CTC_DATAINI').AsDate := E_Data_Ini.Date;
      ParamByName('CTC_DATAFIM').AsDate := E_Data_Fim.date;
    end;

    if prmCotacao then
      ParamByName('CTC_NUMERO').AsString := '%' + E_BuscaCotacao.Text + '%';
    if prmCliente then
      ParamByName('CTC_FANTASIA').AsString := '%' + Copy(E_BuscaCliente.Text,1,98) + '%';

    If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
      ParamByName('ctc_codvdo').AsInteger := Fm_ListaVendedores.Dblcb_Vendedor.keyvalue;

    if prmemail then
      ParamByName('ctc_email_e').AsString := concat('%',E_BuscaEmail.Text,'%');

    if prmEstado then
      ParamByName('UFE_SIGLA').AsString := E_BuscaEstado.Text;
    if prmCidade then
      ParamByName('CDD_DESCRICAO').AsString := '%' + E_BuscaCidade.Text + '%';
    if prmFone then
      ParamByName('END_FONE').AsString := '%' + Fc_RemoveCaracterInformado(E_BuscaFone.Text, ['(',')',' ','-','-']);

    if PrmCdProduto then
    Begin
      IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
      Begin
        ParamByName('PRO_CODIGO').AsString := Fm_ListaProdutos.E_Cd_Produto.Text;
      end
      else
      Begin
        ParamByName('PRO_CODIGO').AsString := '%' + Fm_ListaProdutos.E_Cd_Produto.Text + '%';
      end;
    end;

    if PrmDescProduto then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(Fm_ListaProdutos.E_Busca_Produto.Text,1,98) + '%';

    if PrmMarca then
      ParamByName('PRO_CODMRC').AsInteger := Fm_ListaMarca_Produto.Dblcb_Marca.KeyValue;

  End;
end;

procedure TFr_Cotacao.Pc_AbreCotacaoNovo;
begin
  Cotacao.using('L');
  Cotacao.clear;
  PC_limpa_Campos;
  PG_Itens.ActivePageIndex := 0;
  Pc_AbrirItensVenda;
  Pc_AbrirItensServico;
  Pc_Totalizador;
  if E_Data.CanFocus then E_Data.SetFocus;
end;

procedure TFr_Cotacao.Pc_Abre_Config_Global;
Begin
  Chbx_controle_orcamento.Checked := ( Fc_Tb_Geral('L','ORC_G_CTRL_SEQUENCIA','S') ='S');

  Chbx_Comp_Orcamentos.Checked    := ( Fc_Tb_Geral('L','ORC_G_COMPARTILHA','S') = 'S');

  E_dias_Orc.Text := Fc_Tb_Geral('L','ORC_G_CTRL_EXCLUSAO','0');

  ChBx_Manipula_Orc.Checked       := ( Fc_Tb_Geral('L','ORC_G_MANIP_CUSTO','S') = 'S');

  if Fc_Tb_Geral('G','ORC_G_CTRL_PARCELA','A') = 'A' then
    Rg_Parcela_Orca.ItemIndex := 0
  ELSE
    Rg_Parcela_Orca.ItemIndex := 1;

  ChBx_Libera_Valor.Checked := ( Fc_Tb_Geral('L','ORC_G_EDIT_VL_UNIT','S') ='S');

  chbx_nao_mostra_valor_usuario.Checked := (Fc_Tb_Geral('L','ORC_G_NO_SHOW_VALUES','S') ='L');

  chbx_somente_vendedor_altera.Checked :=  ( Fc_Tb_Geral('L','ORC_G_SO_VENDEDOR_ALTERA','S') = 'S');

  chbx_Alerta_Estoque.Checked := ( Fc_Tb_Geral('L','ORC_G_SO_ALERTA_ESTOQUE','S') = 'S');

  Chbx_somente_produto_cadastrado.Checked := ( Fc_Tb_Geral('L','ORC_G_PRODUCT_REGISTRADO','N') = 'S');
end;

procedure TFr_Cotacao.Pc_Gravar;
begin
  with Cotacao.registro do
  Begin
    Tipo            :=  '0';
    Codusu          :=  Gb_Cd_Usuario;
    Data            := E_Data.Date;
    codemp := StrToIntDef(E_Cd_Empresa.Text,0);
    Fantasia        := Cb_Empresa.Text;
    if (Fm_FormaPagto.DBLCB_FormaPagto.Text <> '') then
      Codfpg          := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue
    ELSE
      Codfpg          := 0;

    if (Fc_Tb_Geral('L','ORC_G_CTRL_PARCELA','')  = 'A') then
      Prazo           := E_Nr_Parcelas.Text + ' - ' + E_Prazo.Text
    else
      Prazo := DBLCB_Prazo.Text;



    Aprovado        := 'N';
    QtProduto       := StrToFloatDef(E_Qt_Produto.Text,0);
    VlProduto       := StrToFloatDef(E_VL_Produto.Caption,0);
    VlServico       := StrToFloatDef(E_Vl_Servico.Caption,0);
    VlFrete         := StrToFloatDef(E_VL_Frete.Text,0);
    AliqDesconto    := StrToFloatDef(E_Aq_Desconto.Text,0);
    VlDesconto      := StrToFloatDef(E_VL_Desconto.Text,0);
    VlCotacao       := StrToFloatDef(E_VL_Cotacao.Caption,0);
    Contato         :=  E_Contato.Text;
    Validade        :=  E_Validade.Text;
    PrzEntrega      := E_Dt_Entrega.Text;
    Garantia        :=  E_Garantia.Text;
    //Frota           :=
    //Equipamento     :=
    //TpFrete         :=
    EmailE          := E_email.Text;
    Codvdo          := Fm_VendedorCotacao.Dblcb_Vendedor.KeyValue;
    if Fm_ListaAuxiliarVenda.Dblcb_Vendedor.Text <> '' then
      AuxiliarVenda := Fm_ListaAuxiliarVenda.Dblcb_Vendedor.KeyValue;
    //TpContato       :=
    Estabelecimento   := Gb_CodMha;
    //ContatoEmpr     :=
    //Codtrp          :=
    //VlCusto         :=
    //ObsCorte        :=
    Obs             := E_obs.Text;
    //DtEnvEmail      :=
    //Codsit          :=
    //Solicitante     :=
    VlAdicional     := StrToFloatDef(E_Vl_Adicional.Text,0);
  End;


  Pedido.Clear;
  Pedido.Registro.Codigo := cotacao.registro.Codped;
  Pedido.Registro.Tipo := 1;
  Pedido.Registro.Usuario := GB_Cd_Usuario;
  Pedido.Registro.Data := E_Data.DateTime;
  if StrToIntDef(E_Cd_Empresa.Text,0) > 0 then
  Begin
   Pedido.Registro.Empresa := StrToIntDef(E_Cd_Empresa.Text,0);
   Pedido.Endereco.REgistro.CodigoEmpresa := Pedido.Registro.Empresa;
   Pedido.Endereco.getByEmpresa;
   Pedido.Registro.Endereco := Pedido.Endereco.Registro.Codigo;
  End
  else
  Begin
    Pedido.Registro.Empresa := Gb_CodMha;
    Pedido.Endereco.REgistro.CodigoEmpresa := Gb_CodMha;
    Pedido.Endereco.getByEmpresa;
    Pedido.Registro.Endereco := Pedido.Endereco.Registro.Codigo;
  End;
  Pedido.Registro.FormaPagto := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
  Pedido.Registro.Faturado := 'C';
  Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
  IF (cotacao.registro.Codped = 0) THEN
    Pedido.insere
  else
    Pedido.salva;

  cotacao.registro.Codped  := Pedido.Registro.Codigo;
  Cotacao.Save;
end;

procedure TFr_Cotacao.Pc_Grava_Config_Global;
Begin
  if Chbx_controle_orcamento.Checked then
    Fc_Tb_Geral('G','ORC_G_CTRL_SEQUENCIA','S')
  else
    Fc_Tb_Geral('G','ORC_G_CTRL_SEQUENCIA','N');

  if Chbx_Comp_Orcamentos.Checked then
    Fc_Tb_Geral('G','ORC_G_COMPARTILHA','S')
  else
    Fc_Tb_Geral('G','ORC_G_COMPARTILHA','N');

  if chbx_dias_Orc.Checked then
  Begin
    if (Fc_Tb_Geral('L','ORC_G_CTRL_EXC_ATIVADO','N') = 'N') then
    Begin
      If (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Deseja realmente excluir automaticamente '+EOLN+
                         'os orçamentos não aprovados em ' + E_dias_Orc.Text + '.'+EOLN+EOLN+
                         'Confirmar a configuração ?',
                      [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
      Begin
        Fc_Tb_Geral('G','ORC_G_CTRL_EXC_ATIVADO','S');
        Pc_Log_Sistema(Gb_CodMha,
                       GB_Cd_Usuario,
                       now,
                       'Configurações Gerais',
                       0,
                       'Exclusão dos orçamentos',
                       'Ativada para cada '+ E_dias_Orc.Text + ' dia(s) ');
      end;
    end;
  end
  else
  Begin
    Fc_Tb_Geral('G','ORC_G_CTRL_EXC_ATIVADO','N');
    Pc_Log_Sistema(Gb_CodMha,
                   GB_Cd_Usuario,
                   now,
                   'Configurações Gerais',
                   0,
                   'Exclusão dos orçamentos',
                   'Operação desativada ');
  end;

  Fc_Tb_Geral('G','ORC_G_CTRL_EXCLUSAO',E_dias_Orc.Text);

  if ChBx_Manipula_Orc.Checked then
    Fc_Tb_Geral('G','ORC_G_MANIP_CUSTO','S')
  else
    Fc_Tb_Geral('G','ORC_G_MANIP_CUSTO','N');

  if Rg_Parcela_Orca.ItemIndex = 0 then
      Fc_Tb_Geral('G','ORC_G_CTRL_PARCELA','A')
  ELSE
      Fc_Tb_Geral('G','ORC_G_CTRL_PARCELA','C');

  if ChBx_Libera_Valor.Checked then
    Fc_Tb_Geral('G','ORC_G_EDIT_VL_UNIT','S')
  else
    Fc_Tb_Geral('G','ORC_G_EDIT_VL_UNIT','N');

  if chbx_nao_mostra_valor_usuario.Checked then
    Fc_Tb_Geral('G','ORC_G_NO_SHOW_VALUES','S')
  else
    Fc_Tb_Geral('G','ORC_G_NO_SHOW_VALUES','N');

  if chbx_somente_vendedor_altera.Checked then
    Fc_Tb_Geral('G','ORC_G_SO_VENDEDOR_ALTERA','S')
  else
    Fc_Tb_Geral('G','ORC_G_SO_VENDEDOR_ALTERA','N');

  if chbx_Alerta_Estoque.Checked then
    Fc_Tb_Geral('G','ORC_G_SO_ALERTA_ESTOQUE','S')
  else
    Fc_Tb_Geral('G','ORC_G_SO_ALERTA_ESTOQUE','N');

  if Chbx_somente_produto_cadastrado.Checked then
    Fc_Tb_Geral('G','ORC_G_PRODUCT_REGISTRADO','S')
  else
    Fc_Tb_Geral('G','ORC_G_PRODUCT_REGISTRADO','N');


end;

procedure TFr_Cotacao.Pc_Abre_Config_Local;
Begin
  //imprimi pedido impressora
  rdg_PedOrc_Imp.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_P_IMPRESSORA',''),0);

  e_porta_ImpOrc.Text := Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_P_PORTA','LPT1');
  e_salto_Orc.Text :=Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_P_SALTO','0');

  //Ites por folha
  e_itens_oRC.Text :=  Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_P_ITENS_FOLHA','');

  //modelo de impressao estilo matricial
  Cbx_TipoMatric.ItemIndex :=   StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_G_MOD_MATRICIAL', ''),1)-1;

  //modelo de impressao estilo lase
  Cbx_TipoLaser.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_G_MOD_JATOLASER', ''),1)-1;

  //Controla o tipo de Interface da Cotação
  Cb_InterfaceCotacao.ItemIndex := StrToIntDef(Fc_Tb_Geral('L','ORC_G_CTRL_INTERFACE','1'),1) - 1;

end;

procedure TFr_Cotacao.Pc_AbrirCotacao;
begin
  Lb_Numero.Caption   := Cotacao.Registro.Numero;
  E_Data.Date         := Cotacao.Registro.Data;
  E_Cd_Empresa.Text   := Cotacao.Registro.Codemp.ToString;
  if StrToIntDef(E_Cd_Empresa.Text,0)>0 then
  Begin
    It_bloqueio := Fc_VerificaBloqueioCliente(StrToIntDef(E_Cd_Empresa.Text,0));
    PC_Sel_FormPagto(It_bloqueio);
    PC_Sel_PrazoPagto(it_bloqueio);
  end;
  Pc_DefineMultiplicadorPreco(StrToIntDef(E_Cd_Empresa.Text,0));
  cb_empresa.text := Cotacao.Registro.Fantasia;
  Fm_VendedorCotacao.Dblcb_Vendedor.KeyValue := Cotacao.Registro.Codvdo;
  Fm_ListaAuxiliarVenda.Dblcb_Vendedor.KeyValue := Cotacao.Registro.AuxiliarVenda;

  E_Contato.Text := Cotacao.Registro.Contato;
  e_Email.Text := Cotacao.Registro.EmailE;
  Fm_FormaPagto.DBLCB_FormaPagto.KeyValue :=Cotacao.Registro.Codfpg;
  Pc_DinheiroFormaPgt;
  E_Nr_Parcelas.Text  := Copy( Cotacao.Registro.Prazo, 1, 3);
  E_Prazo.Text        := Copy(Cotacao.Registro.Prazo, 7, Length( Cotacao.Registro.Prazo));

  E_Validade.Text :=   Cotacao.Registro.Validade;
  E_Dt_Entrega.Text := Cotacao.Registro.PrzEntrega;
  E_Garantia.Text := Cotacao.Registro.Garantia ;
  E_obs.Text :=      Cotacao.Registro.Obs;
    //Frota           :=
    //Equipamento     :=
    //TpFrete         :=
  Fm_ListaAuxiliarVenda.Dblcb_Vendedor.KeyValue := Cotacao.Registro.AuxiliarVenda;


  //Quantidade PRodutos
  E_Qt_Produto.Text := FloatToStrF( Cotacao.Registro.QtProduto, ffFixed, 10, 2);
  //PRodutos
  E_VL_Produto.Caption := FloatToStrF( Cotacao.Registro.VlProduto, ffFixed, 10, 2);
  //Servico
  E_Vl_Servico.Caption := FloatToStrF( Cotacao.Registro.VlServico , ffFixed, 10, 2);
  //Frete
  E_VL_Frete.Text := FloatToStrF( Cotacao.Registro.VlFrete, ffFixed, 10, 2);
  //Adicional
  E_Vl_Adicional.Text := FloatToStrF( Cotacao.Registro.VlAdicional , ffFixed, 10, 2);
  //Desconto
  E_Aq_Desconto.Text := FloatToStrF( Cotacao.Registro.AliqDesconto, ffFixed, 10, 2);
  E_VL_Desconto.Text := FloatToStrF( Cotacao.Registro.VlDesconto, ffFixed, 10, 2);
  //Valor total
  E_VL_Cotacao.Caption := FloatToStrF( Cotacao.Registro.VlCotacao , ffFixed, 10, 2);
  Pc_AtualizaCampos;
  Pc_Totalizador;
end;


procedure TFr_Cotacao.Pc_AbrirItensServico;
begin
  with Qr_Itens_Srv do
  Begin
    Active:=False;
    paramByName('CTC_CODIGO').AsInteger := cOTACAO.Registro.Codigo;
    Active:=True;
    Fetchall;
  End;

end;

procedure TFr_Cotacao.Pc_AbrirItensVenda;
begin
  with Qr_Itens_Pro do
  Begin
    Active:=False;
    paramByName('CTC_CODIGO').AsInteger := COtacao.Registro.Codigo;
    Active:=True;
    Fetchall;
    First;
  End;

end;

procedure TFr_Cotacao.Pc_Grava_Config_Local;
Begin
  //imprimi pedido impressora
  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_IMPRESSORA',IntToStr(rdg_PedOrc_Imp.ItemIndex));

  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_PORTA',e_porta_ImpOrc.Text);
  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_SALTO',e_salto_Orc.Text);

  //Ites por folha
  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_ITENS_FOLHA',e_itens_ORC.Text);

  //modelo de impressao estilo matricial
  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_G_MOD_MATRICIAL', IntToStr(Cbx_TipoMatric.ItemIndex+1));

  //modelo de impressao estilo lase
  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_G_MOD_JATOLASER', IntToStr(Cbx_TipoLaser.ItemIndex+1));

  //Controla o tipo de Interface da Cotação
  Fc_Tb_Geral('G','ORC_G_CTRL_INTERFACE',IntToStr(Cb_InterfaceCotacao.ItemIndex+1));


end;

procedure TFr_Cotacao.Pc_DefineMultiplicadorPreco(Pc_cd_Cliente:Integer);
Var
  Lc_Qry : TSTQuery;
begin
  Try
    It_MultiplicadorPreco := 1;
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT EMP_MULTIPLICADOR FROM TB_EMPRESA WHERE EMP_CODIGO=:EMP_CODIGO');
      ParamByName('EMP_CODIGO').AsInteger := Pc_cd_Cliente;
      Active := true;
      FetchAll;
      if FieldByName('EMP_MULTIPLICADOR').AsFloat > 0 then
        It_MultiplicadorPreco := FieldByName('EMP_MULTIPLICADOR').AsFloat;
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;


function TFr_Cotacao.Fc_ValidasPrecoeParcelamento:Boolean;
Var
  Lc_Msg : String;
Begin
  Result := True;
  if (Fc_Tb_Geral('L','VDA_G_CTRL_TABELA_X_PRAZO','') = 'S') then
  Begin
    if StrToIntDef(E_Nr_Parcelas.Text,0) > 0 then
    Begin
      Qr_Itens_Pro.First;
      Lc_Msg := '';
      while not Qr_Itens_Pro.Eof do
      Begin
        if Qr_Itens_Pro.FieldByName('TPR_MODALIDADE').AsString = 'V' then
          Lc_Msg := Lc_Msg + Qr_Itens_Pro.FieldByName('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens_Pro.FieldByName('ICT_DESCRICAO').AsString + #13#10;
        Qr_Itens_Pro.Next;
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


procedure TFr_Cotacao.Pc_Recalcula_Auto(Pc_Aq_Margem:Real);
Var
  Lc_Valor : Real;
  Lc_Qry : TSTQuery;

Begin
  Try
    Lc_Qry := Base.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_ITENS_CTC SET ICT_VL_UNIT =:ICT_VL_UNIT WHERE ICT_CODIGO =:ICT_CODIGO ');
      Pc_AbrirItensVenda;
      while not Qr_Itens_Pro.Eof do
      Begin
        Active := False;
        Lc_Valor := 0;
        Lc_Valor := Qr_Itens_Pro.FieldByName('PRO_VL_CUSTO').AsCurrency * Qr_Itens_Pro.FieldByName('PRO_DIVISOR').AsFloat;
        ParamByName('ICT_VL_UNIT').AsCurrency :=  Lc_Valor + (Lc_Valor * (Pc_Aq_Margem/100));
        ParamByName('ICT_CODIGO').AsInteger  := Qr_Itens_Pro.FieldByName('ICT_CODIGO').AsInteger;
        ExecSQL;
        Qr_Itens_Pro.Next;
      end;
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
    Pc_AbrirItensVenda;
  End;
end;


procedure TFr_Cotacao.Pc_FormataPanels;
Var
  Lc_top,lc_left : Integer;
BEgin
  //Posiciona o Panel de Tabela de Preço
  Pnl_TabelaPreco.Visible := False;
  Lc_top := trunc((Height - Pnl_TabelaPreco.Height)/2);
  lc_left := trunc((Width - Pnl_TabelaPreco.Width)/2);
  Pnl_TabelaPreco.Top := Lc_top;
  Pnl_TabelaPreco.Left := lc_left;

end;

procedure TFr_Cotacao.Pc_FormataTela;
Var
  Lc_X : Integer;
begin
  if (Fc_Tb_Geral('L', 'OSR_G_ATIVAR', 'S') = 'S') then
  begin
    PG_Itens.Pages[1].TabVisible := True;
    E_Vl_Servico.Visible := True;
    Lb_Opcional.Visible := True;
    Lb_Opcional.Caption := 'Serviços';
  end
  else
  begin
    PG_Itens.Pages[1].TabVisible := False;
    E_Vl_Servico.Visible := False;
    Lb_Opcional.Visible := False;
  end;
  //Ativa a aba de Serviço
  PG_Itens.Pages[1].TabVisible := (Fc_Tb_Geral('L', 'OSR_G_ATIVAR', 'S') = 'S');
  //Visualiza o painel que calculo o valor do orçamento pelo Custo
  if (Fc_Tb_Geral('L','ORC_G_MANIP_CUSTO','S') = 'S') then
  Begin
    Pnl_Calculo_Custo.Visible := True;
    DBG_Produtos.Columns[1].Width := 280;
    DBG_Produtos.Columns[2].Visible := True;
    DBG_Produtos.Columns[3].Visible := True;
  end
  else
  Begin
    Pnl_Calculo_Custo.Visible := False;
    DBG_Produtos.Columns[1].Width := 378;
    DBG_Produtos.Columns[2].Visible := False;
    DBG_Produtos.Columns[3].Visible := False;
  end;
  if Gb_Nivel = 0 then
    DBG_Pesquisa.Columns[3].Visible := not ( Fc_Tb_Geral('L','ORC_G_NO_SHOW_VALUES','S') = 'S')
  else
      DBG_Pesquisa.Columns[3].Visible := True;
  if (Fc_Tb_Geral('L','ORC_G_CTRL_PARCELA','A') = 'A') then
  begin
    E_Nr_Parcelas.Visible:=true;
    E_Prazo.Visible:=true;
    Sb_Parcelamento.Visible:=true;
    DBLCB_Prazo.Visible:=false;
  end
  else
  begin
    DBLCB_Prazo.Top:= E_Nr_Parcelas.Top;
    DBLCB_Prazo.Visible:=true;
    E_Nr_Parcelas.Visible:=False;
    E_Prazo.Visible:=False;
    Sb_Parcelamento.Visible:=False;
  end;

  for Lc_X := 1 to Pg_Cotacao.PageCount do
    Pg_Cotacao.Pages[Lc_X - 1].TabVisible := False;
end;

procedure TFr_Cotacao.Pc_IniciaVariaveis;
Begin
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  E_Data_Ini.Date := (Date - 30);
  E_Data_Fim.date := Date;
  E_Data.Date := Date;
  It_Compar_Orcamento := (Fc_Tb_Geral('L','ORC_G_COMPARTILHA','S') = 'S');
  Cliente.PreencheComboBox('EMP_NOME',Cb_Empresa);

  Fm_ListaMarca_Produto.Pc_ListaMedida;
  Fm_VendedorCotacao.ListaVendedor;
  Fm_ListaVendedores.ListaVendedor;
  Fm_ListaAuxiliarVenda.ListaVendedor;
  Pg_Cotacao.ActivePageIndex:=1;
  If (COTACAO.Registro.Codigo > 0) then
  Begin
    COTACAO.getbyId;
    COTACAO.using('B');
    Pc_AtivarTabelas;
    Pc_AbrirCotacao;
    Pg_Cotacao.ActivePageIndex := 0;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end
  else
    Pg_Cotacao.ActivePageIndex:=1;

end;



function TFr_Cotacao.Fc_GeraEmail_Cotacao(): String;
var
   lc_Data: string;
   Lc_Ano, Lc_mes, Lc_dia: string;
   Lc_I: Integer;
begin
   Pc_AtivaEstabelecimento;

   Lc_dia := Copy(  DateToSTr( cotacao.registro.Data), 1, 2);
   Lc_mes := Fc_DesMes(Fc_Month(cotacao.registro.Data), True);
   Lc_Ano := Copy(DateToSTr( cotacao.registro.Data), 7, 4);

   Lc_Data := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de ' + Lc_Ano;

   Result  :=  '<body> '+ 
               '<html> '+ 
               '<table width="689" border="0" cellspacing="0" cellpadding="0">'+ 
               '  <tr>' + 
               '    <td><strong>' + DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString + '</strong></td>' +
               '  </tr>' + 
               '  <tr>' + 
               '    <td>' + DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + '</td>'+
               '  </tr> '+ 
               '  <tr> '+ 
               '    <td>' + DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString + '</td>' +
               '  </tr>' + 
               '  <tr>' + 
               '    <td>Fone / e-mail: ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString) + ' / ' + DM.Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString + '</td>' +
               '  </tr>' + 
               '  <tr>' + 
               '    <td><font color="#FFFFFF" size="1">.</font></td>' + 
               '  </tr>' + 

               '</table>' + 
               '<table width="689" border="0" cellspacing="0" cellpadding="0">' + 
               '  <tr>' + 
               '    <td width="16%"><strong>Orçamento Nº </strong></td>' + 
               '    <td colspan="2">' + Lb_Numero.Caption + '</td>' + 
               '    <td width="38%"><div align="right">' + Lc_data + '</div>' + 
               '       </td> '+ 
               '  </tr> '+ 
               '  <tr> '+ 
               '    <td><strong>Cliente:</strong></td> '+ 
               '    <td width="37%">' + Cb_Empresa.Text + '</td> '  ;

   Result := Result +
               '    <td width="9%"><strong>Fone:</strong></td> '+
               '    <td>' + fc_MascaraFone(Cliente.Empresa.Endereco.Registro.Fone) + '</td> '+
               '  </tr> '+
               '  <tr> '+
               '    <td><strong>Contato:</strong></td> '+
               '    <td>' + E_Contato.Text + '</td> '+
               '    <td><strong>Celular:</strong></td> '+
               '    <td>' + fc_MascaraFone(Cliente.Empresa.Endereco.Registro.Fax) + '</td> '+
               '  </tr> '+
               '  <tr> '+
               '    <td colspan="4"><font color="#FFFFFF" size="1">.</font></td> '+
               '  </tr> '+
               '</table> '  ;

  //Cordp do Pedido
   Result := Result +
               '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
               '  <tr bgcolor="#CCCCCC"> '+
               '    <td width="25%"><font color="#FFFFFF">Código</font></td> '+
               '    <td width="35%"><font color="#FFFFFF">Descri&ccedil;&atilde;o </font></td> '+
               '    <td width="11%"><font color="#FFFFFF">Quantidade</font></td> '+
               '    <td width="13%"><div align="center"><strong><font color="#FFFFFF">Vl. Unit&aacute;rio</font></strong></div></td> '+
               '    <td width="16%"><div align="center"><strong><font color="#FFFFFF">SubTotal</font></strong></div></td> '+
               '  </tr> ' ;

   Qr_Itens.Active := False;
   Qr_Itens.ParamByName('CTC_CODIGO').AsInteger := cotacao.registro.Codigo;
   Qr_Itens.Active := True;
   Qr_Itens.First;

   while not Qr_Itens.Eof do
      begin
      Result := Result + '  <tr> '  ;
      if (Trim(Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString) <> '') then
        Result := Result + '  <td>' + Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString + '</td> '
      else
        Result := Result + '  <td>' + Qr_Itens.FieldByName('ICT_CODVCL').AsString + '</td> ';
      Result := Result + '    <td>' + Copy(Qr_Itens.FieldByName('ICT_DESCRICAO').AsString, 1, 35) + '</td> '  ;
      Result := Result + '    <td><div align="right">' + FloattoStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat, ffFixed, 10, 0) + '</div></td> '  ;
      Result := Result + '    <td><div align="right">' + FloattoStrf(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency, ffFixed, 10, 2) + '</div></td> ' ;
      Result := Result + '    <td><div align="right">' + FloattoStrf(Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency, ffFixed, 10, 2) + '</div></td> '  ;
      Result := Result + '  </tr> ';
      Qr_Itens.Next;
   end;
   Result := Result + '</table> ';
  //Rodape do Pedido

   Result := Result +
               '<table width="689" border="0" cellspacing="0" cellpadding="0"> '+
               '  <tr> '+
               '    <td height="21"><font color="#FFFFFF" size="1">.</font></td> '+
               '  </tr> '+
               '</table> '+

               '<table width="689" border="0" cellspacing="0" cellpadding="0"> '+
               '  <tr> '+
               '  <td width="546"><div align="right"><strong><font size="4">Valor Desconto</font></strong></div></td> '+
               '  <td width="137"><div align="right"><font size="4">' + E_VL_Desconto.Text  + '</font></div></td> '+
               '  </tr> '+
               '  <tr> '+
               '  <td width="546"><div align="right"><strong><font size="4">Total Geral</font></strong></div></td> '+
               '  <td width="137"><div align="right"><font size="4">' + E_VL_Cotacao.Caption + '</font></div></td> '+
               '  </tr> '+
               '</table> ';
   Result := Result +
               '<table width=689 border=0 cellspacing=0 cellpadding=0> '+
               '  <tr> '+
               '    <td><strong>Validade do Orçamento:</strong></td> '+
               '  </tr> '+
               '  <tr> '+
               '    <td>' + Fc_Tb_Geral('L', 'ORC_VALIDADE', '') + '</td> '+
               '  </tr> '+
               '</table> '+

               '<table width=689 border=0 cellspacing=0 cellpadding=0> '+
               '  <tr> '+
               '    <td><strong>Forma de Pagamento/Observa&ccedil;&otilde;es</strong></td> '+
               '  </tr> '+
               '  <tr> '+
               '    <td>' + E_Prazo.Text + '</td> '+
               '  </tr> ';
   for Lc_I := 0 to E_obs.Lines.Count - 1 do
      begin
      Result := Result + '  <tr> ';
      Result := Result + '    <td>' + E_obs.Lines.Strings[lc_I] + '</td> ';
      Result := Result + '  </tr> ';
     end;
   Result := Result + '</table> ';

   Result := Result +
               '<table width=689 border=0 cellspacing=0 cellpadding=0> '+
               '  <tr> '+
               '    <td width="261"></td> '+ 
               '    <td width="86">&nbsp;</td> '+ 
               '    <td width="334">____________________________________________</td> '+ 
               '  </tr> '+ 
               '  <tr> '+ 
               '    <td><strong>Vendedor: ' + GB_Nm_Usuario + '</strong></td> '+ 
               '    <td>&nbsp;</td> '+ 
               '    <td><div align="center">' + Cb_Empresa.Text + '</td> '+ 
               '  </tr> '+ 
               '</table> ' ;

  //FEchamento HTML
   Result := Result + '</body> ' ;
   Result := Result + '</html> ' ;
end;


function TFr_Cotacao.Fc_GeraEmail_CotacaoComAnexo(): String;
begin
   Pc_AtivaEstabelecimento;
   Result  :=  '<body> '+
               '<html> '+
               '<table width="689" border="0" cellspacing="0" cellpadding="0">'+
               '  <tr>' +
               '    <td> Olá ' + E_Contato.Text + '</td>' +
               '  </tr>' +
               '  <tr>' +
               '    <td><font color="#FFFFFF" size="1">.</font></td>' +
               '  </tr>' +
               '  <tr>' +
               '    <td>Segue em anexo o orçamento Solicitado </td>'+
               '  </tr> '+
               '  <tr>' +
               '    <td><font color="#FFFFFF" size="1">.</font></td>' +
               '  </tr>' +
               '</table>' +
               Fc_GeraAssinaturaEmail +
               '</body> ' +
               '</html> ' ;
end;


procedure TFr_Cotacao.Pc_GeraNumero;
Begin
  with Cotacao.Registro do
  Begin
    If (Numero = '' ) then Cotacao.nextNumber;
    Lb_Numero.Caption:= Numero;
  End;

end;

function TFr_Cotacao.Fc_Historico(pc_Tipo: Char): string;
var
   Lc_TExto: string;
   Lc_codigo: Integer;
   Lc_Vl_Chq_DEv: Real;
   Lc_Vl_Chq_Pre: Real;
   Lc_Vl_Devedor: Real;
begin
   Lc_codigo := StrToIntdef(E_Cd_Empresa.Text, 0);

  //Cheque Devedor
  Lc_Vl_Chq_DEv := Fc_SaldoChequeDevolvido(Lc_codigo);
  if Lc_Vl_Chq_DEv > 0 then
    Lc_TExto := ' Cheque(s) Devolvido(s) : ' + FloatToStrF(Lc_Vl_Chq_DEv, ffFixed, 10, 2);

  //Cheque Pre-Datado
  Lc_Vl_Chq_Pre := Fc_SaldoChequePreDatado(Lc_codigo);
  if Lc_Vl_Chq_Pre > 0 then
    Lc_TExto := Lc_TExto + ' Cheque(s) PreDatado(s) : ' + FloatToStrF(Lc_Vl_Chq_Pre, ffFixed, 10, 2);

 //Saldo Devedor
  Lc_Vl_Devedor := Fc_SaldoDevedorCliente(Lc_codigo);
  if Lc_Vl_Devedor > 0 then
    Lc_TExto := Lc_TExto + ' Saldo Devedor : ' + FloatToStrF(Lc_Vl_Devedor, ffFixed, 10, 2);

  //Observação Cadastro
  if Length(Cliente.Empresa.Registro.Observacao) > 0 then
    Lc_TExto := Lc_TExto + Cliente.Empresa.Registro.Observacao;

  Result := Lc_TExto;
end;

function TFr_Cotacao.Fc_GeraPedido(Fc_cd_Pedido:Integer): string;
var
  Lc_SqlTxt: string;
  Lc_Numero: Integer;
  Lc_Separacao : boolean;
  lc_Estoque : String;
  LcSeq : Integer;
begin
  Lc_Separacao := (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S');
  //Insere o Pedido
  Pedido.Clear;
  with Pedido.Registro do
  Begin
    Codigo := Fc_Cd_Pedido;
    Tipo:= 1;
    Usuario:= Gb_Cd_Usuario;
    Data:= Date;
    Empresa:= strToIntDef(E_Cd_Empresa.Text,0);
    Pedido.Registro.Empresa := StrToIntDef(E_Cd_Empresa.Text,0);
    Pedido.Endereco.REgistro.CodigoEmpresa := Pedido.Registro.Empresa;
    Pedido.Endereco.getByEmpresa;
    Pedido.Registro.Endereco  := Pedido.Endereco.Registro.Codigo;
    Vendedor              := cotacao.REgistro.Codvdo;
    FormaPagto            := cotacao.REgistro.Codfpg;
    Prazo                 := cotacao.REgistro.Prazo;
    QtdeProdutos          :=  StrToFloatDef(E_Qt_Produto.Text, 0);
    ValorProdutos         := StrToFloatDef(E_VL_Produto.Caption, 0);
    //ValorOutrasDEspesas   := Pedido.CustosExtras; desabilitado 06/08/2019
    ValorFrete            := StrToFloatDef(E_VL_Frete.Text, 0);
    AliqDesconto          := StrToFloatDef(E_Aq_Desconto.Text, 0);
    ValorDesconto         := StrToFloatDef(E_VL_Desconto.Text, 0);
    ValorPedido           := StrToFloatDef(E_VL_Cotacao.Caption, 0);
    Faturado              := 'N';
    CodigoEstabelecimento := Gb_Codmha;
    Observacao            := E_obs.Text;
    NumeroOrcamento       := cotacao.REgistro.Codigo;
    IndicaPresenca        := 1;
  end;
  Pedido.CriaPedidoOrcamento;
  Pedido.nextNumber('T');
  Lc_Numero := Pedido.Registro.Numero;
  //Insere os itens de produto
  Pedido.Itens.deleteByPedido;
  LcSeq := 0;
  with Qr_Itens do
  Begin
    Active := False;
    ParamByName('CTC_CODIGO').AsInteger := cotacao.REgistro.Codigo;
    Active := True;
    FetchAll;
    First;
    while not Eof do
      begin
      if (FieldByName('ICT_TIPO').AsString <> 'S') then
        lc_Estoque := 'S'
      else
        lc_Estoque := 'N';
      with pedido.Itens.Registro do
      BEgin
        Codigo            := 0;
        inc(LcSeq);
        Sequencia         := LcSeq;
        CodigoPedido      := PEdido.Registro.codigo;
        CodigoNota        := 0;
        CodigoProduto     := FieldByName('ICT_CODVCL').AsInteger;
        Quantidade        := FieldByName('ICT_QTDE').AsFloat;
        ValorCusto        := fIeldByName('ICT_VL_CUSTO').AsCurrency;
        ValorUnitario     := FieldByName('ICT_VL_UNIT').AsCurrency;
        Despachar         := 'S';
        Estoque           := lc_Estoque;
        AliqComissao      := FieldByName('ICT_AQ_COM').AsFloat;
        ValorDesconto     := FieldByName('ICT_VL_DESC').AsCurrency;
        AliqDesconto      := FieldByName('ICT_AQ_DESC').AsFloat;
        AliqIPI           := FieldByName('ICT_AQ_IPI').AsCurrency;
        Operacao          := 'V';
        AliqICMS          := FieldByName('ICT_AQ_ICMS').AsCurrency;
        CodigoEstoque     := Gb_Estoque;
        CodigoTabela      := FieldByName('ICT_CODTPR').AsInteger;
        Altura            := 0;
        Largura           := 0;
        Sentido           := 'S';
        PedidoCompra      := '';
        ItemCompra        := '';
        ImpostoAproximado := 0;
        NumeroPecas       := 0;
      End;
      tRY
        pedido.Itens.insere;
      except
        on E : Exception do
        Begin
          MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                         'Por favor Informe este erro ao Desenvolvedor.' + EOLN +
                         E.Message + EOLN,
                         ['OK'], [bEscape], mpErro);
        End;
      end;
      if (pedido.Itens.Registro.Codigo > 0 ) then
      Begin
        if (FieldByName('ICT_TIPO').AsString <> 'S') then
        Begin
          with Pedido.CtrlEstoque.Registro do
          Begin
           Codigo      := 0;
            Vinculo     := 'P';
            Terminal    := Gb_Terminal;
            Ordem       := PEdido.Registro.codigo;
            Item        := pedido.Itens.Registro.Codigo;
            Estoque     := Gb_Estoque;
            operacao    := 'S';
            Produto     := FieldByName('ICT_CODVCL').AsInteger;
            Quantidade  := FieldByName('ICT_QTDE').AsFloat;
            Data        := DAte;
            Tipo        := 'Venda';
            UpdateAt    := Now;
          End;
          Pedido.CtrlEstoque.Registra;
        end;
        //Verifica se precisa enviar para a Separação
        if Lc_Separacao and (Qr_Itens.FieldByName('ICT_TIPO').AsString <> 'S') then
        Begin
          Pc_SeparacaoMercadoria(PEdido.Registro.codigo,
                                 pedido.Itens.Registro.Codigo,
                                 Qr_Itens.FieldByName('ICT_CODVCL').AsInteger,
                                 Date,
                                 Qr_Itens.FieldByName('ICT_QTDE').AsFloat);
        end;
      End;
      Next;
    end;
  end;
  Result := IntToStr(Lc_Numero);
end;


function TFr_Cotacao.Fc_VerificaCadastroProduto():Boolean;
Var
   lc_obs: TMemo;
   Lc_Saldo:boolean;
   LcSemRegistro : Boolean;
Begin
  Try
    Result := True;
    LcSemRegistro := False;
    lc_obs := TMemo.Create(Self);
    lc_obs.Visible := false;
    lc_obs.Parent := Self;

    with Qr_Itens_Pro do
    Begin
      Active := True;
      First;
      while not Eof do
      begin
        Cotacao.Itens.Produto.Registro.Codigo := FIELDBYNAME('ICT_CODVCL').AsInteger;
        Cotacao.Itens.Produto.getbyId;
        if not Cotacao.Itens.Produto.exist then
        begin
          Result := False;
          Lc_obs.Lines.Add('Sem Registro: ' + Qr_Itens_Pro.FIELDBYNAME('ICT_CODVCL').AsString + ' - ' + Qr_Itens_Pro.FIELDBYNAME('ICT_DESCRICAO').AsString);
          LcSemRegistro := True;
        end;
        Next;
      end;
    end;
    if LcSemRegistro then
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Problemas com Registro do(s) Produto(s):' + EOLN + EOLN +
                     lc_obs.Text,
                     ['OK'], [bEscape], mpErro);
      Result := false;
    End;
  Finally
    FreeAndNil(lc_obs);
  End;
end;

function TFr_Cotacao.Fc_VerificaCadastroServico():Boolean;
Var
   lc_obs: TMemo;
Begin
  Result := True;
  lc_obs := TMemo.Create(Fr_Cotacao);
  lc_obs.Visible := false;
  lc_obs.Parent := Fr_Cotacao;

  with Qr_Itens_Srv do
  Begin
    Active := True;
    First;
    while not Eof do
    begin
      Cotacao.Itens.Produto.Registro.Codigo := FIELDBYNAME('ICT_CODVCL').AsInteger;
      Cotacao.Itens.Produto.getbyId;
      if not Cotacao.Itens.Produto.exist then
      begin
        ResulT := False;
        Lc_obs.Lines.Add(FIELDBYNAME('ICT_CODVCL').AsString + ' - ' + FIELDBYNAME('ICT_DESCRICAO').AsString);
      end;
      Next;
    end;
  end;
    
  if not Result then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Problemas com Registro do(s) Serviço(s):' + EOLN + EOLN +
                   lc_obs.Text,
                   ['OK'], [bEscape], mpErro);
  end;
  FreeAndNil(lc_obs);
end;

function TFr_Cotacao.Fc_VerificaSaldoProduto: Boolean;
Var
  lc_obs: TMemo;
  Lc_Saldo:boolean;
  Lc_Qry : TSTQuery;
Begin
  Try
    Result := True;
    lc_obs := TMemo.Create(Self);
    lc_obs.Visible := false;
    lc_obs.Parent := Self;
    Lc_Qry := Base.GeraQuery;
    Lc_Qry.SQL.Add('SELECT PRO_CODIGO, PRO_DESCRICAO,PRO_EST_NEG, SUM(EST_QTDE) SALDO '+
                    'FROM TB_PRODUTO tb_produto '+
                    '  INNER JOIN TB_ESTOQUE '+
                    '  ON (PRO_CODIGO = EST_CODPRO) '+
                    '  INNER JOIN TB_ESTOQUES '+
                    '  ON (ETS_CODIGO = EST_CODETS) '+
                    'WHERE (PRO_CODIGO =:PRO_CODIGO) AND (ETS_CODMHA=:ETS_CODMHA) '+
                    'GROUP BY 1,2,3');
    with Qr_Itens_Pro do
    Begin
      Active := True;
      First;

      while not Eof do
      begin
        if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Commit;
        Lc_Qry.Active := False;
        Lc_Qry.ParamByName('PRO_CODIGO').AsInteger := FIELDBYNAME('ICT_CODVCL').AsInteger;
        Lc_Qry.ParamByName('ETS_CODMHA').AsInteger := Gb_CodMha;
        Lc_Qry.Active := True;
        Lc_Qry.FetchAll;
        Lc_Qry.First;
        if (Lc_Qry.FieldByName('PRO_EST_NEG').AsString = 'N') AND
        ( (Lc_Qry.FieldByName('SALDO').AsCurrency <= 0) or ( Lc_Qry.FieldByName('SALDO').AsCurrency < Qr_Itens_Pro.FieldByName('ICT_QTDE').AsFloat ) ) then
        Begin
          Result := False;
          Lc_obs.Lines.Add('Sem Saldo: ' + Lc_Qry.FIELDBYNAME('PRO_CODIGO').AsString + ' - ' + Lc_Qry.FIELDBYNAME('PRO_DESCRICAO').AsString + ' = ' + FloatToStrF(Lc_Qry.FieldByName('SALDO').AsCurrency, ffFixed, 10, 0));
        end;
        Next;
      end;
    end;
    if ( not result ) then
    Begin
       MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                      'Problemas de Saldo de Produtos com os seguintes itens:.'+EOLN+EOLN+
                       lc_obs.Text + EOLN +
                      'Caso Necessário Peça Autorização.' + EOLN,
                      ['OK'], [bEscape], mpAlerta);
        Result := False;
      end
    else
    Begin
      Result := True;
      if (Gb_Nivel = 0)  then Gb_Liberado := False;
    End
  Finally
    FreeAndNil(lc_obs);
    Base.FinalizaQuery(Lc_Qry);
  End;

end;

function TFr_Cotacao.Fc_ValidaAlteracao: Boolean;
begin
  Result := True;
  if validaPedidoExiste then
  Begin
    Result:=false;
    exit;
  End;
  if Gb_Nivel =0 then
  Begin
    if ( Fc_Tb_Geral('L','ORC_G_SO_VENDEDOR_ALTERA','N') = 'S') then
    BEgin
      if ( Fm_VendedorCotacao.Dblcb_Vendedor.KeyValue <> GB_Cd_Vendedor ) and
         ( Fm_VendedorCotacao.Dblcb_Vendedor.KeyValue <> Fm_ListaAuxiliarVenda.Dblcb_Vendedor.KeyValue ) and
         ( Fm_ListaAuxiliarVenda.Dblcb_Vendedor.Text = '' )  then
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Somente o ppróprio vendedor pode alterar este orçamento.' + EOLN +
                       'Verifique antes para continuar.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        result:=false;
        exit;
      End;
    End;
  End;
end;

function TFr_Cotacao.Fc_ValidaCancelameto: Boolean;
begin
  Result := True;
  If E_Aq_Desconto.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;
  if E_VL_Desconto.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;
  If E_Nr_Parcelas.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;
end;

function TFr_Cotacao.Fc_ValidaFaturamento(): Boolean;
var
   Lc_Saldo: Boolean;
begin
  Lc_Saldo := True;
  Result := True;
  if validaPedidoExiste then
  Begin
    Result:=false;
    exit;
  End;

  If not Fc_ValidasPrecoeParcelamento then //Verifica se a tabela usada no parcelamento é válida
  Begin
    Result := False;
    exit;
  end;

  if (StrtoIntDef(E_Cd_Empresa.Text,0) > 0 ) then
  Begin
    Cliente.Empresa.Registro.Codigo := StrtoIntDef(E_Cd_Empresa.Text,0);
    Cliente.Empresa.getById;
  End;

  if (not Cliente.Empresa.exist) or (StrtoIntDef(E_Cd_Empresa.Text,0) = 0 ) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por Favor Cadastre o Cliente antes' + EOLN +
                   '        de gerar o pedido.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    result:=false;
    exit;
  end;

  //Verifica se há endereco
  Cliente.Empresa.Endereco.Registro.CodigoEmpresa := StrToIntDef(E_Cd_Empresa.Text,0);
  Cliente.Empresa.Endereco.getByEmpresa;
  if not Cliente.Empresa.Endereco.exist then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Por Favor Cadastre o Endereço do cliente' + EOLN +
                   '         antes de gerar o pedido.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result:=false;
    exit;
  end;
  //Verifica se o produto esta cadastrado
  if not Fc_VerificaCadastroProduto then
  Begin
    Result := False;
    exit;
  end;

  //Verifica saldo do produto
  if not Fc_VerificaSaldoProduto then
  Begin
    Result := False;
    exit;
  end;

  //Verifica se o Servico esta cadastrado
  if not Fc_VerificaCadastroServico then
  Begin
    Result := False;
    exit;
  end;

  if trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) = '' then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Forma de Pagamento não Preenchido.' + EOLN + EOLN ,
                   ['OK'], [bEscape], mpErro);
    Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    result:=false;
    exit;
  end;

  if (StrToFloatDef(E_VL_Cotacao.Caption, 0) <= 0) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Cotação sem valor. Verifique Itens e Serviço.' + EOLN + EOLN ,
                   ['OK'], [bEscape], mpErro);
    result:=false;
    exit;
  end;

  if (Trim(Fm_VendedorCotacao.DBLCB_Vendedor.Text) = '') then
  begin
  MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Favor informar o nome do Vendedor.' + EOLN + EOLN ,
                   ['OK'], [bEscape], mpAlerta);
    IF Fm_VendedorCotacao.DBLCB_Vendedor.CanFocus then Fm_VendedorCotacao.DBLCB_Vendedor.SetFocus;
    result:=false;
    exit;
  end;

  PC_GeraNumero;
end;

procedure TFr_Cotacao.Pc_AtivarTabelas;
begin
  Fm_VendedorCotacao.ListaVendedor;
  PC_Sel_FormPagto(It_bloqueio);
  Fm_ListaAuxiliarVenda.ListaColaborador;
end;

procedure TFr_Cotacao.PC_Buscar;
Begin
  with Qr_Pesquisa do
  Begin
    Close;
    Sql.Clear;
    Sql.add(concat(
            'SELECT DISTINCT CTC_CODIGO, CTC_DATA, CTC_NUMERO, CTC_FANTASIA, CTC_VL_COTACAO, EMP_FANTASIA ' ,
            'FROM TB_COTACAO c ' ,
            '  LEFT OUTER JOIN TB_CONSERTO tb_conserto ' ,
            '  ON (c.CTC_CODPED =  tb_conserto.CST_CODPED) ' ,
            '  LEFT OUTER JOIN TB_PEDIDO Tb_pedido ' ,
            '  ON  (Tb_pedido.PED_CODIGO = c.CTC_CODPED) ' ,
            '  LEFT OUTER JOIN TB_EMPRESA Tb_empresa ' ,
            '  ON  (Tb_empresa.EMP_CODIGO = c.CTC_CODEMP) '
    ));

    SQL.Add(InnerSQL);
    SQL.Add(whereSQL);
    SQL.Add(' ORDER BY CTC_FANTASIA ');
    PassarParametros(Qr_Pesquisa);
    Open;
    FetchAll;
  End;
  tbs_busca_cotacao.Caption := 'Orçamentos : ' + IntToStr(Qr_Pesquisa.RecordCount) +  ' Registro(s)';
end;

procedure TFr_Cotacao.PC_Buscar_Resumo_Itens;
Begin
  with Qr_Pesquisa_itens do
  Begin
    Close;
    Sql.Clear;
    Sql.add(concat(
            'SELECT PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO, SUM(ICT_QTDE) QT_ITENS ' ,
            'FROM TB_COTACAO c ' ,
            '  LEFT OUTER JOIN TB_CONSERTO tb_conserto ' ,
            '  ON (c.CTC_CODPED =  tb_conserto.CST_CODPED) ' ,
            '  LEFT OUTER JOIN TB_PEDIDO Tb_pedido ' ,
            '  ON  (Tb_pedido.PED_CODIGO = c.CTC_CODPED) ' ,
            '  LEFT OUTER JOIN TB_EMPRESA Tb_empresa ' ,
            '  ON  (Tb_empresa.EMP_CODIGO = c.CTC_CODEMP) '
    ));

    SQL.Add(InnerSQL);
    if (not prmCdProduto) and (not prmDescProduto) and (not prmMarca)  then
    Begin
      SQL.Add(concat(
                    ' INNER JOIN TB_ITENS_CTC I '+
                    ' on (i.ict_codctc = c.ctc_codigo) '+
                    ' INNER JOIN TB_PRODUTO P '+
                    ' ON (P.pro_codigo = I.ict_codvcl) '
//                    ' INNER JOIN tb_marca_produto M ',
//                    ' ON (M.mrc_codigo = P.pro_codmrc) '
      ));
    End;
    SQL.Add(whereSQL);
    SQL.Add(' group BY 1,2,3 ');
    SQL.Add(' ORDER BY PRO_DESCRICAO ');
    PassarParametros(Qr_Pesquisa_itens);
    Open;
    FetchAll;
    tbs_busca_cotacao_itens.Caption := 'Resumo Itens : ' + IntToStr(Qr_Pesquisa_itens.RecordCount) +  ' Registro(s)';
  End;
end;

procedure TFr_Cotacao.Pc_Visualizar;
begin
  Cotacao.getbyId;
  Cotacao.using('B');
  Pc_AtivarTabelas;
  Pc_AbrirCotacao;
  It_Edicao_Ordem := 'B';
  Pc_EstadoEdicaoOrdem;
  Pg_Cotacao.ActivePageIndex := 0;
end;

procedure TFr_Cotacao.Pc_AtualizaCampos;
Var
  Lc_Vl_DEsconto : Real;
  Lc_Aq_Desconto : Real;
  Lc_Qt_Produto : Real;
  Lc_Vl_Produto : Real;
  Lc_VL_Servico : Real;
  Lc_Vl_IPI : Real;
begin
  Lc_Qt_Produto := 0;
  Lc_Vl_Produto := 0;
  Lc_Vl_IPI := 0;
  Lc_Vl_DEsconto := 0;
  Pc_AbrirItensVenda;
  while not Qr_Itens_Pro.Eof do
  begin
    Lc_Vl_Produto := Lc_Vl_Produto + Qr_Itens_Pro.FieldByName('ICT_VL_SUBTOTAL').AsCurrency;
    Lc_Qt_Produto := Lc_Qt_Produto + Qr_Itens_Pro.FieldByName('ICT_QTDE').AsFloat;
    Lc_Vl_IPI := Lc_Vl_IPI + Qr_Itens_Pro.FieldByName('ICT_AQ_IPI').AsCurrency;
    Lc_Vl_DEsconto := Lc_Vl_DEsconto + Qr_Itens_Pro.FieldByName('ICT_VL_DESC').AsCurrency;
    Qr_Itens_Pro.Next;
  end;

  Pc_AbrirItensServico;
  Qr_Itens_Srv.First;
  Lc_VL_Servico := 0;
  while not Qr_Itens_Srv.Eof do
  begin
    Lc_VL_Servico := Lc_VL_Servico + Qr_Itens_Srv.FieldByName('ICT_VL_SUBTOTAL').AsCurrency;
    Lc_Vl_DEsconto := Lc_Vl_DEsconto + Qr_Itens_Srv.FieldByName('ICT_VL_DESC').AsCurrency;
    Qr_Itens_Srv.Next;
  end;

  E_Qt_Produto.Text := FloatToStrF(Lc_Qt_Produto, ffFixed, 10, 2);
  E_VL_Produto.Caption := FloatToStrF(Lc_VL_Produto, ffFixed, 10, 2);
  E_Vl_Servico.Caption := FloatToStrF(Lc_VL_Servico, ffFixed, 10, 2);
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_DEsconto,ffFixed,10,2);
  Lc_Aq_Desconto := (Lc_VL_Desconto / (Lc_VL_Produto + Lc_VL_Servico) ) * 100;
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
end;

procedure TFr_Cotacao.Pc_Totalizador;
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
  //Frete
  Lc_Vl_aux := StrToFloatDef(E_VL_Frete.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_Frete.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Adicional
  Lc_Vl_aux := StrToFloatDef(E_Vl_Adicional.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_Vl_Adicional.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Desconto
  Lc_Vl_aux := StrToFloatDef(E_VL_Desconto.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total - Lc_Vl_aux;
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Valor total
  E_VL_Cotacao.Caption := FloatToStrF(Lc_Vl_Total, ffFixed, 10, 2);
end;


// Procedures Internas



{Ordem de Servico/Venda}


procedure TFr_Cotacao.FormClose(Sender: TObject;
   var Action: TCloseAction);
begin
  FreeAndNil(cotacao);
  FreeAndNil(Pedido);
  FreeAndNil(Cliente);
  FreeAndNil(Base);
end;

procedure TFr_Cotacao.SB_VoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFr_Cotacao.DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if Shift = [] then
      case Key of
         VK_delete: Sb_Exc_ProdutoClick(Sender);
      end;
end;

procedure TFr_Cotacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not (ActiveControl is TMemo) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;


procedure TFr_Cotacao.SB_ClienteClick(Sender: TObject);
begin
  Pc_ChamaCadastroCliente(E_Cd_Empresa.Text);
end;

procedure TFr_Cotacao.Sb_Confirma_TabelaPrecoClick(Sender: TObject);
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

procedure TFr_Cotacao.Sb_PesquisarClick(Sender: TObject);
begin
  Cotacao.using('L');
  Pc_AtivaEstabelecimento;
  Fm_ListaVendedores.ListaVendedor;
  Pg_Cotacao.ActivePageIndex := 1;
  PC_Buscar;
end;

procedure TFr_Cotacao.E_VL_FreteExit(Sender: TObject);
begin
   Pc_Totalizador;
end;

procedure TFr_Cotacao.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) then
  begin
    case PG_Itens.ActivePageIndex of
      0:begin
          if shift = [] then
          begin
            case Key of
              VK_F2: if Sb_Ins_Produto.Enabled then Sb_Ins_ProdutoClick(Sender);
              VK_F3: if Sb_Alt_Produto.Enabled then Sb_Alt_ProdutoClick(Sender);
              VK_F4: if Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
            end;
          end;
        end;
      1:begin
          if shift = [] then
          begin
            case Key of
              VK_F2: if Sb_Ins_Servico.Enabled then Sb_Ins_ServicoClick(Sender);
              VK_F3: if Sb_Alt_Servico.Enabled then Sb_Alt_ServicoClick(Sender);
              VK_F4: if Sb_Exc_Servico.Enabled then Sb_Exc_ServicoClick(Sender);
              VK_F8: if Sb_Servico.Enabled then SB_ServicoClick(Sender);
              VK_F9: if Sb_Tecnico.Enabled then Sb_TecnicoClick(Sender);
            end;
          end;
        end;
      end;
   end;

  case Pg_Cotacao.ActivePageIndex of
    0:begin
        if shift = [] then
        begin
          case Key of
            VK_F2: if SB_Inserir.Enabled then SB_InserirClick(Sender);
            VK_F3: if SB_Alterar.Enabled then SB_AlterarClick(Sender);
            VK_F4: if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
            VK_F5: if SB_Gravar.Enabled then SB_GravarClick(Sender);
            VK_F6: if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
            VK_F7: if SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
            VK_F10: if SB_Pedido.Enabled then SB_PedidoClick(Sender);
            VK_F11: if SB_Enviar.Enabled then SB_EnviarClick(Sender);
            VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
          end;
        end;
      end;
      else
      begin
        if shift = [] then
        begin
          case Key of
            VK_F2: if SB_Cadastrar.Enabled then SB_CadastrarClick(Sender);
            VK_F7: if SB_Buscar.Enabled then SB_BuscarClick(Sender);
            VK_F8: if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
            VK_Escape: if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
          end;
        end;
      end;
    end;

end;

procedure TFr_Cotacao.tbs_pesquisaShow(Sender: TObject);
begin
  if E_BuscaCotacao.CanFocus then E_BuscaCotacao.SetFocus;
  E_BuscaCotacao.SelectAll;
  popLucratividade.Visible := False;
  Pop_ConfigLocal.Visible := True;
  Pop_ConfigGlobal.Visible := True;   
end;

procedure TFr_Cotacao.SB_InserirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
      'Deseja mesmo abrir um novo Orçamento.' + EOLN + EOLN +
      'Confirmar a Abertura ?',
      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    Pc_AbreCotacaoNovo;
    It_Edicao_Ordem := 'I';
    Pc_EstadoEdicaoOrdem;
    If E_Data.CanFocus then E_Data.SetFocus;
  end;
end;

procedure TFr_Cotacao.SB_AlterarClick(Sender: TObject);
begin
  if Fc_ValidaAlteracao then
  Begin
    It_Edicao_Ordem := 'E';
    Pc_EstadoEdicaoOrdem;
    //Pc_AbrirCotacao;
    If E_Data.CanFocus then E_Data.SetFocus;
  end;
end;

procedure TFr_Cotacao.SB_ExcluirClick(Sender: TObject);
begin
   if (MensagemPadrao(TITULO_CONFIRMACAO,
      'Excluir ' + Cotacao.Registro.numero + ' de seus arquivos.' + EOLN + EOLN +
      'Confirmar a exclusão ?',
      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
  begin
    Cotacao.enviaLixeira;
    Cotacao.using('L');
    Pc_Limpa_campo_buscar;
    PC_Buscar;
    Pg_Cotacao.ActivePage := tbs_pesquisa;
  end;
end;

procedure TFr_Cotacao.SB_GravarClick(Sender: TObject);
begin
  If Fc_ValidaGravacao then
  Begin
    Screen.Cursor := crHourGlass;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFr_Cotacao.Sb_InclusaoRapidoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;
  Try
    Lc_Form := TFr_Pesq_Produto.Create(nil);
    Lc_Form.CodigoCotacao := Cotacao.Registro.Codigo;
    Lc_Form.CodigoPedido  := Cotacao.Registro.Codped;
    Lc_Form.It_Cotacao_Vda := True;
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
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  End;

end;

procedure TFr_Cotacao.SB_CadastrarClick(Sender: TObject);
Begin
  Pg_Cotacao.ActivePage := tbs_cotacao;
  Pc_AbreCotacaoNovo;
  It_Edicao_Ordem := 'I';
  Pc_EstadoEdicaoOrdem;
  If E_Data.CanFocus then E_Data.SetFocus;
end;

procedure TFr_Cotacao.SB_CancelarClick(Sender: TObject);
begin
  if Fc_ValidaCancelameto then
  Begin
    If ( It_Edicao_Ordem = 'I' ) then
      Sb_PesquisarClick(sELF);
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Cotacao.Sb_Cancela_TabelaPrecoClick(Sender: TObject);
begin
  ControleElementos(True);
end;

procedure TFr_Cotacao.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;


procedure TFr_Cotacao.SB_BuscarClick(Sender: TObject);
begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    SB_Cadastrar.Enabled  := False;
    SB_Buscar.Enabled     := False;
    SB_Visualizar.Enabled := False;
    Sb_Sair_1.Enabled     := False;
    VerifyParameters;
    PC_Buscar;
    PC_Buscar_Resumo_Itens;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    SB_Cadastrar.Enabled  := It_Inserir;
    SB_Buscar.Enabled     := True;
    SB_Visualizar.Enabled := True;
    Sb_Sair_1.Enabled     := True;
  end;
end;

procedure TFr_Cotacao.SB_VisualizarClick(Sender: TObject);
begin
  If validaVisualizar then
  Begin
    Pc_Visualizar;
  end;
end;

procedure TFr_Cotacao.Sb_Sair_1Click(Sender: TObject);
begin
   Close;
end;

function TFr_Cotacao.EmEdicao: Boolean;
begin
  Result := False;
  If ( (It_Edicao_Ordem = 'B') OR (It_Edicao_Ordem = 'E') )  then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                  'Grave o Pedido antes de continuar. '+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := True;
  end;
end;

function TFr_Cotacao.EmNavegacao: Boolean;
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

procedure TFr_Cotacao.EscolheTabela;
begin
  ControleElementos(false);
  Pc_AbrirItensVenda;
  Fm_ListaTabelaPreco.Listar(Qr_Itens_Pro.FieldByName('ICT_CODTPR').asinteger);
  if Fm_ListaTabelaPreco.CanFocus then
    Fm_ListaTabelaPreco.Dblcb_Lista.SetFocus;
  Application.ProcessMessages

end;

procedure TFr_Cotacao.E_Aq_DescontoExit(Sender: TObject);
Var
  Lc_Aq_Desconto:Real;
  Lc_Vl_Cotacao : Real;
  Lc_Vl_Desconto : Real;
begin
  Lc_Vl_Cotacao := StrtoFloatDef(E_VL_Produto.Caption,0) + StrtoFloatDef(E_Vl_Servico.Caption,0);
  Lc_Aq_Desconto := StrToFloatDef(E_Aq_Desconto.Text,0);
  Lc_Vl_Desconto := Lc_Vl_Cotacao * (Lc_Aq_Desconto/100);
  Cotacao.AplicarDescontoItens(Cotacao.Registro.Codped,Lc_Vl_Desconto);
  E_Aq_Desconto.Text := FloatToStrf(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_AbrirItensVenda;
  Pc_AtualizaCampos;
  Pc_totalizador;
end;

procedure TFr_Cotacao.E_VL_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Cotacao : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Cotacao := StrtoFloatDef(E_VL_Produto.Caption,0) + StrtoFloatDef(E_Vl_Servico.Caption,0);
  Lc_VL_Desconto := StrtoFloatDef(E_VL_Desconto.Text,0);
  Cotacao.AplicarDescontoItens( Cotacao.Registro.codped,Lc_vl_Desconto);
  Lc_Aq_Desconto := (Lc_VL_Desconto / Lc_Vl_Cotacao) * 100;
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_AbrirItensVenda;
  Pc_AtualizaCampos;
  Pc_totalizador;
end;

procedure TFr_Cotacao.Sb_Ins_ProdutoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_CTC_Vda;
begin
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;
  //Cria O Formulario
  try
    Lc_Form := TFr_Itens_Produto_CTC_Vda.create(nil);
    Lc_Form.it_Cd_Empresa := Cotacao.Registro.Codemp;
    Lc_Form.Pc_StateChange(2);
    Lc_Form.It_Cd_Cotacao := Cotacao.Registro.Codigo;
    Lc_Form.It_Cd_Pedido := Cotacao.Registro.Codped;
    Lc_Form.It_MultiplicadorPreco := It_MultiplicadorPreco;
    Lc_Form.It_Aliq_Comissao := It_Aliq_Comissao;
    Lc_Form.LoadItems(Qr_Itens_Pro);
    Lc_Form.It_Cotacao_Vda := True;
    Lc_Form.E_Aq_Desconto.Text := '0,00';
    Lc_Form.E_VL_Desconto.Text := '0,00';
    Lc_Form.E_Qt_Produto.Text := '1';
    Lc_Form.it_Modalidade_preco := Fc_DefineTabela;
    Lc_Form.it_TipoCliente := Fc_DefineTipoPessoa;
    Lc_Form.LoadItems(Qr_Itens_Pro);
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Pc_AtualizaStatusInterface();
  end;
end;

procedure TFr_Cotacao.Pc_AtualizaStatusInterface();
Begin
  Pc_AbrirItensVenda;
  Pc_AbrirItensServico;
  Pc_AtualizaCampos;
  Pc_Totalizador;
  Pc_EstadoEdicaoOrdem;
  PC_Sel_PrazoPagto(It_bloqueio);
end;

procedure TFr_Cotacao.Sb_Alt_ProdutoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_CTC_Vda;
begin
  Try
    //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_CTC_Vda.Create(nil);
    Lc_Form.Pc_StateChange(3);
    Lc_Form.It_Cd_Cotacao := Cotacao.Registro.Codigo;
    Lc_Form.It_Cd_Pedido := Cotacao.Registro.Codped;
    Lc_Form.It_MultiplicadorPreco := It_MultiplicadorPreco;
    Lc_Form.It_Inserir            := True;
    Lc_Form.editItems(Qr_Itens_Pro.FIELDBYNAME('ICT_CODIGO').AsInteger);
    Lc_Form.it_Modalidade_preco   := Fc_DefineTabela;
    Lc_Form.it_TipoCliente        := Fc_DefineTipoPessoa;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    Pc_AtualizaStatusInterface;
  End;
end;

procedure TFr_Cotacao.Sb_Exc_ProdutoClick(Sender: TObject);
begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
      'Excluir o item ' + Qr_Itens_Pro.FieldByName('ICT_DESCRICAO').AsString + ' desta Cotação.' + EOLN + EOLN +
      'Confirmar a exclusão ?',
      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao2) then
      exit;
   try
      Pc_ApagaItensCotacao(Qr_Itens_Pro.FieldByName('ICT_CODIGO').AsInteger);
      Pc_AbrirItensVenda;
      Pc_EstadoEdicaoOrdem;
      PC_Sel_PrazoPagto(It_bloqueio);
      Pc_AtualizaStatusInterface();
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  END;                 
end;

procedure TFr_Cotacao.DBG_ProdutosDrawColumnCell(Sender: TObject;
   const Rect: TRect; DataCol: Integer; Column: TColumn;
   State: TGridDrawState);
begin
//   if Ds_Itens_Pro.DataSet.FieldByName('ICT_DISPON').AsString = 'N' then
//      DBG_Produtos.Canvas.Font.Color := clRed;
//   DBG_Produtos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFr_Cotacao.E_Cd_EmpresaExit(Sender: TObject);
begin
  if ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (StrToIntDef(E_Cd_Empresa.Text,0) > 0) then
  begin
    if Chbx_Nome.Checked then
      CB_Empresa.Text := Fc_BuscaNomeCliente('EMP_NOME',E_Cd_Empresa.Text)
    else
      CB_Empresa.Text := Fc_BuscaNomeCliente('EMP_FANTASIA',E_Cd_Empresa.Text);
    Fc_PosicionaCliente('EMP_CODIGO',E_Cd_Empresa.Text);
  end;
end;

procedure TFr_Cotacao.SB_PedidoClick(Sender: TObject);
var
  Lc_cd_Pedido: Integer;
  Lc_Nr_Pedido:String;
  LcForm : TFr_Pedido_Vda;
begin
  if Fc_ValidaFaturamento then
  begin
    Lc_cd_Pedido := PreGeracaoPEdido(Cotacao.Registro.Codped);
    if (MensagemPadrao(MENSAGEM, TITULO_CONFIRMACAO + EOLN + EOLN +
                       'Deseja gerar um pedido a partir deste orçamento?' + EOLN + EOLN +
                       'Confirma a operação?' + EOLN,
                       [SIM, NAO], [bNormal,bEscape ], mpConfirmacao, clRed) = mrBotao1) then
    Begin
      Lc_Nr_Pedido := Fc_GeraPedido(Lc_cd_Pedido);

      if (MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                         'Pedido Nº ' + Lc_Nr_Pedido + ' Gerado com Sucesso' + EOLN + EOLN +
                         'Deseja visualizar o pedido agora?' + EOLN,
                         [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
      begin
        Pedido.using('L');
        Self.Hide;
        Self.Close;
        try
          LcForm := TFr_Pedido_Vda.create(nil);
          LcForm.Pedido.Registro.Codigo := Lc_cd_Pedido;
          LcForm.Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
          LcForm.ShowModal;
          Pg_Cotacao.ActivePageIndex := 1;
        finally
          FreeAndNil(LcForm);
        end;
      end
      else
      begin
        Sb_PesquisarClick(self);
      end;
    end;
  end;
end;


procedure TFr_Cotacao.TrocaTabela(pCodigoTabela: Integer);
Var
  I : Integer;
  Lc_Tabela : TSTQuery;
  Lc_Qtde : Real;
  Lc_Valor : Real;
Begin
  Try
    Lc_Tabela := base.GeraQuery;
    with Lc_Tabela do
    Begin
      sql.Add('SELECT PRC_VL_VDA '+
              'FROM TB_PRECO '+
              'WHERE (PRC_CODTPR =:PRC_CODTPR) '+
              ' AND ( PRC_CODPRO =:PRC_CODPRO) ');
    End;

    with Qr_Itens_Pro do
    Begin
      while not eof do
      Begin
        Lc_Tabela.Active := False;
        Lc_Tabela.ParamByName('PRC_CODTPR').AsInteger := pCodigoTabela;
        Lc_Tabela.ParamByName('PRC_CODPRO').AsInteger := Qr_Itens_Pro.FieldByNAme('ICT_CODVCL').asInteger;
        Lc_Tabela.Active := True;
        Lc_Tabela.FetchAll;
        //Altera o valor Unitario
        Cotacao.Itens.Registro.Codigo := Qr_Itens_Pro.FieldByNAme('ICT_CODIGO').asInteger;
        Cotacao.Itens.getById;
        Cotacao.Itens.Registro.TabelaPreco := pCodigoTabela;
        Cotacao.Itens.Registro.ValorUnitario := Lc_Tabela.FieldByName('PRC_VL_VDA').AsCurrency;
        Cotacao.Itens.atualiza;
        next;
      End;
    End;
  Finally
    base.FinalizaQuery(Lc_Tabela);
  End;

end;

function TFr_Cotacao.ValidaEnvioWhatsApp: Boolean;
begin
  Result := True;
  FWhatsAppNumber := E_Contato.Text;
  if ( Length(FWhatsAppNumber) > 0 ) and ( Length(FWhatsAppNumber)<9 ) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' O Campo Contato/Telefones/WhatsApp parece estar incompleto. ' +EOLN +
                   ' Verifique se o número informado está correto. ' +EOLN +
                   ' Verifique para continuar'+EOLN,
                   ['OK'], [bEscape], mpErro);
    FWhatsAppNumber := '';
    Result := False;
    exit;
  End
  else
  Begin
    FWhatsAppNumber := '';
    if StrToIntDef(E_Cd_Empresa.Text,0) > 0 then
    Begin
      Cliente.Empresa.Endereco.Registro.CodigoEmpresa := StrToIntDef(E_Cd_Empresa.Text,0);
      Cliente.Empresa.Endereco.getByEmpresa;
      if (Cliente.Empresa.Endereco.exist) then
      Begin
        FWhatsAppNumber := Cliente.Empresa.Endereco.Registro.Celular;
        if ( Length(FWhatsAppNumber) > 0 ) and ( Length(FWhatsAppNumber)<9 ) then
        Begin
          MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                         ' Não foi encontrado nenhum número de whatsApp válido. ' +EOLN +
                         ' Verifique o cadastro para continuar.' +EOLN ,
                         ['OK'], [bEscape], mpErro);
          FWhatsAppNumber := '';
          Result := False;
          exit;
        End
      End;
    End;
  End;

end;

function TFr_Cotacao.validaPedidoExiste: Boolean;
begin
  REsult := False;
  Pedido.Registro.Codigo := Cotacao.getCodigoPedido;
  Pedido.getbyId;
  if Pedido.exist then
  Begin
    if (pedido.Registro.Faturado <> 'C') AND (pedido.Registro.Faturado <> '') then
    Begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' Orçamento não pode ser modificado. ' +EOLN +
                     ' Foi gerado o pedido ou já foi faturado ou Pedido foi apagado. ' +EOLN +
                     ' Esta tela será fechada.'+EOLN,
                     ['OK'], [bEscape], mpErro);
      Sb_PesquisarClick(sELF);
      It_Edicao_Ordem := 'B';
      Pc_EstadoEdicaoOrdem;
      Result:=true;
      exit;
    End;
  End;
end;

function TFr_Cotacao.ValidaTrocaTabela: Boolean;
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

function TFr_Cotacao.validaVisualizar: Boolean;
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
  cotacao.Registro.Codigo := Qr_Pesquisa.FieldByName('CTC_CODIGO').AsInteger;
  If not cotacao.using('C') then
  Begin
    cotacao.clear;
    result:=false;
    exit;
  end;
end;

function TFr_Cotacao.VerificaProdutoSemEstoque: Boolean;
Var
  Lc_Qry : TSTQuery;
  LcMsg : TStringList;
begin
  Try
    Lc_Qry := base.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select PRO_CODIGO, PRO_DESCRICAO,e.est_qtde ',
                'from tb_itens_ctc i ',
                '  inner join tb_cotacao c ',
                '  on (c.ctc_codigo = i.ict_codctc) ',
                '  left outer join tb_produto p ',
                '  on (p.pro_codigo = i.ict_codvcl) ',
                '  left outer join tb_estoque e ',
                '  on (e.est_codpro = i.ict_codvcl) ',
                '    and (i.ict_codest = e.est_codets) ',
                'WHERE ( I.ict_codctc =:ict_codctc ) ',
                ' and ( (e.est_qtde = 0) or (e.est_qtde is null)  ) ',
                ' and c.ctc_codmha=:ctc_codmha ',
                ' and (i.ict_tipo <> ''S'') '
      ));
      ParamByName('ict_codctc').AsInteger := Cotacao.Registro.Codigo;
      ParamByName('ctc_codmha').AsInteger := Gb_CodMha;
      Active := True;
      FetchAll;
      if RecordCount >0 then
      Begin
        First;
        LcMsg := TStringList.Create;
        LcMsg.Clear;
        while not eof  do
        BEgin
          LcMsg.Add(concat(FieldByName('PRO_CODIGO').AsString, ' - ' , FieldByName('PRO_DESCRICAO').AsString));

          Next;
        End;
        MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                       'Constam produtos sem estoque, confirme valores e condições antes de imprimir.' + EOLN + EOLN +
                        LcMsg.Text + EOLN +
                       'Clique em ok para avançar com a gravação.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
      End;
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TFr_Cotacao.VerifyParameters;
begin
  if Trim(E_BuscaEstado.Text)   = '' then PrmEstado     := False else PrmEstado     := True;
  if Trim(E_BuscaCidade.Text)   = '' then PrmCidade     := False else PrmCidade     := True;
  if Trim(E_BuscaEmail.Text)    = '' then Prmemail      := False else Prmemail      := True;
  IF Trim(E_BuscaFone.Text)     = '' then PrmFone       := False else PrmFone       := True;

  if Trim(Fm_ListaProdutos.E_Cd_Produto.Text) <> '' then PrmCdProduto := True else PrmCdProduto := False;
  if Trim(Fm_ListaProdutos.E_Busca_Produto.Text) <> '' then PrmDescProduto := true else PrmDescProduto := False;
  if Trim(Fm_ListaMarca_Produto.Dblcb_Marca.Text) <> '' then PrmMarca := true else PrmMarca := False;
end;

Procedure TFr_Cotacao.Pc_Chama_Impressora;
Var
  Lc_Imp : TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.create(nil);
    Pc_GeraNumero;
    Lc_Imp.Pc_Imp_Tipo(0,Cotacao.REgistro.Codped,0);
  finally
    FreeAndNil(Lc_Imp);
  end;
end;

procedure TFr_Cotacao.Pc_Envia_Email_Sem_Anexo;
Var
  Lc_Destinatario : TStringList;
  Lc_Anexo        : TStringList;
  LcEnviaemail : TFr_envia_email;
Begin
  PC_GeraNumero;
  if MessageDlg('Enviar e-mail deste Orçamento ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Lc_Anexo        := TStringList.Create;
    Lc_Anexo.Add('Sem anexo');
    Lc_Destinatario := TStringList.Create;
    Pc_ListaEmailParaEnvio(E_Cd_Empresa.Text,['PRINCIPAL%','ORÇAMENTO'],Lc_Destinatario) ;
    if Length(Trim(E_email.Text)) > 0 then Lc_Destinatario.Add(' '+E_email.Text);
    if Lc_Destinatario.Count > 0 then
    begin
      Try
        LcEnviaemail := TFr_envia_email.Create(nil);
        with LcEnviaemail do
        Begin
          It_Tipo_Envio := 'S';
          It_Assunto := 'Orçamento Nº ' + Lb_Numero.Caption;
          It_Destino := Lc_Destinatario;
          It_Corpo   := Fc_GeraEmail_Cotacao;
          It_Anexo   := lc_anexo;
          ShowModal;
        end;
      Finally
        FreeAndNil(LcEnviaemail);
      End;
    end
    else
      begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'e-mail não informado verifique.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpErro);
      end;
  end;
end;

procedure TFr_Cotacao.Pc_Envia_WhatsApp;
Var
  LcW : TWhatsApp;
  Lc_Imp : TimpModImpressao;
begin
  PC_GeraNumero;
  if MessageDlg('Enviar Orçamento via WhatsApp ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Try
      if ValidaEnvioWhatsApp then
      Begin
        Lc_Imp := TimpModImpressao.create(nil);
        Lc_Imp.NomePDF := 'cotacao.pdf';
        Lc_Imp.SalvaPDF := True;
        Lc_Imp.CodigoPedido := Cotacao.Registro.codped;
        Lc_Imp.Pc_Imp_Orc_JatoLaser;

        LcW := TWhatsApp.create(nil);
        LcW.Mensagem := 'Ola, preparamos o teu orcamento, segue em anexo.';
        LcW.ReceiverNumber := E_Contato.Text;
        //Agora Envia o Anexo
        LcW.Arquivo := GbPathExe + 'cotacao.pdf';
        LcW.RegisterMessage;
        LcW.Send;
      End;

    Finally
      FreeAndNil(LcW);
      FreeAndNil(Lc_Imp);
    End;
  end;
end;

procedure TFr_Cotacao.Pc_EstadoEdicaoOrdem;
begin
  //Cabeçalho do Pedido
  Pnl_Fundo.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  //botos aba produto
  Sb_Ins_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (Qr_Itens_Pro.RecordCount > 0);
  Sb_Exc_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (Qr_Itens_Pro.RecordCount > 0);

  //botos aba servico
  Sb_Ins_Servico.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Servico.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_Itens_Srv.RecordCount > 0);
  Sb_Exc_Servico.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_Itens_Srv.RecordCount > 0);
  Sb_Servico.Enabled       := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Tecnico.Enabled       := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) AND (Qr_Itens_Srv.RecordCount > 0);


// botoes gerais
  SB_Inserir.Enabled       := (It_Edicao_Ordem = 'B') and It_Inserir;
  SB_Excluir.Enabled       := (It_Edicao_Ordem = 'B') and It_Excluir and (cotacao.Registro.Codigo > 0);
  SB_Enviar.Enabled      := (It_Edicao_Ordem = 'B') and It_Enviar;
  SB_Pedido .Enabled       := (It_Edicao_Ordem = 'B') and It_Pedido;
  SB_Alterar.Enabled       := (It_Edicao_Ordem = 'B') and It_Alterar and (cotacao.Registro.Codigo > 0);
  SB_Gravar.Enabled        := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  SB_Cancelar.Enabled      := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Pesquisar.Enabled     := (It_Edicao_Ordem = 'B');
  Sb_Sair_0.Enabled        := (It_Edicao_Ordem = 'B');


   Fm_FormaPagto.DBLCB_FormaPagto.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   Fm_VendedorCotacao.DBLCB_Vendedor.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   E_Nr_Parcelas.Enabled    := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   DBLCB_Prazo.Enabled      := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   E_Prazo.Enabled          := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   Sb_Parcelamento.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   E_Data.Enabled           := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   E_Cd_Empresa.Enabled     := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   SB_Cliente.Enabled       := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   Cb_Empresa.Enabled       := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   E_Contato.Enabled        := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   E_email.Enabled          := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   Pnl_Produto.Enabled      := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );

   pnl_Totalizar.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
   MnuCustodoPedido.Enabled      := (It_Edicao_Ordem = 'B') and (Cotacao.Registro.Codigo > 0);

end;

procedure TFr_Cotacao.Pc_Envia_Email_Com_Anexo;
Var
  Lc_Destinatario : TStringList;
  Lc_Anexo        : TStringList;
  Lc_Imp : TimpModImpressao;
  LcEnviaemail : TFr_envia_email;
Begin
  PC_GeraNumero;
  if MessageDlg('Enviar e-mail deste Orçamento ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Try
      Lc_Imp := TimpModImpressao.create(nil);
      Lc_Imp.SalvaPDF := True;
      Lc_Imp.NomePDF := 'cotacao.pdf';
      Lc_Imp.CodigoPedido := Cotacao.Registro.codped;
      Lc_Imp.Pc_Imp_Orc_JatoLaser;
      Lc_Anexo        := TStringList.Create;
      Lc_Anexo.Add(GbPathExe + Lc_Imp.NomePDF);
      Lc_Destinatario := TStringList.Create;
      Pc_ListaEmailParaEnvio(E_Cd_Empresa.Text,['PRINCIPAL%','ORÇAMENTO'],Lc_Destinatario) ;
      if Length(Trim(E_email.Text)) > 0 then Lc_Destinatario.Add(' '+E_email.Text);
      if Lc_Destinatario.Count > 0 then
      begin
        TRy
          LcEnviaemail := TFr_envia_email.create(nil);
          with LcEnviaemail do
            Begin
              It_Tipo_Envio := 'S';
              It_Assunto := 'Orçamento Nº ' + Lb_Numero.Caption;
              It_Destino := Lc_Destinatario;
              It_Corpo   := Fc_GeraEmail_CotacaoComAnexo;
              It_Anexo   := lc_anexo;
              ShowModal;
            end;
        Finally
          FreeAndNil(LcEnviaemail);
        End;
      end
      else
      begin
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                       'e-mail não informado verifique.' + EOLN + EOLN,
                       ['OK'], [bEscape], mpErro);
      end;
    Finally
      cotacao.UpdateEnvio;
      FreeAndNil(Lc_Imp);
    End;
  end;
end;

procedure TFr_Cotacao.SB_EnviarClick(Sender: TObject);
var
  Lc_Escolha : Integer;
begin
  if not Fc_ValidasPrecoeParcelamento then exit;
  Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                'Deseja enviar para?',
                                [' IMPRESSORA ', ' E-MAIL ', ' WHATSAPP ', ' CANCELA '], [bNormal, bNormal,bNormal, bEscape], mpConfirmacao, clBtnFace));
  case Lc_Escolha of
    0:Pc_Chama_Impressora;
    1:Pc_Envia_Email_Com_Anexo;
    2:Pc_Envia_WhatsApp;
  end;
end;

procedure TFr_Cotacao.DBGrid2KeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if Shift = [] then
      case Key of
         VK_delete: Sb_Exc_ServicoClick(Sender);
      end;

end;

procedure TFr_Cotacao.Pc_ImagemBotao;
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
    CarregaImagemBotao(SB_Pesquisar,'PESQUISAR');

    CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    CarregaImagemBotao(Sb_Sair_1,'SAIR');

  END;
end;

procedure TFr_Cotacao.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_PermissaoBotao('Orçamento');
  Pc_FormataPanels;
end;

function TFr_Cotacao.InnerSQL: String;
begin
  Result := '';
  if (prmFone) and (not (prmEstado or prmCidade) )   then
  Begin
    Result := Result +
                 '  INNER JOIN TB_ENDERECO '+
                 '  ON (END_CODEMP = EMP_CODIGO) ';
  end
  else
  Begin
    if (prmEstado or prmCidade) then
      Result := Result +
                 '  INNER JOIN TB_ENDERECO '+
                 '  ON (END_CODEMP = EMP_CODIGO) '+
                 '  INNER JOIN TB_UF '+
                 '  ON (UFE_CODIGO = END_CODUFE) '+
                 '  INNER JOIN TB_CIDADE '+
                 '  ON (CDD_CODIGO = END_CODCDD)';
  end;

  if (prmCdProduto or prmDescProduto or PrmMarca)  then
  Begin
    Result := concat(
                  Result ,
                  ' INNER JOIN TB_ITENS_CTC I ',
                  ' on (i.ict_codctc = c.ctc_codigo) ',
                  ' INNER JOIN TB_PRODUTO P ',
                  ' ON (P.pro_codigo = I.ict_codvcl) ',
                  ' INNER JOIN tb_marca_produto M ',
                  ' ON (M.mrc_codigo = P.pro_codmrc) '
    );
  End;

end;

procedure TFr_Cotacao.ChBx_BuscaNomeClick(Sender: TObject);
begin
  if ChBx_BuscaNome.Checked then
    begin
    ChBx_BuscaFantasia.Checked := False;
    DBG_Pesquisa.Columns[2].FieldName := 'CTC_FANTASIA';
    end;
end;

procedure TFr_Cotacao.ChBx_BuscaFantasiaClick(Sender: TObject);
begin
  if ChBx_BuscaFantasia.Checked then
    begin
    ChBx_BuscaNome.Checked := False;
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_FANTASIA';
    end;
end;

procedure TFr_Cotacao.DBG_ProdutosDblClick(Sender: TObject);
begin
   if Sb_Alt_Produto.Enabled then
      Sb_Alt_ProdutoClick(Self);
end;

procedure TFr_Cotacao.DBGrid2DblClick(Sender: TObject);
begin
   if Sb_Alt_Servico.Enabled then
      Sb_Alt_ServicoClick(Self);
end;

procedure TFr_Cotacao.Pc_DinheiroFormaPgt;
begin
  if (Pos('DINHEIRO',Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text))>0) then
    BEGIN
    IF E_Nr_Parcelas.Visible = TRUE THEN
      BEGIN
      E_Nr_Parcelas.Text:='000';
      E_Nr_ParcelasExit(Self);
      E_Nr_Parcelas.Enabled:=FALSE;
      E_Prazo.Enabled:=FALSE;
      END
    ELSE
      BEGIN
      PC_Sel_PrazoPagto(It_bloqueio);
      END;
    END
  ELSE
    BEGIN
    PC_Sel_PrazoPagto(It_bloqueio);
    E_Nr_Parcelas.Enabled:=TRUE;
    E_Prazo.Enabled:=TRUE;
    END;
end;

procedure TFr_Cotacao.PC_Sel_PrazoPagto(Pc_Bloquea_Pagto: Boolean);
var
LC_TXT:string;
Begin
  lc_txt:='';
  qr_prazo_controlado.Active:=false;
  qr_prazo_controlado.SQL.Clear;
  If ((Pc_Bloquea_Pagto) AND (StrToIntDef(e_cd_empresa.Text,0)>0)) OR (Pos('DINHEIRO',Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text))>0)  then
  Begin
    lc_txt:= ' SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo '+
             ' WHERE                                     '+
             ' prz_prazo like :prz_prazo                 ';
    qr_prazo_controlado.SQL.Add(LC_TXT);
    qr_prazo_controlado.ParamByName('prz_prazo').AsString:='%'+'VISTA'+'%';
    qr_prazo_controlado.Active:=True;
    qr_prazo_controlado.FetchAll;
    DBLCB_Prazo.KeyValue:=qr_prazo_controlado.FIELDBYNAME('PRZ_PRAZO').AsString;
  end
  else
  If (NOT Pc_Bloquea_Pagto) AND (StrToIntDef(E_Cd_Empresa.Text,0)>0) then
  Begin
    lc_txt:= ' SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo '+
             ' where                                     '+
             ' prz_vl_minimo <= :prz_vl_minimo           ';
    qr_prazo_controlado.SQL.Add(LC_TXT);
    qr_prazo_controlado.ParamByName('prz_vl_minimo').AsCurrency :=  StrtoFloatdef(E_VL_Cotacao.Caption,0);
    qr_prazo_controlado.Active:=True;
    qr_prazo_controlado.FetchAll;
    DBLCB_Prazo.KeyValue := Cotacao.Registro.prazo;
  end;

end;



procedure TFr_Cotacao.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;


procedure TFr_Cotacao.ControleElementos(Ativo: Boolean);
begin
  Pnl_Fundo.Enabled := Ativo;
  Pnl_Botao.Enabled := Ativo;
  Pnl_TabelaPreco.Visible := not Ativo;
end;

function TFr_Cotacao.whereSQL: String;
Begin
  Result := '';
  Result := Result +
            'WHERE ((CTC_CODIGO IS NOT NULL) AND CST_CODIGO IS NULL) '+
            ' AND ((PED_FATURADO = ''C'') OR (PED_CODIGO IS NULL) or (PED_FATURADO = ''A'')) '+
            ' AND (CTC_STATUS <> ''A'') ';

  if not Fm_LME.chbx_Empresas.Checked then
    Result := Result + ' AND (CTC_CODMHA =:CTC_CODMHA) ';

  if (E_BuscaCotacao.Text = '') then
    prmCotacao := False
  else
    prmCotacao := True;

  if (E_BuscaCliente.Text = '') then
    prmCliente := False
  else
    prmCliente := True;

  if ChBx_Periodo.Checked then
    Result := Result + ' AND (CTC_DATA BETWEEN :CTC_DATAINI AND :CTC_DATAFIM) ';
  if prmCotacao then
    Result := Result + ' AND (CTC_NUMERO LIKE  :CTC_NUMERO) ';
  if prmCliente then
    Result := Result + ' AND (CTC_FANTASIA LIKE :CTC_FANTASIA) ';

  If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
    Result := Result + 'AND (  ctc_codvdo=:ctc_codvdo ) ';

  if prmemail then
    Result := Result + 'AND (  (ctc_email_e like :ctc_email_e) or (emp_email like :ctc_email_e) ) ';


  if prmEstado then
    Result := Result + ' AND UFE_SIGLA =:UFE_SIGLA ';
  if prmCidade then
    Result := Result + ' AND CDD_DESCRICAO LIKE :CDD_DESCRICAO ';

  if prmFone then
    Result := Result + ' AND ((END_FONE LIKE :END_FONE) OR (END_FAX LIKE :END_FONE) OR (END_CELULAR LIKE :END_FONE)) ';



  if (prmCdProduto ) then
  Begin
    IF (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S') then
    Begin
      If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
      Begin
        Result := Result + 'AND ( (PRO_CODIGO =:PRO_CODIGO) or (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
      end
      else
      begin
        Result := Result + 'AND ( (PRO_CODIGOFAB =:PRO_CODIGO) OR (PRO_CODIGOFOR =:PRO_CODIGO) ) ';
      end;
    end
    else
    Begin
      If StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0) >0 then
      Begin
        Result := Result + 'AND ( (PRO_CODIGO LIKE :PRO_CODIGO) or (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
      end
      else
      begin
        Result := Result + 'AND ( (PRO_CODIGOFAB LIKE :PRO_CODIGO) OR (PRO_CODIGOFOR LIKE :PRO_CODIGO) ) ';
      end;
    end;
  end;

  if prmDescProduto then
      Result := Result + ' AND ( (PRO_DESCRICAO LIKE :PRO_DESCRICAO) or (ICT_DESCRICAO LIKE :PRO_DESCRICAO ) )';

    if PrmMarca then
      Result := Result + ' AND ( PRO_CODMRC=:PRO_CODMRC ) ';

end;

procedure TFr_Cotacao.MnuCustodoPedidoClick(Sender: TObject);
Var
  Form : TRegCustoPedido;
begin
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;
  Form := TRegCustoPedido.Create(nil);
  Try
     Form.CodigoPedido := Cotacao.Registro.Codped;
    Form.ShowModal;
  Finally
    FreeAndNil(form);
  End;
end;

procedure TFr_Cotacao.tbs_cotacaoShow(Sender: TObject);
begin
  PG_Itens.ActivePageIndex := 0;
  popLucratividade.Visible := True;
  Pop_ConfigLocal.Visible := FAlse;
  Pop_ConfigGlobal.Visible := FAlse;

end;

procedure TFr_Cotacao.Sb_ParcelamentoClick(Sender: TObject);
Var
  Lc_Form : TFr_Parcelamento;
begin
  If (StrToFloatDef(E_VL_Cotacao.Caption,0) > 0) then
  Begin
    Try
      Lc_Form := TFr_Parcelamento.create(nil);
      Lc_Form.Top                     := Self.Top + 90 ;
      Lc_Form.Left                    := Self.Left + 331;
      Lc_Form.It_StrinPrazo           :=  E_Prazo.Text;
      Lc_Form.It_Cd_Cotacao           := Cotacao.Registro.codigo;
      Lc_Form.Pedido.Registro.Codigo  := Cotacao.Registro.codped;
      Lc_Form.ValorDuplicatas         := StrToFloatDef(E_VL_Cotacao.Caption,0);
      Lc_Form.E_Nr_PArcelas.Text      :=  IntToStr(StrToIntDef(E_Nr_Parcelas.Text,1));
      Lc_Form.It_Bloqueio             := It_bloqueio;
      Lc_Form.ShowModal;
      E_Nr_Parcelas.Text := StrZero(Lc_Form.It_Qt_Parcelas,3,0);
      E_Prazo.EditMask := '';
      E_Prazo.Text := TFr_Parcelamento(Lc_Form).It_StrinPrazo;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end
  else
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O pedido não pode ser zero para este acesso.'+EOLN+
                   'Defina o valor do pedido antes de Parcelar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Cotacao.E_Nr_ParcelasExit(Sender: TObject);
begin
   if StrToIntDef(E_Nr_Parcelas.Text, 0) > 0 then
   begin
      E_Prazo.Clear;
      E_Prazo.EditMask := Fc_MascaraPrazo(StrToInt(E_Nr_Parcelas.Text))
   end
   else
   begin
      E_Prazo.EditMask := '';
      E_Prazo.Text := Fc_MascaraPrazo(StrToInt(E_Nr_Parcelas.Text));
   end;
end;

procedure TFr_Cotacao.DBG_PesquisaTitleClick(Column: TColumn);
begin
   Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TFr_Cotacao.DBG_Pesquisa_ItensTitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa_Itens, Column);
end;

procedure TFr_Cotacao.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Pedido  := True;
    It_Enviar  := True;
    It_Visualizar := True;
    It_Email_cliente:= True;
    It_Email_tecnico:= True;
    It_Contas_pagar:= True;
  end
  else
    begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Pedido     := Fc_HabilitaPermissao(Pc_Menu,'PEDIDO','S');
    It_Enviar     := Fc_HabilitaPermissao(Pc_Menu,'ENVIAR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    It_Pedido := Fc_HabilitaPermissao(Pc_Menu,'PEDIDO','S');
    It_Email_cliente := Fc_HabilitaPermissao(Pc_Menu,'EMAIL CLIENTE','S');
    It_Email_tecnico := Fc_HabilitaPermissao(Pc_Menu,'EMAIL TECNICO','S');
    It_Contas_pagar := Fc_HabilitaPermissao(Pc_Menu,'CONTAS PAGAR','S');
    end;
    SB_Cadastrar.Enabled := It_Inserir;
end;

procedure TFr_Cotacao.Button1Click(Sender: TObject);
Var
  Lc_Aq_Margem : Real;
begin
  Lc_Aq_Margem := StrToFloatDef(E_Mrg_Lucro.Text,0);
  if (MensagemPadrao(TITULO_CONFIRMACAO,
     'Recalcular o orçamento com o Percentual ' + FloatToStr(Lc_Aq_Margem) + '%' + EOLN + EOLN ,
     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    Pc_Recalcula_Auto(Lc_Aq_Margem);
  end;
end;

procedure TFr_Cotacao.Qr_Itens_ProCalcFields(DataSet: TDataSet);
Var
  Lc_Vl : Real;
begin
  IF StrToFloatDef(Qr_Itens_Pro.FieldByName('PRO_DIVISOR').AsString,1) = 0 then
    Lc_Vl := 1
  else
    Lc_Vl :=  StrToFloatDef(Qr_Itens_Pro.FieldByName('PRO_DIVISOR').AsString,1);
  Lc_Vl := Qr_Itens_Pro.FieldByName('PRO_VL_CUSTO').AsCurrency * Lc_Vl;
  Lc_Vl := Qr_Itens_Pro.FieldByName('PRO_VL_CUSTO').AsCurrency * Qr_Itens_Pro.FieldByName('PRO_DIVISOR').AsInteger;

  IF Qr_Itens_Pro.FieldByName('ICT_VL_UNIT').AsCurrency = 0 THEN
   Qr_Itens_Pro.FieldByName('ICT_VL_UNIT').AsCurrency:=1;
  if Lc_Vl = 0  then
    Lc_Vl := 100
  else
    Lc_Vl := ((Qr_Itens_Pro.FieldByName('ICT_VL_UNIT').AsCurrency - Lc_Vl) /Lc_Vl)*100;
  Qr_Itens_Pro.FieldByName('ICT_MRG_LUCRO').AsCurrency   := StrToFloatDef(FloatToStrF(Lc_Vl,ffFixed,10,0),0);
end;

procedure TFr_Cotacao.PC_Sel_FormPagto(Pc_Bloquea_Pagto: Boolean);
Begin
  Fm_FormaPagto.Pc_Listar(3,Pc_Bloquea_Pagto,StrToIntDef(E_Cd_Empresa.Text,0));
  IF StrToIntDef(E_Cd_Empresa.Text,0) >0 THEN
  BEGIN
    if (Pc_Bloquea_Pagto)  then
    BEGIN
      E_Nr_Parcelas.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (not It_bloqueio);
      E_Prazo.Enabled         := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (not It_bloqueio);
      Sb_Parcelamento.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (not It_bloqueio);
    END
    else
    BEGIN
      E_Nr_Parcelas.Enabled := (NOT It_bloqueio);
      E_Prazo.Enabled := (NOT It_bloqueio);
      Sb_Parcelamento.Enabled:= (NOT It_bloqueio);
    end;
  END
  else
  BEgin
    E_Nr_Parcelas.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (not It_bloqueio);
    E_Prazo.Enabled         := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (not It_bloqueio);
    Sb_Parcelamento.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (not It_bloqueio);
  end;
end;

function TFr_Cotacao.Fc_ValidaGravacao: boolean;
Var
  Lc_Ano_Numero : String;
  Lc_Ano : String;
  Lc_Valor : Real;
  Lc_Aux:String;
begin
  Result:= true;
  if validaPedidoExiste then
  Begin
    Result:=false;
    exit;
  End;


  if Length(Cotacao.Registro.numero) > 0 then
  Begin
    Lc_Ano := IntToStr(Fc_Year(E_Data.Date));
    Lc_Ano_Numero := Copy(Cotacao.Registro.numero,Length(Cotacao.Registro.numero)-1,2);
    if  (Lc_Ano_Numero <> Copy(Lc_Ano,3,2)) then
      Cotacao.Registro.numero := '';
  end;

  if E_Cd_Empresa.CanFocus then
    If E_Data.CanFocus then  E_Data.SetFocus;
  if Cb_Empresa.CanFocus then
    If E_Data.CanFocus then  E_Data.SetFocus;

  Lc_Valor := StrToFloatDef(E_VL_Produto.Caption,0) + StrToFloatDef(E_Vl_Servico.Caption,0);
  If DBLCB_Prazo.Visible then
    Lc_Aux := Copy(dBLCB_Prazo.Text,1,3)
  else
    Lc_Aux := Copy(E_Nr_Parcelas.Text,1,3);

  if not Fc_ValidaDesconto(Lc_Valor,StrToFloatDef(E_VL_Desconto.Text,0),Lc_Aux) then
  Begin
    E_Aq_Desconto.Text := '0,00';
    E_Aq_DescontoExit(Self);
    Result:=false;
    exit;
  end;

  if trim(Cb_Empresa.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Nome do Cliente não informado. ' +EOLN +
                   ' Preencha o Cliente.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    if Cb_Empresa.CanFocus then Cb_Empresa.SetFocus;
    exit;
  end;

  if trim(Fm_VendedorCotacao.DBLCB_Vendedor.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Vendedor não informado. ' +EOLN +
                   ' Escolha o vendedor e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    if Fm_VendedorCotacao.DBLCB_Vendedor.CanFocus then Fm_VendedorCotacao.DBLCB_Vendedor.SetFocus;
    exit;
  end;

  if trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Forma de Pagamento não informado. ' +EOLN +
                   ' Escolha a forma de pagamento e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    if Fm_FormaPagto.DBLCB_FormaPagto.CanFocus then Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    exit;
  end;

  if E_Nr_Parcelas.Visible = true then
  BEGIN
    if trim(E_Nr_Parcelas.Text) = '' then
    begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' Número de Parcelas não informado. ' +EOLN +
                     ' Escolha o número de parcela tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpErro);
      Result:=false;
      if E_Nr_Parcelas.CanFocus then E_Nr_Parcelas.SetFocus;
      exit;
    end;
  END
  else
  BEGIN
    if trim(DBLCB_Prazo.Text) = '' then
    begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' Número de Parcelas não informado. ' +EOLN +
                     ' Escolha o número de parcela tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpErro);
      Result:=false;
      if DBLCB_Prazo.CanFocus then DBLCB_Prazo.SetFocus;
      exit;
    END;
  END;

  if Length(E_email.Text)>0 then
  Begin
    if not Fc_ValidaEmail(E_email.Text) then
    Begin
      if Fm_FormaPagto.DBLCB_FormaPagto.CanFocus then Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
      Result:=false;
      exit;
    end;
  end;
  //Não bloqueia a gravação  - Apenas Alerta
  if ( Fc_Tb_Geral('L','ORC_G_SO_ALERTA_ESTOQUE','S') = 'S') then
  Begin
    if VerificaProdutoSemEstoque then
    Begin
      //Apenas mensagens
    end;
  End;

end;

procedure TFr_Cotacao.Pc_Limpa_campos;
begin
  cOTACAO.clear;
  Fm_VendedorCotacao.ListaVendedor;
  Lb_Numero.Caption := '';
  E_Data.Date := Date;
  Cb_Empresa.ItemIndex := -1;
  cb_Empresa.Text := '';
  E_Cd_Empresa.Text := '';
  E_Cd_EmpresaExit(Self);
  if (Gb_Cd_Vendedor > 0) then
    Fm_VendedorCotacao.DBLCB_Vendedor.KeyValue := Gb_Cd_Vendedor
  else
    Fm_VendedorCotacao.DBLCB_Vendedor.KeyValue := 0;
  E_Contato.Clear;
  E_email.Clear;
  Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := Fc_PegaParteFormaPgto('DINHEIRO');
  E_Prazo.EditMask := '';
  E_Prazo.Text := 'A VISTA';
  E_Nr_Parcelas.Text := '000';
  E_Nr_ParcelasExit(Self);

  E_VL_Frete.Text := '0,00';
  E_Vl_Adicional.Text := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  E_obs.Lines.Clear;
  It_Tipo := '0';
  it_tipo_Atual := '0';
  Cotacao.Registro.Status := 'N';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
end;

procedure TFr_Cotacao.Pc_Limpa_campos_Cliente;
begin
  Cotacao.Registro.Contato := '';
  //Fm_VendedorCotacao.Dblcb_Vendedor.KeyValue := Null;
  E_Contato.Clear;
  E_email.Clear;
  //Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := null;
end;

procedure TFr_Cotacao.Pc_Limpa_campo_buscar;
begin
  E_BuscaCliente.Text:='';
  E_BuscaCotacao.Text:='';
end;

procedure TFr_Cotacao.DBLCB_FormaPagtoExit(Sender: TObject);
begin
  Pc_DinheiroFormaPgt;
  if DBLCB_Prazo.CanFocus then DBLCB_Prazo.SetFocus;
end;

procedure TFr_Cotacao.Sb_Ins_ServicoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Servico;
begin
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;
  //Cria O Formulario
  try
    Lc_Form := TFr_Itens_Servico.Create(nil);
    Lc_Form.It_Pedido_Vda           := False;
    Lc_Form.It_Cotacao_Vda          := True;
    Lc_Form.It_Cotacao_Cmv          := False;
    Lc_Form.it_Cd_Empresa           := Cotacao.Registro.Codemp;
    Lc_Form.It_Cd_Cotacao           := Cotacao.Registro.Codigo;
    Lc_Form.It_Cd_Pedido            := Cotacao.Registro.Codped;
    Lc_Form.Pc_StateChange(2);
    Lc_Form.It_MultiplicadorPreco   := It_MultiplicadorPreco;
    Lc_Form.It_Cd_Pedido            := Cotacao.Registro.Codped;
    Lc_Form.It_Cd_Cotacao           := Cotacao.Registro.Codigo;
    Lc_Form.It_Aliq_Comissao        := It_Aliq_Comissao;
    Lc_Form.E_Qt_Servico.Text       := '1';
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Pc_AtualizaStatusInterface;
  end;
end;

Function TFr_Cotacao.Fc_DefineTabela():String;
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

function TFr_Cotacao.Fc_DefineTipoPessoa: String;
begin
  {Tipo de Combinação
      JR - Juridica Revenda
      JC - Juridica Consumidor
      FC - Consumidor
  }
  if ( cliente.Empresa.Registro.ConsumidorFinal = 'S' ) then
    Result := 'C'
  else
    Result := 'R'
end;

procedure TFr_Cotacao.Sb_Alt_ServicoClick(Sender: TObject);
Var
  Lc_Form : TFr_Itens_Servico;
begin
  try
    //Cria O Formulario
    Lc_Form := TFr_Itens_Servico.Create(nil);
    Lc_Form.It_Pedido_Vda      := False;
    Lc_Form.It_Cotacao_Vda     := True;
    Lc_Form.It_Cotacao_Cmv     := False;
    Lc_Form.Pc_StateChange(3);
    Lc_Form.It_MultiplicadorPreco := It_MultiplicadorPreco;
    Lc_Form.It_Inserir         := True;
    Lc_Form.It_Cd_Pedido       := Cotacao.Registro.Codped;
    Lc_Form.It_Cd_Cotacao      := Cotacao.Registro.Codigo;
    Lc_Form.It_Cd_Itens        := Qr_Itens_Srv.FieldByName('ICT_CODIGO').AsInteger;
    Lc_Form.It_Cd_Servico      := Qr_Itens_Srv.FieldByName('ICT_CODVCL').AsInteger;
    Lc_Form.E_Cd_Servico.Text  := Qr_Itens_Srv.FieldByName('ICT_CODVCL').AsString;
    Lc_Form.E_Descricao.Text   := Qr_Itens_Srv.FieldByName('ICT_DESCRICAO').AsString;
    Lc_Form.E_Vl_Unitario.Text := FloatToStrF(Qr_Itens_Srv.FieldByName('ICT_VL_UNIT').AsCurrency, ffFixed, 10, 2);
    Lc_Form.E_Qt_Servico.Text  := FloatToStrF(Qr_Itens_Srv.FieldByName('ICT_QTDE').AsFloat, ffFixed, 10, 0);
    Lc_Form.E_Aq_Com.Text      := FloatToStrF(Qr_Itens_srv.FieldByName('ICT_AQ_COM').AsFloat, ffFixed, 10, 2);
    Lc_Form.E_Aq_Desconto.Text := FloatToStrF(Qr_Itens_Srv.FieldByName('ICT_AQ_DESC').AsFloat, ffFixed, 10, 2);
    Lc_Form.E_VL_Desconto.Text := FloatToStrF(Qr_Itens_Srv.FieldByName('ICT_VL_DESC').AsCurrency, ffFixed, 10, 2);
    Lc_Form.It_Aliq_Comissao   := It_Aliq_Comissao;
    Lc_Form.Pc_Totalizador;
    Lc_Form.ShowModal;
  finally
    FreeandNil(Lc_Form);
    Pc_AtualizaStatusInterface;
  end;
end;

procedure TFr_Cotacao.Sb_Exc_ServicoClick(Sender: TObject);
begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
      'Excluir o item ' + Qr_Itens_Srv.FieldByName('ICT_DESCRICAO').AsString + ' desta Cotação.' + EOLN + EOLN +
      'Confirmar a exclusão ?',
      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao2) then
      exit;
   try
      Pc_ApagaItensCotacao(Qr_Itens_Srv.FieldByName('ICT_CODIGO').AsInteger);
      Pc_AbrirItensServico;
      Pc_EstadoEdicaoOrdem;
      Pc_AtualizaCampos;
      Pc_Totalizador;
      PC_Sel_PrazoPagto(It_bloqueio);
      Pc_AtualizaStatusInterface();
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  END;
end;




procedure TFr_Cotacao.Sb_ServicoClick(Sender: TObject);
var
   Lc_Codigo: Integer;
   Lc_Form : TFr_VehicleSo;
begin
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;
  Pc_AbreListaCliente('EMP_NOME');
  Pc_GeraNumero;
  Lc_Form := TFr_VehicleSo.Create(nil);
  TRy
    with Lc_Form do
    begin
      with OrdemServico do
      Begin
        Registro.CodigoEstabelecimento := Gb_Codmha;
        Registro.CodigoCotacao := Cotacao.Registro.Codigo;
        Registro.CodigoPedido := Cotacao.Registro.Codped;
        with Vehicle do
        Begin
          Registro.CodigoEmpresa := Cotacao.Registro.Codemp;
        End;
      End;
      ShowModal;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

Function TFr_Cotacao.Fc_ValidaInsereTecnicos():Boolean;
Begin
  Result := True;
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;


  if Qr_Itens_Srv.RecordCount = 0 then
    Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não há serviço registrado para incluir técnico.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    exit;
    end;
end;

procedure TFr_Cotacao.Sb_TecnicoClick(Sender: TObject);
Var
  Lc_Form : TFr_Tecnicos;
begin
  if Fc_ValidaInsereTecnicos then
  Begin
    Try
      Lc_Form := TFr_Tecnicos.Create(nil);
      Lc_Form.It_Cd_Pedido :=  Cotacao.Registro.Codped;
      Lc_Form.It_Cd_Item := Qr_Itens_Srv.FieldByName('ICT_CODIGO').AsInteger;
      Lc_Form.It_Tp_Vinculo := 'C';
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;

  end;
end;

procedure TFr_Cotacao.ChBx_NomeClick(Sender: TObject);
begin
  if  TCheckBox(sender).Checked then
    Cliente.PreencheComboBox('EMP_NOME',Cb_Empresa)
  else
    Cliente.PreencheComboBox('EMP_FANTASIA',Cb_Empresa);
end;

procedure TFr_Cotacao.ChBx_FantasiaClick(Sender: TObject);
begin
  if  TCheckBox(sender).Checked then
    Cliente.PreencheComboBox('EMP_FANTASIA',Cb_Empresa)
  else
    Cliente.PreencheComboBox('EMP_NOME',Cb_Empresa)

end;

procedure TFr_Cotacao.Pc_ChamaCadastroCliente(Pc_cd_Cliente:String);
Var
  Lc_Form : TFr_Cliente;
begin
  IF StrToIntDef(Pc_cd_Cliente,0) > 0 then
  Begin
    Try
      Lc_Form := TFr_Cliente.Create(nil);
      Lc_Form.Empresa.Registro.Codigo := StrToIntDef(Pc_cd_Cliente,0);
      Lc_Form.ShowModal;
      Pc_AbreListaCliente('EMP_NOME');
      Cotacao.Registro.Codemp := Lc_Form.CodigoEmpresa;
      E_Cd_Empresa.text := IntToStr(Lc_Form.CodigoEmpresa);
      Fc_PosicionaCliente('EMP_CODIGO',E_Cd_Empresa.text);
      Cb_Empresa.Text := Lc_Form.NomeRazao;
      if Cb_Empresa.CanFocus then Cb_Empresa.SetFocus;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Cotacao.Pc_PreencheDadosCliente;
var
   Lc_Flag: Boolean;
Begin
  Cotacao.Registro.Codemp := Cliente.Empresa.Registro.Codigo;
  It_bloqueio := Fc_VerificaBloqueioCliente(Cliente.Empresa.Registro.Codigo);
  Pc_DefineMultiplicadorPreco(Cotacao.Registro.Codemp);
  E_Cd_Empresa.Text := Cliente.Empresa.Registro.Codigo.ToString();
  if ChBx_Nome.Checked then
    Cb_Empresa.Text := Cliente.Empresa.Registro.NomeRazaoSocial
  else
    Cb_Empresa.Text := Cliente.Empresa.Registro.ApelidoFantasia;
  Cotacao.Registro.EmailE := Copy(Cliente.Empresa.Registro.Email ,1,60);
  e_Email.Text := Cotacao.Registro.EmailE;

  PC_Sel_FormPagto(It_bloqueio);
  PC_Sel_PrazoPagto(It_bloqueio);
  Cliente.Empresa.Endereco.Registro.CodigoEmpresa  := Cliente.Empresa.Registro.Codigo;
  Cliente.Empresa.Endereco.getByEmpresa;
  {desativado em 15/02/2017
  //flag verifica cadastro incompleto do cliente
  Lc_Flag := (FieldbyName('EMP_CODVDOR').AsInteger = 0) or (Length(DM.Qr_Endereco.FieldByname('END_CEP').AsString) = 0);
  if Lc_Flag then //inicio verifica cadastro
  begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Este Cliente está com o cadastro imcompleto.' + EOLN + EOLN +
                       'Visualizar o Cadastro agora?',
                       [SIM, NAO], [bNormal, bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      Pc_ChamaCadastroCliente(E_Cd_Empresa.Text);
      if Gb_Cd_Vendedor = 0 then
      Begin
        if not DM.Qr_Empresas.Active then DM.Qr_Empresas.Active := True;
        DM.Qr_Empresas.First;
        TB_Cotacao.FieldByName('CTC_CODVDO').AsInteger := DM.Qr_Empresas.FieldByname('EMP_CODVDOR').AsInteger;
      End;
      if Fm_VendedorCotacao.DBLCB_Vendedor.CanFocus then Fm_VendedorCotacao.DBLCB_Vendedor.SetFocus;
    end
    else
    begin
      if Gb_Cd_Vendedor = 0 then
        TB_Cotacao.FieldByName('CTC_CODVDO').AsInteger := Fm_VendedorCotacao.Qr_ListaVendedor.FieldByname('CLB_CODIGO').AsInteger;
      if Fm_VendedorCotacao.DBLCB_Vendedor.CanFocus then Fm_VendedorCotacao.DBLCB_Vendedor.SetFocus;
    end;
  end;
  }
  Cotacao.Registro.Contato := '';

  if Cliente.Empresa.Endereco.Registro.Fone <> '' then
    Cotacao.Registro.Contato := fc_MascaraFone(Cliente.Empresa.Endereco.Registro.Fone)
  else
  if Cliente.Empresa.Endereco.Registro.Celular <> '' then
    Cotacao.Registro.Contato := fc_MascaraFone(Cliente.Empresa.Endereco.Registro.Celular);
  if (Cotacao.Registro.Contato <> '') then
    E_Contato.Text := Cotacao.Registro.Contato;
  Pc_Aniversario(DateToStr(Cliente.Empresa.Registro.DataFundacao));
end;

procedure TFr_Cotacao.Pc_PosicionaCliente(Pc_Campo,Pc_Valor:String);
Begin
  Cliente.getByFieldName('TB_EMPRESA',Pc_Campo,Pc_Valor);
  Pc_Limpa_campos_Cliente;
  if Cliente.exist then
  Begin
    Pc_PreencheDadosCliente;
  end
  else
  Begin
    E_Cd_Empresa.Text := '0';
    Cb_Empresa.ItemIndex := -1;
    Pc_DefineMultiplicadorPreco(0);
    PC_Sel_FormPagto(It_bloqueio);
    PC_Sel_PrazoPagto(It_bloqueio);
  end;
end;

procedure TFr_Cotacao.Cb_EmpresaExit(Sender: TObject);
begin
  if ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) and (Trim(Cb_Empresa.Text) <>'')then
  begin
    if (StrToIntDef(E_Cd_Empresa.Text,0) = 0) then
    Begin
      if (ChBx_Nome.Checked) then
        Pc_PosicionaCliente('EMP_NOME',Cb_Empresa.Text)
      else
        Pc_PosicionaCliente('EMP_FANTASIA',Cb_Empresa.Text);
    end
    else
    Begin
      Pc_PosicionaCliente('EMP_CODIGO',E_Cd_Empresa.Text);
    end;
  end;
end;

procedure TFr_Cotacao.CadastrodoProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    TRY
      Lc_Form := TFr_Produtos.Create(NIL);
      Lc_Form.Produto.Registro.Codigo := Qr_Itens_Pro.FieldByName('ICT_CODVCL').AsInteger;
      Lc_Form.ShowModal;
    FINALLY
      FreeAndNil( Lc_Form );
    END;

  end;
end;

procedure TFr_Cotacao.MenuItem1Click(Sender: TObject);
Var
  Lc_Form : TRegService;
begin
  if Fc_VerificaPermissao('Fr_Servico','Cadastro de Serviços','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TRegService.Create(nil);
    Try
      Lc_Form.CodigoRegistro := Qr_Itens_Srv.FieldByName('ICT_CODVCL').AsInteger;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Cotacao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O orçamento está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes de sair da tela.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end
  else
  Begin
    cotacao.using('L');
  end;
end;

procedure TFr_Cotacao.FormCreate(Sender: TObject);
begin
  Pg_Busca.ActivePage := tbs_busca_cotacao;
  cotacao := TControllerCotacao.create(Self);
  cotacao.clear;
  Pedido := TControllerPedido.create(Self);
  Pedido.clear;
  Cliente := TControllerCliente.create(Self);
  Base := TControllerBase.create(Self);
end;

procedure TFr_Cotacao.popLucratividadeClick(Sender: TObject);
Var
  Lc_Form : TRL_ReportLucratividadeOrcamento;
  Lc_Param : TParamLucratividade;
begin
  if Pg_Cotacao.ActivePageIndex = 0 then
  Begin
    If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) then
      Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Grave o orçamento antes de continuar. '+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      exit;
      end;
  end;

  if Pg_Cotacao.ActivePageIndex = 1 then
  Begin
    If (Qr_Pesquisa.RecordCount = 0) then
      Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não há registro para ser visualizado.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      exit;
      end;
  end;

  if Fc_VerificaPermissao('Fr_Cotacao','Orçamento','LUCRATIVIDADE',GB_Cd_Usuario,'S') then
  Begin
    Try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      PC_GeraNumero;
      Lc_Form := TRL_ReportLucratividadeOrcamento.create(nil);
      Lc_Param := TParamLucratividade.Create;
      Lc_Param.Periodo := False;
      Lc_Param.DataInicial := Date;
      Lc_Param.DataFinal := Date;
      if Trim(E_Cd_Empresa.Text) <> '' then
      Lc_Param.CodigoCliente := StrtoIntDef(E_Cd_Empresa.text,0);

      Lc_Param.NomeCliente := '';
      Lc_Param.CodigoTransportadora := 0;
      Lc_Param.CodigoEstabelecimento := GB_codmha;

      Lc_Param.VendedorCliente     := 0;
      Lc_Param.VendedorPedido      := 0;
      Lc_Param.NegociosEspecificos := '';
      if Pg_Cotacao.ActivePageIndex =  0 then
        Lc_Param.NumeroDocumento     := Cotacao.Registro.Numero
      else
        if Qr_Pesquisa.RecordCount > 0 then        
        Lc_Param.NumeroDocumento     := Qr_Pesquisa.FieldByName('CTC_NUMERO').AsString;
      //Parametros para Produtos
      Lc_Param.CodigoGrupo         := 0;
      Lc_Param.CodigoSubGrupo      := 0;
      Lc_Param.CodigoMarca         := 0;
      Lc_Param.CodigoProduto       := 0;
      Lc_Param.DescricaoProduto    := '';

      Lc_Form.Parametros := Lc_Param;
      Lc_Form.Qrpt.ReportTitle := 'LUCRATIVIDADE ORÇAMENTO';
      Lc_Form.Qrpt.Preview;
    Finally
      FreeAndNil(Lc_Form);
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    End;
  end;
end;

procedure TFr_Cotacao.E_Vl_AdicionalExit(Sender: TObject);
begin
   Pc_Totalizador;
end;

procedure TFr_Cotacao.Action1Execute(Sender: TObject);
Var
  Lc_Form :TFr_Liberacao;
begin
  try
    Lc_Form :=  TFr_Liberacao.Create(nil);
    Lc_Form.Liberado := False;
    Lc_Form.It_Interface := 'Fr_Cotacao';
    Lc_Form.It_Nome_Menu := 'Orçamento';
    Lc_Form.It_Privilegio := 'AUTORIZAR';
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Cotacao.Sb_Pesq_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    Cotacao.Registro.Codemp := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
    E_Cd_Empresa.Text := Cotacao.Registro.Codemp.toString;
    Cb_Empresa.Text := Lc_Retorno.It_Dados[1,1];
    if Cb_Empresa.CanFocus then Cb_Empresa.SetFocus;
  end;
end;

procedure TFr_Cotacao.Btn_Ok_LocalClick(Sender: TObject);
begin
  Pc_Grava_Config_Global;
  Pg_Cotacao.ActivePage := tbs_pesquisa;
end;

procedure TFr_Cotacao.Btn_Cn_LocalClick(Sender: TObject);
begin
  Pg_Cotacao.ActivePage := tbs_pesquisa;
end;

procedure TFr_Cotacao.AlteraTabeladePreoClick(Sender: TObject);
begin
  if not EmNavegacao then
  Begin
    EscolheTabela;
  end;
end;

procedure TFr_Cotacao.Btn_Ap_LocalClick(Sender: TObject);
begin
  Pc_Grava_Config_Global;
end;

procedure TFr_Cotacao.Button2Click(Sender: TObject);
begin
  Pc_Grava_Config_Local;
  Pg_Cotacao.ActivePage := tbs_pesquisa;
end;

procedure TFr_Cotacao.Button3Click(Sender: TObject);
begin
  Pg_Cotacao.ActivePage := tbs_pesquisa;
end;

procedure TFr_Cotacao.Button4Click(Sender: TObject);
begin
  Pc_Grava_Config_Local;
end;

procedure TFr_Cotacao.Pop_ConfigLocalClick(Sender: TObject);
begin
  Pg_Cotacao.ActivePage := tbs_Config_Local;
  Pc_Abre_Config_Local;
end;

function TFr_Cotacao.PreGeracaoPEdido(Fc_cd_Pedido: Integer): Integer;
begin
  //Excluir o pedido para evitar reuso quando o pedido é cancelado e volta a ser um
  If (Fc_cd_Pedido > 0) then
  Begin
    Pedido.Registro.Codigo := Fc_cd_Pedido;
    if Pedido.InconsistenciaORcamento then
      Fc_cd_Pedido := 0
  End;
  Pedido.Clear;
  Pedido.Registro.Codigo := Fc_cd_Pedido;
  Pedido.Registro.Tipo := 1;
  Pedido.Registro.Usuario := GB_Cd_Usuario;
  Pedido.Registro.Data := E_Data.DateTime;
  if StrToIntDef(E_Cd_Empresa.Text,0) > 0 then
  Begin
   Pedido.Registro.Empresa := StrToIntDef(E_Cd_Empresa.Text,0);
   Pedido.Endereco.REgistro.CodigoEmpresa := Pedido.Registro.Empresa;
   Pedido.Endereco.getByEmpresa;
   Pedido.Registro.Endereco := Pedido.Endereco.Registro.Codigo;
  End
  else
  Begin
    Pedido.Registro.Empresa := Gb_CodMha;
    Pedido.Endereco.REgistro.CodigoEmpresa := Gb_CodMha;
    Pedido.Endereco.getByEmpresa;
    Pedido.Registro.Endereco := Pedido.Endereco.Registro.Codigo;
  End;

  Pedido.Registro.FormaPagto := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
  Pedido.Registro.Faturado := 'C';
  Pedido.salva;
  //Atualiza o codigo do Pedido no orçamento
  Cotacao.Registro.Codped := Pedido.Registro.Codigo;
  Cotacao.update;
  REsult := Pedido.Registro.Codigo;
end;

procedure TFr_Cotacao.Pop_ConfigGlobalClick(Sender: TObject);
begin
  if Gb_Nivel = 1 then
  Begin
    Pg_Cotacao.ActivePage := tbs_Config_Global;
    Pc_Abre_Config_Global;
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'As configurações Globais são permitidas apenas' + EOLN +
                   'para usuários administradores pois influenciam em todo o sistema.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_Cotacao.chbx_dias_OrcClick(Sender: TObject);
begin
  if not chbx_dias_Orc.Checked then
  Begin
    E_dias_Orc.Clear;
    E_dias_Orc.Enabled := False;
  end
  else
  Begin
    E_dias_Orc.Enabled := True;
  end;
end;

end.







