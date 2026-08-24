UNIT UN_Receber_Multipla;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.Math, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient, Datasnap.Provider, Un_Fm_FormaPagto, ACBrBase, ACBrCMC7, Vcl.Menus, Vcl.DBCtrls, Vcl.ComCtrls, QEdit_Setes, ACBrDANFCeFortesFr, ACBrBoleto, ControllerCartao, ControllerBase, Un_Fm_ListaColaboradores, STDataSet, ControllerBoleto, ControllerCheque, ControllerFinanceiro, ControllerComissao;


type
  TSortByFieldOption = (ForceAscending, ForceDescending);
  TSortByFieldOptions = set of TSortByFieldOption;
  TFr_Receber_Multipla = class(TForm)
    Pg_Controle: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label4: TLabel;
    E_Busca_Empresa: TEdit;
    E_BuscaNota: TEdit;
    TabSheet4: TTabSheet;
    Panel3: TPanel;
    Label35: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    E_VLT_Cheque: TEdit_Setes;
    E_Banco: TEdit_Setes;
    E_Agencia: TEdit;
    E_NumChq: TEdit_Setes;
    E_VL_Cheque: TEdit_Setes;
    E_Emitente: TEdit;
    StrGrd_Cheque: TStringGrid;
    tbs_boleto: TTabSheet;
    Panel4: TPanel;
    Pnl_Duplicatas: TPanel;
    Pnl_Total: TPanel;
    Label23: TLabel;
    Label14: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label24: TLabel;
    Lb_Saldo_Parcial: TLabel;
    E_Vl_Saldo: TLabel;
    E_VL_Pagar: TEdit_Setes;
    E_VL_Juros: TEdit_Setes;
    E_VL_Mora: TEdit_Setes;
    E_VL_Desconto: TEdit_Setes;
    E_VL_Pago: TEdit_Setes;
    Panel1: TPanel;
    SB_Sair_0: TSpeedButton;
    Sb_Baixar: TSpeedButton;
    SB_Boleto: TSpeedButton;
    Sb_Cheque: TSpeedButton;
    Sb_Destinar: TSpeedButton;
    Qr_Parcelas: TSTQuery;
    Ds_Parcelas: TDataSource;
    Qr_Boleto: TSTQuery;
    Ds_Qr_Boleto: TDataSource;
    Qr_Acao: TSTQuery;
    Label3: TLabel;
    E_BuscaFinanceiro: TEdit;
    Ds_ContaBancaria: TDataSource;
    Qr_Cheques: TSTQuery;
    Ds_Cheque: TDataSource;
    PpM_Duplicata: TPopupMenu;
    TabSheet2: TTabSheet;
    pnl_cartao: TPanel;
    Ds_DM_Cartao: TDataSource;
    Sb_Cartao: TSpeedButton;
    Label32: TLabel;
    pnl_cartao_botton: TPanel;
    Sb_GravarCartao: TSpeedButton;
    Sb_ExcluiCartao: TSpeedButton;
    Sb_InsereCartao: TSpeedButton;
    Sb_AlteraCartao: TSpeedButton;
    Sb_CancelarCartao: TSpeedButton;
    Sb_VoltarCartao: TSpeedButton;
    Panel7: TPanel;
    Label33: TLabel;
    Label34: TLabel;
    Panel8: TPanel;
    RetirarDestinao1: TMenuItem;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Sb_Negociar: TSpeedButton;
    E_DataCheque: TDateTimePicker;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Observaes1: TMenuItem;
    ChBx_Periodo: TCheckBox;
    Sb_GravaBoleto: TSpeedButton;
    Sb_ExcluiBoleto: TSpeedButton;
    Sb_InsereBoleto: TSpeedButton;
    Sb_AlteraBoleto: TSpeedButton;
    Sb_CancelaBoleto: TSpeedButton;
    Sb_BuscaBoleto: TSpeedButton;
    Sb_VoltaBoleto: TSpeedButton;
    Sb_Imprimir: TSpeedButton;
    Qr_Empresa: TSTQuery;
    E_Busca_Cd_Empresa: TEdit;
    L_CodigoCliente: TLabel;
    E_BuscaPedido: TEdit_Setes;
    E_Dt_Pagto: TDateTimePicker;
    Sb_Resumo: TSpeedButton;
    Pg_Observacao: TPageControl;
    TabSheet5: TTabSheet;
    Panel9: TPanel;
    E_Vl_Receber: TLabel;
    Label28: TLabel;
    E_Vl_Cred_Ceder: TLabel;
    Label13: TLabel;
    Label37: TLabel;
    E_Vl_Total_Receber: TLabel;
    Lb_Titulo_totalizador: TLabel;
    cheque: TACBrCMC7;
    Sb_GravaCheque: TSpeedButton;
    Sb_ExcluiCheque: TSpeedButton;
    Sb_InsereCheque: TSpeedButton;
    Sb_AlteraCheque: TSpeedButton;
    Sb_VoltaCheque: TSpeedButton;
    Sb_CancelaCheque: TSpeedButton;
    Sb_leitor: TSpeedButton;
    grb_busca_boleto: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    E_BuscaBoleto: TEdit;
    E_Busca_Boleto_Empresa: TEdit;
    E_Dt_Ini_Bol: TDateTimePicker;
    E_Dt_Fim_Bol: TDateTimePicker;
    ChBx_Periodo_b: TCheckBox;
    DBG_Boleto: TDBGrid;
    E_ContaCorrente: TEdit;
    Label9: TLabel;
    AplicarPlanoContas1: TMenuItem;
    Pnl_Boleto: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label8: TLabel;
    E_BDesconto: TEdit;
    E_NumBoleto: TEdit;
    E_Vl_Tarifa: TEdit;
    RG_Descontada: TRadioGroup;
    Label17: TLabel;
    Sb_BoletoEletronico: TSpeedButton;
    E_Blt_Vencimento: TDateTimePicker;
    Label27: TLabel;
    DBLCB_CarteiraCobranca: TDBLookupComboBox;
    Sb_BoletoPDF: TSpeedButton;
    Sb_ImprimirCartao: TSpeedButton;
    Cb_Situacao: TComboBox;
    Label36: TLabel;
    InativarInativar1: TMenuItem;
    Label38: TLabel;
    E_BuscaVl_Parcela: TEdit_Setes;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Sb_Pesq_Empresa: TSpeedButton;
    Fm_TipoCobranca: TFm_FormaPagto;
    Fm_TipoRecebimento: TFm_FormaPagto;
    VisualizarPedido1: TMenuItem;
    Cb_TipoData: TComboBox;
    Label2: TLabel;
    Dbg_Parcela: TDBGrid;
    Panel10: TPanel;
    SB_Add_Tudo: TSpeedButton;
    SB_Adicionar: TSpeedButton;
    SB_Retirar: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    Sb_Duplicata: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Buscar: TSpeedButton;
    sb_RECIBO: TSpeedButton;
    cds_Parcelas: TClientDataSet;
    cds_duplicatas: TClientDataSet;
    ds_duplicatas: TDataSource;
    Dbg_Duplicatas: TDBGrid;
    cds_ParcelasFIN_CODIGO: TIntegerField;
    cds_ParcelasNFL_NUMERO: TWideStringField;
    cds_ParcelasNFL_MODELO: TWideStringField;
    cds_ParcelasPED_NUMERO: TIntegerField;
    cds_ParcelasFIN_NUMERO: TWideStringField;
    cds_ParcelasFIN_DT_VENCIMENTO: TDateField;
    cds_ParcelasFIN_NR_PARCELA: TIntegerField;
    cds_ParcelasFIN_CODEMP: TIntegerField;
    cds_ParcelasEMP_FANTASIA: TWideStringField;
    cds_ParcelasEMP_NOME: TWideStringField;
    cds_ParcelasFIN_VL_PARCELA: TBCDField;
    cds_ParcelasFIN_BAIXA: TWideStringField;
    cds_ParcelasFIN_SITUACAO: TWideStringField;
    cds_ParcelasFIN_VL_PAGO: TBCDField;
    cds_ParcelasFIN_CODQTC: TIntegerField;
    cds_ParcelasFIN_CODFPG: TIntegerField;
    cds_ParcelasPED_CODIGO: TIntegerField;
    cds_ParcelasNFL_CODIGO: TIntegerField;
    cds_ParcelasFIN_TIPO: TWideStringField;
    cds_ParcelasFIN_DT_PAGTO: TDateField;
    cds_ParcelasFIN_OPERACAO: TWideStringField;
    cds_ParcelasFIN_ETAPA: TWideStringField;
    cds_ParcelasFIN_CODMHA: TIntegerField;
    cds_ParcelasFIN_CODCHQ: TIntegerField;
    cds_ParcelasPLC_CODIGO: TIntegerField;
    cds_ParcelasPLC_DESCRICAO: TWideStringField;
    cds_ParcelasFIN_DT_REPROGRAMADA: TDateField;
    cds_duplicatasFIN_CODIGO: TIntegerField;
    cds_duplicatasNFL_NUMERO: TWideStringField;
    cds_duplicatasNFL_MODELO: TWideStringField;
    cds_duplicatasPED_NUMERO: TIntegerField;
    cds_duplicatasFIN_NUMERO: TWideStringField;
    cds_duplicatasFIN_DT_VENCIMENTO: TDateField;
    cds_duplicatasFIN_NR_PARCELA: TIntegerField;
    cds_duplicatasFIN_CODEMP: TIntegerField;
    cds_duplicatasEMP_FANTASIA: TWideStringField;
    cds_duplicatasEMP_NOME: TWideStringField;
    cds_duplicatasFIN_VL_PARCELA: TBCDField;
    cds_duplicatasFIN_BAIXA: TWideStringField;
    cds_duplicatasFIN_SITUACAO: TWideStringField;
    cds_duplicatasFIN_VL_PAGO: TBCDField;
    cds_duplicatasFIN_CODQTC: TIntegerField;
    cds_duplicatasFIN_CODFPG: TIntegerField;
    cds_duplicatasPED_CODIGO: TIntegerField;
    cds_duplicatasNFL_CODIGO: TIntegerField;
    cds_duplicatasFIN_TIPO: TWideStringField;
    cds_duplicatasFIN_DT_PAGTO: TDateField;
    cds_duplicatasFIN_OPERACAO: TWideStringField;
    cds_duplicatasFIN_ETAPA: TWideStringField;
    cds_duplicatasFIN_CODMHA: TIntegerField;
    cds_duplicatasFIN_CODCHQ: TIntegerField;
    cds_duplicatasPLC_CODIGO: TIntegerField;
    cds_duplicatasPLC_DESCRICAO: TWideStringField;
    cds_duplicatasFIN_DT_REPROGRAMADA: TDateField;
    Panel2: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Label10: TLabel;
    E_Vl_Recebido: TLabel;
    Lb_Close_totalizador: TLabel;
    Panel14: TPanel;
    pnl_cartao_dados: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    E_Identifica: TEdit;
    DBLCB_Cartao: TDBLookupComboBox;
    E_Validade: TEdit;
    E_Autoriza: TEdit;
    E_Parcelas: TEdit;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    cds_ParcelasPED_DT_ALTERA: TDateTimeField;
    cds_duplicatasPED_DT_ALTERA: TDateTimeField;
    CalcularComissao1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure E_VL_JurosExit(Sender: TObject);
    procedure E_VL_MoraExit(Sender: TObject);
    procedure E_VL_DescontoExit(Sender: TObject);
    procedure E_VL_JurosEnter(Sender: TObject);
    procedure E_VL_MoraEnter(Sender: TObject);
    procedure E_VL_DescontoEnter(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure SB_RetirarClick(Sender: TObject);
    procedure Qr_NegociacaoAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_BuscarClick(Sender: TObject);

    procedure Sb_ChequeClick(Sender: TObject);
    procedure SB_BoletoClick(Sender: TObject);
    procedure E_VL_ChequeExit(Sender: TObject);
    procedure StrGrd_ChequeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_InsereBoletoClick(Sender: TObject);
    procedure Sb_AlteraBoletoClick(Sender: TObject);
    procedure Sb_ExcluiBoletoClick(Sender: TObject);
    procedure Sb_GravaBoletoClick(Sender: TObject);
    procedure Sb_CancelaBoletoClick(Sender: TObject);
    procedure Sb_BuscaBoletoClick(Sender: TObject);
    procedure Sb_VoltaBoletoClick(Sender: TObject);
    procedure Sb_GravaChequeClick(Sender: TObject);
    procedure Sb_InsereChequeClick(Sender: TObject);
    procedure Sb_AlteraChequeClick(Sender: TObject);
    procedure Sb_CancelaChequeClick(Sender: TObject);
    procedure Sb_VoltaChequeClick(Sender: TObject);
    procedure Sb_DestinarClick(Sender: TObject);
    procedure Sb_ExcluiChequeClick(Sender: TObject);
    procedure Sb_BaixarClick(Sender: TObject);
    procedure DBG_BoletoDblClick(Sender: TObject);
    procedure StrGrd_ChequeDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Sb_InsereCartaoClick(Sender: TObject);
    procedure Sb_AlteraCartaoClick(Sender: TObject);
    procedure Sb_ExcluiCartaoClick(Sender: TObject);
    procedure Sb_GravarCartaoClick(Sender: TObject);
    procedure Sb_CancelarCartaoClick(Sender: TObject);
    procedure Sb_VoltarCartaoClick(Sender: TObject);
    procedure Sb_CartaoClick(Sender: TObject);
    procedure Sb_DuplicataClick(Sender: TObject);
    procedure RetirarDestinao1Click(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure Sb_NegociarClick(Sender: TObject);
    procedure Sb_InserirClick(Sender: TObject);

    procedure E_VL_PagoChange(Sender: TObject);
    procedure E_VL_PagoExit(Sender: TObject);
    procedure SB_AdicionarClick(Sender: TObject);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure ChBx_Periodo_bClick(Sender: TObject);
    procedure Sb_ImprimirClick(Sender: TObject);
    procedure sb_RECIBOClick(Sender: TObject);
    procedure Sb_ResumoClick(Sender: TObject);
    procedure Ds_ParcelasDataChange(Sender: TObject; Field: TField);
    procedure Observaes1Click(Sender: TObject);
    procedure Sb_leitorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbs_boletoShow(Sender: TObject);
    procedure AplicarPlanoContas1Click(Sender: TObject);
    procedure Sb_BoletoEletronicoClick(Sender: TObject);
    procedure Qr_BoletoAfterOpen(DataSet: TDataSet);
    procedure Sb_BoletoPDFClick(Sender: TObject);
    procedure Sb_ImprimirCartaoClick(Sender: TObject);
    procedure Cb_SituacaoChange(Sender: TObject);
    procedure InativarInativar1Click(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure E_Busca_Cd_EmpresaExit(Sender: TObject);
    procedure Fm_TipoRecebimentoDBLCB_FormaPagtoClick(Sender: TObject);
    procedure VisualizarPedido1Click(Sender: TObject);
    procedure Cb_TipoDataClick(Sender: TObject);
    procedure Fm_TipoRecebimentoSB_FormaPagClick(Sender: TObject);
    procedure Dbg_ParcelaDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Lb_Close_totalizadorClick(Sender: TObject);
    procedure Dbg_ParcelaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Dbg_DuplicatasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Dbg_ParcelaTitleClick(Column: TColumn);
    procedure Qr_BoletoAfterScroll(DataSet: TDataSet);
    procedure CalcularComissao1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    It_Inserir: Boolean;
    It_Alterar: Boolean;
    It_Excluir: Boolean;
    It_Visualizar: Boolean;
    It_Duplicata: Boolean;
    It_Recibo: Boolean;
    It_Autorizar : Boolean;

    FCartao : TControllerCartao;
    EditionStateCartao : String;

    FBoleto : TControllerBoleto;
    FCheque : TControllerCheque;
    FFinanceiro : TControllerFinanceiro;
    FEditionStateBoleto : String;
    FComissao : TControllerComissao;
    procedure Pc_IniciaVariaveis;
    procedure BuscaAutomatica;
    procedure SortClientDataSetByField(cds : TClientDataSet; FieldName : String;Direction: Boolean );
    procedure EditionControlCartao;
    //Boleto
    procedure AtivarCarteiraCobranca;
    procedure ShowDataBoleto;
    procedure EditionControlBoleto;
    //Boleto - Isnerir
    function ValidaInsertBoleto:Boolean;
    procedure InsertBoleto;
    //Boleto - Change
    function ValidateChangeBoleto:boolean;
    procedure ChangeBoleto;
    //Boleto - Delete
    function ValidateDeleteBoleto:boolean;
    procedure DeleteBoleto;
    //Boleto - save
    function ValidateSaveBoleto:boolean;
    procedure SaveBoleto;
    //Boleto - Cancel
    function ValidateCancelBoleto:boolean;
    procedure CancelBoleto;

    function ValidaRecalcularComissao:boolean;
    procedure RecalcularComissao;
  public
    { Public declarations }
    //Varival do comando Sql;
    It_Sql_Txt : String;
    //Variveis Vincualadas a Tabela
    It_Oper_Reg      : String;
    It_Cd_Financeiro : Integer;
    It_Cd_Empresa    : Integer;
    It_Data          : TDate;
    It_Cd_Pedido     : Integer;
    It_Cd_Nota       : Integer;
    It_Cd_FmaPagto   : Integer;
    It_Prazo         : String;
    It_Dt_Vencimento : TDate;
    It_Nr_Financeiro : String;
    It_Vl_Parcela: Currency;
    It_Nr_Parcela    : Integer;
    It_Vl_Juros: Currency;
    It_Vl_Mora: Currency;
    It_Vl_Desconto: Currency;
    It_Vl_Pago: Currency;
    It_Dt_Pago       : TDate;
    It_Dt_Baixa      : TDate;
    It_Baixa         : String;
    It_Tipo          : String;
    It_Situacao      : String;
    It_Cd_Quitacao   : Integer;
    It_Operacao      : String;
    It_Etapa         : String;
    It_cd_Cheque     : Integer;
    It_cd_boleto    :integer;

    //Controle da Baixa no Geral
    It_Vl_Baixa: Currency;
    It_Vl_Pagto: Currency;
    It_Vl_Credito: Currency;

    It_Cta_Bancaria : Integer;

    // Manipulação dos Cheques
    It_Cheque : Integer;
    it_Oper_Reg_Chq : String;
    it_Reg_Atl_chq : Integer;

    // Manipulação dos Duplicatas
    It_TipoTransacao : String;


    it_BaixaOK : Boolean;

    //Processo de Interface
    procedure Pc_FormataTela;
    procedure Pc_grava_Perfil_Local;
    procedure Pc_ImagemBotao;

    //procedures para Validar a Baixa
    procedure Pc_Define_Valores_Baixa;
    function Fc_validar_Baixa():Boolean;
    function Fc_ValidaBaixaCartao():Boolean;
    function Fc_Verificar_Baixa_Parcela: Boolean;

    //procedures para Executar a Baixa
    procedure Pc_Processo_Baixa;
    procedure Pc_Baixar_Duplicatas;
    procedure Pc_Baixar_Valor;
    procedure Pc_Gerar_Baixa_Parcial(Pc_Vl_Saldo:Real);
    procedure Pc_Processo_Baixa_Cartao;
    procedure Pc_Baixar_Comissao;
    procedure Pc_Finalizar_Baixa;
    procedure baixaComTEF;

    procedure Pc_Mostrar_Baixados;
    //Processo com o movimento Financeiro
    procedure Pc_Processo_Movim_Financeiro;
    procedure PC_Lancar_PAgto_CArtao;
    function Fc_Preencher_Historico():String;
    Procedure Pc_Lancar_Caixa;
    procedure Pc_Lancar_Banco;

    procedure Pc_Ativar_Tabelas;
    procedure TotalizaBaixa;
    procedure TotalizaReceber;
    procedure Pc_Buscar_Parcela(Pc_Tipo : String);
    procedure Pc_Criterio_Sql_Normal;
    procedure Pc_Criterio_Sql_Destinada;
    procedure Pc_Criterio_Sql_Recibo;
    procedure Pc_Preencher_Parcelas;
    //Processo com os Cheques
    procedure PC_Buscar_Cheque(Pc_Tipo : String);
    procedure Pc_Destinar(Pc_Tipo : String);
    procedure Pc_Limpar_Campo_Cheque;
    procedure Pc_Deletar_Cheque;
    procedure Pc_Preencher_Campo_Cheque;
    procedure Pc_Liberar_Campo_Cheque(Pc_Tipo : Boolean);
    procedure Pc_Somar_Cheque;
    Procedure PC_Verificar_CH_Devolvido;
    Function Fc_ValidaGravacaoCheque():Boolean;
    //Processo com os Boletos
    procedure Pc_BuscaBoleto(Pc_Tipo : String);


    procedure Pc_Verificar_Situacao;
    procedure Pc_Retirar_Destinacao(Pc_cd_Financeiro:Integer);

    procedure Pc_Excluir_Contas_Receber;
    procedure Pc_Adicionar;
    procedure Pc_Adicionar_Tudo;
    procedure Pc_Ativar_Botoes;


    Procedure Pc_Definir_Grade_Cheque;

    Function Fc_Valida_Negociacao:Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);

    procedure GetCartao;
    procedure ShowCartao;
    procedure ClearCartao;
    function ValidaGravaCartao:Boolean;
    function GravaCartao:Boolean;
    function  Fc_ValidaAdicionaBaixa():boolean;
    function  Fc_ValidaOperacaoParcela():boolean;

    procedure posicionaTotalizador;


end;

var
  Fr_Receber_Multipla: TFr_Receber_Multipla;

implementation

uses     Un_DM, UN_MSG, UN_Fin_Baixado, UN_Sistema, UN_RL_Duplicata, Un_MinhaEmpresa, Un_Negociar, UN_Lanca_Pagto, Un_Lanca_PlanoContas, Un_Fin_Edita, TypInfo, Un_Nota_Fiscal, Un_Fc_Comissao, Un_Fc_Sored_Procedures, un_Obs_nfe, Un_Liberacao, Un_Funcoes, Un_Regra_Negocio, UN_Principal, env, RN_PlanoContas, RN_BoletoEletronico, RN_FormaPagto, Un_RL_ControleCartao, RN_Permissao, RN_Cliente, RN_Empresa, RI_MovimentoFinanceiro, RN_Financeiro, un_receber_tef_avulso, Un_Lanca_Caixa, Un_Lanca_Banco, RN_NotaFiscal, RN_NotaFiscalConsumidor, sea_electronic_slip;
{$R *.dfm}

procedure TFr_Receber_Multipla.Pc_FormataTela;
Begin
  //Verificar pefil local
  IF Fc_Aq_Geral('L','CTARECEBER','CRB_TELA_MAXIM','N') = 'S' then
    WindowState := wsMaximized
  else
    WindowState := wsNormal;

  Lb_Titulo_totalizador.Transparent := False;
  Lb_Titulo_totalizador.Color := clNavy;
  Lb_Titulo_totalizador.Font.Color := clWhite;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pg_Observacao.Visible := FAlse;

end;

procedure TFr_Receber_Multipla.Pc_grava_Perfil_Local;
Begin
  if (WindowState = wsNormal) then
    Fc_Aq_Geral('G','CTARECEBER','CRB_TELA_MAXIM','N')
  else
    Fc_Aq_Geral('G','CTARECEBER','CRB_TELA_MAXIM','S');


end;

Procedure TFr_Receber_Multipla.Pc_Baixar_Comissao;
Var
  Lc_I : Integer;
  Lc_cd_Financeiro : Integer;
  Lc_cd_Pedido : Integer;
Begin
  if (Fc_Tb_Geral('L','TP_COMISSAO','')='R') then
  Begin
    Pc_Construtor_Comissao(DM.IB_Transacao);
    if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.First;
    while not cds_duplicatas.Eof do
    Begin
      Lc_cd_Financeiro := cds_duplicatasFIN_CODIGO.AsInteger;
      Lc_Cd_Pedido     := cds_duplicatasPED_CODIGO.AsInteger;
      Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Lc_cd_Pedido);
      Pc_Gerar_Comissao_Vda_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
      Pc_Gerar_Comissao_Srv_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
      Pc_Gerar_Comissao_Srv_Vdo_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
      cds_duplicatas.Next;
    end;
    Pc_Destrutor_Comissao;
  end;
end;



procedure TFr_Receber_Multipla.Pc_Define_Valores_Baixa;
Var
  Lc_I : Integer;
  Lc_data : String;
  Lc_Carencia : Integer;
  Lc_valor : Real;
  Lc_Tx_Multa : Real;
  Lc_Tx_Juros : Real;
  Lc_dias : Real;
Begin
  E_VL_Juros.Text := '0,00';
  E_VL_Mora.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  Lc_Tx_Multa := (StrToIntDef(Fc_Tb_Geral('L','FIN_G_MULTA',''),0)/100);
  Lc_Tx_Juros := StrToFloatDef(Fc_Tb_Geral('L','FIN_G_JUROS',''),0) / 30;
  Lc_Carencia := StrToIntDef(Fc_Tb_Geral('L','FIN_G_CARENCIA',''),0);
  It_Vl_Baixa := 0;
  It_Vl_Credito := 0;
  //variveis instanciadas
  It_Vl_Juros := 0;
  It_Vl_Mora := 0;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if cds_duplicatasFIN_OPERACAO.AsString = 'C' then
    Begin
      if (cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime + Lc_Carencia) < Date then
      Begin
        Lc_dias := Date - cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
        Lc_valor := cds_duplicatasFIN_VL_PARCELA.AsCurrency;
        It_Vl_Mora := It_Vl_Mora + (Lc_valor * Lc_Tx_Multa) ;
        It_Vl_Juros := It_Vl_Juros + (Lc_valor * ((Lc_Tx_Juros * Lc_dias)/100));
      end;
      It_Vl_Baixa := It_Vl_Baixa + cds_duplicatasFIN_VL_PARCELA.AsCurrency;
      E_VL_Mora.Text := FloatToStrF(It_Vl_Mora, ffFixed, 10,2);
      E_VL_Juros.Text := FloatToStrF(It_Vl_Juros, ffFixed, 10,2);
    end
    else
    Begin
      It_Vl_Credito := It_Vl_Credito + cds_duplicatasFIN_VL_PARCELA.AsCurrency;
    end;
    cds_duplicatas.Next;
  end;
    It_Vl_Pagto := (It_Vl_Baixa + It_Vl_Juros + It_Vl_Mora) - It_Vl_Credito;
end;

function TFr_Receber_Multipla.Fc_validar_Baixa():Boolean;
Var
  Lc_Form :TFr_Liberacao;
Begin
  Result := true;
  if Trim(Fm_TipoRecebimento.DBLCB_formaPagto.Text) = ''  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe a forma de pagamento.'+EOLN+
                   'O Campo tipo de cobrança deve ser preenchido.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if Fm_TipoRecebimento.DBLCB_formaPagto.CanFocus then Fm_TipoRecebimento.DBLCB_formaPagto.SetFocus;
    exit;
  end;

  if (StrtofloatDef(E_VL_Desconto.Text,0)>0) and (StrtofloatDef(E_VL_Pago.Text,0)=0) and (StrtofloatDef(E_Vl_Saldo.Caption,0)>0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não é possivel executar a baixa.'+EOLN+
                   'Conceder desconto, com valor pago igual '+EOLN+
                   'a "0,00"(zero), não pode gerar baixa parcial.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if E_VL_Desconto.CanFocus then E_VL_Desconto.SetFocus;
    exit;
  end;


  //Valida as formas de Pagamentos
  if ((Fc_Tb_Geral('L','FIN_VAL_PAGTO_CR','S') = 'S')) then
  Begin
    //Verifica se os dados do Boleto Foram Preenchidos
    if (Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'BOLETO') and (Pg_Controle.ActivePageIndex <> 2) then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Verifique os dados do boleto.'+EOLN+
                     'Os dados devem ser visualizados para a baixa.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
    end;
    //Verifica se os dados do Cheque Foram Preenchidos
    if (Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'CHEQUE') and (Pg_Controle.ActivePageIndex <> 1) then
    Begin
          MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                         'Verifique os dados do(s) cheque(s).'+EOLN+
                         'Os dados devem ser visualizados para a baixa.'+EOLN,
                        ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
    end;
    //Verifica se os dados do Cartão Foram Preenchidos
    if ((Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'CARTÃO') OR (Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'CARTAO') )and (Pg_Controle.ActivePageIndex <> 3) then
    Begin
          MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                         'Verifique os dados do cartão.'+EOLN+
                         'Os dados devem ser visualizados para a baixa.'+EOLN,
                        ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
    end;
  end;

  //Verifica se os dados do Cartão Foram Preenchidos
  if (StrToFloatDef(E_VL_Desconto.Text,0)>0) and (Gb_Nivel = 0) AND (not It_Autorizar) then
  Begin
    Lc_Form := TFr_Liberacao.Create(Self);
    Lc_Form.Liberado := False;
    Lc_Form.It_Interface := 'Fr_Receber_Multipla';
    Lc_Form.It_Nome_Menu := 'Contas a Receber';
    Lc_Form.It_Privilegio := 'AUTORIZAR';
    Lc_Form.ShowModal;
    FreeAndNil(Lc_Form);
    if not GB_Liberado then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Não é possivel dar desconto sem autorização.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'],[bEscape],mpInformacao);
      Result := False;
      exit;
    end;
  end;

  if Fc_Verificar_Baixa_Parcela then
  begin
    Result := False;
    exit;
  end;
end;

procedure TFr_Receber_Multipla.Pc_Excluir_Contas_Receber;
Var
  Lc_Sql_Txt : String;
Begin
  try
    with Qr_Acao do
    Begin
      //Contas a Receber
      Active := False;
      Transaction := DM.IB_Transacao;
      SQL.Clear;
      Lc_Sql_Txt := 'DELETE FROM TB_FINANCEIRO '+
                    'WHERE (FIN_CODIGO =:FIN_CODIGO) ';
      SQL.Add(Lc_Sql_Txt);
      ParamByName('FIN_CODIGO').AsInteger := cds_ParcelasFIN_CODIGO.AsInteger;
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      //Nota
      IF (cds_ParcelasFIN_TIPO.AsString = 'RM') then
      Begin
        Active := False;
        Transaction := DM.IB_Transacao;
        SQL.Clear;
        Lc_Sql_Txt := 'DELETE FROM TB_NOTA_FISCAl '+
                      'WHERE (NFL_CODIGO =:NFL_CODIGO) ';
        SQL.Add(Lc_Sql_Txt);
        ParamByName('NFL_CODIGO').AsInteger := cds_ParcelasNFL_CODIGO.AsInteger;
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      End;
    End;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Receber_Multipla.Pc_Retirar_Destinacao(Pc_cd_Financeiro:Integer);
Var
  Lc_Sqltxt : String;
Begin
  if not (Cb_Situacao.ItemIndex = 1) then exit;
  with Qr_Acao do
  Begin
    //Retira a destinação dos Cheque
    Active := False;
    Transaction := DM.IB_Transacao;
    SQL.Clear;
    Lc_Sqltxt := 'DELETE FROM TB_CHEQUES '+
                 'WHERE (CHQ_QT_REC =:CHQ_QT_REC) ';
    SQL.Add(Lc_Sqltxt);
    ParamByName('CHQ_QT_REC').AsInteger := cds_ParcelasFIN_CODQTC.AsInteger;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    //Retira a destinação da Conta
    Active := False;
    Transaction := DM.IB_Transacao;
    SQL.Clear;
    Lc_Sqltxt := 'UPDATE TB_FINANCEIRO SET '+
                 '  FIN_CODQTC = 0, '+
                 '  FIN_SITUACAO = ''N'', '+
                 '  FIN_ETAPA = ''N'' '+
                 'WHERE (FIN_CODIGO =:FIN_CODIGO) ';
    SQL.Add(Lc_Sqltxt);
    ParamByName('FIN_CODIGO').AsInteger := Pc_cd_Financeiro;
    Active := True;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  end;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
end;

procedure TFr_Receber_Multipla.PC_Lancar_Pagto_CArtao;
Var
  Lc_I : Integer;
  Lc_StrDupl : String;
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_Vl_Desconto : Real;
  Lc_Valor : Real;
  Lc_Parcelas : Integer;
  Lc_Aliq:Real;

  Lc_ContaResultado : Integer;
  Lc_CentroCusto : Integer;
  //Data
  Lc_Data : TDate;
  Lc_Cd_FormaPagto : Integer;
Begin
  FCartao.clear;
  FCartao.registro.CodigoQuitacaoRec := It_Cd_Quitacao;
  FCartao.getByCodigoQuitacao;
  if FCartao.exist then
  Begin
    FCartao.Eletronico.Registro.FormaPagamento := It_Cd_FmaPagto;
    FCartao.Eletronico.getbyFormaPagto;
    //Utilizaremos aqui para pegar dados do plano de contas da forma de pagamento
    FCartao.Eletronico.FormaPagto.Registro.Codigo := FCartao.Eletronico.Registro.FormaPagamento;
    FCartao.Eletronico.FormaPagto.getById;

  End;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if cds_duplicatas.Bof then
    Begin
      if (cds_duplicatasNFL_NUMERO.AsString <>'') then
        Lc_StrDupl := DBLCB_Cartao.Text + ' - N.F.: '+ cds_duplicatasNFL_NUMERO.AsString
      else
        Lc_StrDupl := DBLCB_Cartao.Text + ' - Pedido: '+ cds_duplicatasPED_NUMERO.AsString;
    end
    else
    Begin
      if (cds_duplicatasNFL_NUMERO.AsString <>'') then
        Lc_StrDupl := DBLCB_Cartao.Text + '\'+ cds_duplicatasNFL_NUMERO.AsString
      else
        Lc_StrDupl := Lc_StrDupl + '\'+ cds_duplicatasPED_NUMERO.AsString;
    end;
    cds_duplicatas.next;
  end;
  //Limitar a 100 caracteres
  Lc_StrDupl := Copy(Lc_StrDupl,1,80);

  Lc_Parcelas := FCartao.Registro.NumeroParcela;
  Lc_Valor := StrToFloatDef(E_VL_Pago.Text,0);
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_St_Parcela := FloatToStrF((Lc_Valor / Lc_Parcelas),ffFixed,10,2);

  //Lancamento no Banco
  For Lc_I := 1 to Lc_Parcelas do
  Begin
    if Lc_Parcelas =1 then
      Lc_Data := date + ( FCartao.Eletronico.Registro.prazoCredito * Lc_I )
    else
      Lc_Data := date + ( FCartao.Eletronico.Registro.prazoDebito * Lc_I );

    if not (Lc_I = Lc_Parcelas) then
      Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,1)
    else
      Lc_Vl_Parcela :=(Lc_Valor -(StrToFloatDef(Lc_St_Parcela,0) * (Lc_Parcelas-1)));
    //Centro de Custo observando a forma de pagamento
    if FCartao.Eletronico.FormaPagto.Registro.CentroCusto > 0 then
      Lc_CentroCusto := FCartao.Eletronico.FormaPagto.Registro.CentroCusto
    else
      Lc_CentroCusto := cds_duplicatasPLC_CODIGO.AsInteger;

    //Conta de resultado registrado no cadastro do cartão
    if FCartao.Eletronico.FormaPagto.Registro.CentroCusto > 0 then
      Lc_ContaResultado := FCartao.Eletronico.FormaPagto.Registro.ContaResultado
    else
      Lc_ContaResultado := FCartao.Eletronico.Registro.PlanoCredito;

    //FAz o lancamento no banco
    Lc_Cd_FormaPagto := Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue;
    Pc_Movim_Financeiro(dm.IB_Transacao,
                        'I',
                        0,
                        FCartao.Eletronico.Registro.contaCorrente,
                        Lc_data,
                        1,
                        Lc_ContaResultado,
                        Lc_CentroCusto,
                        Lc_Vl_Parcela,
                        0,
                        Lc_StrDupl + ' - PARCELA ' + IntToStr(Lc_I)+'/'+IntToStr(Lc_Parcelas),
                        'C',
                        It_Cd_Quitacao,
                        Gb_Cd_Usuario,
                        0,
                        Lc_data,
                        '',
                        'N',
                        'S',
                        Gb_CodMha,
                        Lc_Cd_FormaPagto);

    if Lc_Parcelas =1 then
    Begin
      Lc_Data := date + ( FCartao.Eletronico.Registro.PrazoCredito * Lc_I );
      Lc_Aliq := FCartao.Eletronico.Registro.AliqCredito /100;
    end
    else
    Begin
      Lc_Data := date + ( FCartao.Eletronico.Registro.PrazoDebito * Lc_I );
      Lc_Aliq := FCartao.Eletronico.Registro.AliqDebito /100;
    end;

    if not (Lc_I = Lc_Parcelas) then
      Lc_Vl_Desconto := StrToFloatDef(Lc_St_Parcela,1) * Lc_Aliq
    else
      Lc_Vl_Desconto :=(Lc_Valor -(StrToFloatDef(Lc_St_Parcela,0) * (Lc_Parcelas-1))) * Lc_Aliq;

    //Centro de Custo registrado no cadastro do cartão
    Lc_CentroCusto := FCartao.Eletronico.Registro.PlanoDebito;
    //Conta de resultado registrado no cadastro do cartão
    Lc_ContaResultado :=  FCartao.Eletronico.Registro.PlanoCredito;

    Pc_Movim_Financeiro(dm.IB_Transacao,
                        'I',
                        0,
                        FCartao.Eletronico.Registro.contacorrente,
                        Lc_data,
                        1,
                        Lc_ContaResultado,
                        Lc_CentroCusto,
                        0,
                        Lc_Vl_Desconto,
                        'Taxa Desconto ' + Lc_StrDupl + ' - PARCELA ' + IntToStr(Lc_I)+'/'+IntToStr(Lc_Parcelas),
                        'C',
                        It_Cd_Quitacao,
                        Gb_Cd_Usuario,
                        0,
                        Lc_data,
                        '',
                        'N',
                        'S',
                        Gb_CodMha,
                        Lc_Cd_FormaPagto);
  end;
end;

procedure TFr_Receber_Multipla.Pc_Finalizar_Baixa;

Begin
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  Pg_Controle.ActivePageIndex := 0;
  Pc_Ativar_Tabelas;
  Pc_LimpaStringGrid(StrGrd_Cheque);
  It_Cheque := 0;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.EmptyDataSet;

  It_Oper_Reg      := 'I';
  It_Cd_Financeiro := 0;
  It_Cd_Empresa    := 0;
  It_Cd_Pedido     := 0;
  It_Cd_Nota       := 0;
  It_Cd_FmaPagto   := 0;
  It_Prazo         := '000 - VISTA';
  It_Nr_Financeiro := '1';
  It_Vl_Parcela    := 0;
  It_Nr_Parcela    := 0;
  It_Vl_Juros      := 0;
  It_Vl_Mora       := 0;
  It_Vl_Desconto   := 0;
  It_Vl_Pago       := 0;
  It_Baixa         := 'N';
  It_Tipo          := 'RA';
  It_Situacao      := 'N';
  It_Operacao      := 'C';
  It_Etapa         := 'N';
  It_cd_Cheque     := 0;
  It_Vl_Credito    := 0;
  It_Cheque := 0;
  It_Cd_Quitacao := 0;
  //Controle da Baixa no Geral
  It_Vl_Baixa    := 0;
  E_VL_Juros.Text := '0,00';
  E_VL_Mora.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  E_Vl_Pago.Text := '0,00';
  E_Vl_Saldo.Caption := '0,00';
  Pc_Ativar_Botoes;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  TotalizaBaixa;
  ClearCartao;
end;

procedure TFr_Receber_Multipla.Pc_Verificar_Situacao;
Begin
  if cds_ParcelasFIN_BAIXA.AsString = 'S' then
  Begin
    It_TipoTransacao := 'BAIXADAS';
    Pc_Mostrar_Baixados;
    SB_BuscarClick(Self);
  end
  else
  Begin
    if cds_ParcelasFIN_SITUACAO.AsString = 'D' then
    Begin
      It_TipoTransacao := 'DESTINADAS';
      It_Cd_Quitacao := cds_ParcelasFIN_CODQTC.AsInteger;
      It_Cd_FmaPagto := cds_ParcelasFIN_CODFPG.AsInteger;
      It_Cd_Empresa := cds_ParcelasFIN_CODEMP.AsInteger;
    end
    else
    Begin
      It_TipoTransacao := 'NORMAL';
      It_Cd_Quitacao := 0;
    end;
  end;
End;

procedure TFr_Receber_Multipla.posicionaTotalizador;
Var
  I : Integer;
begin
  For I := 1 to Pg_Observacao.PageCount do Pg_Observacao.Pages[I-1].TabVisible:=False;
  Pg_Observacao.Top := Dbg_Parcela.Top;
  Pg_Observacao.Left := trunc((self.Width - Pg_Observacao.Width)/2);
  Pg_Observacao.ActivePageIndex := 0;
  Pg_Observacao.Visible := False;
end;

procedure TFr_Receber_Multipla.Pc_Destinar(Pc_Tipo : String);
Var
  Lc_I : Integer;
  Lc_Cd_Aux :Integer;
Begin
  It_Cd_FmaPagto := Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue;

  if It_Cd_Quitacao = 0 then  It_Cd_Quitacao := Fc_GeraCod_Baixa;
  //Destina as Duplicatas
  if Pc_Tipo = 'D' then
  Begin
    if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.First;
    while not cds_duplicatas.Eof do
    Begin
      Pc_Financeiro(
            dm.IB_Transacao,
            'D',
            cds_duplicatasFIN_CODIGO.AsInteger,
            0, 0, 0, 0, It_Cd_FmaPagto,'', 0,'', 0,0,0, 0, 0,0 ,0, 'N', 0,'RA', 'D', It_Cd_Quitacao,'C','N',0);
      cds_duplicatas.Next;
    end;
  end;

  //Destina os Cheques
  if It_Cd_FmaPagto = Fc_PegaFormaPgto('CHEQUE') then
  Begin
    if StrGrd_Cheque.Cells[2,1] <> '' then
    Begin
      For Lc_I := 1 to StrGrd_Cheque.RowCount -1 do
      Begin
        with FCheque.Registro do
        Begin
          Codigo                := StrToIntDef( StrGrd_Cheque.Cells[1,Lc_I],0);
          Emitente              := StrGrd_Cheque.Cells[2,Lc_I];
          NumeroBanco           := StrToIntDef( StrGrd_Cheque.Cells[3,Lc_I],0);
          Agencia               := StrGrd_Cheque.Cells[4,Lc_I];
          Numero                := StrGrd_Cheque.Cells[5,Lc_I];
          Valor                 :=  StrToFloatDef( StrGrd_Cheque.Cells[6,Lc_I],0);
          Data                  :=  StrToDate( StrGrd_Cheque.Cells[7,Lc_I]);
          Devolvido             := 'N';
          Tipo                  := 'T';
          Estado                := 'N';
          ValorAmortizado       := 0;
          QuitacaoRecebimento   := It_Cd_Quitacao;
          QuitacaoPagamento     := StrToIntDef(StrGrd_Cheque.Cells[14,Lc_I],0);
          CodigoFornecedor      := StrToIntDef(StrGrd_Cheque.Cells[15,Lc_I],0);
          ContaCorrente         := StrGrd_Cheque.Cells[16,Lc_I];
          CodigoEstabelecimento := Gb_CodMha;
        End;
        FCheque.salva;
        StrGrd_Cheque.Cells[1,Lc_I] := FCheque.Registro.Codigo.ToString;
      end;
    End;
  end;

  //Destina os Cartões
  if (It_Cd_FmaPagto = Fc_PegaFormaPgto('CARTÃO')) OR
     (It_Cd_FmaPagto = Fc_PegaFormaPgto('CARTAO')) or
     Fc_ValidaBaixaCartao then
  Begin
    Fcartao.Registro.CodigoQuitacaoRec := It_Cd_Quitacao;
    Fcartao.Atualiza;
  end;
end;

procedure TFr_Receber_Multipla.Pc_Mostrar_Baixados;
Var
  LcForm : TFr_Fin_Baixado;
Begin
  LcForm := TFr_Fin_Baixado.create(self);
  try
    LcForm.CodigoFinanceiro := cds_ParcelasFIN_CODIGO.AsInteger;
    LcForm.TipoOperacao := 'ContasReceber';
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
    Pc_Buscar_Parcela('N');
  end;
End;


procedure TFr_Receber_Multipla.Pc_Baixar_Duplicatas;
Var
  Lc_I : Integer;
  Lc_Rel_Par_Total : real;
  Lc_Vl_Credito : Real;
  Lc_Vl_Debito : Real;
  Lc_Saldo_Cliente : Real;
  Lc_Saldo_Parcial : Real;
BEgin
  Lc_Saldo_Cliente := 0;
  Lc_Saldo_Parcial := 0;
  It_Oper_Reg         := 'B';
  It_Data             := Date;
  It_Cd_FmaPagto      :=Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue;
  It_Dt_Baixa         := Date;
  It_Baixa            := 'S';
  It_Etapa            := 'N';
  It_Tipo             := 'RA';
  It_Situacao         := 'D';
  It_Dt_Pago          := E_Dt_Pagto.Date;
  Lc_Saldo_Cliente := StrToFloatDef(E_VL_Pago.Text,0);
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    //Verifica se É Credito do cliente
    if (cds_duplicatasFIN_OPERACAO.AsString = 'D' ) then
    Begin
      It_Cd_Financeiro := cds_duplicatasFIN_CODIGO.AsInteger;
      It_Nr_Financeiro := cds_duplicatasFIN_NUMERO.AsString;
      It_Nr_Parcela    := cds_duplicatasFIN_NR_PARCELA.AsInteger;
      It_Dt_Vencimento := cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
      It_cd_pedido     := cds_duplicatasPED_CODIGO.AsInteger;
      It_Cd_Nota       := cds_duplicatasNFL_CODIGO.AsInteger;
      It_Vl_Parcela    := cds_duplicatasFIN_VL_PARCELA.AsCurrency;
      if (Lc_Vl_Credito < It_Vl_Parcela) then
        Begin
        Lc_Vl_Credito      := It_Vl_Parcela;
        end;
      It_cd_Cheque     := cds_duplicatasFIN_CODCHQ.AsInteger;
      It_Vl_Juros      := 0;
      It_Vl_Mora       := 0;
      It_Vl_Desconto   := 0;
      It_Operacao      := 'D';
      It_Vl_Pago       := It_Vl_Parcela;
      Pc_Baixar_Valor;
      Lc_Saldo_Cliente := Lc_Saldo_Cliente + It_Vl_Parcela;
    end;
    cds_duplicatas.next;
  end;

  //Verifica o Valor total do Debito do cliente
  Lc_Vl_Debito := 0;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if (cds_duplicatasFIN_OPERACAO.AsString = 'C' ) then
      Lc_Vl_Debito := Lc_Vl_Debito + cds_duplicatasFIN_VL_PARCELA.AsCurrency;
    cds_duplicatas.Next;
  End;

  //Verifica se o Saldo do Cliente É Maior que Zero para continuar a operação
  If (Lc_Saldo_Cliente + It_Vl_Desconto) > 0 then
  Begin
    if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.First;
    while not cds_duplicatas.Eof do
    Begin
      //Verifica se É Débito do cliente
      if ( cds_duplicatasFIN_OPERACAO.AsString = 'C' ) then
      Begin
        It_Cd_Financeiro := cds_duplicatasFIN_CODIGO.AsInteger;
        It_Nr_Financeiro := cds_duplicatasFIN_NUMERO.AsString;
        It_Nr_Parcela    := cds_duplicatasFIN_NR_PARCELA.AsInteger;
        It_Dt_Vencimento := cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
        It_cd_pedido     := cds_duplicatasPED_NUMERO.AsInteger;
        It_Cd_Nota       := cds_duplicatasNFL_CODIGO.AsInteger;
        It_Vl_Parcela    := cds_duplicatasFIN_VL_PARCELA.AsCurrency;
        if (Lc_Vl_Credito < It_Vl_Parcela) then
        Begin
          Lc_Vl_Credito      := It_Vl_Parcela;
        end;
        It_cd_Cheque     := cds_duplicatasFIN_CODCHQ.AsInteger;
        //Verifica a proporcação entre parcelas e valor a receber para distribuiro os juros
        if Lc_Vl_Debito > 0 then
          Lc_Rel_Par_Total := It_Vl_Parcela / Lc_Vl_Debito
        else
          Lc_Rel_Par_Total := 1;
        It_Vl_Juros    := StrToFloatDef(E_VL_Juros.Text,0)* Lc_Rel_Par_Total ;
        It_Vl_Mora     := StrToFloatDef(E_VL_Mora.Text,0)* Lc_Rel_Par_Total ;
        It_Vl_Desconto := StrToFloatDef(E_VL_Desconto.Text,0)* Lc_Rel_Par_Total;
        It_Operacao      := 'C';
        if ((Lc_Saldo_Cliente + It_Vl_Desconto) >= It_Vl_Parcela) then
        Begin
          It_Vl_Pago       := (It_Vl_Parcela + It_Vl_Juros + It_Vl_Mora ) - It_Vl_Desconto;
          Pc_Baixar_Valor;
          Lc_Saldo_Cliente := Lc_Saldo_Cliente - It_Vl_Pago;
        end
        else
        Begin
          if Lc_Saldo_Cliente = 0 then
          Begin
            Pc_Retirar_Destinacao(cds_duplicatasFIN_CODIGO.AsInteger);
          end
          else
          Begin
            //Guarda o Saldo do cliente para Gerar a Baixa Parcial
            Lc_Saldo_Parcial := (( It_Vl_Parcela - (Lc_Saldo_Cliente) ) + It_Vl_Juros + It_Vl_Mora ) - It_Vl_Desconto;
            //Faz a Baixa com o valor parcial
            It_Vl_Pago     := Lc_Saldo_Cliente;
            Pc_Baixar_Valor;
            //Gera uma Parcial com o saldo parcial
            Lc_Saldo_Parcial := StrToFloatDef(FloatToStrf(Lc_Saldo_Parcial,ffFixed,10,2),0);
            It_Vl_Juros    := 0;
            It_Vl_Mora     := 0;
            It_Vl_Desconto := 0;
            Pc_Gerar_Baixa_Parcial(Lc_Saldo_Parcial);
            Lc_Saldo_Cliente := 0;
          end;
        end;
      end;
      cds_duplicatas.Next;
    end;
  end;
  //verifica despois de passar na lista se sobrou saldo para gerar um parcela parcial
  if (Lc_Saldo_Cliente - It_Vl_Desconto) > 0 then
    Begin
    //Gera uma Parcial com o saldo parcial
    Lc_Saldo_Parcial := Lc_Saldo_Cliente * -1;
    Pc_Gerar_Baixa_Parcial(Lc_Saldo_Parcial);
    Lc_Saldo_Cliente := 0;
    end;

end;


procedure TFr_Receber_Multipla.Pc_Baixar_Valor;
Begin
  Pc_Financeiro(dm.IB_Transacao,
                It_Oper_Reg,
                It_Cd_Financeiro,
                It_Cd_Empresa,
                It_DATA,
                It_Cd_Pedido,
                It_Cd_Nota,
                It_Cd_FmaPagto,
                It_Prazo,
                It_Dt_Vencimento,
                It_Nr_Financeiro,
                It_Vl_Parcela,
                It_Vl_Juros,
                It_Vl_Mora,
                It_Vl_Desconto,
                It_Vl_Pago,
                It_Dt_Pago,
                It_Dt_Baixa,
                It_Baixa,
                It_Nr_Parcela,
                It_Tipo,
                It_Situacao,
                It_Cd_Quitacao,
                It_Operacao,
                It_Situacao,
                It_cd_Cheque);
end;

procedure TFr_Receber_Multipla.Pc_Gerar_Baixa_Parcial(Pc_Vl_Saldo:Real);
Var
  Lc_Saldo_Texto : String;
  Lc_cd_quitacao:integer;
Begin
  Lc_Saldo_Texto := FloatToStrf(Pc_Vl_Saldo,ffFixed,10,2);
  Pc_Vl_Saldo := StrToFloatDef(Lc_Saldo_Texto,0);
  if Pc_Vl_Saldo = 0 then exit;

  It_Oper_Reg := 'I';
  It_Cd_Financeiro := 0;
  It_Vl_Juros := 0;
  It_Vl_Mora := 0;
  It_Vl_Desconto := 0;
  It_Vl_Pago := 0;
  It_Nr_Parcela := 1;
  It_Tipo := 'RA';
  It_Etapa := 'N';
  It_Baixa := 'N';
  It_Situacao := 'N';
  //Guarda o codigo de Quitação antes de zerar para gerar a baixa parcial
  Lc_Cd_Quitacao := It_Cd_Quitacao;
  It_Cd_Quitacao := 0;
  It_Cd_FmaPagto:= Fc_PegaFormaPgto('CARTEIRA');
  if not cds_duplicatas.Active then cds_duplicatas.active := True;
  cds_duplicatas.Last;
  It_Nr_Financeiro := cds_duplicatasFIN_NUMERO.AsString;
  It_Nr_Parcela    := cds_duplicatasFIN_NR_PARCELA.AsInteger;
  It_Dt_Vencimento := cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
  It_cd_pedido     := cds_duplicatasPED_CODIGO.AsInteger;
  It_Cd_Nota       := cds_duplicatasNFL_CODIGO.AsInteger;
  It_cd_Cheque     := cds_duplicatasFIN_CODCHQ.AsInteger;

  if ( Pc_Vl_Saldo > 0 ) then
  Begin
    It_Vl_Parcela    := Pc_Vl_Saldo;
    It_Operacao := 'C';
    Pc_Baixar_Valor;
  end;

  if ( Pc_Vl_Saldo < 0 ) then
  Begin
    It_Vl_Parcela    := (Pc_Vl_Saldo * -1);
    It_Operacao := 'D';
    Pc_Baixar_Valor;
  end;
  //Devolve o codigo de quitação anterior
  It_Cd_Quitacao := Lc_Cd_Quitacao

end;

procedure TFr_Receber_Multipla.Pc_Deletar_Cheque;
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
  Lc_Cheque : Integer;
begin
  if StrGrd_Cheque.Cells[2,StrGrd_Cheque.row] = '' then exit;
  Lc_Cheque := 0;
  SetLength(Lc_Lista,StrGrd_Cheque.RowCount,StrGrd_Cheque.ColCount);
  //Guarda os dados que não estão marcados

  for Lc_I := 1 to StrGrd_Cheque.RowCount-1 do
    Begin
    if Lc_I <> StrGrd_Cheque.Row then
      Begin
      Lc_Cheque := Lc_Cheque + 1;
      Lc_Lista[Lc_Cheque,1] := StrGrd_Cheque.Cells[1, Lc_I];
      Lc_Lista[Lc_Cheque,2] := StrGrd_Cheque.Cells[2, Lc_I];
      Lc_Lista[Lc_Cheque,3] := StrGrd_Cheque.Cells[3, Lc_I];
      Lc_Lista[Lc_Cheque,4] := StrGrd_Cheque.Cells[4, Lc_I];
      Lc_Lista[Lc_Cheque,5] := StrGrd_Cheque.Cells[5, Lc_I];
      Lc_Lista[Lc_Cheque,6] := StrGrd_Cheque.Cells[6, Lc_I];
      Lc_Lista[Lc_Cheque,7] := StrGrd_Cheque.Cells[7, Lc_I];
      Lc_Lista[Lc_Cheque,8] := StrGrd_Cheque.Cells[8, Lc_I];
      Lc_Lista[Lc_Cheque,9] := StrGrd_Cheque.Cells[9, Lc_I];
      Lc_Lista[Lc_Cheque,10] := StrGrd_Cheque.Cells[10, Lc_I];
      Lc_Lista[Lc_Cheque,11] := StrGrd_Cheque.Cells[11, Lc_I];
      Lc_Lista[Lc_Cheque,12] := StrGrd_Cheque.Cells[12, Lc_I];
      Lc_Lista[Lc_Cheque,13] := StrGrd_Cheque.Cells[13, Lc_I];
      Lc_Lista[Lc_Cheque,14] := StrGrd_Cheque.Cells[14, Lc_I];
      Lc_Lista[Lc_Cheque,15] := StrGrd_Cheque.Cells[15, Lc_I];
      Lc_Lista[Lc_Cheque,16] := StrGrd_Cheque.Cells[16, Lc_I];
      end;
    end;

  Pc_LimpaStringGrid(StrGrd_Cheque);
  It_Cheque := 0;
  //Grava novamente os dados que não foram marcados e que estão na matriz
  if Lc_Cheque > 0 then
  Begin
    for Lc_I := 1 to Lc_Cheque do
    Begin
      It_Cheque := It_Cheque +1 ;
      StrGrd_Cheque.RowCount := It_Cheque + 1;
      StrGrd_Cheque.Cells[1,It_Cheque] := Lc_Lista[Lc_I,1];
      StrGrd_Cheque.Cells[2,It_Cheque] := Lc_Lista[Lc_I,2];
      StrGrd_Cheque.Cells[3,It_Cheque] := Lc_Lista[Lc_I,3];
      StrGrd_Cheque.Cells[4,It_Cheque] := Lc_Lista[Lc_I,4];
      StrGrd_Cheque.Cells[5,It_Cheque] := Lc_Lista[Lc_I,5];
      StrGrd_Cheque.Cells[6,It_Cheque] := Lc_Lista[Lc_I,6];
      StrGrd_Cheque.Cells[7,It_Cheque] := Lc_Lista[Lc_I,7];
      StrGrd_Cheque.Cells[8,It_Cheque] := Lc_Lista[Lc_I,8];
      StrGrd_Cheque.Cells[9,It_Cheque] := Lc_Lista[Lc_I,9];
      StrGrd_Cheque.Cells[10,It_Cheque] := Lc_Lista[Lc_I,10];
      StrGrd_Cheque.Cells[11,It_Cheque] := Lc_Lista[Lc_I,11];
      StrGrd_Cheque.Cells[12,It_Cheque] := Lc_Lista[Lc_I,12];
      StrGrd_Cheque.Cells[13,It_Cheque] := Lc_Lista[Lc_I,13];
      StrGrd_Cheque.Cells[14,It_Cheque] := Lc_Lista[Lc_I,14];
      StrGrd_Cheque.Cells[15,It_Cheque] := Lc_Lista[Lc_I,15];
      StrGrd_Cheque.Cells[16,It_Cheque] := Lc_Lista[Lc_I,16];
    end;
  end
  else
  Begin
  end;
  Pc_Somar_Cheque;
end;

procedure TFr_Receber_Multipla.Pc_Somar_Cheque;
Var
  Lc_I:Integer;
  Lc_VL_Cheque : Real;
Begin
  if StrGrd_Cheque.Cells[2,StrGrd_Cheque.Row] = '' then exit;
  Lc_VL_Cheque := 0;
  For Lc_I :=1 to (StrGrd_Cheque.RowCount -1) do
    Lc_VL_Cheque := Lc_VL_Cheque + StrToFloatDef(StrGrd_Cheque.Cells[6,lc_I],0);

  E_VLT_Cheque.Text := FloatToStrF(Lc_VL_Cheque,ffFixed,10,2);
  E_VL_Pago.Text := FloatToStrF(Lc_VL_Cheque,ffFixed,10,2);
end;

procedure TFr_Receber_Multipla.Pc_Liberar_Campo_Cheque(Pc_Tipo : Boolean);
Begin
  E_Emitente.Enabled := Pc_Tipo;
  E_Banco.Enabled := Pc_Tipo;
  E_Agencia.Enabled := Pc_Tipo;
  E_ContaCorrente.Enabled := Pc_Tipo;
  E_NumChq.Enabled := Pc_Tipo;
  E_DataCheque.Enabled := Pc_Tipo;
  E_VL_Cheque.Enabled := Pc_Tipo;

  Sb_InsereCheque.Enabled  := not Pc_Tipo;
  Sb_AlteraCheque.Enabled   := not Pc_Tipo;
  Sb_ExcluiCheque.Enabled  := not Pc_Tipo;
  Sb_GravaCheque.Enabled   := Pc_Tipo;
  Sb_CancelaCheque.Enabled := Pc_Tipo;
  Sb_VoltaCheque.Enabled   := not Pc_Tipo;

  Sb_Inserir.Enabled  := not Pc_Tipo;

  Sb_Cheque.Enabled  := not Pc_Tipo;
  SB_Buscar.Enabled  := not Pc_Tipo;
  Sb_Destinar.Enabled  := not Pc_Tipo;
  Sb_Baixar.Enabled  := not Pc_Tipo;
  SB_Sair_0.Enabled  := not Pc_Tipo;
end;

procedure TFr_Receber_Multipla.Pc_Limpar_Campo_Cheque;
Begin
  E_Emitente.Text := '';
  E_Banco.Text := '';
  E_Agencia.Text := '';
  E_NumChq.Text := '';
  E_ContaCorrente.Text := '';
  E_DataCheque.Date := Date;
  E_VL_Cheque.Text := '';
end;

procedure TFr_Receber_Multipla.Pc_Preencher_Campo_Cheque;
Begin
  it_Reg_Atl_chq := StrGrd_Cheque.Row;
  E_Emitente.Text := StrGrd_Cheque.Cells[2,it_Reg_Atl_Chq];
  E_Banco.Text := StrGrd_Cheque.Cells[3,it_Reg_Atl_Chq];
  E_Agencia.Text := StrGrd_Cheque.Cells[4,it_Reg_Atl_Chq];
  E_ContaCorrente.Text := StrGrd_Cheque.Cells[16,it_Reg_Atl_Chq];
  E_NumChq.Text := StrGrd_Cheque.Cells[5,it_Reg_Atl_Chq];
  E_DataCheque.Date := StrToDate(StrGrd_Cheque.Cells[7,it_Reg_Atl_Chq]);
  E_VL_Cheque.Text := StrGrd_Cheque.Cells[6,it_Reg_Atl_Chq];
end;


procedure TFr_Receber_Multipla.Pc_Criterio_Sql_Normal;
var
  Lc_Pedido, Lc_NotaFiscal,Lc_Finaceiro, Lc_Cd_Cliente, Lc_Cliente, Lc_Situacao, Lc_FormaPagto, Lc_Vl_Parcela : boolean;
  Lc_Str_Excecao : String;
  Lc_I,Lc_j:Integer;
Begin
  if E_BuscaPedido.Text = ''         then Lc_Pedido       := False else Lc_Pedido      := True;
  if E_BuscaNota.Text = ''           then Lc_NotaFiscal   := False else Lc_NotaFiscal  := True;
  if E_BuscaFinanceiro.Text = ''     then Lc_Finaceiro    := False else Lc_Finaceiro   := True;
  if E_Busca_empresa.Text = ''        then Lc_Cliente      := False else Lc_Cliente     := True;
  if Fm_TipoCobranca.DBLCB_formaPagto.Text = '' then Lc_FormaPagto   := False else Lc_FormaPagto  := True;
  if E_Busca_Cd_Empresa.Text = ''          then  Lc_Cd_Cliente  := False else Lc_Cd_Cliente  := True;
  if E_BuscaVl_Parcela.Text = ''     then  Lc_VL_Parcela  := False else Lc_VL_Parcela  := True;
  if Cb_Situacao.ItemIndex = 4       then Lc_Situacao     := False else Lc_Situacao    := True;

  IF It_Cd_Empresa > 0 then It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';
  if ChBx_Periodo.Checked then
  Begin
    case Cb_TipoData.ItemIndex of
      0:Begin
          It_Sql_Txt := It_Sql_Txt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) ';
        End;
      1:Begin
          It_Sql_Txt := It_Sql_Txt + 'AND (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) ';
        End;
      2:Begin
          It_Sql_Txt := It_Sql_Txt + 'AND (FIN_DATA BETWEEN :DATAINI AND :DATAFIM) ';
        End;
      3:Begin
          It_Sql_Txt := It_Sql_Txt + 'AND (FIN_DT_REPROGRAMADA BETWEEN :DATAINI AND :DATAFIM) ';
        End;
    end;
  end;

  if Lc_Pedido     then It_Sql_Txt := It_Sql_Txt + 'AND (PED_NUMERO = :PED_NUMERO) ';
  if Lc_NotaFiscal then It_Sql_Txt := It_Sql_Txt + 'AND (NFL_NUMERO LIKE :NFL_NUMERO) ';
  if Lc_Finaceiro  then It_Sql_Txt := It_Sql_Txt + 'AND (FIN_NUMERO LIKE :FIN_NUMERO) ';
  if Lc_Cd_Cliente then It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';
  if Lc_Cliente    then It_Sql_Txt := It_Sql_Txt + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
  if Lc_VL_Parcela then It_Sql_Txt := It_Sql_Txt + 'AND ( FIN_VL_PARCELA =:FIN_VL_PARCELA ) ';
  if Lc_FormaPagto then It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODFPG =:FIN_CODFPG) ';
  if Lc_Situacao   then
    Begin
    if Cb_Situacao.ItemIndex = 0 then  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA =''N'') AND (FIN_SITUACAO =''N'') ';
    if Cb_Situacao.ItemIndex = 1 then  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA =''N'') AND (FIN_SITUACAO =''D'') ';
    if Cb_Situacao.ItemIndex = 2 then  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA =''S'') ';
    if Cb_Situacao.ItemIndex = 3 then  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA =''I'') ';
    end;

  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  if cds_duplicatas.RecordCount > 0  then
  Begin
    Lc_Str_Excecao := 'AND (FIN_CODIGO NOT IN (';
    while NOT cds_duplicatas.Eof do
    Begin
      if cds_duplicatas.Bof then
        Lc_Str_Excecao := Lc_Str_Excecao + cds_duplicatasFIN_CODIGO.AsString
      else
        Lc_Str_Excecao := Lc_Str_Excecao + ','+ cds_duplicatasFIN_CODIGO.AsString;
      cds_duplicatas.next;
    end;
    It_Sql_Txt := It_Sql_Txt + Lc_Str_Excecao +')) ';
  End;

  case Cb_TipoData.ItemIndex of
    0:Begin
        Qr_Parcelas.SQL.Add(It_Sql_Txt+ 'ORDER BY FIN_DT_VENCIMENTO, EMP_NOME, PED_NUMERO, FIN_NUMERO ');
      end;
    1:Begin
        Qr_Parcelas.SQL.Add(It_Sql_Txt+ 'ORDER BY FIN_DT_PAGTO, EMP_NOME, PED_NUMERO, FIN_NUMERO ');
      end;
    2:Begin
        Qr_Parcelas.SQL.Add(It_Sql_Txt+ 'ORDER BY FIN_DATA, EMP_NOME, PED_NUMERO, FIN_NUMERO ');
      end;
    3:Begin
        Qr_Parcelas.SQL.Add(It_Sql_Txt+ 'ORDER BY FIN_DT_REPROGRAMADA, EMP_NOME, PED_NUMERO, FIN_NUMERO ');
      end;
  end;

  if ChBx_Periodo.Checked then
  Begin
    Qr_Parcelas.ParamByName('DATAINI').AsDate      := E_Data_Ini.date;
    Qr_Parcelas.ParamByName('DATAFIM').Asdate      := E_Data_Fim.Date;
  end;

  if Lc_Pedido     then Qr_Parcelas.ParamByName('PED_NUMERO').AsString   := E_BuscaPedido.Text;
  if Lc_NotaFiscal then Qr_Parcelas.ParamByName('NFL_NUMERO').AsString   := '%'+ Copy(E_BuscaNota.Text,1,8)+'%';
  if Lc_Finaceiro  then Qr_Parcelas.ParamByName('FIN_NUMERO').AsString   := '%'+ E_BuscaFinanceiro.Text+'%';
  IF (It_Cd_Empresa > 0)  THEN
    Qr_Parcelas.ParamByName('FIN_CODEMP').AsInteger  := It_Cd_Empresa
  else
    if Lc_Cd_Cliente then Qr_Parcelas.ParamByName('FIN_CODEMP').AsString  := E_Busca_cd_Empresa.Text;
  if Lc_Cliente    then Qr_Parcelas.ParamByName('EMP_FANTASIA').AsString := '%'+ E_Busca_Empresa.Text +'%';
  if Lc_VL_Parcela then Qr_Parcelas.ParamByName('FIN_VL_PARCELA').AsCurrency := StrToFloatDef(E_BuscaVl_Parcela.Text,0);
  if Lc_FormaPagto then Qr_Parcelas.ParamByName('FIN_CODFPG').AsInteger  := Fm_TipoCobranca.DBLCB_formaPagto.KeyValue;
end;

procedure TFr_Receber_Multipla.Pc_Criterio_Sql_Destinada;
Begin
  IF It_Cd_Empresa > 0 THEN It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';
  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_SITUACAO =:FIN_SITUACAO) ';
  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA =:FIN_BAIXA) ';
  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODQTC =:FIN_CODQTC) ';
  Qr_Parcelas.SQL.Add(It_Sql_Txt+ 'ORDER BY EMP_NOME, PED_NUMERO, FIN_NUMERO ');
  
  IF It_Cd_Empresa > 0 THEN  Qr_Parcelas.ParamByName('FIN_CODEMP').AsInteger :=  It_Cd_Empresa;
  Qr_Parcelas.ParamByName('FIN_SITUACAO').AsString :=  'D';
  Qr_Parcelas.ParamByName('FIN_BAIXA').AsString :=  'N';
  Qr_Parcelas.ParamByName('FIN_CODQTC').AsInteger :=  It_Cd_Quitacao;
end;

procedure TFr_Receber_Multipla.Pc_Criterio_Sql_Recibo;
Begin
  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_CODQTC   =:FIN_CODQTC) ';
  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_SITUACAO =:FIN_SITUACAO) ';
  It_Sql_Txt := It_Sql_Txt + 'AND (FIN_BAIXA    =:FIN_BAIXA) ';
  Qr_Parcelas.SQL.Add(It_Sql_Txt+ ' ORDER BY FIN_OPERACAO DESC, FIN_VL_PARCELA ASC');
  Qr_Parcelas.ParamByName('FIN_CODQTC').AsInteger  :=  It_Cd_Quitacao;
  Qr_Parcelas.ParamByName('FIN_SITUACAO').AsString :=  'D';
  Qr_Parcelas.ParamByName('FIN_BAIXA').AsString :=  'N';
end;

procedure TFr_Receber_Multipla.Pc_Buscar_Parcela(Pc_Tipo : String);
begin
  It_Sql_Txt := '';
  Qr_Parcelas.Close;
  Qr_Parcelas.Sql.Clear;

  It_Sql_Txt :=' SELECT DISTINCT '+
           '   FIN_CODIGO, '+
           '   NFL_NUMERO, '+
           '   coalesce(NFL_MODELO,55) NFL_MODELO, '+
           '   PED_NUMERO, '+
           '   FIN_NUMERO, '+
           '   FIN_DT_VENCIMENTO, '+
           '   FIN_NR_PARCELA, '+
           '   FIN_CODEMP, '+
           '   EMP_FANTASIA, '+
           '   EMP_NOME, '+
           '   FIN_VL_PARCELA, '+
           '   FIN_BAIXA, '+
           '   FIN_SITUACAO, '+
           '   FIN_VL_PAGO, '+
           '   FIN_CODQTC, '+
           '   FIN_CODFPG, '+
           '   PED_CODIGO, '+
           '   NFL_CODIGO, '+
           '   FIN_TIPO, '+
           '   FIN_DT_PAGTO, '+
           '   FIN_OPERACAO, '+
           '   FIN_ETAPA, '+
           '   FIN_CODMHA, '+
           '   FIN_CODCHQ, '+
           '   PLC_CODIGO, '+
           '   PLC_DESCRICAO, '+
           '   FIN_DT_REPROGRAMADA, '+
           '   ped_dt_altera '+
           ' FROM TB_FINANCEIRO tb_financeiro '+
           '   INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '+
           '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)  '+
           '   LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
           '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
           '   INNER JOIN TB_EMPRESA tb_empresa '+
           '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
           '   LEFT OUTER JOIN TB_PLANOCONTAS '+
           '   ON (PLC_CODIGO = tb_financeiro.FIN_PLC_DEBITO) '+
           ' WHERE  '+
           '  ((FIN_TIPO = ''RA'') OR '+
           '  (FIN_TIPO = ''RM''))  ';

  if not Grb_MnhaEmpresa.Visible then
  Begin
    It_Sql_Txt := It_Sql_Txt + ' AND (FIN_CODMHA=:FIN_CODMHA) ';
  end
  else
  Begin
    if not chbx_Empresas.Checked then
      It_Sql_Txt := It_Sql_Txt + ' AND (FIN_CODMHA=:FIN_CODMHA) ';
  end;

  If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
    It_Sql_Txt := It_Sql_Txt + 'AND ((PED_CODVDO =:PED_CODVDO)) ';

  //Efetua a Busca pelo Recibo         
  if  (Pc_Tipo = 'N') then Pc_Criterio_Sql_Normal;
  if  (Pc_Tipo = 'D') then Pc_Criterio_Sql_Destinada;
  if  (Pc_Tipo = 'R') then Pc_Criterio_Sql_Recibo;

  //Passa o paramentro do Codigo da minha Empresa
  If Trim(Fm_ListaVendedores.Dblcb_Vendedor.Text)<> '' then
    Qr_Parcelas.ParamByName('PED_CODVDO').AsInteger := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;
  if not Grb_MnhaEmpresa.Visible then
  Begin
    Qr_Parcelas.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
  end
  else
  Begin
    if not chbx_Empresas.Checked then
      Qr_Parcelas.ParamByName('FIN_CODMHA').AsInteger := Dblcb_Mha_Empresa.KeyValue;
  end;
  Qr_Parcelas.Open;
  Qr_Parcelas.FetchAll;
end;

procedure TFr_Receber_Multipla.Pc_Preencher_Parcelas;
Var
  I : Integer;
Begin
  Dbg_Parcela.Visible := False;
  with Qr_Parcelas  do
  Begin
    if not cds_Parcelas.active then cds_Parcelas.CreateDataSet;
    cds_Parcelas.LogChanges := False;
    cds_Parcelas.EmptyDataSet;
    First;
    while not Eof do
    Begin
      cds_Parcelas.Append;
      For I:= 0 to FieldCount -1 do
        cds_Parcelas.Fields[I].Value := Fields[I].Value;
      cds_Parcelas.Post;
      Next;
    end;
    cds_Parcelas.First;
  End;
  Dbg_Parcela.Visible := True;
  cds_Parcelas.LogChanges := True;
end;

procedure TFr_Receber_Multipla.Pc_BuscaBoleto(Pc_Tipo : String);
var
  It_Sql_Txt : string;
  Lc_Boleto, Lc_Cliente : boolean;
begin
  Screen.Cursor:=crHourGlass;
  It_Sql_Txt := '';
  Qr_Boleto.Active:=FALSE;
  Qr_Boleto.Sql.Clear;

  It_Sql_Txt :='SELECT DISTINCT BLT_CODIGO,  BLT_CODEMP,  tb_cliente.EMP_FANTASIA, BLT_NUMERO, BLT_DATA, BLT_CODCTB,    '+
           'BLT_DESCONTO, BLT_TX_DESCONTO, BLT_BAIXA, BLT_VALOR, BLT_CODQTC ,                                       '+
           ' (tb_banco.EMP_FANTASIA || '' - '' || CTB_AGENCIA || '' - '' || CTB_CONTA) CTB_COMPLETO                 '+
           'FROM  TB_BOLETO Tb_boleto                                                                               '+
           '  INNER JOIN TB_FINANCEIRO tb_financeiro ON (tb_financeiro.FIN_CODQTC = tb_boleto.BLT_CODQTC)           '+
           '  INNER JOIN TB_EMPRESA tb_cliente  ON (tb_cliente.EMP_CODIGO = tb_boleto.BLT_CODEMP)                   '+
           '  INNER JOIN TB_CONTABANCARIA tb_contabancaria  ON (tb_contabancaria.CTB_CODIGO = tb_boleto.BLT_CODCTB) '+
           '  INNER JOIN TB_EMPRESA tb_banco  ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO)                '+
           'WHERE ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) ';

  IF (Pc_Tipo = 'D') Then
  Begin
    It_Sql_Txt := It_Sql_Txt + 'AND (BLT_CODQTC =:BLT_CODQTC) ';

    Qr_Boleto.SQL.add(It_Sql_Txt + 'Order By EMP_FANTASIA ');

    Qr_Boleto.ParamByName('BLT_CODQTC').AsInteger := It_Cd_Quitacao;
    AtivarCarteiraCobranca;
    Qr_Boleto.Active := True;
  end
  else
  Begin
    if E_BuscaBoleto.Text = '' then Lc_Boleto := False else Lc_Boleto := True;
    if E_Busca_Boleto_Empresa.Text = '' then Lc_Cliente := False else Lc_Cliente := True;

    if ChBx_Periodo_b.Checked then
      It_Sql_Txt := It_Sql_Txt + 'AND (BLT_DATA BETWEEN :DATAINI AND :DATAFIM) ';
    if Lc_Boleto then It_Sql_Txt := It_Sql_Txt + 'AND (BLT_NUMERO = :BLT_NUMERO) ';
    if Lc_Cliente then It_Sql_Txt := It_Sql_Txt + 'AND ((tb_cliente.EMP_FANTASIA LIKE :EMP_FANTASIA) OR (tb_cliente.EMP_NOME LIKE :EMP_FANTASIA)) ';

    Qr_Boleto.SQL.add(It_Sql_Txt + 'Order By EMP_FANTASIA ');
    if ChBx_Periodo_b.Checked then
    Begin
      Qr_Boleto.ParamByName('DATAINI').Asdate :=  E_Dt_Ini_Bol.Date;
      Qr_Boleto.ParamByName('DATAFIM').AsDate := E_Dt_Fim_Bol.Date;
    end;
    if Lc_Boleto then Qr_Boleto.ParamByName('BLT_NUMERO').AsString := E_BuscaBoleto.Text;
    if Lc_Cliente then Qr_Boleto.ParamByName('EMP_FANTASIA').AsString := '%'+ E_Busca_Boleto_Empresa.Text +'%';
    Qr_Boleto.Active := True;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Receber_Multipla.PC_Buscar_Cheque(Pc_Tipo : String);
var
  It_Sql_Txt : string;
  Lc_Data, Lc_Boleto, Lc_Cliente : boolean;
begin
  Screen.Cursor:=crHourGlass;
  It_Sql_Txt := '';
  Qr_Cheques.Close;
  Qr_Cheques.Sql.Clear;

  It_Sql_Txt :='SELECT DISTINCT  *'+
           'FROM  TB_CHEQUES Tb_cheques '+
           '  WHERE (CHQ_CODIGO IS NOT NULL ) AND (CHQ_QT_REC =:CHQ_QT_REC) ';

  Qr_Cheques.SQL.add(It_Sql_Txt + 'Order By CHQ_EMITENTE ');

  Qr_Cheques.ParamByName('CHQ_QT_REC').AsInteger := It_Cd_Quitacao;
  Qr_Cheques.Active := True;
  Qr_Cheques.First;
  while not Qr_Cheques.Eof do
    Begin
    It_Cheque := It_Cheque +1 ;
    StrGrd_Cheque.RowCount := It_Cheque + 1;
    StrGrd_Cheque.Cells[1,It_Cheque] := Qr_Cheques.FieldByName('CHQ_CODIGO').AsString;
    StrGrd_Cheque.Cells[2,It_Cheque] := Qr_Cheques.FieldByName('CHQ_EMITENTE').AsString;
    StrGrd_Cheque.Cells[3,It_Cheque] := Qr_Cheques.FieldByName('CHQ_NR_BANCO').AsString;
    StrGrd_Cheque.Cells[4,It_Cheque] := Qr_Cheques.FieldByName('CHQ_AGENCIA').AsString;
    StrGrd_Cheque.Cells[5,It_Cheque] := Qr_Cheques.FieldByName('CHQ_NUMERO').AsString;
    StrGrd_Cheque.Cells[6,It_Cheque] := FloatToStrF(Qr_Cheques.FieldByName('CHQ_VALOR').AsCurrency,ffFixed,10,2);
    StrGrd_Cheque.Cells[7,It_Cheque] := Qr_Cheques.FieldByName('CHQ_DATA').AsString;
    StrGrd_Cheque.Cells[8,It_Cheque] := Qr_Cheques.FieldByName('CHQ_DEVOLVIDO').AsString;
    StrGrd_Cheque.Cells[9,It_Cheque] := Qr_Cheques.FieldByName('CHQ_DT_QUITACAO').AsString;
    StrGrd_Cheque.Cells[10,It_Cheque] := Qr_Cheques.FieldByName('CHQ_TIPO').AsString;
    StrGrd_Cheque.Cells[11,It_Cheque] := Qr_Cheques.FieldByName('CHQ_ESTADO').AsString;
    StrGrd_Cheque.Cells[12,It_Cheque] := Qr_Cheques.FieldByName('CHQ_RETORNO').AsString;
    StrGrd_Cheque.Cells[13,It_Cheque] := Qr_Cheques.FieldByName('CHQ_QT_REC').AsString;
    StrGrd_Cheque.Cells[14,It_Cheque] := Qr_Cheques.FieldByName('CHQ_QT_PAG').AsString;
    StrGrd_Cheque.Cells[15,It_Cheque] := Qr_Cheques.FieldByName('CHQ_CODIGO').AsString;
    StrGrd_Cheque.Cells[16,It_Cheque] := Qr_Cheques.FieldByName('CHQ_CONTA').AsString;
    Qr_Cheques.Next;
    end;
  Pc_Somar_Cheque;
  Screen.Cursor:=crDefault;
end;


procedure TFr_Receber_Multipla.TotalizaBaixa;
Begin
  It_VL_Mora := StrToFloatDef(E_VL_Mora.Text,0);
  It_VL_Juros := StrToFloatDef(E_VL_Juros.Text,0);
  It_VL_Desconto := StrToFloatDef(E_VL_Desconto.Text,0);

  if (It_Vl_Baixa < 0) then It_Vl_Baixa := 0;
  E_VL_Pagar.Text := FloatToStrF((It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto),ffFixed,10,2);
  if not E_VL_Pago.Focused then E_VL_Pago.Text := FloatToStrF(It_Vl_Pagto,ffFixed,10,2);

  if ((It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto) - (It_Vl_Pagto + It_Vl_Credito) >= 0) then
  Begin
    Lb_Saldo_Parcial.Font.Color := clNavy;
    E_Vl_Saldo.Caption := FloatToStrf((It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto) - (It_Vl_Pagto + It_Vl_Credito),ffFixed,10,2);
    E_vl_Saldo.Font.Color := clNavy;
  end
  else
  Begin
    Lb_Saldo_Parcial.Font.Color := clRed;
    E_Vl_Saldo.Caption := FloatToStrf((It_Vl_Pagto + It_Vl_Credito )- (It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto),ffFixed,10,2);
    E_vl_Saldo.Font.Color := clRed;
  end;
end;

procedure TFr_Receber_Multipla.TotalizaReceber;
Var
  LcValorReceber : Real;
  LcValorRecebido : REal;
  LcCredito : Real;
begin
  with Qr_Parcelas  do
  Begin
    LcValorReceber  := 0;
    LcValorRecebido := 0;
    LcCredito       := 0;

    First;
    while not Eof do
    Begin
      if FieldByName('FIN_OPERACAO').AsString = 'C' then
      Begin
        if FieldByName('FIN_BAIXA').AsString = 'N' then
          LcValorReceber   := LcValorReceber + FieldByNAme('FIN_VL_PARCELA').AsCurrency
        else
          LcValorReceber   := LcValorReceber + FieldByNAme('FIN_VL_PAGO').AsCurrency;

        if FieldByName('FIN_BAIXA').AsString = 'S' then
          LcValorRecebido   := LcValorRecebido + FieldByNAme('FIN_VL_PAGO').AsCurrency;
      End
      else
      Begin
        if FieldByName('FIN_BAIXA').AsString = 'N' then
          LcCredito := LcCredito + FieldByNAme('FIN_VL_PARCELA').AsCurrency
        else
          LcCredito := LcCredito + FieldByNAme('FIN_VL_PAGO').AsCurrency;
      End;
      Next;
    end;

    E_Vl_Receber.Caption        := FloattoStrF(LcValorReceber,ffNumber,10,2);
    E_Vl_Cred_Ceder.Caption     := FloattoStrF(LcCredito,ffNumber,10,2);
    E_Vl_Recebido.Caption       := FloattoStrF(LcValorRecebido,ffNumber,10,2);
    E_Vl_Total_Receber.Caption  := FloattoStrF(LcValorReceber -( LcCredito +LcValorRecebido),ffNumber,10,2);
    Lb_Titulo_totalizador.Caption := concat(' Totalizador do Contasá Receber - Registro(s): ', IntToStr(RecordCount));
  End;
end;

// Procedimento internos
procedure TFr_Receber_Multipla.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Pc_grava_Perfil_Local;
  FreeAndNil( FCartao );
  FreeAndNil( FBoleto );
  FreeAndNil( FCheque );
  FreeAndNil( FFinanceiro );
end;

procedure TFr_Receber_Multipla.FormCreate(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_FormataTela;
  Pc_ImagemBotao;
end;

procedure TFr_Receber_Multipla.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;


procedure TFr_Receber_Multipla.FormResize(Sender: TObject);
begin
  posicionaTotalizador
end;

procedure TFr_Receber_Multipla.Pc_Ativar_Tabelas;
Begin
  Fm_TipoCobranca.Pc_Listar(3,false,0);
  Fm_TipoCobranca.DBLCB_FormaPagto.KeyValue := null;
  Fm_TipoRecebimento.Pc_Listar(3,false,0);
  Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue := null;
  Fm_ListaVendedores.ListaVendedor;
end;


procedure TFr_Receber_Multipla.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;



procedure TFr_Receber_Multipla.Pc_Lancar_Banco;
Var
  Lc_Cta_Bancaria : Integer;
  Lc_VL_Credito, Lc_VL_Debito:Real;
  Lc_VL_Pago : Real;
  Lc_Troco : String;
  LfFormBanco : TFr_Lanca_Banco;
Begin
  Lc_Troco := '';
  Lc_VL_Pago := StrToFloatDef(E_VL_Pago.Text,0);
  // Verifica se os campos estão zerados
  if ( Lc_VL_Pago <> 0 ) then
  Begin
    if ( Lc_VL_Pago > 0 ) then
    begin
      Lc_VL_Credito := Lc_VL_Pago;
      Lc_VL_Debito := 0;
    end
    else
    Begin
      Lc_VL_Credito := 0;
      Lc_VL_Debito := Lc_VL_Pago * -1;
      Lc_Troco := 'Troco | ';
    End;
    Lc_Cta_Bancaria := 0;
    ShowDataBoleto;
    if FBoleto.exist then
      Lc_Cta_Bancaria := FBoleto.Registro.CodCtb;
      LfFormBanco := TFr_Lanca_Banco.Create(nil);
      Try
        LfFormBanco.Codigo           := 0;
        LfFormBanco.Quitacao         := It_Cd_Quitacao;
        LfFormBanco.Data             := Date;
        LfFormBanco.ContaCorrente    := Lc_Cta_Bancaria;
        LfFormBanco.Operacao         := 'I';
        LfFormBanco.PlanoResultado   := cds_duplicatasPLC_CODIGO.AsInteger;
        LfFormBanco.PlanoCentroCusto := cds_duplicatasPLC_CODIGO.AsInteger;
        LfFormBanco.Historico        := Copy(Lc_Troco + Fc_Preencher_Historico,1,100);
        LfFormBanco.HistoricoBanco   := 0;
        LfFormBanco.ValorCredito     := Lc_Vl_Credito;
        LfFormBanco.ValorDebito      := Lc_Vl_DEbito;
        LfFormBanco.FormaPagto       := Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue;
        LfFormBanco.Mensagem         := True;
        LfFormBanco.LiberaCampo      := False;
        LfFormBanco.AutoFill;
        LfFormBanco.ShowModal;
        it_BaixaOK := LfFormBanco.Resultado;
      Finally
        FreeAndNil(LfFormBanco);
      End;
    // Verifica se a conta utilizada foi a mesma conta informada no boleto, caso contrario altera
    if FBoleto.exist then
      if Lc_Cta_Bancaria <> FBoleto.Registro.CodCtb then
      Begin
        FBoleto.Registro.CodCtb := Lc_Cta_Bancaria;
        FBoleto.Update;
      End;
  End;
end;

procedure TFr_Receber_Multipla.E_VL_JurosExit(Sender: TObject);
begin
  TotalizaBaixa;
  E_VL_Juros.Text := FloatToStrF(It_Vl_Juros, ffFixed, 10,2);
end;

procedure TFr_Receber_Multipla.E_VL_MoraExit(Sender: TObject);
begin
  TotalizaBaixa;
  E_VL_Mora.Text := FloatToStrF(It_Vl_Mora, ffFixed, 10,2);
end;

procedure TFr_Receber_Multipla.E_VL_DescontoExit(Sender: TObject);
begin
  It_VL_Desconto := StrToFloatDef(E_VL_Desconto.Text,0);
  TotalizaBaixa;
end;

procedure TFr_Receber_Multipla.E_VL_JurosEnter(Sender: TObject);
begin
  E_VL_Juros.SelectAll;
end;

procedure TFr_Receber_Multipla.E_VL_MoraEnter(Sender: TObject);
begin
  E_VL_Mora.SelectAll;
end;

procedure TFr_Receber_Multipla.E_VL_DescontoEnter(Sender: TObject);
begin
  E_VL_Desconto.SelectAll;
end;

procedure TFr_Receber_Multipla.Pc_Adicionar_Tudo;
Var
  I : Integer;
begin
  IF (It_TipoTransacao = 'BAIXADAS') then Exit;
  IF (It_TipoTransacao = 'DESTINADAS') then Pc_Buscar_Parcela('D') ;
  if ( Qr_Parcelas.RecordCount = 0 ) OR   ( cds_ParcelasFIN_BAIXA.asString = 'S' ) then exit;
  if ( Qr_Parcelas.RecordCount = 0 ) then exit;
  It_Cd_Empresa := cds_ParcelasFIN_CODEMP.AsInteger;
  IF (It_TipoTransacao <> 'DESTINADAS') then Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  if ( Qr_Parcelas.RecordCount = 0 ) then exit;
  Dbg_Duplicatas.Visible := False;
  with cds_Parcelas  do
  Begin
    if not cds_duplicatas.active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.LogChanges := False;
    cds_duplicatas.EmptyDataSet;
    First;
    while not Eof do
    Begin
      cds_duplicatas.Append;
      For I:= 0 to FieldCount -1 do
        cds_duplicatas.Fields[I].Value := Fields[I].Value;
      cds_duplicatas.Post;
      Next;
    end;
  End;
  Dbg_Duplicatas.Visible := True;
  cds_duplicatas.LogChanges := True;

  It_Cd_FmaPagto := cds_duplicatasFIN_CODFPG.AsInteger;
  Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue := It_Cd_FmaPagto;
  IF (It_TipoTransacao = 'DESTINADAS') then
  Begin
    IF Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'BOLETO' then
    Begin
      Pg_Controle.ActivePageIndex := 2;
      Pc_BuscaBoleto('D');
      ShowDataBoleto;
      FEditionStateBoleto := 'B';
      EditionControlBoleto;
    end;
    IF Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'CHEQUE' then
    Begin
      Pc_LimpaStringGrid(StrGrd_Cheque);
      It_Cheque := 0;
      Pg_Controle.ActivePageIndex := 1;
      Pc_Buscar_Cheque('D');
    end;
    IF Fc_ValidaBaixaCartao then
    Begin
      Pg_Controle.ActivePageIndex := 3;
      GetCartao;
      ShowCartao;
    end;
  end;
  Pc_Define_Valores_Baixa;
  TotalizaBaixa;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
end;

procedure TFr_Receber_Multipla.SB_Retirar_TudoClick(Sender: TObject);
begin
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.EmptyDataSet;
  It_Cd_Empresa := 0;
  Pc_Define_Valores_Baixa;
  TotalizaBaixa;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  Pc_Ativar_Botoes;
end;

procedure TFr_Receber_Multipla.SB_RetirarClick(Sender: TObject);
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
  Lc_Parcela : Integer;
begin
  if cds_duplicatas.Active then
  Begin
    if cds_duplicatas.RecordCount > 0 then
    Begin
      cds_duplicatas.Delete;
      if cds_duplicatas.RecordCount = 0 then
        It_Cd_Empresa := 0;
      Pc_Define_Valores_Baixa;
      TotalizaBaixa;
      Pc_Buscar_Parcela('N');
      Pc_Preencher_Parcelas;
      TotalizaReceber;
      Pc_Ativar_Botoes;
    End;
  End;
end;

procedure TFr_Receber_Multipla.Qr_NegociacaoAfterScroll(DataSet: TDataSet);
begin
  TotalizaBaixa;

end;

procedure TFr_Receber_Multipla.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Pg_Controle.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if Sb_Inserir.Enabled then Sb_InserirClick(Sender);
        VK_F3  : if Sb_Duplicata.Enabled then Sb_DuplicataClick(Sender);
        VK_F4  : if Sb_Cartao.Enabled then Sb_CartaoClick(Sender);
        VK_F5  : if Sb_Cheque.Enabled then Sb_ChequeClick(Sender);
        VK_F6  : if SB_Boleto.Enabled then SB_BoletoClick(Sender);
        VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
        VK_F8  : if Sb_Destinar.Enabled then Sb_DestinarClick(Sender);
        VK_F9  : if Sb_Baixar.Enabled then Sb_BaixarClick(Sender);
        VK_F10  : if Sb_Negociar.Enabled then Sb_NegociarClick(Sender);
        VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end;
  1:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if Sb_InsereCheque.Enabled then Sb_InsereChequeClick(Sender);
        VK_F3  : if Sb_AlteraCheque.Enabled then Sb_AlteraChequeClick(Sender);
        VK_F4  : if Sb_ExcluiCheque.Enabled then Sb_ExcluiChequeClick(Sender);
        VK_F5  : if Sb_GravaCheque.Enabled then Sb_GravaChequeClick(Sender);
        VK_F6  : if Sb_CancelaCheque.Enabled then Sb_CancelaChequeClick(Sender);
        VK_F8  : if Sb_Destinar.Enabled then Sb_DestinarClick(Sender);
        VK_F9  : if Sb_Baixar.Enabled then Sb_BaixarClick(Sender);
        VK_Escape : if Sb_VoltaCheque.Enabled then Sb_VoltaChequeClick(Sender);
        end;
      end;
    end;
   2:begin
    if shift = [] then
      begin
      case Key of
      VK_F2  : if Sb_InsereBoleto.Enabled then Sb_InsereBoletoClick(Sender);
      VK_F3  : if Sb_AlteraBoleto.Enabled then Sb_AlteraBoletoClick(Sender);
      VK_F4  : if Sb_ExcluiBoleto.Enabled then Sb_ExcluiBoletoClick(Sender);
      VK_F5  : if Sb_GravaBoleto.Enabled then Sb_GravaBoletoClick(Sender);
      VK_F6  : if Sb_CancelaBoleto.Enabled then Sb_CancelaBoletoClick(Sender);
      VK_F7  : if Sb_BuscaBoleto.Enabled then Sb_BuscaBoletoClick(Sender);
      VK_F8  : if Sb_Destinar.Enabled then Sb_DestinarClick(Sender);
      VK_F9  : if Sb_Baixar.Enabled then Sb_BaixarClick(Sender);
      VK_Escape : if Sb_VoltaBoleto.Enabled then Sb_VoltaBoletoClick(Sender);
      end;
      end;
    end;
   else
    begin
    if shift = [] then
      begin
      case Key of
      VK_F2  : if Sb_InsereCartao.Enabled then Sb_InsereCartaoClick(Sender);
      VK_F3  : if Sb_AlteraCartao.Enabled then Sb_AlteraCartaoClick(Sender);
      VK_F4  : if Sb_ExcluiCartao.Enabled then Sb_ExcluiCartaoClick(Sender);
      VK_F5  : if Sb_GravarCartao.Enabled then Sb_GravarCartaoClick(Sender);
      VK_F6  : if Sb_CancelarCartao.Enabled then Sb_CancelarCartaoClick(Sender);
      VK_F8  : if Sb_Destinar.Enabled then Sb_DestinarClick(Sender);
      VK_F9  : if Sb_Baixar.Enabled then Sb_BaixarClick(Sender);
      VK_Escape : if Sb_VoltarCartao.Enabled then Sb_VoltaBoletoClick(Sender);
      end;
      end;
    end;
  end;

end;
procedure TFr_Receber_Multipla.SB_BuscarClick(Sender: TObject);
begin
  try
    if Pg_Controle.ActivePageIndex = 0 then  Fm_TipoCobranca.DBLCB_formaPagto.SetFocus;
    Pc_ProcesoAguarde(Self, 'I');
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaReceber;
  finally
    Pc_ProcesoAguarde(Self, 'F');
  end;


end;

procedure TFr_Receber_Multipla.Pc_Adicionar;
Var
  I : Integer;
begin
  It_Cd_Empresa   := cds_ParcelasFIN_CODEMP.AsInteger;
  if not cds_duplicatas.active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.Append;
  For I:= 0 to cds_Parcelas.FieldCount -1 do
    cds_duplicatas.Fields[I].Value := cds_Parcelas.Fields[I].Value;
  cds_duplicatas.Post;
  Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue := cds_duplicatasFIN_CODFPG.AsInteger;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  Pc_Define_Valores_Baixa;
  TotalizaBaixa;
end;

procedure TFr_Receber_Multipla.Sb_ChequeClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 1;
  Sb_InsereChequeClick(Self);
end;

procedure TFr_Receber_Multipla.SB_BoletoClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 2;
  Sb_InsereBoletoClick(Self);
end;

procedure TFr_Receber_Multipla.E_VL_ChequeExit(Sender: TObject);
Var
  Lc_Vl_Cheque : Real;
begin
  Lc_Vl_Cheque := StrToFloatDef(E_VL_Cheque.Text,0);
  E_VL_Cheque.Text := FloatToStrF(Lc_Vl_Cheque,ffFixed,10,2);
end;



procedure TFr_Receber_Multipla.StrGrd_ChequeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  : if Sb_ExcluiCheque.Enabled then Sb_ExcluiChequeClick(Sender);
  end;
 end;

procedure TFr_Receber_Multipla.Sb_InsereBoletoClick(Sender: TObject);
begin
  if ValidaInsertBoleto then
  Begin
    FEditionStateBoleto := 'I';
    EditionControlBoleto;
    InsertBoleto;
  End;
end;

procedure TFr_Receber_Multipla.Sb_AlteraBoletoClick(Sender: TObject);
begin
  if ValidateChangeBoleto then
  Begin
    FEditionStateBoleto := 'E';
    EditionControlBoleto;
    ChangeBoleto;
  End;
end;

procedure TFr_Receber_Multipla.Sb_ExcluiBoletoClick(Sender: TObject);
begin
  if ValidateDeleteBoleto then
  Begin
    DeleteBoleto;
    FEditionStateBoleto := 'B';
    EditionControlBoleto;
    Sb_BuscaBoletoClick(sender);
  End;
end;

procedure TFr_Receber_Multipla.Sb_GravaBoletoClick(Sender: TObject);
vAR
  Lc_estado : Boolean;
begin
  if ValidateSaveBoleto then
  Begin
    SaveBoleto;
    if (FEditionStateBoleto = 'I') then  Sb_DestinarClick(Sender);
    Pc_BuscaBoleto('N');
    FEditionStateBoleto := 'B';
    EditionControlBoleto;
    DBLCB_CarteiraCobranca.KeyValue := FBoleto.Registro.Codble;
  End;
end;

procedure TFr_Receber_Multipla.Sb_CancelaBoletoClick(Sender: TObject);
begin
  if ValidateCancelBoleto then
  Begin
    CancelBoleto;
    FEditionStateBoleto := 'B';
    EditionControlBoleto;
  End;
end;

procedure TFr_Receber_Multipla.Sb_BuscaBoletoClick(Sender: TObject);
begin
  Pc_BuscaBoleto('N');
end;

procedure TFr_Receber_Multipla.Sb_VoltaBoletoClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 0;
  SB_Retirar_TudoClick(sender);
end;

procedure TFr_Receber_Multipla.DeleteBoleto;
begin
  FBoleto.delete;
end;

Function TFr_Receber_Multipla.Fc_ValidaGravacaoCheque():Boolean;
Var
  Lc_I : Integer;
Begin
  Result := True;
  if trim(E_Emitente.Text) = '' then
    begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo emitente.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Emitente.SetFocus;
    Result := False;
    exit;
    end;

  if trim(E_Banco.Text) = '' then
    begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo número do Banco.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Banco.SetFocus;
    Result := False;
    exit;
    end;

  if trim(E_Agencia.Text) = '' then
    begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo agência.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Agencia.SetFocus;
    Result := False;
    exit;
    end;

  if trim(E_NumChq.Text) = '' then
    begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo número do cheque.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_NumChq.SetFocus;
    Result := False;
    exit;
    end;

  if trim(E_VL_Cheque.Text) = '' then
    begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo valor do cheque.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_VL_Cheque.SetFocus;
    Result := False;
    exit;
    end;

  if trim(E_ContaCorrente.Text) <> '' then
    begin
    if not Fc_VerificaDuplicacaoCheque(It_cd_Cheque,E_Banco.Text,E_Agencia.Text,E_ContaCorrente.Text,E_NumChq.Text) then
      Begin
      Result := False;
      exit;
      end;

    For Lc_I := 1 to StrGrd_Cheque.RowCount -1 do
      Begin
      if (Trim(E_Banco.Text)   = StrGrd_Cheque.Cells[3,Lc_I]) and
         (Trim(E_NumChq.Text)  = StrGrd_Cheque.Cells[5,Lc_I]) and
         (Trim(E_Agencia.Text) = StrGrd_Cheque.Cells[4,Lc_I]) and
         (Trim(E_ContaCorrente.Text) = StrGrd_Cheque.Cells[16,Lc_I]) and
         (it_Oper_Reg_Chq = 'I') then
        begin
        MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                       ' JÁ existe este cheque na lista digitada abaixo.' + EOLN +
                       ' Verifique Nr. Banco, Nr. Agência, Nr. Conta, e Nr. de Cheque.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := False;
        exit;
        end;
      end;
    end;
end;

procedure TFr_Receber_Multipla.Sb_GravaChequeClick(Sender: TObject);
begin
  if Fc_ValidaGravacaoCheque then
    Begin
    if it_Oper_Reg_Chq = 'I' then
      Begin
      It_Cheque := It_Cheque +1 ;
      StrGrd_Cheque.RowCount := It_Cheque + 1;
      StrGrd_Cheque.Cells[1,It_Cheque] := '';
      StrGrd_Cheque.Cells[2,It_Cheque] := E_Emitente.Text;
      StrGrd_Cheque.Cells[3,It_Cheque] := E_Banco.Text;
      StrGrd_Cheque.Cells[4,It_Cheque] := E_Agencia.Text;
      StrGrd_Cheque.Cells[5,It_Cheque] := E_NumChq.Text;
      StrGrd_Cheque.Cells[6,It_Cheque] := E_VL_Cheque.Text;
      StrGrd_Cheque.Cells[7,It_Cheque] := DateToStr(E_DataCheque.Date);
      StrGrd_Cheque.Cells[16,It_Cheque] := E_ContaCorrente.Text;
      end
    else
      Begin
      StrGrd_Cheque.Cells[1,it_Reg_Atl_chq] := '';
      StrGrd_Cheque.Cells[2,it_Reg_Atl_chq] := E_Emitente.Text;
      StrGrd_Cheque.Cells[3,it_Reg_Atl_chq] := E_Banco.Text;
      StrGrd_Cheque.Cells[4,it_Reg_Atl_chq] := E_Agencia.Text;
      StrGrd_Cheque.Cells[5,it_Reg_Atl_chq] := E_NumChq.Text;
      StrGrd_Cheque.Cells[6,it_Reg_Atl_chq] := E_VL_Cheque.Text;
      StrGrd_Cheque.Cells[7,it_Reg_Atl_chq] := DateToStr(E_DataCheque.Date);
      StrGrd_Cheque.Cells[16,it_Reg_Atl_chq] := E_ContaCorrente.Text;
      end;
    Pc_Limpar_Campo_Cheque;
    Pc_Somar_Cheque;
    Pc_Liberar_Campo_Cheque(False);
    end;
end;

procedure TFr_Receber_Multipla.Sb_InsereChequeClick(Sender: TObject);
begin
  Pc_Limpar_Campo_Cheque;
  Pc_Liberar_Campo_Cheque(true);
  it_Oper_Reg_Chq := 'I';
  E_Emitente.SetFocus;
  E_Emitente.Text := Copy(cds_duplicatasEMP_NOME.AsString ,1,40);
end;

procedure TFr_Receber_Multipla.Sb_AlteraChequeClick(Sender: TObject);
begin
  it_Oper_Reg_Chq := 'E';
  Pc_Liberar_Campo_Cheque(True);
  Pc_Preencher_Campo_Cheque;
  E_Emitente.SetFocus;
end;

procedure TFr_Receber_Multipla.Sb_CancelaChequeClick(Sender: TObject);
begin
  Pc_Limpar_Campo_Cheque;
  Pc_Liberar_Campo_Cheque(False);
end;

procedure TFr_Receber_Multipla.Sb_VoltaChequeClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 0;
end;

procedure TFr_Receber_Multipla.Sb_DestinarClick(Sender: TObject);
begin
  try
    Pc_Destinar('D');
    //Quando o destinação for em carteira limpar a grid
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Documentos Destinados com Sucesso.'+EOLN+
                   'Código da Destinação: '+IntToStr(It_Cd_Quitacao) +EOLN,
                   ['OK'],[bEscape],mpInformacao);
    if (Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'BOLETO') or
       (Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'CHEQUE') or
       (Fc_ValidaBaixaCartao) THEN SB_Retirar_TudoClick(Sender);
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a Destinação dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Receber_Multipla.Sb_ExcluiChequeClick(Sender: TObject);
var
  Cheque : TControllerCheque;
begin
  IF StrGrd_Cheque.Cells[2,StrGrd_Cheque.Row] = '' THEN Exit;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+StrGrd_Cheque.Cells[2,StrGrd_Cheque.Row]+' desta venda.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
  IF StrGrd_Cheque.Cells[1,StrGrd_Cheque.Row] = '' THEN
    Pc_Deletar_Cheque
  else
  Begin
    Try
      Cheque := TControllerCheque.Create(nil);
      with Cheque.Registro do
      Begin
        Codigo := StrToIntdef( StrGrd_Cheque.Cells[1,StrGrd_Cheque.row],0);
        CodigoEstabelecimento := Gb_CodMha;
      End;
      Cheque.delete;
      Pc_Deletar_Cheque;
    Finally
      FreeAndNil(Cheque);
    End;
  end;
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Receber_Multipla.Pc_Processo_Movim_Financeiro;
Var
  Lc_Escolha: Integer;
Begin
  it_BaixaOK := False;
  if (It_Vl_Pagto <> 0) then
  Begin
    IF ( cds_duplicatasFIN_ETAPA.AsString = 'N') then
    Begin
      //Se a etapa de Baixa for normal
      Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                    'Baixar as Duplicatas Selecionadas.'+EOLN+EOLN+
                                    'Confirmar a Baixa ?',
                                    ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
      IF It_Cd_Quitacao = 0 THEN It_Cd_Quitacao := Fc_GeraCod_BAixa;
      case Lc_Escolha of
        0:Pc_Lancar_Caixa;
        1:Pc_Lancar_Banco;
        2:Exit;
      end;
    end
    else
    Begin
      it_BaixaOK := True;
    end;
  end
  else
  Begin
    it_BaixaOK := True;
  end;
end;

procedure TFr_Receber_Multipla.Pc_Processo_Baixa_Cartao;
Var
  Lc_Escolha: Integer;
Begin
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Baixar as Duplicatas com o Cartão infomardo ?'+EOLN+
                                'O Sistema lancaré os valores conforme Contrato.'+EOLN+
                                'Confirmar a Baixa ?',
                                ['Confirmar','Cancelar'],[bEscape,bNormal],mpConfirmacao,clBtnFace));
  if Lc_Escolha = 0 then
  Begin
    IF It_Cd_Quitacao = 0 then It_Cd_Quitacao := Fc_GeraCod_BAixa;
    PC_Lancar_Pagto_Cartao;
    it_BaixaOK := True;
  end
  else
  Begin
    it_BaixaOK := False;
  end;
end;

function TFr_Receber_Multipla.Fc_ValidaBaixaCartao():Boolean;
Var
  Lc_Aux : String;
  Contrato : Boolean;
Begin
  Result := False;
  Lc_Aux := Fm_TipoRecebimento.DBLCB_formaPagto.Text;
  if (Length(Lc_Aux)>0 ) then
  Begin
    FCartao.Eletronico.Registro.FormaPagamento := Fm_TipoRecebimento.DBLCB_formaPagto.keyValue;
    FCartao.Eletronico.Registro.FormaPagamento := Fm_TipoRecebimento.DBLCB_formaPagto.keyValue;
    FCartao.Eletronico.getbyFormaPagto;
    if ( FCartao.Eletronico.exist ) or
       ((pos(Lc_Aux,'CARTÃO') > 0) or (pos(Lc_Aux,'CARTAO') > 0)) then
    Begin
      Result := True;
    End
   End;
End;

procedure TFr_Receber_Multipla.Sb_BaixarClick(Sender: TObject);
Var
  LcTefAtivo : Boolean;
Label
  lbBaixa;
begin
  if Fc_validar_Baixa then
  Begin
    Pc_Destinar('B');
    LcTefAtivo := ( Fc_Aq_Geral('L','TEF','TEF_LC_ATIVO','N') = 'S');
    if LcTefAtivo then
    begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Deseja efetuar a baixa através do T.E.F?' + EOLN + EOLN +
                         'Confirmar a operação ?',
                         [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
      Begin
        baixaComTEF;
        Goto lbBaixa;
      End;
    End;

    if Fc_ValidaBaixaCartao then
    Begin
      Pc_Processo_Baixa_Cartao;
    End
    else
    Begin
      Pc_Processo_Movim_Financeiro;
    End;
  End;

lbBaixa:
  try
    if it_BaixaOK then Pc_Processo_Baixa;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não foi possível baixar as Duplicatas.'+EOLN+
                   'Verifique os valores informados e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Receber_Multipla.DBG_BoletoDblClick(Sender: TObject);
Var
  Lc_I, Lc_J : Integer;
begin
  IF Qr_Boleto.RecordCount > 0 THEN
  Begin
    if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.EmptyDataSet;
    It_TipoTransacao := 'DESTINADAS';
    It_Cd_Empresa := QR_Boleto.FieldByName('BLT_CODEMP').AsInteger;
    It_Cd_Quitacao := Qr_Boleto.FieldByName('BLT_CODQTC').AsInteger;
    Pc_Adicionar_Tudo;
    Pc_Ativar_Botoes;
    E_Dt_Pagto.Date := date;
  End;
end;

procedure TFr_Receber_Multipla.Dbg_DuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ( TDBGrid(Sender).DataSource.DataSet.FieldByName('FIN_OPERACAO').AsString = 'C' ) then
    TDBGrid(Sender).Canvas.Font.Color := clBlack
  else
    TDBGrid(Sender).Canvas.Font.Color := clRed;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFr_Receber_Multipla.Dbg_ParcelaDblClick(Sender: TObject);
begin
  Pc_Verificar_Situacao;
  if It_TipoTransacao = 'DESTINADAS' then
    SB_Add_TudoClick(Sender);
  if It_TipoTransacao = 'NORMAL' then
    SB_AdicionarClick(Sender);
  Pc_Ativar_Botoes;

end;

procedure TFr_Receber_Multipla.Dbg_ParcelaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ( TDBGrid(Sender).DataSource.DataSet.FieldByName('FIN_OPERACAO').AsString = 'C' ) then
    TDBGrid(Sender).Canvas.Font.Color := clBlack
  else
    TDBGrid(Sender).Canvas.Font.Color := clRed;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TFr_Receber_Multipla.Dbg_ParcelaTitleClick(Column: TColumn);
begin
  SortClientDataSetByField(cds_Parcelas,Column.FieldName, True);
end;



procedure TFr_Receber_Multipla.StrGrd_ChequeDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
  if (StrGrd_Cheque.Cells[14,arow]='X') then
    begin // verifica se a linha impar
    StrGrd_Cheque.Canvas.Font.Color:= clBlack;
    StrGrd_Cheque.Canvas.Brush.Color:= clBtnFace;
    end
  else
    begin
    StrGrd_Cheque.Canvas.Font.Color:= clBlack;
    StrGrd_Cheque.Canvas.Brush.Color:= clMoneyGreen;
    end;
  StrGrd_Cheque.Canvas.FillRect(Rect); // redesenha a celula
  StrGrd_Cheque.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Cheque.Cells[acol,arow]); // reimprime o texto.

  { Pega o texto da célula }
  Texto := StrGrd_Cheque.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Cheque.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Cheque.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
  if  (ACol = 0) or (ACol = 1) or (ACol = 2) or (ACol = 3) or (ACol = 4)then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 7) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;

  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Cheque.Canvas.TextRect(Rect, X, Y, Texto);
end;

procedure TFr_Receber_Multipla.Sb_InsereCartaoClick(Sender: TObject);
begin
  EditionStateCartao := 'I';
  EditionControlCartao;
  DM.Qr_Cartao.Active := True;
  if Fm_TipoRecebimento.DBLCB_FormaPagto.Text <> '' then
  Begin
    FCartao.Eletronico.Registro.FormaPagamento := Fm_TipoRecebimento.DBLCB_FormaPagto.KeyValue;
    FCartao.Eletronico.getbyFormaPagto;
    DBLCB_Cartao.KeyValue := FCartao.Eletronico.Registro.Codigo;
  End;
 DBLCB_Cartao.SetFocus;
end;

procedure TFr_Receber_Multipla.Sb_AlteraCartaoClick(Sender: TObject);
begin
  EditionStateCartao := 'E';
  EditionControlCartao;
  DBLCB_Cartao.SetFocus;
end;

procedure TFr_Receber_Multipla.Sb_ExcluiCartaoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir '+DBLCB_Cartao.Text +' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      FCartao.Delete;
      ClearCartao;
      EditionStateCartao := 'B';
      EditionControlCartao;

    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;
end;

function TFr_Receber_Multipla.ValidaGravaCartao:Boolean;
Begin
 Result := True;
  if Trim(DBLCB_Cartao.Text) = ''  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe a bandeira do cartão.'+EOLN+
                   'Este campo deve ser preenchido.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if DBLCB_Cartao.CanFocus then DBLCB_Cartao.SetFocus;
    exit;
  end;

  if Trim(E_Parcelas.Text) = ''  then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Informe o número de parcelas.'+EOLN+
                   'Este campo deve ser preenchido.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if E_Parcelas.CanFocus then E_Parcelas.SetFocus;
    exit;
  end;
end;

function TFr_Receber_Multipla.ValidaInsertBoleto: Boolean;
begin
  Result := True;
end;

function TFr_Receber_Multipla.ValidaRecalcularComissao: boolean;
begin
  Result := True;
  if (Fc_Tb_Geral('L','TP_COMISSAO','') <> 'R') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'A comissao nao esta configurada para ser calculada neste momento.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;
  if not cds_Parcelas.Active then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor efetue alguma busca.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;

  End;

  if cds_Parcelas.RecordCount = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nenhum registro encontrado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;

  if cds_ParcelasFIN_BAIXA.AsString <> 'S' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Essa operacao só é permitida para documentos baixados.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;

end;

function TFr_Receber_Multipla.ValidateCancelBoleto: boolean;
begin
  Result := True;
end;

function TFr_Receber_Multipla.ValidateChangeBoleto: boolean;
begin
  Result := true;
  if not FBoleto.exist then
  Begin
    TMsgSetes.PararExecucao('Registro de boleto não encontrato');
    Result := False;
    exit;
  End;
end;

function TFr_Receber_Multipla.ValidateDeleteBoleto: boolean;
begin
  Result := True;
  ShowDataBoleto;
  if not FBoleto.exist then
  Begin
    TMsgSetes.PararExecucao('Registro de boleto não encontrato');
    Result := False;
    exit;
  End;

  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;
end;

function TFr_Receber_Multipla.ValidateSaveBoleto: boolean;
begin
  Result:=true;
  if  trim(DBLCB_CarteiraCobranca.Text) ='' then
  begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Por favor informe a carteira de Cobrança.' + EOLN +
                   ' Escolha e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result:=false;
    DBLCB_CarteiraCobranca.SetFocus;
    exit;
  end;

end;

procedure TFr_Receber_Multipla.Sb_GravarCartaoClick(Sender: TObject);
begin
  if ValidaGravaCartao then
  Begin
    GravaCartao;
    EditionStateCartao := 'B';
    EditionControlCartao;
  end;
end;

procedure TFr_Receber_Multipla.Sb_CancelarCartaoClick(Sender: TObject);
begin
  EditionStateCartao := 'B';
  EditionControlCartao;
end;

procedure TFr_Receber_Multipla.Sb_VoltarCartaoClick(Sender: TObject);
begin
  ClearCartao;
  Pg_Controle.ActivePageIndex := 0;
end;

procedure TFr_Receber_Multipla.ShowCartao;
begin
  EditionStateCartao := 'B';
  EditionControlCartao;
  DM.Qr_Cartao.Active := True;
  if FCartao.Registro.CodigoCartao >0 then
  Begin
    DBLCB_Cartao.KeyValue := Fcartao.Registro.CodigoCartao;
    E_Identifica.Text := Fcartao.Registro.Identificacao;
    E_Autoriza.Text := Fcartao.Registro.Autorizacao;
    if Fcartao.Registro.Validade > 0 then
      E_Validade.Text := DateToStr(Fcartao.Registro.Validade)
    else
      E_Validade.Clear;
    E_Parcelas.Text := Fcartao.Registro.NumeroParcela.ToString;
  End
end;

procedure TFr_Receber_Multipla.ShowDataBoleto;
begin
  DBLCB_CarteiraCobranca.KeyValue := Null;
  E_NumBoleto.Clear;
  E_Blt_Vencimento.Date := Date;
  E_VL_Pagar.Text := '0,00';
  E_Vl_Tarifa.Text := '0,00';
  RG_Descontada.ItemIndex := 0;
  if (Qr_Boleto.active) then
  Begin
    FBoleto.Registro.Codigo := Qr_Boleto.FieldByName('BLT_CODIGO').AsInteger;
    FBoleto.Registro.Codemp := Qr_Boleto.FieldByName('BLT_CODEMP').AsInteger;
    FBoleto.getByKey;
    if FBoleto.exist then
    Begin
      DBLCB_CarteiraCobranca.KeyValue := FBoleto.Registro.Codble;
      E_NumBoleto.Text :=  FBoleto.Registro.Numero;
      E_Blt_Vencimento.Date := FBoleto.Registro.DtVenc;
      E_VL_Pagar.Text := FloatToStrF(FBoleto.Registro.Valor,ffFixed,10,2);
      E_Vl_Tarifa.Text := FloatTosTrF(FBoleto.Registro.VlTarifa,ffFixed,10,2);
      RG_Descontada.ItemIndex := StrTOIntDef(FBoleto.Registro.Desconto,0);
    End
  End;
end;

procedure TFr_Receber_Multipla.SortClientDataSetByField(cds: TClientDataSet;
  FieldName: String; Direction: Boolean);
const
  IndexName = 'GridSort';

var
  i: integer;
  index: TIndexDef;
  OldOrder: string;
  IndexOptions : TIndexOptions;
  Options: TSortByFieldOptions;
begin
  cds.DisableControls;
  try
    i := cds.IndexDefs.IndexOf(IndexName);
    if i <> - 1  then
    begin
      index := cds.IndexDefs.Find(IndexName);
      OldOrder := index.Fields;
      try
        cds.DeleteIndex(IndexName);
      except;
        OutputDebugString('no index?');
        //there seem to be conditions where the index does not exist but
      end;
      index.Free; //delete index for some reason does not free the index
      indexOptions := index.Options;
    end else
      IndexOptions := [ixDescending];

    index := cds.IndexDefs.AddIndexDef;
    index.Name := IndexName;
    index.Fields := FieldName;
    if Direction then
      Options :=  [ForceAscending]
    else
      Options := [ForceDescending];

    if ForceAscending in Options then
      index.Options := []
    else if ForceDescending in Options then
      index.Options := [ixDescending]
    else if OldOrder = FieldName  then
    begin
      if (IndexOptions = [ixDescending]) then
        index.Options := []
      else
        index.Options := [ixDescending];
    end;
    cds.IndexName := IndexName;
  finally
    cds.EnableControls;
  end;
end;

procedure TFr_Receber_Multipla.Sb_CartaoClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 3;
  GetCartao;
  ShowCartao;
end;

procedure TFr_Receber_Multipla.Sb_DuplicataClick(Sender: TObject);
begin
  Pc_Imprime_Duplicata( cds_ParcelasNFL_CODIGO.AsInteger);
end;

procedure TFr_Receber_Multipla.RecalcularComissao;
Var
  Lc_I : Integer;
  Lc_cd_Financeiro : Integer;
  Lc_cd_Pedido : Integer;
Begin
  Pc_Construtor_Comissao(DM.IB_Transacao);
  Try
    Lc_cd_Financeiro := cds_ParcelasFIN_CODIGO.AsInteger;
    Lc_Cd_Pedido     := cds_ParcelasPED_CODIGO.AsInteger;

    FComissao.Parametros.FieldName.Pedido := Lc_Cd_Pedido;
    FComissao.Parametros.FieldName.Financeiro := Lc_Cd_Financeiro;
    FComissao.deleteByFinanceiro;

    Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Lc_cd_Pedido);
    Pc_Gerar_Comissao_Vda_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
    Pc_Gerar_Comissao_Srv_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
    Pc_Gerar_Comissao_Srv_Vdo_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
  Finally
    Pc_Destrutor_Comissao;
  End;

end;

procedure TFr_Receber_Multipla.RetirarDestinao1Click(Sender: TObject);
begin
  Pc_Retirar_Destinacao( cds_ParcelasFIN_CODIGO.AsInteger);
end;

procedure TFr_Receber_Multipla.ChBx_NomeClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
  Begin
    Dbg_Parcela.Columns[7].Visible := False;
    Dbg_Duplicatas.Columns[7].Visible := False;

    Dbg_Parcela.Columns[8].Visible := TRue;
    Dbg_Duplicatas.Columns[8].Visible := True;

    ChBx_Fantasia.Checked := False;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaReceber;
    ChBx_Nome.Enabled := False;
    ChBx_Fantasia.Checked := False;
    ChBx_Fantasia.Enabled := True;

  end;
end;

procedure TFr_Receber_Multipla.ChBx_FantasiaClick(Sender: TObject);
begin
  if ChBx_Fantasia.Checked then
  Begin
    Dbg_Parcela.Columns[7].Visible := True;
    Dbg_Duplicatas.Columns[7].Visible := True;

    Dbg_Parcela.Columns[8].Visible := FAlse;
    Dbg_Duplicatas.Columns[8].Visible := FAlse;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaReceber;
    ChBx_Nome.enabled := True;
    ChBx_Nome.Checked := False;
    ChBx_Fantasia.enabled := False;
  end;
end;

procedure TFr_Receber_Multipla.Sb_NegociarClick(Sender: TObject);
Var
  Lc_Form : TFr_Negociar;
begin
  if Fc_Valida_Negociacao then
  Begin
    Lc_Form := TFr_Negociar.Create(NIL);
    Try
      Lc_Form.It_Ctrl_Tela := 'Fr_Receber_Multipla';
      Lc_Form.cds_Financeiro.Data := cds_duplicatas.data;
      Lc_Form.It_Cd_Empresa := It_Cd_Empresa;
      Lc_Form.It_Dt_Emissao := Date;
      Lc_Form.E_VL_Doc.Text := E_VL_Pagar.Text;
      if Fm_TipoRecebimento.DBLCB_formaPagto.Text = '' then
        Lc_Form.It_FormaPagto := Fc_PegaParteFormaPgto('CARTEIRA')
      else
        Lc_Form.It_FormaPagto := Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
      SB_Retirar_TudoClick(Self);
    End;
  end;
end;

procedure TFr_Receber_Multipla.Sb_InserirClick(Sender: TObject);
Var
  Lc_form :TFr_Lanca_Pagto;
begin
  Lc_form := TFr_Lanca_Pagto.create(Self);
  Lc_form.Caption := 'Lançamento do Contasá Receber';
  Lc_form.Grb_Empresa.Caption := 'Cliente';
  Lc_form.It_Tipo_Fin := 'RM';
  Lc_form.It_Operacao := 'C';
  try
    Lc_form.ShowModal;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TFr_Receber_Multipla.EditionControlBoleto;
begin
  Pnl_Boleto.Enabled        := (FEditionStateBoleto = 'I') or (FEditionStateBoleto = 'E');
  Sb_InsereBoleto.Enabled   := (FEditionStateBoleto = 'B') and ( FBoleto.Registro.Codigo  > 0 )and ( FBoleto.Registro.Baixa <> 'S');
  Sb_AlteraBoleto.Enabled   := (FEditionStateBoleto = 'B') and ( FBoleto.Registro.Codigo > 0 ) and ( FBoleto.Registro.Baixa <> 'S');
  Sb_ExcluiBoleto.Enabled   := (FEditionStateBoleto = 'B') and ( FBoleto.Registro.Codigo > 0 ) and ( FBoleto.Registro.Baixa <> 'S');
  Sb_GravaBoleto.Enabled    := (FEditionStateBoleto = 'I') or (FEditionStateBoleto = 'E');
  Sb_CancelaBoleto.Enabled  := (FEditionStateBoleto = 'I') or (FEditionStateBoleto = 'E');
  Sb_BuscaBoleto.Enabled    := (FEditionStateBoleto = 'B');
  Sb_VoltaBoleto.Enabled    := (FEditionStateBoleto = 'B');
  Sb_Inserir.Enabled        := not (FEditionStateBoleto = 'I');
  Sb_Duplicata.Enabled      := not (FEditionStateBoleto = 'I');
  SB_Boleto.Enabled         := not (FEditionStateBoleto = 'I');
  SB_Buscar.Enabled         := not (FEditionStateBoleto = 'I');
  Sb_Destinar.Enabled       := not (FEditionStateBoleto = 'I');
  Sb_Baixar.Enabled         := not (FEditionStateBoleto = 'I');
  Sb_Negociar.Enabled       := not (FEditionStateBoleto = 'I');
  SB_Sair_0.Enabled         := not (FEditionStateBoleto = 'I');
  Sb_Imprimir.Enabled       := (FEditionStateBoleto = 'B');
  grb_busca_boleto.Enabled  := (FEditionStateBoleto = 'B');
  E_Dt_Ini_Bol.Enabled      := ChBx_Periodo_b.Checked;
  E_Dt_Fim_Bol.Enabled      := ChBx_Periodo_b.Checked;
end;

procedure TFr_Receber_Multipla.Pc_Ativar_Botoes;
begin
  SB_Buscar.Enabled:=True;
  if (cds_duplicatasFIN_CODIGO.AsInteger = 0) then
  Begin
    Sb_Baixar.Enabled := False;
    SB_Boleto.Enabled := False;
    Sb_Cheque.Enabled := False;
    Sb_Cartao.Enabled := False;
    Sb_Destinar.Enabled := False;
    exit;
  end;
  Sb_Baixar.Enabled := True;
  SB_Boleto.Enabled := False;
  Sb_Cheque.Enabled := False;
  Sb_Cartao.Enabled := False;
  Sb_Destinar.Enabled := False;
  if (Pos('BOLETO',Trim(Fm_TipoRecebimento.DBLCB_formaPagto.Text))>0) then
  Begin
    SB_Boleto.Enabled := True;
    Sb_Cheque.Enabled := False;
    Sb_Cartao.Enabled := False;
    Sb_Destinar.Enabled := cds_duplicatasFIN_CODIGO.AsInteger > 0;
  end
  else
  Begin
    if (Pos('CHEQUE',Trim(Fm_TipoRecebimento.DBLCB_formaPagto.Text))>0) then
    Begin
      SB_Boleto.Enabled := False;
      Sb_Cheque.Enabled := True;
      Sb_Cartao.Enabled := False;
      Sb_Destinar.Enabled := cds_duplicatasFIN_CODIGO.AsInteger > 0;
    end
    else
    BEgin
      if (Pos('CARTEIRA',Trim(Fm_TipoRecebimento.DBLCB_formaPagto.Text))>0) then
      BEgin
        Sb_Destinar.Enabled := True;
      End
      else
      Begin
        FCartao.Eletronico.Registro.FormaPagamento := Fm_TipoRecebimento.DBLCB_formaPagto.keyValue;
        FCartao.Eletronico.getbyFormaPagto;
        if ( FCartao.Eletronico.exist ) or
            (Pos('CARTÃO',Trim(Fm_TipoRecebimento.DBLCB_formaPagto.Text))>0) or
            (Pos('CARTAO',Trim(Fm_TipoRecebimento.DBLCB_formaPagto.Text))>0) then
        Begin
          SB_Boleto.Enabled := False;
          Sb_Cheque.Enabled := False;
          Sb_Cartao.Enabled := True;
          Sb_Destinar.Enabled := False;
        end;
      End;
    End;
  End;
end;

procedure TFr_Receber_Multipla.E_VL_PagoChange(Sender: TObject);
begin
  It_Vl_Pagto := StrToFloatDef(E_VL_Pago.Text,0);
  TotalizaBaixa;
end;

procedure TFr_Receber_Multipla.E_VL_PagoExit(Sender: TObject);
begin
  E_VL_Pago.Text := FloatToStrF(It_Vl_Pagto,ffFixed,10,2);
  TotalizaBaixa;
end;

procedure TFr_Receber_Multipla.SB_AdicionarClick(Sender: TObject);
begin
  if Fc_ValidaAdicionaBaixa then
  Begin
    Pc_Verificar_Situacao;
    if It_TipoTransacao = 'DESTINADAS' then Pc_Adicionar_Tudo;
    if It_TipoTransacao = 'NORMAL' then Pc_Adicionar;
    Pc_Ativar_Botoes;
    E_Dt_Pagto.Date := date;
  end;
end;

procedure TFr_Receber_Multipla.SaveBoleto;
begin
  FBoleto.Registro.Codemp     := It_Cd_Empresa;
  if Trim(E_NumBoleto.Text) ='' then
  Begin
    E_NumBoleto.Text := concat(
                          cds_duplicatasPED_NUMERO.AsString,
                          cds_duplicatasFIN_NR_PARCELA.AsString
                          );
  End;
  FBoleto.Registro.Numero := E_NumBoleto.Text;

  if FBoleto.Registro.CodQtc = 0 then
  Begin
    if It_Cd_Quitacao = 0 then  It_Cd_Quitacao := Fc_GeraCod_Baixa;
    FBoleto.Registro.CodQtc := It_Cd_Quitacao;
  End;
  FBoleto.Registro.Data       :=  Date;
  FBoleto.Registro.CodCtb     :=  DM.Qr_Carteiras.FieldByName('CTB_CODIGO').AsInteger;
  FBoleto.Registro.Desconto   := IntToStr(RG_Descontada.ItemIndex);
  FBoleto.Registro.TxDesconto := 0;
  if ( FBoleto.Registro.Baixa = '') then
    FBoleto.Registro.Baixa      := 'N';
  FBoleto.Registro.Valor      := StrToFloatDef(E_VL_Pagar.Text,0);
  FBoleto.Registro.VlTarifa   := StrToFloatDef(E_Vl_Tarifa.Text,0);
  FBoleto.Registro.TxMora     := 0;
  FBoleto.Registro.Codble     := DBLCB_CarteiraCobranca.KeyValue;
  FBoleto.Registro.DtVenc     := E_Blt_Vencimento.Date;
  FBoleto.save;
end;

procedure TFr_Receber_Multipla.SB_Add_TudoClick(Sender: TObject);
begin
  if Fc_ValidaAdicionaBaixa then
  Begin
    Pc_Verificar_Situacao;
    Pc_Adicionar_Tudo;
    Pc_Ativar_Botoes;
    E_Dt_Pagto.Date := date;
  end;
end;

procedure TFr_Receber_Multipla.Lb_Close_totalizadorClick(Sender: TObject);
begin
  Pg_Observacao.Visible := False;
end;

procedure TFr_Receber_Multipla.SB_ExcluirClick(Sender: TObject);
begin
  if (cb_Situacao.ItemIndex > 1) then exit;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir '+cds_ParcelasFIN_NUMERO.AsString+ ' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                     [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then

  begin
    Pc_Log_Sistema(Gb_CodMha,
                   GB_Cd_Usuario,
                   now,
                   'Contas a Receber',
                   cds_ParcelasFIN_CODIGO.AsInteger,
                   'Exclusão Contas à receber',
                   'FINANCEIRO: ' + cds_ParcelasFIN_NUMERO.AsString + ' | VALOR: ' + cds_ParcelasFIN_VL_PARCELA.AsString);
    Pc_Excluir_Contas_Receber;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaReceber;
  end;
end;

procedure TFr_Receber_Multipla.SB_AlterarClick(Sender: TObject);
begin
  if cds_Parcelas.RecordCount > 0 then
  BEgin
    if not Assigned(Fr_Fin_Edita) then Application.CreateForm(TFr_Fin_Edita, Fr_Fin_Edita);
    Fr_Fin_Edita.Financeiro.Registro.Codigo := cds_ParcelasFIN_CODIGO.AsInteger;
    Fr_Fin_Edita.Enabled := True;
    Fr_Fin_Edita.ShowModal;
  End;
end;

procedure TFr_Receber_Multipla.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Receber_Multipla.ChBx_Periodo_bClick(Sender: TObject);
begin
  E_Dt_Ini_Bol.Enabled := ChBx_Periodo_b.Checked;
  E_Dt_Fim_Bol.Enabled := ChBx_Periodo_b.Checked;
end;

procedure TFr_Receber_Multipla.ClearCartao;
begin
  FCartao.Clear;
  DBLCB_Cartao.KeyValue := null;
  E_Identifica.Clear;
  E_Autoriza.Clear;
  E_Validade.Clear;
  E_Parcelas.Clear;

end;

procedure TFr_Receber_Multipla.Sb_ImprimirClick(Sender: TObject);
begin
  IF (FBoleto.exist) then
  Begin
    Fr_Principal.Boleto.ListadeBoletos.Clear;
    if Fc_Gerar_Boleto_Sem_Registro( FBoleto.Registro.CodQtc ) then
    Begin
      if not DirectoryExists(GbPathExe + 'imagem\') then
        CreateDir(GbPathExe + 'imagem\');
      Fr_Principal.Boleto.ACBrBoletoFC.DirLogo := GbPathExe + '\imagem\';
      if not FileExists(GbPathExe + 'imagem\'+StrZero(Fr_Principal.Boleto.Banco.Numero,3,0)+'.bmp') then
        Pc_BaixarLogoBanco(StrZero(Fr_Principal.Boleto.Banco.Numero,3,0));
      Fr_Principal.Boleto.ACBrBoletoFC.Filtro := fiNenhum;
      Fr_Principal.Boleto.ACBrBoletoFC.NomeArquivo := '';
      Fr_Principal.Boleto.Imprimir;
    end;
  end;
end;



procedure TFr_Receber_Multipla.PC_Verificar_CH_Devolvido;
Var
  I : Integer;
begin
  FFinanceiro.Registro.CodigoQuitacao := It_Cd_Quitacao;
  FFinanceiro.Registro.DocumentoBaixado := 'S';
  FFinanceiro.getlist;
  for I := 0 to FFinanceiro.Lista.Count - 1 do
  Begin
    FFinanceiro.ClonarObj(FFinanceiro.Lista[I],FFinanceiro.Registro);
    if FFinanceiro.Registro.CodigoCheque > 0 then
    Begin
      FCheque.Parametros.FieldName.Codigo := FFinanceiro.Registro.CodigoCheque;
      FCheque.getById;
      FCheque.Registro.ValorAmortizado := FCheque.Registro.ValorAmortizado + FFinanceiro.Registro.ValorPago;
      if FCheque.Registro.ValorAmortizado >= FCheque.Registro.Valor then
        FCheque.Registro.Devolvido := 'N'
      else
        FCheque.Registro.Devolvido := 'S';
      FCheque.Registro.DataQuitacao := Now;
      FCheque.update;
    end;
  End;
end;


function TFr_Receber_Multipla.Fc_Preencher_Historico():String;
Begin
  Result := '';
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if cds_duplicatasFIN_CODCHQ.AsInteger > 0 then
    Begin
      if cds_duplicatas.bof then
        Result := 'VENDA Nº : '+ cds_duplicatasPED_NUMERO.AsString + ' - RECEBIMENTO DE CHEQUE DEVOLVIDO Nº: '+ Fc_PesquisaNumeroCheque(cds_duplicatasFIN_CODCHQ.AsInteger)
      else
        Result := Result + ' , ' + cds_duplicatasFIN_NUMERO.AsString;
    end
    else
    begin
      if Length(cds_duplicatasPED_NUMERO.AsString) > 0 then
      Begin
        if cds_duplicatas.bof then
          Result := 'VENDA Nº : '+ cds_duplicatasPED_NUMERO.AsString
        else
          Result := Result + ' , ' + cds_duplicatasPED_NUMERO.AsString;
      end
      else
      Begin
        if Length(cds_duplicatasNFL_NUMERO.AsString) > 0 then
        Begin
          //se for nota preenche aqui
          if cds_duplicatas.bof then
            Result := 'VENDA Nº : '+ cds_duplicatasNFL_NUMERO.AsString
          else
            Result := Result + ' , ' + cds_duplicatasNFL_NUMERO.AsString;
        end
        else
        Begin
          //se for Duplicata
          if cds_duplicatas.bof then
            Result := 'VENDA Nº : '+ cds_duplicatasFIN_NUMERO.AsString
          else
            Result := Result + ' , ' + cds_duplicatasFIN_NUMERO.AsString
        end;
      end;
    end;
    cds_duplicatas.next;
  end;
  Result := Result + ' , ' + cds_duplicatasEMP_NOME.AsString;
end;

procedure TFr_Receber_Multipla.Pc_Lancar_Caixa;
Var
  Lc_VL_Credito, Lc_VL_Debito:Real;
  Lc_VL_Pago : Real;
  Lc_Troco : String;
  LfFormCaixa : TFr_Lanca_Caixa;
Begin
  Lc_Troco := '';
  Lc_VL_Pago := StrToFloatDef(E_VL_Pago.Text,0);
  // Verifica se os campos estão zerados
  if ( Lc_VL_Pago <> 0 ) then
  Begin
    if ( Lc_VL_Pago > 0 ) then
    begin
      Lc_VL_Credito := Lc_VL_Pago;
      Lc_VL_Debito := 0;
    end
    else
    Begin
      Lc_VL_Credito := 0;
      Lc_VL_Debito := Lc_VL_Pago * -1;
      Lc_Troco := 'Troco | ';
    End;
    if Fc_VErificaCaixaAberto(True) then
    Begin
      Try
        LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
        LfFormCaixa.Codigo           := 0;
        LfFormCaixa.Quitacao         := It_Cd_Quitacao;
        LfFormCaixa.Caption          := '';
        LfFormCaixa.Operacao         := 'I';
        LfFormCaixa.PlanoResultado   := cds_duplicatasPLC_CODIGO.AsInteger;
        LfFormCaixa.PlanoCentroCusto := cds_duplicatasPLC_CODIGO.AsInteger;
        LfFormCaixa.Historico        := Copy(Lc_Troco + Fc_Preencher_Historico,1,100);
        LfFormCaixa.ValorCredito     := Lc_VL_Credito;
        LfFormCaixa.ValorDebito      := Lc_VL_Debito;
        LfFormCaixa.FormaPagto       := Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue;
        LfFormCaixa.Mensagem         := True;
        LfFormCaixa.LiberaCampo      := False;
        LfFormCaixa.AutoFill;
        LfFormCaixa.ShowModal;
        it_BaixaOK := LfFormCaixa.Resultado;
      Finally
        FreeAndNil(LfFormCaixa);
      End;
    End;
  End;
end;


procedure TFr_Receber_Multipla.Pc_Processo_Baixa;
Var
  Lc_I : Integer;
  Lc_Cd_Quitacao : Integer;
begin
  //Baixa os creditos dos clientes e soma ao saldo de Credtios a utilizar
  Pc_Baixar_Duplicatas;
  PC_Verificar_CH_Devolvido;
  Lc_Cd_Quitacao := It_Cd_Quitacao;
  Pc_Baixar_Comissao;
  Pc_ControleBloqueioCliente(It_Cd_Empresa,'L');
  Pc_Finalizar_Baixa;
  MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                'Documentos Baixados com Sucesso.'+EOLN+
                'Código da Baixa: '+IntToStr(Lc_Cd_Quitacao) +EOLN,
               ['OK'],[bEscape],mpInformacao);
end;



procedure TFr_Receber_Multipla.Pc_Definir_Grade_Cheque;
begin
  It_Cheque := 0;
  it_Oper_Reg_Chq := 'I';
  with StrGrd_Cheque do
  Begin
    ColWidths[0]:=17;
    ColWidths[1]:=-1;
    ColWidths[2]:=310;
    ColWidths[3]:=77;
    ColWidths[4]:=76;
    ColWidths[5]:=87;
    ColWidths[6]:=64;
    ColWidths[7]:=80;
    ColWidths[8]:=-1;
    ColWidths[9]:=-1;
    ColWidths[10]:=-1;
    ColWidths[11]:=-1;
    ColWidths[12]:=-1;
    ColWidths[13]:=-1;
    ColWidths[14]:=-1;
    ColWidths[15]:=-1;
    ColWidths[16]:=-1;
    Cols[2].Add('Emitente');
    Cols[3].Add('Banco');
    Cols[4].Add('Agência');
    Cols[5].Add('N. Cheque');
    Cols[6].Add('Valor');
    Cols[7].Add('Pré-Datado');
    Cols[8].Add('Devolvido');
    Cols[9].Add('Dt_Quitação');
    Cols[10].Add('Tipo');
    Cols[11].Add('Estado');
    Cols[12].Add('Retorno');
    Cols[13].Add('Qt_Rec');
    Cols[14].Add('Qt_pag');
    Cols[15].Add('CodFor');
    Cols[16].Add('ContaCorrente');
  end;
end;

procedure TFr_Receber_Multipla.sb_RECIBOClick(Sender: TObject);
var
  Lc_NumeroRecibo: String;
  Lc_I,Lc_J : Integer;
begin
  if cds_duplicatas.RecordCount > 0 then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'A lista de duplicatas a baixar será apagada para ' + EOLN+
                       'a inclusão dos dos itens relacionados ao recibo' + EOLN+
                       '                   Deseja continuar ?',
                       [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      cds_duplicatas.EmptyDataSet;
    end;
  end;

  Qr_Acao.Active := False;
  Qr_Acao.Transaction := DM.IB_Transacao;
  if not (InputQuery('Recibo','Digite o número do recibo', Lc_NumeroRecibo)) then
    Exit;

  Qr_Acao.SQL.Clear;
  Qr_Acao.SQL.Add('SELECT REC_CODQTC FROM TB_RECIBO        ');
  Qr_Acao.SQL.Add('WHERE REC_NUMERO=:REC_NUMERO   ');
  Qr_Acao.SQL.Add('  AND REC_CODMHA=:REC_CODMHA   ');
  Qr_Acao.ParamByName('REC_NUMERO').AsInteger := StrToIntDef(Lc_NumeroRecibo,0);
  Qr_Acao.ParamByName('REC_CODMHA').AsInteger := Gb_CodMha;
  Qr_Acao.Active := True;
  Qr_Acao.FetchAll;
  It_Cd_Quitacao := Qr_Acao.FieldByName('REC_CODQTC').AsInteger;

  If Qr_Acao.RecordCount = 0 then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não encontrado Recibo com este número.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    exit;
  end;

  Cb_Situacao.ItemIndex := 1;
  ChBx_Periodo.Checked := False;
  Pc_Buscar_Parcela('R');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  if ((It_Cd_Quitacao > 0) and (Qr_Parcelas.RecordCount > 0)) then
  Begin
    It_Cd_Empresa := cds_ParcelasFIN_CODEMP.AsInteger;
    //=======
    {
     preencher a grade de duplicatas
    }
    IF (It_TipoTransacao = 'DESTINADAS') then
    Begin
      Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue := It_Cd_FmaPagto;
      IF Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'BOLETO' then
      Begin
        Pg_Controle.ActivePageIndex := 2;
        Pc_BuscaBoleto('D');
        ShowDataBoleto;
      end;
      IF Fm_TipoRecebimento.DBLCB_formaPagto.Text = 'CHEQUE' then
      Begin
        Pc_LimpaStringGrid(StrGrd_Cheque);
        It_Cheque := 0;
        Pg_Controle.ActivePageIndex := 1;
        Pc_Buscar_Cheque('D');
      end;
      if (It_Cd_FmaPagto = Fc_PegaFormaPgto('CARTÃO')) OR
         (It_Cd_FmaPagto = Fc_PegaFormaPgto('CARTAO')) or
         Fc_ValidaBaixaCartao then
      Begin
        Pg_Controle.ActivePageIndex := 3;
        Fm_TipoRecebimento.DBLCB_formaPagto.KeyValue := 3;
      end;
    end;
    Pc_Define_Valores_Baixa;
    TotalizaBaixa;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaReceber;
    Pc_Ativar_Botoes;
    E_Dt_Pagto.Date := date;
  end
  else
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Parcela(s) deste recibo já estão baixada(s) '+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

{ Verifica se alguma parcela escolhida foi baixada em outra instancia
  Retorna verdadeiro se encontrar uma das parcelas baixadas.
  Esta parcela será retirada da lista de baixas e o processo será abortado.
  Valdo - 04/03/2011 - 22:24 }
  
Function TFr_Receber_Multipla.Fc_Verificar_Baixa_Parcela: Boolean;
Var
 Lc_Sql_Txt : String;
 Lc_I : Integer;
  LcQry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(Nil);
    LcQry := LcBase.GeraQuery;
    with LcQry do
    Begin
      Result := False;
      SQL.Clear;
      Lc_Sql_Txt := 'SELECT FIN_CODIGO FROM TB_FINANCEIRO                   '+
                   'WHERE (FIN_CODIGO=:FIN_CODIGO) AND (FIN_BAIXA = ''S'') ';
      SQL.Add(Lc_Sql_Txt);
      if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
      cds_duplicatas.First;
      while not cds_duplicatas.Eof do
      Begin
        if not Transaction.InTransaction then Transaction.StartTransaction;
        Active := False;
        ParamByName('FIN_CODIGO').AsInteger := cds_duplicatasFIN_CODIGO.AsInteger;
        Active := True;
        FetchAll;
        IF RecordCount > 0 then
        Begin
          MensagemPadrao('Aviso Importante', ATENCAO + EOLN + EOLN +
                         'A Duplicata Nº '+ cds_duplicatasFIN_NUMERO.AsString + ' já foi baixada em outra Instência.' + EOLN +
                         'Esta parcela será retirada desta baixa.' + EOLN+
                         'Verifique e reinicie o processo de baixa.' + EOLN,
                         ['OK'], [bEscape], mpErro);
           SB_RetirarClick(Self);
           Result := True;
           exit;
        end;
        cds_duplicatas.next;
        if Transaction.InTransaction then Transaction.Commit;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(LcQry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Receber_Multipla.Fm_TipoRecebimentoDBLCB_FormaPagtoClick(
  Sender: TObject);
begin
  Pc_Ativar_Botoes;
end;

procedure TFr_Receber_Multipla.Fm_TipoRecebimentoSB_FormaPagClick(
  Sender: TObject);
begin
  Fm_TipoRecebimento.SB_FormaPagClick(Sender);

end;

procedure TFr_Receber_Multipla.Sb_ResumoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  Cb_TipoData.SetFocus;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  Pg_Observacao.Visible := TRue;
end;

procedure TFr_Receber_Multipla.Ds_ParcelasDataChange(Sender: TObject;
  Field: TField);
begin
  SB_Alterar.Enabled   := (Qr_Parcelas.RecordCount > 0) and (It_Alterar) AND (Cb_Situacao.ItemIndex <= 1);
  SB_Excluir.Enabled   := (Qr_Parcelas.RecordCount > 0) and (It_Excluir) AND (Cb_Situacao.ItemIndex <= 1);
  Sb_Duplicata.Enabled := (Qr_Parcelas.RecordCount > 0) ;
end;

procedure TFr_Receber_Multipla.Observaes1Click(Sender: TObject);
begin
  if not Assigned(fr_obs_nfe) then Application.CreateForm(tfr_obs_nfe,fr_obs_nfe);
  fr_obs_nfe.it_cd_nfl:= cds_ParcelasNFL_CODIGO.AsInteger;
  fr_obs_nfe.showmodal;

end;

procedure TFr_Receber_Multipla.VisualizarPedido1Click(Sender: TObject);
begin
  if cds_ParcelasPED_CODIGO.AsInteger > 0 then
  Begin
    if cds_ParcelasNFL_MODELO.AsInteger = 65 then
      Pc_AbreTelaNotaFiscal65('N', cds_ParcelasNFL_CODIGO.AsInteger )
    else
      Pc_AbreTelaNotaFiscal( cds_ParcelasNFL_CODIGO.AsInteger ,self);
  End;
end;

procedure TFr_Receber_Multipla.Sb_leitorClick(Sender: TObject);
VAR
  lc_cheque: String;
begin
  if not (InputQuery('Leitor de Cheque','Cheque',lc_cheque)) then Exit;
  CHEQUE.CMC7 := lc_cheque;
  E_Banco.Text:= CHEQUE.Banco;
  E_Agencia.Text:= CHEQUE.Agencia;
  E_ContaCorrente.Text := CHEQUE.Conta + CHEQUE.DvCCT;
  E_NumChq.Text:= CHEQUE.Numero;
end;


function TFr_Receber_Multipla.Fc_Valida_Negociacao: Boolean;
begin
  result:=True;
  IF not Fc_VerificaPermissao('Fr_Receber_Multipla','Contas a Receber','NEGOCIAR',GB_Cd_Usuario,'S') then
  Begin
    Result:=FALSE;
    Exit;
  end;

  IF (cds_duplicatas.RecordCount = 0) then
  BEGIN
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor Selecione um registro antes de continunar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result:=FALSE;
    Exit;
  END;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  begin
    if cds_duplicatasFIN_OPERACAO.AsString = 'D' THEN
    BEGIN
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Por Favor Compense os créditos antes de Negociar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      Result:=FALSE;
      Exit;
    END;
    cds_duplicatas.next;
  end;

end;

procedure TFr_Receber_Multipla.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Visualizar:= True;
    It_Autorizar  := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Autorizar  := Fc_HabilitaPermissao(Pc_Menu,'AUTORIZAR','S');
    end;
  SB_Inserir.Enabled:= It_Inserir;
  SB_Alterar.Enabled:= It_Alterar;
  SB_Excluir.Enabled:= It_Excluir;
end;

procedure TFr_Receber_Multipla.FormShow(Sender: TObject);
begin
  Pc_PermissaoBotao('Contas a Receber');
  Pc_Ativar_Tabelas;
  BuscaAutomatica;
end;

procedure TFr_Receber_Multipla.GetCartao;
begin
  if It_Cd_Quitacao > 0 then
  Begin
    FCartao.clear;
    FCartao.registro.CodigoQuitacaoRec := It_Cd_Quitacao;
    FCartao.getByCodigoQuitacao;
    if FCartao.exist then
    Begin
      FCartao.Eletronico.Registro.Codigo := FCartao.registro.Codigo;
      FCartao.Eletronico.getByKey;
    End;
  End;
end;

function TFr_Receber_Multipla.GravaCartao: Boolean;
begin
  Fcartao.Registro.Estabelecimento := Gb_CodMha;
  Fcartao.Registro.CodigoCartao    := DBLCB_Cartao.KeyValue;
  Fcartao.Registro.Identificacao   := E_Identifica.Text;
  Fcartao.Registro.Autorizacao     := E_Autoriza.Text;
  Fcartao.Registro.Validade        := StrToDateDef(E_Validade.Text,Date);
  Fcartao.Registro.NumeroParcela   := StrTOIntDef(E_Parcelas.Text,1);
  Fcartao.Registro.CodigoQuitacaoRec := It_Cd_Quitacao;
  Fcartao.Registro.CodigoQuitacaoPag := 0;
  Fcartao.salva;
end;

procedure TFr_Receber_Multipla.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Busca
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(Sb_Duplicata,'INSERIR');
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    //sb_RECIBO,'RECIBO');
    //CHEQUE
    CarregaImagemBotao(Sb_InsereCheque,'INSERIR');
    CarregaImagemBotao(Sb_AlteraCheque,'ALTERAR');
    CarregaImagemBotao(Sb_ExcluiCheque,'EXCLUIR');
    CarregaImagemBotao(Sb_GravaCheque,'GRAVAR');
    CarregaImagemBotao(Sb_CancelaCheque,'CANCELAR');
    CarregaImagemBotao(Sb_leitor,'LEITOR');
    CarregaImagemBotao(Sb_VoltaCheque,'VOLTAR');
    //BOLETO
    CarregaImagemBotao(Sb_InsereBoleto,'INSERIR');
    CarregaImagemBotao(Sb_AlteraBoleto,'ALTERAR');
    CarregaImagemBotao(Sb_ExcluiBoleto,'EXCLUIR');
    CarregaImagemBotao(Sb_GravaBoleto,'GRAVAR');
    CarregaImagemBotao(Sb_CancelaBoleto,'CANCELAR');
    CarregaImagemBotao(Sb_BuscaBoleto,'BUSCAR');
    CarregaImagemBotao(Sb_Imprimir,'IMPRIMIR');
    CarregaImagemBotao(Sb_VoltaBoleto,'VOLTAR');
    //CARTAO
    CarregaImagemBotao(Sb_InsereCartao,'INSERIR');
    CarregaImagemBotao(Sb_AlteraCartao,'ALTERAR');
    CarregaImagemBotao(Sb_ExcluiCartao,'EXCLUIR');
    CarregaImagemBotao(Sb_GravarCartao,'GRAVAR');
    CarregaImagemBotao(Sb_CancelarCartao,'CANCELAR');
    CarregaImagemBotao(Sb_ImprimirCartao,'IMPRIMIR');
    CarregaImagemBotao(Sb_VoltarCartao,'VOLTAR');
    //Baixa
    CarregaImagemBotao(Sb_Cartao,'CARTÃO');
    CarregaImagemBotao(Sb_cheque,'CHEQUE');
    CarregaImagemBotao(SB_Boleto,'BOLETO');
    CarregaImagemBotao(Sb_Destinar,'DESTINAR');
    CarregaImagemBotao(Sb_Baixar,'FATURAR');
    CarregaImagemBotao(Sb_Negociar,'NEGOCIAR');
    CarregaImagemBotao(SB_Sair_0,'SAIR');
  END;
end;


procedure TFr_Receber_Multipla.Pc_IniciaVariaveis;
Var
 X:Integer;
begin
  For X:=1 to Pg_Controle.PageCount do Pg_Controle.Pages[x-1].TabVisible:=False;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  ChBx_Periodo_b.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Pg_Controle.ActivePageIndex:=0;
  Pc_Definir_Grade_Cheque;
  It_Cd_Quitacao := 0;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  E_Dt_Pagto.Date := Date;
  FCartao := TControllerCartao.create(Self);
  FBoleto := TControllerBoleto.create(Self);
  FCheque := TControllerCheque.create(Self);
  FFinanceiro := TControllerFinanceiro.create(Self);
  FComissao   := TControllerComissao.create(Self);

end;

procedure TFr_Receber_Multipla.tbs_boletoShow(Sender: TObject);
begin
  E_Dt_Ini_Bol.Date := Date;
  E_Dt_Fim_Bol.Date := Date;

end;

procedure TFr_Receber_Multipla.AplicarPlanoContas1Click(Sender: TObject);
begin
  if Fc_ValidaOperacaoPArcela then
  Begin
    Pc_AplicarPlanoContasFinanceiro( cds_ParcelasFIN_CODIGO.AsInteger);
    SB_BuscarClick(Self);
  End;
end;

procedure TFr_Receber_Multipla.Sb_BoletoEletronicoClick(Sender: TObject);
Var
  Lc_Form : TSeaElectronicSlip;
begin
  Lc_Form := TSeaElectronicSlip.Create(nil);
  Try
    Lc_Form.ShowModal;
  Finally
    AtivarCarteiraCobranca;
    DBLCB_CarteiraCobranca.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Receber_Multipla.Qr_BoletoAfterOpen(DataSet: TDataSet);
begin
  Qr_Boleto.FetchAll;
end;

procedure TFr_Receber_Multipla.Qr_BoletoAfterScroll(DataSet: TDataSet);
begin
  ShowDataBoleto;
end;

procedure TFr_Receber_Multipla.Sb_BoletoPDFClick(Sender: TObject);
begin
  IF (FBoleto.exist ) then
  Begin
    Fr_Principal.SaveDialogo.Filter := 'Documento PDF|*.pdf';
    if Fr_Principal.SaveDialogo.Execute then
    Begin
      Fr_Principal.Boleto.ListadeBoletos.Clear;
      if Fc_Gerar_Boleto_Sem_Registro( FBoleto.Registro.CodQtc) then
      Begin
        if not DirectoryExists(GbPathExe + 'imagem\') then
          CreateDir(GbPathExe + 'imagem\');
        Fr_Principal.Boleto.ACBrBoletoFC.DirLogo := GbPathExe + '\imagem\';
        if not FileExists(GbPathExe + 'imagem\'+StrZero(Fr_Principal.Boleto.Banco.Numero,3,0)+'.bmp') then
          Pc_BaixarLogoBanco(StrZero(Fr_Principal.Boleto.Banco.Numero,3,0));
        Fr_Principal.Boleto.ACBrBoletoFC.Filtro := fiPDF;
        Fr_Principal.Boleto.ACBrBoletoFC.NomeArquivo := Fr_Principal.SaveDialogo.FileName;
        Fr_Principal.Boleto.Imprimir;
      end;
      Fr_Principal.SaveDialogo.Filter := 'Pasta de Trabalho do Microsoft Excel (*.xls)|*.xls';
    end;
  end;
end;

procedure TFr_Receber_Multipla.Sb_ImprimirCartaoClick(Sender: TObject);
Var
  Lc_Form : TRL_ControleCartao;
begin
  Try
    Lc_Form := TRL_ControleCartao.Create(nil);
    Lc_Form.It_Cd_Quitacao := FCartao.Registro.CodigoQuitacaoRec;
    Lc_Form.Qrpt.Preview;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Receber_Multipla.AtivarCarteiraCobranca;
begin
  DM.Qr_Carteiras.Active := False;
  DM.Qr_Carteiras.ParamByName('CTB_CODMHA').AsInteger := Gb_CodMha;
  DM.Qr_Carteiras.Active := True;
end;

procedure TFr_Receber_Multipla.baixaComTEF;
Var
  Lc_Form : TFr_receber_tef_avulso;
begin
  Lc_Form := TFr_receber_tef_avulso.Create(Self);
  Try
    //Lc_Form.Align := alClient;
    Lc_Form.It_Cd_Cliente := cds_duplicatasFIN_CODEMP.AsInteger;
    Lc_Form.It_Pizzaria := False;
    Lc_Form.It_Cd_Pedido := self.It_Cd_Pedido;
    Lc_Form.It_Nr_Pedido := cds_duplicatasPED_CODIGO.AsInteger;
    Lc_Form.E_VL_Total.Text := E_VL_Pago.Text;
    Lc_Form.It_NFCe := False;
    Lc_Form.ShowModal;
    Lc_Form.BringToFront;
    Self.it_BaixaOK := Lc_Form.It_Fatura_Ok;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Receber_Multipla.BuscaAutomatica;
begin
  if E_BuscaPedido.Text <> '' then
    SB_BuscarClick(Self);
end;

procedure TFr_Receber_Multipla.CalcularComissao1Click(Sender: TObject);
Begin
  if ValidaRecalcularComissao then
  Begin
    RecalcularComissao;
    MensagemPadrao(MENSAGEM,TITULO_INFORMACAO+EOLN+EOLN+
                   'Comissao calculada com sucesso.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
  End;
end;

procedure TFr_Receber_Multipla.CancelBoleto;
begin

end;

procedure TFr_Receber_Multipla.Cb_SituacaoChange(Sender: TObject);
begin
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  if Cb_Situacao.ItemIndex = 0 then It_Cd_Quitacao := 0;
end;

procedure TFr_Receber_Multipla.Cb_TipoDataClick(Sender: TObject);
begin
  case Cb_TipoData.ItemIndex of
    0:Begin
        Cb_Situacao.Enabled := True;
        Cb_Situacao.ItemIndex := 0;
      End;
    1:Begin
        Cb_Situacao.Enabled := False;
        Cb_Situacao.ItemIndex := 2;
      End;
    2:Begin
        Cb_Situacao.Enabled := False;
        Cb_Situacao.ItemIndex := Cb_Situacao.Items.Count - 1;
      End;
    3:Begin
        Cb_Situacao.Enabled := True;
        Cb_Situacao.ItemIndex := 0;
      End;
  end;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaReceber;
  if Cb_Situacao.ItemIndex = 0 then It_Cd_Quitacao := 0;
end;

procedure TFr_Receber_Multipla.ChangeBoleto;
begin
  ShowDataBoleto;
  DBLCB_CarteiraCobranca.SetFocus;
end;

function  TFr_Receber_Multipla.Fc_ValidaAdicionaBaixa():boolean;
Begin
  Result := true;
  if not cds_Parcelas.Active then cds_Parcelas.CreateDataSet;
  if (cds_ParcelasFIN_BAIXA.AsString <> 'N' ) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Parcela já está baixada.'+EOLN+
                   'Verifique para continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function  TFr_Receber_Multipla.Fc_ValidaOperacaoPArcela():boolean;
Begin
  Result := true;
  if cds_Parcelas.RecordCount = 0 then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Não há registro selecionado.' + EOLN +
                   ' Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;
end;


procedure TFr_Receber_Multipla.InativarInativar1Click(Sender: TObject);
Var
  Lc_Escolha : Integer;
Begin
  if Fc_ValidaOperacaoPArcela then
  Begin
    Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                                'Escolha o Tipo de Movimento.',
                                ['ATIVAR','DESATIVAR','CANCELAR'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    case Lc_Escolha of
      0:Pc_AtivarFinanceiro( cds_ParcelasFIN_CODIGO.AsInteger,True);
      1:Pc_AtivarFinanceiro( cds_ParcelasFIN_CODIGO.AsInteger,False);
      end;
    if (Lc_Escolha < 2) then SB_BuscarClick(Sender);
  end;
end;

procedure TFr_Receber_Multipla.InsertBoleto;
begin
  AtivarCarteiraCobranca;
  FBoleto.clear;
  DBLCB_CarteiraCobranca.KeyValue := dm.Qr_Carteiras.FieldByname('BLE_CODIGO').AsInteger;
  RG_Descontada.ItemIndex := 1;
  E_Blt_Vencimento.Date := cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
  DBLCB_CarteiraCobranca.SetFocus;
end;

procedure TFr_Receber_Multipla.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TFr_Receber_Multipla.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Busca_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    E_Busca_Empresa.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

procedure TFr_Receber_Multipla.EditionControlCartao;
begin
  Sb_InsereCartao.Enabled   := ( EditionStateCartao = 'B' ) and (cds_duplicatasFIN_CODIGO.AsInteger > 0 );
  Sb_AlteraCartao.Enabled   := ( EditionStateCartao = 'B' ) and (Fcartao.registro.codigo>0);
  Sb_ExcluiCartao.Enabled   := ( EditionStateCartao = 'B' ) and (Fcartao.registro.codigo>0);
  Sb_GravarCartao.Enabled   := ( EditionStateCartao = 'I' ) or ( EditionStateCartao = 'E' );
  Sb_CancelarCartao.Enabled := ( EditionStateCartao = 'I' ) or ( EditionStateCartao = 'E' );
  Sb_VoltarCartao.Enabled   := ( EditionStateCartao = 'B' );
  Sb_ImprimirCartao.Enabled := ( EditionStateCartao = 'B' );

  pnl_cartao_dados.Enabled := ( EditionStateCartao = 'I' ) or ( EditionStateCartao = 'E' );

  Sb_Inserir.Enabled  := ( EditionStateCartao = 'B' );
  Sb_Cartao.Enabled   := ( EditionStateCartao = 'B' );
  SB_Buscar.Enabled   := ( EditionStateCartao = 'B' );
  Sb_Destinar.Enabled := ( EditionStateCartao = 'B' );
  Sb_Destinar.Enabled := ( EditionStateCartao = 'B' );
  Sb_Baixar.Enabled   := ( EditionStateCartao = 'B' );
  Sb_Negociar.Enabled := ( EditionStateCartao = 'B' );
  SB_Sair_0.Enabled   := not (( EditionStateCartao = 'I' ) or ( EditionStateCartao = 'E' ));

end;

procedure TFr_Receber_Multipla.E_Busca_Cd_EmpresaExit(Sender: TObject);
begin
  if ChBx_Nome.checked then
    E_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_NOME',E_Busca_Cd_Empresa.Text)
  else
    E_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_FANTASIA',E_Busca_Cd_Empresa.Text);
end;

end.








