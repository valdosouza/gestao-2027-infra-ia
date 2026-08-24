unit tas_mdfe_config;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus, Vcl.Buttons, TypInfo, ControllerMdfe, blcksock, ACBrDFeSSL, Vcl.FileCtrl;

type
  TTasMdfeConfig = class(TBaseRegistry)
    Pg_MFDeConfig: TPageControl;
    tbs_ConfigGeral: TTabSheet;
    Pnl_Config_Geral: TPanel;
    Rg_Orien_Damdfe: TRadioGroup;
    Rg_Emissao: TRadioGroup;
    Rg_Ambiente: TRadioGroup;
    chbx_Visualizar: TCheckBox;
    chbx_copia_mdfe_proprio: TCheckBox;
    chbx_copia_mdfe_contador: TCheckBox;
    Pnl_Validade: TPanel;
    Pnl_Cert_Validade: TPanel;
    Pnl_Cert_Expira: TPanel;
    Label35: TLabel;
    E_Pasta_MDFe: TEdit;
    Sb_PathNFe: TSpeedButton;
    TabSheet1: TTabSheet;
    pnl_config_cert: TPanel;
    Label2: TLabel;
    lblXmlSign: TLabel;
    lblSSLLib: TLabel;
    lblCryptLib: TLabel;
    lblHttpLib: TLabel;
    Gb_Dados_Cert: TGroupBox;
    sbtnGetCert: TSpeedButton;
    Label17: TLabel;
    Label3: TLabel;
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
    procedure Sb_PathNFeClick(Sender: TObject);
    procedure Pc_PathClick(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure Rg_SSLTLSClick(Sender: TObject);
  private
    { Private declarations }
    procedure preenchecombossl;
    procedure AtualizaLibs;
  protected
    Pf_Inserir , Pf_Alterar, Pf_Excluir : Boolean;

    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    procedure EditionControl;Override;
    //Teclas de atalhos

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;


  public
    { Public declarations }
    MDFe : TControllerMdfe;


  end;

var
  TasMdfeConfig: TTasMdfeConfig;

const
  SELDIRHELP = 1000;

implementation

{$R *.dfm}

uses     Un_Regra_Negocio, RN_NotaFiscalEletronica3X, UN_Sistema, Un_DM, UN_Principal, env;

{ TTasMdfeConfig }


procedure TTasMdfeConfig.AtualizaLibs;
begin
  Fc_Aq_Geral('G', 'MDFE', 'MDFE_TIPO_SSL', IntToStr(cbSSLType.ItemIndex));
  Fc_Aq_Geral('G', 'MDFE', 'MDFE_SSLLib', IntToStr(cbSSLLib.ItemIndex));
  Fc_Aq_Geral('G', 'MDFE', 'MDFE_CryptLib', IntToStr(cbCryptLib.ItemIndex));
  Fc_Aq_Geral('G', 'MDFE', 'MDFE_HttpLib', IntToStr(cbHttpLib.ItemIndex));
  Fc_Aq_Geral('G', 'MDFE', 'MDFE_XmlSignLib', IntToStr(cbXmlSignLib.ItemIndex));
end;



procedure TTasMdfeConfig.cbCryptLibChange(Sender: TObject);
begin
  Try
    if cbHttpLib.ItemIndex <> -1 then
    Begin
      MDFe.Operador.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
      Fc_Aq_Geral('G', 'MDFE', 'MDFE_CryptLib', IntToStr(cbCryptLib.ItemIndex));
    End;
  Finally
    AtualizaLibs
  End;
end;

procedure TTasMdfeConfig.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
    Begin
      MDFe.Operador.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
      Fc_Aq_Geral('G', 'MDFE', 'MDFE_HttpLib', IntToStr(cbHttpLib.ItemIndex));
    End;
  finally
    AtualizaLibs;
  end;
end;

procedure TTasMdfeConfig.cbSSLLibChange(Sender: TObject);
begin
  Try
    if cbCryptLib.ItemIndex <> -1 then
    Begin
      MDFe.Operador.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
      Fc_Aq_Geral('G', 'MDFE', 'MDFE_SSLLib', IntToStr(cbSSLLib.ItemIndex));
    End;
  Finally
    AtualizaLibs;
  End;
end;

procedure TTasMdfeConfig.cbSSLTypeChange(Sender: TObject);
begin
  Try
    if cbSSLLib.ItemIndex <> -1 then
    Begin
      MDFe.Operador.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
      Fc_Aq_Geral('G', 'MDFE', 'MDFE_TIPO_SSL', IntToStr(cbSSLType.ItemIndex));
    End;
  Finally
    AtualizaLibs
  End;

end;

procedure TTasMdfeConfig.cbXmlSignLibChange(Sender: TObject);
begin
  Try
    if cbXmlSignLib.ItemIndex <> -1 then
    Begin
      MDFe.Operador.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
      Fc_Aq_Geral('G', 'MDFE', 'MDFE_XmlSignLib', IntToStr(cbXmlSignLib.ItemIndex));
    End;
  Finally
    AtualizaLibs
  End;
end;


procedure TTasMdfeConfig.ClearAllFields;
begin

end;

procedure TTasMdfeConfig.CriarVariaveis;
begin
  inherited;
  MDFe := TControllerMdfe.create(self);

end;


procedure TTasMdfeConfig.EditionControl;
begin
  inherited;
  Pnl_Config_Geral.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  pnl_config_cert.Enabled  := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasMdfeConfig.FormataTela;
begin
  inherited;

end;

procedure TTasMdfeConfig.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(SB_Alterar,'ALTERAR');
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(Sb_Cancelar,'CANCELAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TTasMdfeConfig.IniciaVariaveis;
begin
  Pc_AtivaEstabelecimento;
  preenchecombossl;
  MDFe.Config.CarregaListaSSLType(cbSSLType);
  if CodigoRegistro > 0 then
  begin
    MDFe.Config.Registro.Estabelecimento := Gb_CodMha;
    MDFe.Config.getbyId;
    MDFe.Config.Configura;
  end;
  inherited;
end;

procedure TTasMdfeConfig.Insert;
begin

end;

procedure TTasMdfeConfig.Save;
begin
  With MDFe.Config do
  begin
    registro.Estabelecimento          := Gb_CodMha;
    Registro.Serie                    := E_Serie_Certificado.Text;
    Registro.Senha                    := E_Senha_Certificado.Text;

    if chbx_copia_mdfe_proprio.Checked then
      Registro.EnviarParaSiMesmo      := 'S'
    else
      Registro.EnviarParaSiMesmo      := 'N';
    if chbx_copia_mdfe_contador.Checked then
      Registro.EnviarParaContador     := 'S'
    else
      Registro.EnviarParaContador     := 'N';
    if chbx_Visualizar.Checked then
      Registro.Mensagem               := 'S'
    else
      Registro.Mensagem               := 'N';

    if Rg_Ambiente.ItemIndex          = 0 then
      Registro.Camada                 :=  'P'
    else
      Registro.Camada                 :=  'H';
    if Rg_Orien_Damdfe.ItemIndex      = 0 then
      Registro.Orientacao             :=  'R'
    else
      Registro.Orientacao             :=  'P';
    if Rg_TipoCertificado.ItemIndex    = 0 then
      Registro.Tipo                   :=  'A'
    else
      Registro.Tipo                   :=  'C';
    registro.TipoEmissao              := IntToStr(Rg_Emissao.ItemIndex +1);

    Registro.RepositorioMdfe         := E_Pasta_MDFe.Text;
    MDFe.Config.salva;

    //AQ
    Fc_Aq_Geral('G', 'MDFE', 'MDFE_TIPO_SSL', IntToStr(cbSSLType.ItemIndex));
    Fc_Aq_Geral('G', 'MDFE', 'MDFE_SSLLib', IntToStr(cbSSLLib.ItemIndex));
    Fc_Aq_Geral('G', 'MDFE', 'MDFE_CryptLib', IntToStr(cbCryptLib.ItemIndex));
    Fc_Aq_Geral('G', 'MDFE', 'MDFE_HttpLib', IntToStr(cbHttpLib.ItemIndex));
    Fc_Aq_Geral('G', 'MDFE', 'MDFE_XmlSignLib', IntToStr(cbXmlSignLib.ItemIndex));


  end;

end;

procedure TTasMdfeConfig.sbtnGetCertClick(Sender: TObject);
begin
  MDFe.Config.Configura;
  Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(Rg_TipoCertificado.ItemIndex);
  E_Serie_Certificado.Text := MDFe.Config.CarregaCertificado;
  MDFe.Config.MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);
end;

procedure TTasMdfeConfig.Pc_PathClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(TEdit(Sender).Text) <= 0 then
    Dir := ExtractFileDir(Application.ExeName)
  else
    Dir := TEdit(Sender).Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP)
  then
    TEdit(Sender).Text := Dir;
end;

procedure TTasMdfeConfig.preenchecombossl;
var
  T: TSSLLib;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
begin
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

procedure TTasMdfeConfig.Rg_SSLTLSClick(Sender: TObject);
begin
  if Rg_SSLTLS.ItemIndex = 1 then
    Fc_Aq_Geral('G', 'MDFE', 'MDFE_SSLTLS', '1')  //Usar SSL 3.0 / Usar TSL 1.0
  else
    Fc_Aq_Geral('G', 'MDFE', 'MDFE_SSLTLS', '0'); //Usar SSL 2.0 / Usar TSL 1.0
end;

procedure TTasMdfeConfig.Sb_PathNFeClick(Sender: TObject);
begin
  Pc_PathClick(E_Pasta_MDFe);
end;

procedure TTasMdfeConfig.setPerfil;
begin
  inherited;

end;

procedure TTasMdfeConfig.ShowData;
begin
  With MDFe.Config do
  begin
    IF Registro.Tipo = 'A' THEN
      Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(0)
    ELSE
      Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(1) ;

    E_Serie_Certificado.Text          :=  Registro.Serie;
    E_Senha_Certificado.Text          :=  Registro.Senha;
    chbx_copia_mdfe_proprio.Checked   := (Registro.EnviarParaSiMesmo = 'S');
    chbx_copia_mdfe_contador.Checked  := (Registro.EnviarParaContador = 'S');
    chbx_Visualizar.Checked           := (Registro.Mensagem = 'S');

    if Registro.Camada = 'P' then
      Rg_Ambiente.ItemIndex          :=  0
    else
      Rg_Ambiente.ItemIndex          :=  1;

    if Registro.Orientacao = 'R' then
      Rg_Orien_Damdfe.ItemIndex        :=  0
    else
      Rg_Orien_Damdfe.ItemIndex        :=  1;

    if Registro.Tipo = 'A' then
      Rg_TipoCertificado.ItemIndex          :=  0
    else
      Rg_TipoCertificado.ItemIndex          :=  1;

    Rg_Emissao.ItemIndex := StrToIntDef(registro.TipoEmissao,1) - 1;

    E_Pasta_MDFe.Text                 :=Registro.RepositorioMdfe;

  end;
  cbSSLType.ItemIndex     := StrToIntDef( Fc_Aq_Geral('L', 'MDFE', 'MDFE_TIPO_SSL','0'),0);
  cbSSLLib.ItemIndex      := StrToIntDef( Fc_Aq_Geral('L', 'MDFE', 'MDFE_SSLLib','0'),0);
  cbCryptLib.ItemIndex    := StrToIntDef( Fc_Aq_Geral('L', 'MDFE', 'MDFE_CryptLib','0'),0);
  cbHttpLib.ItemIndex     := StrToIntDef( Fc_Aq_Geral('L', 'MDFE', 'MDFE_HttpLib','0'),0);
  cbXmlSignLib.ItemIndex  := StrToIntDef( Fc_Aq_Geral('L', 'MDFE', 'MDFE_XmlSignLib','0'),0);

  E_Serie_Certificado.Text := MDFe.Config.Registro.Serie;
  MDFe.Config.MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);
  Lb_Explica_Certificado.Caption  := MDFe.Config.LabelTipo(Rg_TipoCertificado.ItemIndex);
End;

procedure TTasMdfeConfig.ShowNoData;
begin

end;

function TTasMdfeConfig.ValidaInsert: boolean;
begin
  Result := True;
end;


function TTasMdfeConfig.ValidateSave: boolean;
begin
  Result := True;
end;

end.
