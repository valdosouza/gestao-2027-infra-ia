unit Un_FrenteCaixa;

interface

uses
      Winapi.Windows, Messages, SysUtils, Classes, Variants, System.Math, vcl.Graphics, vcl.Forms, Generics.Defaults, Vcl.Controls, Data.DB, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, ACBrBase, Vcl.ActnList, env, STQuery, Vcl.Imaging.jpeg, ControllerCommand, Vcl.Menus, Actions, QEdit_Setes, ImageList, Vcl.ImgList, Un_Fm_ListaTabelaPreco, ACBrTEFD, ACBrTEFDClass, ACBrTEFDCliSiTef, ACBrPosPrinter, ControllerTefMovimento, ControllerPedidoVDa, ControllerDskPromotion, ControllerCheckOutItems, ControllerEmpresa, Vcl.Dialogs, DateUtils, TypInfo, STDatabase, GeneralPrint, sea_pay_back, itemVenda, STTransaction;

type
  TCustomGridAccess = class(TCustomGrid) end;

  TFr_FrenteCaixa = class(TForm)
    Pnl_topo: TPanel;
    Timer1: TTimer;
    Img_Frente: TImage;
    Sb_ExcluiItem: TImage;
    Sb_Desconto: TImage;
    Label5: TLabel;
    SB_Cliente: TImage;
    Label11: TLabel;
    Label12: TLabel;
    SB_Pesquisa: TImage;
    Label13: TLabel;
    Label6: TLabel;
    Sb_logout: TImage;
    Label15: TLabel;
    Label9: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Sb_ExcluiVenda: TImage;
    Label23: TLabel;
    Label24: TLabel;
    SB_Faturar: TImage;
    Label26: TLabel;
    Label27: TLabel;
    Ac_Funcoes: TActionList;
    Ac_Gaveta: TAction;
    Pnl_rodape: TPanel;
    MenuOper: TMainMenu;
    Pnl_Corpo: TPanel;
    Pnl_Corpo_Items: TPanel;
    Qr_Pedido: TSTQuery;
    E_M_Fisco: TMemo;
    popmenu: TPopupMenu;
    Cadastrodeproduto1: TMenuItem;
    Tarefas: TMenuItem;
    PedidosEmitidos: TMenuItem;
    Sair2: TMenuItem;
    VendasBalcao: TMenuItem;
    Liberacao: TAction;
    DadosNCM1: TMenuItem;
    AlterarPreosconformeTabelaAtiva1: TMenuItem;
    Pnl_TabelaPreco: TPanel;
    Sb_Confirma_TabelaPreco: TButton;
    Sb_Cancela_TabelaPreco: TButton;
    Fm_ListaTabelaPreco: TFm_ListaTabelaPreco;
    AdministrativoTEF1: TMenuItem;
    Pnl_TEF_Geral: TPanel;
    Pnl_Msg_TEF: TPanel;
    Pnl_tef_Msg: TPanel;
    mm_Tef: TMemo;
    lMensagemOperador: TLabel;
    Label48: TLabel;
    Pnl_Tef_Cancela: TPanel;
    bCancelarResp: TButton;
    OcultarBarradeTarefasWindows: TMenuItem;
    LanamentodeCaixa1: TMenuItem;
    TEF: TACBrTEFD;
    MnuPromoces: TMenuItem;
    Grp_Totalizador: TPanel;
    Lb_Valor_Pedido: TLabel;
    Lb_Valor_Desconto: TLabel;
    Lb_Valor_Total: TLabel;
    Lb_Taxa_Desconto: TLabel;
    E_Quantidade: TLabel;
    Lb_TipoVenda: TLabel;
    Lb_Label_Qtde_Total: TLabel;
    Lb_Valor_troco: TLabel;
    E_VL_Troco: TPanel;
    E_Vl_Total: TPanel;
    E_Data: TLabel;
    E_Hora: TLabel;
    Lbl_Caixa: TLabel;
    E_Usuario: TLabel;
    StrGrd_Produtos: TStringGrid;
    Pnl_Cliente: TPanel;
    Pnl_Lanca_Items: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    E_Status: TLabel;
    E_Cd_Cliente: TEdit_Setes;
    E_Nome_Cliente: TEdit;
    Lb_Status_Caixa: TLabel;
    Label31: TLabel;
    E_Qtde: TEdit_Setes;
    Label30: TLabel;
    E_BuscaCodigo: TEdit_Setes;
    Lb_Item_lancado: TLabel;
    Lb_Label_totalizador: TLabel;
    ImageList1: TImageList;
    FechamentoVendas1: TMenuItem;
    E_Vl_Pedido: TPanel;
    E_Aq_Desconto: TEdit_Setes;
    E_Vl_Desconto: TEdit_Setes;
    Lb_Vl_Economia: TLabel;
    E_Vl_Economia: TPanel;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    MnuSalvarComanda: TMenuItem;
    MnuConsultarComanda: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    GoCodigoCliente: TAction;
    MnuSalvarDelivery: TMenuItem;
    MnuConsultarDelivery: TMenuItem;
    N6: TMenuItem;
    ComissoDelivery1: TMenuItem;
    CartoPrPago1: TMenuItem;
    N7: TMenuItem;
    Observao1: TMenuItem;
    N8: TMenuItem;
    Atualizao1: TMenuItem;
    LanamentoCrditoPrPago1: TMenuItem;
    MenuOperMenuFiscal: TMenuItem;
    VerprodutosdestaPromoo1: TMenuItem;
    IBT_Pesq_Produto: TSTTransaction;
    Qr_PesqProduto: TSTQuery;
    N9: TMenuItem;
    ProgramaPAYBACK1: TMenuItem;
    AlterarPreo1: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_ClienteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StrGrd_ProdutosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure E_Vl_DescontoExit(Sender: TObject);
    procedure E_Aq_DescontoExit(Sender: TObject);

    procedure Sb_DescontoClick(Sender: TObject);
    procedure SB_PesquisaClick(Sender: TObject);
    procedure Sb_logoutClick(Sender: TObject);
    procedure Sb_ExcluiItemClick(Sender: TObject);
    procedure Sb_ExcluiVendaClick(Sender: TObject);
    procedure E_Aq_DescontoEnter(Sender: TObject);
    procedure E_Vl_DescontoEnter(Sender: TObject);
    procedure StrGrd_ProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_BuscaCodigoEnter(Sender: TObject);
    procedure E_QtdeExit(Sender: TObject);
    procedure Cadastrodeproduto1Click(Sender: TObject);

    procedure PedidosEmitidosClick(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure SB_FaturarClick(Sender: TObject);
    procedure VendasBalcaoClick(Sender: TObject);
    procedure E_BuscaCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure E_QtdeKeyPress(Sender: TObject; var Key: Char);
    procedure DadosNCM1Click(Sender: TObject);
    procedure E_Aq_DescontoKeyPress(Sender: TObject; var Key: Char);
    procedure E_Vl_DescontoKeyPress(Sender: TObject; var Key: Char);
    procedure GoCodigoClienteExecute(Sender: TObject);
    procedure E_QtdeEnter(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure E_Peso_LiquidoManualEnter(Sender: TObject);
    procedure E_Vl_UnitarioManualEnter(Sender: TObject);
    procedure E_VL_UnitarioEnter(Sender: TObject);
    procedure Sb_Cancela_TabelaPrecoClick(Sender: TObject);
    procedure Sb_Confirma_TabelaPrecoClick(Sender: TObject);
    procedure AlterarPreosconformeTabelaAtiva1Click(Sender: TObject);
    procedure ControleElementos(Painel:Tpanel;Ativo:Boolean);
    procedure TEFCliSiTefExibeMenu(Titulo: string; Opcoes: TStringList;
      var ItemSelecionado: Integer; var VoltarMenu: Boolean);
    procedure TEFCliSiTefObtemCampo(Titulo: string; TamanhoMinimo,
      TamanhoMaximo, TipoCampo: Integer;
      Operacao: TACBrTEFDCliSiTefOperacaoCampo; var Resposta: AnsiString;
      var Digitado, VoltarMenu: Boolean);
    procedure TEFComandaECF(Operacao: TACBrTEFDOperacaoECF; Resp: TACBrTEFDResp;
      var RetornoECF: Integer);
    procedure TEFComandaECFAbreVinculado(COO, IndiceECF: string; Valor: Double;
      var RetornoECF: Integer);
    procedure TEFComandaECFImprimeVia(TipoRelatorio: TACBrTEFDTipoRelatorio;
      Via: Integer; ImagemComprovante: TStringList; var RetornoECF: Integer);
    procedure TEFComandaECFSubtotaliza(DescAcre: Double;
      var RetornoECF: Integer);
    procedure TEFExibeMsg(Operacao: TACBrTEFDOperacaoMensagem; Mensagem: string;
      var AModalResult: TModalResult);
    procedure TEFInfoECF(Operacao: TACBrTEFDInfoECF; var RetornoECF: string);
    procedure ConfigAtivaTEF;
    procedure AdministrativoTEF1Click(Sender: TObject);
    procedure TEFAguardaResp(Arquivo: string; SegundosTimeOut: Integer;
      var Interromper: Boolean);
    procedure TEFAntesFinalizarRequisicao(Req: TACBrTEFDReq);
    procedure TEFBloqueiaMouseTeclado(Bloqueia: Boolean; var Tratado: Boolean);
    procedure TEFDepoisConfirmarTransacoes(
      RespostasPendentes: TACBrTEFDRespostasPendentes);
    procedure TEFMudaEstadoReq(EstadoReq: TACBrTEFDReqEstado);
    procedure TEFMudaEstadoResp(EstadoResp: TACBrTEFDRespEstado);
    procedure TEFRestauraFocoAplicacao(var Tratado: Boolean);
    procedure Ac_GavetaExecute(Sender: TObject);
    procedure LiberacaoExecute(Sender: TObject);
    procedure OcultarBarradeTarefasWindowsClick(Sender: TObject);
    procedure LanamentodeCaixa1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MnuPromocesClick(Sender: TObject);
    procedure FechamentoVendas1Click(Sender: TObject);
    procedure MnuSalvarComandaClick(Sender: TObject);
    procedure MnuConsultarComandaClick(Sender: TObject);
    procedure E_Cd_ClienteExit(Sender: TObject);
    procedure E_Cd_ClienteKeyPress(Sender: TObject; var Key: Char);
    procedure E_Cd_ClienteEnter(Sender: TObject);
    procedure MnuSalvarDeliveryClick(Sender: TObject);
    procedure MnuConsultarDeliveryClick(Sender: TObject);
    procedure ComissoDelivery1Click(Sender: TObject);
    procedure CartoPrPago1Click(Sender: TObject);
    procedure Observao1Click(Sender: TObject);
    procedure Atualizao1Click(Sender: TObject);
    procedure LanamentoCrditoPrPago1Click(Sender: TObject);
    procedure TEFExibeQRCode(const Dados: string);
    procedure MenuOperMenuFiscalClick(Sender: TObject);
    procedure VerprodutosdestaPromoo1Click(Sender: TObject);
    procedure ProgramaPAYBACK1Click(Sender: TObject);
    procedure AlterarPreo1Click(Sender: TObject);

  private
    { Private declarations }
    It_NFCe : Boolean;
    It_Ctrl_Estoque : Boolean;
    BalBarraCodigoProduto :Integer;
    BalBarraPrecoPeso : Integer;
    BalBarraTipo : String;
    fCancelado : Boolean ;
    CtrlTEF : TControllerTefMovimento;
    It_Casa_Decimal : Integer;
    ObservacaoPedido : String;
    forcafechamento : Boolean;
    ImpNumeroColunas : Integer;
    ImpPorta : String;
    ImpSaltos : Integer;
    ImpModelo : Integer;
    ImpTraco : String;
    ImpCompTefQuebra : Boolean;
    ImpCompTefMostraUsuario : Boolean;
    It_Cd_Consumidor : Integer;
    It_Cd_Cliente: Integer;
    procedure Pc_TeclaAtalhoF2();
    procedure Pc_TeclaAtalhoF3();
    procedure Pc_TeclaAtalhoF4();
    procedure Pc_TeclaAtalhoF5();
    procedure Pc_TeclaAtalhoF6();
    procedure Pc_TeclaAtalhoF7();
    procedure Pc_TeclaAtalhoF8();
    procedure Pc_TeclaAtalhoF9();
    procedure Pc_TeclaAtalhoF10();
    procedure Pc_TeclaAtalhoF11();
    procedure Pc_TeclaAtalhoF12();
    procedure Pc_TeclaAtalhoEscape();

    procedure LancaCreditoCartaoPrePago;
    procedure AbrirTelaTabelaPreco;
    function ValidaTrocaTabela:Boolean;
    Procedure EscolheTabela;
    procedure TrocaTabela;
    function CentralizarTexto(Texto : String; Tamanho : integer) : String;
    //Controla as Promoções
   procedure DeletaItemDaGrade(Linha:Integer);
   procedure Pc_DefineCasaDecimal;
   function ValidaAberturaTEF:Boolean;
   function ValidaVerPromocaoByItemList:Boolean;
   procedure VerPromocaoByItemList;
   function TrataQtde(Qtde:String):String;
  protected
    //Controle de Promoção
    FTeclaF11Bloqueada : Boolean;
    Promocao : TControllerDskPromotion;
    ListaPedidoItem : TListaItemVenda;
      Bitmap: TBitmap;
    procedure GuardaListaProdutos(ListaItem : TListaItemVenda;Promocao:String);
    Function EfetuaCopiaItem(ItemVenda : TItemVenda;Qtde:Real;TipoPreco:String):TItemVenda;
    procedure TratarRestoPromocao(QtdePromocao,QtdeTotal:Real;ListaItem : TListaItemVenda);
    procedure TratarValorUnitarioPromocao;
    procedure TratarMensagemPromocao(QtdePromocao,QtdeTotal:Real;ListaItem : TListaItemVenda);

    procedure InitVariable;

    procedure Pc_Promocao(Promocao : String;QtdePromocao:Real;preco:Real);
    procedure OrdenarListaItems(Lista: TListaItemVenda);
    procedure EliminaItemDaGRid(Pc_strGrid: TStringGrid; Item: String);
    Procedure OcultaBarraTarefas(YesNo: Boolean);
    procedure AjustaComponentesParaResolucao1024x768;
  public
     { Public declarations }
    //Identificação do Cliente
    It_Cd_Endereco: Integer;
    It_Cd_FormaPagto : Integer;
    IT_Calc_automatico:string;
    //Controla o Tipo de Operação - PDV - CMD
    It_TP_Operacao: String;

    It_Usa_Gaveta : boolean;
    It_Guilhotina : boolean;
    It_Usa_Balanca : boolean;
    It_Usa_ProdutoAvulso : Boolean;
    It_Cd_ProdutoAvulso : String;
    It_Usa_Cd_Fabrica : Boolean;
    //Impressão
    It_Usa_Imp_Checkout : Boolean;
    It_Tp_Impressao : Integer;
    It_Linha : Integer;

    It_ColunaCentro : Integer;


    //Variaveis que controlam o Pedido

    Pedido: TControllerPedidoVda;
    It_NR_Pedido: Integer;
    It_Nr_Item: Integer;

    It_cd_Tabela: Integer;
    It_Vl_Produtos: Currency;
    It_Qt_Produtos: Real;
    //ecf
    TEF_Ativo : Boolean;
    IndiceTransacaoTef : Integer;
    estadoSimuladoEcf : tEstadoEcfSimulado;
    TEFformapagto : String;
    //retorna como Faturamento ok
    procedure Pc_FormataTela;
    procedure Pc_MontaGrid;
    procedure Pc_FormataPanels;
    procedure Pc_PosicionaCliente;
    procedure Pc_IniciaVariaveis;
    procedure Pc_LimpaCampos;
    procedure DefineStatus;
    function Fc_ValidaPreencheProduto(Pc_Vl_Venda:Real):boolean;
    function FC_BuscarProduto(Pc_Codigo,Fc_Campo,Fc_Unidade: string):Integer;
    procedure Pc_MostraBusca;

    procedure Pc_PreencheItensVenda(Pc_Cd_Produto:String;
                                    Pc_Cd_Fabrica:String;
                                    Pc_Descricao:String;
                                    Pc_Qtde:Real;
                                    Pc_Vl_Venda:Real;
                                    Pc_Abreviatura:String;
                                    Pc_VL_Custo:Real;
                                    Pc_NCM:String;
                                    Pc_Origem:String;
                                    Pc_Vl_Original:Real;
                                    pc_Observacao : String;
                                    Pc_AtingiuPromocao : String);

    procedure Pc_SomaProdutos;
    procedure Pc_Desconto(Pc_Tipo:String);
    procedure Pc_Totalizador;

    procedure Pc_GeraPedido(pPresenca:Integer);
    procedure Pc_GeraItensPedido;

    function  Fc_ValidaFaturamento:boolean;

    function Fc_CarregaPedidoBalcao(Fc_Cd_Pedido,Fc_Nr_Pedido:Integer):Boolean;
    procedure Pc_FaturamentoNormal;
    procedure Pc_Pre_Venda;
    procedure Pc_ChamaPedidoBalcao;
    Function Fc_validaExcluiCupom():Boolean;
    Function Fc_validaExcluiItemCupom():Boolean;
    procedure Pc_AbreTelaProdutoSemRegistro(Pc_Descricao,Pc_Unidade,Pc_VL_Unitario:String);
    procedure Pc_AbreTelaBalanca;
    procedure Pc_AbreTelaBalancaManual;
    procedure Pc_AbreTelaProdutoAvulso;
    function Fc_LancaItem:Boolean;
    procedure Pc_Imp_Abre_CupomNaoFiscal;
    procedure Pc_Imp_Item_CupomNaoFiscal;
    procedure Pc_Imp_Cancela_Item_CupomNaoFiscal(Pc_Item:Integer);
    Function Fc_StatusTecla (Key: integer): boolean;//função para desabilitar alt+f4
    procedure Pc_ImprimeItemCheckout;
    Function FC_Valida_ImpostoAproximado:boolean;

    procedure Pc_PreencheProdutoCodigoReduzido(Pc_Cd_Produto:String);
    function Fc_PreencheProdutoCodigoBarrasBalanca(Pc_Cd_Barras:String):Boolean;
    procedure Pc_PreencheProdutoCodigoBarras(Pc_Cd_Barras:String);
    procedure ProdutoDifDeUm(Nr_Registro:Integer);

    //Função TEF
    procedure ImprimeComprovante(Via:Integer;c:TStringList);
    Function ValidaItensNaLista:Boolean;
    //Comanda
    procedure SalvarCommand;
    procedure SalvaItemsComanda;
    procedure ConsultarCommand;
    function getPedidoByCommand(CommandID:String):Integer;
    function  CarregaItensCommand(PedidoID : Integer):Boolean;
    procedure limparTela;

    procedure SalvarDelivery;
    procedure ConsultaDelivery;
  end;

var
  Fr_FrenteCaixa: TFr_FrenteCaixa;


implementation

uses     Un_DM, UN_Sistema, UN_MSG, Un_Funcoes, Un_Fc_Sored_Procedures, StrUtils, RN_Produto, Un_Pesq_Produto, Un_Cupom_Fiscal, Un_Regra_Negocio, Un_Produtos, Un_Nota_Fiscal, Un_Liberacao, Un_Imp_Mod_Impressao, RN_Permissao, RN_Estoque, RN_Financeiro, UN_NCM, RN_NotaFiscal, RN_FormaPagto, RN_Itens_Vda_Avulso, Un_Pesq_Empresa, RN_Crud, UN_TabelasEmListas, Un_Pesq_NF_Pro, RN_NotaFiscalConsumidor, RI_MovimentoFinanceiro, RN_NotaFiscalEletronica3X, Un_TEF_ObtemCampo, Un_TEF_ExibeMenu, BematechPrint, EpsonPrint, tblDskPromotion, tblCheckOutItems, ControllerBase, GraphicPrint, ControllerPayBack, ControllerPrePaidCard, Un_Principal, sea_promotion, un_imp_fechamento, Un_FrenteCaixaPesoBalanca, Un_FrenteCaixaPesoManual, Un_FrenteCaixaProdSemRegistro, Un_FrenteCaixaProdAvulso, Un_Command, sea_command, tas_delivery, Un_PizzariaEntrega, UN_Imp_Comissao, sea_pre_paid_card, un_obtem_campo_memo, tas_pre_paid_card, frQrCode, tas_menu_fiscal_paf, cad_promotion, setes_forms, Un_Ajusta_Preco;
{$R *.dfm}


{Frente de Caixa}

function TFr_FrenteCaixa.CentralizarTexto(Texto : String; Tamanho : integer) : String;
 var
   metade: integer;
begin
   Texto := Trim(Texto);
   metade := ((Tamanho-Length(Texto)) div 2);
   while Length(Texto)+metade < Tamanho do
     Texto := ' ' + Texto;
   result := Texto;
end;

procedure TFr_FrenteCaixa.Pc_DefineCasaDecimal;
Begin
  //Define casas decimais para as vendas
  case StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_VENDA','0'),0) of
    0:It_Casa_Decimal := 2;
    1:It_Casa_Decimal := 3;
    2:It_Casa_Decimal := 4;
    3:It_Casa_Decimal := 5;
    4:It_Casa_Decimal := 6;
  end;
end;


procedure TFr_FrenteCaixa.Pc_Desconto(Pc_Tipo:String);
var
   Lc_VL_Pedido: Real;
   Lc_Aq_Desconto: Real;
   Lc_Vl_Desconto: real;
begin
  Lc_VL_Pedido    := StrToFloatDef(E_Vl_Pedido.Caption, 0);
  if (Lc_VL_Pedido > 0) then
  Begin
    Lc_Aq_Desconto  := 0;
    if (Pc_Tipo = 'A') then
    begin
      Lc_Aq_Desconto := StrToFloatDef(E_Aq_Desconto.Text, 0);
      if Lc_Aq_Desconto >= 100 then Lc_Aq_Desconto := 0;
      Lc_Vl_Desconto := (Lc_VL_Pedido * Lc_Aq_Desconto)/100;
      Lc_Vl_Desconto := RoundTo(Lc_Vl_Desconto,-2);
      E_Vl_Desconto.Text := FloatToStrF(Lc_Vl_Desconto,ffFixed,10,2);
      E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
    end
    else
    begin
      Lc_Vl_Desconto := StrToFloatDef(E_VL_Desconto.Text, 0);
      Lc_Aq_Desconto := (Lc_Vl_Desconto/Lc_VL_Pedido)*100;
      Lc_Aq_Desconto := RoundTo(Lc_Aq_Desconto,-2);
      if Lc_Aq_Desconto >= 100 then
      Begin
        Lc_Aq_Desconto := 0;
        E_VL_Desconto.Text := '0,00';
      End;
      E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
    end;
  end;
end;

procedure TFr_FrenteCaixa.Pc_GeraPedido(pPresenca:Integer);
begin
  with Pedido.registro do
  Begin
    Terminal := Gb_Terminal;
    Tipo:= 1;
    CodigoEstabelecimento := Gb_CodMha;
    Usuario:= Gb_Cd_Usuario;
    Data:= Gb_DataCaixa;
    Empresa:= It_Cd_Cliente;
    Vendedor:= Gb_Cd_Vendedor;
    FormaPagto:= It_Cd_FormaPagto;
    Prazo:= '000 - A VISTA';
    Endereco:= It_Cd_Endereco;
    QtdeProdutos:= It_Qt_Produtos;
    ValorProdutos:= StrToFloatDef(E_Vl_Pedido.Caption, 0);
    AliqDesconto:=  StrToFloatDef(E_aQ_Desconto.Text, 0);
    ValorDesconto:= StrToFloatDef(E_VL_Desconto.Text, 0);
    ValorPedido:= StrToFloatDef(E_VL_Total.Caption, 0);
    Faturado:= 'N';
    if pPresenca > 0 then
      IndicaPresenca:= pPresenca
    else
      if IndicaPresenca = 0 then
        IndicaPresenca:= 1;

    TipoContato:= '0';
    Observacao := Self.ObservacaoPedido;
  end;
  Pedido.salva;
  //Define que cupom não precisa ter numero
  if (Pedido.registro.Numero = 0) then
    Pedido.nextNumber('T');

end;

procedure TFr_FrenteCaixa.Pc_GeraItensPedido;
var
  I: Integer;
  Lc_Estoque : String;
  Lc_Cd_Item : Integer;
  ItemVenda : TItemVenda;
begin
  //Insere os itens de produto
  FreeAndNil(ListaPedidoItem);
  ListaPedidoItem := TListaItemVenda.create;
  for I := 1 to StrGrd_Produtos.RowCount - 1 do
  begin
    //Guarda os itens da Venda para o caso do usuario desistir do faturamento e
    // voltar para a tela de venda
    ItemVenda := TItemVenda.Create;
    ItemVenda.Produto         := StrToIntDef(   StrGrd_Produtos.Cells[2,  I],0);
    ItemVenda.Fabrica         :=                StrGrd_Produtos.Cells[3,  I];
    ItemVenda.Descricao       :=                StrGrd_Produtos.Cells[4,  I];
    ItemVenda.Quantidade      := StrToFloatDef( StrGrd_Produtos.Cells[5,  I],0);
    ItemVenda.ValorVenda      := StrToFloatDef( StrGrd_Produtos.Cells[6,  I],0);
    ItemVenda.Abreviatura     :=                StrGrd_Produtos.Cells[8,  I];
    ItemVenda.ValorCusto      := StrToFloatDef( StrGrd_Produtos.Cells[9,  I],0);
    ItemVenda.ItemPedido      :=   StrToIntDef( StrGrd_Produtos.Cells[10, I],0);
    ItemVenda.ncm             :=                StrGrd_Produtos.Cells[11, I];
    ItemVenda.Origem          :=                StrGrd_Produtos.Cells[12, I];
    ItemVenda.Promocao        :=                StrGrd_Produtos.Cells[13, I];
    ItemVenda.ValorOriginal   := StrToFloatDef( StrGrd_Produtos.Cells[14, I],0);
    ItemVenda.QtdePromocao    := StrToFloatDef( StrGrd_Produtos.Cells[15, I],0);
    ItemVenda.PrecoPromocao   := StrToFloatDef( StrGrd_Produtos.Cells[16, I],0);
    ItemVenda.TotalPromocao   := StrToFloatDef( StrGrd_Produtos.Cells[19, I],0);
    ListaPedidoItem.Add(ItemVenda);
  end;
end;

procedure TFr_FrenteCaixa.Pc_MostraBusca;
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Try
    Lc_Form := TFr_Pesq_Produto.Create(Nil);
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.Pc_Tabelas_Disponiveis;
    if (E_BuscaCodigo.Text <> '') then
      Lc_Form.E_BuscaCodigo.Text :=  E_BuscaCodigo.Text
    else
      Lc_Form.E_BuscaCodigo.Text := '';
    Lc_Form.ShowModal;
    //Depois que Fecha o Relatorio
    if Lc_Form.It_Visualizar then
    Begin
      IF (It_Usa_Cd_Fabrica)then
        E_BuscaCodigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGOFAB').AsString
      else
        E_BuscaCodigo.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString;
      //if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus; - Comentado em 20/12/2016 - 23:55
      if Fc_LancaItem then
      Begin
        //totaliza os itens na tela
        Pc_SomaProdutos;
        Pc_Totalizador;
        Pc_ImprimeItemCheckout;
      End;
      //Limpa os campos
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  Finally
    FreeAndNil(Lc_Form) ;
  End;
end;



function TFr_FrenteCaixa.Fc_ValidaPreencheProduto(Pc_Vl_Venda:Real):boolean;
Var
  Lc_Preco:String;
Begin
  Result := true;
  IF not Fc_ValidaEscalaUnidadeProduto(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsInteger,StrToFloatDef(TrataQtde(E_Qtde.Text),0)) then
  Begin
    Result := False;
    exit;
  end;

  If It_NFCe then
  Begin
    if (trim(Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString) = '') or
       (Length(Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString) < 8) then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Código de NCM não preenchido ou incompleto.'+EOLN +
                     'Verifique antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      E_BuscaCodigo.Clear;
      Result := false;
      exit;
    end;
  end;

  IF (Pc_Vl_Venda =0)  then
  Begin
      MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                    'Este produto está com o preço Zerado.' + EOLN +
                    'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
      E_BuscaCodigo.Clear;
      Result := false;
      exit;
  end;
  if Trim(Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString)='' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O produto está com problemas em sua descrição.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;


function TFr_FrenteCaixa.FC_BuscarProduto(Pc_Codigo,Fc_Campo,Fc_Unidade: string):Integer;
var
  Lc_Sqltxt: string;
begin
  Screen.Cursor := crHourGlass;
  Lc_Sqltxt := 'SELECT DISTINCT '+
               'PRO_CODIGO, '+
               'PRO_CODIGOFAB, '+
               'PRO_ORIGEM, '+
               'PRO_CODIGOBAR, '+
               'PRO_CODIGOFOR, '+
               'PRO_CODIGONCM, '+
               'PRO_DESCRICAO, '+
               'PRO_VL_CUSTO, '+
               'MED_ABREVIATURA, '+
               'PRC_VL_VDA, '+
               'PRC_AQ_COM, '+
               'PRO_CAMPANHA '+
               'FROM TB_PRODUTO tb_produto '+
               '  INNER JOIN TB_PRECO tb_preco '+
               '  ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO) '+
               '  INNER JOIN tb_medida m '+
               '  ON (m.med_codigo = tb_produto.pro_codmed) '+
               'WHERE (PRO_ATIVO = ''S'') AND (PRC_CODTPR =:PRC_CODTPR) '+
               ' AND (PRO_TIPO <> ''S'') ';
  if not GB_ProdCompartilha then Lc_Sqltxt := Lc_Sqltxt + ' AND (PRO_CODMHA=:PRO_CODMHA) ';

  if (Fc_Unidade<>'') then
    Lc_Sqltxt := Lc_Sqltxt + '  AND upper(m.med_abreviatura) =:med_abreviatura ';

  Lc_Sqltxt := Lc_Sqltxt + ' AND (' + Fc_Campo + ' =:' + Fc_Campo + ') ';
  Qr_PesqProduto.Close;
  with Qr_PesqProduto do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    if not Transaction.InTransaction then Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add(Lc_Sqltxt);
    ParamByName(FC_CAMPO).AsString := Pc_Codigo;
    ParamByName('PRC_CODTPR').AsInteger := It_Cd_Tabela;
    if not GB_ProdCompartilha then
      ParamByName('PRO_CODMHA').AsInteger := Gb_CodMha;
    if (Fc_Unidade<>'') then
      ParamByName('med_abreviatura').AsString := Upper(Fc_Unidade);

    Open;
    FetchAll;
    First;
    if RecordCount > 0 then
    Begin
      if FieldByName('PRO_CAMPANHA').AsString = 'S' then
      Begin
        Close;
        ParamByName(FC_CAMPO).AsString := Pc_Codigo;
        ParamByName('PRC_CODTPR').AsInteger := 2;
        Open;
        FetchAll;
        First;
      end;
      Result := Qr_PesqProduto.RecordCount;
    end
    else
    Begin
      Qr_PesqProduto.Close;
      Result := 0;
    end;
  End;
  Screen.Cursor := crDefault;
end;

procedure TFr_FrenteCaixa.Pc_PreencheItensVenda(Pc_Cd_Produto:String;
                                              Pc_Cd_Fabrica:String;
                                              Pc_Descricao:String;
                                              Pc_Qtde:Real;
                                              Pc_Vl_Venda:Real;
                                              Pc_Abreviatura:String;
                                              Pc_VL_Custo:Real;
                                              Pc_NCM:String;
                                              Pc_Origem:String;
                                              Pc_Vl_Original:Real;
                                              pc_Observacao : String;
                                              Pc_AtingiuPromocao : String);
Var
  Lc_Aux : Real;
begin
  //Zera o Troco no primeiro lançamento de item em uma nova venda
  if (It_Nr_Item = 0) then E_VL_Troco.Caption := '0,00';
  It_Nr_Item := It_Nr_Item + 1;
  with StrGrd_Produtos do
  Begin
    RowCount := It_Nr_Item + 1;
    Cells[0, It_Nr_Item] := '';
    Cells[1, It_Nr_Item] := StrZero(It_Nr_Item,3,0);
    Cells[2, It_Nr_Item] := Pc_Cd_Produto;
    Cells[3, It_Nr_Item] := Pc_Cd_Fabrica;
    Cells[4, It_Nr_Item] := Pc_Descricao;
    Cells[5, It_Nr_Item] := FloatToStrF(Pc_Qtde, ffFixed, 10, 3);
    Cells[6, It_Nr_Item] := FormatFloat('#0.00###', Pc_Vl_Venda);
      //FloatToStrF(Pc_Vl_Venda, ffFixed, 10, 2);
    Pc_Qtde := RoundTo(Pc_Qtde,-3);
    //Foi preciso criar a variavel Lc_Aux pois o compilador não esta dando a instrução correta para o processador
    //Se colocar o calculo aninhado dá erro no  arredondamento
    Lc_Aux := (Pc_Vl_Venda * Pc_Qtde);
    Lc_Aux := RoundTo( Lc_Aux,-2);
    Cells[7, It_Nr_Item] := FloatToStrF(Lc_Aux , ffFixed, 10, 2);
    Cells[8, It_Nr_Item] := Pc_Abreviatura;
    Cells[9, It_Nr_Item] := FloatToStrF(Pc_VL_Custo, ffGeneral, 10, 2);
    Cells[10, It_Nr_Item] := '0';
    Cells[11, It_Nr_Item] := Pc_NCM;
    Cells[12, It_Nr_Item] := Pc_Origem;
    Promocao.getbyProduct(StrToIntDef(Pc_Cd_Produto,0),Gb_CodMha);
    if (Promocao.exist and ( (Promocao.Registro.DataValidade >= Date) or (Promocao.Registro.DataValidade = 0))   ) then
    Begin
      Cells[13,It_Nr_Item] := Promocao.Registro.Codigo.ToString;
      Cells[15,It_Nr_Item] := FloattoStr(Promocao.Registro.Quantidade);
      Cells[16,It_Nr_Item] := FormatFloat('#0.#####',Promocao.Registro.Preco);
      Cells[18,It_Nr_Item] := pc_Observacao;
      Cells[19,It_Nr_Item] := FormatFloat('#0.##',Promocao.Registro.Preco * Promocao.Registro.Quantidade);
      Cells[20,It_Nr_Item] := Pc_AtingiuPromocao;
    End
    else
    Begin
      Cells[13,It_Nr_Item] := '0';
      Cells[15,It_Nr_Item] := '0';
      Cells[16,It_Nr_Item] := '0';
      if (Promocao.exist and (date > Promocao.Registro.DataValidade)and (Promocao.Registro.DataValidade > 0)  ) then
        Cells[18,It_Nr_Item] := concat('Promoção expirou em ', DateToStr(Promocao.Registro.DataValidade))
      else
        Cells[18,It_Nr_Item] := '';
      Cells[19,It_Nr_Item] := '0';
      Cells[20,It_Nr_Item] := '';
    End;
    Cells[14, It_Nr_Item] := FloatToStrF(Pc_Vl_Original, ffFixed, 10, 2);
    E_Qtde.Text := '1';
    Row := StrGrd_Produtos.RowCount - 1;
    //Item Lançado
    Lb_Item_lancado.Caption := concat(
                                 Pc_Descricao, ' | ',
                                 FloatToStrF(Pc_Qtde, ffFixed, 10, 3), ' X ',
                                 FloatToStrF(Pc_Vl_Venda, ffFixed, 10, 2), ' = ',
                                 FloatToStrF(Pc_Vl_Venda * Pc_Qtde, ffFixed, 10, 2)
                                );
  End;
end;

procedure TFr_FrenteCaixa.TEFAguardaResp(Arquivo: string;
  SegundosTimeOut: Integer; var Interromper: Boolean);
var
  Msg : String ;
begin
  Msg := '' ;
  if (TEF.GPAtual in [gpCliSiTef, gpVeSPague]) then   // TEF dedicado ?
  begin
    if (Arquivo = '23') and (not bCancelarResp.Visible) then  // Esta aguardando Pin-Pad ?
    begin
      if TEF.TecladoBloqueado then
      begin
        TEF.BloquearMouseTeclado(False);  // Desbloqueia o Teclado
        // TODO: nesse ponto é necessário desbloquear o Teclado, mas permitir
        // um clique apenas no botão cancelar.... FALTA CORRIGIR NO DEMO
      end ;
      Msg := 'Tecle "ESC" para cancelar.';
      bCancelarResp.Visible := True ;
      fCancelado := False;
    end;
  end
  else
    Msg := 'Aguardando: '+Arquivo+' '+IntToStr(SegundosTimeOut) ;

  if Msg <> '' then mm_Tef.Lines.Add( Msg );
  mm_Tef.Update;
  if fCancelado then
     Interromper := True ;
end;

procedure TFr_FrenteCaixa.TEFAntesFinalizarRequisicao(Req: TACBrTEFDReq);
begin
   if Req.Header = 'CRT' then
      Req.GravaInformacao(777,777,'TESTE REDECARD');
   mm_Tef.Lines.Add('Enviando: '+Req.Header+' ID: '+IntToStr( Req.ID ) );
   mm_Tef.Update;
end;

procedure TFr_FrenteCaixa.TEFBloqueiaMouseTeclado(Bloqueia: Boolean;
  var Tratado: Boolean);
begin
//  self.Enabled := not Bloqueia ;
//  mm_Tef.Lines.Add('BloqueiaMouseTeclado = '+IfThen(Bloqueia,SIM, 'NAO'));
//  mm_Tef.Update;
//  Tratado := False ;  { Deixa executar o código de Bloqueio do ACBrTEFD }
end;

procedure TFr_FrenteCaixa.TEFCliSiTefExibeMenu(Titulo: string;
  Opcoes: TStringList; var ItemSelecionado: Integer; var VoltarMenu: Boolean);
Var
  AForm : TFr_TEF_ExibeMenu ;
  MR    : TModalResult ;
Label
  lbTEfForma;
begin
  try
    AForm := TFr_TEF_ExibeMenu.Create(nil);
    AForm.Panel1.Caption := Titulo;
    AForm.ListBox1.Items.AddStrings(Opcoes);
    MR := AForm.ShowModal ;
    VoltarMenu := (MR = mrRetry) ;
    if (MR = mrOK) then
      ItemSelecionado := AForm.ListBox1.ItemIndex;
  finally
    FreeAndNil(AForm);
  end;
end;

procedure TFr_FrenteCaixa.TEFCliSiTefObtemCampo(Titulo: string; TamanhoMinimo,
  TamanhoMaximo, TipoCampo: Integer; Operacao: TACBrTEFDCliSiTefOperacaoCampo;
  var Resposta: AnsiString; var Digitado, VoltarMenu: Boolean);
Var
  AForm : TFr_TEF_ObtemCampo ;
  MR    : TModalResult ;
  LcShow : Boolean;
begin
  try
    AForm := TFr_TEF_ObtemCampo.Create(nil);
    LcShow := True;
    AForm.Caption := 'TEF - Setes';
    AForm.Panel1.Caption := Titulo;

    { Indica, na coleta, que o campo em questão é o valor do troco em dinheiro
      a ser devolvido para o cliente.
      Na devolução de resultado (Comando = 0) contém o valor efetivamente aprovado para o troco}
    //tAXA DE sERVIÇO - 130
    if TipoCampo=130 then
    Begin
      Digitado := True;
      Resposta := '0';
      LcShow := False;
    End;

    //Digitar senha
    if TipoCampo=500 then
    Begin
      AForm.Panel1.Caption := 'Forneça a Senha do Supervisor';
      AForm.Edit1.PasswordChar:='*';
      TamanhoMinimo := 5;
    end
    else
    Begin
      AForm.Edit1.PasswordChar:=#0;
    End;

    AForm.TamanhoMaximo  := TamanhoMaximo;
    AForm.TamanhoMinimo  := TamanhoMinimo;
    AForm.Operacao       := Operacao;
    AForm.TipoCampo      := TipoCampo;
    AForm.Edit1.Text     := Resposta; { Para usar Valores Previamente informados }

    //tAXA DE sERVIÇO - 504
    if TipoCampo=504 then
    Begin
      Digitado := True;
      Resposta := '';
      LcShow := False;
    End;

    //Número do Cartão de Crédito Digitado
    if TipoCampo = 512 then
    Begin
      AForm.Panel1.Caption := 'Forneça o Número do Cartão';
      AForm.Edit1.MaxLength :=  16;
      TamanhoMinimo := 16;
      TamanhoMaximo := 16;
    End;

    //Código de segurança do Cartão - 514
    if TipoCampo=514 then
    Begin
      AForm.Panel1.Caption := 'Informe o Código de segurança do Cartão';
      TamanhoMinimo := 3;
      TamanhoMaximo := 5;
    End;

    //DATA DA TRANSAÇÃO - 515
    if TipoCampo=515 then
    Begin
      AForm.Panel1.Caption := 'Informe Data da Transação (DDMMAAAA)';
      TamanhoMinimo := 8;
      TamanhoMaximo := 8;
    End;
    //Número do documento a ser cancelado ou a ser re-impresso - 516
    if TipoCampo=516 then
    Begin
      AForm.Panel1.Caption := 'Forneça o número a ser cancelado ou re-impresso';
      TamanhoMinimo := 6;
    End;

    //Vai abrir o formulario para solicitar dados
    if LcShow then
    Begin
      MR := AForm.ShowModal ;

      Digitado   := (MR = mrOK) ;
      VoltarMenu := (MR = mrRetry) ;
      if Digitado then
         Resposta := AForm.Edit1.Text;
    End;
  finally
    FreeAndNil(AForm);
  end;
end;

procedure TFr_FrenteCaixa.TEFComandaECF(Operacao: TACBrTEFDOperacaoECF;
  Resp: TACBrTEFDResp; var RetornoECF: Integer);
BEGIN
  try
    case Operacao of
      opeAbreGerencial :
         mm_Tef.Lines.Add('Abre Gerencial') {ACBrECF1.AbreRelatorioGerencial} ;

      opeFechaCupom :
         estadoSimuladoEcf := tpsLivre;

      opeSubTotalizaCupom :
         mm_Tef.Lines.Add('Sub Totaliza');

      opeFechaGerencial, opeFechaVinculado :
         estadoSimuladoEcf := tpsRelatorio;

      opePulaLinhas :
        begin
          mm_Tef.Lines.Add('PulaLinhas');
          Sleep(200);
        end;

      opeImprimePagamentos :
        begin
          mm_Tef.Lines.Add('ImprimePagamentos');
        end;
    end;
    RetornoECF := 1 ;
    mm_Tef.Update;
  except
    RetornoECF := 0 ;
  end;

end;

procedure TFr_FrenteCaixa.Timer1Timer(Sender: TObject);
begin
  E_Hora.Caption := TimeToStr(time);
end;

procedure TFr_FrenteCaixa.Pc_MontaGrid;
Begin

  with StrGrd_Produtos do
  Begin
    ColWidths[0] := 25;
    ColWidths[1] := 50;
    ColWidths[2] := -1;
    ColWidths[3] := 0;
    ColWidths[4] := 430;
    ColWidths[5] := 100;
    ColWidths[6] := 100;
    ColWidths[7] := 125;
//------------------------------------
    ColWidths[8] := -1;
    ColWidths[9] := -1;
    ColWidths[10] := -1;
    ColWidths[11] := -1;
    ColWidths[12] := -1;
    ColWidths[13] := -1;
    ColWidths[14] := -1;
    ColWidths[15] := -1;
    ColWidths[16] := -1;
//------------------------------------
    ColWidths[17] := 20;
    ColWidths[18] := 500;
    ColWidths[19] := -1;
    ColWidths[20] := -1;
    Cols[1].Add('Seq');
    Cols[2].Add('Cód. Produto');
    Cols[3].Add('Código');
    Cols[4].Add('Descrição');
    Cols[5].Add('Qtde');
    Cols[6].Add('Unitário');
    Cols[7].Add('Subtotal');
    Cols[8].Add('Abreviatura');
    Cols[9].Add('Vl. Custo');
    Cols[10].Add('Cd. Item');
    Cols[11].Add('ncm');
    Cols[12].Add('Origem');
    Cols[13].Add('TemPromoção');
    Cols[14].Add('ValorOriginal');
    Cols[15].Add('Qtde Promoção');
    Cols[16].Add('Preço Promoção');
  End;
End;

procedure TFr_FrenteCaixa.Pc_FormataPanels;
Var
  Lc_top,lc_left : Integer;
BEgin
  //Posiciona o Panel de Tabela de Preço
  Pnl_TabelaPreco.Visible := False;
  Lc_top := trunc((Height - Pnl_TabelaPreco.Height)/2);
  lc_left := trunc((Width - Pnl_TabelaPreco.Width)/2);
  Pnl_TabelaPreco.Top := Lc_top;
  Pnl_TabelaPreco.Left := lc_left;
End;

procedure TFr_FrenteCaixa.Pc_FormataTela;
Var
  LcTemPromocao : Boolean;
Begin
  //Oculta a barra de ferramenta
  Width := Screen.Width;
  Height := Screen.Height - 10;
  Pnl_Topo.Height := 131;
  AjustaComponentesParaResolucao1024x768;
  OcultaBarraTarefas(Fc_Aq_Geral('L','CONTROLE DE FRENTE','OCULTABARRAWINDOWS','S') = 'S');
  IF (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_USAR_DESCONTO', 'S') = 'N') then
  Begin
    E_Vl_Pedido.Height := 90;
    Lb_Taxa_Desconto.Visible := False;
    E_Aq_Desconto.Visible := False;
    Lb_Valor_Desconto.Visible := False;
    E_Vl_Desconto.Visible := False;
    Lb_Valor_Total.Visible := False;
    E_Vl_Total.Visible := False;
  end;

  FTeclaF11Bloqueada := ( Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_BLOQUEIA_F11', 'N') = 'S');
  E_Qtde.ReadOnly := FTeclaF11Bloqueada;

  LcTemPromocao := Promocao.tempromocao;
  Lb_Vl_Economia.Visible := LcTemPromocao;
  E_Vl_Economia.Visible := LcTemPromocao;
  Fc_BuscaImagemEmpresa(Img_Frente.Picture, 'FRENTECAIXA');
  Pc_LimpaStringGrid(StrGrd_Produtos);
  Pc_MontaGrid;
  E_Vl_Total.ParentBackground := False;
  E_Vl_Total.ParentColor := False;
  E_Vl_Total.Color := clBlack;
  E_Vl_Total.Font.Color := clLime;
  if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
  If (It_TP_Operacao = 'CMD') then
  Begin
    PedidosEmitidos.Visible := False;
    Caption := 'Atendimento Balcão - Pré-Venda';
    Lbl_Caixa.Caption := 'BALCÃO';
    Lb_Status_Caixa.Visible := False;
    E_Status.Visible := False;
  end
  else
  Begin
    Caption := 'Frente de Caixa - Venda';
    Lbl_Caixa.Caption := 'VENDA';
    Lb_Status_Caixa.Visible := True;
    E_Status.Visible := True;
  end;
  Pc_FormataPanels;

end;

procedure TFr_FrenteCaixa.Pc_PosicionaCliente;
Var
  LcEmpresa : TControllerEmpresa;
Begin
  try
    E_Cd_Cliente.Text :=  StrZero(It_Cd_Cliente,4,0);
    LcEmpresa := TControllerEmpresa.Create(nil);
    LcEmpresa.Registro.Codigo := It_Cd_Cliente;
    LcEmpresa.getById;
    E_Nome_Cliente.Text := LcEmpresa.Registro.ApelidoFantasia;

    LcEmpresa.Endereco.Registro.CodigoEmpresa := It_Cd_Cliente;
    LcEmpresa.Endereco.getByEmpresa;
    if LcEmpresa.Endereco.exist then
    Begin
      It_Cd_Endereco := LcEmpresa.Endereco.Registro.Codigo;
    end
    else
    Begin
       MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                      'Este cliente está sem endereço ou ' + EOLN +
                      'como endereço incompleto.'+ EOLN +
                      'Verifique antes de continuar.' + EOLN,
                      ['OK'], [bEscape], mpErro);
    end;
  finally
    FreeAndNil(LcEmpresa);
  end;
end;

procedure TFr_FrenteCaixa.Pc_IniciaVariaveis;
Var
  Lc_Gvta:Integer;
  I : Integer;
Begin
  Pc_DefineCasaDecimal;

  It_NFCe := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_VDA_NFCE', 'N') = 'S');
  It_Ctrl_Estoque := (Fc_TB_Geral('L','FRT_VDA_EST_SEM_CTRL', 'N') = 'S');

  ImpNumeroColunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
  ImpTraco := '';
  For I:= 1 to ImpNumeroColunas do
    ImpTraco := ImpTraco + '-';
  ImpPorta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
  ImpSaltos := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'),2);
  ImpModelo := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL','1'),0);

  //FAz a quebra de Linnha no comprovante para deixar mais legível
  ImpCompTefQuebra := ( Fc_Aq_Geral('L','TEF','TEF_CP_QBRA_LINHA','S') = 'S' ) ;
  //Mostra o Usuario do CAixa na 1º Via
  ImpCompTefMostraUsuario  := ( Fc_Aq_Geral('L','TEF','TEF_CP_MOSTRA_USUARIO','S') = 'S');

  It_Cd_Consumidor := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  It_Cd_Cliente := It_Cd_Consumidor;

  //Bloco do codigo de produto
  BalBarraCodigoProduto := StrToIntDef( Fc_Aq_Geral('L','BALANCA','BAL_BAR_CD_PRODUTO','6'),6);
  //Bloco do codigo de peso ou preco
  BalBarraPrecoPeso := StrToIntDef( Fc_Aq_Geral('L','BALANCA','BAL_BAR_PRECO_QTDE','6'),6);
  //Tipo da leitura, Price ou Weight
  BalBarraTipo := Fc_Aq_Geral('L','BALANCA','BAL_TIPO_LEITURA','P');

  //Inicia a Variavel que autoriza fechar a tela
  It_Cd_FormaPagto := Fc_PegaParteFormaPgto('DINHEIRO');
  It_Cd_Tabela := StrToIntDef(Fc_Tb_Geral('L','FRT_G_PRECO_CONSUMIDOR','1'),1);
  //Identifica o Cliente na Tela;
  Pc_PosicionaCliente;

  //Peso Automatico se a unidade for KG
  IT_Calc_automatico:= Fc_Tb_Geral('L','FRENTE_CX_CALC_AUTO','');


  DefineStatus;

  //Ativa a Gaveta de dinheiro
  Lc_Gvta := (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_MODELO', ''),0)-1);
  It_Usa_Gaveta := False;
  if (Lc_Gvta <> 2) then
  Begin
    It_Usa_Gaveta := True;
    Pc_ConfiguraGavetaACBR;
  end;
  //Ativa a Guilhotina
  It_Guilhotina := ( Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_CORTE_PAPEL', 'S') = 'S');
  //Ativa a Balanca
  It_Usa_Balanca := (Fc_Aq_Geral('L','BALANCA','BAL_P_ATIVACAO','') = 'S');

  //Verifica o uso do Produto avulso
  It_Usa_ProdutoAvulso := (Fc_Tb_Geral('L','FRT_PRODUTOAVULSO','N') = 'S');
  if It_Usa_ProdutoAvulso then
  Begin
    Pedido.Itens.Produto.getProdutoAvulso;
    if Pedido.Itens.Produto.exist then
      It_Cd_ProdutoAvulso := Pedido.Itens.Produto.Registro.Codigo.ToString()
    else
    Begin
      It_Usa_ProdutoAvulso := False;
      It_Cd_ProdutoAvulso := '0';
    End;
  End;
  //Faz a Busca por codigo de Fabrica
  It_Usa_Cd_Fabrica := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N') = 'S');
  //Utilizar sistemática de impressão item a item na leitura do produto no checkout
  It_Usa_Imp_Checkout := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_ITEM_CHECKOUT', 'N') = 'S');
  //Verifica se o Tipo de Impressão será matricial ou termica
  It_Tp_Impressao := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','1'),1);
  //Prepara o ESC/POS para usar a gaveta e outros
  AtivaESCPOS;
  //Ativa o TEF
  TEF_Ativo := ( Fc_Aq_Geral('L','TEF','TEF_LC_ATIVO','N') = 'S'); //( Fc_Tb_Geral('L','FIN_G_TEF','S') = 'S');
  Pnl_TEF_Geral.Visible := TEF_Ativo;

  if (TEF_Ativo) then
  Begin
    ConfigAtivaTEF;
  End;

  Pc_AtivaEstabelecimento;
  MenuOperMenuFiscal.Visible  := Gb_PAF_NFE_e;//( DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString = 'SC' );
End;

procedure TFr_FrenteCaixa.Pc_Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
begin
  //Pedido
  Lc_Vl_Total := 0;
  Lc_Vl_aux := StrToFloatDef(E_Vl_Pedido.Caption, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_Vl_Pedido.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Desconto
  Lc_Vl_aux := StrToFloatDef(E_VL_Desconto.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total - Lc_Vl_aux;
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Valor total
  E_Vl_Total.Caption := FloatToStrF(Lc_Vl_Total, ffFixed, 10, 2);
  //Quantidade
  E_Quantidade.Caption := FloatToStrF(It_Qt_Produtos, ffFixed, 10, 0);
end;

procedure TFr_FrenteCaixa.Pc_AbreTelaProdutoAvulso;
Var
  Form : TFr_FrenteCaixaProdAvulso;
Begin
  try
    Form := TFr_FrenteCaixaProdAvulso.Create(nil);
    Form.E_Qt_Avulso.Text := '1,00';
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Fc_BuscarProduto(It_Cd_ProdutoAvulso,'PRO_CODIGO','');
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Form.E_Avl_Descricao.Text,
                            StrToFloatDef(Form.E_Qt_Avulso.Text,0),
                            StrToFloatDef(Form.E_Vl_Avulso.Text,0),
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            '',
                            '');
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_FrenteCaixa.Pc_AbreTelaProdutoSemRegistro(Pc_Descricao,Pc_Unidade,Pc_VL_Unitario:String);
Var
  Form : TFr_FrenteCaixaProdSemRegistro;
Begin
  try
    Form := TFr_FrenteCaixaProdSemRegistro.Create(nil);
    Form.E_Avl_Descricao.Text := Pc_Descricao;
    Form.E_Avl_Medida.Text := Pc_Unidade;
    Form.E_Avl_Vl_Unitario.Text := Pc_VL_Unitario;
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Form.E_Avl_Descricao.Text,
                            StrToFloatDef(Form.E_Avl_Qtde.Text,0),
                            StrToFloatDef(Form.E_Avl_Vl_Unitario.Text,0),
                            Form.E_Avl_Medida.Text,
                            0,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            '',
                            '');
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    End;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_FrenteCaixa.Pc_AbreTelaBalanca;
Var
  Form : TFr_FrenteCaixaPesoBalanca;
Begin
  try
    Form := TFr_FrenteCaixaPesoBalanca.Create(nil);
    Form.E_Vl_Unitario.Text := FloatToStrF(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,ffFixed,10,2);
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            StrToFloatDef(Form.E_Peso_Liquido.Caption,1),
                            StrToFloatDef(Form.E_Vl_Unitario.Text,0),
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            '',
                            '');
      SB_Cliente.Enabled := True;
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    End;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_FrenteCaixa.Pc_AbreTelaBalancaManual;
Var
  Form : TFr_FrenteCaixaPesoManual;
Begin
  try
    Form := TFr_FrenteCaixaPesoManual.Create(nil);
    Form.E_Peso_LiquidoManual.Text := '0,00';
    Form.E_Vl_UnitarioManual.Text := FloatToStrF(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,ffFixed,10,2);
    Form.E_Vl_PesoManual.Caption := '0,00';
    Form.ShowModal;
    if Form.Confirma then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            StrToFloatDef(Form.E_Peso_LiquidoManual.Text,1),
                            StrToFloatDef(Form.E_Vl_UnitarioManual.Text,0),
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            '',
                            '');

      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_FrenteCaixa.Pc_PreencheProdutoCodigoReduzido(Pc_Cd_Produto:String);
Var
  Lc_Nr_Registro:Integer;
Begin
  IF It_Usa_Cd_Fabrica then
    Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGOFAB','')
  else
    Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGO','');
    
  if (Lc_Nr_Registro = 1) then
  begin
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      if (Upper(Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString) = 'KG')then
      Begin
        if It_Usa_Balanca then
          Pc_AbreTelaBalanca
        else
          Pc_AbreTelaBalancaManual;
      end
      else
      Begin
        Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                              Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                              Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                              StrToFloatDef(TrataQtde(E_Qtde.Text),1),
                              Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                              Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                              Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                              Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                              Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                              Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                              '',
                              '');
        Pc_Promocao(StrGrd_Produtos.Cells[13,It_Nr_Item],
                    StrToFloatDef(StrGrd_Produtos.Cells[15,It_Nr_Item],0),
                    StrToFloatDef(StrGrd_Produtos.Cells[16,It_Nr_Item],0));

        //totaliza os itens na tela
        Pc_SomaProdutos;
        Pc_Totalizador;
        Pc_ImprimeItemCheckout;
        //Limpa os campos
        if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
        E_BuscaCodigo.Clear;
      end;
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

function TFr_FrenteCaixa.Fc_PreencheProdutoCodigoBarrasBalanca(Pc_Cd_Barras:String):Boolean;
Var
  Lc_Cd_produto,Lc_StrPreco, Lc_StrPeso : String;
  Lc_Peso : Real;
  Lc_Preco : Real;
  Lc_Nr_Registro:Integer;
Begin
  Result := True;
  Lc_Cd_produto := Copy(E_BuscaCodigo.Text,2,BalBarraCodigoProduto);
  Lc_Cd_produto := IntToStr( StrToIntDef(Lc_Cd_produto,0) );
  IF (It_Usa_Cd_Fabrica)then
    Lc_Nr_Registro := Fc_BuscarProduto(Lc_Cd_produto,'PRO_CODIGOFAB','KG')
  else
    Lc_Nr_Registro := Fc_BuscarProduto(Lc_Cd_produto,'PRO_CODIGO','KG');
  if (Lc_Nr_Registro = 1) then
  begin
    //SE O TIPO DE LEITURA É POR PESO ENTÃO O PRODUTO PRECISA TER PREÇO PARA CALCULAR
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      if BalBarraTipo = 'P' then
      Begin
        Lc_StrPreco := Copy(E_BuscaCodigo.Text,BalBarraCodigoProduto + 2 ,BalBarraPrecoPeso );
        //Colocando a Virgula
        Lc_StrPreco := Copy(Lc_StrPreco,1,BalBarraPrecoPeso-2)+','+Copy(Lc_StrPreco,BalBarraPrecoPeso-1,2);
        Lc_Peso := StrToFloatDEf(Lc_StrPreco,1) / Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency;
      End
      else
      Begin
        Lc_StrPeso := Copy(E_BuscaCodigo.Text,BalBarraCodigoProduto + 2 ,BalBarraPrecoPeso );
        //Colocando a Virgula
        Lc_StrPeso := Copy(Lc_StrPeso,1,2) +','+Copy(Lc_StrPeso,3,4);
        Lc_Peso := StrtoFloatDef(Lc_StrPeso,1);
      End;

      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            Lc_Peso,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            '',
                            '');
      Pc_Promocao(StrGrd_Produtos.Cells[13,It_Nr_Item],
                  StrToFloatDef(StrGrd_Produtos.Cells[15,It_Nr_Item],0),
                  StrToFloatDef(StrGrd_Produtos.Cells[16,It_Nr_Item],0));
      //totaliza os itens na tela
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      //Limpa os campos
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  end
  else
  Begin
    Result := False;
  end;
end;

procedure TFr_FrenteCaixa.Pc_PreencheProdutoCodigoBarras(Pc_Cd_Barras:String);
Var
  Lc_Nr_Registro:Integer;
Begin
  Lc_Nr_Registro := Fc_BuscarProduto(E_BuscaCodigo.Text,'PRO_CODIGOBAR','');
  if (Lc_Nr_Registro = 1) then
  begin
    if (Fc_ValidaPreencheProduto(Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency)) then
    Begin
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            StrToFloatDef(TrataQtde(E_Qtde.Text),1),
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            '',
                            '');
      Pc_Promocao(StrGrd_Produtos.Cells[13,It_Nr_Item],
                  StrToFloatDef(StrGrd_Produtos.Cells[15,It_Nr_Item],0),
                  StrToFloatDef(StrGrd_Produtos.Cells[16,It_Nr_Item],0));
      //totaliza os itens na tela
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      //Limpa os campos
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
    end;
  end
  else
  Begin
    ProdutoDifDeUm(Lc_Nr_Registro);
  end;
end;

procedure TFr_FrenteCaixa.ProdutoDifDeUm(Nr_Registro:Integer);
Begin
  if (Nr_Registro > 1) then
  begin
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    Pc_MostraBusca;
  end
  else
  Begin
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    ShowMessage('Produto Não encontrado');
  end;
end;

procedure TFr_FrenteCaixa.ProgramaPAYBACK1Click(Sender: TObject);
Var
  Lc_Form:TSeaPAyBack;
begin
  Try
    Lc_Form := TSeaPAyBack.Create(nil);
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form)
  end;
end;

procedure TFr_FrenteCaixa.MnuSalvarComandaClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja salvar esta venda em uma Comanda'+EOLN+EOLN+
                     'Confirmar a operação ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    SalvarCommand;
end;

procedure TFr_FrenteCaixa.MnuSalvarDeliveryClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja salvar esta venda para o Delivery?'+EOLN+EOLN+
                     'Confirmar a operação ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    SalvarDelivery;
end;

procedure TFr_FrenteCaixa.SalvaItemsComanda;
Var
  I : Integer;
  LcCmdItems : TControllerCheckOutItems;
begin
  try
    LcCmdItems := TControllerCheckOutItems.Create(nil);
    LcCmdItems.Registro.Estabelecimento := Gb_CodMha;
    LcCmdItems.Registro.Pedido          := Pedido.Registro.Codigo;
    //Apaga os itens da Comanda para reinserir
    LcCmdItems.deleteByOrder;
    //Insere os itens da Lista atualizada
    with LcCmdItems, StrGrd_Produtos do
    Begin
      for I := 1 to ( RowCount - 1 ) do
      begin
        Registro.Codigo          := StrToIntDef( Cells[1, I],0);
        Registro.Estabelecimento := Gb_CodMha;
        Registro.Pedido          := Pedido.Registro.Codigo;
        Registro.CodigoProduto   := StrToIntDef( Cells[2, I] ,0 );
        Registro.Unidade         := Cells[8, I];
        Registro.DescProduto     := Cells[4, I];
        Registro.Quantidade      := StrToFloatDef( Cells[5, I],0 );
        Registro.ValorUnitario   := StrToFloatDef( Cells[6, I],0 );
        Registro.CodigoFabrica   := Cells[3, I];
        Registro.PrecoCusto      := StrToFloatDef( Cells[9, I],0 );
        Registro.Ncm             := Cells[11, I];
        Registro.Origem          := Cells[12, I];
        Registro.PromoCodigo     := StrToIntDef( Cells[13,I],0);
        Registro.PromoQtde       := StrToFloatDef( Cells[15, I],0 );
        Registro.PromoPreco      := StrToFloatDef( Cells[16, I],0 );
        Registro.PromoOriginal   := StrToFloatDef( Cells[14, I],0 );
        LcCmdItems.insere;
      End;
    end;
  finally
    FreeAndNil(LcCmdItems)
  end;
end;

procedure TFr_FrenteCaixa.SalvarCommand;
Var
  LcCmd : TControllerCommand;
  Form : TFr_Command;
begin
  try
    if Pedido.Registro.Codigo = 0 then
      Pc_GeraPedido(1);
    LcCmd := TControllerCommand.Create(nil);
    LcCmd.Registro.Estabelecimento := Gb_CodMha;
    LcCmd.Registro.Pedido := Pedido.Registro.Codigo;
    LcCmd.Registro.DataRegistro := Now;
    LcCmd.getbyKey;
    if not LcCmd.exist then
    Begin
      try
        Form := TFr_Command.Create(nil);
        Form.Command := LcCmd;
        Form.ShowModal;
      finally
        FreeAndNil(Form);
      end;
    End;
    SalvaItemsComanda;
    limparTela;
  finally
    FreeAndNil(LcCmd);
  end;
end;

procedure TFr_FrenteCaixa.SalvarDelivery;
Var
  Form : TTasDelivery;
  Lc_Handle : hwnd;
begin
  try
    Form := TTasDelivery.Create(nil);
    IF (It_Cd_Cliente <> It_Cd_Consumidor) then
      Form.CodigoRegistro := It_Cd_Cliente
    else
      Form.CodigoRegistro := 0;
    Form.ShowModal;
    if Form.cliente.Registro.Codigo > 0 then
    Begin
      It_Cd_Cliente := Form.cliente.Registro.Codigo;
      Pedido.registro.ValorFrete := Form.cliente.Registro.ValorEntrega;
      Pc_GeraPedido(4);
      Pedido.SaveAddressDelivery;
    End
    else
    Begin
      It_Cd_Cliente := It_Cd_Consumidor;
      Pedido.registro.ValorFrete := 0;
      Pc_GeraPedido(1);
      Pedido.DeleteAddressDelivery;
    End;
  finally
    FreeAndNil(Form);
    self.Enabled := True;
    self.Activate;
    SetWindowPos(Lc_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);
    Pc_PosicionaCliente;
    if E_Qtde.CanFocus then
      E_Qtde.SetFocus
    else
      if E_BuscaCodigo.CanFocus then
        E_BuscaCodigo.SetFocus;
  end;
end;

procedure TFr_FrenteCaixa.MnuPromocesClick(Sender: TObject);
Var
  Form : TseaPromotion;
begin
  if Fc_VerificaPermissao('seaPromotion','Promoções','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    try
      Form := TseaPromotion.create(nil);
      Form.Showmodal;
    finally
      FreeAndNil(Form);
    end;
  End;
end;

function TFr_FrenteCaixa.Fc_CarregaPedidoBalcao(Fc_Cd_Pedido,
  Fc_Nr_Pedido: Integer): Boolean;
Var
  I : Integer;
Begin
  pedido.Clear;
  with Pedido do
  begin
    Registro.CodigoEstabelecimento := Gb_CodMha;
    if Fc_Cd_Pedido > 0 then
    Begin
      Registro.Codigo := Fc_Cd_Pedido;
      getbyId
    end
    else
    Begin
      Registro.Tipo := 1;
      Registro.Numero := Fc_Nr_Pedido;
      getIdByNumero;
    end;
    if not pedido.exist then
    Begin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'Pedido não encontrado.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      exit;
    end;

    if Registro.Faturado = 'S' then
    Begin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     '   Pedido já faurado.' + EOLN +
                     'Não é possivel Carregar.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      exit;
    end;
    E_Vl_Desconto.Text := FloatToStrF( Registro.ValorDesconto,ffFixed,10,2);
    //Carrega os dados dos itens do pedido
    Itens.Registro.CodigoPedido := Registro.Codigo;
    Itens.getList;
    if Itens.Lista.Count = 0 then
    BEgin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'Não há itens neste Pedido.' + EOLN +
                     'Ele pode ser reutilizado mas será necessário inserir os itens.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      exit;
    End;
    It_Nr_Item := 0;
    with StrGrd_Produtos, itens do
    Begin
      for I := 0 to Itens.Lista.Count -1 do
      Begin
        //Pega o Produto
        Produto.Registro.Codigo := lista[I].CodigoProduto;
        Produto.getbyId;
        //Pega a Medida
        Produto.Medida.Registro.Codigo := Produto.Registro.MedidaComercial;
        Produto.Medida.getbyId;

        Pc_PreencheItensVenda(Produto.Registro.Codigo.ToString,
                              Produto.Registro.CodigoFabrica,
                              Produto.Registro.Descricao,
                              Lista[I].Quantidade,
                              Lista[I].ValorUnitario,
                              Produto.Medida.Registro.Abreviatura,
                              Produto.Registro.ValorCusto,
                              Produto.Registro.CodigoNCM,
                              Produto.Registro.Origem,
                              Lista[I].ValorUnitario,
                              '',
                              '');
      end;
    End;
    StrGrd_Produtos.Row := StrGrd_Produtos.RowCount - 1;
    E_Qtde.Text := '1';
    Pc_SomaProdutos;
    Pc_Desconto('V');
    Pc_Totalizador;
  end;

end;

function TFr_FrenteCaixa.Fc_LancaItem:Boolean;
begin
  Result := False;
  if Length(Trim(E_BuscaCodigo.Text)) > 0 then
  Begin
    Result := True;
    //Busca Pelo Codigo Reduzido
    if Length(Trim(E_BuscaCodigo.Text)) <= 6 then
    Begin
      if (Length(Trim(E_BuscaCodigo.Text)) = 4) and ( Copy(Trim(E_BuscaCodigo.Text),1,1) ='0') then
      Begin
        CarregaItensCommand( getPedidoByCommand( E_BuscaCodigo.Text ) );
        if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
        E_BuscaCodigo.Clear;
      End
      else
      Begin
        Pc_PreencheProdutoCodigoReduzido(E_BuscaCodigo.Text);
        Result := True;
      End;
    end
    else
    Begin
      //VErifica se o codigo de barras é de balança
      if (Copy(E_BuscaCodigo.Text,1,1) = '2') and (Length(E_BuscaCodigo.Text)< 14) then
      Begin
        Result := Fc_PreencheProdutoCodigoBarrasBalanca(E_BuscaCodigo.Text);
        if not Result then
        Begin
          Pc_PreencheProdutoCodigoBarras(E_BuscaCodigo.Text);
          Result := True;
        end;
      end
      else
      Begin
        Pc_PreencheProdutoCodigoBarras(E_BuscaCodigo.Text);
        Result := True;
      end;
    end;
  end;
end;

Function TFr_FrenteCaixa.Fc_StatusTecla (Key: integer): boolean;//função para desabilitar alt+f4
begin
  Result := Odd (GetKeyState (Key)); //Result := se a tecla for pressionada
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF2();
Begin
 if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF3();
Begin
  If It_Usa_ProdutoAvulso then
  Begin
    Pc_AbreTelaProdutoAvulso;
  end
  else
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O uso de produto avulso no sistema não foi encontrado.'+EOLN+
                   'ou o produto está inativado.'+EOLN+
                   'Verifique com o Administrador do Sistema.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF4();
Begin
  if SB_Desconto.Enabled then
    SB_DescontoClick(Self);
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF5();
Begin
  if Pnl_TabelaPreco.Visible then
  Begin
    Sb_Confirma_TabelaPrecoClick(Self);
    exit;
  end;
  if SB_Cliente.Enabled then
  Begin
    SB_ClienteClick(Self);
    exit;
  end;
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF6();
Begin
  if SB_Pesquisa.Enabled then SB_PesquisaClick(Self);
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF7();
Begin
  if Sb_ExcluiItem.Enabled then Sb_ExcluiItemClick(Self);
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF8();
Begin
  if Sb_ExcluiVenda.Enabled then Sb_ExcluiVendaClick(Self);
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF9();
Begin
  if SB_Faturar.Enabled then SB_FaturarClick(Self);
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF10();
Begin
  if Sb_logout.Enabled then Sb_logoutClick(Self);
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF11();
Var
  Lc_Form : TFr_Liberacao;
Begin
  if FTeclaF11Bloqueada then
  Begin
    E_Qtde.Text := '1';
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'O campo quantidade foi bloqueado pelo Administrador.' + EOLN +
                   '      Você deve informar item a item ou.' + EOLN +
                   '    Solicite autorização e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    try
      Lc_Form := TFr_Liberacao.Create(nil);
      Lc_Form.Liberado := False;
      Lc_Form.It_Interface := 'Fr_FrenteCaixa';
      Lc_Form.It_Nome_Menu := 'Frente de Caixa';
      Lc_Form.It_Privilegio := 'AUTORIZAR';
      Lc_Form.FLogOperacao := 'Liberação do Campo Quantidade';
      Lc_Form.FLogDEscricao := 'Autorizada o desbloqueio do campo Quantidade';

      Lc_Form.ShowModal;
      if Lc_Form.Liberado then
      Begin
        E_Qtde.ReadOnly := False;
        if E_Qtde.CanFocus then E_Qtde.SetFocus;
        E_Qtde.Clear;
        //Para bloquear o GbLiberado precisa ser usuario normal
        if (Gb_Liberado) and (Gb_Nivel = 0) then
        Begin
          Gb_Liberado := False;
        end;
      End;
    finally
      FreeAndNil(Lc_Form);
    end;
  End
  else
  Begin
    if E_Qtde.CanFocus then E_Qtde.SetFocus;
    E_Qtde.Clear;
  End;
end;


procedure TFr_FrenteCaixa.Pc_TeclaAtalhoF12();
Begin
  EscolheTabela;
end;

procedure TFr_FrenteCaixa.Pc_TeclaAtalhoEscape();
Begin
  if Pnl_TabelaPreco.Visible then
  Begin
    Sb_Cancela_TabelaPrecoClick(Self);
    exit;
  end;
end;

procedure TFr_FrenteCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    If  Fc_StatusTecla (VK_LMENU) And (Key = VK_F4)and (E_Status.Caption = 'Aberto') Then //Se esc e Alt+f4 for apertada
      self.close;


    case Key of
      VK_F2: Pc_TeclaAtalhoF2();
      VK_F3: Pc_TeclaAtalhoF3();
      VK_F4: Pc_TeclaAtalhoF4();
      VK_F5:Pc_TeclaAtalhoF5();
      VK_F6:Pc_TeclaAtalhoF6();
      VK_F7:Pc_TeclaAtalhoF7();
      VK_F8:Pc_TeclaAtalhoF8();
      VK_F9:Pc_TeclaAtalhoF9();
      VK_F10:Pc_TeclaAtalhoF10();
      VK_F11:Pc_TeclaAtalhoF11();
      VK_F12:Pc_TeclaAtalhoF12();
      VK_ESCAPE:Pc_TeclaAtalhoEscape();
    end;
  end;
end;

procedure TFr_FrenteCaixa.Pc_SomaProdutos;
var
  Lc_I: Integer;
  Lc_Qtde : Real;
  Lc_Vl_Pedido : Real;
  Lc_VL_Original : real;
  Lc_VL_Venda : real;
  Lc_VL_Tl_Original : Real;
  Lc_VL_Tl_Venda : Real;
  Lc_Vl_Subtotal : Real;
begin
  Lc_Vl_Pedido := 0;
  It_Qt_Produtos := 0;
  Lc_VL_Tl_Original := 0;
  for Lc_I := 1 to StrGrd_Produtos.RowCount - 1 do
  begin
    Lc_Qtde := StrToFloatDef(StrGrd_Produtos.Cells[5, LC_I], 0);
    if (Lc_Qtde > 0) and (Lc_Qtde < 1) then
      It_Qt_Produtos := It_Qt_Produtos + 1
    else
      It_Qt_Produtos := It_Qt_Produtos + Lc_Qtde;
    Lc_Vl_Subtotal := StrToFloatDef(StrGrd_Produtos.Cells[7, LC_I],0);

    Lc_Vl_Pedido := Lc_Vl_Pedido + Lc_Vl_Subtotal;
    //Soma os Valores da Coluna Original para saber se houve economia
    //Se for Produto avulso não soma
    if not (It_Cd_ProdutoAvulso = StrGrd_Produtos.Cells[2, LC_I]) then
    Begin
      Lc_VL_Venda := StrToFloatDef(StrGrd_Produtos.Cells[6, LC_I], 0);
      Lc_VL_Original := StrToFloatDef(StrGrd_Produtos.Cells[14, LC_I], 0);
      //O Valor Original deve ser maior do que zero e maior do que o valor vendido
//      if (Lc_VL_Original > 0 ) and (Lc_VL_Original > Lc_VL_Venda) then
//        Lc_VL_Tl_Original := Lc_VL_Tl_Original + (Lc_VL_Original * Lc_Qtde);
      Lc_VL_Tl_Original := Lc_VL_Tl_Original + (Lc_VL_Original * Lc_Qtde);
      Lc_VL_Tl_VEnda := Lc_VL_Tl_Venda + (Lc_VL_Venda * Lc_Qtde);
    End;
  end;
  Lc_Vl_Pedido := RoundTo(Lc_Vl_Pedido,-2);
  E_Vl_Pedido.Caption := FloatToStrF(Lc_Vl_Pedido,ffFixed,10,2);
//  if (Lc_VL_Tl_Original - Lc_Vl_Pedido ) > 0 then
    if  Lc_VL_Tl_Original>Lc_VL_Tl_VEnda then
    E_Vl_Economia.Caption := FloatToStrF(Lc_VL_Tl_Original - Lc_VL_Tl_VEnda,ffFixed,10,2)
  else
    E_Vl_Economia.Caption := '0,00';
end;

procedure TFr_FrenteCaixa.Pc_LimpaCampos;
begin
  Pedido.clear;
  E_Vl_Pedido.Caption := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_Vl_Desconto.Text := '0,00';
  E_VL_Total.Caption := '0,00';
  E_Usuario.Caption := GB_Nm_Usuario;
  Lb_Item_lancado.Caption := 'Lançar item';
  ObservacaoPedido := '';
  It_Nr_Item := 0;
  FreeAndNil(ListaPedidoItem);
  ListaPedidoItem := TListaItemVenda.create;
end;


procedure TFr_FrenteCaixa.SB_ClienteClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Empresa;
  Lc_Handle : hwnd;
begin
  Lc_Form := TFr_Pesq_Empresa.Create(nil);
  try
    self.Enabled := False;
    It_Cd_Cliente := It_Cd_Consumidor;
    Lc_Form.TipoEmpresa := 1;
    Lc_Form.ShowModal;
    if Lc_Form.Qr_Pesquisa.RecordCount > 0 then
    Begin
      If (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Deseja registrar a venda para o cliente ' + Lc_Form.Qr_Pesquisa.FieldByName('EMP_NOME').AsString + '.'+EOLN+EOLN+
                         'Confirmar a alteração ?',
                         [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clBtnFace) = mrBotao1) then
      Begin
        It_Cd_Cliente := Lc_Form.Qr_Pesquisa.FieldByName('EMP_CODIGO').AsInteger;
      end;
    end;
  finally
    FreeAndNil(Lc_Form);
    self.Enabled := True;
    self.Activate;
    SetWindowPos(Lc_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);
    IF (It_Cd_Cliente <> It_Cd_Consumidor) then
      Pc_PosicionaCliente;

    if E_Qtde.CanFocus then
      E_Qtde.SetFocus
    else
      if E_BuscaCodigo.CanFocus then
        E_BuscaCodigo.SetFocus;
  end;
end;

procedure TFr_FrenteCaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( ListaPedidoItem );
  FreeAndNil( Pedido );
  FreeAndNil( CtrlTEF );
  FreeAndNil( Promocao );
  OcultaBarraTarefas(False);
  Action := caFree;
end;

procedure TFr_FrenteCaixa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not forcafechamento then
  BEgin
    //Valida Abertura
    if ValidaItensNaLista then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                     '    Existe uma venda em Aberto.' + EOLN +
                     'Exclua primeiro e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      canClose := False;
      exit;
    end;

    if (MensagemPadrao(TITULO_CONFIRMACAO,
                        'Deseja realmente sair do Tela de Frente de Caixa ?' + EOLN + EOLN +
                        'Confirmar a saida ?',
                        [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao2) then
    begin
       canClose := False;
    end;
  End;
end;

procedure TFr_FrenteCaixa.FormCreate(Sender: TObject);
begin
  InitVariable;
end;

procedure TFr_FrenteCaixa.StrGrd_ProdutosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
  Lc_str_comp_1,  Lc_str_comp_2:real;
begin
  with StrGrd_Produtos do
  Begin
    if (arow > 0) and (acol > 0) then // testa se não é a primeira linha (fixa)
      if (odd(arow)) then
      begin // verifica se a linha impar
        Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := clCream;
      end
      else
      begin
        Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := clScrollBar;
      end;
    Canvas.FillRect(Rect); // redesenha a celula
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Cells[acol, arow]); // reimprime o texto.


    { Pega o texto da célula }
    Texto := Concat(Cells[acol, ARow], '  ');
    { Calcura largura e altura (em pontos) do texto }
    LarguraTexto := Canvas.TextWidth(Texto);
    AlturaTexto := Canvas.TextHeight(Texto);

    { Calcula a posição horizontal do início do texto }
    if (ACol = 2) or (ACol = 3) or (ACol = 4)or (ACol = 18) then { Esquerda }
      X := Rect.Left + 2
    else if ACol = 1 then { Centro }
      X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
        LarguraTexto div 2
    else { Direita }
      X := Rect.Right - LarguraTexto - 2;

    { Calcula a posição vertical do início do texto para
      que seja impresso no centro (verticalmente) da célula }
    Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
      AlturaTexto div 2;

    { Pinta o texto }
//    Canvas.Font.Size := 14;
//    Canvas.Font.Style:= [fsBold];
    Canvas.TextRect(Rect, X, Y, Texto);

    if (ACol = 1) then
    Begin
      if (arow > 0) and (trim(Texto) <> '')then
      Begin
        if (StrToIntDef(Cells[13,ARow],0) > 0) then
        Begin
            try
              Bitmap:=TBitmap.Create;
              if (Cells[20,ARow] = 'S') then
              //if AnsiCompareText(Lc_str_comp_1,Lc_str_comp_2 ) = 0 then
                ImageList1.GetBitmap(0,bitmap)
              else
                ImageList1.GetBitmap(1,bitmap);
              Canvas.StretchDraw(CellRect(0,ARow),Bitmap);
            finally
              FreeAndNil(Bitmap);
            End;
        End;

        {
        if (StrToIntDef(Cells[13,ARow],0) > 0) then
        Begin
            try
              Bitmap:=TBitmap.Create;
              Lc_str_comp_1 := RoundTO(StrToFloatDef(Cells[6,ARow],0),-2);
              Lc_str_comp_2 := RoundTO(StrToFloatDef(Cells[16,ARow],0),-2);
              if (Lc_str_comp_1 = Lc_str_comp_2) then
              //if AnsiCompareText(Lc_str_comp_1,Lc_str_comp_2 ) = 0 then
                ImageList1.GetBitmap(0,bitmap)
              else
                ImageList1.GetBitmap(1,bitmap);
              Canvas.StretchDraw(CellRect(0,ARow),Bitmap);
            finally
              FreeAndNil(Bitmap);
            End;
        End;
        }
      end;
    End;
  End;
end;


procedure TFr_FrenteCaixa.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_LimpaCampos;
end;

function TFr_FrenteCaixa.getPedidoByCommand(CommandID:String): Integer;
Var
  LcCommand : TControllerCommand;
begin
  Try
    LcCommand := TControllerCommand.create(nil);
    LcCommand.Registro.Estabelecimento := Gb_CodMha;
    LcCommand.Registro.Numero := CommandID;
    LcCommand.getByComandaLivre;
    if LcCommand.exist then
    Begin
      Result := LcCommand.Registro.Pedido;
    End
    else
    Begin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'Commanda não encontrada.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := 0;
    End;
  Finally
    FreeAndNil(LcCommand);
  End;
end;

procedure TFr_FrenteCaixa.GuardaListaProdutos(ListaItem : TListaItemVenda;Promocao:String);
Var
  I,J :Integer;
  ItemVenda : TItemVenda;
  LcSomaItem : Real;
begin
  for I := 1 to (StrGrd_Produtos.RowCount - 1) do
  Begin
    //Se for da Promoção podemos alterar a aquantidade confomre a sma e o valor da prmoção
    if ( Promocao = StrGrd_Produtos.Cells[13,I] ) then
    Begin
      ItemVenda := TItemVenda.Create;
      ItemVenda.Produto       := StrToIntDef(StrGrd_Produtos.Cells[2, I],0);
      ItemVenda.ValorOriginal := StrToFloatDef(StrGrd_Produtos.Cells[14, I],0);
      ItemVenda.ValorCusto    := StrToFloatDef(StrGrd_Produtos.Cells[9, I],0);
      ItemVenda.Fabrica       := StrGrd_Produtos.Cells[3, I];
      ItemVenda.Descricao     := StrGrd_Produtos.Cells[4, I];
      ItemVenda.Quantidade    := StrToFloatDef(StrGrd_Produtos.Cells[5, I],0);
      ItemVenda.ValorVenda    := StrToFloatDef(StrGrd_Produtos.Cells[16, I],0);  //Cells[16
      ItemVenda.ncm           := StrGrd_Produtos.Cells[11, I];
      ItemVenda.Abreviatura   := StrGrd_Produtos.Cells[8, I];
      ItemVenda.Promocao      := StrGrd_Produtos.Cells[13, I];
      ItemVenda.QtdePromocao  := StrToFloatDef(StrGrd_Produtos.Cells[15, I],0);
      ItemVenda.PRecoPromocao := StrToFloatDef(StrGrd_Produtos.Cells[16, I],0);
      ItemVenda.TotalPromocao := StrToFloatDef(StrGrd_Produtos.Cells[19, I],0);
      //Soma a quantidade de todos os itens iguais a este
      LcSomaItem := 0;
      for J := 1 to (StrGrd_Produtos.RowCount - 1) do
      Begin
        if ( ItemVenda.Produto = StrToIntDef(StrGrd_Produtos.Cells[2,J],0) ) then
          LcSomaItem := LcSomaItem + StrToFloatDef(StrGrd_Produtos.Cells[5,J],0);
      End;
      //Accumula toda a quantidade em apenas um registro
      ItemVenda.Quantidade := LcSomaItem;
      ListaItem.Add(ItemVenda);
      //Delata os Itens iguais da lista
      EliminaItemDaGRid(StrGrd_Produtos,ItemVenda.Produto.ToString);
      GuardaListaProdutos(ListaItem,Promocao);
    End;
  End;
end;

procedure TFr_FrenteCaixa.E_Vl_DescontoExit(Sender: TObject);
begin
  Pc_Desconto('V');
  Pc_Totalizador;
end;

procedure TFr_FrenteCaixa.E_Aq_DescontoExit(Sender: TObject);
beGIN
  Pc_Desconto('A');
  Pc_Totalizador;

end;

Function TFr_FrenteCaixa.FC_Valida_ImpostoAproximado:boolean;
var
  lc_obs : TMemo;
  Lc_Imp_Aprox :TStringList;
  Lc_I:Integer;
Begin
  Try
    Result:=true;
    Lc_obs := TMemo.Create(Self);
    Lc_obs.Visible := false;
    Lc_obs.Parent := self;
    Lc_Imp_Aprox := TStringList.Create;
    For Lc_I := 1 to StrGrd_Produtos.RowCount-1 do
    Begin
      Fc_ImpostoAproximado(Lc_Imp_Aprox,StrGrd_Produtos.cells[11,StrGrd_Produtos.Row],
                                          StrGrd_Produtos.cells[12,StrGrd_Produtos.Row]);

      if (StrToFloatDef(Lc_Imp_Aprox.Strings[3],0) = 0) then
      Begin
        Result := False;
        lc_obs.Lines.Add(StrGrd_Produtos.cells[2,StrGrd_Produtos.Row] + ' - ' + StrGrd_Produtos.cells[4,StrGrd_Produtos.Row]);
      end;
    end;

    If not Result then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Problemas com os as informações do Imposto CF. Lei 12.741/12.'+EOLN+EOLN+
                     lc_obs.Text,
                     ['OK'],[bEscape],mpAlerta);
    end;
  Finally
    FreeAndNil(Lc_Imp_Aprox);
    FreeAndNil(lc_obs);
  End;
end;

procedure TFr_FrenteCaixa.FechamentoVendas1Click(Sender: TObject);
Var
  LcForm : TFr_Imp_Fechamento;
begin
  if Fc_VerificaPermissao('Fr_FrenteCaixa','Frente de Caixa - ECF','FechamentoVendas',GB_Cd_Usuario,'S') then
  Begin
    try
      LcForm := TFr_Imp_Fechamento.Create( nil );
      LcForm.ShowModal;
    finally
      FreeAndNil(LcForm);
    end;
  End;
end;

function  TFr_FrenteCaixa.Fc_ValidaFaturamento:boolean;
Begin
  Result := true;
  if not ValidaItensNaLista then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não há itens na lista de venda.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result:=false;
    exit;
  End;

  if not Fc_ValidaDesconto(StrToFloatDef(E_Vl_Pedido.Caption,0),StrToFloatDef(E_VL_Desconto.Text,0),'000') then
  Begin
    E_Aq_Desconto.Text := '0,00';
    E_Aq_DescontoExit(Self);
    Result:=false;
    exit;
  end;

  if StrToIntDef(E_Cd_Cliente.Text,0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Código do cliente não informado.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    if E_Cd_Cliente.CanFocus then E_Cd_Cliente.SetFocus;
    Result := false;
    exit;
  end;


  if It_NFCe then
  Begin
    if not FC_Valida_ImpostoAproximado then
    Begin
      Result := False;
      exit;
    end;
  end;

  if (E_VL_Total.Caption = '0,00') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O valor total não pode ser igual a Zero'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := false;
    exit;
  end;
end;

procedure TFr_FrenteCaixa.Pc_FaturamentoNormal;
Var
  I : Integer;
  LcItemCopia : TItemVenda;
  LcForm :TFr_Cupom_Fiscal;
  LcVLPedido : Real;
  Lc_Vl_Economia : Real;


begin
  if Fc_ValidaFaturamento then
  Begin
    //Cria o Panel para Colocar o form de faturamento
    Pc_GeraPedido(0);
    Pc_GeraItensPedido;
    try
      LcForm  := TFr_Cupom_Fiscal.Create(nil);
      LcForm.ListaPedidoItem.Clear;
      for I := 0 to Self.ListaPedidoItem.Count -1 do
      Begin
        LcItemCopia := TItemVenda.Create;
        LcItemCopia.Produto       := Self.ListaPedidoItem.Items[I].Produto;
        LcItemCopia.Fabrica       := Self.ListaPedidoItem.Items[I].Fabrica;
        LcItemCopia.Descricao     := Self.ListaPedidoItem.Items[I].Descricao;
        LcItemCopia.Quantidade    := Self.ListaPedidoItem.Items[I].Quantidade;
        LcItemCopia.ValorVenda    := Self.ListaPedidoItem.Items[I].ValorVenda;
        LcItemCopia.Abreviatura   := Self.ListaPedidoItem.Items[I].Abreviatura;
        LcItemCopia.ValorCusto    := Self.ListaPedidoItem.Items[I].ValorCusto;
        LcItemCopia.ncm           := Self.ListaPedidoItem.Items[I].ncm;
        LcItemCopia.Origem        := Self.ListaPedidoItem.Items[I].Origem;
        LcItemCopia.ValorOriginal := Self.ListaPedidoItem.Items[I].ValorOriginal;
        LcItemCopia.Promocao      := Self.ListaPedidoItem.Items[I].Promocao;
        LcItemCopia.QtdePromocao  := Self.ListaPedidoItem.Items[I].QtdePromocao;
        LcItemCopia.ItemPedido    := Self.ListaPedidoItem.Items[I].ItemPedido;
        LcItemCopia.PrecoPromocao := Self.ListaPedidoItem.Items[I].PrecoPromocao;
        LcItemCopia.AtingiuPromocao := Self.ListaPedidoItem.Items[I].AtingiuPromocao;
        LcForm.ListaPedidoItem.Add(LcItemCopia);
      End;
      //Passado direto para o objeto pedido
      //LcForm.ValorDesconto := StrToFloatDef(E_Vl_Desconto.Text,0);
      LcForm.It_Ctrl_Estoque := Self.It_Ctrl_Estoque;
      LcForm.It_Cd_Cliente := It_Cd_Cliente;
      LcForm.It_Pizzaria := False;
      LcForm.It_Cd_Pedido := Pedido.Registro.codigo;
      LcForm.It_Nr_Pedido := Pedido.Registro.Numero;
      LcVLPedido := StrToFloatDef(E_VL_TOTAL.Caption,0) + Pedido.Registro.ValorFrete;
      LcForm.E_VL_Total.Text := FloatToStrf(LcVLPedido,ffFixed,10,2);
      LcForm.It_NFCe := It_NFCe;
      Lc_Vl_Economia := StrToFloatDef(E_Vl_Economia.Caption,0);
      LcForm.ObservacaoNFCE := '';
      if ( Lc_Vl_Economia > 0) then
        LcForm.ObservacaoNFCE := concat('Você economizou nesta compra o valor de R$ ',FloatToStrF(Lc_Vl_Economia,ffFixed,10,2));
      if trim(ObservacaoPedido)<> '' then
      Begin
        LcForm.ObservacaoNFCE := concat(LcForm.ObservacaoNFCE,#13,ObservacaoPedido);
      End;

      LcForm.ShowModal;
      IF LcForm.It_Fatura_Ok then
      Begin
        E_VL_Troco.Caption := LcForm.E_VL_Troco.Text;
        limparTela;
      end
      else
      Begin
        //'Não faturou e recarregamos o pedido'
        //09-05-2019 - Não precisa reacarregar pois os objetos enviados não foram destuidos
        //Tanto o obejto pedido quanto a lista que foi enviada via ponteiro

      end;
    finally
      FreeAndNil(LcForm);
      Self.Update;
      Self.BringToFront;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    end;
  end;
end;

procedure TFr_FrenteCaixa.Pc_Pre_Venda;
Begin
  if Fc_ValidaFaturamento then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja gerar a venda deste pedido?' + EOLN + EOLN,
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      Pc_GeraPedido(0);
      Pc_GeraItensPedido;
      Pc_SomaProdutos;
      Pc_Totalizador;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Pedido gerado com Sucesso.' + EOLN + EOLN +
                     '      Nº ' + IntToStr(self.It_NR_Pedido) + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      IF (It_Cd_Cliente <> It_Cd_Consumidor) then
        Pc_PosicionaCliente;
      Pc_LimpaStringGrid(StrGrd_Produtos);
      Pc_LimpaCampos;
    end;
  end;
end;


procedure TFr_FrenteCaixa.EliminaItemDaGRid(Pc_strGrid: TStringGrid; Item: String);
var
   Lc_I, Lc_J: Integer;
   Lc_Lista: array of array of string;
   Lc_Linha: Integer;
begin
  Lc_Linha := 0;
  SetLength(Lc_Lista, Pc_strGrid.RowCount, Pc_strGrid.ColCount);

  //Guarda os dados difernetes do item
   for Lc_I := 1 to Pc_strGrid.RowCount - 1 do
   begin
      if ( Pc_strGrid.Cells[2,Lc_I] <> Item ) then
      begin
         Lc_Linha := Lc_Linha + 1;
         for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
            Lc_Lista[Lc_Linha, Lc_J] := Pc_strGrid.Cells[Lc_J, Lc_I];
      end;
   end;

  //Limpa a Matriz antes de incluir a diferenca
   for Lc_I := 1 to Pc_strGrid.RowCount - 1 do
      for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
         Pc_strGrid.Cells[Lc_J, Lc_I] := '';

   Pc_strGrid.RowCount := 2;
   It_Nr_Item := 0;
  //Grava novamente os dados que não foram marcados e que estão na matriz
   if (Lc_Linha > 0) then
   begin
      for Lc_I := 1 to Lc_Linha do
      begin
         Pc_strGrid.RowCount := Lc_I + 1;
         for Lc_J := 1 to Pc_strGrid.ColCount - 1 do
            Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I, Lc_J];
      end;
      It_Nr_Item := Lc_Linha;
   end;
end;

procedure TFr_FrenteCaixa.OrdenarListaItems(Lista: TListaItemVenda);
var
  comparison: TComparison<TItemVenda>;
  delegateComparer: TDelegatedComparer<TItemVenda>;
begin
  // método anonimo para ordenação crescente por ID
  comparison := function (const P1, P2: TItemVenda): Integer
    begin
      Result := - CompareValue(P1.Quantidade, P2.Quantidade);
    end;

  // método anonimo para ordenação decrescente por ID
  { comparison := function (const P1, P2: TPessoa): Integer
    begin
      Result := - CompareText(P1.Id, P2.Id);
    end; }

  // classe que implementa TComparer<T> e facilita o uso.
  // passe o método de comparação para o delegate!
  delegateComparer := TDelegatedComparer<TItemVenda>.Create(comparison);
  try
    // Usando método Sort da nossa lista passando nosso "ordenador"
    Lista.Sort(delegateComparer);
  finally
    FreeAndNil(delegateComparer);
  end;
end;

procedure TFr_FrenteCaixa.Pc_Promocao(Promocao : String;QtdePromocao:Real; preco : REal);
Var
  LcSomaQtde : Real;
  I,J : Integer;
  LcSomaItem : Real;
  LcMaiorQTde : Real;
  LcIndxCopia : Integer;
Label
  Reinicia;
begin
  with StrGrd_Produtos do
  Begin
    if ( Promocao <> '0' ) then
    Begin
      //Recoloca o valor de venda Original para tratar o caso de Exclussão
      {comentado em 05/10/2023
      for I := 1 to (RowCount - 1) do
      Begin
        if ( Promocao = Cells[13,I] ) then
        Begin
          Cells[6, I] := Cells[14, I];
        End;
      End;
      }
      //Faz a Soma para comparar com a quantidade da promoção
      LcSomaQtde := 0;
      for I := 1 to (RowCount - 1) do
      Begin
        if ( Promocao = Cells[13,I] ) then
        Begin
          LcSomaQtde := LcSomaQtde + StrToFloatDef(Cells[5,I],0);
        End;
      End;

      //Guara dos regisros do produto
      FreeAndNil(ListaPedidoItem);
      ListaPedidoItem := TListaItemVenda.create;
      GuardaListaProdutos(ListaPedidoItem,Promocao);
      OrdenarListaItems(ListaPedidoItem);
      //Trata o resto que ficar fora da quantidade da promoção
      TratarRestoPromocao(QtdePromocao,LcSomaQtde,ListaPedidoItem);
      TratarMensagemPromocao(QtdePromocao,LcSomaQtde,ListaPedidoItem);
      //Recolocar os itens excluidos agora com as quantidades somadas por produtos
      for I := 0 to ListaPedidoItem.Count - 1 do
      Begin

        Pc_PreencheItensVenda(ListaPedidoItem[I].Produto.ToString,
                              ListaPedidoItem[I].Fabrica,
                              ListaPedidoItem[I].Descricao,
                              ListaPedidoItem[I].Quantidade,
                              ListaPedidoItem[I].ValorVenda,
                              ListaPedidoItem[I].Abreviatura,
                              ListaPedidoItem[I].ValorCusto,
                              ListaPedidoItem[I].ncm,
                              ListaPedidoItem[I].Origem,
                              ListaPedidoItem[I].ValorOriginal,
                              ListaPedidoItem[I].Observacao,
                              ListaPedidoItem[I].AtingiuPromocao);
      End;
      //Refez a numeração dos itens - Não retirar precisa desta sequencia
      for I := 1 to It_Nr_Item do
        Cells[1, I] := StrZero(I,3,0);
    End;
  End;
  TratarValorUnitarioPromocao;
end;

procedure TFr_FrenteCaixa.Sb_DescontoClick(Sender: TObject);
begin
  Grp_Totalizador.Enabled := True;
  if E_Aq_Desconto.CanFocus then E_Aq_Desconto.SetFocus;
end;

procedure TFr_FrenteCaixa.SB_PesquisaClick(Sender: TObject);
begin
  Pc_MostraBusca;
end;

procedure TFr_FrenteCaixa.Sb_logoutClick(Sender: TObject);
begin
   self.Close;
end;

Function TFr_FrenteCaixa.Fc_validaExcluiCupom():Boolean;
Var
  Lc_Form :TFr_Liberacao;
Begin
  Result := true;
  if (Trim(StrGrd_Produtos.Cells[2,1])='') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'Não há itens para Excluir.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if Fc_HabilitaPermissao('Fr_FrenteCaixa','EXCLUIR CUPOM','S') then
  Begin
    Result := True;
    exit;
  End;

  if (not Gb_Liberado) or (Gb_Nivel = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'O Cancelamento do Cupom é permitido apenas para usuário Administrador.' + EOLN +
                   '        Solicite autorização e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    try
      Lc_Form := TFr_Liberacao.Create(nil);
      Lc_Form.Liberado := False;
      Lc_Form.It_Interface := 'Fr_FrenteCaixa';
      Lc_Form.It_Nome_Menu := 'Frente de Caixa';
      Lc_Form.It_Privilegio := 'AUTORIZAR';
      Lc_Form.FLogOperacao := 'Cancelamento de Cupom';
      Lc_Form.FLogDEscricao := 'Exclusão via F8';
      Lc_Form.ShowModal;
      Result := False;
      if Lc_Form.Liberado then
      Begin
        //Para bloquear o GbLiberado precisa ser usuario normal
        if (Gb_Liberado) and (Gb_Nivel = 0) then
        Begin
          Gb_Liberado := False;
          Result := True;
        end;
      End;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;

procedure TFr_FrenteCaixa.Sb_ExcluiVendaClick(Sender: TObject);
Var
  I: Integer;
begin
  if Fc_validaExcluiCupom then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Excluir esta venda de seus arquivos.' + EOLN + EOLN +
                      'Confirmar a exclusão ?',
                      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
    begin
      I := 1;
      while Trim(StrGrd_Produtos.Cells[2,I]) <> '' do
      Begin
        Pc_Log_Sistema( Gb_CodMha,
                        GB_Cd_Usuario,
                        now,
                        'Frente de Caixa',
                        Pedido.Registro.Codigo,
                       concat('Exclusão Via F8'),
                       concat('Item ',I.ToString(), ' - Produto: ' , StrGrd_Produtos.Cells[3,I] , ' - ' , StrGrd_Produtos.Cells[4,I]));
        inc(I);
      End;
      if pedido.Registro.Codigo > 0 then
      Begin
        pedido.Itens.Registro.CodigoPedido := pedido.Registro.Codigo;
        pedido.Itens.deleteByPedido;
      End;
      Pc_LimpaStringGrid(StrGrd_Produtos);
      DefineStatus;
      Pc_LimpaCampos;
      Pc_SomaProdutos;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    end;
  end;
end;

procedure TFr_FrenteCaixa.E_Aq_DescontoEnter(Sender: TObject);
begin
  E_Aq_Desconto.SelectAll;
end;

procedure TFr_FrenteCaixa.E_Vl_DescontoEnter(Sender: TObject);
begin
  E_Vl_Desconto.SelectAll;
end;

procedure TFr_FrenteCaixa.Sb_ExcluiItemClick(Sender: TObject);
begin
  if StrGrd_Produtos.CanFocus then StrGrd_Produtos.SetFocus;
end;

Function TFr_FrenteCaixa.Fc_validaExcluiItemCupom():Boolean;
var
  Lc_Form : TFr_Liberacao;

Begin
  Result := true;
  if It_Nr_Item <= 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'Não há itens para Excluir.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if Fc_HabilitaPermissao('Fr_FrenteCaixa','EXCLUIR','S') then
  Begin
    Result := True;
    exit;
  End;

  if (not Gb_Liberado) or (Gb_Nivel = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'A Exclusão do item do Cupom é permitido apenas para usuário Administrador.' + EOLN +
                   '        Solicite autorização e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    try
      Lc_Form := TFr_Liberacao.Create(nil);
      Lc_Form.Liberado := False;
      Lc_Form.It_Interface := 'Fr_FrenteCaixa';
      Lc_Form.It_Nome_Menu := 'Frente de Caixa';
      Lc_Form.It_Privilegio := 'AUTORIZAR';
      Lc_Form.FLogOperacao := 'Exclusão item do Cupom';
      Lc_Form.FLogDEscricao := 'Autorizada a Exclusão de um item';

      Lc_Form.ShowModal;
      Result := False;
      if Lc_Form.Liberado then
      Begin
        //Para bloquear o GbLiberado precisa ser usuario normal
        if (Gb_Liberado) and (Gb_Nivel = 0) then
        Begin
          Gb_Liberado := False;
          Result := True;
        end;
      End;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;

procedure TFr_FrenteCaixa.StrGrd_ProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var
  LcPromocao : String;
  LcQtde : REal;
  PReco : Real;
begin
  if Shift = [] then
  Begin
    if Key = vk_delete then
    begin
      if Fc_validaExcluiItemCupom then
      begin
        Pc_Log_Sistema( Gb_CodMha,
                        GB_Cd_Usuario,
                        now,
                        'Frente de Caixa',
                        Pedido.Registro.Codigo,
                       'Exclusão do item de venda',
                       'Produto: ' + StrGrd_Produtos.Cells[3,StrGrd_Produtos.Row]+ ' - ' + StrGrd_Produtos.Cells[4,StrGrd_Produtos.Row]);
        IF (StrToIntDef(StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row],0) > 0) then
        BEgin
          Fc_ApagarRegistro('TB_ITENS_AVL',['IAV_CODITF'],[StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row]]);
          Pc_Delete_Estoque('P',0,StrToIntDef(StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row],0));
          pedido.Itens.Registro.Codigo := StrToIntDef(StrGrd_Produtos.Cells[10,StrGrd_Produtos.Row],0);
          pedido.Itens.delete;
        end;
        if It_Usa_Imp_Checkout then
        Begin
          //Imprimindo produto cancelado
          Pc_Imp_Cancela_Item_CupomNaoFiscal(StrGrd_Produtos.Row);
        end;
        LcPromocao  := StrGrd_Produtos.Cells[13,StrGrd_Produtos.Row];
        LcQtde      := StrToFloatDef(StrGrd_Produtos.Cells[15,StrGrd_Produtos.Row],0);
        Preco       := StrToFloatDef(StrGrd_Produtos.Cells[16,StrGrd_Produtos.Row],0);
        DeletaItemDaGrade(StrGrd_Produtos.Row);
        Pc_Promocao(LcPromocao,LcQtde,Preco);
        Pc_SomaProdutos;
        Pc_Totalizador;
      end;
    end;
  end;
end;

procedure TFr_FrenteCaixa.DefineStatus;
begin
  E_Data.Caption := DateToStr(Gb_DataCaixa);
  if ( DateToStr(Gb_DataCaixa) = DateToStr(Date) ) then
  Begin
    E_Status.Caption := 'Livre';
  End
  else
  Begin
    E_Status.Caption := 'Verifique a Data do Caixa';
  End;
  E_Status.Update;


end;

procedure TFr_FrenteCaixa.DeletaItemDaGrade(Linha:Integer);
Var
  I :Integer;
  LcItemVenda : TItemVenda;
  LcFloTotal : Real;
begin
  FreeAndNil(ListaPedidoItem);
  ListaPedidoItem := TListaItemVenda.create;
  with StrGrd_Produtos do
  Begin
    For I := 1 to RowCount -1 do
    Begin
      if I <> Linha then
      Begin
        LcItemVenda := TItemVenda.Create;
        LcItemVenda.Produto       :=  StrToIntDef(Cells[2, I],0);
        LcItemVenda.Fabrica       :=  Cells[3, I];
        LcItemVenda.Descricao     :=  Cells[4, I];
        LcItemVenda.Quantidade    :=  StrToFloatDef(Cells[5,I],0);
        LcItemVenda.ValorVenda    :=  StrToFloatDef(Cells[6, I],0);
        //7 e o subtotal
        LcItemVenda.Abreviatura   :=  Cells[8, I];
        LcItemVenda.ValorCusto    :=  StrToFloatDef(Cells[9, I],0);
        LcItemVenda.ItemPedido    :=  StrToIntDef(Cells[10, I],0);
        LcItemVenda.ncm           :=  Cells[11, I];
        LcItemVenda.Origem        :=  Cells[12, I];
        LcItemVenda.Promocao      :=  Cells[13, I];
        LcItemVenda.ValorOriginal :=  StrToFloatDef(Cells[14, I],0);
        LcItemVenda.QtdePromocao  :=  StrToFloatDef(Cells[15, I],0);
        LcItemVenda.PrecoPromocao :=  StrToFloatDef(Cells[16, I],0);
        LcItemVenda.TotalPromocao :=  StrToFloatDef(Cells[19, I],0);
        ListaPedidoItem.Add(LcItemVenda);
      End;
    End;
    //Preenche a Lista
    It_Nr_Item := 0;
    Pc_LimpaStringGrid(StrGrd_Produtos);

    for I := 0 to ListaPedidoItem.Count - 1 do
    Begin
      It_Nr_Item := It_Nr_Item + 1;
      RowCount      := It_Nr_Item + 1;
      Cells[1,  It_Nr_Item]  := StrZero(It_Nr_Item,3,0);
      Cells[2,  It_Nr_Item]  := ListaPedidoItem[I].Produto.ToString;
      Cells[3,  It_Nr_Item]  := ListaPedidoItem[I].Fabrica;
      Cells[4,  It_Nr_Item]  := ListaPedidoItem[I].Descricao;
      Cells[5,  It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].Quantidade, ffFixed, 10, 3);
      Cells[6,  It_Nr_Item]  := FormatFloat('#0.00###',ListaPedidoItem[I].ValorVenda);

      LcFloTotal   :=  ( ListaPedidoItem[I].ValorVenda * ListaPedidoItem[I].Quantidade ) ;
      LcFloTotal   := Roundto( LcFloTotal  ,-2);
      Cells[7,  It_Nr_Item]  := FloatToStrF(LcFloTotal, ffFixed, 10, 2);
      Cells[8,  It_Nr_Item]  := ListaPedidoItem[I].Abreviatura;
      Cells[9,  It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].ValorCusto, ffFixed, 10, 2);
      Cells[10, It_Nr_Item]  := ListaPedidoItem[I].ItemPedido.ToString;
      Cells[11, It_Nr_Item]  := ListaPedidoItem[I].ncm;
      Cells[12, It_Nr_Item]  := ListaPedidoItem[I].Origem;
      Cells[13, It_Nr_Item]  := ListaPedidoItem[I].Promocao;
      Cells[14, It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].ValorOriginal, ffFixed, 10, 2);
      Cells[15, It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].QtdePromocao, ffFixed, 10, 2);
      Cells[16, It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].PRecoPromocao, ffFixed, 10, 2);
      Cells[19, It_Nr_Item]  := FloatToStrF(ListaPedidoItem[I].TotalPromocao, ffFixed, 10, 2);
      Cells[20, It_Nr_Item]  := ListaPedidoItem[I].AtingiuPromocao;
    End;
  End;
End;

procedure TFr_FrenteCaixa.E_BuscaCodigoEnter(Sender: TObject);
begin
  E_BuscaCodigo.Color := clYellow;
  Grp_Totalizador.Enabled := False;
  E_BuscaCodigo.SelectAll;
end;

procedure TFr_FrenteCaixa.E_BuscaCodigoExit(Sender: TObject);
begin
  E_BuscaCodigo.Color := clScrollBar;
end;

procedure TFr_FrenteCaixa.E_QtdeEnter(Sender: TObject);
begin
  E_Qtde.Color := clYellow;
end;

procedure TFr_FrenteCaixa.E_QtdeExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  E_Qtde.Color := clScrollBar;
  Lc_Valor := StrToFloatDef(TrataQtde(E_Qtde.Text),1);
  if Lc_Valor >= 10000 then Lc_Valor := 1;
  E_Qtde.Text := FloatToStr(Lc_Valor);
  E_Qtde.ReadOnly := FTeclaF11Bloqueada;
end;


procedure TFr_FrenteCaixa.Cadastrodeproduto1Click(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    if StrToIntDef(StrGrd_Produtos.Cells[2, StrGrd_Produtos.Row],0) > 0 then
    Begin
      Try
        Lc_Form := TFr_Produtos.Create(nil);
        Lc_Form.Produto.Registro.Codigo := StrToIntDef(StrGrd_Produtos.Cells[2, StrGrd_Produtos.Row],0);
        Lc_Form.ShowModal;
      Finally
        FreeAndNil( Lc_Form );
      End;
    end;
  end;
end;


function TFr_FrenteCaixa.CarregaItensCommand( PedidoID: Integer): Boolean;
Var
  I : Integer;
  LcItems : TControllerCheckOutItems;
Begin
  if PedidoID > 0 then
  Begin
    Try
      pedido.Clear;
      with Pedido do
      begin
        Registro.CodigoEstabelecimento := Gb_CodMha;
        Registro.Codigo := PedidoID;
        getbyId;
        //CheckOut Controller
        LcItems := TControllerCheckOutItems.Create(nil);
        LcItems.Registro.Estabelecimento := Gb_CodMha;
        LcItems.Registro.Pedido := PedidoID;
        LcItems.getList;
        if LcItems.Lista.Count > 0 then
        Begin
          It_Nr_Item := 0;
          Pc_LimpaStringGrid(StrGrd_Produtos);
          with StrGrd_Produtos, itens do
          Begin
            for I := 0 to LcItems.Lista.Count - 1 do
            Begin
              Pc_PreencheItensVenda(LcItems.Lista[I].CodigoProduto.ToString,
                                    LcItems.Lista[I].CodigoFabrica,
                                    LcItems.Lista[I].DescProduto,
                                    LcItems.Lista[I].Quantidade,
                                    LcItems.Lista[I].ValorUnitario,
                                    LcItems.Lista[I].Unidade,
                                    LcItems.Lista[I].PrecoCusto,
                                    LcItems.Lista[I].ncm,
                                    LcItems.Lista[I].Origem,
                                    LcItems.Lista[I].ValorUnitario,
                                    '',
                                    '');
            End;
          End;
        End;
        E_Qtde.Text := '1';
        Pc_SomaProdutos;
        Pc_Totalizador;
      end;
    Finally
      FreeAndNil(LcItems);
    End;
  End;
end;

procedure TFr_FrenteCaixa.CartoPrPago1Click(Sender: TObject);
Var
  Form : TSeaPrePaidCard;
begin
  try
    Form := TSeaPrePaidCard.create(nil);
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_FrenteCaixa.AdministrativoTEF1Click(Sender: TObject);
begin
  if ValidaAberturaTEF then
  Begin
    ConfigAtivaTEF;
    estadoSimuladoEcf := tpsLivre;
    if estadoSimuladoEcf <> tpsLivre then
      raise Exception.Create('Estado do Simulador ECF deve ser Livre');

    TEF.ADM(gpCliSiTef);
    mm_Tef.Lines.Add('Administrativo TEF');
    mm_Tef.Update;
  End;
end;

procedure TFr_FrenteCaixa.AjustaComponentesParaResolucao1024x768;
Var
  LcHeightDif : Integer;
  LcEditFontHeightDif : Integer;
  LcLabelFontHeightDif : Integer;
begin
  if (Screen.Height = 768) then
  Begin
    LcHeightDif := 4;
    LcEditFontHeightDif := 6;
    LcLabelFontHeightDif := 1;

    E_Status.Font.Size := 20;

    Lb_Valor_Pedido.Height := 19 - LcHeightDif;
    Lb_Valor_Pedido.Font.Height := -16 + LcLabelFontHeightDif;

    Lb_Valor_Desconto.Height := 19 - LcHeightDif;
    Lb_Valor_Desconto.Font.Height := -16 + LcLabelFontHeightDif;

    Lb_Valor_Total.Height := 19 - LcHeightDif;
    Lb_Valor_Total.Font.Height := -16 + LcLabelFontHeightDif;

    Lb_Taxa_Desconto.Height := 19 - LcHeightDif;
    Lb_Taxa_Desconto.Font.Height := -16 + LcLabelFontHeightDif;

    E_Quantidade.Height := 24 - LcHeightDif;
    E_Quantidade.Font.Height := -19 + LcEditFontHeightDif;

    Lb_TipoVenda.Height := 16 - LcHeightDif;
    Lb_TipoVenda.Font.Height := -13 + LcLabelFontHeightDif;

    Lb_Label_Qtde_Total.Height := 20 - LcHeightDif;
    Lb_Label_Qtde_Total.Font.Height := -16 + LcLabelFontHeightDif;

    Lb_Valor_troco.Height := 19 - LcHeightDif;
    Lb_Valor_troco.Font.Height := -16 + LcLabelFontHeightDif;

    E_Data.Height := 24 - LcHeightDif;
    E_Data.Font.Height := -19 + LcEditFontHeightDif;

    E_Hora.Height := 24 - LcHeightDif;
    E_Hora.Font.Height := -19 + LcEditFontHeightDif;

    Lbl_Caixa.Height := 27 - LcHeightDif;
    Lbl_Caixa.Font.Height := -19 + LcLabelFontHeightDif;

    E_Usuario.Height := 24 - LcHeightDif;
    E_Usuario.Font.Height := -19 + LcEditFontHeightDif;

    Lb_Label_totalizador.Height := 19 - LcHeightDif;
    Lb_Label_totalizador.Font.Height := -16 + LcLabelFontHeightDif;

    Lb_Vl_Economia.Height := 19 - LcHeightDif;
    Lb_Vl_Economia.Font.Height := -16 + LcLabelFontHeightDif;

    E_VL_Troco.Height := 45 - LcHeightDif;
    E_VL_Troco.Font.Height := -37 + LcEditFontHeightDif;

    E_Vl_Total.Height := 45 - LcHeightDif;
    E_Vl_Total.Font.Height := -37 + LcEditFontHeightDif;

    E_Vl_Pedido.Height := 45 - LcHeightDif;
    E_Vl_Pedido.Font.Height := -37 + LcEditFontHeightDif;

    E_Aq_Desconto.Height := 47 - LcHeightDif;
    E_Aq_Desconto.Font.Height := -35 + LcEditFontHeightDif;

    E_Vl_Desconto.Height := 47 - LcHeightDif;
    E_Vl_Desconto.Font.Height := -35 + LcEditFontHeightDif;

    E_Vl_Economia.Height := 45 - LcHeightDif;
    E_Vl_Economia.Font.Height := -37 + LcEditFontHeightDif;

  end;
end;

procedure TFr_FrenteCaixa.ControleElementos(Painel:Tpanel; Ativo:Boolean);
Begin
  Grp_Totalizador.Enabled := Ativo;
  StrGrd_Produtos.Enabled := Ativo;
  E_BuscaCodigo.Enabled := Ativo;
  E_Qtde.Enabled := Ativo;
  Pnl_rodape.Enabled := Ativo;
  Painel.Visible := not Ativo;
  if Ativo then
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus
  else
    Painel.BringToFront;
End;

procedure TFr_FrenteCaixa.AlterarPreo1Click(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_AjustaPreco','Ajusta Preço','Visualizar',GB_Cd_Usuario,'S') then
  Begin
    TSetesForms.Show(TFr_AjustaPreco);
  End;
end;

procedure TFr_FrenteCaixa.AlterarPreosconformeTabelaAtiva1Click(
  Sender: TObject);
begin
  EscolheTabela;
end;

procedure TFr_FrenteCaixa.Atualizao1Click(Sender: TObject);
begin
  if FileExists(concat(GbPathExe,'RoteadorGestao.exe')) then
  Begin
    WinExec('RoteadorGestao.exe',SW_SHOWNORMAL);
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O Roteador de Dados do Gestão não está instalado.' + EOLN +
                   'Não é possível continuar.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TFr_FrenteCaixa.Sb_Cancela_TabelaPrecoClick(Sender: TObject);
begin
  Pnl_TabelaPreco.Visible := False;
  ControleElementos(Pnl_TabelaPreco,True);
end;

procedure TFr_FrenteCaixa.PedidosEmitidosClick(Sender: TObject);
begin
  Pc_AbreTelaPesqNF_65;
end;

procedure TFr_FrenteCaixa.Sair2Click(Sender: TObject);
begin
  Sb_logoutClick(Self);
end;


procedure TFr_FrenteCaixa.SB_FaturarClick(Sender: TObject);
begin
  if (It_TP_Operacao = 'PDV') or (It_NFCe) then
  Begin
    Pc_FaturamentoNormal;
  end
  else
  Begin
    Pc_Pre_Venda;
  end;
end;

procedure TFr_FrenteCaixa.Pc_ChamaPedidoBalcao;
var
  Lc_Nr_Pedido : String;
begin
  if not(InputQuery('Informe o Número do Pedido ', 'Pedido Número',    Lc_Nr_Pedido)) then
    exit;
  if (TRim(Lc_Nr_Pedido) = '') or (StrtoIntDef(Lc_Nr_Pedido,0) = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Por favor informe um numero de pedido válido.' + EOLN +
                   '        Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    exit;
  end;
  if Fc_CarregaPedidoBalcao(0,StrtoIntDef(Lc_Nr_Pedido,0)) then
  Begin
    //Emite Mensagem de Confirmação quando for PRÉ-VENDA
    IF (It_TP_Operacao = 'CMD') then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Pedido gerado com Sucesso.' + EOLN + EOLN +
                     '      Nº ' + IntToStr(self.It_NR_Pedido) + EOLN,
                     ['OK'], [bEscape], mpInformacao);
    end;
  end;
end;

procedure TFr_FrenteCaixa.LanamentoCrditoPrPago1Click(Sender: TObject);
begin
  LancaCreditoCartaoPrePago;
end;

procedure TFr_FrenteCaixa.LanamentodeCaixa1Click(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Caixa','Lançamento Caixa','Visualizar',GB_Cd_Usuario,'S') then
  Begin
    Fr_Principal.AbrirTelaCaixa;
    if not Fc_VerificaCaixaAberto(True) then
    Begin
      forcafechamento := True;
      Self.Close;
      exit;
    End;
    DefineStatus;
  End;
end;

procedure TFr_FrenteCaixa.LancaCreditoCartaoPrePago;
Var
  Form : TTasPrePaidCard;
begin
  Try
    Form := TTasPrePaidCard.create(nil);
    Form.ShowModal;
    if Form.Prepago.Registro.Codigo > 0 then
    Begin
      //Verfica se o produto existe e conforme for cadastra
      Form.produto.getByDescricao('CREDITO PRÉ-PAGO');
      if not Form.produto.exist then
        Form.Pc_CadastrarProdutosAuto;

      Fc_BuscarProduto( Form.Produto.Registro.Codigo.ToString ,'PRO_CODIGO','');
      Pc_PreencheItensVenda(Qr_PesqProduto.FieldByName('PRO_CODIGO').AsString,
                            Qr_PesqProduto.FieldByName('PRO_CODIGOFAB').AsString,
                            Qr_PesqProduto.FieldByName('PRO_DESCRICAO').AsString,
                            1,
                            StrToFloatDef(Form.E_VL_Credito.Text,0),
                            Qr_PesqProduto.FieldByName('MED_ABREVIATURA').AsString,
                            Qr_PesqProduto.FieldByName('PRO_VL_CUSTO').AsCurrency,
                            Qr_PesqProduto.FieldByName('PRO_CODIGONCM').AsString,
                            Qr_PesqProduto.FieldByName('PRO_ORIGEM').AsString,
                            Qr_PesqProduto.FieldByName('PRC_VL_VDA').AsCurrency,
                            '',
                            '');
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
      if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
      E_BuscaCodigo.Clear;
      Pc_GeraPedido(0);
      Form.Prepago.Registro.Ordem := Pedido.Registro.Codigo;
      Form.Prepago.Registro.Historico := concat('PEDIDO VENDA Nº ',Pedido.Registro.Numero.ToString);
      Form.Prepago.salva;
    end;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TFr_FrenteCaixa.LiberacaoExecute(Sender: TObject);
Var
  Form : TFr_Liberacao;
begin
  Try
    Form := TFr_Liberacao.Create(nil);
    with Form do
    begin
      Liberado := False;
      It_Interface := 'Fr_FrenteCaixa';
      It_Nome_Menu := 'Frente de Caixa';
      It_Privilegio := 'AUTORIZAR';
      ShowModal;
    end;
  Finally
    FreeAndNil(Form);
  End;
end;


procedure TFr_FrenteCaixa.limparTela;
begin
  Pc_LimpaStringGrid(StrGrd_Produtos);
  Pc_LimpaCampos;
  Pc_SomaProdutos;
  Pc_Totalizador;
  IF (It_Cd_Cliente <> It_Cd_Consumidor) then
  Begin
    It_Cd_Cliente := It_Cd_Consumidor;
    Pc_PosicionaCliente;
  end;
  //Atualiza o Status do Caixa
  DefineStatus;
end;

procedure TFr_FrenteCaixa.Observao1Click(Sender: TObject);
Var
  Form : TFr_ObtemCampoMemo;
begin
  try
    Form := TFr_ObtemCampoMemo.Create(nil);
    Form.ShowModal;
    if Length(Form.E_Observacao.Text) >=10 then
    Begin
      ObservacaoPedido := Form.E_Observacao.Text;
    End;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_FrenteCaixa.OcultaBarraTarefas(YesNo: Boolean);
begin
  Pc_SetTaskBar(Self,YesNo);
  OcultarBarradeTarefasWindows.Checked := YesNo;
end;

procedure TFr_FrenteCaixa.OcultarBarradeTarefasWindowsClick(Sender: TObject);
begin
  if OcultarBarradeTarefasWindows.Checked then
  Begin
    OcultaBarraTarefas(false);
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','OCULTABARRAWINDOWS','N');
  End
  else
  Begin
    OcultaBarraTarefas(True);
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','OCULTABARRAWINDOWS','S');
  End;
end;

procedure TFr_FrenteCaixa.VendasBalcaoClick(Sender: TObject);
begin
  Pc_ChamaPedidoBalcao;
end;



procedure TFr_FrenteCaixa.VerprodutosdestaPromoo1Click(Sender: TObject);
begin
  if ValidaVerPromocaoByItemList then
     VerPromocaoByItemList

end;

procedure TFr_FrenteCaixa.VerPromocaoByItemList;
Var
  Form:TCadPromotion;
begin
  Try
    Form := TCadPromotion.create(nil);
    Form.CodigoRegistro := StrToIntDef(StrGrd_Produtos.Cells[13, StrGrd_Produtos.Row],0);
    Form.Codigodetalhe := StrToIntDef(StrGrd_Produtos.Cells[2, StrGrd_Produtos.Row],0);
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TFr_FrenteCaixa.Pc_ImprimeItemCheckout;
Begin
  //Utilizar sistemática de impressão item a item na leitura do produto no checkout
  if It_Usa_Imp_Checkout then
  Begin
    //'Imprimindo produto ao incluir
    if It_Nr_Item = 1 then
    Begin
      Pc_Imp_Abre_CupomNaoFiscal;
      Pc_Imp_Item_CupomNaoFiscal;
    end
    else
    Begin
      Pc_Imp_Item_CupomNaoFiscal;
    end;
  end;
end;

procedure TFr_FrenteCaixa.Pc_Imp_Abre_CupomNaoFiscal;
Var
  Lc_I : Integer;
  Lc_Imp: TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.Create(Nil);
    Lc_Imp.It_Porta := ImpPorta;
    if Trim(Lc_Imp.It_Porta) = '' then Lc_Imp.It_Porta := 'LPT1';
    Lc_Imp.It_FRow:=1;
    Lc_Imp.It_FCol:=1;

    It_ColunaCentro := Trunc(ImpNumeroColunas/2);
    case It_Tp_Impressao of
      0:Begin
          //Gera novo Registro para o Pedido
          Pc_GeraPedido(0);
          //Desabilitar o Alt+F4
          RegisterHotkey(Self.Handle, 1, MOD_ALT , VK_f4);
          //Desabilitar o Ctrl+Alt+Del
          RegisterHotkey(Self.Handle, 2, MOD_CONTROL, MOD_ALT);
          DefineStatus;
          AssignFile(Lc_Imp.It_Arquivo,Lc_Imp.It_Porta);
          Rewrite(Lc_Imp.It_Arquivo);
          Lc_Imp.It_FRow:=1;
          Lc_Imp.It_FCol:=1;
          It_Linha := 1;
          //Define o tamanhho do Traço

          Pc_AtivaEstabelecimento;
          if Qr_Pedido.RecordCount > 0 then
          begin
            DM.Qr_Endereco.Active := False;
            DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_Pedido.FieldByname('PED_CODEMP').AsInteger;
            DM.Qr_Endereco.Active := true;
          end;
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString,ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('END_Numero').AsString,ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString,ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC(fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString),ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('N.: ' + IntToStr(self.It_NR_Pedido)  + '   ' + DateToStr(Date),ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(ImpTraco,ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('Descricao dos Produtos  ',ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('Qte    VL. Unitario                    Sub-Total',ImpNumeroColunas));
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(ImpTraco,ImpNumeroColunas));
          CloseFile(Lc_Imp.It_Arquivo);
          //Finaliza o Cupom
          Lc_Imp.Pc_FinalizaCupom(0);
        end;
      1:Begin
          {with Fr_Principal.RdPrint_DP do
          Begin
            // Cabeçalho do Cupom...
            abrir;
            It_Linha := 1; // Linhas (deve ser 1 quando for CUPOM)
            TamanhoQteLinhas := 1;
            //Define o tamanhho do Traço
            ImpTraco := '';
            For Lc_I:= 1 to ImpNumeroColunas do
              ImpTraco := ImpTraco + '-';

            FonteTamanhoPadrao := s20cpp; // Fonte Comprimido em 20 cpp
            Acentuacao := Transliterate;
            if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') = 'S') then
              OpcoesPreview.Preview := True
            else
              OpcoesPreview.Preview := False;
            Pc_AtivaEstabelecimento;

            if Qr_Pedido.RecordCount > 0 then
              begin
              DM.Qr_Endereco.Active := False;
              DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_Pedido.FieldByname('PED_CODEMP').AsInteger;
              DM.Qr_Endereco.Active := true;
              end;
            impc(01, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString, [comp17]);
            impc(02, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString, [comp17]);
            impc(03, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString, [comp17]);
            impc(04, It_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString, [comp17]);
            impc(05, It_ColunaCentro, fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString), [comp17]);
            imp(06, 01, 'Nº ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString + '   ' + Qr_Pedido.FieldByname('PED_DATA').AsString);

            imp(07, 01, ImpTraco);
            imp(08, 01, 'Descriçao dos Produtos  ');
            imp(09, 01, 'Qte    VL. Unitário                    Sub-Total');
            imp(10, 01, ImpTraco);
          end;}
        end;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  end;
end;

procedure TFr_FrenteCaixa.Pc_Imp_Item_CupomNaoFiscal;
Var
  Lc_Imp: TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.Create(Nil);
    Lc_Imp.It_Porta := ImpPorta;
    if Trim(Lc_Imp.It_Porta) = '' then Lc_Imp.It_Porta := 'LPT1';
    case It_Tp_Impressao of
      0:Begin
          AssignFile(Lc_Imp.It_Arquivo,Lc_Imp.It_Porta);
          Rewrite(Lc_Imp.It_Arquivo);
          Lc_Imp.It_FRow:=1;
          Lc_Imp.It_FCol:=1;
          It_Linha := 1;
          //Descrição do Produto
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(Copy(StrGrd_Produtos.Cells[4, It_Nr_Item],1,ImpNumeroColunas),ImpNumeroColunas));
          //Quantidade
          Inc(It_linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(StrGrd_Produtos.Cells[5, It_Nr_Item],9));
          Lc_Imp.Pc_TextOutLC(It_Linha,11,Lc_Imp.Pc_AlinhaE( ' X ',3));
          //Valor Unitario
          Lc_Imp.Pc_TextOutLC(IT_Linha,15,Lc_Imp.Pc_AlinhaD(StrGrd_Produtos.Cells[6, It_Nr_Item],14));
          //Subtotal
          Lc_Imp.Pc_TextOutLC(It_Linha,34,Lc_Imp.Pc_AlinhaD(StrGrd_Produtos.Cells[7, It_Nr_Item],14));
          CloseFile(Lc_Imp.It_Arquivo);
          //Finaliza o Cupom
          Lc_Imp.Pc_FinalizaCupom(0);
        end;
      1:Begin
          {with Fr_Principal.RdPrint_DP do
          Begin
            //Descrição do Produto
            imp(It_linha, 01, Copy(StrGrd_Produtos.Cells[4, It_Nr_Item] ,1,ImpNumeroColunas));
            Inc(It_linha);
            //Quantidade
            imp(It_linha, 01, FormatFloat('#0.###', StrToFloatDef(StrGrd_Produtos.Cells[5, It_Nr_Item],0)));
            imp(It_linha, 08, ' X ');
            //Valor Unitario
            imp(It_linha, 11, FormatFloat('#0.###', StrToFloatDef(StrGrd_Produtos.Cells[6, It_Nr_Item],0)));
            //SubTotal
            impval(It_linha, 35, '###,###,##0.00', StrToFloatDef(StrGrd_Produtos.Cells[7, It_Nr_Item],0), []);
            IF It_linha > 70 THEN
            begin
              Novapagina;
              It_linha:=1;
            end
            else
            Begin
              inc(It_linha);
            end;
          end;}
        end;
    end;
  Finally
    FreeAndNil(Lc_Imp);
  end;
end;

Procedure TFr_FrenteCaixa.Pc_Imp_Cancela_Item_CupomNaoFiscal;
Var
  Lc_Valor : Real;
  Lc_Imp: TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.Create(Nil);
    Lc_Imp.It_Porta := ImpPorta;
    AssignFile(Lc_Imp.It_Arquivo,Lc_Imp.It_Porta);
    Rewrite(Lc_Imp.It_Arquivo);
    Lc_Imp.It_FRow:=1;
    Lc_Imp.It_FCol:=1;
    It_Linha := 1;
    //Descrição do Produto
    Inc(It_linha);
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(Copy(StrGrd_Produtos.Cells[4, It_Nr_Item],1,ImpNumeroColunas),ImpNumeroColunas - 12));
    //Mensagem de Cancelado
    Lc_Imp.Pc_TextOutLC(IT_Linha,ImpNumeroColunas - 11,Lc_Imp.Pc_AlinhaE('(CANCELADO)',9));
    //Quantidade
    Inc(It_linha);
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaD(StrGrd_Produtos.Cells[5, It_Nr_Item],9));
    Lc_Imp.Pc_TextOutLC(It_Linha,11,Lc_Imp.Pc_AlinhaE( ' X ',3));
    //Valor Unitario
    Lc_Valor := StrToFloatDef(StrGrd_Produtos.Cells[6, It_Nr_Item],0) * -1;
    Lc_Imp.Pc_TextOutLC(IT_Linha,15,Lc_Imp.Pc_AlinhaD(FloattoStrF(Lc_Valor,ffFixed,10,2),14));
    //Subtotal
    Lc_Valor := StrToFloatDef(StrGrd_Produtos.Cells[7, It_Nr_Item],0) * -1;
    Lc_Imp.Pc_TextOutLC(It_Linha,34,Lc_Imp.Pc_AlinhaD(FloattoStrF(Lc_Valor,ffFixed,10,2),14));
    CloseFile(Lc_Imp.It_Arquivo);
    //Finaliza o Cupom
    Lc_Imp.Pc_FinalizaCupom(0);
  finally
    FreeAndNil(Lc_Imp);
  end;
end;

procedure TFr_FrenteCaixa.E_BuscaCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then Fc_LancaItem;
end;

procedure TFr_FrenteCaixa.E_Cd_ClienteEnter(Sender: TObject);
begin
//  E_Cd_Cliente.Color := clYellow;
//  E_Cd_Cliente.SelectAll;
end;

procedure TFr_FrenteCaixa.E_Cd_ClienteExit(Sender: TObject);
Var
  LcNome : String;
begin
  exit;
  //Desabilitdo pois a solicitante cancelou contrato - 28/03/2019
  E_Cd_Cliente.Color := clWindow;
  It_Cd_Cliente := StrToIntDef(E_Cd_Cliente.Text,It_Cd_Consumidor);
  if ( It_Cd_Cliente <> It_Cd_Consumidor ) then
  Begin
    Pedido.Cliente.Empresa.Registro.Codigo := It_Cd_Cliente;
    Pedido.Cliente.Empresa.getById;
    if not Pedido.Cliente.Empresa.exist then
    BEgin
      It_Cd_Cliente := It_Cd_Consumidor;
      Pedido.Cliente.Empresa.Registro.Codigo := It_Cd_Cliente;
      Pedido.Cliente.Empresa.getById;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Código de Cliente não existe.' + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                      ['OK'], [bEscape], mpAlerta);
    End;
    LcNome := Pedido.Cliente.Empresa.Registro.ApelidoFantasia;
    if Length(Trim(LcNome))= 0 then
      LcNome := Pedido.Cliente.Empresa.Registro.NomeRazaoSocial;
    if ( It_Cd_Cliente <> It_Cd_Consumidor ) then
    Begin
      If (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Deseja registrar a venda para o cliente ' + LcNome + '.'+EOLN+EOLN+
                         'Confirmar a alteração ?',
                         [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clBtnFace) = mrBotao2) then
      Begin
        It_Cd_Cliente := It_Cd_Consumidor;
      end;
    End;
    Pc_PosicionaCliente;
  end;
end;

procedure TFr_FrenteCaixa.E_Cd_ClienteKeyPress(Sender: TObject; var Key: Char);
begin
//  if (Key = #13) then
//    E_BuscaCodigo.SetFocus;
end;

procedure TFr_FrenteCaixa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if not (ActiveControl is TEdit_Setes) then
    Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
  end;
end;

procedure TFr_FrenteCaixa.E_QtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
end;

procedure TFr_FrenteCaixa.DadosNCM1Click(Sender: TObject);
Var
  Lc_Form : TFr_ncm;
begin
  Try
    Lc_Form := TFr_ncm.Create(nil);
    Lc_Form.It_Cd_Ncm := StrGrd_Produtos.Cells[11, StrGrd_Produtos.row];
    Lc_Form.ShowModal;
    StrGrd_Produtos.Cells[11,StrGrd_Produtos.Row] := Lc_Form.It_Cd_Ncm;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_FrenteCaixa.E_Peso_LiquidoManualEnter(Sender: TObject);
begin
  (Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_FrenteCaixa.E_Aq_DescontoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_FrenteCaixa.E_Vl_DescontoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_FrenteCaixa.E_VL_UnitarioEnter(Sender: TObject);
begin
(Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_FrenteCaixa.E_Vl_UnitarioManualEnter(Sender: TObject);
begin
(Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_FrenteCaixa.AbrirTelaTabelaPreco;
Begin


End;

function TFr_FrenteCaixa.ValidaAberturaTEF: Boolean;
begin
  Result := True;
  if ( not TEF_Ativo ) then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O MÉdulo TEF (Tranferência Eletrônica de Fundos) não está ativado.'+EOLN +
                   'Este módulo permite usar máquina de cartão acoplado ao computador.'+EOLN +
                   'Caso tenho interesse entre em contato com a Setes.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result:=false;
    exit;
  End;
end;

function TFr_FrenteCaixa.ValidaItensNaLista: Boolean;
Var
  I : Integer;
begin
  Result := True;
  for I := 1 to StrGrd_Produtos.RowCount-1 do
  Begin
    if (StrGrd_Produtos.Cells[2,I]) = '' then
    Begin
      Result := False;
      break;
    End;
  End;
end;

function TFr_FrenteCaixa.ValidaTrocaTabela:Boolean;
Begin
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
End;

function TFr_FrenteCaixa.ValidaVerPromocaoByItemList: Boolean;
begin
  Result := True;
  if StrToIntDef(StrGrd_Produtos.Cells[13, StrGrd_Produtos.Row],0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Este item não consta em nenhuma promoção agrupada.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result:=false;
    exit;
  End;
  if not fc_VerificaPermissao('seaPromotion','Promoções','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Result:=false;
    exit;
  End;
end;

Procedure TFr_FrenteCaixa.EscolheTabela;
Begin
  ControleElementos(Pnl_TabelaPreco,false);
  Fm_ListaTabelaPreco.Listar(It_Cd_Tabela);
  if Fm_ListaTabelaPreco.Dblcb_Lista.CanFocus then Fm_ListaTabelaPreco.Dblcb_Lista.SetFocus;

End;

Function TFr_FrenteCaixa.EfetuaCopiaItem(ItemVenda : TItemVenda;Qtde:Real;TipoPreco:String):TItemVenda;
Begin
  Result := TItemVenda.Create;
  with Result do
  Begin
    Produto         := ItemVenda.Produto;
    ValorOriginal   := ItemVenda.ValorOriginal;
    ValorCusto      := ItemVenda.ValorCusto;
    Fabrica         := ItemVenda.Fabrica;
    if TipoPreco = 'P' then
    Begin
      ValorVenda      := ItemVenda.ValorVenda;    //Promoção
      AtingiuPromocao := 'S';
    end
    else
    Begin
      ValorVenda      := ItemVenda.ValorOriginal; //Original
      AtingiuPromocao := 'N';
    end;
    Descricao       := ItemVenda.Descricao;
    ncm             := ItemVenda.ncm;
    Promocao        := ItemVenda.Promocao;
    Quantidade      := Qtde;
    Abreviatura     := ItemVenda.Abreviatura;
    Origem          := ItemVenda.Origem;
    ItemPedido      := ItemVenda.ItemPedido;
    QtdePromocao    := ItemVenda.QtdePromocao;
    PrecoPromocao   := ItemVenda.PrecoPromocao;
  End;
End;

function TFr_FrenteCaixa.TrataQtde(Qtde: String): String;
Var
  Lc_Valor : Real;
begin
  Lc_Valor := 0;
  E_Qtde.Color := clScrollBar;
  Lc_Valor := StrToFloatDef(E_Qtde.Text,1);
  if (Lc_Valor = 0) or (Lc_Valor >= 10000)  then Lc_Valor := 1;
  Result := FloatToStr(Lc_Valor);
  E_Qtde.ReadOnly := FTeclaF11Bloqueada;
end;

procedure TFr_FrenteCaixa.TratarMensagemPromocao(QtdePromocao, QtdeTotal: Real;
  ListaItem: TListaItemVenda);
Var
  I : Integer;
  Lc_QtdeRestante : Real;
  Lc_CodigoPromocao : String;
  LcQtdeProdutos : Integer;
  LcQtdePromocao: Integer;
  LcQtdeItens : real;
Label
  Reinicia;
begin
  if ListaItem.Count > 0 then
  Begin
    Lc_QtdeRestante := QtdePromocao;
    Lc_CodigoPromocao := ListaItem[0].Promocao;
    for I := 0 to ListaItem.Count - 1 do
    Begin
    Reinicia:
      if (Lc_CodigoPromocao = ListaItem[I].Promocao) then
      Begin
        Lc_QtdeRestante := Lc_QtdeRestante  - ListaItem[I].Quantidade;
        if Lc_QtdeRestante = 0 then
        Begin
          ListaItem[I].Observacao := '';
          Lc_QtdeRestante := QtdePromocao;
        End
        else
        Begin//Será maior que zero, pois trato disso na função resto
          ListaItem[I].Observacao := '';
        End;
      End
      else
      Begin
        Lc_CodigoPromocao := ListaItem[I].Promocao;
        Lc_QtdeRestante := QtdePromocao;
        goto Reinicia;
      End;
    End;
    if (Lc_QtdeRestante > 0) and  (Lc_QtdeRestante <> QtdePromocao ) then
    Begin
      ListaItem[I -1].Observacao := concat('Leve + ',FloattoStr(Lc_QtdeRestante),' unidades da promoção e pague ',FloatToStrF(ListaItem[I -1].PrecoPromocao ,ffNumber,10,2),' cada.');
    End;
  End;
end;

procedure TFr_FrenteCaixa.TratarRestoPromocao(QtdePromocao,QtdeTotal:Real;ListaItem: TListaItemVenda);
Var
  I : Integer;
  ItemVenda : TItemVenda;
  Dividendo : Real;
  Divisor   : Real;
  Quociente : Integer;
  Resto     : Real;
  //
  ListaTemp   : TListaItemVenda;
  SaldoPromocao : Real;
  SaldoItem   : Real;

begin
  Try
    ListaTemp := TListaItemVenda.create;
    //Para saber a quantiade de produtos que estaré na promoção
    Dividendo := QtdeTotal;
    Divisor := QtdePromocao;
    Quociente := Trunc(Dividendo / Divisor);
    SaldoPromocao := (Quociente * Divisor);
    //Verficar qual item tem a maior quantidade e quarda o Indice da lista
    for I := 0 to ListaItem.Count - 1 do
    Begin
      if ( SaldoPromocao > 0 ) then
      Begin
        // -2                     7            5
        SaldoItem := ListaItem[I].Quantidade - SaldoPromocao; //QtdePromocao;
        if (SaldoItem = 0 ) then
        Begin
          ListaTemp.add( EfetuaCopiaItem(ListaItem[I],ListaItem[I].Quantidade,'P') );
          SaldoPromocao := SaldoPromocao -  ListaItem[I].Quantidade;
        end
        else
        Begin
          if (SaldoItem < 0 ) then
          Begin
            // -2 = 3 - 5;
            ListaTemp.add( EfetuaCopiaItem(ListaItem[I],ListaItem[I].Quantidade,'P') );
            SaldoPromocao := SaldoPromocao -  ListaItem[I].Quantidade;
          end
          else
          Begin
            //2 = 7 - 5;
            Resto     := ListaItem[I].Quantidade - SaldoPromocao;
            ListaTemp.add( EfetuaCopiaItem(ListaItem[I],(ListaItem[I].Quantidade - Resto),'P') );
            SaldoPromocao := SaldoPromocao -  (ListaItem[I].Quantidade - Resto);
            if Resto > 0 then
            Begin
              if (Resto <= SaldoPromocao) and ( SaldoPromocao > 0 ) then
              Begin
                ListaTemp.add( EfetuaCopiaItem(ListaItem[I],Resto,'P') );
                SaldoPromocao := SaldoPromocao -  Resto;
              End
              else
              Begin
                ListaTemp.add( EfetuaCopiaItem(ListaItem[I],Resto,'N') );
              End;
            End;
          end;
        end;
      end
      else
      Begin
        //Esta Fora da Promoção
        ListaTemp.add( EfetuaCopiaItem(ListaItem[I],ListaItem[I].Quantidade,'N') );
      end;
    end;
    ListaItem.Clear;
    for I := 0 to ListaTemp.Count - 1 do
    Begin
      ItemVenda := TItemVenda.create;
      ItemVenda.Assign(ListaTemp[I]);
      ListaItem.add(ItemVenda);
    End;

  Finally
    FreeAndNil(ListaTemp);
  End;
end;

procedure TFr_FrenteCaixa.TratarValorUnitarioPromocao;
Var
  I, J, K: Integer;
  Lc_idx_promo : Integer;
  Lc_idx_promo_ant : Integer;
  Lc_sum_qtde : Real;
  Lc_valor_promo : Real;
  Lc_valor_unit : Real;
  Lc_str_unit : String;
  Lc_itens_na_promo:Integer;
  Lc_sum_item_promo : Real;
  Lc_Contador_passagem : Integer;
  Lc_Aux : Real;
begin

  Lc_idx_promo_ant := -1;
  for I := 1 to StrGrd_Produtos.RowCount - 1 do
  begin
    Lc_idx_promo := StrToIntDef(StrGrd_Produtos.Cells[13, I],0);

    if (Lc_idx_promo > 0) and (Lc_idx_promo <> Lc_idx_promo_ant) then
    BEgin

      //verifica se a quantidade da promoção foi atingida
      Lc_itens_na_promo := 0;
      Lc_sum_qtde := 0;
      for J := 1 to StrGrd_Produtos.RowCount - 1 do
      begin
        if (Lc_idx_promo = StrToIntDef(StrGrd_Produtos.Cells[13, J],0)) then
        Begin
          Lc_sum_qtde := Lc_sum_qtde + StrToFloatDef( StrGrd_Produtos.Cells[5,  J],0);
          Lc_itens_na_promo := Lc_itens_na_promo + 1;
        end;
      end;
      //Se as quantidades atingirem a quantidade da promoção, vamos manupular o valor unitario
      if ( Lc_sum_qtde = StrToFloatDef( StrGrd_Produtos.Cells[15, I],0) ) then
      Begin
        Lc_valor_promo := StrToFloatDef( StrGrd_Produtos.Cells[19, I],0);
        Lc_valor_unit := Lc_valor_promo / Lc_sum_qtde;
        Lc_str_unit := FloatToStrF(Lc_valor_unit,ffFixed,10,2);
        Lc_valor_unit := StrToFloatDEf(Lc_str_unit,0);
        //Faz o loop para alterar somente a promoção indexada
        Lc_sum_item_promo := 0;
        for K := 1 to StrGrd_Produtos.RowCount - 1 do
        begin
          if (Lc_idx_promo = StrToIntDef(StrGrd_Produtos.Cells[13, K],0)) then
          Begin
//            if Lc_itens_na_promo = 1 then
//            Begin
//              StrGrd_Produtos.Cells[6,  K] := FormatFloat('#0.00###', Lc_valor_unit);
//              Lc_Aux := (Lc_valor_unit * StrToFloatDef(StrGrd_Produtos.Cells[5,  K],0));
//              Lc_Aux := RoundTo( Lc_Aux,-2);
//              StrGrd_Produtos.Cells[7, K] := FloatToStrF(Lc_Aux , ffFixed, 10, 2);
//              Lc_sum_item_promo := Lc_sum_item_promo + Lc_Aux;
//
//            End
//            else
            Begin
              if Lc_itens_na_promo > 1 then
              Begin
                StrGrd_Produtos.Cells[6,  K] := FormatFloat('#0.00###', Lc_valor_unit);
                Lc_Aux := (Lc_valor_unit * StrToFloatDef(StrGrd_Produtos.Cells[5,  K],0));
                Lc_Aux := RoundTo( Lc_Aux,-2);
                StrGrd_Produtos.Cells[7, K] := FloatToStrF(Lc_Aux , ffFixed, 10, 2);
                Lc_sum_item_promo := Lc_sum_item_promo + Lc_Aux;
              end
              else
              Begin
                //Se este valor zero, quer dizer que estamos lidando com um registro unico e quantidade igual a 1
                if (Lc_sum_item_promo > 0) then
                Begin
                  Lc_valor_unit := StrToFloatDef( StrGrd_Produtos.Cells[19, K],0) - Lc_sum_item_promo;
                  //Quando a quantidade maior que 1 precisamos recalcular o valor unitário
                  Lc_valor_unit := Lc_valor_unit / StrToFloatDef(StrGrd_Produtos.Cells[5,  K],0);
                  StrGrd_Produtos.Cells[6,  K] := FormatFloat('#0.00###', Lc_valor_unit);
                    //Depois multimplicamos pela quantidade novamente para obter o subtotal que é o valor restante
                  Lc_Aux := (Lc_valor_unit * StrToFloatDef(StrGrd_Produtos.Cells[5,  K],0));
                  Lc_Aux := RoundTo( Lc_Aux,-2);
                  StrGrd_Produtos.Cells[7, K] := FloatToStrF(Lc_Aux , ffFixed, 10, 2);
                End;
              end;
              Lc_itens_na_promo := Lc_itens_na_promo - 1;
            End;
          end;
        end;
      end;
      //Guarda o indice da promoção para verificar no proxio loop
      Lc_idx_promo_ant := StrToIntDef(StrGrd_Produtos.Cells[13, I],0);
    end;
  End;
end;

procedure TFr_FrenteCaixa.TrocaTabela;
Var
  I : Integer;
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  LcFloTotal : Real;
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

    with StrGrd_Produtos do
    Begin
      for I := 1 to ( RowCount - 1 ) do
      Begin
        Lc_Qry.Active := False;
        Lc_Qry.ParamByName('PRC_CODTPR').AsInteger := It_cd_Tabela;
        Lc_Qry.ParamByName('PRC_CODPRO').AsInteger := StrToIntDef( Cells[2, I],0);
        Lc_Qry.Active := True;
        Lc_Qry.FetchAll;
        //Altera o valor Unitario
        Lc_Qtde := StrToFloatDef(Cells[5, I],0);
        Lc_Valor := Lc_Qry.FieldByName('PRC_VL_VDA').AsCurrency;
        Cells[6, I] := FormatFloat('#0.00###',Lc_Valor );

        LcFloTotal   := ( Lc_Valor * Lc_Qtde );
        LcFloTotal   := Roundto( LcFloTotal ,-2);

        Cells[7, I] := FloatToStrF( LcFloTotal ,ffFixed, 10,2);
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

End;

procedure TFr_FrenteCaixa.Sb_Confirma_TabelaPrecoClick(Sender: TObject);
begin
  if ValidaTrocaTabela then
  Begin
    It_cd_Tabela := Fm_ListaTabelaPreco.Dblcb_Lista.KeyValue;
    Lb_TipoVenda.Caption :=  Fm_ListaTabelaPreco.Dblcb_Lista.Text + ' - F12';
    TrocaTabela;
    Pc_SomaProdutos;
    Pc_Totalizador;
    ControleElementos(Pnl_TabelaPreco,True);
  End;
end;

procedure TFr_FrenteCaixa.GoCodigoClienteExecute(Sender: TObject);
begin
//  E_Cd_Cliente.SetFocus;
end;

procedure TFr_FrenteCaixa.Ac_GavetaExecute(Sender: TObject);
begin
  if Fc_ValidaAberturaGaveta(It_Usa_Gaveta) then
    Pc_AbreGaveta;
end;

//============================== TEF=========================================
procedure TFr_FrenteCaixa.TEFComandaECFAbreVinculado(COO, IndiceECF: string;
  Valor: Double; var RetornoECF: Integer);
begin
  try
     RetornoECF := 1 ;
  except
     RetornoECF := 0 ;
  end;
end;

procedure TFr_FrenteCaixa.ImprimeComprovante(Via:Integer;c:TStringList);
VAR
  PrtGeneral : TGeneralPrint;
  PrtGraphic : TGraphicPrint;
  I : Integer;
  Traco : String;
Begin
  if ImpCompTefMostraUsuario then
  Begin
    if Via = 2 then
    Begin
      //Define o tamanhho do Traço
      Traco := '';
      For I:= 1 to ImpNumeroColunas do
        Traco := Traco + '-';

      //Adiciona dados do Usuario
      c. Add('');
      c.Add(Traco);
      c.Add(Concat('OPERADOR: ',GB_Nm_Usuario ));
      c.Add(Traco);
    End;
  End;

  if ImpModelo = 1 then
  Begin
    PrtGeneral := TPrintGeneralFactory.criarPrint('EPSON - TM-T20');
    With PrtGeneral Do
    begin
      Porta := ImpPorta;
      Quebralinha := ImpCompTefQuebra;
      Iniciar;
      for I := 0 to c.Count - 1 do
        TextOutLC(1,1,c.Strings[I]);
      Saltar(ImpSaltos);
      CortarPapel(0);
      Fechar;
    end;
    FreeAndNil(PrtGeneral);
  End
  else
  Begin
    //Gerenciado pelo Windows
    if ImpModelo = 5 then
    Begin
      PrtGraphic := TGraphicPrint.Create;
      PrtGraphic.Linhas := c.Count;
      PrtGraphic.Saltos := ImpSaltos;
      PrtGraphic.Iniciar;
      PrtGraphic.print(c);
      PrtGraphic.Saltar;
      PrtGraphic.Fechar;
      FreeAndNil(PrtGraphic);
    end
    else
    Begin
      try
        PrtGeneral := TPrintGeneralFactory.criarPrint('BEMATECH - MP4200');
        with  PrtGeneral do
        Begin
          case ImpModelo of
            2:ModeloImpressora := 7;
            3:ModeloImpressora := 5;
            4:ModeloImpressora := 5;
            6:ModeloImpressora := 8;
          end;
          Porta := ImpPorta;
          TamanhoMargem := 3;
          Iniciar;
          for I := 0 to c.Count - 1 do
            TextOutLC(1,1,c.Strings[I]);
          Saltar(ImpSaltos);
          CortarPapel(0);
          Fechar;
        End;
      finally
        FreeAndNil(PrtGeneral);
      end;
    End;
  End

END;

procedure TFr_FrenteCaixa.InitVariable;
begin
  Pedido    := TControllerPedidoVda.Create(Self);
  CtrlTEF   := TControllerTefMovimento.Create(Self);
  Promocao  := TControllerDskPromotion.Create(Self);
  ListaPedidoItem := TListaItemVenda.Create;
  forcafechamento := False;
end;

procedure TFr_FrenteCaixa.TEFComandaECFImprimeVia(
  TipoRelatorio: TACBrTEFDTipoRelatorio; Via: Integer;
  ImagemComprovante: TStringList; var RetornoECF: Integer);
begin
  try
     case TipoRelatorio of
       trGerencial :
         ImprimeComprovante(Via,ImagemComprovante); //mm_Tef.Lines.Add('GERENCIAL:' + ImagemComprovante.Text);
       trVinculado :
         ImprimeComprovante(Via,ImagemComprovante); //mm_Tef.Lines.Add('VINCULADO:' + ImagemComprovante.Text);
     end;
     RetornoECF := 1 ;
  except
     RetornoECF := 0 ;
  end;
end;

procedure TFr_FrenteCaixa.TEFComandaECFSubtotaliza(DescAcre: Double;
  var RetornoECF: Integer);
begin
  estadoSimuladoEcf := tpsPagamento;
  RetornoECF := 1 ;
end;

procedure TFr_FrenteCaixa.TEFDepoisConfirmarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
begin
  CtrlTEF.Clear;
  CtrlTEF.Registro.CodigoPedido := Self.Pedido.Registro.codigo;
  CtrlTEF.Registro.Estabelecimento := Gb_CodMha; ;
  CtrlTEF.Registro.status := 'F';
  CtrlTEF.finaliza;
end;

procedure TFr_FrenteCaixa.TEFExibeMsg(
  Operacao: TACBrTEFDOperacaoMensagem;
  Mensagem: string; var AModalResult: TModalResult);
var
   Fim : TDateTime;
   OldMensagem : String;
begin
  case Operacao of
    opmOK :
       AModalResult := MessageDlg( Mensagem, mtInformation, [mbOK], 0);

    opmYesNo :
       AModalResult := MessageDlg( Mensagem, mtConfirmation, [mbYes,mbNo], 0);

    opmExibirMsgOperador, opmRemoverMsgOperador :
         lMensagemOperador.Caption := Mensagem ;

    //  opmExibirMsgCliente, opmRemoverMsgCliente :
    //     lMensagemCliente.Caption := Mensagem ;
    opmDestaqueVia :
      begin
        OldMensagem := lMensagemOperador.Caption ;
        try
          lMensagemOperador.Caption := Mensagem ;
          { Aguardando 3 segundos }
          Fim := IncSecond( now, 3)  ;
          repeat
            sleep(200) ;
            lMensagemOperador.Caption := Mensagem + ' ' + IntToStr(SecondsBetween(Fim,now));
          until (now > Fim) ;

        finally
          lMensagemOperador.Caption := OldMensagem ;
        end;
      end;
  end;
  Application.ProcessMessages;
end;

procedure TFr_FrenteCaixa.TEFExibeQRCode(const Dados: string);
var
  frCode :TFormQrCode;
begin

  if (Dados <> '') then
  Begin
    try
      TEF.BloquearMouseTeclado(False);
      frCode := TFormQrCode.Create(nil);
      frCode.Dados := Dados;
      frCode.ShowModal;
    finally
      TEF.BloquearMouseTeclado(True);
      FreeAndNil(frCode);
    end;
  End;
end;

procedure TFr_FrenteCaixa.TEFInfoECF(Operacao: TACBrTEFDInfoECF;
  var RetornoECF: string);
var
   ASubTotal: Double;
begin
  { Para CliSiTEF ou V&SPague aplique o IF abaixo em sua aplicação, que
    permite saber se o Cupom foi concluido mesmo com o ECF desligado }

  if (not TEF.TEF.Inicializado) and   { Esta na inicialização ? }
       (TEF.GPAtual in [gpCliSiTef,gpVeSPague]) then
  begin
    { Leia o último Documento Gravado no seu Banco de Dados, e verifique
      se o Cupom já foi finalizado,ou se já foi aberto um CCD ou Gerencial...
      Exemplo:}

    CtrlTEF.Registro.Usuario := GB_Cd_Usuario;
    if CtrlTEF.getByStatus('I') then
      RetornoECF := 'O'
    else
      RetornoECF := 'R';

    //RetornoECF := 'O';    // ExecutarÉ CancelarTransacoesPendentes;
    //RetornoECF := 'R';    // ExecutarÉ ConfirmarESolicitarImpressaoTransacoesPendentes;
    exit ;
  end ;

  case Operacao of
    ineSubTotal :
      begin
        ASubTotal := StrToFloatDef(E_VL_Total.Caption, 0);
        //ASubTotal := ASubTotal - StringToFloatDef(EditTotalPago.Text, 0){ + Tratar Desconto e Acrescimo aqui: StringToFloatDef(edValorDescAcre.Text, 0)};
        RetornoECF := FloatToStr(ASubTotal);
        if estadoSimuladoEcf = tpsPagamento then
          RetornoECF := FloatToStr(0);
      end;

    ineTotalAPagar :
        RetornoECF := '0';

    ineEstadoECF :
      begin
        Case estadoSimuladoEcf of
          tpsLivre     : RetornoECF := 'L' ;
          tpsVenda     : RetornoECF := 'V' ;
          tpsPagamento : RetornoECF := 'P' ;
          tpsRelatorio : RetornoECF := 'R' ;
        else
          RetornoECF := 'O' ;
        end;
      end;
   end;
end;

procedure TFr_FrenteCaixa.TEFMudaEstadoReq(EstadoReq: TACBrTEFDReqEstado);
begin
   mm_Tef.Lines.Add( GetEnumName(TypeInfo(TACBrTEFDReqEstado), Integer(EstadoReq) ) );
   mm_Tef.Update;
   fCancelado := False ;
end;

procedure TFr_FrenteCaixa.TEFMudaEstadoResp(EstadoResp: TACBrTEFDRespEstado);
begin
  mm_Tef.Lines.Add( GetEnumName(TypeInfo(TACBrTEFDRespEstado), Integer(EstadoResp) ) );
  mm_Tef.Update;
  bCancelarResp.Visible     := (EstadoResp = respAguardandoResposta) ;
end;

procedure TFr_FrenteCaixa.TEFRestauraFocoAplicacao(var Tratado: Boolean);
begin
  Application.BringToFront;
  Tratado := False ;  { Deixa executar o código de Foco do ACBrTEFD }
end;

procedure TFr_FrenteCaixa.ComissoDelivery1Click(Sender: TObject);
Var
  Lc_Form :TFr_Imp_Comissao;
begin
  if Fc_VerificaPermissao('Fr_Imp_Comissao','Relatorio Comissão','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Imp_Comissao.create(nil);
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    end;
  End;
end;

procedure TFr_FrenteCaixa.ConfigAtivaTEF;
var
  stringCNPJCliente : String;
  stringCNPJSoftwareHouse : String;
Begin
  with TEF do
  Begin
    AutoAtivarGP := True;
    MultiplosCartoes := True;
    EsperaSleep := 250;
    EsperaSTS := 7;
    TEFCliSiTef.CodigoLoja := Fc_Tb_Geral('L','TEF_ID_LOJA','0'); //'00000000';
    TEFCliSiTef.EnderecoIP := Fc_Tb_Geral('L','TEF_IP_SERVIDOR','0'); // '127.0.0.1';
    TEFCliSiTef.NumeroTErminal := Fc_Aq_Geral('L','TEF','TEF_ID_TERMINAL','0'); //'SE000001';
    TEFCliSiTef.PortaPinPad := StrToIntDef( Fc_Aq_Geral('L','TEF','TEF_PORTA_PINPAD','0'), 8);// 8;
    //TEFCliSiTef.Restricoes := '{DevolveStringQRCode=1}';
    TEFCliSiTef.Restricoes := '{DevolveStringQRCode=1};{[10;11;12;13;14]};';
    ExibirMsgAutenticacao := fALSE;
    Identificacao.NomeAplicacao := 'Gestão Setes';
    Identificacao.VersaoAplicacao := '2.016';
    Identificacao.SoftwareHouse := 'GESTAO COMPUTACIONAL SETES ';
    Identificacao.RazaoSocial := 'F. D. SOUZA DESENVOLVIMENTO E LICENCIAMENTO DE PROGRAMAS';
    Identificacao.RegistroCertificacao := '';
    Pc_AtivaEstabelecimento;
    stringCNPJCliente := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
    stringCNPJSoftwareHouse := '07742094000113';
    TEFCliSiTef.ParametrosAdicionais.Text := 'ParmsClient=1='+stringCNPJCliente+';2='+stringCNPJSoftwareHouse;
    TEFCliSiTef.PathDLL := GbPathExe;
    estadoSimuladoEcf := tpsLivre;
    lMensagemOperador.Font.color := clBlack;
    Application.ProcessMessages;
    if not Inicializado( gpCliSiTef ) then
    Begin
      try
        try
          Inicializar( gpCliSiTef );
          //Encerra tef pendente
          CtrlTEF.Registro.Estabelecimento := Gb_CodMha;
          CtrlTEF.Registro.Usuario := GB_Cd_Usuario;

          CtrlTEF.encerraPendentes;
          //Conclui tef pendente
          CtrlTEF.Registro.Estabelecimento := Gb_CodMha;
          CtrlTEF.Registro.Usuario := GB_Cd_Usuario;
          CtrlTEF.ConcluiPendentes;

        finally
          lMensagemOperador.Font.Color := clBlack;
          mm_Tef.Lines.Add('TEF Inicializado');
          Application.ProcessMessages;
        end;
       except
          on E : Exception do
          Begin
            ShowMessage(E.ClassName+' Erro enontrado: '+E.Message);
            lMensagemOperador.Font.Color := clRed;
            lMensagemOperador.Caption := 'TEF NÃO FOI ATIVADO. VERIFIQUE!!';
            Application.ProcessMessages;
          End;
       end;
    end;
  End;
end;

procedure TFr_FrenteCaixa.MenuOperMenuFiscalClick(Sender: TObject);
Var
  LcForm : TTasMenuFiscalPaf;
begin
  try
    LcForm := TTasMenuFiscalPaf.create(nil);
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_FrenteCaixa.MnuConsultarComandaClick(Sender: TObject);
begin
  ConsultarCommand;
end;

procedure TFr_FrenteCaixa.MnuConsultarDeliveryClick(Sender: TObject);
begin
  ConsultaDelivery;
end;

procedure TFr_FrenteCaixa.ConsultaDelivery;
Var
  Lc_Form : TFr_PizzariaEntrega;
begin
  try
    Lc_Form := TFr_PizzariaEntrega.create(nil);
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_FrenteCaixa.ConsultarCommand;
var
  Form :TSeaCommand;
begin
  try
    Form := TSeaCommand.Create(nil);
    Form.ShowModal;
    if Form.Visualizar then
    BEgin
      CarregaItensCommand( Form.ComandaEscolhida );
    End;
  finally
    FreeAndNil(Form);
  end;
end;


end.
