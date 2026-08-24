unit tas_gera_nfe_config;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_geranfe3X, STDataSet, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Menus, Data.DB, STQuery, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, System.StrUtils, ACBrPosPrinter;

type
  TTasGeraNfeConfig = class(TFr_GeraNfe3x)
    tbs_config: TTabSheet;
    Panel8: TPanel;
    SB_Cfg_Alterar: TSpeedButton;
    SB_Cfg_Gravar: TSpeedButton;
    Sb_Cfg_Cancelar: TSpeedButton;
    Sb_Cfg_Sair: TSpeedButton;
    Pnl_Nfe: TPanel;
    Label18: TLabel;
    Pg_NFeConfig: TPageControl;
    tbs_ConfigGeral: TTabSheet;
    Pnl_Config_Geral: TPanel;
    Label24: TLabel;
    Label2: TLabel;
    Rg_Orien_Danfe: TRadioGroup;
    Rg_Emissao: TRadioGroup;
    GroupBox6: TGroupBox;
    ChBx_NotaDuplicata: TCheckBox;
    ChBx_NotaDuplicataOcultaAVista: TCheckBox;
    Rg_Ambiente: TRadioGroup;
    chbx_Visualizar: TCheckBox;
    Rg_posicao_CAnhoto: TRadioGroup;
    E_email_contador: TEdit;
    chbx_copia_nfe: TCheckBox;
    ChBx_MostraCodigoDestinatario: TCheckBox;
    E_NF_Serie: TEdit;
    Chbx_Bloqueia_Fechamento_Caixa: TCheckBox;
    tbs_arquivosNfe: TTabSheet;
    Pnl_Config_Arquivos: TPanel;
    Sb_PathNFe: TSpeedButton;
    Label35: TLabel;
    Label39: TLabel;
    Sb_PathCan: TSpeedButton;
    Label46: TLabel;
    Sb_PathCCe: TSpeedButton;
    Label40: TLabel;
    Sb_PathInu: TSpeedButton;
    Label41: TLabel;
    Sb_PathDPEC: TSpeedButton;
    Label47: TLabel;
    Sb_PathEvento: TSpeedButton;
    Label7: TLabel;
    Sb_PathNFCe: TSpeedButton;
    cbxSalvarArqs: TCheckBox;
    cbxPastaMensal: TCheckBox;
    cbxAdicionaLiteral: TCheckBox;
    cbxEmissaoPathNFe: TCheckBox;
    cbxSalvaCCeCancelamentoPathEvento: TCheckBox;
    cbxSepararPorCNPJ: TCheckBox;
    edtPathCCe: TEdit;
    edtPathNFe: TEdit;
    edtPathCan: TEdit;
    edtPathInu: TEdit;
    edtPathDPEC: TEdit;
    edtPathEvento: TEdit;
    cbxSepararPorModelo: TCheckBox;
    edtPathNFCe: TEdit;
    tbs_config_NFC_e: TTabSheet;
    Pnl_Config_NFCe: TPanel;
    Label30: TLabel;
    Label32: TLabel;
    Panel2: TPanel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    cbxPortaNFCe: TComboBox;
    CbxModeloNFCe: TComboBox;
    CbxVelocidadeNFCe: TComboBox;
    edtLinhasEntreCupomNFCE: TSpinEdit;
    ChBx_NFCe: TCheckBox;
    GroupBox1: TGroupBox;
    Label33: TLabel;
    Label34: TLabel;
    edtIdToken: TEdit;
    edtToken: TEdit;
    chkImprimirDescAcresItemNFCE: TCheckBox;
    ChBx_ESCPOS: TCheckBox;
    ChBx_EscPos_AtivaInicio: TCheckBox;
    chbx_Imp_auto_Esc_pos: TCheckBox;
    E_Linha_Entre_Cupom: TEdit;
    E_LarguraBobina: TEdit;
    TabSheet2: TTabSheet;
    Pnl_Config_Outras: TPanel;
    chbx_Rastrea_completo: TCheckBox;
    chbx_Prenche_Lote_Valida: TCheckBox;
    chbx_mostra_Lote: TCheckBox;
    TabSheet3: TTabSheet;
    Pnl_Config_Certificado: TPanel;
    lSSLLib1: TLabel;
    lblXmlSign: TLabel;
    lblSSLLib: TLabel;
    lblCryptLib: TLabel;
    lblHttpLib: TLabel;
    GroupBox2: TGroupBox;
    sbtnGetCert: TSpeedButton;
    Label17: TLabel;
    Label28: TLabel;
    Lb_Explica_Certificado: TLabel;
    E_Serie_Certificado: TEdit;
    E_Senha_Certificado: TEdit;
    Rg_SSLTLS: TRadioGroup;
    Rg_TipoCertificado: TRadioGroup;
    cbSSLType: TComboBox;
    cbSSLLib: TComboBox;
    cbXmlSignLib: TComboBox;
    cbHttpLib: TComboBox;
    cbCryptLib: TComboBox;
    tbs_config_nfe: TTabSheet;
    Pnl_Config_Nfe: TPanel;
    Label37: TLabel;
    Label38: TLabel;
    Label48: TLabel;
    E_Nfe_Margem_Esquerda: TEdit;
    E_Nfe_Margem_Superior: TEdit;
    E_Nfe_Margem_Inferior: TEdit;
    chbx_Sem_Codigo_Barras: TCheckBox;
    Mnu_Principal: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sb_PathNFeClick(Sender: TObject);
    procedure Sb_PathCanClick(Sender: TObject);
    procedure Sb_PathCCeClick(Sender: TObject);
    procedure Sb_PathInuClick(Sender: TObject);
    procedure Sb_PathDPECClick(Sender: TObject);
    procedure Sb_PathEventoClick(Sender: TObject);
    procedure Sb_PathNFCeClick(Sender: TObject);
    procedure SB_Cfg_AlterarClick(Sender: TObject);
    procedure SB_Cfg_GravarClick(Sender: TObject);
    procedure Sb_Cfg_CancelarClick(Sender: TObject);
    procedure Sb_Cfg_SairClick(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure Rg_TipoCertificadoClick(Sender: TObject);
    procedure MnuStatusServicoClick(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
  private
    EditionState : String;

    procedure AtualizaLibs;

    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;

    procedure ShowData;
    procedure ShowNFe;
    procedure ShowNFce;
    procedure ShowNoData;
    procedure ClearAllFields;
    //Editar
    function ValidateChange():boolean;
    procedure Change;
    //Salvar
    function ValidateSave():boolean;
    procedure Save;
    procedure SaveNFE;
    procedure SaveNFCE;
    //Cancelar
    function ValidateCancel():boolean;
    procedure Cancel;

    procedure EditionControl;

  public
    { Public declarations }
  end;

var
  TasGeraNfeConfig: TTasGeraNfeConfig;

implementation

{$R *.dfm}

uses     un_sistema, UN_Principal, ACBrDFeSSL, blcksock, System.TypInfo, RN_NotaFiscalEletronica3X, env;

procedure TTasGeraNfeConfig.AtualizaLibs;
begin
  Fc_Aq_Geral('G', 'NFE', 'NFE_TIPO_SSL', IntToStr(cbSSLType.ItemIndex));
  Fc_Aq_Geral('G', 'NFE', 'NFE_SSLLib', IntToStr(cbSSLLib.ItemIndex));
  Fc_Aq_Geral('G', 'NFE', 'NFE_CryptLib', IntToStr(cbCryptLib.ItemIndex));
  Fc_Aq_Geral('G', 'NFE', 'NFE_HttpLib', IntToStr(cbHttpLib.ItemIndex));
  Fc_Aq_Geral('G', 'NFE', 'NFE_XmlSignLib', IntToStr(cbXmlSignLib.ItemIndex));

end;

procedure TTasGeraNfeConfig.Cancel;
begin

end;

procedure TTasGeraNfeConfig.cbCryptLibChange(Sender: TObject);
begin
  Try
    if cbHttpLib.ItemIndex <> -1 then
      Fr_Principal.Nfe.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  Finally
    AtualizaLibs
  End;

end;

procedure TTasGeraNfeConfig.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      Fr_Principal.Nfe.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizaLibs;
  end;


end;

procedure TTasGeraNfeConfig.cbSSLLibChange(Sender: TObject);
begin
  Try
    if cbCryptLib.ItemIndex <> -1 then
      Fr_Principal.Nfe.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
  Finally
    AtualizaLibs;
  End;

end;

procedure TTasGeraNfeConfig.cbSSLTypeChange(Sender: TObject);
begin
  Try
    if cbSSLLib.ItemIndex <> -1 then
      Fr_Principal.Nfe.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  Finally
    AtualizaLibs
  End;


end;

procedure TTasGeraNfeConfig.cbXmlSignLibChange(Sender: TObject);
begin
  Try
    if cbXmlSignLib.ItemIndex <> -1 then
      Fr_Principal.Nfe.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  Finally
    AtualizaLibs
  End;
end;

procedure TTasGeraNfeConfig.Change;
begin

end;

procedure TTasGeraNfeConfig.ClearAllFields;
begin

end;

procedure TTasGeraNfeConfig.CriarVariaveis;
var
  T: TSSLLib;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
begin
  inherited;
  //Tipo de SSL
    cbSSLLib.Items.Clear;
  For T := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add(GetEnumName(TypeInfo(TSSLLib), Integer(T)));
  cbSSLLib.ItemIndex := 0;

  cbCryptLib.Items.Clear;
  For U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add(GetEnumName(TypeInfo(TSSLCryptLib), Integer(U)));
  cbCryptLib.ItemIndex := 0;

  cbHttpLib.Items.Clear;
  For V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add(GetEnumName(TypeInfo(TSSLHttpLib), Integer(V)));
  cbHttpLib.ItemIndex := 0;

  cbXmlSignLib.Items.Clear;
  For X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add(GetEnumName(TypeInfo(TSSLXmlSignLib), Integer(X)));
  cbXmlSignLib.ItemIndex := 0;

  cbSSLType.Items.Clear;
  For Y := Low(TSSLType) to High(TSSLType) do
    cbSSLType.Items.Add(GetEnumName(TypeInfo(TSSLType), Integer(Y)));
  cbSSLType.ItemIndex := 0;

end;

procedure TTasGeraNfeConfig.EditionControl;
begin
  Pnl_Config_Arquivos.Enabled     := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Pnl_Config_Geral.Enabled        := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Pnl_Config_NFCe.Enabled         := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cfg_Alterar.Enabled          := ( EditionState = 'B' ) and
    (FNFEletronica.Registro.codigo > 0);
  SB_Cfg_Gravar.Enabled           := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Cfg_Cancelar.Enabled         := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Cfg_Sair.Enabled             := ( EditionState = 'B' ) ;
  Pnl_Config_Certificado.Enabled  := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Pnl_Config_Outras.Enabled       := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Pnl_Config_Nfe.Enabled          := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasGeraNfeConfig.FormataTela;
begin
  inherited;
  pg_Principal.ActivePage := tbs_config;
end;

procedure TTasGeraNfeConfig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F3:
      if SB_Cfg_Alterar.Enabled then
        SB_Cfg_AlterarClick(self);
    VK_F5:
      if SB_Cfg_Gravar.Enabled then
        SB_Cfg_GravarClick(self);
    VK_F6:
      if Sb_Cfg_Cancelar.Enabled then
        Sb_Cfg_CancelarClick(self);
    VK_Escape:
      if Sb_Cfg_Sair.Enabled then
        Sb_Cfg_SairClick(self);
  end;
end;

procedure TTasGeraNfeConfig.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    CarregaImagemBotao(SB_Cfg_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Cfg_Gravar,'GRAVAR');
    CarregaImagemBotao(Sb_Cfg_Cancelar,'CANCELAR');
    CarregaImagemBotao(Sb_Cfg_Sair,'SAIR');
  End;
end;

procedure TTasGeraNfeConfig.IniciaVariaveis;
Begin
  inherited;
  Pc_CarregaDadosEmitente(true);
  Pc_AtivatTb_NF_Eletronica;
  if FNFEletronica.exist then
    EditionState := 'B'
  else
    EditionState := 'I';
  EditionControl;
  Showdata;
  Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(Rg_TipoCertificado.ItemIndex);
end;

procedure TTasGeraNfeConfig.MenuItem11Click(Sender: TObject);
begin
  Close;
end;

procedure TTasGeraNfeConfig.MnuStatusServicoClick(Sender: TObject);
begin
  inherited;
  Fc_VerificaStatusServicoNfe(True);
end;

procedure TTasGeraNfeConfig.Rg_TipoCertificadoClick(Sender: TObject);
begin
  Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(TRadioGroup(sender).ItemIndex);
  if Rg_TipoCertificado.ItemIndex = 1 then
    Fc_Aq_Geral('G', 'NFE', 'NFE_TIPO_CERT', '1')  //mODELO A3
  else
    Fc_Aq_Geral('G', 'NFE', 'NFE_TIPO_CERT', '0'); //MODELO A1


end;

procedure TTasGeraNfeConfig.Save;
begin
  SaveNFE;
  SaveNFCE;
end;

procedure TTasGeraNfeConfig.SaveNFCE;
begin
  with FNFEletronica do
  Begin
    Registro.IDToken  := edtIdToken.Text;
    Registro.Token    := edtToken.Text;
    Registro.Versao := '400';
  End;

  // Emissão de NOta Fiscal de Consumidor Eletronica
  if ChBx_NFCe.Checked then
    Fc_Aq_Geral('G', 'CONTROLE DE FRENTE', 'FRT_VDA_NFCE', 'S')
  else
    Fc_Aq_Geral('G', 'CONTROLE DE FRENTE', 'FRT_VDA_NFCE', 'N');
  // Emissão de NOta Fiscal de Consumidor Eletronica
  if ChBx_ESCPOS.Checked then
    Fc_Aq_Geral('G', 'CONTROLE DE FRENTE', 'FRT_ESCPOS', 'S')
  else
    Fc_Aq_Geral('G', 'CONTROLE DE FRENTE', 'FRT_ESCPOS', 'N');

  Fc_Aq_Geral('G', 'NFCE', 'NFCE_MARCA_IMP', IntToStr(CbxModeloNFCe.ItemIndex));
  Fc_Aq_Geral('G', 'NFCE', 'NFCE_PORTA', cbxPortaNFCe.Text);
  Fc_Aq_Geral('G', 'NFCE', 'NFCE_VELOC', CbxVelocidadeNFCe.Text);
  Fc_Aq_Geral('G', 'NFCE', 'NFCE_LINHAS',
    IntToStr(edtLinhasEntreCupomNFCE.Value));
  if chkImprimirDescAcresItemNFCE.Checked then
    Fc_Aq_Geral('G', 'NFCE', 'NFCE_SHW_DESCACRESITEM', 'S')
  else
    Fc_Aq_Geral('G', 'NFCE', 'NFCE_SHW_DESCACRESITEM', 'N');

  if ChBx_EscPos_AtivaInicio.Checked then
    Fc_Aq_Geral('G', 'NFCE', 'NFCE_ESCPOS_ATIVA_INI', 'S')
  else
    Fc_Aq_Geral('G', 'NFCE', 'NFCE_ESCPOS_ATIVA_INI', 'N');

  if chbx_Imp_auto_Esc_pos.Checked then
    Fc_Aq_Geral('G', 'NFCE', 'NFCE_IMP_AUTO', 'S')
  else
    Fc_Aq_Geral('G', 'NFCE', 'NFCE_IMP_AUTO', 'N');

  Fc_Aq_Geral('G','NFCE','LHA_ENTRE_CUP', E_Linha_Entre_Cupom.Text);
  Fc_Aq_Geral('G','NFCE','LARGURA_BOBINA', E_LarguraBobina.Text);

end;

procedure TTasGeraNfeConfig.SaveNFE;
Var
  Lc_NF_Serie : Integer;
Begin
  with FNFEletronica do
  Begin
    //Registro.Codigo
    Registro.Estabelecimento    := Gb_CodMha;
    Registro.Ambiente           := IntToStr(Rg_Ambiente.ItemIndex);
    Registro.Emissao            := IntToStr(Rg_Emissao.ItemIndex);
    Registro.Certificado        := E_Serie_Certificado.Text;
    Registro.RepositorioNFE     := edtPathNFe.Text;
    Registro.Orientacao         := IntToStr(Rg_Orien_Danfe.ItemIndex);
    Registro.VisualizarMensagem := IfThen( chbx_Visualizar.Checked,SIGLA_S,SIGLA_N);
    Registro.Faturamento        := IfThen(ChBx_NotaDuplicata.Checked ,SIGLA_S,SIGLA_N);
    Registro.Duplicata          := IfThen(ChBx_NotaDuplicata.Checked,SIGLA_S,SIGLA_N);
    Registro.Tipo               := '0';
    Registro.Cobranca           := '';
    Registro.EmailContador      := E_email_contador.Text;
    Registro.ReceberCopiaEmail  := IfThen(chbx_copia_nfe.Checked,'S','N');
    Registro.IDToken            := edtIdToken.Text;
    Registro.Token              := edtToken.Text;
    Registro.RepositorioNFCE    := edtPathNFCe.Text;
    Registro.PosicaoCanhoto     := IntToStr(Rg_posicao_CAnhoto.ItemIndex);
  End;
  FNFEletronica.salva;

  if ChBx_NotaDuplicataOcultaAVista.Checked then
    Fc_Tb_Geral('G','NFE_OCUL_PAG_AVISTA','S')
  else
    Fc_Tb_Geral('G','NFE_OCUL_PAG_AVISTA','N');

  if ChBx_MostraCodigoDestinatario.Checked then
    Fc_Tb_Geral('G','NFE_SHOW_COD_DESTINATARIO','S')
  else
    Fc_Tb_Geral('G','NFE_SHOW_COD_DESTINATARIO','N');

  Lc_NF_Serie := StrToIntDef(E_NF_Serie.Text,1);
  E_NF_Serie.Text := Fc_Tb_Geral('G','NFE_SERIE',IntToStr(Lc_NF_Serie));

  if Rg_SSLTLS.ItemIndex = 1 then
    Fc_Aq_Geral('G', 'NFE', 'NFE_SSLTLS', '1')  //Usar SSL 3.0 / Usar TSL 1.0
  else
    Fc_Aq_Geral('G', 'NFE', 'NFE_SSLTLS', '0'); //Usar SSL 2.0 / Usar TSL 1.0

  if Rg_TipoCertificado.ItemIndex = 1 then
    Fc_Aq_Geral('G', 'NFE', 'NFE_TIPO_CERT', '1')  //mODELO A3
  else
    Fc_Aq_Geral('G', 'NFE', 'NFE_TIPO_CERT', '0'); //MODELO A1

  Fc_Tb_Geral('G','NFE_SENHA_CERT',E_Senha_Certificado.Text);

  if chbx_mostra_Lote.Checked then
    Fc_Tb_Geral('G','NFE_MOSTRA_LOTE','S')
  else
    Fc_Tb_Geral('G','NFE_MOSTRA_LOTE','N');

  if chbx_Prenche_Lote_Valida.Checked then
    Fc_Tb_Geral('G','NFE_PREENCHE_LOTE_VALID','S')
  else
    Fc_Tb_Geral('G','NFE_PREENCHE_LOTE_VALID','N');

  if chbx_Rastrea_completo.Checked then
    Fc_Tb_Geral('G','NFE_SHOW_RASTREIO_COMPLETO','S')
  else
    Fc_Tb_Geral('G','NFE_SHOW_RASTREIO_COMPLETO','N');

  Fc_Tb_Geral('G','NFE_MARGEM_ESQUERDA', IntToStr( StrToIntDef(E_Nfe_Margem_Esquerda.Text,5)) );
  Fc_Tb_Geral('G','NFE_MARGEM_SUPERIOR', IntToStr( StrToIntDef(E_Nfe_Margem_Superior.Text,5)) );
  Fc_Tb_Geral('G','NFE_MARGEM_INFERIOR', IntToStr( StrToIntDef(E_Nfe_Margem_Inferior.Text,10)) );

  if Chbx_Bloqueia_Fechamento_Caixa.Checked then
    Fc_Tb_Geral('G','NFE_BLOQUEIA_FECHA_CAIXA','S')
  else
    Fc_Tb_Geral('G','NFE_BLOQUEIA_FECHA_CAIXA','N');

  if chbx_Sem_Codigo_Barras.Checked then
    Fc_Tb_Geral('G','NFE_SEM_CODIGO_BARRAS','S')
  else
    Fc_Tb_Geral('G','NFE_SEM_CODIGO_BARRAS','N');

  AtualizaLibs;


end;

procedure TTasGeraNfeConfig.sbtnGetCertClick(Sender: TObject);
begin
  Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(Rg_TipoCertificado.ItemIndex);
  E_Serie_Certificado.Text := CarregaCertificado(E_Senha_Certificado.Text);
  MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);

end;

procedure TTasGeraNfeConfig.SB_Cfg_AlterarClick(Sender: TObject);
begin
  EditionState := 'E';
  EditionControl;
end;

procedure TTasGeraNfeConfig.Sb_Cfg_CancelarClick(Sender: TObject);
begin
  EditionState := 'B';
  EditionControl;
end;

procedure TTasGeraNfeConfig.SB_Cfg_GravarClick(Sender: TObject);
begin
  if ValidateSave then
  Begin
    Save;
    EditionState := 'B';
    EditionControl;
  End;

end;

procedure TTasGeraNfeConfig.Sb_Cfg_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TTasGeraNfeConfig.Sb_PathCanClick(Sender: TObject);
begin
  Pc_PathClick(edtPathCan);
end;

procedure TTasGeraNfeConfig.Sb_PathCCeClick(Sender: TObject);
begin
  Pc_PathClick(edtPathCCe);

end;

procedure TTasGeraNfeConfig.Sb_PathDPECClick(Sender: TObject);
begin
  Pc_PathClick(edtPathDPEC);
end;

procedure TTasGeraNfeConfig.Sb_PathEventoClick(Sender: TObject);
begin
  Pc_PathClick(edtPathEvento);

end;

procedure TTasGeraNfeConfig.Sb_PathInuClick(Sender: TObject);
begin
  Pc_PathClick(edtPathInu);
end;

procedure TTasGeraNfeConfig.Sb_PathNFCeClick(Sender: TObject);
begin
  Pc_PathClick(edtPathNFCe);
end;

procedure TTasGeraNfeConfig.Sb_PathNFeClick(Sender: TObject);
begin
  Pc_PathClick(edtPathNFe);
end;

procedure TTasGeraNfeConfig.setPerfil;
begin

end;

procedure TTasGeraNfeConfig.ShowData;
begin
  if FNFEletronica.Registro.Codigo > 0 then
  Begin
    E_Serie_Certificado.Text    := FNFEletronica.Registro.Certificado;
    ShowNFe;
    ShowNFce;
  End;
end;

procedure TTasGeraNfeConfig.ShowNFce;
var
  ModeloImpressora: TACBrPosPrinterModelo;
Begin
  // Configurções
  // lista de impressoras suportadas
  CbxModeloNFCe.Items.Clear;
  For ModeloImpressora := Low(TACBrPosPrinterModelo)
    to High(TACBrPosPrinterModelo) do
    CbxModeloNFCe.Items.Add(GetEnumName(TypeInfo(TACBrPosPrinterModelo),Integer(ModeloImpressora)));
  // portas COM dispon�veis
  cbxPortaNFCe.Items.BeginUpdate;
  try
    cbxPortaNFCe.Items.Clear;
    Fr_Principal.ACBrPosPrinter.Device.AcharPortasSeriais(cbxPortaNFCe.Items);
  finally
    cbxPortaNFCe.Items.EndUpdate;
  end;
  // Preencher dados
  // Emissão de NOta Fiscal de Consumidor Eletronica
  ChBx_NFCe.Checked                     :=  (Fc_Aq_Geral('L', 'CONTROLE DE FRENTE', 'FRT_VDA_NFCE','S') = 'S');
  ChBx_ESCPOS.Checked                   :=  (Fc_Aq_Geral('L', 'CONTROLE DE FRENTE', 'FRT_ESCPOS','S') = 'S');
  CbxModeloNFCe.ItemIndex               :=  StrToIntdef(Fc_Aq_Geral('L', 'NFCE', 'NFCE_MARCA_IMP', '0'), 0);
  cbxPortaNFCe.Text                     :=  Fc_Aq_Geral('L', 'NFCE', 'NFCE_PORTA', 'COM1');
  CbxVelocidadeNFCe.Text                :=  Fc_Aq_Geral('L', 'NFCE', 'NFCE_VELOC', '9600');
  edtLinhasEntreCupomNFCE.Value         :=  StrToIntdef(Fc_Aq_Geral('L', 'NFCE', 'NFCE_LINHAS', '5'), 5);
  chkImprimirDescAcresItemNFCE.Checked  :=  (Fc_Aq_Geral('L', 'NFCE', 'NFCE_SHW_DESCACRESITEM', 'N') = 'S');
  ChBx_EscPos_AtivaInicio.Checked       :=  (Fc_Aq_Geral('L', 'NFCE', 'NFCE_ESCPOS_ATIVA_INI', 'N') = 'S');
  chbx_Imp_auto_Esc_pos.Checked         :=  ( Fc_Aq_Geral('L', 'NFCE', 'NFCE_IMP_AUTO', 'S') = 'S');
  E_Linha_Entre_Cupom.Text              :=  Fc_Aq_Geral('L','NFCE','LHA_ENTRE_CUP','5' );
  E_LarguraBobina.Text                  :=  Fc_Aq_Geral('L','NFCE','LARGURA_BOBINA', '302');

  with FNFEletronica do
  Begin
    edtIdToken.Text                       :=  Registro.IDToken;
    edtToken.Text                         :=  Registro.Token;
  End;


end;

procedure TTasGeraNfeConfig.ShowNFe;
begin
  with FNFEletronica do
  Begin
    Rg_Emissao.ItemIndex            :=  StrToIntdef(Registro.Emissao, 0);
    E_Serie_Certificado.Text        :=  Registro.Certificado;
    edtPathNFe.Text                 :=  Registro.RepositorioNFE;
    edtPathNFCe.Text                :=  Registro.RepositorioNFCE;
    Rg_Ambiente.ItemIndex           :=  StrToIntdef(Registro.Ambiente, 0);
    Rg_Orien_Danfe.ItemIndex        :=  StrToIntdef( Registro.Orientacao , 0);
    Rg_posicao_CAnhoto.ItemIndex    :=  StrToIntdef( Registro.PosicaoCanhoto , 0);
    chbx_Visualizar.Checked         :=  (Registro.VisualizarMensagem = 'S');
    ChBx_NotaDuplicata.Checked      :=  (Registro.Duplicata = 'S');
    chbx_copia_nfe.Checked          :=  ( Registro.ReceberCopiaEmail = 'S');
    E_email_contador.Text           :=  Registro.EmailContador;

    ChBx_NotaDuplicataOcultaAVista.Checked  := (Fc_Tb_Geral('L','NFE_OCUL_PAG_AVISTA','S') ='S');
    ChBx_MostraCodigoDestinatario.Checked   := ( Fc_Tb_Geral('L','NFE_SHOW_COD_DESTINATARIO','S') = 'S');
    E_NF_Serie.Text                         := Fc_Tb_Geral('L','NFE_SERIE','1');
    Rg_SSLTLS.ItemIndex                     := StrToIntDef( Fc_Aq_Geral('L', 'NFE', 'NFE_SSLTLS','0'),0);
    Rg_TipoCertificado.ItemIndex            := StrToIntDef( Fc_Aq_Geral('L', 'NFE', 'NFE_TIPO_CERT','0'),0);
    E_Senha_Certificado.Text                := Fc_Tb_Geral('L','NFE_SENHA_CERT','');
    chbx_mostra_Lote.Checked                := ( Fc_Tb_Geral('L','NFE_MOSTRA_LOTE','S') = 'S');
    chbx_Prenche_Lote_Valida.Checked        := ( Fc_Tb_Geral('L','NFE_PREENCHE_LOTE_VALID','S') = 'S');
    chbx_Rastrea_completo.Checked           := (Fc_Tb_Geral('L','NFE_SHOW_RASTREIO_COMPLETO','S') = 'S');
    cbSSLType.ItemIndex                     := StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_TIPO_SSL','-1'),-1 );
    cbSSLLib.ItemIndex                      := StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_SSLLib','-1'),-1 );
    cbCryptLib.ItemIndex                    := StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_CryptLib','-1'),-1 );
    cbHttpLib.ItemIndex                     := StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_HttpLib','-1'),-1 );
    cbXmlSignLib.ItemIndex                  := StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_XmlSignLib','-1'),-1 );
    E_Nfe_Margem_Esquerda.Text              := Fc_Tb_Geral('L','NFE_MARGEM_ESQUERDA','5');
    E_Nfe_Margem_Superior.Text              := Fc_Tb_Geral('L','NFE_MARGEM_SUPERIOR','5');
    E_Nfe_Margem_Inferior.Text              := Fc_Tb_Geral('L','NFE_MARGEM_INFERIOR','10');
    Chbx_Bloqueia_Fechamento_Caixa.Checked  := ( Fc_Tb_Geral('L','NFE_BLOQUEIA_FECHA_CAIXA','S') = 'S' );
    chbx_Sem_Codigo_Barras.Checked          := ( Fc_Tb_Geral('L','NFE_SEM_CODIGO_BARRAS','N') = 'S' );
  End;
end;

procedure TTasGeraNfeConfig.ShowNoData;
begin

end;

function TTasGeraNfeConfig.ValidateCancel: boolean;
begin

end;

function TTasGeraNfeConfig.ValidateChange: boolean;
begin

end;

function TTasGeraNfeConfig.ValidateSave: boolean;
begin
  Result := True;
end;

end.
