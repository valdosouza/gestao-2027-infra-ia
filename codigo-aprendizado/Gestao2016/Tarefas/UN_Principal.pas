unit UN_Principal;
//{$D-}  // desabilitar debug
//{$WEAKLINKRTTI ON}
interface

uses
      Windows, Messages, SysUtils, Variants, Classes, System.Threading, IB, TypInfo, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, QRExport, QRPDFFilt, ACBrDANFCeFortesFr, ACBrBoleto, un_thread_retaguarda, ACBrPosPrinter, ACBrNFeDANFEClass, ACBrNFeDANFeESCPOS, ACBrValidador, ACBrBoletoFCFortesFr, ImageList, ImgList, Controls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, ACBrDFeReport, ACBrDFeDANFeReport, ACBrNFeDANFeRLClass, ACBrDFe, ACBrNFe, ACBrBase, ACBrGAV, Dialogs, Actions, ActnList, Data.DB, STQuery, STStoredProc, STTransaction, ExtCtrls, AppEvnts, Menus, StdCtrls, Mask, Graphics, Buttons, ComCtrls, shellapi, Forms, SetesTEF, IniFiles, STDatabase, Vcl.Imaging.GIFImg, Vcl.Imaging.jpeg, QEdit_Setes, ACBrGIF, ACBrPIXCD, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, Vcl.Samples.Gauges, Un_ProcessoAguarde, Vcl.CategoryButtons, Vcl.Imaging.pngimage, base_frame_list;

type
  TFr_Principal = class(TForm)
    MnuOper: TMainMenu;
    MnuArqOpe: TMenuItem;
    MnuArqClienteoOper: TMenuItem;
    MnuArqFornOper: TMenuItem;
    MnuArqTranspOper: TMenuItem;
    N17: TMenuItem;
    MnuArqGpPdOper: TMenuItem;
    MnuArqCadSrvOper: TMenuItem;
    MnuArqCadProdOper: TMenuItem;
    N1: TMenuItem;
    MnuArqSairOper: TMenuItem;
    MnuModOper: TMenuItem;
    MnuModFinOper: TMenuItem;
    MnuModBancoOper: TMenuItem;
    MnuModAnalOper: TMenuItem;
    Pessoal1: TMenuItem;
    MnuTafOper: TMenuItem;
    MnuTafTrfOper: TMenuItem;
    MnuTafAjtEstOper: TMenuItem;
    N3: TMenuItem;
    MnuTafOVSOper: TMenuItem;
    MnuTafCpaOper: TMenuItem;
    MnuRelOper: TMenuItem;
    MnuRelClienteOper: TMenuItem;
    MnuRelProdOper: TMenuItem;
    N12: TMenuItem;
    MnuRelMpCrgOper: TMenuItem;
    MnuRelVdaOper: TMenuItem;
    MnuRelCpaOper: TMenuItem;
    MnuAjdOper: TMenuItem;
    MnuMhaEmpOper: TMenuItem;
    Aniversariantes1: TMenuItem;
    MnuAjdManuUsuOper: TMenuItem;
    MnuAjdManuBkpOper: TMenuItem;
    MnuAjdTrShaOper: TMenuItem;
    MnuAjdCfgNFOper: TMenuItem;
    MnuAjdSobreOper: TMenuItem;
    AppEvents: TApplicationEvents;
    Tm_Status: TTimer;
    SB_Status: TStatusBar;
    MnuPsl: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    Bancrio1: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    ManutenoComisses1: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MnuBco: TMainMenu;
    MnuArqBco: TMenuItem;
    MnuArqBancoBco: TMenuItem;
    MnuArqContaBco: TMenuItem;
    MnuArqHistBco: TMenuItem;
    N5: TMenuItem;
    MnuArqSairBco: TMenuItem;
    MnuModBco: TMenuItem;
    MnuModFinBco: TMenuItem;
    MnuModOperBco: TMenuItem;
    MnuModAnalBco: TMenuItem;
    Pessoal3: TMenuItem;
    MnuTafBco: TMenuItem;
    MnuTafLacBco: TMenuItem;
    MnuRelBco: TMenuItem;
    MnuRelLancBco: TMenuItem;
    MnuRelExtrato: TMenuItem;
    MnuFin: TMainMenu;
    MnuArqFin: TMenuItem;
    MnuArqFPagtoFin: TMenuItem;
    MnuArqPlCtaFin: TMenuItem;
    N2: TMenuItem;
    MnuArqSairFin: TMenuItem;
    MnuModFin: TMenuItem;
    MnuModOpeFin: TMenuItem;
    MnuModBanFin: TMenuItem;
    MnuModAnalFin: TMenuItem;
    Pessoal2: TMenuItem;
    MnuTafFin: TMenuItem;
    MnuTafManuDupFin: TMenuItem;
    FichaFinCliente1: TMenuItem;
    N14: TMenuItem;
    MnuTafManuPagFin: TMenuItem;
    FichaFinanceiraFornecedor1: TMenuItem;
    N8: TMenuItem;
    MnuTafCtrlChqFin: TMenuItem;
    MnuTafLanCxaFin: TMenuItem;
    MnuRelFin: TMenuItem;
    MnuRelCtaRbrFin: TMenuItem;
    MnuRelCtrlChqFin: TMenuItem;
    N10: TMenuItem;
    MnuRelCtaPgrFin: TMenuItem;
    MnuRelLanCxaFin: TMenuItem;
    N23: TMenuItem;
    FluxodeCaixa1: TMenuItem;
    Duplicatas1: TMenuItem;
    Lucratividade1: TMenuItem;
    Contatos1: TMenuItem;
    Cargos1: TMenuItem;
    Observao1: TMenuItem;
    Prazos1: TMenuItem;
    NaturezaCFOP1: TMenuItem;
    ransformao1: TMenuItem;
    N9: TMenuItem;
    SB_Encerrar: TSpeedButton;
    Bevel1: TBevel;
    Bevel4: TBevel;
    SB_Clientes: TSpeedButton;
    SB_Fornecedor: TSpeedButton;
    SB_PedidoCpa: TSpeedButton;
    SB_Help: TSpeedButton;
    SB_Pedido: TSpeedButton;
    Sb_Fi_Fin_Cli: TSpeedButton;
    Sb_Cta_Receber: TSpeedButton;
    Sb_cheques: TSpeedButton;
    Sb_Produtos: TSpeedButton;
    Sb_LancaBanco: TSpeedButton;
    LogPedidos1: TMenuItem;
    N13: TMenuItem;
    ipoVeculo1: TMenuItem;
    N24: TMenuItem;
    MarcasModelos1: TMenuItem;
    Veculos1: TMenuItem;
    OrdemdeServio1: TMenuItem;
    N25: TMenuItem;
    Produo1: TMenuItem;
    N27: TMenuItem;
    EtiquetasMalaDireta1: TMenuItem;
    CpiaBDados1: TMenuItem;
    Pnl_Login: TPanel;
    Mnu_inicial: TMainMenu;
    Sair2: TMenuItem;
    CRMClientes1: TMenuItem;
    CartoEletrnico1: TMenuItem;
    Gerencial1: TMenuItem;
    Sb_Orcamento: TSpeedButton;
    ConsultaConserto1: TMenuItem;
    Sb_Clta_Cst: TSpeedButton;
    N29: TMenuItem;
    MapaProduo1: TMenuItem;
    Sb_Agenda: TSpeedButton;
    Sb_Telefone: TSpeedButton;
    Vales1: TMenuItem;
    Vales2: TMenuItem;
    EtiquetasProdutos1: TMenuItem;
    Tm_Agenda: TTimer;
    Sb_Fi_Fin_For: TSpeedButton;
    Representada1: TMenuItem;
    Despacho1: TMenuItem;
    NotaFiscalEletrnica1: TMenuItem;
    Sintegra1: TMenuItem;
    AssistnciaTcnica1: TMenuItem;
    Sincronia1: TMenuItem;
    Ajustes1: TMenuItem;
    N31: TMenuItem;
    ributao1: TMenuItem;
    ActionList1: TActionList;
    Atualizao1: TMenuItem;
    Action3: TAction;
    Sb_MultiEmpresa: TSpeedButton;
    N32: TMenuItem;
    Notas1: TMenuItem;
    AjustaPreo1: TMenuItem;
    Sb_Cta_Pagar: TSpeedButton;
    Pnl_ToolBar: TPanel;
    Situao1: TMenuItem;
    Sb_Pesq_Produtos: TSpeedButton;
    VencimentoExtintores1: TMenuItem;
    N34: TMenuItem;
    ResumoSelos1: TMenuItem;
    Medidas1: TMenuItem;
    Embalagens1: TMenuItem;
    Marcas1: TMenuItem;
    Oramento1: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    Perfil1: TMenuItem;
    Interface1: TMenuItem;
    Perfil2: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    Buffet1: TMenuItem;
    N7: TMenuItem;
    N18: TMenuItem;
    BaixaporLote1: TMenuItem;
    ConectaBanco1: TMenuItem;
    Pizzaria1: TMenuItem;
    N11: TMenuItem;
    Controledelotes1: TMenuItem;
    Boto1: TMenuItem;
    SaveDialogo: TSaveDialog;
    Desenvolvimento1: TMenuItem;
    ControledeSries1: TMenuItem;
    Frente1: TMenuItem;
    ipoExtintor1: TMenuItem;
    TabelasdePreco: TMenuItem;
    nalisemovimentaoprodutos1: TMenuItem;
    LogdeOperaes1: TMenuItem;
    EFDPISCOFINS1: TMenuItem;
    PrVendaBalco1: TMenuItem;
    AnlisedeNegcios1: TMenuItem;
    N16: TMenuItem;
    Cardpio1: TMenuItem;
    MotivoCondenaoReprovao1: TMenuItem;
    N19: TMenuItem;
    NvelManunteo1: TMenuItem;
    Extintores1: TMenuItem;
    Selos1: TMenuItem;
    Ensaiador1: TMenuItem;
    N20: TMenuItem;
    OrdemdeSerioExtintores1: TMenuItem;
    BoletoEletronico1: TMenuItem;
    Extintores2: TMenuItem;
    Img_Inmetro: TImage;
    ImportarXMLdaNFe1: TMenuItem;
    N26: TMenuItem;
    AgenteExtintor1: TMenuItem;
    Conferncia1: TMenuItem;
    DescontarDuplicata1: TMenuItem;
    Estoques1: TMenuItem;
    EnsariodeFuncionamento1: TMenuItem;
    AgenteExtintor2: TMenuItem;
    N28: TMenuItem;
    ManutenoVeculos1: TMenuItem;
    readeTestes1: TMenuItem;
    Voltaraversoanterior1: TMenuItem;
    OrigemdaVenda1: TMenuItem;
    ControledeBoletos1: TMenuItem;
    N39: TMenuItem;
    OrdensdeProduo1: TMenuItem;
    OrigemdoCliente1: TMenuItem;
    Contabilidade1: TMenuItem;
    N41: TMenuItem;
    Impressoras1: TMenuItem;
    LojaVirtual1: TMenuItem;
    MnuRamodeAtividade: TMenuItem;
    CientesemProspeco1: TMenuItem;
    ConfiguraesLocais1: TMenuItem;
    N42: TMenuItem;
    NotasFiscaisConsumidor1: TMenuItem;
    Img_Youtube: TImage;
    Venda1: TMenuItem;
    Servico1: TMenuItem;
    QrpPDF: TQRPDFFilter;
    QrpXLS: TQRExcelFilter;
    Img_Principal: TImage;
    Sb_Logout: TSpeedButton;
    Lb_Title: TLabel;
    N30: TMenuItem;
    NotasFiscaisdeServio1: TMenuItem;
    Panel1: TPanel;
    SB_Login: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    E_Senha: TMaskEdit;
    CB_Usuario: TComboBox;
    PedidodeVendaRemoto1: TMenuItem;
    Img_Aguarde: TImage;
    BaixarAtualizador1: TMenuItem; 
    N33: TMenuItem;
    FechametoFinanceiro1: TMenuItem;
    ControleSequenciaNotas1: TMenuItem;
    MalaDiretaemail1: TMenuItem;
    Promoes1: TMenuItem;
    InventrioManual1: TMenuItem;
    PedidodeVendaLojaVirtual1: TMenuItem;
    LogOramento1: TMenuItem;
    N4: TMenuItem;
    Fechamento1: TMenuItem;
    Comanda1: TMenuItem;
    Consignao1: TMenuItem;
    EstoqueManual1: TMenuItem;
    N6: TMenuItem;
    AlteraesnoSistema1: TMenuItem;
    Bevel3: TBevel;
    Bevel2: TBevel;
    N43: TMenuItem;
    AgendaSalo1: TMenuItem;
    Bevel5: TBevel;
    N44: TMenuItem;
    ControleBasedeTroca1: TMenuItem;
    InventrioAutomtico1: TMenuItem;
    Equipamentos1: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    ManutenoEletrnicos1: TMenuItem;
    N47: TMenuItem;
    AtendimetoPet1: TMenuItem;
    N48: TMenuItem;
    Pets1: TMenuItem;
    ListaTerminais: TMenuItem;
    http_down: TIdHTTP;
    MenuOperMenuFiscal: TMenuItem;
    MenuFinMenuFiscal: TMenuItem;
    MenuBcoMenuFiscal: TMenuItem;
    MenuPslMenuFiscal: TMenuItem;
    Retaguarda1: TMenuItem;
    N49: TMenuItem;
    Moveleiro1: TMenuItem;
    Contratos1: TMenuItem;
    N50: TMenuItem;
    Image1: TImage;
    ControleEstpqueZerado1: TMenuItem;
    RetaguardaWEB1: TMenuItem;
    Configuraes1: TMenuItem;
    Ifood1: TMenuItem;
    WhatsApp1: TMenuItem;
    N51: TMenuItem;
    Grfica1: TMenuItem;
    ManuteoFrotaPrpria1: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    MarketplaceMagazord1: TMenuItem;
    Acb_Gaveta: TACBrGAV;
    Boleto: TACBrBoleto;
    BoletoFcFortes: TACBrBoletoFCFortes;
    Nfe: TACBrNFe;
    ACBrValidador1: TACBrValidador;
    Danfe_NFCe_S: TACBrNFeDANFeESCPOS;
    Danfe_NFCe_F: TACBrNFeDANFCeFortes;
    ACBrPosPrinter: TACBrPosPrinter;
    ImageGeral: TImageList;
    MnuAnal: TMainMenu;
    MnuArqAnal: TMenuItem;
    Veiculo1: TMenuItem;
    Motoristas1: TMenuItem;
    Ocorrencias1: TMenuItem;
    Defeitos1: TMenuItem;
    PadresVerificaes1: TMenuItem;
    N15: TMenuItem;
    Sair1: TMenuItem;
    MnuModAnal: TMenuItem;
    MnuModOperAnal: TMenuItem;
    MnuModFinAnal: TMenuItem;
    MnuModBcoAnal: TMenuItem;
    Pessoal4: TMenuItem;
    MnuTarAnal: TMenuItem;
    MnuTarAnalSintAnal: TMenuItem;
    MnuTarAnalAnltAnal: TMenuItem;
    N21: TMenuItem;
    Calibrao1: TMenuItem;
    MnuRelAnal: TMenuItem;
    MnuRelAnalDiscoAnal: TMenuItem;
    MnuRelVeicAnal: TMenuItem;
    MnuRelMotAnal: TMenuItem;
    N22: TMenuItem;
    Certificados1: TMenuItem;
    Panel3: TPanel;
    Image3: TImage;
    Label4: TLabel;
    pnl_notification: TPanel;
    Configurao1: TMenuItem;
    AtualizarSchemas1: TMenuItem;
    vInutilizaodeNotas1: TMenuItem;
    OperaesNFe1: TMenuItem;
    OperaesNFCe1: TMenuItem;
    ConsultaLotes1: TMenuItem;
    AutorizaLoteOFFLine1: TMenuItem;
    ImpressoXML1: TMenuItem;
    OpenDialog1: TOpenDialog;
    ReformaTributria1: TMenuItem;
    Dfe_Fortes: TACBrNFeDANFeRL;

    procedure AppEventsHint(Sender: TObject);

    procedure Tm_StatusTimer(Sender: TObject);
    procedure MnuAjdManuUsuOperClick(Sender: TObject);
    procedure MnuAjdSobreOperClick(Sender: TObject);
    procedure Contatos1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
    procedure Pessoal1Click(Sender: TObject);
    procedure MnuArqFornOperClick(Sender: TObject);
    procedure MnuArqTranspOperClick(Sender: TObject);
    procedure MnuArqGpPdOperClick(Sender: TObject);
    procedure MnuArqCadProdOperClick(Sender: TObject);
    procedure Observao1Click(Sender: TObject);
    procedure MnuArqCadSrvOperClick(Sender: TObject);
    procedure MnuArqPlCtaFinClick(Sender: TObject);
    procedure MnuArqFPagtoFinClick(Sender: TObject);
    procedure MnuModFinOperClick(Sender: TObject);
    procedure MnuModOpeFinClick(Sender: TObject);
    procedure MnuModOperBcoClick(Sender: TObject);
    procedure MnuModOperAnalClick(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MnuModFinBcoClick(Sender: TObject);
    procedure MnuModFinAnalClick(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MnuModBancoOperClick(Sender: TObject);
    procedure MnuModBanFinClick(Sender: TObject);
    procedure MnuModBcoAnalClick(Sender: TObject);
    procedure Bancrio1Click(Sender: TObject);
    procedure Pessoal2Click(Sender: TObject);
    procedure Pessoal3Click(Sender: TObject);
    procedure Pessoal4Click(Sender: TObject);
    procedure MnuArqBancoBcoClick(Sender: TObject);
    procedure MnuMhaEmpOperClick(Sender: TObject);
    procedure MnuArqHistBcoClick(Sender: TObject);
    procedure MnuAjdManuBkpOperClick(Sender: TObject);
    procedure Prazos1Click(Sender: TObject);
    procedure MnuTafOVSOperClick(Sender: TObject);
    procedure NaturezaCFOP1Click(Sender: TObject);
    procedure MnuRelVdaOperClick(Sender: TObject);
    procedure MnuRelCtaRbrFinClick(Sender: TObject);
    procedure MnuRelCtaPgrFinClick(Sender: TObject);
    procedure MnuRelClienteOperClick(Sender: TObject);
    procedure FluxodeCaixa1Click(Sender: TObject);
    procedure MnuTafManuDupFinClick(Sender: TObject);
    procedure MnuTafManuPagFinClick(Sender: TObject);
    procedure MnuTafLanCxaFinClick(Sender: TObject);
    procedure MnuRelProdOperClick(Sender: TObject);
    procedure MnuRelCpaOperClick(Sender: TObject);
    procedure FichaFinCliente1Click(Sender: TObject);
    procedure FichaFinanceiraFornecedor1Click(Sender: TObject);
    procedure MnuRelLanCxaFinClick(Sender: TObject);
    procedure Duplicatas1Click(Sender: TObject);
    procedure MnuRelLancBcoClick(Sender: TObject);
    procedure MnuRelExtratoClick(Sender: TObject);
    procedure MnuTafCtrlChqFinClick(Sender: TObject);
    procedure MnuTafCpaOperClick(Sender: TObject);
    procedure MnuTafTrfOperClick(Sender: TObject);
    procedure MnuRelCtrlChqFinClick(Sender: TObject);
    procedure MnuTafAjtEstOperClick(Sender: TObject);
    procedure ManutenoComisses1Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure Aniversariantes1Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure SB_ClientesClick(Sender: TObject);
    procedure SB_FornecedorClick(Sender: TObject);
    procedure SB_PedidoCpaClick(Sender: TObject);
    procedure Sb_ProdutosClick(Sender: TObject);
    procedure Sb_Fi_Fin_CliClick(Sender: TObject);
    procedure Sb_Cta_ReceberClick(Sender: TObject);
    procedure Sb_chequesClick(Sender: TObject);
    procedure LogPedidos1Click(Sender: TObject);
    procedure ransformao1Click(Sender: TObject);
    procedure ipoVeculo1Click(Sender: TObject);
    procedure MarcasModelos1Click(Sender: TObject);
    procedure Veculos1Click(Sender: TObject);
    procedure OrdemdeServio1Click(Sender: TObject);
    procedure Produo1Click(Sender: TObject);
    procedure MnuRelMpCrgOperClick(Sender: TObject);
    procedure MnuArqSairOperClick(Sender: TObject);
    procedure MnuArqSairFinClick(Sender: TObject);
    procedure MnuArqSairBcoClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure EtiquetasMalaDireta1Click(Sender: TObject);
    procedure Lucratividade1Click(Sender: TObject);
    procedure CpiaBDados1Click(Sender: TObject);
    procedure SB_LoginClick(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_LogoutClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CRMClientes1Click(Sender: TObject);
    procedure CartoEletrnico1Click(Sender: TObject);
    procedure Gerencial1Click(Sender: TObject);
    procedure Sb_OrcamentoClick(Sender: TObject);
    procedure ConsultaConserto1Click(Sender: TObject);
    procedure Sb_Clta_CstClick(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MapaProduo1Click(Sender: TObject);
    procedure Sb_TelefoneClick(Sender: TObject);
    procedure Vales1Click(Sender: TObject);
    procedure Vales2Click(Sender: TObject);
    procedure EtiquetasProdutos1Click(Sender: TObject);
    procedure Tm_AgendaTimer(Sender: TObject);
    procedure Sb_AgendaClick(Sender: TObject);
    procedure Sb_Fi_Fin_ForClick(Sender: TObject);
    procedure Despacho1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Sintegra1Click(Sender: TObject);
    procedure Ajustes1Click(Sender: TObject);
    procedure ributao1Click(Sender: TObject);
    procedure Atualizao1Click(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Cidades1Click(Sender: TObject);
    procedure Estados1Click(Sender: TObject);
    procedure Notas1Click(Sender: TObject);
    procedure AjustaPreo1Click(Sender: TObject);
    procedure AssistnciaTcnica1Click(Sender: TObject);
    procedure Sb_Cta_PagarClick(Sender: TObject);
    procedure Situao1Click(Sender: TObject);
    procedure Sb_Pesq_ProdutosClick(Sender: TObject);
    procedure Medidas1Click(Sender: TObject);
    procedure Embalagens1Click(Sender: TObject);
    procedure Marcas1Click(Sender: TObject);
    procedure Oramento1Click(Sender: TObject);
    procedure Perfil1Click(Sender: TObject);
    procedure Interface1Click(Sender: TObject);
    procedure Perfil2Click(Sender: TObject);
    procedure BaixaporLote1Click(Sender: TObject);
    procedure ConectaBanco1Click(Sender: TObject);
    procedure Pizzaria1Click(Sender: TObject);
    procedure Controledelotes1Click(Sender: TObject);
    procedure Buffet1Click(Sender: TObject);
    procedure AppEventsException(Sender: TObject; E: Exception);
    procedure Desenvolvimento1Click(Sender: TObject);
    procedure ControledeSries1Click(Sender: TObject);
    procedure Frente1Click(Sender: TObject);
    procedure TabelasdePrecoClick(Sender: TObject);
    procedure nalisemovimentaoprodutos1Click(Sender: TObject);
    procedure LogdeOperaes1Click(Sender: TObject);
    procedure EFDPISCOFINS1Click(Sender: TObject);
    procedure PrVendaBalco1Click(Sender: TObject);
    procedure AnlisedeNegcios1Click(Sender: TObject);
    procedure Cardpio1Click(Sender: TObject);
    procedure BoletoEletronico1Click(Sender: TObject);
    procedure ImportarXMLdaNFe1Click(Sender: TObject);
    procedure Conferncia1Click(Sender: TObject);
    procedure DescontarDuplicata1Click(Sender: TObject);
    procedure Estoques1Click(Sender: TObject);
    procedure ManutenoVeculos1Click(Sender: TObject);
    procedure readeTestes1Click(Sender: TObject);
    procedure Voltaraversoanterior1Click(Sender: TObject);
    procedure OrigemdaVenda1Click(Sender: TObject);
    procedure ControledeBoletos1Click(Sender: TObject);
    procedure OrdensdeProduo1Click(Sender: TObject);
    procedure OrigemdoCliente1Click(Sender: TObject);
    procedure Contabilidade1Click(Sender: TObject);
    procedure SPEDFiscal1Click(Sender: TObject);
    procedure Sb_MultiEmpresaClick(Sender: TObject);
    procedure Impressoras1Click(Sender: TObject);
    procedure LojaVirtual1Click(Sender: TObject);
    procedure MnuRamodeAtividadeClick(Sender: TObject);
    procedure CientesemProspeco1Click(Sender: TObject);
    procedure ConfiguraesLocais1Click(Sender: TObject);
    procedure SB_PedidoClick(Sender: TObject);
    procedure NotasFiscaisConsumidor1Click(Sender: TObject);
    procedure Img_YoutubeClick(Sender: TObject);
    procedure SB_EncerrarClick(Sender: TObject);
    procedure Servico1Click(Sender: TObject);
    procedure NotasFiscaisdeServio1Click(Sender: TObject);
    procedure BaixarAtualizador1Click(Sender: TObject);
    procedure FechametoFinanceiro1Click(Sender: TObject);
    procedure ControleSequenciaNotas1Click(Sender: TObject);
    procedure MalaDiretaemail1Click(Sender: TObject);
    procedure Promoes1Click(Sender: TObject);
    procedure InventrioManual1Click(Sender: TObject);
    procedure PedidodeVendaLojaVirtual1Click(Sender: TObject);
    procedure LogOramento1Click(Sender: TObject);
    procedure Boto1Click(Sender: TObject);
    procedure Fechamento1Click(Sender: TObject);
    procedure ManifestodeFrete1Click(Sender: TObject);
    procedure Comanda1Click(Sender: TObject);
    procedure Consignao1Click(Sender: TObject);
    procedure EstoqueManual1Click(Sender: TObject);
    procedure AlteraesnoSistema1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SB_HelpClick(Sender: TObject);
    procedure AgendaSalo1Click(Sender: TObject);
    procedure ControleBasedeTroca1Click(Sender: TObject);
    procedure InventrioAutomtico1Click(Sender: TObject);
    procedure Equipamentos1Click(Sender: TObject);
    procedure ManutenoEletrnicos1Click(Sender: TObject);
    procedure AtendimetoPet1Click(Sender: TObject);
    procedure Pets1Click(Sender: TObject);
    procedure ListaTerminaisClick(Sender: TObject);
    procedure MenuOperMenuFiscalClick(Sender: TObject);
    procedure MenuFinMenuFiscalClick(Sender: TObject);
    procedure MenuBcoMenuFiscalClick(Sender: TObject);
    procedure MenuPslMenuFiscalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Retaguarda1Click(Sender: TObject);
    procedure Moveleiro1Click(Sender: TObject);
    procedure Contratos1Click(Sender: TObject);
    procedure ControleEstpqueZerado1Click(Sender: TObject);
    procedure RetaguardaWEB1Click(Sender: TObject);
    procedure Configuraes1Click(Sender: TObject);
    procedure WhatsApp1Click(Sender: TObject);
    procedure Grfica1Click(Sender: TObject);
    procedure ManuteoFrotaPrpria1Click(Sender: TObject);
    procedure MarketplaceMagazord1Click(Sender: TObject);
    procedure MnuAjdTrShaOperClick(Sender: TObject);
    procedure MnuArqContaBcoClick(Sender: TObject);
    procedure Sb_LancaBancoClick(Sender: TObject);
    procedure MnuTafLacBcoClick(Sender: TObject);
    procedure Configurao1Click(Sender: TObject);
    procedure AtualizarSchemas1Click(Sender: TObject);
    procedure vInutilizaodeNotas1Click(Sender: TObject);
    procedure OperaesNFe1Click(Sender: TObject);
    procedure ImpressoXML1Click(Sender: TObject);
    procedure ConsultaLotes1Click(Sender: TObject);
    procedure AutorizaLoteOFFLine1Click(Sender: TObject);
    procedure ReformaTributria1Click(Sender: TObject);


  private
    { Private declarations }
    TentativaSair : Integer;
    It_PedidoInternet : Boolean;
    It_PerguntaInternet : Boolean;

    //TrataExcecao : TTrata_Excecao;
    Retaguarda : TThreadRetaguarda;
    procedure OpeningPAFNFCE;
    procedure UnprepareAndCloseAll;
    procedure CloseGestaoDataSets;
    procedure CloseGestaoTransactions;
    procedure CloseDatabaseSafe;

    procedure OpenSeaProduct;
    function ValidaBaixarMarktplaceMagazord:Boolean;
    procedure BaixarMarktplaceMagazord;
    function AbrirMarketplaceMagazord:boolean;
    procedure OnMessageOwn(var Msg: TMsg; var Handled: Boolean);
    procedure finalizaProcessoAbertos;
    procedure AbreTelaBackupRestore;
    procedure AbreTelaAniversariantes;
    procedure ParaRetaguarda;
    procedure AtivaControleRetaguarda;
    procedure AtivaNotification;
    procedure OcultaNotification;

    procedure Pc_ProcesoAguarde(Pc_Tela:TForm;Pc_Tipo:String);
    function ValidateExistenciaClienteConsumidor:Boolean;
    function ValidaExistenciaVendedor:Boolean;
  public
    { Public declarations }
    It_CodMenu: Integer;
    It_Lc_Script: String;
    It_Data_Net: String;
    It_NomeEXE: String;
    IT_Data_Atual: String;
    FAguarde : TProcessoAguarde;
    TEF7 : TSetesTEF;
    function ValidaAberturaFrenteCaixa:Boolean;
    procedure OpenFrenteCaixa;
    function ValidaAberturaPizzaria:Boolean;
    procedure OpenPizzaria;
    procedure Pc_MenuOperacao;
    procedure Pc_MenuBanco;
    procedure Pc_MenuFinanceiro;
    procedure PC_MenuPessoal;

    function Fc_Valida_Autenticacao: Boolean;
    function SetAuthentication:Boolean;
    function  Fc_GeraEmailFalhaLogin: String;
    function SendEmailLoginFail:Boolean;

    procedure Pc_OcultaMenu;
    procedure Pc_AtivaMenu(Pc_Modulo:TMainMenu;Menu, Item:String; Visible : Boolean);
    procedure Pc_MontaMenu;
    procedure pc_MontaMenuAdm;
    procedure MenuTerminal;
    procedure pc_MontaToolBar(Pc_Nome: string; Pc_Liberado: string);

    procedure Pc_Resolucao;
    procedure Pc_Compromisso;
    procedure PC_ExportarWord;


    function pc_GeraEmailLogin : String;
    Procedure Pc_UpdateAtivaCliente;

    procedure OpenPAFNFC_e;
    function fc_Valida_Backup():boolean;

    function Fc_CarregaImagemBotao(Fc_Operacao: String): TBitmap;
    procedure CarregaImagemBotao(Sb:TSpeedButton;Fc_Operacao: String) ;

    procedure Pc_Renomeiarquivo;
    function Fc_ValidaVoltaVersao():Boolean;
    procedure Pc_TrocaEmbienteEmpresa;
    procedure Pc_AbreTelaPesqEmpresa(Pc_Tipo_Empresa:Integer);
    procedure Pc_AbrePedidoVenda;
    procedure Pc_AbrePedidoCompra;
    procedure AbrirTelaCaixa;

  end;


var
  Fr_Principal: TFr_Principal;
  function Fc_MultiEmpresa(): Boolean;


implementation

uses
  UN_TrocaSenha, UN_Sobre, sea_contacts, sea_job_position,  sea_Collaborator,
  sea_group,Un_Produtos,   sea_Service, UN_FormaPagto,setes_forms,
  sea_banking_account, Un_MinhaEmpresa,UN_Backup, sea_dead_line,
  UN_Pedido_Vda, sea_cfop, UN_Imp_Vendas,UN_Imp_CtasReceber, Un_Configuracao,
  Un_Nota_Fiscal, UN_Imp_CtasPagar, UN_Imp_Empresas,UN_Imp_Fluxo_Cxa,
  UN_Receber_Multipla,Un_Pagar_Multipla, Un_Caixa,Un_ContasCorrente,UN_Imp_Produtos,
  UN_Imp_Compras, Un_Fich_Fin_Cli, Un_Fich_Fin_For, UN_Imp_Caixa,UN_Imp_Duplicatas,
  UN_Imp_Banco, UN_Imp_ExtratoBancario, UN_Pedido_Cpa, Un_Cotacao,
  UN_Imp_CtrlCheques, UN_Pedido_Ajt, Un_Comissao,UN_Flh_Pagto, UN_Aniversariante,
  UN_Imp_Comissao, sea_vehicle_kind, sea_vehicle_brand, Un_Veiculo,
  UN_Imp_Servico, UN_Imp_Producao,UN_Imp_MapaCarga,Un_DM, UN_Imp_Lucratividade,
  UN_SPLASH, UN_MSG, Un_Crm, Un_Pesq_Produto, UN_Imp_CtasGerenciais,
  Un_Clta_Csto, UN_Imp_Colaborador, Un_Imp_MapaProducao,Un_Agenda, UN_Fone_Util,
  Un_Lanca_Folha, UN_Imp_Eventos, Un_Imp_EtiqProdutos,Un_Despacho, UN_Sintegra,
  UN_Imp_Ajuste,sea_taxation, Un_Maladireta, Un_MultiEmpresa, Un_Atualiza,
  Un_Buffets , UN_Imp_Notas, Un_Ajusta_Preco,sea_situation, Un_Fc_Sored_Procedures,
  sea_measure, sea_package, sea_product_brand, Un_Imp_Orcamento, sea_assistance,
  sea_interface,  un_receber_baixa_lote, Un_Pesq_NCM,
  Un_Conexao,Un_Funcoes,  Un_Pizzaria,Un_Ctrl_Lotes, sea_button_image, Un_envia_email,
  Un_RL_Financeiro_Comissao, Un_Licenca, Un_Criptografia,Un_VendaXFinanceiro,
  Un_Ctrl_Series, Un_FrenteCaixa,Un_Ctrl_Interface,Un_Info_Dec_Imp, Un_Transportadora,
  Un_Frete, Un_Ficha_Cadastral,Un_RL_Ficha_Cadastro, Un_Tabela_Preco, Un_Clta_Mov_Produtos,
  Un_Log_Operacao, UN_Fich_Colaborador,Un_SPEDPisCofins, Un_Bancos,reg_commitment,
  Un_ContasReceberBoleto, Un_Clta_Negocio, Un_Cardapio,
  Un_PizzariaItensMedida,DateUtils, RN_Permissao, Un_ImportaXMLNFe,
  un_conferente,Un_Rl_Etiq_Conferencia,Un_VehicleCheckList, Un_Receber_Descontada,
  sea_stocks,Un_Vei_OrdemServico,Un_Img_Site_Produto, Un_AreaTestes,sea_sales_origin,
  Un_Info_Origen_Sale,sea_customer_origin, Un_Contabilidade, Un_SPEDFiscal, RN_Produto,
  Un_CliResumo, Un_CopiaPedidoNota, sea_printers, RN_NotaFiscal,Un_Imp_Mod_Impressao,
  RN_NotaFiscalEletronica3x, Un_Fatura_Fin, UN_Fatura_Vda,
  Un_Virtual_Shop,Un_Pesq_Empresa, sea_line_business,
  Un_Configuracao_Local, Un_Pesq_NotaFiscal, RN_Compras,Un_Consumidor, Md5,
  RN_NotaFiscalServico, RN_NotaFiscalConsumidor,Un_RL_Report , RI_MovimentoFinanceiro,
  reg_plano_contas, Un_Excel, Un_Fecha_Financeiro, Un_Pesq_Ctrl_NF,ControllerPedido,
  Un_Fm_PizzariaMTP, Un_Especie_Doc, Un_TEF_ExibeMenu,Un_TEF_ObtemCampo, Un_Regra_Negocio,
  Un_Custo_Importacao,un_frx_ord_serv_detalhado, UN_Sistema, un_inventario_manual,
  sea_production,un_tray_to_gestao, sea_nf_product, un_imp_fechamento, Un_MalaDiretaEMail,
  sea_Mdfe, sea_promotion, sea_loja_tray_order, tributacao,
  Un_Itens_Produto_Vda, Un_Lanca_Command,sea_consignment, tblFollowup, un_estoque_manual,
  sea_pay_back, UnFunctions, ControllerBase, sea_schedule, PrintPizzaria,
  cad_product_variant,cad_pet_deadline, ControllerTerminal, ControllerPafCtrl,
  tas_processamento,ControllerRetaguarda,tas_retaguarda,sea_contract,
  frx_order_contract, RESTRequest4D,sea_receipt, ControllerAgenda,
  Un_Trata_Excecao, StackTrace, Un_Cliente,  Un_tr_send_email, Un_tr_send_email_login, tas_followup,sea_pre_paid_card,
  un_proj_log_changes, un_ctrl_base_troca,  un_inventario, sea_elect_equip,
  sea_order_elect_equip, sea_order_pet_shop, sea_pet, cad_pet_contact,
  tas_conecta_terminal, tas_menu_fiscal_paf,sea_product,  tas_retaguarda_web,
  sea_furniture_os, tas_contract_order, sea_ctrl_estoque_zerado,
  un_thread_load_general,   Un_CopiaBancoDados, api_route_projeto,
  un_frx_ctt_troca_brecho,  sea_whats_app_cfg, WhatsApp,  sea_order_print_shop,
  base_download,  sea_own_fleet_os, env, sea_users, sea_city,sea_uf ,sea_electronic_slip,
  UnGeraLog,tas_notification,reg_quotation_log, sea_profile, sea_oper_interface,
  sea_note, tas_gera_nfe_schemas, tas_gera_nfe_config, tas_gera_nfe_inutiliza,
  tas_gera_nfe_operacao, tas_gera_nfce_autorizacao_lote,
  tas_gera_nfce_operacao, sea_banking_history, sea_ctrl_cheque,
  sea_electronic_card, reg_order_log, sea_taxes;


Function GetWindowsVersion: string;
var
  VersionInfo: TOSVersionInfo;
begin
  // get size of the structure
  VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
  // populate the struct using api call
  GetVersionEx(VersionInfo);
  // platformid gets the core platform
  // major and minor versions also included.
  with VersionInfo do
  begin
    case dwPlatformid of
      1:begin
          case dwMinorVersion of
            0 : result := 'Windows 95';
            10: begin
                  if ( szCSDVersion[ 1 ] = 'A' ) then
                    Result :='Windows 98 SE'
                  else
                    Result := 'Windows 98';
                end;
            90 : result := 'Windows Millenium';
          else
            result := 'Unknown Version';
          end;
      end;
      2 : begin
            case dwMajorVersion of
              3 : result := 'Windows NT ' + IntToStr(dwMajorVersion) + '.' + IntToStr(dwMinorVersion);
              4 : result := 'Windows NT ' + IntToStr(dwMajorVersion) + '.' + IntToStr(dwMinorVersion);
              5 : begin
                    case dwMinorVersion of
                      0 : result := 'Windows 2000';
                      1 : result := 'Windows XP ou Whistler';
                    end;
                end;
            else
              result := 'Unknown Version';
            end;
        end;
      else
        result := 'Unknown Platform';
    end;

end;
end;

{$R *.dfm}


function TFr_Principal.Fc_CarregaImagemBotao(Fc_Operacao: String): TBitmap;
Var
  St_Image:TStream;
Begin
  Try
    DM.Qr_ImagenBotao.Active := False;
    DM.Qr_ImagenBotao.ParamByName('OPF_DESCRICAO').AsString :=  Fc_Operacao;
    DM.Qr_ImagenBotao.Active := True;
    DM.Qr_ImagenBotao.FetchAll;
    DM.Qr_ImagenBotao.First;
    St_Image := nil;
    St_Image := DM.Qr_ImagenBotao.CreateBlobStream(DM.Qr_ImagenBotao.FieldByName('OPF_IMAGEM'),bmRead);
    if St_Image.Size > 0 then
    begin
      Result := TBitmap.Create;
      Result.LoadFromStream(St_Image);
    end
    else
      Result := nil;
  finally
    FreeAndNil(St_Image);
    DM.Qr_ImagenBotao.Close;
  end;
end;


function TFr_Principal.fc_Valida_Backup():boolean;
Var
  Lc_I :Integer;
  Lc_Texto : String;
  ArquivoIni:TIniFile;
  LcIni :Integer;
begin
  Result := True;
  Lc_Texto := DM.IBD_Gestao.DatabaseName;

  LcIni := Pos(':\', Lc_Texto) -1;


  Lc_Texto := Copy(Lc_Texto,Lcini,(Length(Lc_Texto) - LcIni + 1));
  REsult := FileExists(Lc_Texto);


  if not Result then
  Begin
    TRy
      // Abre arquivo de configuracao e apaga as configurações do terminal
      ArquivoIni:=TIniFile.Create(GbPathExe+'CONFIG.INI');
      ArquivoIni.WriteString('BACKUP','ONLINE','N');
      ArquivoIni.WriteString('BACKUP','BACKUP','N');
      ArquivoIni.WriteString('BACKUP','SERVIDOR','');
      ArquivoIni.WriteString('BACKUP','USUARIO','');
      ArquivoIni.WriteString('BACKUP','SENHA','');
      ArquivoIni.WriteString('BACKUP','DIRETORIO','');
      ArquivoIni.WriteString('BACKUP','HORA_1','');
      ArquivoIni.WriteString('BACKUP','HORA_2','');
      ArquivoIni.WriteString('BACKUP','ARMAZENA','');
      ArquivoIni.WriteString('BACKUP','DATABASE','');
     finally
        FreeAndNil(ArquivoIni);
     end;
  end
end;

procedure TFr_Principal.PC_ExportarWord;
begin

end;

procedure TFr_Principal.pc_OcultaMenu;
var
  Lc_Menu : String;
  Lc_Item : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  try
    try
      MnuFin.Items.Items [1].Items[0].Visible := False;
      MnuBco.Items.Items [1].Items[1].Visible := False;
      MnuAnal.Items.Items[1].Items[0].Visible := False;
      MnuPsl.Items.Items [1].Items[1].Visible := False;
      MnuOper.Items.Items[1].Items[0].Visible := False;
      MnuBco.Items.Items [1].Items[0].Visible := False;
      MnuAnal.Items.Items[1].Items[1].Visible := False;
      MnuPsl.Items.Items [1].Items[0].Visible := False;
      MnuFin.Items.Items [1].Items[1].Visible := False;
      MnuOper.Items.Items[1].Items[1].Visible := False;
      MnuAnal.Items.Items[1].Items[2].Visible := False;
      MnuPsl.Items.Items [1].Items[3].Visible := False;
      MnuOper.Items.Items[1].Items[2].Enabled := False;
      MnuFin.Items.Items [1].Items[2].Enabled := False;
      MnuBco.Items.Items [1].Items[2].Enabled := False;
      MnuPsl.Items.Items [1].Items[2].Enabled := False;
      MnuOper.Items.Items[1].Items[3].Visible := False;
      MnuFin.Items.Items [1].Items[3].Visible := False;
      MnuBco.Items.Items [1].Items[3].Visible := False;
      MnuAnal.Items.Items[1].Items[3].Visible := False;
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add(concat(
                  'SELECT ',
                  '  IFC_CODIGO, ',
                  '  MNU_CODMOD, ',
                  '  MNU_DESCRICAO, ',
                  '  IFC_DESCRICAO ',
                  'FROM TB_INTERFACE IFC ',
                  '  INNER JOIN TB_MENUS MNU ',
                  '  ON (IFC.IFC_CODMNU = MNU.MNU_CODIGO) ',
                  'WHERE IFC_MENU = ''S'' ',
                  'ORDER BY IFC_CODIGO '
        ));
        Active := True;
        First;
        while not Eof do
        begin
          Lc_Menu := FieldByName('MNU_DESCRICAO').AsString;
          Lc_Item := FieldByName('IFC_DESCRICAO').AsString;
          //Se nao esta na permissão oculta o menu
          case (FieldByName('MNU_CODMOD').AsInteger) of
            1: Pc_AtivaMenu(MnuOper, Lc_Menu, Lc_Item, False );
            2: Pc_AtivaMenu(MnuFin, Lc_Menu, Lc_Item, False );
            3: Pc_AtivaMenu(MnuBco, Lc_Menu, Lc_Item, False );
            4: Pc_AtivaMenu(MnuAnal, Lc_Menu, Lc_Item, False );
            5: Pc_AtivaMenu(MnuPsl, Lc_Menu, Lc_Item, False );
          end; { 5 }
          Next;
        end;
      END;
    except
      Lc_Qry.Close;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  end;
end;

procedure TFr_Principal.Pc_ProcesoAguarde(Pc_Tela: TForm; Pc_Tipo: String);
Var
  Lc_Painel : Tpanel;
  Lc_Imagem : TImage;
  Lc_I,Lc_J : Integer;
  Lc_Tela:TForm;
  Lc_Achou : Boolean;
  LcRand : String;
Begin
  Lc_Achou := False;
  if (Pc_Tipo = 'I') then
  Begin
    LcRand := IntToStr(Random(10000));
    Lc_Painel := TPanel.Create(Pc_Tela);
    Lc_Painel.Name := concat('Pnl_ProceAguarde',LcRand) ;
    with Lc_Painel do
    Begin
      Visible := False;
      Parent := Pc_Tela;
      Caption := '';
      FullRepaint := True;
      ShowCaption := False;
      BorderWidth := 0;
      BevelInner := bvNone;
      BevelKind := bkNone;
      BevelOuter := bvNone;
      Height := 114;
      Width := 340;
      Top := -115;//trunc((Pc_Tela.Height - Lc_Painel.Height)/2);
      Left := trunc((Pc_Tela.Width - Lc_Painel.Width)/2);
    End;
    //Cria imagens
    Lc_Imagem := TImage.Create(Lc_Painel);
    Lc_Imagem.Name := concat('Img_ProceAguarde',LcRand) ;
    with Lc_Imagem do
    Begin
      Align := alClient;
      Parent := Lc_Painel;
      Transparent := True;
      Center := True;
      Top := 3;
      Left := 8;
      Picture := Fr_Principal.Img_Aguarde.Picture;
      AutoSize := True;
    End;
    Lc_Painel.Visible := True;
    for Lc_I := 1 to 12 do
    Begin
      Lc_Painel.Top := -118 + (Lc_I * 10) ;
      Lc_Painel.Update;
    end;
    Pc_Tela.BringToFront;
    (Lc_Imagem.Picture.Graphic as TGIFImage).Animate := True;
    Lc_Imagem.Update;
  end
  else
  begin
    for Lc_I := 0 to Pc_Tela.ComponentCount - 1 do
    begin
      //Limpa Painel
      if (Pc_Tela.Components[Lc_I].ClassType = TPanel) then
      begin
        if (Copy(TPanel(Pc_Tela.Components[Lc_I]).Name,1,16) = 'Pnl_ProceAguarde') then
        begin
          for Lc_J := 0 to TPanel(Pc_Tela.Components[Lc_I]).ComponentCount - 1 do
          Begin
            if (TPanel(Pc_Tela.Components[Lc_I]).Components[Lc_J].ClassType = TImage) then
            Begin
              TImage(TPanel(Pc_Tela.Components[Lc_I]).Components[Lc_J]).DisposeOf;
              TPanel(Pc_Tela.Components[Lc_I]).disposeOf;
              Lc_Achou := True;
              Break;
            End;
          End;
        end;
      end;
      if Lc_Achou then Break;
    end;
  end;
end;

procedure TFr_Principal.Pc_Compromisso;
Var
  Lc_Form: TRegCommitment;
  Lc_Agenda : TControllerAgenda;
Begin
  Lc_Agenda := TControllerAgenda.create(nil);
  Try
    Lc_Agenda.Parametros.FieldName.ToUsuario := Gb_cd_Usuario;
    Lc_Agenda.getByUser;
    if Lc_Agenda.exist then
    Begin
      MessageBeep(MB_ICONINFORMATION);
      Lc_form := TRegCommitment.create(Self);
      Try
        Lc_form.CodigoRegistro := Lc_Agenda.Registro.Codigo;
        Lc_form.ShowModal;
      Finally
        FreeAndNil(Lc_form);
      End;
    end;
  finally
    FreeAndNil(Lc_Agenda);
  end;
end;

procedure TFr_Principal.Pc_Resolucao;
begin
  Pnl_Login.Top  := Trunc( (Height - Pnl_Login.Height) / 2);
  Pnl_Login.Left := Trunc( (Width - Pnl_Login.Width) / 2);
  Lb_Title.Color := clNavy;
  Lb_Title.Font.Color := clWhite;

end;

procedure TFr_Principal.Pc_MenuOperacao;
begin
  caption := 'Gestão Empresarial - Módulo De operação - ' + GB_NM_Empresa;
  menu := MnuOper;
  hint := 'Módulo de operação';
end;

procedure TFr_Principal.Pc_MenuBanco;
begin
  caption := 'Gestão Empresarial - Módulo Bancário - ' + GB_NM_Empresa;
  menu := MnuBco;
  hint := 'Módulo Bancário';
end;

procedure TFr_Principal.Pc_MenuFinanceiro;
begin
  caption := 'Gestão Empresarial - Módulo Financeiro - ' + GB_NM_Empresa;
  menu := MnuFin;
  hint := 'Módulo Financeiro';

end;

procedure TFr_Principal.Pc_MenuPessoal;
begin
  caption := 'Gestão Empresarial - Módulo de Pessoal - ' + GB_NM_Empresa;
  menu := MnuPsl;
  hint := 'Módulo de Pessoal';

end;

procedure TFr_Principal.pc_MontaToolBar(Pc_Nome: string; Pc_Liberado: string);
begin
  if Pc_Nome = 'L' then
  begin
    Fr_Principal.SB_Clientes.Visible := False;
    Fr_Principal.SB_Fornecedor.Visible := False;
    Fr_Principal.SB_PedidoCpa.Visible := False;
    Fr_Principal.Sb_Produtos.Visible := False;
    Fr_Principal.Sb_Pesq_Produtos.Visible := False;
    Fr_Principal.Sb_Orcamento.Visible := False;
    Fr_Principal.SB_Pedido.Visible := False;
    Fr_Principal.Sb_Fi_Fin_Cli.Visible := False;
    Fr_Principal.Sb_Fi_Fin_For.Visible := False;
    Fr_Principal.Sb_Cta_Receber.Visible := False;
    Fr_Principal.Sb_Cta_Pagar.Visible := False;
    Fr_Principal.Sb_cheques.Visible := False;
    Fr_Principal.Sb_LancaBanco.Visible := False;
    Fr_Principal.Sb_Clta_Cst.Visible := False;
    Fr_Principal.Sb_MultiEmpresa.Visible := False;
    Fr_Principal.Sb_Agenda.Visible := False;
    Fr_Principal.Sb_Telefone.Visible := False;
    exit;
  end;
  //libera a Agenda para todos os usuarios
  Fr_Principal.Sb_Agenda.Visible := True;
  Fr_Principal.Sb_Telefone.Visible := True;
  if ((Pc_Nome = 'Clientes') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Clientes') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.SB_Clientes.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Fornecedores') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Fornecedores') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.SB_Fornecedor.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Pedido de Compra') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Pedido de Compra') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.SB_PedidoCpa.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Cadastro Produtos') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Cadastro Produtos') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Produtos.Visible := True;
    Fr_Principal.Sb_Pesq_Produtos.Visible := True;
    exit;
  end;

  if ((Pc_Nome = 'Orçamento') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Orçamento') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Orcamento.Visible := True;
    exit;
  end;

  if ((Pc_Nome = 'Pedido de Venda') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Pedido de Venda') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.SB_Pedido.Visible := True;
    Fr_Principal.Sb_Pesq_Produtos.Visible := True;
    exit;
  end;

  if ((Pc_Nome = 'Frente de Caixa - ECF') and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Pesq_Produtos.Visible := True;
    exit;
  end;


  if ((Pc_Nome = 'Pedido de Venda Remoto') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Pedido de Venda Remoto') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Pesq_Produtos.Visible := True;
    exit;
  end;

  if ((Pc_Nome = 'Consulta Conserto') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Consulta Conserto') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Clta_Cst.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Ficha Financeira Cliente') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Ficha Financeira Cliente') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Fi_Fin_Cli.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Ficha Financeira Fornecedor') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Ficha Financeira Fornecedor') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Fi_Fin_For.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Contas a Receber') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Contas a Receber') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Cta_Receber.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Contas a Pagar') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Contas a Pagar') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_Cta_Pagar.Visible := True;
    exit;
  end;
     
  if ((Pc_Nome = 'Controle de Cheques') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Controle de Cheques') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_cheques.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Lançamentos') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Lançamentos') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_LancaBanco.Visible := True;
    exit;
  end;
  if ((Pc_Nome = 'Lançamentos') and (Pc_Liberado = 'S')) or ((Pc_Nome = 'Lançamentos') and (Gb_Nivel = 1) and (Pc_Liberado = 'S')) then
  begin
    Fr_Principal.Sb_LancaBanco.Visible := True;
    exit;
  end;
end;

procedure TFr_Principal.Pc_AtivaMenu(Pc_Modulo:TMainMenu;Menu, Item:String; Visible : Boolean);
var
  Lc_Menu: Integer;
  Lc_Item: Integer;
  MenuItem : TMenuItem;
  ChildItem : TMenuItem;
Begin
  if (Pc_Modulo = nil) or (Pc_Modulo.Items = nil) then Exit;

  // Procura pelo caption do menu de topo (ex.: "Arquivo")
  MenuItem := Pc_Modulo.Items.Find(Menu);
  if not Assigned(MenuItem) then Exit;

  // Procura pelo caption do item filho (ex.: "Abrir")
  ChildItem := MenuItem.Find(item);
  if Assigned(ChildItem) then
    ChildItem.Visible := visible;
end;


procedure TFr_Principal.pc_MontaMenuAdm;
var
  Lc_Menu: String;
  Lc_Item: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Progresso :TGauge;
  Lc_MontaMenu : TThread;
Begin
  Lc_MontaMenu := TThread.CreateAnonymousThread(
  procedure
  begin
    try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      MnuFin.Items.Items[1].Items[0].Visible := True;
      MnuFin.Items.Items[1].Items[1].Visible := True;
      MnuFin.Items.Items[1].Items[2].Enabled := True;
      MnuFin.Items.Items[1].Items[3].Visible := True;

      MnuBco.Items.Items[1].Items[1].Visible := True;
      MnuBco.Items.Items[1].Items[0].Visible := True;
      MnuBco.Items.Items[1].Items[2].Enabled := True;
      MnuBco.Items.Items[1].Items[3].Visible := True;

      MnuAnal.Items.Items[1].Items[0].Visible := True;
      MnuAnal.Items.Items[1].Items[1].Visible := True;
      MnuAnal.Items.Items[1].Items[2].Visible := True;
      MnuAnal.Items.Items[1].Items[3].Visible := True;

      MnuOper.Items.Items[1].Items[0].Visible := True;
      MnuOper.Items.Items[1].Items[1].Visible := True;
      MnuOper.Items.Items[1].Items[2].Enabled := True;
      MnuOper.Items.Items[1].Items[3].Visible := True;

      MnuPsl.Items.Items[1].Items[0].Visible := True;
      MnuPsl.Items.Items[1].Items[1].Visible := True;
      MnuPsl.Items.Items[1].Items[2].Enabled := True;
      MnuPsl.Items.Items[1].Items[3].Visible := True;

      MenuOperMenuFiscal.Visible  := Gb_PAF_NFE_E;
      MenuFinMenuFiscal.Visible   := Gb_PAF_NFE_E;
      MenuBcoMenuFiscal.Visible   := Gb_PAF_NFE_E;
      MenuPslMenuFiscal.Visible   := Gb_PAF_NFE_E;

      with Lc_Qry do
      Begin
        SQL.Add(concat(
                  'SELECT ',
                  '  IFC_CODIGO, ',
                  '  MNU_CODMOD, ',
                  '  MNU_DESCRICAO, ',
                  '  IFC_DESCRICAO, ',
                  '  IFC_SISTEMA ',
                  'FROM TB_INTERFACE IFC ',
                  '  INNER JOIN TB_MENUS MNU ',
                  '  ON (IFC.IFC_CODMNU = MNU.MNU_CODIGO) ',
                  'WHERE IFC_MENU = ''S'' ',
                  '  AND IFC_SISTEMA = ''S'' ',
                  'ORDER BY IFC_CODIGO '
        ));
        Active := True;
        FetchAll;
        First;
        Lc_Progresso := Pc_BarraProgresso('S',Fr_Principal,Pnl_ToolBar,RecordCount,'Montando Menu');
        while not Eof do
        begin
          Pc_MontaToolBar(FieldByName('IFC_DESCRICAO').AsString, FieldByName('IFC_SISTEMA').AsString);
          //Se nao esta na permissão oculta o menu
          Lc_Menu := FieldByName('MNU_DESCRICAO').AsString;
          Lc_Item := FieldByName('IFC_DESCRICAO').AsString;
          case (FieldByName('MNU_CODMOD').AsInteger) of
            1:Pc_AtivaMenu(MnuOper, Lc_Menu, Lc_Item, True );
            2:Pc_AtivaMenu(MnuFin, Lc_Menu, Lc_Item, True );
            3:Pc_AtivaMenu(MnuBco, Lc_Menu, Lc_Item, True );
            4:Pc_AtivaMenu(MnuAnal, Lc_Menu, Lc_Item, True );
            5:Pc_AtivaMenu(MnuPsl, Lc_Menu, Lc_Item, True );
          end;
          Next;
          TThread.Synchronize(Lc_MontaMenu,
          procedure
          begin
            Lc_Progresso.Progress := Lc_Progresso.Progress + 1;
          end);
        end;
      End;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil( LcBase );
      Lc_Progresso.Visible := False;
      FreeAndNil(Lc_Progresso);
      Lc_MontaMenu.Terminate;
    end;
  end);
  Lc_MontaMenu.FreeOnTerminate := True;
  Lc_MontaMenu.Start;
end;

procedure TFr_Principal.Pc_MontaMenu;
var
  Lc_Menu: String;
  Lc_Item: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Progresso :TGauge;
  Lc_MontaMenu : TThread;
Begin
  Lc_MontaMenu := TThread.CreateAnonymousThread(
  procedure
  begin
    try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        sql.Add(concat(
                  'SELECT DISTINCT ',
                  '  MNU_CODMOD, ',
                  '  MNU_DESCRICAO, ',
                  '  IFC_DESCRICAO, ',
                  '  IFC_SISTEMA, ',
                  '  IFC_FR_NAME ',
                  'FROM TB_PERMISSAO PER ',
                  '  INNER JOIN TB_ITENS_IFC IIF ',
                  '  ON (IIF.IIF_CODIGO = PER.PER_CODIIF) ',
                  '  INNER JOIN TB_INTERFACE IFC ',
                  '  ON (IFC.IFC_CODIGO = IIF.IIF_CODIFC) ',
                  '  INNER JOIN TB_MENUS MNU ',
                  '  ON (MNU.MNU_CODIGO = IFC.IFC_CODMNU) ',
                  '  INNER JOIN TB_OPER_INTERFACE OPF ',
                  '  ON (OPF.OPF_CODIGO = IIF.IIF_CODOPF) ',
                  'WHERE (PER.PER_CODUSU=:PER_CODUSU) ',
                  '  AND (OPF.OPF_DESCRICAO=:OPF_DESCRICAO) ',
                  '  AND IFC_SISTEMA = ''S'' AND IFC_MENU = ''S'' '
        ));
        Active := False;
        ParamByName('PER_CODUSU').AsInteger := Gb_Cd_Usuario;
        ParamByName('OPF_DESCRICAO').AsString := 'VISUALIZAR';
        Active := true;
        FetchAll;
        Lc_Progresso := Pc_BarraProgresso('S',Fr_Principal,Fr_Principal.Pnl_ToolBar, RecordCount,'Montando Menu');
        First;
        while not Eof do
        begin
          if ( FieldByName('MNU_DESCRICAO').AsString = 'Arquivo' ) or
             ( FieldByName('MNU_DESCRICAO').AsString = 'Tarefas' ) then
            pc_MontaToolBar(FieldByName('IFC_DESCRICAO').AsString, FieldByName('IFC_SISTEMA').AsString);
          Lc_Menu := FieldByName('MNU_DESCRICAO').AsString;
          Lc_Item := FieldByName('IFC_DESCRICAO').AsString;
          case (FieldByName('MNU_CODMOD').AsInteger) of
          1:
            begin
              MnuFin.Items.Items[1].Items[0].Visible := True;
              MnuBco.Items.Items[1].Items[1].Visible := True;
              MnuAnal.Items.Items[1].Items[0].Visible := True;
              MnuPsl.Items.Items[1].Items[1].Visible := True;
              Pc_AtivaMenu(MnuOper, Lc_Menu, Lc_Item, True );
            end;
          2:
            begin
              MnuOper.Items.Items[1].Items[0].Visible := True;
              MnuBco.Items.Items[1].Items[0].Visible := True;
              MnuAnal.Items.Items[1].Items[1].Visible := True;
              MnuPsl.Items.Items[1].Items[0].Visible := True;
              Pc_AtivaMenu(MnuFin, Lc_Menu, Lc_Item, True );
            end;
          3:
            begin
              MnuFin.Items.Items[1].Items[1].Visible := True;
              MnuOper.Items.Items[1].Items[1].Visible := True;
              MnuAnal.Items.Items[1].Items[2].Visible := True;
              MnuPsl.Items.Items[1].Items[3].Visible := True;
              Pc_AtivaMenu(MnuBco, Lc_Menu, Lc_Item, True );
            end;
          5:
            begin
              MnuOper.Items.Items[1].Items[3].Visible := True;
              MnuFin.Items.Items[1].Items[3].Visible := True;
              MnuBco.Items.Items[1].Items[3].Visible := True;
              MnuAnal.Items.Items[1].Items[3].Visible := True;
              Pc_AtivaMenu(MnuPsl, Lc_Menu, Lc_Item, True );
            end;
          end;
          Next;
          TThread.Synchronize(Lc_MontaMenu,
          procedure
          begin
            Lc_Progresso.Progress := Lc_Progresso.Progress + 1;
          end);

        end;
      end;
    finally
      Lc_Progresso.Visible := False;
      FreeAndNil(Lc_Progresso);
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
      Lc_MontaMenu.Terminate;
    end;
  end);
  Lc_MontaMenu.FreeOnTerminate := True;
  Lc_MontaMenu.Start;
end;

procedure TFr_Principal.AppEventsHint(Sender: TObject);
begin
  SB_Status.Panels[9].Text := Application.Hint;
end;

procedure TFr_Principal.Tm_StatusTimer(Sender: TObject);
begin
  SB_Status.Panels[0].Text := TimeToStr(time);
end;

procedure TFr_Principal.UnprepareAndCloseAll;
  procedure SafeCloseDS(DS: TDataSet);
  begin
    try
      if DS.Active then
      begin
        if (DS.State in [dsEdit, dsInsert]) then
          try DS.Post except DS.Cancel; end;
        DS.Close;
      end;
    except
      // nao propagar erro nessa fase
    end;
  end;

  function IsGestaoDatabase(C: TComponent): Boolean;
  begin
    Result := False;

    if C is TSTQuery then
      Result := TSTQuery(C).Database = DM.IBD_Gestao
    else if C is TSTStoredProc then
      Result := TSTStoredProc(C).Database = DM.IBD_Gestao;
  end;

  procedure SafeUnprepare(C: TComponent);
  begin
    try
      if C is TSTQuery then
      begin
        if TSTQuery(C).Prepared then
          TSTQuery(C).UnPrepare;
      end
      else if C is TSTStoredProc then
      begin
        if TSTStoredProc(C).Prepared then
          TSTStoredProc(C).UnPrepare;
      end;
    except
      // silencioso
    end;
  end;

var i: Integer; C: TComponent;
begin
  // percorre os componentes TST do mesmo owner do DB (ou do DataModule)
  if Assigned(DM.IBD_Gestao.Owner) then
    for i := 0 to DM.IBD_Gestao.Owner.ComponentCount-1 do
    begin
      C := DM.IBD_Gestao.Owner.Components[i];

      if not IsGestaoDatabase(C) then
        Continue;

      // datasets TST ligados a este DB/transacao
      if C is TDataSet then
        SafeCloseDS(TDataSet(C));

      // statements preparados da camada TST
      SafeUnprepare(C);
    end;
end;

procedure TFr_Principal.CloseGestaoDataSets;
  function ComponentDB(C: TComponent): TObject;
  begin
    Result := nil;

    if GetPropInfo(C.ClassInfo, 'Database') <> nil then
      Result := TObject(GetObjectProp(C, 'Database'))
    else if GetPropInfo(C.ClassInfo, 'Connection') <> nil then
      Result := TObject(GetObjectProp(C, 'Connection'));
  end;

  procedure SafeCloseDataSet(DS: TDataSet);
  begin
    try
      if DS.Active then
      begin
        if DS.State in [dsEdit, dsInsert] then
          try DS.Post except DS.Cancel; end;
        DS.Close;
      end;
    except
      // silencioso no shutdown
    end;
  end;

  procedure CloseOwnerDataSets(AOwner: TComponent);
  var
    I: Integer;
    C: TComponent;
  begin
    if not Assigned(AOwner) then
      Exit;

    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      C := AOwner.Components[I];
      if (C is TDataSet) and (ComponentDB(C) = DM.IBD_Gestao) then
        SafeCloseDataSet(TDataSet(C));
    end;
  end;

var
  I: Integer;
begin
  CloseOwnerDataSets(DM.IBD_Gestao.Owner);
  CloseOwnerDataSets(Application);

  for I := 0 to Screen.FormCount - 1 do
    CloseOwnerDataSets(Screen.Forms[I]);

  for I := 0 to Screen.DataModuleCount - 1 do
    CloseOwnerDataSets(Screen.DataModules[I]);
end;
procedure TFr_Principal.CloseGestaoTransactions;
  function TransactionDB(T: TSTTransaction): TObject;
  begin
    Result := nil;

    if GetPropInfo(T.ClassInfo, 'DefaultDatabase') <> nil then
      Result := TObject(GetObjectProp(T, 'DefaultDatabase'))
    else if GetPropInfo(T.ClassInfo, 'Database') <> nil then
      Result := TObject(GetObjectProp(T, 'Database'))
    else if GetPropInfo(T.ClassInfo, 'Connection') <> nil then
      Result := TObject(GetObjectProp(T, 'Connection'));
  end;

  function TransactionActive(T: TSTTransaction): Boolean;
  begin
    Result := False;

    if GetPropInfo(T.ClassInfo, 'InTransaction') <> nil then
      Result := GetOrdProp(T, 'InTransaction') <> 0
    else if GetPropInfo(T.ClassInfo, 'Active') <> nil then
      Result := GetOrdProp(T, 'Active') <> 0;
  end;

  function IsGestaoTransaction(T: TSTTransaction): Boolean;
  begin
    Result := Assigned(T) and (TransactionDB(T) = DM.IBD_Gestao);
  end;

  procedure SafeFinishTransaction(T: TSTTransaction);
  begin
    if not IsGestaoTransaction(T) then
      Exit;

    try
      if TransactionActive(T) then
        T.Commit;
    except
      try
        if TransactionActive(T) then
          T.Rollback;
      except
        // nada a fazer no shutdown
      end;
    end;
  end;

  procedure CloseOwnerTransactions(AOwner: TComponent);
  var
    I: Integer;
    C: TComponent;
  begin
    if not Assigned(AOwner) then
      Exit;

    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      C := AOwner.Components[I];
      if C is TSTTransaction then
        SafeFinishTransaction(TSTTransaction(C));
    end;
  end;

var
  I: Integer;
begin
  CloseOwnerTransactions(DM.IBD_Gestao.Owner);
  CloseOwnerTransactions(Application);

  for I := 0 to Screen.FormCount - 1 do
    CloseOwnerTransactions(Screen.Forms[I]);

  for I := 0 to Screen.DataModuleCount - 1 do
    CloseOwnerTransactions(Screen.DataModules[I]);
end;
procedure TFr_Principal.MnuArqFornOperClick(Sender: TObject);
begin
  Pc_AbreTelaPesqEmpresa(2);
end;

procedure TFr_Principal.MnuArqTranspOperClick(Sender: TObject);
begin
  Pc_AbreTelaPesqEmpresa(3);
end;

procedure TFr_Principal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Var
  LcForm : TFr_Backup;
begin
  if (TentativaSair = 0 ) then
  Begin
    case Application.MessageBox('Finalizar o Sistema!', 'Atenção', MB_YESNO or MB_APPLMODAL or MB_ICONINFORMATION) of
      mrYes:
        begin
          inc(TentativaSair);
          if ( Fc_Aq_Geral('L','BACKUP','BACKUP','S') = 'S' ) then
          begin
            if fc_Valida_Backup then
              AbreTelaBackupRestore;
          end;
          finalizaProcessoAbertos;
          CanClose := True;
          Application.Terminate;

        end;
      mrNo: CanClose := False;
    end;
  end
  else
  Begin
    CanClose := True;
    inc(TentativaSair);
    if True then
    if (TentativaSair = 1 ) then
    begin
      finalizaProcessoAbertos;
      Halt;
    end
    else
      winexec('taskkill /f /im Gestao.exe' ,sw_hide);
  end;
end;

procedure TFr_Principal.FormCreate(Sender: TObject);
begin
  TentativaSair := 0;
  Application.OnMessage := OnMessageOwn;
end;

procedure TFr_Principal.MnuAjdManuUsuOperClick(Sender: TObject);
begin
  TSetesForms.Show(TSeaUsers)
end;

procedure TFr_Principal.MnuAjdSobreOperClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Sobre);
end;

procedure TFr_Principal.MnuAjdTrShaOperClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_TrocaSenha);
end;

procedure TFr_Principal.Contatos1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaContacts);
end;

procedure TFr_Principal.MenuItem2Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaCollaborator);
end;

procedure TFr_Principal.Cargos1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaJobPosition);
end;

procedure TFr_Principal.CarregaImagemBotao(Sb: TSpeedButton;
  Fc_Operacao: String);
Var
  St_Image:TStream;
  St_BMP :TBitmap;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(Concat(
                'SELECT OPF_IMAGEM ',
                'FROM TB_OPER_INTERFACE ',
                'WHERE OPF_DESCRICAO =:OPF_DESCRICAO '
      ));
      ParamByName('OPF_DESCRICAO').AsString :=  Fc_Operacao;
      Active := True;
      FetchAll;
      First;
      if recordCount > 0 then
      Begin
        St_Image := CreateBlobStream(FieldByName('OPF_IMAGEM'),bmRead);
        if St_Image.Size > 0 then
        begin
          St_BMP := TBitmap.Create;
          St_BMP.LoadFromStream(St_Image);
          Sb.Glyph.Assign(St_BMP);
          FreeAndNil(St_BMP);
        end;
        FreeAndNil(St_Image);
      End;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  end;
end;

procedure TFr_Principal.Pessoal1Click(Sender: TObject);
begin
  PC_MenuPessoal;
end;

procedure TFr_Principal.MnuArqGpPdOperClick(Sender: TObject);
begin
  TSetesForms.Show(TSeaGroup);
  DM.Qr_Grupo.Active := False;
  DM.Qr_SubGrupo.Active := False;
  DM.Qr_Grupo.Active := True;
  DM.Qr_SubGrupo.Active := True;
end;

procedure TFr_Principal.MnuArqCadProdOperClick(Sender: TObject);
begin
  OpenSeaProduct;
end;

procedure TFr_Principal.Observao1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaNote);
end;

procedure TFr_Principal.OnMessageOwn(var Msg: TMsg; var Handled: Boolean);
var
  KeyState: TKeyboardState;
begin
  GetKeyboardState(KeyState);
  if KeyState[VK_NUMLOCK] = 0 then
    sb_status.Panels[5].Text:= ''
  else
    sb_status.Panels[5].Text:= 'NUM';
  if KeyState[VK_CAPITAL] = 0 then
    sb_status.Panels[6].Text:= ''
  else
    sb_status.Panels[6].Text:= 'CAPS';

  if KeyState[VK_INSERT] = 0 then
    sb_status.Panels[7].Text:= ''
  else
    sb_status.Panels[7].Text:= 'INS';
end;


procedure TFr_Principal.OpenFrenteCaixa;
begin
  self.Enabled := False;
  if not Assigned(Fr_FrenteCaixa) then (Application.CreateForm(TFr_FrenteCaixa, Fr_FrenteCaixa));
  Fr_FrenteCaixa.It_TP_Operacao := 'PDV';
  try
    Fr_FrenteCaixa.showModal;
  finally
    if Assigned(Fr_FrenteCaixa) then Fr_FrenteCaixa := nil;
    Self.Enabled := True;
  end;
end;

procedure TFr_Principal.OpeningPAFNFCE;
Var
  PafCtrl : TControllerPafCtrl;
begin
  try
    PafCtrl := TControllerPafCtrl.Create(nil);
    PafCtrl.Registro.DataMovimento := Date;
    PafCtrl.getbyId;
    if (not PafCtrl.exist ) then
    Begin
      PafCtrl.Registro.DataMovimento    := Date;
      PafCtrl.Registro.TempoAbertura    := Now;
      PafCtrl.Registro.UsuarioAbertura  := GB_Cd_Usuario;
      PafCtrl.Registro.Situacao         := 'A';
      PafCtrl.Registro.HaMovimentacao   := 'N';
      PafCtrl.insert;
    end;
  finally
    FreeAndNil(PafCtrl);
  end;

end;

procedure TFr_Principal.OpenPAFNFC_e;
begin
  TSetesForms.Show(TTasMenuFiscalPaf);
end;

procedure TFr_Principal.OpenPizzaria;
Var
  Lc_Form : TFr_Pizzaria;
begin
  try
    self.Enabled := False;
    Lc_Form := TFr_Pizzaria.Create(Fr_Principal);
    Lc_Form.ShowModal;
  finally
    Self.Enabled := True;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Principal.OpenSeaProduct;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    TSetesForms.Show(TSeaProduct);
  end;
end;

procedure TFr_Principal.OperaesNFe1Click(Sender: TObject);
begin
  TSetesForms.Show(TTasGeraNfeOperacao);
end;

procedure TFr_Principal.MnuArqCadSrvOperClick(Sender: TObject);
begin
  TSetesForms.Show(TSeaService);
end;

procedure TFr_Principal.MnuArqContaBcoClick(Sender: TObject);
begin
  TSetesForms.Show(TSeaBankingAccount);
end;

procedure TFr_Principal.MnuArqPlCtaFinClick(Sender: TObject);
begin
  TSetesForms.Show(TRegPlanoContas);
end;

procedure TFr_Principal.MnuArqFPagtoFinClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_FormaPagto);
end;

procedure TFr_Principal.MnuModFinOperClick(Sender: TObject);
begin
  Pc_MenuFinanceiro;
end;

procedure TFr_Principal.MnuModOpeFinClick(Sender: TObject);
begin
  Pc_MenuOperacao;
end;

procedure TFr_Principal.MnuModOperBcoClick(Sender: TObject);
begin
  Pc_MenuOperacao;
end;

procedure TFr_Principal.MnuModOperAnalClick(Sender: TObject);
begin
  Pc_MenuOperacao;
end;

procedure TFr_Principal.MenuItem12Click(Sender: TObject);
begin
  Pc_MenuOperacao;
end;

procedure TFr_Principal.MnuModFinBcoClick(Sender: TObject);
begin
  Pc_MenuFinanceiro;
end;

procedure TFr_Principal.MnuModFinAnalClick(Sender: TObject);
begin
  Pc_MenuFinanceiro;
end;

procedure TFr_Principal.MenuOperMenuFiscalClick(Sender: TObject);
begin
  OpenPAFNFC_e;
end;

procedure TFr_Principal.MenuFinMenuFiscalClick(Sender: TObject);
begin
  OpenPAFNFC_e;
end;

procedure TFr_Principal.MenuBcoMenuFiscalClick(Sender: TObject);
begin
  OpenPAFNFC_e
end;

procedure TFr_Principal.MenuPslMenuFiscalClick(Sender: TObject);
begin
  OpenPAFNFC_e;
end;

procedure TFr_Principal.MenuItem11Click(Sender: TObject);
begin
  Pc_MenuFinanceiro;
end;

procedure TFr_Principal.MnuModBancoOperClick(Sender: TObject);
begin
  Pc_MenuBanco;
end;

procedure TFr_Principal.MnuModBanFinClick(Sender: TObject);
begin
  Pc_MenuBanco;
end;

procedure TFr_Principal.MnuModBcoAnalClick(Sender: TObject);
begin
  Pc_MenuBanco;
end;

procedure TFr_Principal.Bancrio1Click(Sender: TObject);
begin
  Pc_MenuBanco;
end;

procedure TFr_Principal.Pessoal2Click(Sender: TObject);
begin
  PC_MenuPessoal;
end;

procedure TFr_Principal.Pessoal3Click(Sender: TObject);
begin
  PC_MenuPessoal;
end;

procedure TFr_Principal.Pessoal4Click(Sender: TObject);
begin
  PC_MenuPessoal;
end;

procedure TFr_Principal.Pets1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaPet);
end;

procedure TFr_Principal.MnuArqBancoBcoClick(Sender: TObject);
begin
  Pc_AbreTelaPesqEmpresa(4);
end;

procedure TFr_Principal.MnuMhaEmpOperClick(Sender: TObject);
begin
  Pc_AbreTelaPesqEmpresa(0);
end;

procedure TFr_Principal.MnuArqHistBcoClick(Sender: TObject);
begin
  TSetesForms.Show(TSEaBankingHistory);
end;

procedure TFr_Principal.MnuAjdManuBkpOperClick(Sender: TObject);
begin
  if fc_Valida_Backup then
    AbreTelaBackupRestore;
end;

procedure TFr_Principal.Prazos1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaDeadLine);
end;

procedure TFr_Principal.MnuTafOVSOperClick(Sender: TObject);
begin
  Pc_AbrePedidoVenda;
end;

procedure TFr_Principal.NaturezaCFOP1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaCFOP);
end;

procedure TFr_Principal.MnuRelVdaOperClick(Sender: TObject);
begin
  //Precisa verificar que este formulario esá referenciado dentro de alguns relatorios, será necessarios criar uma independencia
  if not assigned(Fr_Imp_Vendas) then
    Application.CreateForm(TFr_Imp_Vendas, Fr_Imp_Vendas);
  Fr_Imp_Vendas.ShowModal;
end;

procedure TFr_Principal.MnuRelCtaRbrFinClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_CtasReceber) then
    Application.CreateForm(TFr_Imp_CtasReceber, Fr_Imp_CtasReceber);
  Fr_Imp_CtasReceber.ShowModal;
end;

procedure TFr_Principal.MnuRelCtaPgrFinClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_CtasPagar) then
    Application.CreateForm(TFr_Imp_CtasPagar, Fr_Imp_CtasPagar);
  Fr_Imp_CtasPagar.ShowModal;
end;

procedure TFr_Principal.MnuRelClienteOperClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_Empresa) then
    Application.CreateForm(TFr_Imp_Empresa, Fr_Imp_Empresa);
  Fr_Imp_Empresa.ShowModal;
end;

procedure TFr_Principal.FluxodeCaixa1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Imp_fluxo_Cxa);
end;

procedure TFr_Principal.MnuTafManuDupFinClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Receber_multipla);
end;

procedure TFr_Principal.MnuTafManuPagFinClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Pagar_multipla);
end;

procedure TFr_Principal.AbreTelaAniversariantes;
begin
  TSetesForms.Show(Tfr_Aniversariantes);
end;

procedure TFr_Principal.AbreTelaBackupRestore;
begin
  TSetesForms.Show(TFr_Backup);
end;

function TFr_Principal.AbrirMarketplaceMagazord: boolean;
var
  Lc_Arq_Ini: TIniFile;
begin
  try
    Result := False;
    Lc_Arq_Ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'autentica.txt');
    Lc_Arq_Ini.WriteString('GESTAO', 'CODMHA',Fc_Base64Encode(IntToStr(Gb_CodMha)));
    Lc_Arq_Ini.WriteString('GESTAO', 'USUARIO',Fc_Base64Encode(IntToStr(GB_Cd_Usuario)));
    Lc_Arq_Ini.WriteString('GESTAO', 'VENDEDOR',Fc_Base64Encode(IntToStr(GB_Cd_Vendedor)));
    Lc_Arq_Ini.WriteString('GESTAO', 'ESTOQUE',Fc_Base64Encode(IntToStr(Gb_Estoque)));
  Finally
    FreeAndNil(Lc_Arq_Ini);
    Result := True;
    WinExec(pAnsichar('Magazord.exe'),SW_NORMAL);
  End;
end;

procedure TFr_Principal.AbrirTelaCaixa;
begin
  TSetesForms.Show(TFr_Caixa);
end;

procedure TFr_Principal.MnuTafLacBcoClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_ContasCorrente);
end;

procedure TFr_Principal.MnuTafLanCxaFinClick(Sender: TObject);
begin
  AbrirTelaCaixa;
end;

procedure TFr_Principal.MnuRelProdOperClick(Sender: TObject);
begin
  //Precisa verificar que este formulario esá referenciado dentro de alguns relatorios, será necessarios criar uma independencia
  if not assigned(Fr_Imp_Produtos) then
    Application.CreateForm(TFr_Imp_Produtos, Fr_Imp_Produtos);
  Fr_Imp_Produtos.ShowModal;
end;

procedure TFr_Principal.MnuRelCpaOperClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_Compras) then
    Application.CreateForm(TFr_Imp_Compras, Fr_Imp_Compras);
  Fr_Imp_Compras.ShowModal;
end;

procedure TFr_Principal.FichaFinCliente1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Fich_Fin_Cli);
end;

procedure TFr_Principal.finalizaProcessoAbertos;
begin
  Try
    Tm_Agenda.enabled := False;
    Tm_Status.enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Application.OnMessage := nil;

    AguardaEmailThreads(5000);

    ParaRetaguarda;

    CloseDatabaseSafe;

  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Principal.Fechamento1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Imp_Fechamento);
end;

procedure TFr_Principal.FechametoFinanceiro1Click(Sender: TObject);
begin
  TSetesForms.Show(TFR_Fecha_Financeiro);
end;

procedure TFr_Principal.FichaFinanceiraFornecedor1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Fich_Fin_For);
end;

procedure TFr_Principal.MnuRelLanCxaFinClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_Caixa) then
    Application.CreateForm(TFr_Imp_Caixa, Fr_Imp_Caixa);
  Fr_Imp_Caixa.ShowModal;
end;

procedure TFr_Principal.Duplicatas1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Duplicatas) then
    Application.CreateForm(TFr_Imp_Duplicatas, Fr_Imp_Duplicatas);
  Fr_Imp_Duplicatas.ShowModal;
end;

procedure TFr_Principal.MnuRelLancBcoClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_Banco) then
    Application.CreateForm(TFr_Imp_Banco, Fr_Imp_Banco);
  Fr_Imp_Banco.ShowModal;
end;

procedure TFr_Principal.MnuRelExtratoClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_ExtratoBancario) then
    Application.CreateForm(TFr_Imp_ExtratoBancario, Fr_Imp_ExtratoBancario);
  Fr_Imp_ExtratoBancario.ShowModal;
end;

procedure TFr_Principal.MnuTafCtrlChqFinClick(Sender: TObject);
begin
  TSetesForms.Show(TSeaCtrlCheque);
end;

procedure TFr_Principal.MnuTafCpaOperClick(Sender: TObject);
begin
  Pc_AbrePedidoCompra;
end;

procedure TFr_Principal.MnuTafTrfOperClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Cotacao);

end;

procedure TFr_Principal.MnuRelCtrlChqFinClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_CtrlCheques) then
    Application.CreateForm(TFr_Imp_CtrlCheques, Fr_Imp_CtrlCheques);
  Fr_Imp_CtrlCheques.ShowModal;
end;

procedure TFr_Principal.NotasFiscaisdeServio1Click(Sender: TObject);
begin
  Pc_AbreTelaPesqNF_Srv;
end;

procedure TFr_Principal.MnuTafAjtEstOperClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Pedido_Ajt);
end;

procedure TFr_Principal.MalaDiretaemail1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_MalaDiretaEMail);
end;

procedure TFr_Principal.ManifestodeFrete1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaMdfe);
end;

procedure TFr_Principal.ManutenoComisses1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Comissao);
end;

procedure TFr_Principal.ManutenoEletrnicos1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaOrderElectEquip);
end;

procedure TFr_Principal.MenuItem15Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Flh_pagto);
end;

procedure TFr_Principal.Aniversariantes1Click(Sender: TObject);
Begin
  AbreTelaAniversariantes;
end;

procedure TFr_Principal.MenuItem20Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Comissao) then
    Application.CreateForm(TFr_Imp_Comissao, Fr_Imp_Comissao);
  Fr_Imp_Comissao.ShowModal;
end;

procedure TFr_Principal.SB_ClientesClick(Sender: TObject);
begin
  if not Fc_VerificaFormularioDisponivel('Fr_CliResumo') then
  Begin
    Pc_AbreTelaPesqEmpresa(1);
  end
  else
  Begin
    TSetesForms.Show(TFr_CliResumo);
  end;
end;

procedure TFr_Principal.SB_FornecedorClick(Sender: TObject);
begin
  Pc_AbreTelaPesqEmpresa(2);
end;

procedure TFr_Principal.SB_HelpClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Sobre);
end;

procedure TFr_Principal.Sb_LancaBancoClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_ContasCorrente);
end;

procedure TFr_Principal.SB_PedidoCpaClick(Sender: TObject);
begin
  Pc_AbrePedidoCompra;
end;

procedure TFr_Principal.Sb_ProdutosClick(Sender: TObject);
Begin
  OpenSeaProduct;
end;

procedure TFr_Principal.Pc_AbrePedidoCompra;
begin
  TSetesForms.Show(TFr_Pedido_Cpa);
end;

procedure TFr_Principal.Pc_AbrePedidoVenda;
begin
  TSetesForms.Show(TFr_Pedido_Vda);
end;

procedure TFr_Principal.Sb_Fi_Fin_CliClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Fich_Fin_Cli);
end;

procedure TFr_Principal.Sb_Cta_ReceberClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Receber_multipla);
end;

procedure TFr_Principal.Sb_chequesClick(Sender: TObject);
begin
  TSetesForms.Show(TSeaCtrlCheque);
end;

procedure TFr_Principal.LogPedidos1Click(Sender: TObject);
begin
  TSetesForms.Show(TRegOrderLog);
end;

procedure TFr_Principal.ransformao1Click(Sender: TObject);
Begin
  TSetesForms.Show(TSeaReceipt);
end;

procedure TFr_Principal.ipoVeculo1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaVehicleKind);
end;

procedure TFr_Principal.MarcasModelos1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaVehicleBrand);
end;

procedure TFr_Principal.MarketplaceMagazord1Click(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Magazord','Marketplace','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    if ValidaBaixarMarktplaceMagazord then
    Begin
      BaixarMarktplaceMagazord
    end;
    AbrirMarketplaceMagazord;
  end;

end;

procedure TFr_Principal.Veculos1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Veiculo);
end;

procedure TFr_Principal.OrdemdeServio1Click(Sender: TObject);
begin
  //Precisa verificar que este formulario esá referenciado dentro de alguns relatorios, será necessarios criar uma independencia
  if not assigned(Fr_Imp_Servico) then
    Application.CreateForm(TFr_Imp_Servico, Fr_Imp_Servico);
  Fr_Imp_Servico.ShowModal;
end;

procedure TFr_Principal.Produo1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Producao) then
    Application.CreateForm(TFr_Imp_Producao, Fr_Imp_Producao);
  Fr_Imp_Producao.ShowModal;
end;

procedure TFr_Principal.Promoes1Click(Sender: TObject);
begin
  TSetesForms.Show(TseaPromotion);
end;

procedure TFr_Principal.MnuRelMpCrgOperClick(Sender: TObject);
begin
  if not assigned(Fr_Imp_MapaCarga) then
    Application.CreateForm(TFr_Imp_MapaCarga, Fr_Imp_MapaCarga);
  Fr_Imp_MapaCarga.ShowModal;
end;

procedure TFr_Principal.MnuArqSairOperClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Principal.MnuArqSairFinClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Principal.MnuArqSairBcoClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Principal.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Principal.MenuItem9Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Principal.MenuTerminal;
var
  Lc_I : Integer;
  LcLinha : String;
  Lc_FileImport : TextFile;
begin
  Lc_I := 0;
  if FileExists(concat( GbPathExe,'LISTATERMINAL.TXT')) then
  Begin
    Try
      AssignFile(Lc_FileImport,concat( GbPathExe,'LISTATERMINAL.TXT'));
      Reset( Lc_FileImport ); //abre o arquivo para leitura;

      While not eof(Lc_FileImport) do
      begin
        Readln(Lc_FileImport,LcLinha);
        inc(Lc_I);
      End;;
    Finally
      Closefile(Lc_FileImport); //fecha o handle de arquivo
    End;
  end;
  ListaTerminais.Visible := (Lc_I > 1);
end;

procedure TFr_Principal.EtiquetasMalaDireta1Click(Sender: TObject);
var
  Lc_Escolha: Integer;
  lc_data: string;
  Lc_Texto: string;
begin
  lc_data := Fc_Tb_Geral('L', 'CRM_QUALIFICA', DateToStr(Date));
  if lc_data = '' then
    begin
    Lc_Texto := 'A qualificação dos clientes ainda Não foi executada.';
    end
  else
    begin
    Lc_Texto := 'A última qualificação dos clientes foi feito no dia ' + lc_data + '.'
    end;
  Lc_Escolha := (MensagemPadrao('Aviso Importante.',
                                Lc_Texto + EOLN + EOLN +
                                'Escolha dentre as opções.',
                                ['Mala Direta', 'CRM Clientes', 'Cancelar'], [bNormal, bNormal, bEscape], mpConfirmacao, clBtnFace));
  case Lc_Escolha of
    0:begin
        TSetesForms.Show(TFr_maladireta)
      end;
    1:begin
        TSetesForms.Show(TFr_Crm);
      end;
  end;
end;

procedure TFr_Principal.Lucratividade1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Imp_Lucratividade);
end;

procedure TFr_Principal.CpiaBDados1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_CopiaBancoDAdos);
end;

function TFr_Principal.Fc_Valida_Autenticacao: Boolean;
Begin
  Result := True;
  If Trim(CB_Usuario.Text) = '' then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por Favor informe um usuário.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    if CB_Usuario.CanFocus then
      CB_Usuario.SetFocus;
    exit;
  end;

  If Trim(E_Senha.Text) = '' then
  Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por favor informe uma senha.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    if Assigned(E_Senha) and E_Senha.CanFocus then
      E_Senha.SetFocus;
    exit;
  end;

end;

procedure TFr_Principal.SB_LoginClick(Sender: TObject);
begin
  if not Fc_Valida_Autenticacao then
    Exit;

  SB_Login.Enabled := False;
  try
    if Fc_AutenticaUsuario(CB_Usuario.Text,E_Senha.Text) then
      SetAuthentication;
    // TODO: Rod - sem internet
    SendEmailLoginFail;
    if Assigned(E_Senha) then
      E_Senha.Text := '';
  finally
    SB_Login.Enabled := True;
  end;
end;


procedure TFr_Principal.Sair2Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Principal.FormShow(Sender: TObject);
Var
  LcData : TDateTime;
  LcExe : String;
begin
  Try
    Gb_PAF_NFE_e := False;
    Tm_Agenda.enabled := True;
    Tm_Status.enabled := True;
    Gb_CorEntra := clYellow;
    Gb_CorSai := clWindow;
    Menu := Mnu_inicial;
    top := 0;
    Left := 0;
    Pc_MontaUsuario(CB_Usuario);
    SB_Status.Panels[1].Text := DateToStr(Date);
    SB_Status.Panels[2].Text := 'versão: 2.016 - ' + Fc_Aq_Geral('L','SISTEMA','Versao',Gb_data_Criacao);
    //Data nome do executvel
    LcExe := ExtractFileName(ParamStr(0));
    FileAge(ParamStr(0),LcData);
    LcExe := concat(UpperCase(Copy(LcExe,1,1)),
                    LowerCase(Copy(LcExe,2,Length(LcExe)-1)),' - ',
                    DateTimeToStr(LcData));
    SB_Status.Panels[4].Text := LcExe;
    Pc_Resolucao;
    //  Pc_EnviaEmailClienteNaoCadastrado;
    //  pc_licenca;
    //Ativa o time para consulta de perguntas na internet
    It_PedidoInternet := (Fc_Tb_Geral('L','VDA_G_PEDIDO_INTERNET','N') = 'S');
    It_PerguntaInternet := (Fc_Tb_Geral('L','VDA_G_PERGUNTA_INTERNET','N') = 'S');

    if CB_Usuario.canfocus then CB_Usuario.SetFocus;
  Finally

  End;
end;

procedure TFr_Principal.Sb_LogoutClick(Sender: TObject);
begin
  Pnl_Login.Visible := True;
  Sb_Logout.Visible := False;
  Gb_Cd_Usuario := 0;
  GB_Cd_Vendedor := 0;
  Gb_Liberado := False;
  CB_Usuario.SetFocus;
  Menu := Mnu_inicial;
  pc_MontaToolBar('L', 'N');
  Img_Principal.Picture.LoadFromFile('');
  Pc_MontaUsuario(CB_Usuario);
  OcultaNotification;
  Tm_Agenda.enabled := False;
  ParaRetaguarda;
end;

procedure TFr_Principal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F3:if Sb_Pesq_Produtos.Visible then Sb_Pesq_ProdutosClick(Self);
      VK_RETURN: if Pnl_Login.Visible then
          SB_LoginClick(Sender);
    end;
  end;
end;


procedure TFr_Principal.CRMClientes1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Crm);
end;

procedure TFr_Principal.CartoEletrnico1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaEletronicCard);
end;


procedure TFr_Principal.Gerencial1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_CtasGerenciais) then
    Application.CreateForm(TFr_Imp_CtasGerenciais, Fr_Imp_CtasGerenciais);
  Fr_Imp_CtasGerenciais.ShowModal;
end;

procedure TFr_Principal.Grfica1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaOrderPrintShop);
end;

procedure TFr_Principal.Sb_OrcamentoClick(Sender: TObject);
begin
  MnuTafTrfOperClick(Self);
end;

procedure TFr_Principal.Consignao1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaConsignment);
end;

procedure TFr_Principal.ConsultaConserto1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Clta_Csto);
end;

procedure TFr_Principal.ConsultaLotes1Click(Sender: TObject);
begin
  TSetesForms.Show(TTasGeraNfceOperacao);
end;

procedure TFr_Principal.Sb_Clta_CstClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Clta_Csto);
end;

procedure TFr_Principal.MenuItem17Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Colaborador) then
    Application.CreateForm(TFr_Imp_Colaborador, Fr_Imp_Colaborador);
  Fr_Imp_Colaborador.ShowModal;
end;

procedure TFr_Principal.MapaProduo1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_MapaProducao) then
    Application.CreateForm(TFr_Imp_MapaProducao, Fr_Imp_MapaProducao);
  Fr_Imp_MapaProducao.ShowModal;
end;

procedure TFr_Principal.Sb_TelefoneClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Fone_Util);
end;


procedure TFr_Principal.Vales1Click(Sender: TObject);
Var
  Form : TFr_Lanca_Folha;
begin
  try
    Form := TFr_Lanca_Folha.Create(nil);
    Form.Lb_Vencimento.Visible := False;
    Form.E_Credito.Visible := False;
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Principal.Vales2Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Eventos) then
    Application.CreateForm(TFr_Imp_Eventos, Fr_Imp_Eventos);
  Fr_Imp_Eventos.ShowModal;
end;


function TFr_Principal.ValidaAberturaFrenteCaixa: Boolean;
Var
  Lc_Tentativas : Integer;
Label
  Lb_ValidaCaixaAberto;
begin
  Lc_Tentativas := 0;
  Result := True;

  if not ValidateExistenciaClienteConsumidor then
  Begin
    Result := False;
    exit;
  end;

  if not ValidaExistenciaVendedor then
  Begin
    Result := False;
    exit;
  end;

  if Gb_PAF_NFE_E then
  Begin
    if ValidatePafNfceForcedClosure then
    Begin
      Result := False;
      exit;
    end;
  end;

  Lb_ValidaCaixaAberto:
  if not Fc_VerificaCaixaAberto(True) then
  Begin
    AbrirTelaCaixa;
    inc(Lc_Tentativas);
    if Lc_Tentativas <= 3 then
      goto Lb_ValidaCaixaAberto;
    Result := False;
    exit;
  End;



end;

function TFr_Principal.ValidaAberturaPizzaria: Boolean;
Var
  Lc_Tentativas : Integer;
Label
  Lb_ValidaCaixaAberto;
begin
  Lc_Tentativas := 0;
  Result := True;

  if not ValidateExistenciaClienteConsumidor then
  Begin
    Result := False;
    exit;
  end;

  if not ValidaExistenciaVendedor then
  Begin
    Result := False;
    exit;
  end;

  Lb_ValidaCaixaAberto:
  if not Fc_VerificaCaixaAberto(True) then
  Begin
    AbrirTelaCaixa;
    inc(Lc_Tentativas);
    if Lc_Tentativas <= 3 then
      goto Lb_ValidaCaixaAberto;
    Result := False;
    exit;
  End;


end;

function TFr_Principal.ValidaBaixarMarktplaceMagazord: Boolean;
begin
  if not FileExists(GbPathExe + 'Magazord.exe') then
  Begin
    Result := True;
  end
  else
  Begin
    Result := (Fc_Aq_Geral('L','ATUALIZA','MAGAZORD','S') = 'S');
  end;
end;



function TFr_Principal.ValidaExistenciaVendedor: Boolean;
begin
  Result := (Gb_Cd_Vendedor > 0);
  if not Result then
  Begin
    MensagemPadrao('Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Nenhum vendedor foi encontrado.' + EOLN +
                   'É necessário registrar pelo menos um para continuar.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
  end;
end;

function TFr_Principal.ValidateExistenciaClienteConsumidor: Boolean;
Var
  Lc_Cd_Cliente : Integer;
begin
  Lc_Cd_Cliente := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  Result := (Lc_Cd_Cliente > 0);
  if not Result then
  Begin
    MensagemPadrao('Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Código do cliente consumidor Não informado.' + EOLN +
                   'Verifique nas Configurações na aba de pedidos.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
  end;
end;

procedure TFr_Principal.EtiquetasProdutos1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_EtiqProdutos) then
    Application.CreateForm(TFr_Imp_EtiqProdutos, Fr_Imp_EtiqProdutos);
  Fr_Imp_EtiqProdutos.ShowModal;
end;

procedure TFr_Principal.Tm_AgendaTimer(Sender: TObject);
begin
  Pc_Compromisso;
end;

procedure TFr_Principal.Sb_AgendaClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Agenda);
end;

procedure TFr_Principal.Sb_Fi_Fin_ForClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Fich_Fin_For);
end;

procedure TFr_Principal.Despacho1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Despacho);
end;

procedure TFr_Principal.FormResize(Sender: TObject);
begin
  Pc_Resolucao;
end;

procedure TFr_Principal.Sintegra1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Sintegra);
end;

procedure TFr_Principal.Ajustes1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Ajuste) then
    Application.CreateForm(TFr_Imp_Ajuste, Fr_Imp_Ajuste);
  Fr_Imp_Ajuste.ShowModal;
end;

procedure TFr_Principal.AlteraesnoSistema1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_ProjLogChanges);
end;

procedure TFr_Principal.ributao1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaTaxation);
end;

procedure TFr_Principal.AtendimetoPet1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaOrderPetShop);
end;

procedure TFr_Principal.ParaRetaguarda;
var
  LcThread: TThreadRetaguarda;
begin
  LcThread := Retaguarda;
  Retaguarda := nil;
  if Assigned(LcThread) then
  begin
    LcThread.Stop;
    LcThread.WaitFor;
    FreeAndNil(LcThread);
  end;
end;

procedure TFr_Principal.AtivaControleRetaguarda;
Var
  Lc_Ret : TControllerRetaguarda;
begin
  Lc_Ret := TControllerRetaguarda.create(nil);
  Try
    Lc_Ret.getFirst;
    if Lc_Ret.exist then
    Begin
      if Lc_Ret.Registro.Ativo = 'S' then
      Begin
        ParaRetaguarda;
        Retaguarda := TThreadRetaguarda.Create;
        Retaguarda.FRetaguarda.BancoPDV := DM.IBD_Gestao;
        Retaguarda.Start;
      end;
    end;
  finally
    FreeAndNil(Lc_Ret);
  end;
end;

procedure TFr_Principal.AtivaNotification;
Var
  Lc_form : TTasNotification;
begin
  if ( Fc_Tb_Geral('L','GRL_G_NOTIFICATION','N') = 'S') then
  Begin
    Lc_form := TTasNotification .create(pnl_notification);
    Lc_form.parent := pnl_notification;
    pnl_notification.visible := True;
    Lc_form.Show;
  end;
end;

procedure TFr_Principal.Atualizao1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Atualiza);
end;

procedure TFr_Principal.AtualizarSchemas1Click(Sender: TObject);
begin
  TSetesForms.Show(TTasGeraNfeSchemas);
end;

procedure TFr_Principal.AutorizaLoteOFFLine1Click(Sender: TObject);
begin
    TSetesForms.Show(TTasGeraNfceAutorizacaoLote);
end;

procedure TFr_Principal.Action3Execute(Sender: TObject);
begin
  if (CB_Usuario.Text = 'SETES') and (Sb_Logout.Visible = True) then
  begin
    if not Assigned(Fr_Ctrl_Interface) then
      Application.CreateForm(TFr_Ctrl_Interface, Fr_Ctrl_Interface);
    Fr_Ctrl_Interface.Show;
  end;
end;

procedure TFr_Principal.OcultaNotification;
Var
  I:Integer;
  Lc_Form : TTasNotification;
begin
  I := 0;
  Repeat
    if ( Screen.Forms[I] <> Fr_Principal ) then
    Begin
      Screen.Forms[I].Close;
      Screen.Forms[I].disposeof;
    End;
    inc(I);
  Until (Screen.FormCount - 3) <=0  ;
  pnl_notification.visible := False;
end;

procedure TFr_Principal.Cidades1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaCity);
end;

procedure TFr_Principal.Estados1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaUf);

end;

function TFr_Principal.pc_GeraEmailLogin: String;
var
  lc_data : String;
  wAno, wMes, wDia : Word;
  Lc_local : String;
begin
  // Pega a data e ano e mês e dia
  DecodeDate(Date, wAno, wMes, wDia);
  //Define o Local de envio do email (Cidade)
  Pc_AtivaEstabelecimento;
  Lc_local := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString;
  If Length(Trim(Lc_local)) = 0 then
    Lc_local := 'Local Não definido';
  // Insere o dia mês e ano mostrando de qual Cidade

  lc_data := Lc_local + ', ' + IntToStr(wDia) + ' de ' + Fc_DesMes(wMes,False) + ' de ' + IntToStr(wAno) +' / ' + TimeToStr(Now);
  // Gera o corpo do E-mail
  Result := '<table width="689" border="0" cellspacing="0" cellpadding="0"> '+
            '  <tr> '+
            '  <tr>'+ lc_data+ 
            '    <td><strong>O usuário : '+ CB_Usuario.Text+'   </strong></td> '+
            '  </tr> '+
            '  <tr> '+
            '    <td> tentou logar no sistema, no dia conforme descrito a cima     </td> '+
            '  </tr> '+
            '  <tr> '+
            '    <td> porém este acabou Não logando, pelo motivo de errar a senha. </td> '+
            '  </tr>  '+
            '  <td>  Computador : '+ Fc_NomeComputador + '</td> '+
            '  </tr> '+
            '    <td> Att.                      </td> '+
            '  </tr> '+
            '    <td> Administrador do Sistema  </td> ';
end;

procedure TFr_Principal.Pc_TrocaEmbienteEmpresa;
Var
  Lc_Form : TFr_MultiEmpresa;
begin
  try
    Lc_Form := TFr_MultiEmpresa.Create(nil);
    Gb_CodMha := 0;
    Lc_Form.ShowModal;
    if (Lc_Form.It_Codmha > 0) then
    Begin
      Pc_DefineEmpresaAtiva(Lc_Form.It_Codmha);
    end
    else
    Begin
      if (Gb_CodMha = 0) then
      Begin
        MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       'Nenhuma empresa selecionada.' + EOLN +
                       'O sistema será encerrado.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        FreeAndNil(Lc_Form);
        winexec('taskkill /f /im Gestao.exe',sw_hide);
      end;
    end;
  finally
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Principal.Pc_AbreTelaPesqEmpresa(Pc_Tipo_Empresa:Integer);
Var
  Lc_Form : TFr_Pesq_Empresa;
begin
  Lc_Form := TFr_Pesq_Empresa.Create( nil );
  Try
    Lc_Form.TipoEmpresa := Pc_Tipo_Empresa;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Principal.Notas1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Notas) then
    Application.CreateForm(TFr_Imp_Notas, Fr_Imp_Notas);
  Fr_Imp_Notas.ShowModal;
end;

procedure TFr_Principal.AjustaPreo1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_AjustaPreco);
end;

procedure TFr_Principal.AssistnciaTcnica1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaAssistance);
end;

procedure TFr_Principal.Sb_Cta_PagarClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Pagar_Multipla);
end;

procedure TFr_Principal.Situao1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaSituation);
end;

procedure TFr_Principal.Sb_Pesq_ProdutosClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  if Gb_Cd_Usuario > 0 then
  BEgin
    Lc_Form := TFr_Pesq_Produto.Create(Self);
    Try
      Lc_Form.it_Modalidade_preco := 'A';
      Lc_Form.Pc_Tabelas_Disponiveis;
      Lc_Form.SB_Visualizar.Enabled := False;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;
procedure TFr_Principal.Pc_UpdateAtivaCliente;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(' update tb_empresa set emp_ativa = ''S'' where emp_ativa is null ');
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

procedure TFr_Principal.vInutilizaodeNotas1Click(Sender: TObject);
begin
  TSetesForms.Show(TTasGeraNfeInutiliza);
end;

procedure TFr_Principal.ReformaTributria1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaTaxes);
end;

procedure TFr_Principal.Retaguarda1Click(Sender: TObject);
begin
  TSetesForms.Show(TTasRetaguarda);
end;

procedure TFr_Principal.RetaguardaWEB1Click(Sender: TObject);
begin
  TSetesForms.Show(TTasRetaguardaWeb);
end;

procedure TFr_Principal.Medidas1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaMeasure);
end;

procedure TFr_Principal.Embalagens1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaPackage);
end;


procedure TFr_Principal.Marcas1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaProductBrand);
  DM.Qr_MarcaProduto.Active := False;
  DM.Qr_MarcaProduto.Active := True;
end;

procedure TFr_Principal.Oramento1Click(Sender: TObject);
begin
  if not assigned(Fr_Imp_Orcamento) then
    Application.CreateForm(TFr_Imp_Orcamento, Fr_Imp_Orcamento);
  Fr_Imp_Orcamento.ShowModal;
end;

procedure TFr_Principal.PedidodeVendaLojaVirtual1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaLojaTrayOrder);
end;

procedure TFr_Principal.Perfil1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaOperInterface);
end;

procedure TFr_Principal.Interface1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaInterface);
end;

procedure TFr_Principal.InventrioAutomtico1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_inventario);
end;

procedure TFr_Principal.InventrioManual1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_inventario_manual);
end;

procedure TFr_Principal.Perfil2Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaProfile);
end;

procedure TFr_Principal.BaixaporLote1Click(Sender: TObject);
begin
  TSetesForms.Show(TFR_RECEBER_BAIXA_LOTE);
end;


procedure TFr_Principal.BaixarAtualizador1Click(Sender: TObject);
Var
  lc_Form : TBaseDonwload;
begin
  try
    lc_Form := TBaseDonwload.Create(Self);
    lc_Form.Caption := 'Baixar o Atualziador Gestão';
    lc_Form.FileNameZip := 'GestaoUpdate.zip';
    lc_Form.URL := 'https://www.setes.com.br/Gestao2016/';
    lc_Form.ShowModal;
  finally
    FreeAndNil(lc_Form);
  end;
end;


procedure  TFr_Principal.BaixarMarktplaceMagazord;
Var
  lc_Form : TBaseDonwload;
begin
  try
    lc_Form := TBaseDonwload.Create(Self);
    lc_Form.Caption := 'Baixar o Marketplace Magazord';
    lc_Form.FileNameZip := 'Magazord.zip';
    lc_Form.URL := 'https://www.setes.com.br/Magazord/';
    lc_Form.ShowModal;
    Fc_Aq_Geral('G','ATUALIZA','MAGAZORD','N');
  finally
    FreeAndNil(lc_Form);
  end;
end;

procedure TFr_Principal.Comanda1Click(Sender: TObject);
Var
  LcForm : TFr_Lanca_Command;
begin
  if not ValidateExistenciaClienteConsumidor then exit;

  self.Enabled := False;
  LcForm := TFr_Lanca_Command.create(nil);
  Try
    LcForm.Showmodal;
  Finally
    FreeAndNil(LcForm);
    Self.Enabled := True;
  End;
end;

procedure TFr_Principal.ConectaBanco1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_ConectaBanco);
end;

procedure TFr_Principal.Pizzaria1Click(Sender: TObject);
begin
  if ValidaAberturaPizzaria then
  Begin
    OpenPizzaria;
  End;
end;

procedure TFr_Principal.Controledelotes1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Ctrl_Lote);
end;

procedure TFr_Principal.Buffet1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Buffets);
end;

procedure TFr_Principal.AppEventsException(Sender: TObject; E: Exception);
Var
  Lc_TrataExcecao : TTrata_Excecao;
  Lc_StackTrace : string;
begin
  if not IniciarTrataExcecao then
    Exit;
  Lc_TrataExcecao := nil;
  Lc_StackTrace := '';
  try
    try
      GeralogFile(GbPathExe, E.Message);
    except
    end;
    try
      Lc_StackTrace := CaptureExceptionStack(E);
    except
    end;
    Lc_TrataExcecao := TTrata_Excecao.Create();
    Lc_TrataExcecao.Objeto := Sender;
    Lc_TrataExcecao.DefineExcecao(E);
    Lc_TrataExcecao.StackTraceText := Lc_StackTrace;
    Lc_TrataExcecao.Estabelecimento := Gb_Codmha;
    Lc_TrataExcecao.Start;
  except
    FinalizarTrataExcecao;
    if Lc_TrataExcecao <> nil then
    begin
      Lc_TrataExcecao.FreeOnTerminate := False;
      FreeAndNil(Lc_TrataExcecao);
    end;
  end;
end;

procedure TFr_Principal.Desenvolvimento1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_VendaXFinanceiro);
end;

procedure TFr_Principal.ControledeSries1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Ctrl_Serie);
end;

procedure TFr_Principal.ControleEstpqueZerado1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaCtrlEstoqueZerado);
end;

procedure TFr_Principal.ControleSequenciaNotas1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Pesq_Ctrl_NF);
end;

procedure TFr_Principal.Frente1Click(Sender: TObject);
begin
  if ValidaAberturaFrenteCaixa then
  Begin
    OpenFrenteCaixa;
  end;
end;

procedure TFr_Principal.TabelasdePrecoClick(Sender: TObject);
begin
  TSetesForms.Show(TFr_Tabela_Preco);
end;

procedure TFr_Principal.nalisemovimentaoprodutos1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Clta_Mov_Produtos);
end;

procedure TFr_Principal.ListaTerminaisClick(Sender: TObject);
begin
  TSetesForms.Show(TTasConectaTerminal);
end;

procedure TFr_Principal.LogdeOperaes1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Log_Operacao);
end;

procedure TFr_Principal.LogOramento1Click(Sender: TObject);
begin
  TSetesForms.Show(TRegQuotationLog);
end;

procedure TFr_Principal.EFDPISCOFINS1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_SPEDPisCofins);
end;

procedure TFr_Principal.PrVendaBalco1Click(Sender: TObject);
begin
  if not ValidateExistenciaClienteConsumidor then exit;

  if not ValidaExistenciaVendedor then exit;

  self.Enabled := False;

  if not Assigned(Fr_FrenteCaixa) then (Application.CreateForm(TFr_FrenteCaixa, Fr_FrenteCaixa));
  //Define a variavel que vai trabalhar como Pré-Venda
  Fr_FrenteCaixa.It_TP_Operacao := 'CMD';
  try
    Fr_FrenteCaixa.ShowModal;
  finally
    if Assigned(Fr_FrenteCaixa) then FreeAndNil(Fr_FrenteCaixa);
    self.Enabled := True;
  end
end;

procedure TFr_Principal.AnlisedeNegcios1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Clta_Negocio);
end;

procedure TFr_Principal.Cardpio1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Cardapio);
end;

procedure TFr_Principal.Moveleiro1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaFurnitureOS);
end;

function TFr_Principal.Fc_GeraEmailFalhaLogin: String;
begin
  REsult  := concat(
                 '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> ',
                 '<html> ',
                 '<head> ',
                 '  <meta content="text/html; charset=ISO-8859-1" ',
                 ' http-equiv="content-type"> ',
                 '  <title>Tentativa de Login</title> ',
                 '</head> ',
                 '<body> ',
                 '<table style="text-align: left; width: 605px; height: 116px;"  ',
                 ' border="1" cellpadding="0" cellspacing="0"> ',
                 '  <tbody> ',
                 '    <tr> ',
                 '      <td style="width: 159px;">Data&nbsp;</td> ',
                 '      <td style="width: 10px;">:</td> ',
                 '      <td style="width: 790px;">' , DateTimeToStr(Now) ,'</td> ',
                 '    </tr> ',
                 '    <tr> ',
                 '      <td style="width: 159px;">Nome do Usuário</td> ',
                 '      <td style="width: 10px;">:</td>  ',
                 '      <td style="width: 790px;">', CB_Usuario.Text+'</td> ',
                 '    </tr>  ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Nome do Computador</td> ',
                 '      <td style="width: 10px;">:</td> ',
                 '      <td style="width: 790px;">' , Fc_NomeComputador ,'</td> ',
                 '    </tr> ',

                 '  </tbody> ',
                 '</table> ',
                 '</body> ',
                 '</html> '
  );

end;


function TFr_Principal.SendEmailLoginFail: Boolean;
var
  LcEmail : TTRSendEmailLogin;
begin
  LcEmail := TTRSendEmailLogin.Create();
  LcEmail.Usuario :=  CB_Usuario.Text;
  LcEmail.Autenticado := (Gb_Cd_Usuario > 0 );
  LcEmail.FreeOnTerminate := True;
  LcEmail.Start;
end;

procedure TFr_Principal.Servico1Click(Sender: TObject);
begin
  Fc_ChamarGeraNFSE('Config',0)
end;

function TFr_Principal.SetAuthentication: Boolean;
vAR
  LcLoadGeneral : TThreadLoadGeneral;
begin
  if not FileExists(concat(GbPathExe , '/aguarde.gif')) then
    Img_Aguarde.Picture.SaveToFile(concat(GbPathExe , '/aguarde.gif'));
  Pnl_Login.Visible := False;
  Sb_Logout.Visible := True;
  SB_Status.Panels[3].Text := 'Usuário: '+ GB_Nm_Usuario;

  //Oculta o Menu para depois avaliar o que será liberado para o usuario
  Pc_OcultaMenu;

  if Fc_MultiEmpresa then
  Begin
    Pc_TrocaEmbienteEmpresa;
    Sb_MultiEmpresa.Visible := true;
  end
  else
  begin
    Pc_DefineEmpresaAtiva(0);
  end;

  //Faz a abertura do PAF NFCe
  if Gb_PAF_NFE_E then OpeningPAFNFCE;

  //Verifica produtos que estão zerados e sem movimentação
  //Pc_AjustaICMSTSTRetido;
  //Pc_AuditoriaEstoqueDuplicados;

  if Gb_Nivel = 1 then Pc_MontaMenuADM ELSE Pc_MontaMenu;
  MenuTerminal;
  //Verifica NCM
  //Pc_VerificaDadosNCM;
  if Fc_MostraAniver then
    AbreTelaAniversariantes;
  Gb_Terminal := StrToIntDef( Fc_Tb_Geral('L','GRL_G_TERMINAL','1'),1);

  Gb_Reforma_Tributaria := ( Fc_Tb_Geral('L','GRL_G_REF_TRIBUTARIA','N') = 'S');
  AtivaControleRetaguarda;
  AtivaNotification;

  // Carga em background somente após login concluir acessos síncronos ao banco
  // (FireDAC não é thread-safe na mesma conexão compartilhada)
  LcLoadGeneral := TThreadLoadGeneral.create();
  LcLoadGeneral.FreeOnTerminate := True;
  LcLoadGeneral.Start;
end;

procedure TFr_Principal.BoletoEletronico1Click(Sender: TObject);
begin
  TSetesForms.Show(  TSeaElectronicSlip);
end;

procedure TFr_Principal.Boto1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaButtonImage);
end;

procedure TFr_Principal.ImportarXMLdaNFe1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_ImportaXMLNFe);
end;

procedure TFr_Principal.AgendaSalo1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaSchedule);
end;

procedure TFr_Principal.Conferncia1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Conferente);
end;

procedure TFr_Principal.DescontarDuplicata1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Receber_Descontada);
end;

procedure TFr_Principal.EstoqueManual1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_estoque_manual);
end;

procedure TFr_Principal.Estoques1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaStocks);
end;

procedure TFr_Principal.Equipamentos1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaElectEquip);
end;

procedure TFr_Principal.ManutenoVeculos1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Vei_OrdemServico);
end;

procedure TFr_Principal.ManuteoFrotaPrpria1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaOwnFleetOs);
end;

procedure TFr_Principal.readeTestes1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_AreaTestes);
end;

function TFr_Principal.Fc_ValidaVoltaVersao():Boolean;
Begin
  Result := True;
  if not FileExists(GbPathExe + '/Gestao_old.exe') then
  Begin
    MensagemPadrao('Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'O arquivo anterior Não foi encontrado.' + EOLN +
                   'Não É possível voltar a versão atual.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result := False;
    Exit;
  end;
end;


procedure TFr_Principal.Pc_Renomeiarquivo;
var
  Lc_ArquivoV : String;
begin
  if FileExists(GbPathExe + '/Gestao_new.exe') then
    DeleteFile(GbPathExe + '/Gestao_new.exe');
  RenameFile(GbPathExe + '/Gestao.exe',GbPathExe + '/Gestao_new.exe');
  //Renomeia o Arquivo Gestão Old da maquina  para Gestão
  RenameFile(GbPathExe + '/Gestao_old.exe',GbPathExe + '/Gestao.exe');
end;


procedure TFr_Principal.Voltaraversoanterior1Click(Sender: TObject);
begin
  if Fc_ValidaVoltaVersao then
  Begin
    if (MensagemPadrao('Mensagem de Confirmação',
                       'Deseja voltar a versão anterior do sistema.' + EOLN + EOLN +
                       'Confirmar a operação ?',
                       ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    Begin
      Pc_Renomeiarquivo;
      MensagemPadrao('Mensagem', 'S U C E S S O!' + EOLN + EOLN +
                     'operação realizada com sucesso.' + EOLN +
                     'O sistema será encerrado agora.' + EOLN+
                     '    Basta abri-lo novamente' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      Application.Terminate;
      Halt;
    end;
  end;
end;

procedure TFr_Principal.WhatsApp1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaWhatsAppCfg);
end;

procedure TFr_Principal.OrigemdaVenda1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaSalesOrigin);
end;

procedure TFr_Principal.Contratos1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaContract);
end;

procedure TFr_Principal.ControleBasedeTroca1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Ctrl_base_troca);
end;

procedure TFr_Principal.ControledeBoletos1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_ContasReceberBoleto);
end;

procedure TFr_Principal.OrdensdeProduo1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaProduction);
end;

procedure TFr_Principal.OrigemdoCliente1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaCustomerOrigin);
end;

procedure TFr_Principal.Contabilidade1Click(Sender: TObject);
begin
  Pc_AbreTelaPesqEmpresa(9);
end;

procedure TFr_Principal.SPEDFiscal1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_SPEDFiscal);
end;

procedure TFr_Principal.Sb_MultiEmpresaClick(Sender: TObject);
begin
  Pc_TrocaEmbienteEmpresa;
end;

procedure TFr_Principal.Impressoras1Click(Sender: TObject);
begin
  TSetesForms.Show(TSeaPrinters);
end;

procedure TFr_Principal.ImpressoXML1Click(Sender: TObject);
Var
  Lc_Escolha: Integer;
Begin
  Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                'Escolha o Tipo DANFE.',
                                 ['NF-e', 'NFC-e', 'CANCELAR'], [bNormal, bNormal,
                                 bEscape], mpConfirmacao, clBtnFace));
  if Lc_Escolha < 2 then
  Begin
    with Fr_Principal.Nfe do
    Begin
      if Lc_Escolha = 0 then
      Begin
        OpenDialog1.Title := 'Selecione a NF-e';
        Pc_FormataModeloNFE
      end
      else
      Begin
        OpenDialog1.Title := 'Selecione a NFC-e';
        Pc_FormataModeloNFCe;
      end;
      OpenDialog1.DefaultExt := '*-nfe.XML';
      OpenDialog1.Filter :=
        'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
      if OpenDialog1.Execute then
      begin
        NotasFiscais.Clear;
        NotasFiscais.LoadFromFile(OpenDialog1.FileName);
        if (MensagemPadrao(TITULO_CONFIRMACAO, 'Deseja validar o XML?' +
          EOLN + EOLN, [SIM, NAO], [bNormal, bEscape], mpConfirmacao, clred)
          = mrBotao1) then
        begin
          Fr_Principal.Nfe.NotasFiscais.GerarNFe;
          Fr_Principal.Nfe.NotasFiscais.Assinar;
          Fr_Principal.Nfe.NotasFiscais.Validar;
        end;
        DANFE.MostraPreview := True;
        NotasFiscais.Imprimir;
      end;
    end;
  end;
end;

procedure TFr_Principal.LojaVirtual1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Virtual_Shop);
end;

procedure TFr_Principal.MnuRamodeAtividadeClick(Sender: TObject);
begin
  TSetesForms.Show(TSeaLineBusiness);
end;

procedure TFr_Principal.CientesemProspeco1Click(Sender: TObject);
begin
  Pc_AbreTelaPesqEmpresa(8);
end;

procedure TFr_Principal.CloseDatabaseSafe;
var
  SavedBeforeDisconnect: TNotifyEvent;
begin
  if not Assigned(DM) or not Assigned(DM.IBD_Gestao) then Exit;
  if not DM.IBD_Gestao.Connected then Exit;

  { Evita dupla passagem: este metodo ja encerra datasets/transacoes; sem isto,
    IBD_GestaoBeforeDisconnect repetia Commit/Close dos datasets durante Connected:=False. }
  SavedBeforeDisconnect := DM.IBD_Gestao.BeforeDisconnect;
  DM.IBD_Gestao.BeforeDisconnect := nil;
  try
    // 1) UnPrepare dos componentes TST do Owner do DB
    UnprepareAndCloseAll;

    // 2) fechar TODOS os datasets ligados ao database (IBX/FireDAC)
    CloseGestaoDataSets;

    // 3) encerrar TODAS as transacoes ligadas ao database (IBX/FireDAC via TST)
    CloseGestaoTransactions;
    // 4) fechar a conexao
    try
      DM.IBD_Gestao.Connected := False;
    except
      try
        DM.IBD_Gestao.Close;
      except
        // silencioso
      end;
    end;
  finally
    DM.IBD_Gestao.BeforeDisconnect := SavedBeforeDisconnect;
  end;
end;

procedure TFr_Principal.Configuraes1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Configuracao);
end;

procedure TFr_Principal.ConfiguraesLocais1Click(Sender: TObject);
begin
  TSetesForms.Show(TFr_Configuracao_Local);
end;

procedure TFr_Principal.Configurao1Click(Sender: TObject);
begin
  TSetesForms.Show(TTasGeraNfeConfig);
end;

procedure TFr_Principal.SB_PedidoClick(Sender: TObject);
begin
  Pc_AbrePedidoVenda;
end;

procedure TFr_Principal.NotasFiscaisConsumidor1Click(Sender: TObject);
begin
  Pc_AbreTelaPesqNF_65;
end;

procedure TFr_Principal.Img_YoutubeClick(Sender: TObject);
begin
//  Fc_ChamaTelaVideoTreinamento('','','http://www.setes.com.br/ctv/index.html');
//  Fc_ChamaTelaVideoTreinamento('','','https://youtu.be/XEpOBIm3BYw');
  Fc_ChamaTelaVideoTreinamento('','','https://www.youtube.com/watch?v=XEpOBIm3BYw&feature=youtu.be');
end;


procedure TFr_Principal.SB_EncerrarClick(Sender: TObject);
begin
  Close;
end;

function Fc_MultiEmpresa(): Boolean;
Var
  Lc_Nivel : Integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  //Guarda o nivel atual do Usuario
  Lc_Nivel := Gb_Nivel;
  Gb_Nivel := 1;
  //Permite o acesso a esta funcionalidade a todos os usuarios
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.add('Select EMP_CODIGO FROM TB_EMPRESA WHERE (EMP_TIPO = ''0'') ');
      Active := True;
      Fetchall;
      //Recoloca o nivel do usuario
      Result := (RecordCount > 1) AND Fc_HabilitaPermissao('MultiEmpresa','VISUALIZAR','S');
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    Gb_Nivel :=Lc_Nivel;
  end;
end;


end.
