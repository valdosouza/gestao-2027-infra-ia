unit Un_Configuracao_Local;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, Grids, DBGrids, StdCtrls, Printers, Buttons, Mask, DBCtrls, ExtCtrls, STQuery, ComCtrls, IniFiles, STDatabase, QEdit_Setes, ActnList, ACBrBase, ACBrBAL, ACBrDevice, ACBrGAV, Actions, ACBrDeviceSerial;

type
  TFr_Configuracao_Local = class(TForm)
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
    Chbx_dt_Padrao: TCheckBox;
    Btn_Ap_1: TButton;
    Tbs_OrdemServico: TTabSheet;
    Panel3: TPanel;
    Tbs_Impressao: TTabSheet;
    Panel5: TPanel;
    ChBx_Vis_Relatorio: TCheckBox;
    ChBx_Cupom: TCheckBox;
    Tbs_Produto: TTabSheet;
    Panel4: TPanel;
    Chbx_CodigoExato: TCheckBox;
    ChBx_Distingue_Produto: TCheckBox;
    Cbx_TipoMatric: TComboBox;
    Cbx_TipoLaser: TComboBox;
    Btn_Ok_3: TButton;
    Button10: TButton;
    Btn_Ap_3: TButton;
    Btn_Ok_4: TButton;
    Btn_Cn_4: TButton;
    Btn_Ap_4: TButton;
    Btn_Ok_5: TButton;
    Btn_Cn_5: TButton;
    Btn_Ap_5: TButton;
    Chb_ImpSalto: TCheckBox;
    Chb_ImpCondensa: TCheckBox;
    tbs_pedidos: TTabSheet;
    Panel6: TPanel;
    Btn_Ok_9: TButton;
    Btn_Cn_9: TButton;
    Btn_Ap_9: TButton;
    tbs_orcamento: TTabSheet;
    Panel12: TPanel;
    Btn_Ok_11: TButton;
    Btn_Cn_11: TButton;
    Btn_Ap_11: TButton;
    rdg_PedOrc_Imp: TRadioGroup;
    GroupBox19: TGroupBox;
    e_porta_ImpOrc: TEdit;
    e_salto_Orc: TEdit_Setes;
    GroupBox21: TGroupBox;
    e_itens_oRC: TEdit_Setes;
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
    GroupBox24: TGroupBox;
    E_PortaImpressao: TEdit;
    E_SaltoImpressao: TEdit_Setes;
    Ds_Pesquisa: TDataSource;
    ACBrGAV1: TACBrGAV;
    pg_pedidos: TPageControl;
    tbs_controle_compra: TTabSheet;
    Label41: TLabel;
    Label6: TLabel;
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
    Label56: TLabel;
    cbx_modeloMat_Frt: TComboBox;
    cbx_modeloTer_frt: TComboBox;
    ChBx_DesativaECF: TCheckBox;
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
    Dblcb_TabelasRevendedor: TDBLookupComboBox;
    rdg_PedfRT_Imp: TGroupBox;
    RB_ImpMatricial_Frt: TRadioButton;
    RB_ImpTermica_Frt: TRadioButton;
    RB_ImpPedido_Frt: TRadioButton;
    GroupBox27: TGroupBox;
    e_salto_Frt: TEdit_Setes;
    Chb_ImpCupom: TCheckBox;
    Chb_Visualiza_Cupom: TCheckBox;
    ChBx_CodigoBarra: TCheckBox;
    Chbx_ProdutoAvulso: TCheckBox;
    Label47: TLabel;
    Cb_TipoImpressora: TComboBox;
    E_Nr_Colunas: TEdit_Setes;
    Label57: TLabel;
    e_porta_Frt: TEdit;
    ChBx_UsarCodigoFAb: TCheckBox;
    ChBx_Imp_Item_Checkout: TCheckBox;
    tbs_controle_Pizzaria: TTabSheet;
    Panel15: TPanel;
    rdg_PedPiz_Imp: TGroupBox;
    RB_ImpMatricial_Piz: TRadioButton;
    RB_ImpTermica_Piz: TRadioButton;
    GroupBox29: TGroupBox;
    e_salto_Piz: TEdit_Setes;
    e_porta_Piz: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    ChBx_Placa: TCheckBox;
    Cb_ImpOrdemServico: TComboBox;

    Label59: TLabel;
    E_Cpm_Modelo: TComboBox;
    E_Cpm_Nr_Vias: TEdit_Setes;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Cb_Cpm_TipoImpressora: TComboBox;
    E_Cpm_Colunas: TEdit_Setes;
    Label5: TLabel;
    Label16: TLabel;
    cbx_modeloMat_Piz: TComboBox;
    cbx_modeloTer_Piz: TComboBox;
    GroupBox22: TGroupBox;
    Label18: TLabel;
    E_Tra_Str_Ini_Piz: TEdit;
    E_Tra_Str_Tam_Piz: TEdit;
    Label63: TLabel;
    GroupBox28: TGroupBox;
    Rb_bal_bar_Peso: TRadioButton;
    Rb_bal_bar_Preco: TRadioButton;
    E_bal_bar_Cd_Produto: TEdit_Setes;
    Label64: TLabel;
    Label65: TLabel;
    Lb_blc_bar_Preco_Peso: TLabel;
    E_bal_bar_Preco_Peso: TEdit_Setes;
    ChBx_InformaValor: TCheckBox;
    Rg_Rdp_Fte_Padrao: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Tbs_GeralShow(Sender: TObject);
    procedure Btn_Ok_1Click(Sender: TObject);
    procedure Btn_Ok_3Click(Sender: TObject);
    procedure Btn_Ok_4Click(Sender: TObject);
    procedure Btn_Ap_4Click(Sender: TObject);
    procedure Btn_Ap_3Click(Sender: TObject);
    procedure Btn_Ap_1Click(Sender: TObject);
    procedure Tbs_ImpressaoShow(Sender: TObject);
    procedure Tbs_OrdemServicoShow(Sender: TObject);
    procedure Tbs_ProdutoShow(Sender: TObject);
    procedure tbs_pedidosShow(Sender: TObject);
    procedure Btn_Ap_8Click(Sender: TObject);
    procedure Btn_Ok_8Click(Sender: TObject);
    procedure Btn_Cn_8Click(Sender: TObject);
    procedure Btn_Ok_9Click(Sender: TObject);
    procedure Btn_Ap_9Click(Sender: TObject);
    procedure Btn_Cn_10Click(Sender: TObject);
    procedure Btn_Ap_11Click(Sender: TObject);
    procedure tbs_orcamentoShow(Sender: TObject);
    procedure Btn_Ok_11Click(Sender: TObject);
    procedure Btn_Cn_11Click(Sender: TObject);
    procedure pg_pedidosChange(Sender: TObject);
    procedure Btn_Ok_12Click(Sender: TObject);
    procedure Btn_AP_12Click(Sender: TObject);
    procedure Tbs_BalancaShow(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure btnDesconectarClick(Sender: TObject);
    procedure btnLerPesoClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Rb_bal_bar_PesoClick(Sender: TObject);
    procedure Rb_bal_bar_PrecoClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Btn_Ok_5Click(Sender: TObject);
    procedure Btn_Ap_5Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    It_Conectado : Integer;
    procedure Pc_Abre_Aba_Geral;
    procedure Pc_Grava_Aba_Geral;
    procedure Pc_Abre_Aba_Os;
    procedure Pc_Grava_Aba_OS;
    procedure Pc_Abre_Aba_Impressao;
    procedure Pc_Grava_Aba_Impressao;
    procedure Pc_Abre_Aba_Produtos;

    procedure Pc_Grava_Aba_Produtos;
    procedure Pc_Grava_Aba_Controle_Venda;
    procedure Pc_Abre_Aba_Controle_Venda;
    procedure Pc_Grava_Aba_Controle_Compra;
    procedure Pc_Abre_Aba_Controle_Compra;
    procedure Pc_Grava_Aba_Controle_Frente;
    procedure Pc_Abre_Aba_Controle_Frente;

    procedure Pc_Grava_Aba_Controle_Pizzaria;
    procedure Pc_Abre_Aba_Controle_Pizzaria;


    procedure Pc_Grava_Aba_Controle_Orcamento;
    procedure Pc_Abre_Aba_Controle_Orcamento;
    procedure Pc_Grava_Geral_Pedido;
    procedure Pc_Abre_Aba_Geral_Pedido;
    procedure Pc_Grava_Aba_Balanca;
    procedure Pc_Abre_Aba_Balanca;

  end;

var
  Fr_Configuracao_Local: TFr_Configuracao_Local;

implementation

uses     Un_DM, UN_MSG, UN_Sistema, un_principal, env, Un_Produtos, Un_Regra_Negocio, Un_Fc_Sored_Procedures, RN_Permissao;

{$R *.dfm}


procedure TFr_Configuracao_Local.Pc_Abre_Aba_Geral;
Begin
  //Controle de Dados Gerais
  Rb_Aniv_Dia.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_DIA','S') = 'S';
  Rb_Aniv_Semana.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_SEMANA','S') = 'S';
  Rb_Aniv_Mes.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_MES','S') = 'S';
  E_Aniv_DataIni.Text := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_INI','0');
  E_Aniv_DataFim.Text := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_FIM','0');
  ChBx_Aniver.Checked := Fc_Aq_Geral('L','ANIVER','GRL_P_ANIV_TELA','S') = 'S';
end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_Geral;
Begin
 //Controle de Dados Gerais
  if Rb_Aniv_Dia.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_DIA','S') else Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_DIA','N');
  if Rb_Aniv_Semana.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_SEMANA','S') else Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_SEMANA','N');
  if Rb_Aniv_Mes.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_MES','S') else  Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_MES','N');
  Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_INI', E_Aniv_DataIni.text);
  Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_FIM',E_Aniv_DataFim.text);
  if ChBx_Aniver.Checked then Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_TELA','S') else Fc_Aq_Geral('G','ANIVER','GRL_P_ANIV_TELA','N');

end;


procedure TFr_Configuracao_Local.Pc_Abre_Aba_Os;
Begin
  //Controle de Ordem de Serviços
  ChBx_Placa.Checked := (Fc_Aq_Geral('L','ORDEM DE SERVICO','OSR_P_MOSTRA_PLACA','N') = 'S');

end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_OS;
Begin
  if ChBx_Placa.Checked   then Fc_Aq_Geral('G','ORDEM DE SERVICO','OSR_P_MOSTRA_PLACA','S') else Fc_Aq_Geral('G','ORDEM DE SERVICO','OSR_P_MOSTRA_PLACA','N');
  //modelo de impressao Estiqueta para extintores

end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Impressao;
Begin
  //Controle de impressão
  ChBx_Vis_Relatorio.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S');
  ChBx_Cupom.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_TP_CUPOM_FAT','') = 'S');
  Chb_ImpSalto.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S');
  Chb_ImpCondensa.Checked := (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_CONDENSA','S') = 'S');
  E_PortaImpressao.Text := Fc_Aq_Geral('L','IMPRESSAO','PORTA',E_PortaImpressao.Text);
  E_SaltoImpressao.Text :=Fc_Aq_Geral('L','IMPRESSAO','SALTO','0');

  //modelo de impressao estilo Cupom
  Cb_Cpm_TipoImpressora.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_P_MOD_IMPRESSAO', ''),0)-1;
  E_Cpm_Nr_Vias.Text := Fc_Aq_Geral('L','IMPRESSAO','CPM_NR_VIAS','');

  //modelo de impressao estilo Cupom
  E_Cpm_Modelo.ItemIndex := StrTOIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_P_MOD_IMPRESSAO','1'),1) -1;
  //Numero de vias
  E_Cpm_Nr_Vias.Text := Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_VIAS','');
  //Tipo de Impressora
  Cb_Cpm_TipoImpressora.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_TIPO_IMPRESSORA', '1'),1) -1;
  //Numero de Colunas
  E_Cpm_Colunas.Text := Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', '');
  //Tamanho da Fonte
  Rg_Rdp_Fte_Padrao.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_RPD_FTE_PADRAO', '1'),1);
end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_Impressao;
Begin
  //Controle de impressão
  if ChBx_Vis_Relatorio.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_VISUALIZA','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_VISUALIZA','N');
  if ChBx_Cupom.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_TP_CUPOM_FAT','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_TP_CUPOM_FAT','N');
  if Chb_ImpSalto.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_EJECTA','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_EJECTA','N');
  if Chb_ImpCondensa.Checked then Fc_Aq_Geral('G','IMPRESSAO','IMP_P_CONDENSA','S') else Fc_Aq_Geral('G','IMPRESSAO','IMP_P_CONDENSA','N');

  Fc_Aq_Geral('G','IMPRESSAO','PORTA',E_PortaImpressao.Text);
  Fc_Aq_Geral('G','IMPRESSAO','SALTO',E_SaltoImpressao.Text);

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
end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Produtos;
Begin
  //Controle de Dados DOS PRODUTOS
  Chbx_CodigoExato.Checked := (Fc_Aq_Geral('L','PRODUTO','PRO_P_COD_EXATO','S') = 'S');
  ChBx_Distingue_Produto.Checked := (Fc_Aq_Geral('L','PRODUTO','PRO_P_DISTG_PA_MP','S') = 'S');
end;



procedure TFr_Configuracao_Local.Pc_Grava_Aba_Produtos;
Begin
 //Controle de Dados Referente aos Produtos
  if Chbx_CodigoExato.Checked   then Fc_Aq_Geral('G','PRODUTO','PRO_P_COD_EXATO','S') else Fc_Aq_Geral('G','PRODUTO','PRO_P_COD_EXATO','N');
  if ChBx_Distingue_Produto.Checked   then Fc_Aq_Geral('G','PRODUTO','PRO_P_DISTG_PA_MP','S') else Fc_Aq_Geral('G','PRODUTO','PRO_P_DISTG_PA_MP','N');
end;



procedure TFr_Configuracao_Local.FormCreate(Sender: TObject);
begin
  It_Conectado := 1;
  Pg_Configuracao.ActivePageIndex:=0;

end;

procedure TFr_Configuracao_Local.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Configuracao_Local.Tbs_GeralShow(Sender: TObject);
begin
  Pc_Abre_Aba_Geral;
end;

procedure TFr_Configuracao_Local.Btn_Ok_1Click(Sender: TObject);
begin
  Pc_Grava_Aba_Geral;
  Close;
end;

procedure TFr_Configuracao_Local.Btn_Ok_3Click(Sender: TObject);
begin
  Pc_Grava_Aba_OS;
  Close;
end;

procedure TFr_Configuracao_Local.Btn_Ok_4Click(Sender: TObject);
begin
  Pc_Grava_Aba_Impressao;
  Close;
end;

procedure TFr_Configuracao_Local.Btn_Ap_4Click(Sender: TObject);
begin
  Pc_Grava_Aba_Impressao
end;

procedure TFr_Configuracao_Local.Btn_Ap_3Click(Sender: TObject);
begin
  Pc_Grava_Aba_OS
end;

procedure TFr_Configuracao_Local.Btn_Ap_1Click(Sender: TObject);
begin
  Pc_Grava_Aba_Geral
end;

procedure TFr_Configuracao_Local.Tbs_ImpressaoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Impressao;
end;

procedure TFr_Configuracao_Local.Tbs_OrdemServicoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Os;
end;

procedure TFr_Configuracao_Local.Tbs_ProdutoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Produtos;
end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_Controle_Venda;
begin
  if (ChBx_InformaValor.Checked = True) then
    Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_EDIT_VALOR_PESO','S')
  else
    Fc_Aq_Geral('G','CONTROLE DE VENDA','VDA_P_EDIT_VALOR_PESO','N');
end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Controle_Venda;
begin




end;

procedure TFr_Configuracao_Local.tbs_pedidosShow(Sender: TObject);
begin
  Pc_Abre_Aba_Geral_Pedido;
  pg_pedidos.ActivePage := tbs_controle_compra;
  Pc_Abre_Aba_Controle_Venda
end;

procedure TFr_Configuracao_Local.Btn_Ap_8Click(Sender: TObject);
begin
  Pc_Grava_Aba_Controle_Venda;
end;

procedure TFr_Configuracao_Local.Btn_Ok_8Click(Sender: TObject);
begin
  Pc_Grava_Aba_Controle_Venda;
  close;
end;

procedure TFr_Configuracao_Local.Btn_Cn_8Click(Sender: TObject);
begin
close;
end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Controle_Compra;
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



end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_Controle_Compra;
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
end;




procedure TFr_Configuracao_Local.Pc_Grava_Aba_Controle_Frente;
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

  //Desativar o ECF
  if ChBx_DesativaECF.Checked  then
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_DESATIVA_ECF', 'S')
  else
    Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_DESATIVA_ECF', 'N');

  //Opções de Impressao do Cupom
  if ChBx_CodigoBarra.Checked then Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_BARRAS_CUPOM','S') else Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_BARRAS_CUPOM','N');
  if Chb_ImpCupom.Checked then Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_FRENTE','S') else Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_FRENTE','N');
  if Chb_Visualiza_Cupom.Checked then Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') else Fc_Aq_Geral('G','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','N');
  //vERIFICA SE DISPONIBILIZA PRODUTO AVULSO


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

end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Controle_Frente;
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

  //Desativar o ECF
  ChBx_DesativaECF.Checked :=(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_DESATIVA_ECF', 'N') = 'S');

  //Opções de Impressao do Cupom
  ChBx_CodigoBarra.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_BARRAS_CUPOM','S') = 'S');
  Chb_ImpCupom.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_FRENTE','S') = 'S');
  Chb_Visualiza_Cupom.Checked  := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') = 'S') ;
  //Tipo de Impressora
  Cb_TipoImpressora.ItemIndex := StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_TIPO_IMPRESSORA', '1'),1) - 1;
  //Número de Colunas
  E_Nr_Colunas.Text := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '');

  //FAz a Busca por codigo de Fabrica
  ChBx_UsarCodigoFAb.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_PESQ_COD_FAB', 'N') = 'S');

  //Utilizar sistemática de impressão item a item na leitura do produto no checkout
  ChBx_Imp_Item_Checkout.Checked := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_ITEM_CHECKOUT', 'N') = 'S');
end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_Controle_Pizzaria;
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


  //Identificador de chamada


  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_INI',E_Tra_Str_Ini_Piz.Text);
  Fc_Aq_Geral('G','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_TAM',E_Tra_Str_Tam_Piz.Text);

end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Controle_Pizzaria;
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


  E_Tra_Str_Ini_Piz.Text := Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_INI','3');
  E_Tra_Str_Tam_Piz.Text := Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_TAM','8');


end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_Controle_Orcamento;
begin
  //imprimi pedido impressora
  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_IMPRESSORA',IntToStr(rdg_PedOrc_Imp.ItemIndex));

  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_PORTA',e_porta_ImpOrc.Text);
  Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_SALTO',e_salto_Orc.Text);


  //Ites por folha
    Fc_Aq_Geral('G','CONTROLE DE ORCAMENTO','ORC_P_ITENS_FOLHA',e_itens_ORC.Text);

end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Controle_Orcamento;
begin
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

end;

procedure TFr_Configuracao_Local.Btn_Ok_9Click(Sender: TObject);
begin
  Pc_Grava_Geral_Pedido;
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

procedure TFr_Configuracao_Local.Btn_Ap_9Click(Sender: TObject);
begin
  Pc_Grava_Geral_Pedido;
  if pg_pedidos.ActivePage = tbs_controle_compra then
    Pc_Grava_Aba_Controle_Compra
  else
  if pg_pedidos.ActivePage = tbs_controle_Frente then
    Pc_Grava_Aba_Controle_Frente
  else
  if pg_pedidos.ActivePage = tbs_controle_Pizzaria then
    Pc_Grava_Aba_Controle_Pizzaria;
end;

procedure TFr_Configuracao_Local.Btn_Cn_10Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Configuracao_Local.Btn_Ap_11Click(Sender: TObject);
begin
  Pc_Grava_Aba_Controle_Orcamento
end;

procedure TFr_Configuracao_Local.tbs_orcamentoShow(Sender: TObject);
begin
  Pc_Abre_Aba_Controle_Orcamento;
end;

procedure TFr_Configuracao_Local.Btn_Ok_11Click(Sender: TObject);
begin
  Pc_Grava_Aba_Controle_Orcamento;
  close;
end;

procedure TFr_Configuracao_Local.Btn_Cn_11Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Geral_Pedido;
begin

end;

procedure TFr_Configuracao_Local.Pc_Grava_Geral_Pedido;
begin
end;

procedure TFr_Configuracao_Local.pg_pedidosChange(Sender: TObject);
begin
  if pg_pedidos.ActivePage = tbs_controle_compra then
    Pc_ABRE_Aba_Controle_Compra
  else
  if pg_pedidos.ActivePage = tbs_controle_Frente then
    Pc_Abre_Aba_Controle_Frente
  else
  if pg_pedidos.ActivePage = tbs_controle_Pizzaria then
    Pc_Abre_Aba_Controle_Pizzaria;

end;

procedure TFr_Configuracao_Local.Pc_Abre_Aba_Balanca;
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
  if (Fc_Aq_Geral('L','BALANCA','BAL_BAR_KIND_READ','PESO') = 'PESO') then
  Begin
    Rb_bal_bar_Peso.Checked := True;
    Rb_bal_bar_Preco.Checked := False;
  end
  else
  Begin
    Rb_bal_bar_Peso.Checked := False;
    Rb_bal_bar_Preco.Checked := true;
  end;
  //Bloco do codigo de produto
  E_bal_bar_Cd_Produto.Text := Fc_Aq_Geral('L','BALANCA','BAL_BAR_CD_PRODUTO','6');
  //Bloco do codigo de peso ou preco
  E_bal_bar_Preco_Peso.Text := Fc_Aq_Geral('L','BALANCA','BAL_BAR_PRECO_QTDE','6');

end;

procedure TFr_Configuracao_Local.Pc_Grava_Aba_Balanca;
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

  //cODIGO DE bARRASDA bALANCA
  if Rb_bal_bar_Peso.Checked then
  Begin
    Fc_Aq_Geral('G','BALANCA','BAL_BAR_KIND_READ','PESO');
  end
  else
  Begin
    Fc_Aq_Geral('G','BALANCA','BAL_BAR_KIND_READ','PRECO');
  end;
  //Bloco do codigo de produto
  Fc_Aq_Geral('G','BALANCA','BAL_BAR_CD_PRODUTO',E_bal_bar_Cd_Produto.Text);
  //Bloco do codigo de peso ou preco
  Fc_Aq_Geral('G','BALANCA','BAL_BAR_PRECO_QTDE',E_bal_bar_Preco_Peso.Text);
end;

procedure TFr_Configuracao_Local.Btn_Ok_12Click(Sender: TObject);
begin
  Pc_Grava_Aba_Balanca;
  close;
end;

procedure TFr_Configuracao_Local.Btn_AP_12Click(Sender: TObject);
begin
  Pc_Grava_Aba_Balanca;
end;

procedure TFr_Configuracao_Local.Tbs_BalancaShow(Sender: TObject);
begin
  Pc_Abre_Aba_Balanca;
end;

procedure TFr_Configuracao_Local.btnConectarClick(Sender: TObject);
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
   btnDesconectar.Enabled := true;
   btnLerPeso.Enabled     := true;
end;

procedure TFr_Configuracao_Local.btnDesconectarClick(Sender: TObject);
begin
  Balanca.Desativar;

  btnConectar.Enabled    := True;
  btnDesconectar.Enabled := False;
  btnLerPeso.Enabled     := False;
end;

procedure TFr_Configuracao_Local.btnLerPesoClick(Sender: TObject);
Var TimeOut : Integer ;
begin
   try
      TimeOut := StrToInt( E_Timer.Text ) ;
   except
      TimeOut := 2000 ;
   end ;

   sttPeso.Caption := FloatToStrF(Balanca.LePeso( TimeOut ),ffFixed,10,3);
end;

procedure TFr_Configuracao_Local.Button5Click(Sender: TObject);
begin
  Fc_Aq_Geral('G','BALANCA','BAL_P_TARA',sttPeso.Caption);
end;



procedure TFr_Configuracao_Local.Rb_bal_bar_PesoClick(Sender: TObject);
begin
  if Rb_bal_bar_Peso.Checked then
  Begin
    Rb_bal_bar_preco.Checked := False;
    Lb_blc_bar_Preco_Peso.CAption := 'Peso';
  end
  else
  Begin
    Rb_bal_bar_preco.Checked := True;
    Rb_bal_bar_Peso.Checked := False;
    Lb_blc_bar_Preco_Peso.Caption := 'Preço';
  end;
end;

procedure TFr_Configuracao_Local.Rb_bal_bar_PrecoClick(Sender: TObject);
begin
  if Rb_bal_bar_Preco.Checked then
  Begin
    Rb_bal_bar_Peso.Checked := False;
    Lb_blc_bar_Preco_Peso.Caption := 'Preço';
  end
  else
  Begin
    Rb_bal_bar_Peso.Checked := True;
    Lb_blc_bar_Preco_Peso.Caption := 'Peso';
  end;
end;

procedure TFr_Configuracao_Local.Button10Click(Sender: TObject);
begin
  close;
end;

procedure TFr_Configuracao_Local.Btn_Ok_5Click(Sender: TObject);
begin
  Pc_Grava_Aba_Produtos;
  Pc_Define_CasasDecimais;
  Close;
end;

procedure TFr_Configuracao_Local.Btn_Ap_5Click(Sender: TObject);
begin
  Pc_Grava_Aba_Produtos;
  Pc_Define_CasasDecimais;
end;

end.






