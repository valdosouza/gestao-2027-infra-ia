unit Un_Configuracao;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, System.TypInfo, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, ACBrGAV, ACBrBase, ACBrBAL, Actions, Vcl.ActnList, Vcl.Dialogs, QEdit_Setes, Vcl.Mask, Vcl.Printers, ACBrDevice, ACBrDeviceSerial, ControllerGeral, ControllerProduto;


type
  TFr_Configuracao = class(TForm)
    OpenDialogo: TOpenDialog;
    Act_Acoes: TActionList;
    Act_Diversos: TAction;
    Pg_Configuracao: TPageControl;
    Tbs_Geral: TTabSheet;
    Panel8: TPanel;
    Btn_Ok_1: TButton;
    Btn_Cn_1: TButton;
    GB_Aniver: TGroupBox;
    Label12: TLabel;
    Label54: TLabel;
    Rb_Aniv_Dia: TRadioButton;
    Rb_Aniv_Semana: TRadioButton;
    Rb_Aniv_Mes: TRadioButton;
    E_Aniv_DataIni: TMaskEdit;
    E_Aniv_DataFim: TMaskEdit;
    ChBx_Aniver: TCheckBox;
    Chbx_Conserto: TCheckBox;
    Chbx_dt_Padrao: TCheckBox;
    GroupBox1: TGroupBox;
    E_Atualizador: TEdit;
    chk_cliente_cpf: TCheckBox;
    rg_pessoaPredominante: TRadioGroup;
    Btn_Ap_1: TButton;
    Tbs_Financeiro: TTabSheet;
    Sb_FN_Ok: TButton;
    Sb_FN_Cancelar: TButton;
    Panel7: TPanel;
    GroupBox11: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label23: TLabel;
    E_Multa: TEdit_Setes;
    E_Juros: TEdit_Setes;
    E_Carencia: TEdit_Setes;
    Chbx_Ativa_Cobranca: TCheckBox;
    Chbx_Cheque_Devolvido: TCheckBox;
    Chbx_Cheque_PreDatado: TCheckBox;
    Chbx_Saldo_Devedor: TCheckBox;
    Chbx_Credito: TCheckBox;
    ch_cliente_saldo: TCheckBox;
    chk_Saldo_atraso: TCheckBox;
    Btn_Ok_2: TButton;
    Btn_Cn_2: TButton;
    Btn_Ap_2: TButton;
    Tbs_OrdemServico: TTabSheet;
    Panel3: TPanel;
    ChBx_Servicos: TCheckBox;
    Tbs_Impressao: TTabSheet;
    Panel5: TPanel;
    ChBx_Vis_Relatorio: TCheckBox;
    ChBx_Cupom: TCheckBox;
    Tbs_Produto: TTabSheet;
    Panel4: TPanel;
    Chbx_CodigoExato: TCheckBox;
    ChBx_Distingue_Produto: TCheckBox;
    GroupBox9: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    E_ProMovimento: TEdit_Setes;
    GroupBox12: TGroupBox;
    Lb_Formula: TLabel;
    Rd_Calculo_Tipo_1: TRadioButton;
    Rd_Calculo_Tipo_2: TRadioButton;
    ChBx_Observacao_NFe: TCheckBox;
    rdg_Preco_venda: TRadioGroup;
    Rg_AtualizaPrecoVenda: TRadioGroup;
    chk_contAba: TGroupBox;
    ChBx_ABA_Fornecedor: TCheckBox;
    ChBx_ABA_imposto: TCheckBox;
    ChBx_ABA_TabeladePrec: TCheckBox;
    ChBx_ABA_imagem: TCheckBox;
    ChBx_ABA_instacao: TCheckBox;
    ChBx_ABA_estoque: TCheckBox;
    ChBx_ABA_aviamento: TCheckBox;
    ChBx_ABA_composicao: TCheckBox;
    ChBx_ABA_Aplicacao: TCheckBox;
    rdg_Rel_inv: TRadioGroup;
    Tbs_Pessoal: TTabSheet;
    Panel9: TPanel;
    Chbx_CompColaborador: TCheckBox;
    Btn_Ok_4: TButton;
    Btn_Cn_4: TButton;
    Btn_Ap_4: TButton;
    Btn_Ok_5: TButton;
    Btn_Cn_5: TButton;
    Btn_Ap_5: TButton;
    Btn_Ok_6: TButton;
    Btn_Cn_6: TButton;
    Btn_Ap_6: TButton;
    Tbs_comissao: TTabSheet;
    Panel1: TPanel;
    Memo1: TMemo;
    Memo2: TMemo;
    chk_Com_Vend_ped: TCheckBox;
    Chk_Com_Desc: TCheckBox;
    RB_Com_Fat: TRadioButton;
    RB_Com_Rec: TRadioButton;
    E_Aliq_Com_Padrao: TEdit_Setes;
    Label1: TLabel;
    Chb_ImpSalto: TCheckBox;
    Chb_ImpCondensa: TCheckBox;
    chk_visualisa_com: TCheckBox;
    tbs_pedidos: TTabSheet;
    Btn_Ok_7: TButton;
    Btn_Cn_7: TButton;
    Btn_Ap_7: TButton;
    Panel6: TPanel;
    Btn_Ok_9: TButton;
    Btn_Cn_9: TButton;
    Btn_Ap_9: TButton;
    lb_qtd_itens: TLabel;
    ed_qtd_nfe: TEdit_Setes;
    Chbx_Devolucao: TCheckBox;
    chbx_ProdMultiEmpresa: TCheckBox;
    chbx_crtl_codFab: TCheckBox;
    chbx_lbl_produto: TCheckBox;
    Chbx_Val_Ppagto_CP: TCheckBox;
    Chbx_Val_Ppagto_CR: TCheckBox;
    GpB_Devolucao: TGroupBox;
    E_Cd_Produto: TEdit_Setes;
    Sb_Produto: TSpeedButton;
    chbx_aq_comissao: TCheckBox;
    chbx_Pesq_CodBarra: TCheckBox;
    Tbs_Balanca: TTabSheet;
    Balanca: TACBrBAL;
    Panel2: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    btnConectar: TButton;
    btnDesconectar: TButton;
    btnLerPeso: TButton;
    sttPeso: TStaticText;
    sttResposta: TStaticText;
    E_Timer: TEdit_Setes;
    chbMonitorar: TCheckBox;
    Memo3: TMemo;
    Panel11: TPanel;
    Label40: TLabel;
    Label10: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Cb_Tipo_Balanca: TComboBox;
    Cb_Porta_Serial: TComboBox;
    Cb_Baud_Rate: TComboBox;
    Cb_Data_Bits: TComboBox;
    Cb_HandShaking: TComboBox;
    Cb_Paridade: TComboBox;
    Cb_BitsParada: TComboBox;
    chbx_Balanca: TCheckBox;
    Button5: TButton;
    Btn_Ok_12: TButton;
    Btn_Cn_12: TButton;
    Btn_AP_12: TButton;
    GroupBox23: TGroupBox;
    Sb_Buffet: TSpeedButton;
    E_Cd_Pro_Buffet: TMaskEdit;
    GroupBox24: TGroupBox;
    E_PortaImpressao: TEdit;
    E_SaltoImpressao: TEdit_Setes;
    ChBx_ABA_Botoes: TCheckBox;
    ChBx_DesativaProduto: TCheckBox;
    GroupBox25: TGroupBox;
    Rg_Casas_Venda: TRadioGroup;
    Rg_Casas_Compra: TRadioGroup;
    Label17: TLabel;
    ed_vl_cupom: TEdit_Setes;
    Ds_NF_Informatizada: TDataSource;
    chbx_venc_lote: TCheckBox;
    chbx_email_auto: TCheckBox;
    ChBx_LiberaDigitacaoBanco: TCheckBox;
    ChBx_CalculoAutoPrecoVenda: TCheckBox;
    ACBrGAV1: TACBrGAV;
    Ds_TabelaConsumidor: TDataSource;
    pg_pedidos: TPageControl;
    tbs_controle_venda: TTabSheet;
    rdg_Lucratividade: TRadioGroup;
    ChBx_InformaValor: TCheckBox;
    Chbx_Rec_Bruta_Venda: TCheckBox;
    Chbx_Custo_Relatorio_Venda: TCheckBox;
    chbk_Valida_Transp: TCheckBox;
    chbx_reg_obs_naNF: TCheckBox;
    tbs_controle_compra: TTabSheet;
    Label41: TLabel;
    Label6: TLabel;
    ChBx_Ctrl_Nota_Compra: TCheckBox;
    ChBx_Nfe_Compra: TCheckBox;
    Chbx_controle_compra: TCheckBox;
    cbx_modeloLaser_cpa: TComboBox;
    rdg_PedCpa_Imp: TRadioGroup;
    GroupBox16: TGroupBox;
    e_porta_ImpCpa: TEdit;
    e_salto_cpa: TEdit_Setes;
    cbx_modeloMat_cpa: TComboBox;
    GroupBox17: TGroupBox;
    e_itens_cpa: TEdit_Setes;
    tbs_controle_Frente: TTabSheet;
    Panel10: TPanel;
    Label48: TLabel;
    Label49: TLabel;
    Label53: TLabel;
    cbx_modeloMat_Frt: TComboBox;
    cbx_modeloTer_frt: TComboBox;
    GroupBox13: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label55: TLabel;
    Cb_Gvta_modelo: TComboBox;
    Cb_Gvta_porta: TComboBox;
    Cb_Gvta_StrAbertura: TComboBox;
    Cb_Gvta_AcaoAntecip: TComboBox;
    Dblcb_TabelasConsumidor: TDBLookupComboBox;
    rdg_PedfRT_Imp: TGroupBox;
    RB_ImpMatricial_Frt: TRadioButton;
    RB_ImpTermica_Frt: TRadioButton;
    RB_ImpPedido_Frt: TRadioButton;
    GroupBox27: TGroupBox;
    e_salto_Frt: TEdit_Setes;
    Chb_ImpCupom: TCheckBox;
    Chb_Visualiza_Cupom: TCheckBox;
    ChBx_CodigoBarra: TCheckBox;
    grp_geral: TGroupBox;
    chbx_Ctrl_Est_Auto: TCheckBox;
    tbs_Despacho: TTabSheet;
    Panel13: TPanel;
    chbx_Ctrl_despacho: TCheckBox;
    Chbx_Ctrl_separacao: TCheckBox;
    GroupBox14: TGroupBox;
    E_PortaImpressao_dsp: TEdit;
    E_SaltoImpressao_dsp: TEdit_Setes;
    Sb_OK_10: TButton;
    Sb_Cn_10: TButton;
    Sb_Ap_10: TButton;
    chbx_Imp_auto_Separacao: TCheckBox;
    Chbx_ProdutoAvulso: TCheckBox;
    Label47: TLabel;
    Cb_TipoImpressora: TComboBox;
    E_Nr_Colunas: TEdit_Setes;
    Label57: TLabel;
    e_porta_Frt: TEdit;
    ChBx_UsarCodigoFAb: TCheckBox;
    ChBx_Imp_Item_Checkout: TCheckBox;
    Chbx_Frt_Desconto: TCheckBox;
    tbs_controle_Pizzaria: TTabSheet;
    Panel15: TPanel;
    rdg_PedPiz_Imp: TGroupBox;
    RB_ImpMatricial_Piz: TRadioButton;
    RB_ImpTermica_Piz: TRadioButton;
    GroupBox29: TGroupBox;
    e_salto_Piz: TEdit_Setes;
    e_porta_Piz: TEdit;
    GroupBox30: TGroupBox;
    Rd_Media_Pizzaria: TRadioButton;
    Rd_Maior_Pizzaria: TRadioButton;
    rg_ClientePredominante: TRadioGroup;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    ChBx_Veiculo: TCheckBox;
    ChBx_Placa: TCheckBox;
    Chbx_Tecnico: TCheckBox;
    Chbx_Instalador_vendedor: TCheckBox;
    Cb_ImpOrdemServico: TComboBox;
    ChBx_SistemaAndroid: TCheckBox;
    Label59: TLabel;
    Chbx_Fin_FichaCadastral: TCheckBox;
    chbx_Fin_Referencia: TCheckBox;
    E_Cpm_Nr_Vias: TEdit;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Cb_Cpm_TipoImpressora: TComboBox;
    E_Cpm_Colunas: TEdit_Setes;
    ChBx_Obs_Veiculo_NF: TCheckBox;
    Grb_Ctrl_Compra: TGroupBox;
    E_Ctrl_Cpa_Valor_Total: TEdit_Setes;
    Label9: TLabel;
    ChBx_PedidoInternet: TCheckBox;
    Label15: TLabel;
    cbx_Impressao_Dsp: TComboBox;
    Chbx_Troca: TCheckBox;
    ChBx_MostraEstabelecimento: TCheckBox;
    GroupBox7: TGroupBox;
    Sb_Consumidor: TSpeedButton;
    E_CodConsumo: TEdit_Setes;
    Label2: TLabel;
    Chbx_RegistrarAlteraPreco: TCheckBox;
    Chbx_PerguntasInternet: TCheckBox;
    Chbx_Decreto108352014: TCheckBox;
    ChBx_Detalhar_ST: TCheckBox;
    GroupBox6: TGroupBox;
    edtCaminhoBancoEnviaPedido: TEdit;
    Chbx_MultiEmpresaMostraTodas: TCheckBox;
    Label5: TLabel;
    Label16: TLabel;
    cbx_modeloMat_Piz: TComboBox;
    cbx_modeloTer_Piz: TComboBox;
    GroupBox10: TGroupBox;
    Chbx_Ativar_Identificador_Piz: TCheckBox;
    E_PortaCom_Piz: TEdit;
    ChBx_AutoFaturamentoEntrega: TCheckBox;
    GroupBox22: TGroupBox;
    Label18: TLabel;
    E_Tra_Str_Ini_Piz: TEdit;
    E_Tra_Str_Tam_Piz: TEdit;
    Label63: TLabel;
    GroupBox28: TGroupBox;
    E_bal_bar_Cd_Produto: TEdit_Setes;
    Label64: TLabel;
    Label65: TLabel;
    Lb_blc_bar_Preco_Peso: TLabel;
    E_bal_bar_Preco_Peso: TEdit_Setes;
    TabSheet6: TTabSheet;
    Label58: TLabel;
    Label8: TLabel;
    Chbx_Nfse_Conjugada: TCheckBox;
    ComboBox3: TComboBox;
    Label69: TLabel;
    E_Nfse_Cd_LC116: TEdit;
    Chbx_Cli_Ctrl_Email: TCheckBox;
    Chbx_Cli_Ctrl_Fone: TCheckBox;
    ChBx_NovaVersaoOS: TCheckBox;
    ChBx_ComissaoFrenteCaixa: TCheckBox;
    Chbx_Vda_Sem_Ctrl_Estoque: TCheckBox;
    Chbx_ZerarPedidoPizza: TCheckBox;
    TabSheet7: TTabSheet;
    Panel12: TPanel;
    Btn_Ok_11: TButton;
    Btn_Cn_11: TButton;
    Btn_Ap_11: TButton;
    GroupBox8: TGroupBox;
    Label19: TLabel;
    E_Tx_Cr_ICMS: TEdit_Setes;
    Chbx_MultiEmpresaEscolheNFe: TCheckBox;
    Rg_Rdp_Fte_Padrao: TRadioGroup;
    E_Cpm_Modelo: TComboBox;
    ChBx_ItensPedidoM2: TCheckBox;
    Chbx_Fin_BaixaAutomatica: TCheckBox;
    ChBx_ItensPedidoMod50: TCheckBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    E_Diariamotoboy: TEdit_Setes;
    ChBx_ImpostoAproximado: TCheckBox;
    GroupBox4: TGroupBox;
    E_PortaImpZebra: TEdit;
    ChBx_EmailSistemaNfe: TCheckBox;
    ChBx_MostraTelaFinanceiro: TCheckBox;
    ChBx_Piz_GuilhotinaOneByOne: TCheckBox;
    ChBx_DadosCartao: TCheckBox;
    ChBx_DadosCheque: TCheckBox;
    tbsTEF: TTabSheet;
    Panel17: TPanel;
    Panel18: TPanel;
    btn_ok_13: TButton;
    btn_cn_13: TButton;
    btn_ap_13: TButton;
    Label7: TLabel;
    Label13: TLabel;
    chbx_CortePapel: TCheckBox;
    Button2: TButton;
    ChBx_TEF: TCheckBox;
    ChBx_TEF_Ativa_Local: TCheckBox;
    Label14: TLabel;
    E_TEF_ID_Loja: TEdit_Setes;
    Label20: TLabel;
    E_TEF_Porta_PinPad: TEdit_Setes;
    Label28: TLabel;
    E_TEF_Desc_Terminal: TEdit;
    E_TEF_IP: TEdit;
    ChBx_Vend_List_cliente: TCheckBox;
    E_TEF_ID_Terminal: TEdit;
    GroupBox18: TGroupBox;
    Label34: TLabel;
    E_Tx_Aprox_Mun: TEdit_Setes;
    Cb_ListPrintWindows: TComboBox;
    Lb_ListPrintWindows: TLabel;
    chbx_piz_reduzir_valor_Entrega: TCheckBox;
    Button1: TButton;
    lbl_status: TLabel;
    lb_CodStatus: TLabel;
    chbx_frt_nota_Promissoria: TCheckBox;
    ChBx_AutoFaturamentoBalcao: TCheckBox;
    ChBx_AutoFaturamentoMesa: TCheckBox;
    chbx_SemBenef: TCheckBox;
    GroupBox19: TGroupBox;
    E_Terminal: TEdit_Setes;
    chbx_ValidaDiferencaCompra: TCheckBox;
    E_LarguraBobina: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    E_MarDirBobina: TEdit;
    Label37: TLabel;
    E_MarEsqBobina: TEdit;
    Label66: TLabel;
    Cb_modulo_servico: TComboBox;
    Panel20: TPanel;
    Btn_Ok_3: TButton;
    Button10: TButton;
    Btn_Ap_3: TButton;
    GroupBox5: TGroupBox;
    Rb_Bal_Preco: TRadioButton;
    Rb_Bal_Peso: TRadioButton;
    Chbx_Res_Vda_Hora: TCheckBox;
    Chbx_Autorizar_Contas_Pagar: TCheckBox;
    Chbx_NaoValidaEAN: TCheckBox;
    Chbx_TEF_Comp_Quebra_Linha: TCheckBox;
    Chbx_TEF_Comp_Mostra_Usuario: TCheckBox;
    chbx_frt_bloqueia_F11: TCheckBox;
    ChBx_Fat_Vda_Auto_Cta_Ger: TCheckBox;
    Chbx_PAF_NFC_E: TCheckBox;
    tbs_estoque: TTabSheet;
    Panel22: TPanel;
    Panel21: TPanel;
    ChBx_est_Avise_Saldo_Zero: TCheckBox;
    GroupBox20: TGroupBox;
    E_est_email_notifica: TEdit;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ChBx_Fat_Vda_Auto_Boleto_impressao: TCheckBox;
    Chbx_est_auto_reposicao: TCheckBox;
    chbx_enable_notification: TCheckBox;
    Chbx_Send_Qr_code_Pinpad: TCheckBox;
    chbx_Reforma_tributaria: TCheckBox;
    ChBx_EnvioBoletoEmail: TCheckBox;
    Chbx_despacho_by_cod_barra: TCheckBox;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_ConsumidorClick(Sender: TObject);
    procedure ChBx_ServicosClick(Sender: TObject);
    procedure Chbx_DevolucaoClick(Sender: TObject);
    procedure Rd_Calculo_Tipo_1Click(Sender: TObject);
    procedure Rd_Calculo_Tipo_2Click(Sender: TObject);
    procedure Tbs_GeralShow(Sender: TObject);
    procedure Btn_Ok_1Click(Sender: TObject);
    procedure Btn_Ok_2Click(Sender: TObject);
    procedure Btn_Ok_3Click(Sender: TObject);
    procedure Btn_Ok_4Click(Sender: TObject);
    procedure Btn_Ok_5Click(Sender: TObject);
    procedure Btn_Ok_6Click(Sender: TObject);
    procedure Btn_Ap_6Click(Sender: TObject);
    procedure Btn_Ap_5Click(Sender: TObject);
    procedure Btn_Ap_4Click(Sender: TObject);
    procedure Btn_Ap_3Click(Sender: TObject);
    procedure Btn_Ap_2Click(Sender: TObject);
    procedure Btn_Ap_1Click(Sender: TObject);
    procedure Tbs_ImpressaoShow(Sender: TObject);
    procedure Tbs_FinanceiroShow(Sender: TObject);
    procedure Tbs_OrdemServicoShow(Sender: TObject);
    procedure Tbs_ProdutoShow(Sender: TObject);
    procedure Tbs_PessoalShow(Sender: TObject);
    procedure Tbs_comissaoShow(Sender: TObject);
    procedure Btn_Ap_7Click(Sender: TObject);
    procedure Btn_Ok_7Click(Sender: TObject);
    procedure tbs_pedidosShow(Sender: TObject);
    procedure Btn_Ap_8Click(Sender: TObject);
    procedure Btn_Ok_8Click(Sender: TObject);
    procedure Btn_Cn_8Click(Sender: TObject);
    procedure Btn_Ok_9Click(Sender: TObject);
    procedure Btn_Ap_9Click(Sender: TObject);
    procedure Btn_Cn_10Click(Sender: TObject);
    procedure Sb_ProdutoClick(Sender: TObject);
    procedure pg_pedidosChange(Sender: TObject);
    procedure Btn_Ok_12Click(Sender: TObject);
    procedure Btn_AP_12Click(Sender: TObject);
    procedure Tbs_BalancaShow(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure btnDesconectarClick(Sender: TObject);
    procedure btnLerPesoClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Sb_BuffetClick(Sender: TObject);
    procedure Btn_Cn_1Click(Sender: TObject);
    procedure Sb_Ap_10Click(Sender: TObject);
    procedure Sb_OK_10Click(Sender: TObject);
    procedure Sb_Cn_10Click(Sender: TObject);
    procedure tbs_DespachoShow(Sender: TObject);
    procedure Chbx_Ctrl_separacaoClick(Sender: TObject);
    procedure E_Ctrl_Cpa_Valor_TotalExit(Sender: TObject);
    procedure Btn_Ok_11Click(Sender: TObject);
    procedure Btn_Cn_11Click(Sender: TObject);
    procedure Btn_Ap_11Click(Sender: TObject);
    procedure TabSheet7Show(Sender: TObject);
    procedure btn_ap_13Click(Sender: TObject);
    procedure btn_ok_13Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure tbsTEFShow(Sender: TObject);
    procedure Chb_Visualiza_CupomClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Rb_Bal_PrecoClick(Sender: TObject);
    procedure Rb_Bal_PesoClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure tbs_estoqueShow(Sender: TObject);
    procedure chbx_Ctrl_despachoClick(Sender: TObject);
  private
    { Private declarations }
    GeralSistema : TControllerGeral;
    procedure ListaImpressoras;
    procedure ListaBalanca;
  public
    { Public declarations }
    It_Conectado : Integer;
    procedure Pc_Abre_Aba_Geral;
    procedure Pc_Grava_Aba_Geral;
    procedure Pc_Abre_Aba_Tributos;
    procedure Pc_Grava_Aba_Tributos;

    function ValidaAbaFinanceiro:boolean;
    procedure Pc_Abre_Aba_Financeiro;
    procedure Pc_Grava_Aba_Financeiro;
    procedure Pc_Abre_Aba_Os;
    procedure Pc_Grava_Aba_OS;
    procedure Pc_Abre_Aba_Impressao;
    procedure Pc_Grava_Aba_Impressao;
    procedure Pc_Abre_Aba_Produtos;
    function Fc_Valida_Aba_Produtos():Boolean;
    procedure Pc_Grava_Aba_Produtos;

    procedure Pc_Abre_Aba_Estoque;
    function Fc_Valida_Aba_Estoque : Boolean;
    procedure Pc_Grava_Aba_Estoque;

    procedure Pc_Abre_Aba_Pessoal;
    procedure Pc_Grava_Aba_Pessoal;
    procedure Pc_Abre_Aba_Comissao;
    procedure Pc_Grava_Aba_Comissao;
    procedure Pc_Grava_Aba_Controle_Venda;
    procedure Pc_Abre_Aba_Controle_Venda;
    procedure Pc_Grava_Aba_Controle_Compra;
    procedure Pc_Abre_Aba_Controle_Compra;
    procedure Pc_Grava_Aba_Controle_Frente;
    procedure Pc_Abre_Aba_Controle_Frente;

    procedure Pc_Grava_Aba_Controle_Pizzaria;
    procedure Pc_Abre_Aba_Controle_Pizzaria;


    procedure Pc_Grava_Geral_Pedido;
    procedure Pc_Abre_Aba_Geral_Pedido;
    procedure Pc_Grava_Aba_Balanca;
    procedure Pc_Abre_Aba_Balanca;
    function Valida_Grava_Aba_Despacho:Boolean;
    procedure Pc_Grava_Aba_Despacho;
    procedure Pc_Abre_Aba_Despacho;

    procedure Pc_Grava_Aba_TEF;
    procedure Pc_Abre_Aba_TEF;


    procedure Pc_ConsultaRegistroProdutoAvulso;
  end;

var
  Fr_Configuracao: TFr_Configuracao;

implementation

uses     Un_DM, UN_MSG, UN_Sistema, un_principal, env, Un_Produtos, Un_Regra_Negocio, Un_Fc_Sored_Procedures, RN_Permissao, RN_Empresa, RN_NotaFiscalEletronica3X, un_mp2032, ControllerBoletoBancario, sea_product;

{$R *.dfm}


procedure TFr_Configuracao.Pc_Abre_Aba_Geral;
Begin
  //Controle de Dados Gerais
  Rb_Aniv_Dia.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_DIA','S') = 'S';
  Rb_Aniv_Semana.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_SEMANA','S') = 'S';
  Rb_Aniv_Mes.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_MES','S') = 'S';
  E_Aniv_DataIni.Text := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_INI','0');
  E_Aniv_DataFim.Text := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_FIM','0');
  ChBx_Aniver.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_TELA','S') = 'S';
  ed_qtd_nfe.Text:= Fc_Tb_Geral('L','GRL_G_NUM_ITEN_NFE', ed_qtd_nfe.Text);
  ed_vl_cupom.Text:= Fc_Tb_Geral('L','GRL_G_VL_CUPOM', ed_vl_cupom.Text);
  E_Atualizador.Text := Fc_Tb_Geral('L','GRL_G_LIVEUPDATE',E_Atualizador.Text);

  Chbx_dt_Padrao.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Chbx_Conserto.Checked := (Fc_Tb_Geral('L','GRL_G_TAR_CONSERTO','S') = 'S');

  chk_cliente_cpf.Checked :=Fc_Tb_Geral('L','GRL_G_VALIDA_CPF_CNPJ','') = 'S';
  Chbx_Devolucao.Checked := (Fc_Tb_Geral('L','GRL_G_TAR_DEVOLUCAO','N') = 'S');
  Chbx_Troca.Checked := (Fc_Tb_Geral('L','GRL_G_TAR_TROCA','N') = 'S');
  chbx_email_auto.Checked := (Fc_Tb_Geral('L','GRL_G_EMAIL_AUTOMATICO','S') = 'S');
  ChBx_EmailSistemaNfe.Checked := (Fc_Tb_Geral('L','GRL_G_EMAIL_SISTEMANFE','S') = 'S');
  Chbx_DevolucaoClick(Self);
  E_Cd_Produto.Text := Fc_Tb_Geral('L','GRL_G_PRO_CD_DEVOLUCAO','');
  IF  Fc_Tb_Geral('L','GRL_G_PRED_PESSOA','') = 'F' THEN
    rg_pessoaPredominante.ItemIndex :=0
  ELSE
    rg_pessoaPredominante.ItemIndex :=1;

  IF  Fc_Tb_Geral('L','GRL_G_PRED_CLIENTE','') = 'C' THEN
    rg_clientePredominante.ItemIndex :=0
  ELSE
    rg_ClientePredominante.ItemIndex :=1;

  chbx_Pesq_CodBarra.Checked:= (Fc_Tb_Geral('L','GRL_G_PES_COD_BARRA','S')='S');
  //Tipo de plano de contas
  ChBx_MostraEstabelecimento.Checked := (Fc_Tb_Geral('L','GRL_G_MOSTRAESTABELECIMENTO','S') = 'S');
  //Decreto 10.835/2014 - MVA Reduzida
  Chbx_Decreto108352014.Checked := (Fc_Tb_Geral('L','GRL_G_DECRETO108352014','N') = 'S');
  Chbx_MultiEmpresaMostraTodas.Checked  := Fc_Tb_Geral('L','GRL_G_MULTIEMP_MOSTRATODAS','N') = 'S';
  Chbx_MultiEmpresaEscolheNFe.Checked  := Fc_Tb_Geral('L','GRL_G_MULTIEMP_ESCOLHENFE','N') = 'S';
  Chbx_Cli_Ctrl_Email.Checked := (Fc_Tb_Geral('L','GRL_G_CLI_CTRL_EMAIL','N')= 'S');
  Chbx_Cli_Ctrl_Fone.Checked  := (Fc_Tb_Geral('L','GRL_G_CLI_CTRL_FONE','N')= 'S');
  ChBx_ImpostoAproximado.checked  := ( Fc_Tb_Geral('L','GRL_G_IMPOSTO_APROX','S') = 'S');
  ChBx_Vend_List_cliente.checked := (Fc_Tb_Geral('L','GRL_G_VEND_LIST_CLIENTE','S') = 'S');
  E_Terminal.Text := Fc_Tb_Geral('L','GRL_G_TERMINAL','1');
  Chbx_PAF_NFC_E.checked  := ( Fc_Tb_Geral('L','GRL_G_PAF_NFCE','N') = 'S');
  chbx_enable_notification.checked  := ( Fc_Tb_Geral('L','GRL_G_NOTIFICATION','N') = 'S');

  chbx_Reforma_tributaria.checked := ( Fc_Tb_Geral('L','GRL_G_REF_TRIBUTARIA','N') = 'S');
end;

procedure TFr_Configuracao.Pc_Grava_Aba_Geral;
Begin
 //Controle de Dados Gerais
  if Rb_Aniv_Dia.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_DIA','S') else Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_DIA','N');
  if Rb_Aniv_Semana.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_SEMANA','S') else Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_SEMANA','N');
  if Rb_Aniv_Mes.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_MES','S') else  Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_MES','N');
  Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_INI', E_Aniv_DataIni.text);
  Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_FIM',E_Aniv_DataFim.text);
  if ChBx_Aniver.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_TELA','S') else Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_TELA','N');
  Fc_Tb_Geral('G','GRL_G_NUM_ITEN_NFE', ed_qtd_nfe.Text);
  Fc_Tb_Geral('G','GRL_G_VL_CUPOM', ed_vl_cupom.Text);
  Fc_Tb_Geral('G','GRL_G_LIVEUPDATE',E_Atualizador.Text);

  if Chbx_dt_Padrao.Checked   then Fc_Tb_Geral('G','GRL_G_DT_PESQUISA','S') else Fc_Tb_Geral('G','GRL_G_DT_PESQUISA','N');
  if Chbx_Conserto.Checked   then Fc_Tb_Geral('G','GRL_G_TAR_CONSERTO','S') else Fc_Tb_Geral('G','GRL_G_TAR_CONSERTO','N');

  if chk_cliente_cpf.Checked = true then  Fc_Tb_Geral('G','GRL_G_VALIDA_CPF_CNPJ','S') else Fc_Tb_Geral('G','GRL_G_VALIDA_CPF_CNPJ','N');
  if Chbx_Devolucao.Checked   then Fc_Tb_Geral('G','GRL_G_TAR_DEVOLUCAO','S') else Fc_Tb_Geral('G','GRL_G_TAR_DEVOLUCAO','N');
  if Chbx_Troca.Checked   then Fc_Tb_Geral('G','GRL_G_TAR_TROCA','S') else Fc_Tb_Geral('G','GRL_G_TAR_TROCA','N');  
  IF chbx_email_auto.Checked THEN  Fc_Tb_Geral('G','GRL_G_EMAIL_AUTOMATICO','S') ELSE Fc_Tb_Geral('G','GRL_G_EMAIL_AUTOMATICO','N');
  IF ChBx_EmailSistemaNfe.Checked THEN  Fc_Tb_Geral('G','GRL_G_EMAIL_SISTEMANFE','S') ELSE Fc_Tb_Geral('G','GRL_G_EMAIL_SISTEMANFE','N');

  Fc_Tb_Geral('G','GRL_G_PRO_CD_DEVOLUCAO',E_Cd_Produto.Text);
  if rg_pessoaPredominante.ItemIndex = 0 then Fc_Tb_Geral('G','GRL_G_PRED_PESSOA','F') ELSE Fc_Tb_Geral('G','GRL_G_PRED_PESSOA','J');
  if rg_ClientePredominante.ItemIndex = 0 then Fc_Tb_Geral('G','GRL_G_PRED_CLIENTE','C') ELSE Fc_Tb_Geral('G','GRL_G_PRED_CLIENTE','R');
  if chbx_Pesq_CodBarra.Checked   then Fc_Tb_Geral('G','GRL_G_PES_COD_BARRA','S') else Fc_Tb_Geral('G','GRL_G_PES_COD_BARRA','N');


  if ChBx_MostraEstabelecimento.Checked then Fc_Tb_Geral('G','GRL_G_MOSTRAESTABELECIMENTO','S') else Fc_Tb_Geral('G','GRL_G_MOSTRAESTABELECIMENTO','N');

  if Chbx_Decreto108352014.Checked then Fc_Tb_Geral('G','GRL_G_DECRETO108352014','S') else Fc_Tb_Geral('G','GRL_G_DECRETO108352014','N');

  if Chbx_MultiEmpresaMostraTodas.Checked then Fc_Tb_Geral('G','GRL_G_MULTIEMP_MOSTRATODAS','S') else Fc_Tb_Geral('G','GRL_G_MULTIEMP_MOSTRATODAS','N');
  if Chbx_MultiEmpresaEscolheNFe.Checked then Fc_Tb_Geral('G','GRL_G_MULTIEMP_ESCOLHENFE','S') else Fc_Tb_Geral('G','GRL_G_MULTIEMP_ESCOLHENFE','N');

  if Chbx_Cli_Ctrl_Email.Checked then Fc_Tb_Geral('G','GRL_G_CLI_CTRL_EMAIL','S') else Fc_Tb_Geral('G','GRL_G_CLI_CTRL_EMAIL','N');
  if Chbx_Cli_Ctrl_Fone.Checked then Fc_Tb_Geral('G','GRL_G_CLI_CTRL_FONE','S') else Fc_Tb_Geral('G','GRL_G_CLI_CTRL_FONE','N');
  if ChBx_ImpostoAproximado.checked then  Fc_Tb_Geral('G','GRL_G_IMPOSTO_APROX','S') else Fc_Tb_Geral('G','GRL_G_IMPOSTO_APROX','N');

  if ChBx_Vend_List_cliente.checked then  Fc_Tb_Geral('G','GRL_G_VEND_LIST_CLIENTE','S') else Fc_Tb_Geral('G','GRL_G_VEND_LIST_CLIENTE','N');

  Fc_Tb_Geral('G','GRL_G_TERMINAL',IntToStr(StrToIntDef(E_Terminal.Text,1)));

  if Chbx_PAF_NFC_E.checked then  Fc_Tb_Geral('G','GRL_G_PAF_NFCE','S') else Fc_Tb_Geral('G','GRL_G_PAF_NFCE','N');

  if chbx_enable_notification.checked then  Fc_Tb_Geral('G','GRL_G_NOTIFICATION','S') else Fc_Tb_Geral('G','GRL_G_NOTIFICATION','N');

  if chbx_Reforma_tributaria.checked then  Fc_Tb_Geral('G','GRL_G_REF_TRIBUTARIA','S') else Fc_Tb_Geral('G','GRL_G_REF_TRIBUTARIA','N');
  Gb_Reforma_Tributaria := chbx_Reforma_tributaria.checked;
end;

procedure TFr_Configuracao.Pc_Abre_Aba_TEF;
begin
  //Local
  ChBx_TEF_Ativa_Local.Checked  := ( Fc_Aq_Geral('L','TEF','TEF_LC_ATIVO','S') = 'S');
  //Global - ID Loja
  E_TEF_ID_Loja.Text            := Fc_Tb_Geral('L','TEF_ID_LOJA','0');
  //Global - IP Servidor
  E_TEF_IP.Text                 := Fc_Tb_Geral('L','TEF_IP_SERVIDOR','0');
  //Local
  E_TEF_ID_Terminal.Text        := Fc_Aq_Geral('L','TEF','TEF_ID_TERMINAL','0');
  //Local
  E_TEF_Desc_Terminal.Text      := Fc_Aq_Geral('L','TEF','TEF_DESC_TERMINAL','0');
  //Local - Porta PinPAd
  E_TEF_Porta_PinPad.Text       := Fc_Aq_Geral('L','TEF','TEF_PORTA_PINPAD','0');
  //FAz a quebra de Linnha no comprovante para deixar mais legível
  Chbx_TEF_Comp_Quebra_Linha.Checked := ( Fc_Aq_Geral('L','TEF','TEF_CP_QBRA_LINHA','S') = 'S' ) ;
  //Mostra o Usuario do CAixa na 1º Via
  Chbx_TEF_Comp_Mostra_Usuario.Checked  := ( Fc_Aq_Geral('L','TEF','TEF_CP_MOSTRA_USUARIO','S') = 'S');
  //Envia a imagem do QrCode para o PInPad
  Chbx_Send_Qr_code_Pinpad.Checked := ( Fc_Aq_Geral('L','TEF','TEF_QRCODE_PIX_PINPAD','N') = 'S');
end;

procedure TFr_Configuracao.Pc_Grava_Aba_TEF;
begin
  //Local
  if ChBx_TEF_Ativa_Local.Checked then Fc_Aq_Geral('G','TEF','TEF_LC_ATIVO','S') else Fc_Aq_Geral('G','TEF','TEF_LC_ATIVO','N');
  //Global - ID Loja
  Fc_Tb_Geral('G','TEF_ID_LOJA',E_TEF_ID_Loja.Text);
  //Global - IP Servidor
  Fc_Tb_Geral('G','TEF_IP_SERVIDOR',E_TEF_IP.Text);
  //Local
  Fc_Aq_Geral('G','TEF','TEF_ID_TERMINAL',E_TEF_ID_Terminal.Text);
  //Local
  Fc_Aq_Geral('G','TEF','TEF_DESC_TERMINAL',E_TEF_Desc_Terminal.Text);
  //Porta PinPAd
  Fc_Aq_Geral('G','TEF','TEF_PORTA_PINPAD',E_TEF_Porta_PinPad.Text);
  //FAz a quebra de Linnha no comprovante para deixar mais legível
  if Chbx_TEF_Comp_Quebra_Linha.Checked then Fc_Aq_Geral('G','TEF','TEF_CP_QBRA_LINHA','S') else Fc_Aq_Geral('G','TEF','TEF_CP_QBRA_LINHA','N');
  //Mostra o Usuario do CAixa na 1º Via
  if Chbx_TEF_Comp_Mostra_Usuario.Checked then Fc_Aq_Geral('G','TEF','TEF_CP_MOSTRA_USUARIO','S') else Fc_Aq_Geral('G','TEF','TEF_CP_MOSTRA_USUARIO','N');
  if Chbx_Send_Qr_code_Pinpad.Checked then Fc_Aq_Geral('G','TEF','TEF_QRCODE_PIX_PINPAD','S') else Fc_Aq_Geral('G','TEF','TEF_QRCODE_PIX_PINPAD','N');

end;

procedure TFr_Configuracao.Pc_Abre_Aba_Tributos;
BEgin
  E_Tx_Cr_ICMS.Text := Fc_Tb_Geral('L','GRL_G_AQ_CRED_ICMS','');
  E_Tx_Aprox_Mun.Text := Fc_Tb_Geral('L','GRL_G_AQ_APROX_MUN','');
end;




procedure TFr_Configuracao.Pc_Grava_Aba_Tributos;
Begin
  Fc_Tb_Geral('G','GRL_G_AQ_CRED_ICMS',E_Tx_Cr_ICMS.Text);
  Fc_Tb_Geral('G','GRL_G_AQ_APROX_MUN',E_Tx_Aprox_Mun.Text);
end;


procedure TFr_Configuracao.Pc_Abre_Aba_Financeiro;
Begin
  //Controle Financeiro
  E_Multa.Text             := Fc_Tb_Geral('L','FIN_G_MULTA',E_Multa.Text);
  E_Juros.Text             := Fc_Tb_Geral('L','FIN_G_JUROS',E_Juros.Text);
  E_Carencia.Text          := Fc_Tb_Geral('L','FIN_G_CARENCIA',E_Carencia.Text);



  Chbx_Ativa_Cobranca.Checked  := (Fc_Tb_Geral('L','FIN_G_ATIVAR','') = 'S');
  Chbx_Cheque_Devolvido.Checked  := (Fc_Tb_Geral('L','FIN_G_INF_CHQ_DEV','') = 'S');
  Chbx_Cheque_PreDatado.Checked  := (Fc_Tb_Geral('L','FIN_G_INF_CHQ_PRE','') = 'S');
  Chbx_Saldo_Devedor.Checked  := (Fc_Tb_Geral('L','FIN_G_INF_SALDO_DEV','') = 'S');
  Chbx_Credito.Checked := (Fc_Tb_Geral('L','FIN_G_ATIVA_CREDITO','') = 'S');
  ch_cliente_saldo.Checked :=Fc_Tb_Geral('L','FIN_G_BLOQ_LIMITE','') = 'S';
  chk_Saldo_atraso.Checked := Fc_Tb_Geral('L','FIN_G_BLOQ_ATRASO','') = 'S';
  Chbx_Val_Ppagto_CR.Checked := (Fc_Tb_Geral('L','FIN_VAL_PAGTO_CR','S') = 'S');
  Chbx_Val_Ppagto_CP.Checked := (Fc_Tb_Geral('L','FIN_VAL_PAGTO_CP','S') = 'S');
  ChBx_LiberaDigitacaoBanco.Checked := (Fc_Tb_Geral('L','FIN_LIB_DIG_BANCO','N') = 'S');
  //Liberar a Ficha Financeira
  Chbx_Fin_FichaCadastral.Checked := (Fc_Tb_Geral('L','FIN_FICHA_CADASTRAL','N') = 'S');
  //Liberar a aba de Referencia
  chbx_Fin_Referencia.Checked := (Fc_Tb_Geral('L','FIN_ABA_REFERENCIA','N') = 'S');
  Chbx_Fin_BaixaAutomatica.Checked  := ( Fc_Tb_Geral('L','FIN_FAT_BAIXA_AUTO','S') = 'S');
  //Mostra tela do Financeiro na tela de venda
  ChBx_MostraTelaFinanceiro.Checked := ( Fc_Tb_Geral('L','FIN_MOSTRA_FATURAMENTO','S') = 'S');
  //Obriga prenchimento dos dados do cartão no faturamento
  ChBx_DadosCartao.Checked := Fc_Tb_Geral('L','FIN_OB_INFO_CARTAO_FATURAMENTO','N') = 'S';
  //Obriga prenchimento dos dados do Cheque no faturamento
  ChBx_DadosCheque.Checked := Fc_Tb_Geral('L','FIN_OB_INFO_CHEQUE_FATURAMENTO','N') = 'S';
  //Utilização do TEF
  ChBx_TEF.Checked := ( Fc_Tb_Geral('L','FIN_G_TEF','S') = 'S');
  //Controla a Baixa do Contas a Pagar para documentos Autorizados
  Chbx_Autorizar_Contas_Pagar.Checked  := ( Fc_Tb_Geral('L','FIN_CP_AUTO_BAIXA','N') = 'S');

  ChBx_Fat_Vda_Auto_Cta_Ger.Checked  := ( Fc_Tb_Geral('L','FIN_SET_CTA_GER_AUTO','S') = 'S');

  ChBx_Fat_Vda_Auto_Boleto_impressao.Checked  := ( Fc_Tb_Geral('L','FIN_FAT_GER_AUTO_BOLETO','N') = 'S');

  ChBx_EnvioBoletoEmail.Checked := ( Fc_Tb_Geral('L','FIN_BOL_ENVIA_EMAIL','S') = 'S');

end;

procedure TFr_Configuracao.Pc_Grava_Aba_Financeiro;
Begin
  //Controle Financeiro
  Fc_Tb_Geral('G','FIN_G_MULTA',E_Multa.Text);
  Fc_Tb_Geral('G','FIN_G_JUROS',E_Juros.Text);
  Fc_Tb_Geral('G','FIN_G_CARENCIA',E_Carencia.Text);

  if Chbx_Ativa_Cobranca.Checked       then Fc_Tb_Geral('G','FIN_G_ATIVAR','S') else Fc_Tb_Geral('G','FIN_G_ATIVAR','N');
  if Chbx_Cheque_Devolvido.Checked     then Fc_Tb_Geral('G','FIN_G_INF_CHQ_DEV','S')   else Fc_Tb_Geral('G','FIN_G_INF_CHQ_DEV','N');
  if Chbx_Cheque_PreDatado.Checked     then Fc_Tb_Geral('G','FIN_G_INF_CHQ_PRE','S')   else Fc_Tb_Geral('G','FIN_G_INF_CHQ_PRE', 'N');
  if Chbx_Saldo_Devedor.Checked        then Fc_Tb_Geral('G','FIN_G_INF_SALDO_DEV','S')     else Fc_Tb_Geral('G','FIN_G_INF_SALDO_DEV','N');
  if Chbx_Credito.Checked              then Fc_Tb_Geral('G','FIN_G_ATIVA_CREDITO','S') else Fc_Tb_Geral('G','FIN_G_ATIVA_CREDITO','N');
  if ch_cliente_saldo.Checked          then Fc_Tb_Geral('G','FIN_G_BLOQ_LIMITE','S') else  Fc_Tb_Geral('G','FIN_G_BLOQ_LIMITE','N');
  if chk_Saldo_atraso.Checked          then Fc_Tb_Geral('G','FIN_G_BLOQ_ATRASO ','S') else Fc_Tb_Geral('G','FIN_G_BLOQ_ATRASO ','N');
  IF Chbx_Val_Ppagto_CR.Checked        then Fc_Tb_Geral('G','FIN_VAL_PAGTO_CR','S') else Fc_Tb_Geral('G','FIN_VAL_PAGTO_CR','N');
  IF Chbx_Val_Ppagto_CP.Checked        then Fc_Tb_Geral('G','FIN_VAL_PAGTO_CP','S') else Fc_Tb_Geral('G','FIN_VAL_PAGTO_CP','N');
  IF ChBx_LiberaDigitacaoBanco.Checked then Fc_Tb_Geral('G','FIN_LIB_DIG_BANCO','S') else Fc_Tb_Geral('G','FIN_LIB_DIG_BANCO','N');
  if Chbx_Fin_BaixaAutomatica.Checked  then Fc_Tb_Geral('G','FIN_FAT_BAIXA_AUTO','S') else Fc_Tb_Geral('G','FIN_FAT_BAIXA_AUTO','N');

  //Liberar a Ficha Financeira
  IF Chbx_Fin_FichaCadastral.Checked then Fc_Tb_Geral('G','FIN_FICHA_CADASTRAL','S') else Fc_Tb_Geral('G','FIN_FICHA_CADASTRAL','N');

  //Liberar a aba de Referencia
  IF chbx_Fin_Referencia.Checked then Fc_Tb_Geral('G','FIN_ABA_REFERENCIA','S') else Fc_Tb_Geral('G','FIN_ABA_REFERENCIA','N');

  //Mostra tela do Financeiro na tela de venda
  IF ChBx_MostraTelaFinanceiro.Checked then Fc_Tb_Geral('G','FIN_MOSTRA_FATURAMENTO','S') else Fc_Tb_Geral('G','FIN_MOSTRA_FATURAMENTO','N');

  //Obriga prenchimento dos dados do cartão no faturamento
  IF ChBx_DadosCartao.Checked then Fc_Tb_Geral('G','FIN_OB_INFO_CARTAO_FATURAMENTO','S') else Fc_Tb_Geral('G','FIN_OB_INFO_CARTAO_FATURAMENTO','N');

  //Obriga prenchimento dos dados do Cheque no faturamento
  IF ChBx_DadosCheque.Checked then Fc_Tb_Geral('G','FIN_OB_INFO_CHEQUE_FATURAMENTO','S') else Fc_Tb_Geral('G','FIN_OB_INFO_CHEQUE_FATURAMENTO','N');

  //Utilização do TEF
  if ChBx_TEF.Checked then Fc_Tb_Geral('G','FIN_G_TEF','S') else Fc_Tb_Geral('G','FIN_G_TEF','N');

  //Controla a Baixa do Contas a Pagar para documentos Autorizados
  IF Chbx_Autorizar_Contas_Pagar.Checked then Fc_Tb_Geral('G','FIN_CP_AUTO_BAIXA','S') else Fc_Tb_Geral('G','FIN_CP_AUTO_BAIXA','N');

  if ChBx_Fat_Vda_Auto_Cta_Ger.Checked then Fc_Tb_Geral('G','FIN_SET_CTA_GER_AUTO','S') else Fc_Tb_Geral('G','FIN_SET_CTA_GER_AUTO','N');

  if ChBx_Fat_Vda_Auto_Boleto_impressao.Checked  then
    Fc_Tb_Geral('G','FIN_FAT_GER_AUTO_BOLETO','S')
  else
    Fc_Tb_Geral('G','FIN_FAT_GER_AUTO_BOLETO','N');

  if ChBx_EnvioBoletoEmail.Checked  then
    Fc_Tb_Geral('G','FIN_BOL_ENVIA_EMAIL','S')
  else
    Fc_Tb_Geral('G','FIN_BOL_ENVIA_EMAIL','N');

end;

procedure TFr_Configuracao.Pc_Abre_Aba_Os;
Var
  I :Integer;
  LcModulo :String;
Begin
  //Controle de Ordem de Serviços
  ChBx_Servicos.Checked := (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S');
  LcModulo := Fc_Tb_Geral('L','OSR_G_TIPO_MODULO','AUTO CENTER');
  for I := 0 to Cb_modulo_servico.Items.Count -1 do
  Begin
    if (Cb_modulo_servico.Items[I] = LcModulo) then
    break;
  End;
  Cb_modulo_servico.ItemIndex := I;

  ChBx_Veiculo.Checked := (Fc_Tb_Geral('L','OSR_G_PREENCHE_VEI','S') = 'S');
  Chbx_Tecnico.Checked := (Fc_Tb_Geral('L','OSR_G_PREENCHE_TEC','S') = 'S');
  ChBx_Placa.Checked := (Fc_Aq_Geral('L','ORDEM DE SERVICO','OSR_P_MOSTRA_PLACA','N') = 'S');
  Chbx_Instalador_vendedor.Checked := (Fc_Aq_Geral('L','ORDEM DE SERVICO','OSR_P_INSTALA_VENDE','N') = 'S');
  ChBx_NovaVersaoOS.Checked := (Fc_Tb_Geral('L','OSR_G_NOVA_OS','S') = 'S');
  Cb_ImpOrdemServico.ItemIndex := StrToIntDef(Fc_Tb_Geral('L','OSR_G_TIPOIMPRESSAO','0'),0);

  //Auto Center
  ChBx_SistemaAndroid.Checked  := (Fc_Tb_Geral('L','OSR_G_TABLETANDROID','S') = 'S');
  ChBx_Obs_Veiculo_NF.Checked  := (Fc_Tb_Geral('L','OSR_G_OBS_VEICULO_NF','S') = 'S');


  //Sobre nota Fiscal Eletronica Conjugada
  Chbx_Nfse_Conjugada.Checked := ( Fc_Tb_Geral('L','OSR_G_NFSE_CONJ','N') = 'S');


  E_Nfse_Cd_LC116.Text := Fc_Tb_Geral('L','OSR_G_NFSE_CL116','');


end;

procedure TFr_Configuracao.Pc_Grava_Aba_OS;
Begin
  //Controle de Ordem de Serviços
  if ChBx_Servicos.Checked   then Fc_Tb_Geral('G','OSR_G_ATIVAR','S') else Fc_Tb_Geral('G','OSR_G_ATIVAR','N');
  case Cb_modulo_servico.ItemIndex of
    0:Fc_Tb_Geral('G','OSR_G_TIPO_MODULO','<<SEM MODULO>>');
    1:Fc_Tb_Geral('G','OSR_G_TIPO_MODULO','AUTO CENTER');
    2:Fc_Tb_Geral('G','OSR_G_TIPO_MODULO','EXINTORES');
    3:Fc_Tb_Geral('G','OSR_G_TIPO_MODULO','EQUIPAMENTOS ELETRÔNICOS');
    4:Fc_Tb_Geral('G','OSR_G_TIPO_MODULO','PET SHOP');
    5:Fc_Tb_Geral('G','OSR_G_TIPO_MODULO','MOVELEIRO');
    6:Fc_Tb_Geral('G','OSR_G_TIPO_MODULO','GRÁFICA');
  end;


  if ChBx_Veiculo.Checked then Fc_Tb_Geral('G','OSR_G_PREENCHE_VEI','S') else Fc_Tb_Geral('G','OSR_G_PREENCHE_VEI','N');
  if Chbx_Tecnico.Checked   then Fc_Tb_Geral('G','OSR_G_PREENCHE_TEC','S') else Fc_Tb_Geral('G','OSR_G_PREENCHE_TEC','N');
  if ChBx_Placa.Checked   then Fc_Aq_Geral('G','ORDEM DE SERVICO','OSR_P_MOSTRA_PLACA','S') else Fc_Aq_Geral('G','ORDEM DE SERVICO','OSR_P_MOSTRA_PLACA','N');
  if Chbx_Instalador_vendedor.Checked then Fc_Aq_Geral('G','ORDEM DE SERVICO','OSR_P_INSTALA_VENDE','S')  else Fc_Aq_Geral('G','ORDEM DE SERVICO','OSR_P_INSTALA_VENDE','N');

  if ChBx_NovaVersaoOS.Checked then Fc_tb_Geral('G','OSR_G_NOVA_OS','S')  else Fc_tb_Geral('G','OSR_G_NOVA_OS','N');
  Fc_Tb_Geral('G','OSR_G_TIPOIMPRESSAO',IntToStr(Cb_ImpOrdemServico.ItemIndex));

  Fc_Tb_Geral('G','OSR_G_OS_SEM_SERVICO','N');

  if ChBx_SistemaAndroid.Checked   then Fc_Tb_Geral('G','OSR_G_TABLETANDROID','S') else Fc_Tb_Geral('G','OSR_G_TABLETANDROID','N');
  if ChBx_Obs_Veiculo_NF.Checked   then Fc_Tb_Geral('G','OSR_G_OBS_VEICULO_NF','S') else Fc_Tb_Geral('G','OSR_G_OBS_VEICULO_NF','N');

  //Sobre nota Fiscal Eletronica Conjugada
  Pc_AtivaEstabelecimento;
  if Chbx_Nfse_Conjugada.Checked then
    Begin
    if (Trim(DM.Qr_Estabelecimento.FieldByname('EMP_INSC_MUN').AsString) <> '') then
      Begin
      Fc_Tb_Geral('G','OSR_G_NFSE_CONJ','S');
      Fc_Tb_Geral('G','OSR_G_NFSE_CL116',E_Nfse_Cd_LC116.Text);
      end
    else
      Begin
      Chbx_Nfse_Conjugada.Checked := False;
      Fc_Tb_Geral('G','OSR_G_NFSE_CONJ','N');
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Não é possivel ativar a Nf-e Conjugada.'+EOLN+
                     'Não foi informada a Inscrição Municipal.'+EOLN+
                     'Veja o Cadastro da Minha Empresa'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      end;
    end
  else
    Begin
    Fc_Tb_Geral('G','OSR_G_NFSE_CONJ','N');
    end;

end;

procedure TFr_Configuracao.Pc_Abre_Aba_Impressao;
Begin
  //Controle de impressão
  ChBx_Vis_Relatorio.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','s') = 'S');
  ChBx_Cupom.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_TP_CUPOM_FAT','') = 'S');
  Chb_ImpSalto.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S');
  Chb_ImpCondensa.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_CONDENSA','S') = 'S');
  E_PortaImpressao.Text := Fc_Aq_Geral('L','IMPRESSAO','PORTA',E_PortaImpressao.Text);
  E_SaltoImpressao.Text :=Fc_Aq_Geral('L','IMPRESSAO','SALTO','0');
  E_PortaImpZebra.Text := Fc_Aq_Geral('L','IMPRESSAO','PORTAZEBRA',E_PortaImpZebra.Text);

  //modelo de impressao estilo Cupom
  Cb_Cpm_TipoImpressora.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_P_MOD_IMPRESSAO', ''),0)-1;

  //modelo de impressao estilo Cupom
  E_Cpm_Modelo.ItemIndex := StrTOIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_P_MOD_IMPRESSAO','1'),1) -1;
  //Numero de vias
  E_Cpm_Nr_Vias.Text := Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_VIAS','X');
  //Tipo de Impressora
  Cb_Cpm_TipoImpressora.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_TIPO_IMPRESSORA', '1'),1) -1;
  //Numero de Colunas
  E_Cpm_Colunas.Text := Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', '');
  //Tamanho da Fonte
  Rg_Rdp_Fte_Padrao.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_RPD_FTE_PADRAO', '1'),1);
  E_LarguraBobina.Text  := Fc_Aq_Geral('L','NFCE','LARG_BOB_NOVO', '80');
  E_MarEsqBobina.Text   := Fc_Aq_Geral('L','NFCE','MARESQ_BOB_NOVO','0');
  E_MarDirBobina.Text   := Fc_Aq_Geral('L','NFCE','MARDIR_BOB_NOVO','0');

end;

procedure TFr_Configuracao.Pc_Grava_Aba_Impressao;
Begin
  //Controle de impressão
  if ChBx_Vis_Relatorio.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_VISUALIZA','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_VISUALIZA','N');
  if ChBx_Cupom.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_TP_CUPOM_FAT','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_TP_CUPOM_FAT','N');
  if Chb_ImpSalto.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_EJECTA','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_EJECTA','N');
  if Chb_ImpCondensa.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_CONDENSA','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_CONDENSA','N');

  Fc_Aq_Geral('G','IMPRESSAO','PORTA',E_PortaImpressao.Text);
  Fc_Aq_Geral('G','IMPRESSAO','SALTO',E_SaltoImpressao.Text);
  Fc_Aq_Geral('G','IMPRESSAO','PORTAZEBRA',E_PortaImpZebra.Text);

  //modelo de impressao estilo Cupom
  Fc_Aq_Geral('G','CONTROLE DE CUPOM','CPM_P_MOD_IMPRESSAO', IntToStr(E_Cpm_Modelo.ItemIndex + 1));
  //Numero de vias
  Fc_Aq_Geral('G','CONTROLE DE CUPOM','CPM_NR_VIAS',E_Cpm_Nr_Vias.Text);
  //Tipo de Impressora
  Fc_Aq_Geral('G','CONTROLE DE CUPOM','CPM_TIPO_IMPRESSORA', InttoStr(Cb_Cpm_TipoImpressora.ItemIndex + 1));
  //Numero de Colunas
  Fc_Aq_Geral('G','CONTROLE DE CUPOM','CPM_NR_COLUNAS', E_Cpm_Colunas.Text);
  //Tamanho da Fonte
  Fc_Aq_Geral('G','CONTROLE DE CUPOM','CPM_RPD_FTE_PADRAO', IntToStr(Rg_Rdp_Fte_Padrao.ItemIndex));

  Fc_Aq_Geral('G','NFCE','LARG_BOB_NOVO',E_LarguraBobina.Text);
  Fc_Aq_Geral('G','NFCE','MARESQ_BOB_NOVO',E_MarEsqBobina.Text);
  Fc_Aq_Geral('G','NFCE','MARDIR_BOB_NOVO',E_MarDirBobina.Text);
end;

procedure TFr_Configuracao.Pc_Abre_Aba_Produtos;
Begin
  //Controle de Dados DOS PRODUTOS
  Chbx_CodigoExato.Checked := (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S');
  ChBx_Distingue_Produto.Checked := (Fc_Aq_Geral('L','PRODUTO','PRO_P_DISTG_PA_MP','S') = 'S');
  ChBx_Observacao_NFe.Checked := (Fc_Tb_Geral('L','PRO_G_OBS_DESCRIC_NFE','N') = 'S');
  chbx_ProdMultiEmpresa.Checked :=   Fc_Tb_Geral('L','PRO_G_COMPARTILHA','S') ='S';
  chbx_crtl_codFab.Checked   := Fc_Tb_Geral('L','PRO_G_VAL_CODIGOFAB','S') = 'S';
  chbx_lbl_produto.Checked  := Fc_Tb_Geral('L','PRO_G_LABEL_PRO','')='S';
  chbx_aq_comissao.Checked  := Fc_Tb_Geral('L','PRO_VALIDA_AQ_COM','')='S';
  ChBx_DesativaProduto.Checked  := Fc_Tb_Geral('L','PRO_DESATIVA','N')='S';
  chbx_venc_lote.Checked  := Fc_Tb_Geral('L','PRO_VENC_LOTE','')='S';
  //Abas
  ChBx_ABA_Fornecedor.Checked   := (Fc_Tb_Geral('L','PRO_G_ABA_FORNECEDOR','S') = 'S');
  ChBx_ABA_imposto.Checked      := (Fc_Tb_Geral('L','PRO_G_ABA_IMPOSTO','S') = 'S');
  ChBx_ABA_TabeladePrec.Checked := (Fc_Tb_Geral('L','PRO_G_ABA_TABELA','S') = 'S');
  ChBx_ABA_imagem.Checked       := (Fc_Tb_Geral('L','PRO_G_ABA_IMAGEM','S') = 'S');
  ChBx_ABA_instacao.Checked     := (Fc_Tb_Geral('L','PRO_G_ABA_INSTALACAO','S') = 'S');
  ChBx_ABA_estoque.Checked      := (Fc_Tb_Geral('L','PRO_G_ABA_ESTOQUE','S') = 'S');
  ChBx_ABA_composicao.Checked   := (Fc_Tb_Geral('L','PRO_G_ABA_COMPOSICAO','S') = 'S');
  ChBx_ABA_aviamento.Checked    := (Fc_Tb_Geral('L','PRO_G_ABA_INSUMO_PROD','S') = 'S');
  ChBx_ABA_Aplicacao.Checked    := (Fc_Tb_Geral('L','PRO_G_ABA_APLICACAO','S')= 'S');
  ChBx_ABA_Botoes.Checked       := (Fc_Tb_Geral('L','PRO_G_ABA_BOTOES','S')= 'S');
  Chbx_RegistrarAlteraPreco.Checked := (Fc_Tb_Geral('L','PRO_G_PRO_ALTERA','S') = 'S');
  ChBx_ItensPedidoM2.Checked    := ( Fc_Tb_Geral('L','PRO_G_PRO_ITEMPEDME2','S') = 'S');
  ChBx_ItensPedidoMod50.Checked    := ( Fc_Tb_Geral('L','PRO_G_PRO_ITEMPEDMOD50','S') = 'S');

 //Atualizacao preco de venda na compra
  IF Fc_Tb_Geral('L','PRO_G_ATUAL_PRECO_COMPRA','') = 'A' THEN
    Rg_AtualizaPrecoVenda.ItemIndex:=0
  ELSE
  IF Fc_Tb_Geral('L','PRO_G_ATUAL_PRECO_COMPRA','') = 'M' THEN
    Rg_AtualizaPrecoVenda.ItemIndex:=1
  ELSE
  IF Fc_Tb_Geral('L','PRO_G_ATUAL_PRECO_COMPRA','') = 'N' THEN
    Rg_AtualizaPrecoVenda.ItemIndex:=2;

  //Relatorio inventario
  IF Fc_Tb_Geral('L','PRO_G_CUSTO_INVENTARIO','') = 'C' THEN
     rdg_Rel_inv.ItemIndex := 0
  ELSE
     rdg_Rel_inv.ItemIndex := 1;

  //Atualizacao de preco
  IF Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','C') = 'C' THEN
    rdg_Preco_venda.ItemIndex:=0
  else
    rdg_Preco_venda.ItemIndex:=1;

  //Detalhar os dados da Substituição Tributária nos itens da NF-e
  if Fc_Tb_Geral('L','PRO_G_DET_ST_NFE','N') = 'S' then
    ChBx_Detalhar_ST.Checked := True
  else
    ChBx_Detalhar_ST.Checked := False;

  ChBx_CalculoAutoPrecoVenda.Checked := (Fc_Tb_Geral('L','PRO_G_CALCULO_AUTO_PRECOVENDA','S') = 'S');

  //movimento de produto
  E_ProMovimento.Text := Fc_Tb_Geral('L','PRO_P_INATIVIDADE',E_ProMovimento.Text);

  //calculo de margem lucro
  Rd_Calculo_Tipo_1.Checked := (Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','') = '1');
  Rd_Calculo_Tipo_2.Checked := (Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','') = '2');

  E_Cd_Pro_Buffet.Text := Fc_Tb_Geral('L','PRO_G_CD_PRO_BUFFET','');

  Rg_Casas_Venda.ItemIndex := StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_VENDA','0'),0);
  Rg_Casas_Compra.ItemIndex := StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_COMPRA','0'),0);

  chbx_SemBenef.Checked := ( Fc_Tb_Geral('L','PRO_G_SEM_BENEFIC','N') = 'S');

  Chbx_NaoValidaEAN.Checked := ( Fc_Tb_Geral('L','PRO_G_NAO_VALIDA_EAN','N') = 'S');

end;



procedure TFr_Configuracao.Pc_Grava_Aba_Produtos;
Begin
  

 //Controle de Dados Referente aos Produtos
  if Chbx_CodigoExato.Checked   then Fc_Aq_Geral('G','PRODUTO','PRO_P_COD_EXATO','S') else Fc_Aq_Geral('G','PRODUTO','PRO_P_COD_EXATO','N');
  if ChBx_Distingue_Produto.Checked   then Fc_Aq_Geral('G','PRODUTO','PRO_P_DISTG_PA_MP','S') else Fc_Aq_Geral('G','PRODUTO','PRO_P_DISTG_PA_MP','N');
  if ChBx_Observacao_NFe.Checked then Fc_Tb_Geral('G','PRO_G_OBS_DESCRIC_NFE','S') else Fc_Tb_Geral('G','PRO_G_OBS_DESCRIC_NFE','N');
  if chbx_aq_comissao.Checked   then Fc_TB_Geral('G','PRO_VALIDA_AQ_COM','S') else Fc_tb_Geral('G','PRO_VALIDA_AQ_COM','N');
  if ChBx_DesativaProduto.Checked   then Fc_TB_Geral('G','PRO_DESATIVA','S') else Fc_tb_Geral('G','PRO_DESATIVA','N');
  If chbx_venc_lote.Checked then Fc_Tb_Geral('G','PRO_VENC_LOTE','S') ELSE Fc_Tb_Geral('G','PRO_VENC_LOTE','N');



  if chbx_ProdMultiEmpresa.Checked then
    begin
    Fc_Tb_Geral('G','PRO_G_COMPARTILHA','S');
    GB_ProdCompartilha:= true;
    end
  else
    begin
    Fc_Tb_Geral('G','PRO_G_COMPARTILHA','N');
    GB_ProdCompartilha:= False;
    end;

  if chbx_crtl_codFab.Checked then Fc_Tb_Geral('G','PRO_G_VAL_CODIGOFAB','S') else Fc_Tb_Geral('G','PRO_G_VAL_CODIGOFAB','N');
  if chbx_lbl_produto.Checked then Fc_Tb_Geral('G','PRO_G_LABEL_PRO','S') else Fc_Tb_Geral('G','PRO_G_LABEL_PRO','N');

//Abas
  if ChBx_ABA_Fornecedor.Checked then Fc_Tb_Geral('G','PRO_G_ABA_FORNECEDOR','S') else Fc_Tb_Geral('G','PRO_G_ABA_FORNECEDOR','N');
  if ChBx_ABA_imposto.Checked then Fc_Tb_Geral('G','PRO_G_ABA_IMPOSTO','S') else Fc_Tb_Geral('G','PRO_G_ABA_IMPOSTO','N');
  if ChBx_ABA_TabeladePrec.Checked then Fc_Tb_Geral('G','PRO_G_ABA_TABELA','S') else Fc_Tb_Geral('G','PRO_G_ABA_TABELA','N');
  if ChBx_ABA_imagem.Checked then Fc_Tb_Geral('G','PRO_G_ABA_IMAGEM','S') else Fc_Tb_Geral('G','PRO_G_ABA_IMAGEM','N');
  if ChBx_ABA_instacao.Checked then Fc_Tb_Geral('G','PRO_G_ABA_INSTALACAO','S') else Fc_Tb_Geral('G','PRO_G_ABA_INSTALACAO','N');
  if ChBx_ABA_estoque.Checked then Fc_Tb_Geral('G','PRO_G_ABA_ESTOQUE','S') else Fc_Tb_Geral('G','PRO_G_ABA_ESTOQUE','N');
  if ChBx_ABA_composicao.Checked then Fc_Tb_Geral('G','PRO_G_ABA_COMPOSICAO','S') else Fc_Tb_Geral('G','PRO_G_ABA_COMPOSICAO','N');
  if ChBx_ABA_aviamento.Checked then Fc_Tb_Geral('G','PRO_G_ABA_INSUMO_PROD','S') else Fc_Tb_Geral('G','PRO_G_ABA_INSUMO_PROD','N');
  if ChBx_ABA_Aplicacao.Checked then Fc_Tb_Geral('G','PRO_G_ABA_APLICACAO','S') else Fc_Tb_Geral('G','PRO_G_ABA_APLICACAO','N');
  if ChBx_ABA_Botoes.Checked then Fc_Tb_Geral('G','PRO_G_ABA_BOTOES','S') else Fc_Tb_Geral('G','PRO_G_ABA_BOTOES','N');
  if Chbx_RegistrarAlteraPreco.Checked  then Fc_Tb_Geral('G','PRO_G_PRO_ALTERA','S') else Fc_Tb_Geral('G','PRO_G_PRO_ALTERA','N');
  if ChBx_ItensPedidoM2.Checked  then Fc_Tb_Geral('G','PRO_G_PRO_ITEMPEDME2','S') else Fc_Tb_Geral('G','PRO_G_PRO_ITEMPEDME2','N');
  if ChBx_ItensPedidoMod50.Checked  then Fc_Tb_Geral('G','PRO_G_PRO_ITEMPEDMOD50','S') else Fc_Tb_Geral('G','PRO_G_PRO_ITEMPEDMOD50','N');

 //Atualizacao preco na compra
  case Rg_AtualizaPrecoVenda.ItemIndex of
    0:Fc_Tb_Geral('G','PRO_G_ATUAL_PRECO_COMPRA','A');
    1:Fc_Tb_Geral('G','PRO_G_ATUAL_PRECO_COMPRA','M');
    2:Fc_Tb_Geral('G','PRO_G_ATUAL_PRECO_COMPRA','N');
  end;

  //Relatorio inventario
  IF rdg_Rel_inv.ItemIndex = 0 THEN
    Fc_Tb_Geral('G','PRO_G_CUSTO_INVENTARIO','C')
  else
    Fc_Tb_Geral('G','PRO_G_CUSTO_INVENTARIO','R');

  //atualização de preço
  IF rdg_Preco_venda.ItemIndex = 0 THEN
    Fc_Tb_Geral('G','PRO_G_CUSTO_ATUAL_PRECO','C')
  else
    Fc_Tb_Geral('G','PRO_G_CUSTO_ATUAL_PRECO','R');

  if ChBx_CalculoAutoPrecoVenda.Checked then
    Fc_Tb_Geral('G','PRO_G_CALCULO_AUTO_PRECOVENDA','S')
  else
    Fc_Tb_Geral('G','PRO_G_CALCULO_AUTO_PRECOVENDA','N');

  //Detalhar os dados da Substituição Tributária nos itens da NF-e
  if ChBx_Detalhar_ST.Checked then
    Fc_Tb_Geral('G','PRO_G_DET_ST_NFE','S')
  else
    Fc_Tb_Geral('G','PRO_G_DET_ST_NFE','N');
    
//movimento de produto
  Fc_Tb_Geral('G','PRO_P_INATIVIDADE',E_ProMovimento.Text);


//calculo de margem lucro
  if Rd_Calculo_Tipo_1.Checked then
     Fc_Tb_Geral('G','PRO_G_CALC_MRG_LUCRO','1')
  else
  if Rd_Calculo_Tipo_2.Checked then
    Fc_Tb_Geral('G','PRO_G_CALC_MRG_LUCRO','2');

  Fc_Tb_Geral('G','PRO_G_CD_PRO_BUFFET',E_Cd_Pro_Buffet.Text);


  Fc_Tb_Geral('G','PRO_CASA_DEC_VENDA',IntToStr(Rg_Casas_Venda.ItemIndex));
  Fc_Tb_Geral('G','PRO_CASA_DEC_COMPRA',IntToStr(Rg_Casas_Compra.ItemIndex));

 if chbx_SemBenef.Checked then
    Fc_Tb_Geral('G','PRO_G_SEM_BENEFIC','S')
  else
    Fc_Tb_Geral('G','PRO_G_SEM_BENEFIC','N');

  if Chbx_NaoValidaEAN.Checked then
    Fc_Tb_Geral('G','PRO_G_NAO_VALIDA_EAN','S')
  else
    Fc_Tb_Geral('G','PRO_G_NAO_VALIDA_EAN','N');


end;

procedure TFr_Configuracao.Pc_Abre_Aba_Pessoal;
Begin
  Chbx_CompColaborador.Checked := (Fc_Tb_Geral('L','PES_G_COMPARTILHA','S') = 'S');
end;

procedure TFr_Configuracao.Pc_Grava_Aba_Pessoal;
Begin
  if Chbx_CompColaborador.Checked = true then Fc_Tb_Geral('G','PES_G_COMPARTILHA','S') else Fc_Tb_Geral('G','PES_G_COMPARTILHA','N');
end;

procedure TFr_Configuracao.Pc_Abre_Aba_Comissao;
Begin
//pagar comissao
  if (Fc_Tb_Geral('L','TP_COMISSAO','') = 'R') then
  begin
    RB_Com_Fat.Checked := false;
    RB_Com_Rec.Checked :=True;
  end
  ELSE
  begin
    RB_Com_Fat.Checked := True;
    RB_Com_Rec.Checked := false;
  end;

  chk_Com_Vend_ped.Checked := (Fc_Tb_Geral('L','COM_G_DIST_EMPVDO_PEDVDO','S') = 'S');    
  E_Aliq_Com_Padrao.Text := Fc_Tb_Geral('L','COM_G_AQ_DIST','');
  Chk_Com_Desc.Checked := (Fc_Tb_Geral('L','COM_G_VEND_E_CLIENTE','S') = 'S');
  chk_visualisa_com.Checked:= (Fc_Tb_Geral('L','COM_G_MOSTRA_AQ','S') = 'S');
  ChBx_ComissaoFrenteCaixa.Checked  := (Fc_Tb_Geral('L','COM_G_GERA_COM_FRT','N') = 'S');
end;

procedure TFr_Configuracao.Pc_Grava_Aba_Comissao;
Begin
  //Controla a gravação da Aba de Comissão
  //pagar comissao
  if RB_Com_Fat.Checked = True then (Fc_Tb_Geral('G','TP_COMISSAO','F'));
  if RB_Com_Rec.Checked then (Fc_Tb_Geral('G','TP_COMISSAO','R'));

  if chk_Com_Vend_ped.Checked then Fc_Tb_Geral('G','COM_G_DIST_EMPVDO_PEDVDO','S') else Fc_Tb_Geral('G','COM_G_DIST_EMPVDO_PEDVDO','N');
  Fc_Tb_Geral('G','COM_G_AQ_DIST',FloatToStr(StrToFloatDef(E_Aliq_Com_Padrao.Text,0)));
  if Chk_Com_Desc.Checked then Fc_Tb_Geral('G','COM_G_VEND_E_CLIENTE','S') else Fc_Tb_Geral('G','COM_G_VEND_E_CLIENTE','N');
  if chk_visualisa_com.Checked then Fc_Tb_Geral('G','COM_G_MOSTRA_AQ','S') else Fc_Tb_Geral('G','COM_G_MOSTRA_AQ','N');
  if ChBx_ComissaoFrenteCaixa.Checked then Fc_Tb_Geral('G','COM_G_GERA_COM_FRT','S') else Fc_Tb_Geral('G','COM_G_GERA_COM_FRT','N');
end;


procedure TFr_Configuracao.FormCreate(Sender: TObject);
begin
  GeralSistema := TControllerGeral.create(Self);
  It_Conectado := 1;
  ListaImpressoras;
  ListaBalanca;
  E_ProMovimento.Alignment:= TAlignment(1);
  E_Multa.Alignment:= TAlignment(1);
  E_Juros.Alignment:= TAlignment(1);
  E_Carencia.Alignment:= TAlignment(1);
  Pg_Configuracao.ActivePageIndex:=0;


end;

procedure TFr_Configuracao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(GeralSistema);
  Action:=caFree;
  Fr_Configuracao :=nil;
end;

procedure TFr_Configuracao.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Configuracao.Sb_ConsumidorClick(Sender: TObject);
var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  E_CodConsumo.Text := Lc_Retorno.It_Dados[1,0];
end;

procedure TFr_Configuracao.ChBx_ServicosClick(Sender: TObject);
begin
  if not ChBx_Servicos.Checked then
    Begin
    Chbx_Tecnico.Checked := False;
    Chbx_Tecnico.Enabled := False;
    ChBx_Veiculo.Checked := False;
    ChBx_Veiculo.Enabled := False;
    ChBx_Placa.Enabled := False;
    ChBx_Placa.Checked := False;
    end
  else
    Begin
    Chbx_Tecnico.Enabled := True;
    ChBx_Veiculo.Enabled := True;
    ChBx_Placa.Enabled := True;
    Chbx_Devolucao.Checked := False;
    end;

end;

procedure TFr_Configuracao.Chb_Visualiza_CupomClick(Sender: TObject);
begin
  Lb_ListPrintWindows.Visible := not Chb_Visualiza_Cupom.Checked;
  Cb_ListPrintWindows.Visible := not Chb_Visualiza_Cupom.Checked;
end;

procedure TFr_Configuracao.Chbx_DevolucaoClick(Sender: TObject);
begin
  if Chbx_Devolucao.Checked then
    Begin
    ChBx_Servicos.Checked := False;
    ChBx_ServicosClick(Sender);
    GpB_Devolucao.Enabled := True;
    end
  else
    Begin
    ChBx_Servicos.Enabled := True;
    ChBx_ServicosClick(Sender);
    GpB_Devolucao.Enabled := False;
    E_Cd_Produto.Text := '0';
    end;
end;

procedure TFr_Configuracao.Rb_Bal_PesoClick(Sender: TObject);
begin
  if TRadioButton(Sender).Checked then
    Lb_blc_bar_Preco_Peso.Caption := 'Peso';
end;

procedure TFr_Configuracao.Rd_Calculo_Tipo_1Click(Sender: TObject);
begin
  if Rd_Calculo_Tipo_1.Checked then
    Lb_Formula.Caption := 'Fórmula : Preço de Venda = '+#13 +'Preço de Custo / [( 100 - Taxa de Lucro ) / 100 ]';
end;

procedure TFr_Configuracao.Rd_Calculo_Tipo_2Click(Sender: TObject);
begin
  if Rd_Calculo_Tipo_2.Checked then
    Lb_Formula.Caption := 'Fórmula : Preço de Venda = '+#13 +'Preço de Custo + (Preço de Custo * Taxa de Lucro) ';
end;

procedure TFr_Configuracao.Tbs_GeralShow(Sender: TObject);
begin
  Pc_Abre_Aba_Geral;
end;

procedure TFr_Configuracao.Btn_Ok_1Click(Sender: TObject);
begin
  Pc_Grava_Aba_Geral;
  Close;
end;

procedure TFr_Configuracao.Btn_Ok_2Click(Sender: TObject);
begin
  if ValidaAbaFinanceiro then
  Begin
    Pc_Grava_Aba_Financeiro;
    Close;
  End;
end;

procedure TFr_Configuracao.Btn_Ok_3Click(Sender: TObject);
begin
  Pc_Grava_Aba_OS;
  Close;
end;

procedure TFr_Configuracao.Btn_Ok_4Click(Sender: TObject);
begin
  Pc_Grava_Aba_Impressao;
  Close;
end;

procedure TFr_Configuracao.Btn_Ok_5Click(Sender: TObject);
begin
  if Fc_Valida_Aba_Produtos then
  Begin
    Pc_Grava_Aba_Produtos;
    Pc_Define_CasasDecimais;
    Close;
  end;
end;

procedure TFr_Configuracao.Btn_Ok_6Click(Sender: TObject);
begin
  Pc_Grava_Aba_Pessoal;
  Close;
end;

procedure TFr_Configuracao.Btn_Ap_6Click(Sender: TObject);
begin
  Pc_Grava_Aba_Pessoal;
end;

procedure TFr_Configuracao.Btn_Ap_5Click(Sender: TObject);
begin
  if Fc_Valida_Aba_Produtos then Pc_Grava_Aba_Produtos;
  Pc_Define_CasasDecimais;
end;

procedure TFr_Configuracao.Btn_Ap_4Click(Sender: TObject);
begin
  Pc_Grava_Aba_Impressao
end;

procedure TFr_Configuracao.Btn_Ap_3Click(Sender: TObject);
begin
  Pc_Grava_Aba_OS
end;

procedure TFr_Configuracao.Btn_Ap_2Click(Sender: TObject);
begin
  if ValidaAbaFinanceiro then
  Begin
    Pc_Grava_Aba_Financeiro;
  End;
end;

procedure TFr_Configuracao.Btn_Ap_1Click(Sender: TObject);
begin
  Pc_Grava_Aba_Geral
end;

procedure TFr_Configuracao.Tbs_ImpressaoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Impressao;
end;

procedure TFr_Configuracao.Tbs_FinanceiroShow(Sender: TObject);
begin
  Pc_Abre_Aba_Financeiro;
end;

procedure TFr_Configuracao.Tbs_OrdemServicoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Os;
end;

procedure TFr_Configuracao.Tbs_ProdutoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Produtos;
end;

function TFr_Configuracao.ValidaAbaFinanceiro: boolean;
Var
  Lc_Boleto : TControllerBoletoBancario;
  Lc_Result : Boolean;
begin
  lc_result := true;
  if ChBx_Fat_Vda_Auto_Boleto_impressao.Checked  then
  Begin
    try
      Lc_Boleto := TControllerBoletoBancario.Create(nil);
      if not Lc_Boleto.VerificaExistenciaContaCorrente then
      Begin
        MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                       'Para ativar esta opção, configurações precisam ser efetuadas.'+EOLN+
                       'Registrar a conta-corrente no módulo bancário.'+EOLN+EOLN,
                      ['OK'],[bEscape],mpAlerta);
        lc_result := false;
        exit;
      End;
      if not Lc_Boleto.VerificaExistenciaCarteiraCobranca then
      Begin
        MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                       'Para ativar esta opção, configurações precisam ser efetuadas.'+EOLN+
                       'Registrar uma carteira de cobrança no módulo bancário.'+EOLN+EOLN,
                      ['OK'],[bEscape],mpAlerta);
        lc_result := false;
        exit;
      End;
    finally
      FreeAndNil(Lc_Boleto);
      if not lc_result  then
        ChBx_Fat_Vda_Auto_Boleto_impressao.Checked := False;
    end;
  End;
  Result := Lc_Result;
end;

function TFr_Configuracao.Valida_Grava_Aba_Despacho: Boolean;
begin
  Result := True;
  if Chbx_Ctrl_separacao.Checked and Chbx_despacho_by_cod_barra.Checked then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'O uso da separação de mercadoria e .'+EOLN+
                   'do código de barras  não podem ser usados simultâneamente.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
  End;
end;

procedure TFr_Configuracao.Rb_Bal_PrecoClick(Sender: TObject);
begin
  if TRadioButton(Sender).Checked then
    Lb_blc_bar_Preco_Peso.Caption := 'Preço';
end;

procedure TFr_Configuracao.Tbs_PessoalShow(Sender: TObject);
begin
  Pc_Abre_Aba_Pessoal;
end;

procedure TFr_Configuracao.Tbs_comissaoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Comissao;
end;

procedure TFr_Configuracao.Pc_Grava_Aba_Controle_Venda;
begin
  if (ChBx_InformaValor.Checked = True) then
    Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_EDIT_VALOR_PESO','S')
  else
    Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_EDIT_VALOR_PESO','N');

  //codigo do consumidor
  Fc_Tb_Geral('G','VDA_G_CODCONS',E_CodConsumo.Text);

//lucratividade
  if rdg_Lucratividade.ItemIndex = 0 then
    Fc_Tb_Geral('G','VDA_G_CALC_LCVDADE','V')
  else
    Fc_Tb_Geral('G','VDA_G_CALC_LCVDADE','C');


  if Chbx_Rec_Bruta_Venda.Checked   then Fc_Tb_Geral('G','VDA_REC_BRUTA_VENDA','S') else Fc_Tb_Geral('G','VDA_REC_BRUTA_VENDA','N');
  if Chbx_Custo_Relatorio_Venda.Checked   then Fc_Tb_Geral('G','VDA_CUSTO_REL_VDA','S') else Fc_Tb_Geral('G','VDA_CUSTO_REL_VDA','N');
  if chbk_Valida_Transp.Checked   then Fc_Tb_Geral('G','VDA_VALIDA_TRANSP_FAT','S') else Fc_Tb_Geral('G','VDA_VALIDA_TRANSP_FAT','N');
  if chbx_reg_obs_nanf.Checked   then Fc_Tb_Geral('G','VDA_OBS_FINANCEIRA','S') else Fc_Tb_Geral('G','VDA_OBS_FINANCEIRA','N');
  if ChBx_PedidoInternet.Checked   then Fc_Tb_Geral('G','VDA_G_PEDIDO_INTERNET','S') else Fc_Tb_Geral('G','VDA_G_PEDIDO_INTERNET','N');
  if Chbx_PerguntasInternet.Checked   then Fc_Tb_Geral('G','VDA_G_PERGUNTA_INTERNET','S') else Fc_Tb_Geral('G','VDA_G_PERGUNTA_INTERNET','N');
  if Chbx_Res_Vda_Hora.Checked   then Fc_Tb_Geral('G','VDA_G_RES_HORA','S') else Fc_Tb_Geral('G','VDA_G_RES_HORA','N');
end;

procedure TFr_Configuracao.Pc_Abre_Aba_Controle_Venda;
begin
  ChBx_InformaValor.Checked := (Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_EDIT_VALOR_PESO','') = 'S');
  chbk_Valida_Transp.Checked:= (Fc_Tb_Geral('L','VDA_VALIDA_TRANSP_FAT','') = 'S');

  //codigo do consumidor
  E_CodConsumo.Text := Fc_Tb_Geral('L','VDA_G_CODCONS',E_CodConsumo.Text);

//lucratividade
  if Fc_Tb_Geral('L','VDA_G_CALC_LCVDADE','') = 'V' THEN
    rdg_Lucratividade.ItemIndex :=0
  ELSE
  if Fc_Tb_Geral('L','VDA_G_CALC_LCVDADE','') = 'C' THEN
    rdg_Lucratividade.ItemIndex :=1;


  Chbx_Rec_Bruta_Venda.Checked := (Fc_Tb_Geral('L','VDA_REC_BRUTA_VENDA','S') = 'S');
  Chbx_Custo_Relatorio_Venda.Checked := (Fc_Tb_Geral('L','VDA_CUSTO_REL_VDA','S') = 'S');
  chbx_reg_obs_naNF.Checked := (Fc_Tb_Geral('L','VDA_OBS_FINANCEIRA','S') ='S');
  ChBx_PedidoInternet.Checked  := (Fc_Tb_Geral('L','VDA_G_PEDIDO_INTERNET','S') = 'S');
  Chbx_PerguntasInternet.Checked  := (Fc_Tb_Geral('L','VDA_G_PERGUNTA_INTERNET','S') = 'S');
  Chbx_Res_Vda_Hora.Checked       := (Fc_Tb_Geral('L','VDA_G_RES_HORA','N') = 'S');



end;

procedure TFr_Configuracao.Btn_Ap_7Click(Sender: TObject);
begin
  Pc_Grava_Aba_Comissao;
end;

procedure TFr_Configuracao.Btn_Ok_7Click(Sender: TObject);
begin
  Pc_Grava_Aba_Comissao;
  Close;
end;

procedure TFr_Configuracao.tbs_pedidosShow(Sender: TObject);
begin
  Pc_Abre_Aba_Geral_Pedido;
  pg_pedidos.ActivePage := tbs_controle_venda;
  Pc_Abre_Aba_Controle_Venda
end;

procedure TFr_Configuracao.Btn_Ap_8Click(Sender: TObject);
begin
  Pc_Grava_Aba_Controle_Venda;
end;

procedure TFr_Configuracao.Btn_Ok_8Click(Sender: TObject);
begin
  Pc_Grava_Aba_Controle_Venda;
  close;
end;

procedure TFr_Configuracao.Btn_Cn_8Click(Sender: TObject);
begin
close;
end;

procedure TFr_Configuracao.Pc_Abre_Aba_Controle_Compra;
begin
  //imprimi pedido impressora
  rdg_PedCpa_Imp.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_IMPRESSORA',''),0);

  e_porta_ImpCpa.Text := Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_PORTA',e_porta_ImpCpa.Text);
  e_salto_cpa.Text :=Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_SALTO','0');

//modelo de impressao estilo matricial
  cbx_modeloMat_cpa.ItemIndex :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_MOD_MATRICIAL', ''),1)-1;

//modelo de impressao estilo lase
  cbx_modeloLaser_cpa.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_MOD_JATOLASER', ''),1)-1;

//Ites por folha
  e_itens_cpa.Text := Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_ITENS_FOLHA','');

  ChBx_Ctrl_Nota_Compra.Checked :=Fc_Tb_Geral('L','CPA_G_CTRL_NUM_NOTA', '') = 'S';
  ChBx_Nfe_Compra.Checked := Fc_Tb_Geral('L','CPA_G_OPER_COMPRA_NFE','') = 'S';
  Chbx_controle_compra.Checked := (Fc_Tb_Geral('L','CPA_G_CTRL_SEQUENCIA','') = 'S');

  E_Ctrl_Cpa_Valor_Total.Text := Fc_Tb_Geral('L','CPA_G_CTRL_VL_MENSAL', '0,00');

  chbx_ValidaDiferencaCompra.Checked := Fc_Tb_Geral('L','CPA_G_OPER_DIFER_VALOR','S') = 'S';
end;

procedure TFr_Configuracao.Pc_Grava_Aba_Controle_Compra;
begin
  //imprimi pedido impressora
  Fc_Aq_Geral('G','CONTROLE DE COMPRA','CPA_P_IMPRESSORA',IntToStr(rdg_PedCpa_Imp.ItemIndex));

  Fc_Aq_Geral('G','CONTROLE DE COMPRA','CPA_P_PORTA',e_porta_ImpCpa.Text);
  Fc_Aq_Geral('G','CONTROLE DE COMPRA','CPA_P_SALTO',e_salto_cpa.Text);

//modelo de impressao estilo matricial
  Fc_Aq_Geral('G','CONTROLE DE COMPRA','CPA_P_MOD_MATRICIAL', IntToStr(cbx_modeloMat_cpa.ItemIndex+1));

//modelo de impressao estilo lase
 Fc_Aq_Geral('G','CONTROLE DE COMPRA','CPA_P_MOD_JATOLASER', IntToStr(cbx_modeloLaser_cpa.ItemIndex+1));


//Ites por folha
  Fc_Aq_Geral('G','CONTROLE DE COMPRA','CPA_P_ITENS_FOLHA',e_itens_cpa.Text);


 if ChBx_Ctrl_Nota_Compra.Checked then
   Fc_Tb_Geral('G','CPA_G_CTRL_NUM_NOTA','S')
 else
   Fc_Tb_Geral('G','CPA_G_CTRL_NUM_NOTA', 'N');

  if ChBx_Nfe_Compra.Checked then Fc_Tb_Geral('G','CPA_G_OPER_COMPRA_NFE','S') else Fc_Tb_Geral('G','CPA_G_OPER_COMPRA_NFE','N');
  if Chbx_controle_compra.Checked then Fc_Tb_Geral('G','CPA_G_CTRL_SEQUENCIA','S') else  Fc_Tb_Geral('G','CPA_G_CTRL_SEQUENCIA','N');

  Fc_Tb_Geral('G','CPA_G_CTRL_VL_MENSAL', E_Ctrl_Cpa_Valor_Total.Text);
  if chbx_ValidaDiferencaCompra.Checked then Fc_Tb_Geral('G','CPA_G_OPER_DIFER_VALOR','S') else Fc_Tb_Geral('G','CPA_G_OPER_DIFER_VALOR','N');

end;

procedure TFr_Configuracao.Pc_Grava_Aba_Controle_Frente;
Begin
  //imprimi pedido impressora
  if RB_ImpMatricial_Frt.Checked then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','0')
  else
  if RB_ImpTermica_Frt.Checked then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','1')
  else
  if RB_ImpPedido_Frt.Checked then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','2');

  //Preenche combo com as impressoras
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_PORTA', e_porta_Frt.Text);
  Fc_Aq_Geral('G','CONTROLE DE FRETE','FRT_P_SALTO', e_salto_Frt.Text);

  //modelo de impressao estilo matricial
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL',IntToStr(cbx_modeloMat_Frt.ItemIndex + 1));
  //modelo de impressao estilo Termica
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_MOD_TERMICA', IntToStr(cbx_modeloTer_frt.ItemIndex + 1));

  //Controle de Gaveta
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_GVT_MODELO', IntToStr(Cb_Gvta_modelo.ItemIndex + 1));
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', Cb_Gvta_porta.Text);
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', Cb_Gvta_StrAbertura.Text);
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_P_GVT_ACA_ANTEC', IntToStr(Cb_Gvta_AcaoAntecip.ItemIndex + 1));

  //Tabelas de Preço
  IF Trim(Dblcb_TabelasConsumidor.Text) <> '' then
    Fc_Tb_Geral('G','FRT_G_PRECO_CONSUMIDOR', IntToStr(Dblcb_TabelasConsumidor.KeyValue));

  //Opções de Impressao do Cupom
  if ChBx_CodigoBarra.Checked then Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_BARRAS_CUPOM','S') else Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_BARRAS_CUPOM','N');
  if Chb_ImpCupom.Checked then Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_FRENTE','S') else Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_FRENTE','N');
  if Chb_Visualiza_Cupom.Checked then Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') else Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','N');
  Chb_Visualiza_CupomClick(Self);
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_NOME_IMPRESSORA', Cb_ListPrintWindows.Text);
  //vERIFICA SE DISPONIBILIZA PRODUTO AVULSO
  Pc_ConsultaRegistroProdutoAvulso;

  //Tipo de Impressora
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_TIPO_IMPRESSORA', InttoStr(Cb_TipoImpressora.ItemIndex + 1));
  //Numero de Colunas
  Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_NR_COLUNAS', E_Nr_Colunas.Text);

  //FAz a Busca por codigo de Fabrica
  if ChBx_UsarCodigoFAb.Checked  then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'S')
  else
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N');

  //Utilizar sistemática de impressão item a item na leitura do produto no checkout
  if ChBx_Imp_Item_Checkout.Checked  then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_ITEM_CHECKOUT', 'S')
  else
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_ITEM_CHECKOUT', 'N');

  //Utilizar opção de Desconto
  if Chbx_Frt_Desconto.Checked  then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_USAR_DESCONTO', 'S')
  else
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_USAR_DESCONTO', 'N');


  if Chbx_Vda_Sem_Ctrl_Estoque.Checked  then
    Fc_Tb_Geral('G','FRT_VDA_EST_SEM_CTRL', 'S')
  else
    Fc_tb_Geral('G','FRT_VDA_EST_SEM_CTRL', 'N');

  if chbx_CortePapel.Checked  then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_CORTE_PAPEL', 'S')
  else
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_CORTE_PAPEL', 'N');


  if chbx_frt_nota_Promissoria.Checked  then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_NOTA_PROMISSORIA', 'S')
  else
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_NOTA_PROMISSORIA', 'N');

  if chbx_frt_bloqueia_F11.Checked  then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_BLOQUEIA_F11', 'S')
  else
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_BLOQUEIA_F11', 'N');

end;

procedure TFr_Configuracao.Pc_Abre_Aba_Controle_Frente;
var
  I: Integer;
  LcNomeImpressora : String;
Begin
  //imprimi pedido impressora
  RB_ImpMatricial_Frt.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','0') = '0');
  RB_ImpTermica_Frt.Checked   := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','1') = '1');
  RB_ImpPedido_Frt.Checked    := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','2') = '2');

  //Preenche combo com as impressoras
  e_porta_Frt.Text := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', 'LPT1');
  e_salto_Frt.Text :=Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0');

  //modelo de impressao estilo matricial
  cbx_modeloMat_Frt.ItemIndex :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL', '1'),0)-1;
  //modelo de impressao estilo Termica
  cbx_modeloTer_frt.ItemIndex :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_TERMICA', '1'),0)-1;

  //Controle de Gaveta
  Cb_Gvta_modelo.ItemIndex      := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_MODELO', ''),0)-1;
  Cb_Gvta_porta.Text            := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', '');
                                
  Cb_Gvta_StrAbertura.Text      := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '');
  Cb_Gvta_AcaoAntecip.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_ACA_ANTEC', ''),0)-1;

  //Tabelas de Preço
  DM.Qr_Tabelas.Active := True;
  Dblcb_TabelasConsumidor.KeyValue := StrToIntDef(Fc_Tb_Geral('L','FRT_G_PRECO_CONSUMIDOR','1'),1);



  //Opções de Impressao do Cupom
  ChBx_CodigoBarra.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_BARRAS_CUPOM','S') = 'S');
  Chb_ImpCupom.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_FRENTE','S') = 'S');
  Chb_Visualiza_Cupom.Checked  := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') = 'S') ;
  LcNomeImpressora :=  Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NOME_IMPRESSORA','' );
  for I := 0 to Cb_ListPrintWindows.Items.Count - 1 do
  Begin
    if ( LcNomeImpressora = Cb_ListPrintWindows.Items[I] ) then
    BEgin
      Cb_ListPrintWindows.ItemIndex := I;
      break;
    End;
  End;

  Chbx_ProdutoAvulso.Checked := (Fc_Tb_Geral('L','FRT_PRODUTOAVULSO','N') = 'S');
  //Tipo de Impressora
  Cb_TipoImpressora.ItemIndex := StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_TIPO_IMPRESSORA', '1'),1) - 1;
  //Número de Colunas
  E_Nr_Colunas.Text := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '');

  //FAz a Busca por codigo de Fabrica
  ChBx_UsarCodigoFAb.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N') = 'S');

  //Utilizar sistemática de impressão item a item na leitura do produto no checkout
  ChBx_Imp_Item_Checkout.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_ITEM_CHECKOUT', 'N') = 'S');

  //Utilizar opção de Desconto
  Chbx_Frt_Desconto.Checked  := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_USAR_DESCONTO', 'S') = 'S');
  //Utilizar opção para vender produto sem registro no cadastro

  Chbx_Vda_Sem_Ctrl_Estoque.Checked  := (Fc_TB_Geral('L','FRT_VDA_EST_SEM_CTRL', 'N') = 'S');

  chbx_CortePapel.Checked := ( Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_CORTE_PAPEL', 'S') = 'S');

  chbx_frt_nota_Promissoria.Checked := ( Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NOTA_PROMISSORIA', 'S') = 'S');

  chbx_frt_bloqueia_F11.Checked := ( Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_BLOQUEIA_F11', 'N') = 'S');

end;

procedure TFr_Configuracao.ListaBalanca;
var
  I : TACBrBALModelo ;
begin
  Cb_Tipo_Balanca.Items.Clear ;
  For I := Low(TACBrBALModelo) to High(TACBrBALModelo) do
     Cb_Tipo_Balanca.Items.Add( GetEnumName(TypeInfo(TACBrBALModelo), integer(I) ) ) ;
  Cb_Tipo_Balanca.ItemIndex := 0;
end;

procedure TFr_Configuracao.ListaImpressoras;
var
  i: Integer;
  Printer: TPrinter;
begin
  try
    Printer:=TPrinter.Create;
    Cb_ListPrintWindows.Items.Clear;
    for i := 0 to Printer.Printers. Count - 1 do
    begin
      Cb_ListPrintWindows.Items. Add(Printer. Printers. Strings[i] );
      Cb_ListPrintWindows.ItemIndex:=0;
    end;
  finally
    FreeAndNil(Printer);
  end;
end;

procedure TFr_Configuracao.Pc_Grava_Aba_Controle_Pizzaria;
Begin
  //imprimi pedido impressora
  if RB_ImpMatricial_Piz.Checked then
    Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_P_IMPRESSORA','0')
  else
    Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_P_IMPRESSORA','1');

  //Preenche combo com as impressoras
  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_P_PORTA', e_porta_Piz.Text);
  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_P_SALTO', e_salto_Piz.Text);

  //modelo de impressao estilo matricial
  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_P_MOD_MATRICIAL',IntToStr(cbx_modeloMat_Piz.ItemIndex + 1));
  //modelo de impressao estilo Termica
  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_P_MOD_TERMICA', IntToStr(cbx_modeloTer_Piz.ItemIndex + 1));

  IF Rd_Media_Pizzaria.Checked THEN Fc_Tb_Geral('G','PIZ_CALC_PIZZA','1');
  IF Rd_Maior_Pizzaria.Checked THEN Fc_Tb_Geral('G','PIZ_CALC_PIZZA','2');

  //Identificador de chamada
  if Chbx_Ativar_Identificador_Piz.Checked then
    Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_IDENT_ATIVA','S')
  else
    Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_IDENT_ATIVA','N');

  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_IDENT_PORTA',E_PortaCom_Piz.Text);

  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_INI',E_Tra_Str_Ini_Piz.Text);
  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_TAM',E_Tra_Str_Tam_Piz.Text);

  if ChBx_AutoFaturamentoEntrega.Checked then
    Fc_Tb_Geral('G','PIZ_AUTO_FATURA_ENTREGA','S')
  else
    Fc_Tb_Geral('G','PIZ_AUTO_FATURA_ENTREGA','N');

  if ChBx_AutoFaturamentoBalcao.Checked then
    Fc_Tb_Geral('G','PIZ_AUTO_FATURA_BALCAO','S')
  else
    Fc_Tb_Geral('G','PIZ_AUTO_FATURA_BALCAO','N');

  if ChBx_AutoFaturamentoMesa.Checked then
    Fc_Tb_Geral('G','PIZ_AUTO_FATURA_MESA','S')
  else
    Fc_Tb_Geral('G','PIZ_AUTO_FATURA_MESA','N');

  if Chbx_ZerarPedidoPizza.Checked then
    Fc_Tb_Geral('G','PIZ_ZERA_PEDIDO_CXA','S')
  else
    Fc_Tb_Geral('G','PIZ_ZERA_PEDIDO_CXA','N');

  Fc_Tb_Geral('G','PIZ_DIAR_MOTOBOY',E_Diariamotoboy.Text);

  if ChBx_Piz_GuilhotinaOneByOne.Checked then
    Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_GUILHOTINA_ONEBYONE','S')
  Else
    Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_GUILHOTINA_ONEBYONE','N');

  if chbx_piz_reduzir_valor_Entrega.Checked then
    Fc_Tb_Geral('G','PIZ_REDUZ_VL_ENTREGA','S')
  Else
    Fc_Tb_Geral('G','PIZ_REDUZ_VL_ENTREGA','N');

end;

procedure TFr_Configuracao.Pc_Abre_Aba_Controle_Pizzaria;
Begin
  //imprimi pedido impressora
  RB_ImpMatricial_Piz.Checked := (Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_IMPRESSORA','0') = '0');
  RB_ImpTermica_Piz.Checked   := (Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_IMPRESSORA','1') = '1');

  //Preenche combo com as impressoras
  e_porta_Piz.Text := Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_PORTA', 'LPT1');
  e_salto_Piz.Text :=Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_SALTO','0');

  //modelo de impressao estilo matricial
  cbx_modeloMat_Piz.ItemIndex :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_MOD_MATRICIAL', '1'),0)-1;
  //modelo de impressao estilo Termica
  cbx_modeloTer_Piz.ItemIndex :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_MOD_TERMICA', '1'),0)-1;

  Rd_Media_Pizzaria.Checked := (Fc_Tb_Geral('L','PIZ_CALC_PIZZA','') = '1');
  Rd_Maior_Pizzaria.Checked := (Fc_Tb_Geral('L','PIZ_CALC_PIZZA','') = '2');

  //Identificador de chamada
  Chbx_Ativar_Identificador_Piz.Checked := (Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_ATIVA','N') = 'S');
  E_PortaCom_Piz.Text := Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_PORTA','');

  E_Tra_Str_Ini_Piz.Text := Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_INI','3');
  E_Tra_Str_Tam_Piz.Text := Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_TAM','8');

  ChBx_AutoFaturamentoEntrega.Checked := ( Fc_Tb_Geral('L','PIZ_AUTO_FATURA_ENTREGA','S') = 'S' );
  ChBx_AutoFaturamentoBalcao.Checked := ( Fc_Tb_Geral('L','PIZ_AUTO_FATURA_BALCAO','N') = 'S' );
  ChBx_AutoFaturamentoMesa.Checked := ( Fc_Tb_Geral('L','PIZ_AUTO_FATURA_MESA','N') = 'S' );

  Chbx_ZerarPedidoPizza.Checked := (Fc_Tb_Geral('L','PIZ_ZERA_PEDIDO_CXA','S') = 'S');

  E_Diariamotoboy.Text := Fc_Tb_Geral('L','PIZ_DIAR_MOTOBOY','0,00');

  ChBx_Piz_GuilhotinaOneByOne.Checked := ( Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_GUILHOTINA_ONEBYONE','S') = 'S');

  chbx_piz_reduzir_valor_Entrega.Checked := (Fc_Tb_Geral('L','PIZ_REDUZ_VL_ENTREGA','') = 'S');


end;



procedure TFr_Configuracao.Btn_Ok_9Click(Sender: TObject);
begin
  Pc_Grava_Geral_Pedido;
  if pg_pedidos.ActivePage = tbs_controle_venda then
    Pc_Grava_Aba_Controle_Venda
  else
  if pg_pedidos.ActivePage = tbs_controle_compra then
    Pc_Grava_Aba_Controle_Compra
  else
  if pg_pedidos.ActivePage = tbs_controle_Frente then
    Pc_Grava_Aba_Controle_Frente
  else
  if pg_pedidos.ActivePage = tbs_controle_Pizzaria then
    Pc_Grava_Aba_Controle_Pizzaria;
  Close;
end;

procedure TFr_Configuracao.Btn_Ap_9Click(Sender: TObject);
begin
  Pc_Grava_Geral_Pedido;
  if pg_pedidos.ActivePage = tbs_controle_venda then
    Pc_Grava_Aba_Controle_Venda
  else
  if pg_pedidos.ActivePage = tbs_controle_compra then
    Pc_Grava_Aba_Controle_Compra
  else
  if pg_pedidos.ActivePage = tbs_controle_Frente then
    Pc_Grava_Aba_Controle_Frente
  else
  if pg_pedidos.ActivePage = tbs_controle_Pizzaria then
    Pc_Grava_Aba_Controle_Pizzaria;
end;

procedure TFr_Configuracao.Btn_Cn_10Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Configuracao.Sb_ProdutoClick(Sender: TObject);
Var
  Lc_Form : TSeaProduct;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TSeaProduct.Create(Self);
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Configuracao.Pc_Abre_Aba_Geral_Pedido;
begin
  chbx_Ctrl_Est_Auto.Checked    := (Fc_Tb_Geral('L','PED_G_EST_AUTO','S')= 'S');
  edtCaminhoBancoEnviaPedido.Text := trim(Fc_Tb_Geral('L','PED_G_BANCO_DESTINO','')); // Busca Caminho do Banco de Destino
end;

procedure TFr_Configuracao.Pc_Grava_Geral_Pedido;
begin
  IF chbx_Ctrl_Est_Auto.Checked THEN Fc_Tb_Geral('G','PED_G_EST_AUTO','S') ELSE  Fc_Tb_Geral('G','PED_G_EST_AUTO','N');
  Fc_Tb_Geral('G','PED_G_BANCO_DESTINO',edtCaminhoBancoEnviaPedido.Text); 
end;

procedure TFr_Configuracao.pg_pedidosChange(Sender: TObject);
begin
  if pg_pedidos.ActivePage = tbs_controle_venda then
    Pc_ABRE_Aba_Controle_Venda
  else
  if pg_pedidos.ActivePage = tbs_controle_compra then
    Pc_ABRE_Aba_Controle_Compra
  else
  if pg_pedidos.ActivePage = tbs_controle_Frente then
    Pc_Abre_Aba_Controle_Frente
  else
  if pg_pedidos.ActivePage = tbs_controle_Pizzaria then
    Pc_Abre_Aba_Controle_Pizzaria;

end;

procedure TFr_Configuracao.Pc_Abre_Aba_Balanca;
Begin
  //Dados da Balanca
  Cb_Tipo_Balanca.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_MODELO',''),0);
  Cb_HandShaking.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_HANDSHAKE',''),0);
  Cb_Paridade.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_PARIDADE',''),0);
  Cb_BitsParada.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_BITSPARADA',''),0);
  Cb_Data_Bits.Text := Fc_Aq_Geral('L','BALANCA','BAL_P_DATABITS','');
  Cb_Baud_Rate.Text := Fc_Aq_Geral('L','BALANCA','BAL_P_BAUDRATE','');
  Cb_Porta_Serial.Text := Fc_Aq_Geral('L','BALANCA','BAL_P_PORTA','');
  E_Timer.Text := Fc_Aq_Geral('L','BALANCA','BAL_P_TIMER','');
  chbx_Balanca.Checked := (Fc_Aq_Geral('L','BALANCA','BAL_P_ATIVACAO','') = 'S');
  //cODIGO DE bARRASDA bALANCA
  //Bloco do codigo de produto
  E_bal_bar_Cd_Produto.Text := Fc_Aq_Geral('L','BALANCA','BAL_BAR_CD_PRODUTO','6');
  //Bloco do codigo de peso ou preco
  E_bal_bar_Preco_Peso.Text := Fc_Aq_Geral('L','BALANCA','BAL_BAR_PRECO_QTDE','6');
  if Fc_Aq_Geral('L','BALANCA','BAL_TIPO_LEITURA','P') = 'P' then
  Begin
    Rb_Bal_Preco.Checked := True;
    Rb_Bal_Peso.Checked := False;
  End
  else
  Begin
    Rb_Bal_Preco.Checked := False;
    Rb_Bal_Peso.Checked := True;
  End;
  
end;

procedure TFr_Configuracao.Pc_Grava_Aba_Balanca;
Begin
  //Dados da Balanca
  Fc_Aq_Geral('G','BALANCA','BAL_P_MODELO',IntToStr(Cb_Tipo_Balanca.ItemIndex));
  Fc_Aq_Geral('G','BALANCA','BAL_P_HANDSHAKE',IntToStr(Cb_HandShaking.ItemIndex));
  Fc_Aq_Geral('G','BALANCA','BAL_P_PARIDADE',IntToStr(Cb_Paridade.ItemIndex));
  Fc_Aq_Geral('G','BALANCA','BAL_P_BITSPARADA',IntToStr(Cb_BitsParada.ItemIndex));
  Fc_Aq_Geral('G','BALANCA','BAL_P_DATABITS',Cb_Data_Bits.Text);
  Fc_Aq_Geral('G','BALANCA','BAL_P_BAUDRATE',Cb_Baud_Rate.Text);
  Fc_Aq_Geral('G','BALANCA','BAL_P_PORTA',Cb_Porta_Serial.Text);
  Fc_Aq_Geral('G','BALANCA','BAL_P_TIMER',E_Timer.Text);
  if chbx_Balanca.Checked   then Fc_Aq_Geral('G','BALANCA','BAL_P_ATIVACAO','S') else Fc_Aq_Geral('G','BALANCA','BAL_P_ATIVACAO','N');

  //Bloco do codigo de produto
  Fc_Aq_Geral('G','BALANCA','BAL_BAR_CD_PRODUTO',E_bal_bar_Cd_Produto.Text);
  //Bloco do codigo de peso ou preco
  Fc_Aq_Geral('G','BALANCA','BAL_BAR_PRECO_QTDE',E_bal_bar_Preco_Peso.Text);

  if Rb_Bal_Preco.Checked then
    Fc_Aq_Geral('G','BALANCA','BAL_TIPO_LEITURA','P')//Price
  else
    Fc_Aq_Geral('G','BALANCA','BAL_TIPO_LEITURA','W')//Weight



end;

procedure TFr_Configuracao.Pc_Grava_Aba_Despacho;
Begin
  if chbx_Imp_auto_Separacao.Checked then
    Begin
    if Trim(E_PortaImpressao_dsp.Text) = '' then
      Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Escolhendo a opção de impressão automática para'+EOLN+
                     'impressora de separação, o caminhho da impressora é obrigatório.'+EOLN+
                     'Verifique e tente novamente' +EOLN,
                     ['OK'], [bEscape], mpAlerta);
      if E_PortaImpressao_dsp.CanFocus then E_PortaImpressao_dsp.SetFocus;
      exit;
      end;
    end;

  if chbx_Ctrl_despacho.Checked then  Fc_Tb_Geral('G','DSP_G_CTRL_DESPACHO','S') else  Fc_Tb_Geral('G','DSP_G_CTRL_DESPACHO','N');
  if chbx_Ctrl_separacao.Checked then  Fc_Tb_Geral('G','DSP_G_CTRL_SEPARACAO','S') else  Fc_Tb_Geral('G','DSP_G_CTRL_SEPARACAO','N');
  if chbx_Imp_auto_Separacao.Checked then  Fc_Tb_Geral('G','DSP_P_IMP_AUTO_SEP','S') else  Fc_Tb_Geral('G','DSP_P_IMP_AUTO_SEP','N');
  Fc_Aq_Geral('G','CONTROLE DE DESPACHO','DSP_P_PORTA',E_PortaImpressao_dsp.Text);
  Fc_Aq_Geral('G','CONTROLE DE DESPACHO','DSP_P_SALTO',E_SaltoImpressao_dsp.Text);

  //modelo de impressao
  Fc_Aq_Geral('G','CONTROLE DE DESPACHO','DSP_P_MOD_IMPRESSAO', IntToStr(cbx_Impressao_Dsp.ItemIndex+1));

  if Chbx_despacho_by_cod_barra.Checked then  Fc_Tb_Geral('G','DSP_BY_COD_BARRAS','S') else  Fc_Tb_Geral('G','DSP_BY_COD_BARRAS','N');


end;

procedure TFr_Configuracao.Pc_Grava_Aba_Estoque;
begin
  IF ChBx_est_Avise_Saldo_Zero.Checked THEN
   Fc_Tb_Geral('G','EST_NOTIFICA_EMAIL','S')
  else
   Fc_Tb_Geral('G','EST_NOTIFICA_EMAIL','N');

  Fc_Tb_Geral('G','EST_IDENTIF_EMAIL',E_est_email_notifica.Text);

  if Chbx_est_auto_reposicao.checked then
   Fc_Tb_Geral('G','EST_AUTO_REPOSICAO','S')
  else
   Fc_Tb_Geral('G','EST_AUTO_REPOSICAO','N');



end;

procedure TFr_Configuracao.Pc_Abre_Aba_Despacho;
Begin
  chbx_Ctrl_despacho.Checked:= (Fc_Tb_Geral('L','DSP_G_CTRL_DESPACHO','')='S');
  chbx_Ctrl_separacao.Checked:= (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','')='S');
  chbx_Imp_auto_Separacao.Checked:= (Fc_Tb_Geral('L','DSP_P_IMP_AUTO_SEP','')='S');
  Chbx_Ctrl_separacaoClick(self);
  E_PortaImpressao_dsp.Text := Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_PORTA','');
  E_SaltoImpressao_dsp.Text := Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_SALTO','');

  //modelo de impressao
  cbx_Impressao_Dsp.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_MOD_IMPRESSAO', ''),1)-1;

  Chbx_despacho_by_cod_barra.Checked := ( Fc_Tb_Geral('L','DSP_BY_COD_BARRAS','N') = 'S');
end;

procedure TFr_Configuracao.Pc_Abre_Aba_Estoque;
begin
  ChBx_est_Avise_Saldo_Zero.Checked := ( Fc_Tb_Geral('L','EST_NOTIFICA_EMAIL','N')  = 'S');
  E_est_email_notifica.Text := Fc_Tb_Geral('L','EST_IDENTIF_EMAIL','');

  Chbx_est_auto_reposicao.checked := ( Fc_Tb_Geral('L','EST_AUTO_REPOSICAO','N') = 'S');
end;

procedure TFr_Configuracao.Btn_Ok_12Click(Sender: TObject);
begin
  Pc_Grava_Aba_Balanca;
  close;
end;

procedure TFr_Configuracao.btn_ok_13Click(Sender: TObject);
begin
  Pc_Grava_Aba_TEF;
  Close;
end;

procedure TFr_Configuracao.Btn_AP_12Click(Sender: TObject);
begin
  Pc_Grava_Aba_Balanca;
end;

procedure TFr_Configuracao.btn_ap_13Click(Sender: TObject);
begin
  Pc_Grava_Aba_TEF;
end;

procedure TFr_Configuracao.Tbs_BalancaShow(Sender: TObject);
begin
  Pc_Abre_Aba_Balanca;
end;

procedure TFr_Configuracao.btnConectarClick(Sender: TObject);
begin
   // se houver conecção aberta, Fecha a conecção
   if Balanca.Ativo then
      Balanca.Desativar;

   // configura porta de comunicação
   Balanca.Modelo           := TACBrBALModelo( Cb_Tipo_Balanca.ItemIndex );



   Balanca.Device.HandShake :=  TACBrHandShake( Cb_HandShaking.ItemIndex );
   Balanca.Device.Parity    := TACBrSerialParity( Cb_Paridade.ItemIndex );
   Balanca.Device.Stop      := TACBrSerialStop( Cb_BitsParada.ItemIndex );
   Balanca.Device.Data      := StrToInt( Cb_Data_Bits.text );
   Balanca.Device.Baud      := StrToInt( Cb_Baud_Rate.Text );
   Balanca.Device.Porta     := Cb_Porta_Serial.Text;

   // Conecta com a balança
   Balanca.Ativar;

   btnConectar.Enabled    := false;
   Panel1.Enabled         := false;
   btnDesconectar.Enabled := true;
   btnLerPeso.Enabled     := true;
end;

procedure TFr_Configuracao.btnDesconectarClick(Sender: TObject);
begin
  Balanca.Desativar;

  btnConectar.Enabled    := True;
  Panel1.Enabled         := True;
  btnDesconectar.Enabled := False;
  btnLerPeso.Enabled     := False;
end;

procedure TFr_Configuracao.btnLerPesoClick(Sender: TObject);
Var TimeOut : Integer ;
begin
   try
      TimeOut := StrToInt( E_Timer.Text ) ;
   except
      TimeOut := 2000 ;
   end ;

   sttPeso.Caption := FloatToStrF(Balanca.LePeso( TimeOut ),ffFixed,10,3);
end;

procedure TFr_Configuracao.Button1Click(Sender: TObject);
var
i_status: integer;
s_stporta: String;
s_porta : String;
i_retorno : Integer;
i_modelo:integer;
begin
  s_porta := Cb_Gvta_porta.text;
  //0 - MODELO 1 - EPSON
  //1 - MODELO 2 - BEMATECH MP4200
  //2 - MODELO 3 - BEMATECH MP4000
  //3 - MODELO 4 - BEMATECH MP100S
  //4 - MODELO 5 - GERENCIADOR WINDOWS
  //5 - MODELO 6 - BEMATECH MP2500
  case cbx_modeloMat_Frt.itemindex of
    1:i_modelo := 7;
    2:i_modelo := 5;
    3:i_modelo := 5;
    5:i_modelo := 8;
  else
    Begin
      lbl_status.Caption := 'Modelos não implementados';
      exit;
    End;
  end;


  i_retorno:= IniciaPorta(pchar(s_porta));
  //ANºLISE DO RETORNO DE STATUS DAS IMPRESSORAS FISCAIS

  if s_porta='COM1' then s_stporta:='serial';
  if s_porta='COM2' then s_stporta:='serial';
  if s_porta='COM3' then s_stporta:='serial';
  if s_porta='COM4' then s_stporta:='serial';
  if s_porta='COM5' then s_stporta:='serial';
  if s_porta='COM6' then s_stporta:='serial';
  if s_porta='lpt1' then s_stporta:='lpt';
  if s_porta='lpt2' then s_stporta:='lpt';
  if s_porta='Ethernet' then s_stporta:='rede';

  i_retorno:=Le_Status();
  lb_CodStatus.caption := concat(IntToStr(i_retorno), ' - ');
//******************IMPRESSORAS MP 20 CI E MI - CONEXÃO SERIAL******************

  if (i_modelo=1) and (s_stporta='serial') then
    Begin
    if i_retorno= 24 then lbl_status.Caption:='24 - ON LINE';
    if i_retorno= 0 then lbl_status.Caption:='0 - OFF LINE';
    if i_retorno= 32 then lbl_status.Caption:='32 - SEM PAPEL';
    End;
//******************************************************************************

//******************IMPRESSORAS MP 20 CI E MI - CONEXÃO PARALELA****************

  if (i_modelo=1) and (s_stporta='lpt') then
    Begin
    if i_retorno= 144 then lbl_status.Caption:='144 - ON LINE';
    if i_retorno= 0 then lbl_status.Caption:='0 - OFF LINE OU IMP. SEM PAPEL';
    End;
//******************************************************************************

//******IMPRESSORAS MP 20 TH, 2000 CI 2000 TH 2100 TH - CONEXÃO SERIAL**********

  if (i_modelo=0) and (s_stporta='serial') then
    Begin
    if i_retorno= 0 then lbl_status.Caption:='0 - OFF LINE';
    if i_retorno= 24 then lbl_status.Caption:='24 - ON LINE OU POUCO PAPEL';
    if i_retorno= 32 then lbl_status.Caption:='32 - IMP. SEM PAPEL';
    End;
//******************************************************************************

//******IMPRESSORAS MP 20 TH, 2000 CI 2000 TH 2100 TH - CONEXÃO PARALELA********

  if (i_modelo=0) and (s_stporta='lpt') then
    Begin
    if i_retorno= 79 then lbl_status.Caption:='79 - OFF LINE';
    if i_retorno= 144 then lbl_status.Caption:='144 - ON LINE OU POUCO PAPEL';
    if i_retorno= 32 then lbl_status.Caption:='32 - IMP. SEM PAPEL';
    if i_retorno= 0 then lbl_status.Caption:='0 - ERRO DE COMUNICAÇÃO';
    End;
//******************************************************************************

//******************IMPRESSORAS MP 4000 TH CONEXÃO PARALELA*********************

  if (i_modelo=5) and (s_stporta='lpt') then
    Begin
    if i_retorno= 40 then lbl_status.Caption:='40 - IMP. OFF LINE/SEM COMUNICAÇÃO';
    if i_retorno= 24 then lbl_status.Caption:='24 - IMPRESSORA ON LINE';
    if i_retorno= 128 then lbl_status.Caption:='128 - IMP. SEM PAPEL';
    if i_retorno= 0 then lbl_status.Caption:='0 - POUCO PAPEL';
    End;
//******************************************************************************

//******************IMPRESSORAS MP 4000 TH CONEXÃO ETHERNET*********************

  if (i_modelo=5) and (s_stporta='rede') then
    Begin
    if i_retorno= 24 then lbl_status.Caption:='24 - IMPRESSORA ON LINE';
    if i_retorno= 0 then lbl_status.Caption:='0 - IMP. OFF LINE/SEM COMUNICAÇÃO';
    if i_retorno= 32 then lbl_status.Caption:='32 - IMP. SEM PAPEL';
    if i_retorno= 24 then lbl_status.Caption:='24 - ON LINE - POUCO PAPEL';
    End;
//******************************************************************************

//******************IMPRESSORAS MP 4000 TH CONEXÃO SERIAL***********************

  if (i_modelo=5) and (s_stporta='serial') then
    Begin
    if i_retorno= 24 then lbl_status.Caption:='24 - IMPRESSORA ON LINE';
    if i_retorno= 0 then lbl_status.Caption:='0 - IMP. OFF LINE/SEM COMUNICAÇÃO';
    if i_retorno= 32 then lbl_status.Caption:='32 - IMP. SEM PAPEL';
    if i_retorno= 5 then lbl_status.Caption:='5 - ON LINE - POUCO PAPEL';
    End;
//******************************************************************************

//*********************IMPRESSORAS MP 4000 TH CONEXÃO USB***********************

  if (i_modelo=5) and (s_stporta='serial') then
    Begin
    if i_retorno= 24 then lbl_status.Caption:='24 - IMPRESSORA ON LINE';
    if i_retorno= 68 then lbl_status.Caption:='68 - IMP. OFF LINE/SEM COMUNICAÇÃO';
    if i_retorno= 32 then lbl_status.Caption:='32 - IMP. SEM PAPEL';
    if i_retorno= 24 then lbl_status.Caption:='24 - ON LINE - POUCO PAPEL';
    End;
//******************************************************************************

//*******************IMPRESSORAS MP 4200 TH CONEXÃO TODAS***********************

  if (i_modelo=7) then
    Begin
    if i_retorno= 24 then lbl_status.Caption:='24 - IMPRESSORA ON LINE';
    if i_retorno= 0 then lbl_status.Caption:='0 - IMP. OFF LINE/SEM COMUNICAÇÃO';
    if i_retorno= 32 then lbl_status.Caption:='32 - IMP. SEM PAPEL';
    if i_retorno= 5 then lbl_status.Caption:='5 - ON LINE - POUCO PAPEL';
    if i_retorno= 9 then lbl_status.Caption:='9 - TAMPA ABERTA';
    End;
//******************************************************************************



end;

procedure TFr_Configuracao.Button2Click(Sender: TObject);
begin
  AtivaESCPOS;
  Pc_ConfiguraGavetaACBR;
  Pc_AbreGaveta;
end;

procedure TFr_Configuracao.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Configuracao.Button5Click(Sender: TObject);
begin
  Fc_Aq_Geral('G','BALANCA','BAL_P_TARA',sttPeso.Caption);
end;

procedure TFr_Configuracao.Button7Click(Sender: TObject);
begin
  if Fc_Valida_Aba_Estoque then
  Begin
    Pc_Grava_Aba_Estoque;
    Close;
  end;
end;

procedure TFr_Configuracao.Button8Click(Sender: TObject);
begin
  if Fc_Valida_Aba_Estoque then Pc_Grava_Aba_Estoque;
end;

procedure TFr_Configuracao.chbx_Ctrl_despachoClick(Sender: TObject);
begin
  if not chbx_Ctrl_despacho.Checked then
  Begin
    Chbx_despacho_by_cod_barra.Checked := false;
    Chbx_despacho_by_cod_barra.Enabled := False;
  end
  else
  Begin
    Chbx_despacho_by_cod_barra.Enabled := True;
  End;
end;

procedure TFr_Configuracao.Sb_BuffetClick(Sender: TObject);
Var
  Lc_Form : TSeaProduct;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TSeaProduct.Create(Self);
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Configuracao.Btn_Cn_1Click(Sender: TObject);
begin
  CLOSE;
end;

function TFr_Configuracao.Fc_Valida_Aba_Estoque: Boolean;
begin
  REsult := True;
  if ChBx_est_Avise_Saldo_Zero.Checked then
  Begin
    if (Trim(E_est_email_notifica.Text) = '') then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Usando a opção para notificar estoque zerado ou negativo.' + EOLN +
                     'é obrigatório informar o email de quem vai receber a notificação. ' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      Result := False;
      E_est_email_notifica.SetFocus;
      exit;
    end;
  end;
end;

function TFr_Configuracao.Fc_Valida_Aba_Produtos():Boolean;
Begin
  Result := True;
  if ChBx_DesativaProduto.Checked then
  Begin
    if (StrToIntDef(E_ProMovimento.Text,0) =0) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Usando a opção Desativar produto com saldo zero no cadastro.' + EOLN +
                     'Preecher a quantidade de dias para verificar Inatividade. ' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      Result := False;
      E_ProMovimento.SetFocus;
      exit;
    end;
  end;
end;


procedure TFr_Configuracao.Sb_Ap_10Click(Sender: TObject);
begin
  if Valida_Grava_Aba_Despacho then
    Pc_Grava_Aba_Despacho;
end;

procedure TFr_Configuracao.Sb_OK_10Click(Sender: TObject);
begin
  if Valida_Grava_Aba_Despacho then
  Begin
    Pc_Grava_Aba_Despacho;
    close;
  End;
end;

procedure TFr_Configuracao.Sb_Cn_10Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Configuracao.tbs_DespachoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Despacho;
end;

procedure TFr_Configuracao.tbs_estoqueShow(Sender: TObject);
begin
  Pc_Abre_Aba_Estoque;
end;

procedure TFr_Configuracao.Chbx_Ctrl_separacaoClick(Sender: TObject);
begin
  if not Chbx_Ctrl_separacao.Checked then
  Begin
    chbx_Imp_auto_Separacao.Checked := false;
    chbx_Imp_auto_Separacao.Enabled := False;
  end
  else
  Begin
    chbx_Imp_auto_Separacao.Enabled := True;
  End;

end;

procedure TFr_Configuracao.Pc_ConsultaRegistroProdutoAvulso;
Var
  Lc_Produto : TControllerProduto;
Begin
  Try
    Lc_Produto := TControllerProduto.create(Nil);
    if Chbx_ProdutoAvulso.Checked then
    Begin
      Lc_Produto.getProdutoAvulso;
      if Lc_Produto.exist then
      Begin
        Fc_Tb_Geral('G','FRT_PRODUTOAVULSO','S');
      end
      else
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Não foi encontrado o registro "PRODUTO AVULSO" no Cadastro.'+EOLN+
                       'Antes de usar esta opção registre o produto conforme descrito acima.'+EOLN+
                       'Verifique e tente novamente.'+EOLN,
                       ['OK'],[bEscape],mpAlerta);
        Fc_Tb_Geral('G','FRT_PRODUTOAVULSO','N');
        Chbx_ProdutoAvulso.Checked := False;
      end;
    end
    else
    BEGIN
      Fc_Tb_Geral('G','FRT_PRODUTOAVULSO','N');
    END;
  Finally
    FreeAndNil(Lc_Produto);
  End;
end;

procedure TFr_Configuracao.E_Ctrl_Cpa_Valor_TotalExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrtoFloatDef(E_Ctrl_Cpa_Valor_Total.Text,0);
  E_Ctrl_Cpa_Valor_Total.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Configuracao.Btn_Ok_11Click(Sender: TObject);
begin
  Pc_Grava_Aba_Tributos;
  Close;
end;

procedure TFr_Configuracao.Btn_Cn_11Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Configuracao.Btn_Ap_11Click(Sender: TObject);
begin
  Pc_Grava_Aba_Tributos;
end;

procedure TFr_Configuracao.TabSheet7Show(Sender: TObject);
begin
  Pc_Abre_Aba_Tributos;
end;

procedure TFr_Configuracao.tbsTEFShow(Sender: TObject);
begin
  Pc_Abre_Aba_TEF;
end;

end.






