unit un_geranfe_Srv;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Spin, Menus, DB, TypInfo, STQuery, FileCtrl, System.Math, ControllerRPSNFSe, ControllerRetornoNFS, Winapi.ShellAPI, System.StrUtils, ACBrNFSeXNotasFiscais, ACBrNFSeXInterface, ACBrBase, ACBrUtil, ACBrDFe, ACBrDFeReport, ACBrMail, ACBrNFSeX, ACBrNFSeXConversao, ACBrNFSeXWebservicesResponse, ACBrNFSeXClass, ACBrNFSeXDANFSeClass, ACBrNFSeXDANFSeRLClass, Vcl.OleCtrls, SHDocVw, blcksock, ControllerNotaFiscal,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFullPath = record
    Path: String;
    FileNameXML:String;
    FileNamePDF:String;
  end;

  TFr_geranfe_Srv = class(TForm)
    pg_Principal: TPageControl;
    tbs_config: TTabSheet;
    tbs_NFS_e: TTabSheet;
    Pnl_Botao: TPanel;
    Sb_Enviar: TSpeedButton;
    Sb_Gerar: TSpeedButton;
    Sb_sair_0: TSpeedButton;
    Sb_Envia_Mensagem: TSpeedButton;
    Sb_Imprimir: TSpeedButton;
    Sb_Consultar: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    pnl_NF_e: TPanel;
    Lb_titulo: TLabel;
    MM_Acompanhamento: TMemo;
    E_Obs: TMemo;
    CkBx_Recibo_Manual: TCheckBox;
    Pnl_Nfe: TPanel;
    Label18: TLabel;
    Pg_NFeConfig: TPageControl;
    tbs_ConfigGeral: TTabSheet;
    Pnl_Config_Geral: TPanel;
    tbs_arquivosNfe: TTabSheet;
    Pnl_Config_Arquivos: TPanel;
    Sb_Path_NFSe: TSpeedButton;
    Label35: TLabel;
    Label39: TLabel;
    Sb_Path_RPS: TSpeedButton;
    E_Path_NFSe: TEdit;
    E_Path_RPS: TEdit;
    Panel8: TPanel;
    SB_Cfg_Alterar: TSpeedButton;
    SB_Cfg_Gravar: TSpeedButton;
    Sb_Cfg_Cancelar: TSpeedButton;
    Sb_Cfg_Sair: TSpeedButton;
    Sb_Path_Schemas: TSpeedButton;
    Label30: TLabel;
    E_Path_Schemas: TEdit;
    Label2: TLabel;
    Sb_Arq_Ini_Provedor: TSpeedButton;
    E_Arq_Ini_Provedor: TEdit;
    Mnu_Principal: TMainMenu;
    MnuTarefas: TMenuItem;
    MnuSchemas: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Label7: TLabel;
    E_NomePrefeitura: TEdit;
    Label8: TLabel;
    Sb_LogoPrefeitura: TSpeedButton;
    E_LogoPrefeitura: TEdit;
    Qr_Nota: TSTQuery;
    Qr_Itens: TSTQuery;
    OpenDialog: TOpenDialog;
    CkBx_Lote_Manual: TCheckBox;
    Pnl_Cancelamento: TPanel;
    lb_TituloCancelamento: TLabel;
    Rg_Cancelamento: TRadioGroup;
    E_Motivo_Cancelamento: TEdit;
    Label9: TLabel;
    Btn_Confirmar: TButton;
    Btn_Cancelar: TButton;
    PpMnu: TPopupMenu;
    AtualizarAtravsdoXML1: TMenuItem;
    Qr_Observacao: TSTQuery;
    Qr_Parcelamento: TSTQuery;
    PageControl1: TPageControl;
    tbs_Certfificado: TTabSheet;
    tbs_webservice: TTabSheet;
    Rg_Ambiente: TRadioGroup;
    Rg_TipoCertificado: TRadioGroup;
    GroupBox2: TGroupBox;
    sbtnGetCert: TSpeedButton;
    Label17: TLabel;
    Label28: TLabel;
    Lb_Explica_Certificado: TLabel;
    E_Serie_Certificado: TEdit;
    E_Senha_Certificado: TEdit;
    lblHttpLib: TLabel;
    lblCryptLib: TLabel;
    lblSSLLib: TLabel;
    lblXmlSign: TLabel;
    cbCryptLib: TComboBox;
    cbSSLLib: TComboBox;
    cbHttpLib: TComboBox;
    cbXmlSignLib: TComboBox;
    lSSLLib1: TLabel;
    cbSSLType: TComboBox;
    Rg_SSLTLS: TRadioGroup;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    E_Pws_WEb: TEdit;
    E_User_Web: TEdit;
    E_Frase_WEb: TEdit;
    tbs_outras: TTabSheet;
    Label58: TLabel;
    Label69: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    chbx_Visualizar: TCheckBox;
    chbx_copia_nfe: TCheckBox;
    E_Nfse_Cd_LC116: TEdit;
    Cb_CRET: TComboBox;
    E_CodigoTribMunicipio: TEdit;
    E_CodigoCnae: TEdit;
    Cb_Provedor: TComboBox;
    Pnl_Validade: TPanel;
    Pnl_Cert_Validade: TPanel;
    Pnl_Cert_Expira: TPanel;
    ACBrMail: TACBrMail;
    tbs_xml_retorno: TTabSheet;
    WBXmlRetorno: TWebBrowser;
    tbs_xml_nota: TTabSheet;
    WBXmlNotas: TWebBrowser;
    Btn_Xml_Nota: TButton;
    Btn_Xml_retorno: TButton;
    Panel1: TPanel;
    SpeedButton4: TSpeedButton;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Dfe_NFSe: TACBrNFSeXDANFSeRL;
    Label1: TLabel;
    cbLayoutNFSe: TComboBox;
    Cb_versao_utilizado: TComboBox;
    Label3: TLabel;
    chbx_forcar_consulta: TCheckBox;
    NFS_e: TACBrNFSeX;
    Label4: TLabel;
    cbFormatoDiscr: TComboBox;
    Label13: TLabel;
    E_CodigoNBS: TEdit;
    procedure Sb_GerarClick(Sender: TObject);
    procedure Sb_EnviarClick(Sender: TObject);
    procedure SB_Cfg_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Sb_Path_NFSeClick(Sender: TObject);
    procedure Sb_Path_RPSClick(Sender: TObject);
    procedure Sb_Path_SchemasClick(Sender: TObject);
    procedure Sb_Arq_Ini_ProvedorClick(Sender: TObject);
    procedure Sb_LogoPrefeituraClick(Sender: TObject);
    procedure SB_Cfg_AlterarClick(Sender: TObject);
    procedure Sb_Cfg_CancelarClick(Sender: TObject);
    procedure Sb_Cfg_SairClick(Sender: TObject);
    procedure Sb_ImprimirClick(Sender: TObject);
    procedure Sb_sair_0Click(Sender: TObject);
    procedure Sb_Envia_MensagemClick(Sender: TObject);
    procedure Btn_CancelarClick(Sender: TObject);
    procedure Btn_ConfirmarClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure AtualizarAtravsdoXML1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sb_ConsultarClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure Rg_TipoCertificadoClick(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Btn_Xml_retornoClick(Sender: TObject);
    procedure Btn_Xml_NotaClick(Sender: TObject);
  private
    //Teclas de Atalho
    It_Edicao_Config : String;
    FProvider: IACBrNFSeXProvider;
    FFullPathRps : TFullPath;
    FFullPathNFSe : TFullPath;
    FConsumidorFinal : Integer;
    FLinkNFSe : String;
    procedure Pc_EstadoEdicaoConfig;

    procedure Pc_TeclaAtalhoNFSE(Key: Word);
    procedure Pc_TeclaAtalhoConfig(Key: Word);
    procedure Pc_ImagemBotao;
    procedure Pc_Inicia_variaveis;

    function executeConsulta(etapa :String):Boolean;
    function executeGeneral(etapa :String):Boolean;
    function executeIPMSistemas(etapa :String):Boolean;
    function executeIPMSistemasV01(etapa :String):Boolean;
    function executePadraoNacional(etapa :String):Boolean;
    function executeISSNet(etapa :String):Boolean;

    function mostraErrosEmite : Boolean;
    function mostraErrosConsulta : Boolean;

    procedure Pc_Inicia_variaveisNFSe;
    procedure Pc_Inicia_variaveisConfig;
    procedure Pc_FormataTela;
    procedure Pc_PreencherNFSE;
    procedure Pc_PathClick(Sender: TObject);
    procedure AtualizaSSLLibsCombo;
    function Fc_AtivaDadosDaNota():Boolean;
    function Fc_DefineNumeroRPS():Boolean;
    function Fc_DefineNumeroLOTE():Boolean;
    procedure OpenItens(nfl_codigo:Integer);
    function Fc_CarregaComponenente():Boolean;
    procedure CarregaDadosReformaTributaria;
    procedure MostraValidade(pValidade, pCert_Validade,pCert_Expira: TPanel);
    procedure ChecarResposta(aMetodo: TMetodo);
    procedure LoadXML(RetWS: String; MyWebBrowser: TWebBrowser;
      NomeArq: string = 'temp.xml'; aTempo: Integer = 0);


    procedure setValoresNFSE(valores: TValores);

    function SplitPathFile(FullPath:String;Tipo:String):TFullPath;

    function VerificaExistenciaArquivoXML():boolean;

    procedure ChamarGeraNFE_VDA;
  public
    It_Tipo_Operacao : String;
    function Fc_ValidaGeracao():Boolean;
    Function Fc_Gera_RPS():Integer;
    function Fc_ValidaEnvio():Boolean;
    function  Pc_Envia_RPS:Boolean;

    Function Fc_Atualiza_NFSE_by_Arquivo:Boolean;

    Function Fc_Atualiza_NFSE_by_Consulta:Boolean;
    Function Fc_Atualiza_NFSE_by_Consulta_ProIPM:Boolean;
    Function Fc_Atualiza_NFSE_by_Consulta_ProIPM_V01:Boolean;
    Function Fc_Atualiza_NFSE_by_Consulta_proISSNet:Boolean;
    Function Fc_Atualiza_NFSE_by_Consulta_General:Boolean;

    Function Fc_Atualiza_NFSE_by_Status(msg:String):Boolean;
    Function Fc_Atualiza_NFSE_by_Emite:Boolean;
    Function Fc_Atualiza_NFSE_by_Emite_proIPM:Boolean;
    Function Fc_Atualiza_NFSE_by_Emite_General:Boolean;

    function Fc_Atualiza_RPS:Boolean;


    //Validaçãoes
    function Fc_ValidaConsultar():Boolean;
    function ValidarIPMSistemas:Boolean;

    function validaConsultaLote:Boolean;
    function validaConsultaProtocolo:Boolean;

    function Fc_ValidaCancelar():Boolean;
    function VerificaRPSGerada():boolean;
    function VerificaRpsGeradaNaoEnviada():Boolean;
    function VerificaRpsProcessada():Boolean;
    function VerificaRpsProcessadaComErro():boolean;

    function VerificaCarregamentoNota():Boolean;
    function VerificaNotaProcessada():Boolean;
    function VerificaNotaCancelada():Boolean;
    function VerificaNotaProduto(): boolean;

    procedure Pc_Cancelar;
    function Fc_ValidaImprimir():Boolean;
    procedure Pc_ImprimirPadraoNacional;
    procedure Pc_ImprimirIPMSistemas;
    procedure PrepararArquivoParaEnvio;
    procedure PreparaLinkParaEnvio;
    function ValidaEnviarMensagem():Boolean;
    procedure EnviarMensagem;
    procedure EnviarEmail;
    function ValidaEnviaWhatsApp:Boolean;
    procedure EnviaWhatsApp;

    function Fc_ValidaGravacao():Boolean;
    procedure Pc_Gravar;
    function Fc_ValidaSituacao:Boolean;

  end;

var
  Fr_geranfe_Srv: TFr_geranfe_Srv;
  RetNFse : TControllerRetornoNFS;
  RetNfe : TControllerNotaFiscal;

implementation

uses     UN_Principal, env, Un_Regra_Negocio, UN_Sistema, RN_NotaFiscalServico, Un_DM, RN_Permissao, UN_MSG, Un_Funcoes, Un_RL_NFSe_IPMSistemas, WhatsApp, pcnAuxiliar, pcnConversao, RN_NotaFiscalEletronica3X, ACBrDFeConfiguracoes, ACBrDFeSSL, ACBrDFeOpenSSL, ACBrDFeUtil, ACBrNFSeXWebserviceBase, un_geranfe_vda, ACBrDFe.Conversao;
const
  SELDIRHELP = 1000;

{$R *.dfm}


function TFr_geranfe_Srv.SplitPathFile(FullPath:String;Tipo:String):TFullPath;
Var
  Lc_Tamfile: Integer;
  Lc_TamAll : Integer;
  Lc_Text_Inverso:String;
  Lc_Pos : Integer;
  Lc_FullPath : String;
  Lc_Path : String;
  Lc_FileName : String;
begin
  if (Pos(':\',FullPath) > 0) then
  Begin
    Lc_Text_Inverso := ReverseString(FullPath);
    Lc_Pos := Pos('\',Lc_Text_Inverso);
    if (Lc_Pos > 0) then
    Begin
      Lc_Text_Inverso := copy(Lc_Text_Inverso,1,Lc_Pos-1);
      Lc_FileName := ReverseString(Lc_Text_Inverso);
    End;

    Lc_TamAll := Length(FullPath);
    Lc_TamFile := Length(Lc_FileName) + 1;
    Lc_Path := Copy( FullPath,1, (Lc_TamAll -Lc_TamFile) );
  End
  else
  BEgin
    Lc_FileName := FullPath;
  End;
  //Retira extensão do arquivo
  if (Pos('.',Lc_FileName) > 0) then
  Begin
    Lc_TamAll := Length(Lc_FileName)- 4;
    Lc_FileName := Copy(Lc_FileName,1,Lc_TamAll);
  End;

  if Tipo = 'NFSE' then
  Begin
    if Lc_Path = '' then
      Lc_Path := RetNFse.Config.Registro.CaminhoNFSE;
    if not (Pos('\Notas',Lc_Path) > 0) then
      FFullPathNFSe.Path := concat(Lc_Path , '\Notas')
    else
      FFullPathNFSe.Path := concat(Lc_Path);
    if not DirectoryExists(FFullPathNFSe.Path) then  ForceDirectories(FFullPathNFSe.Path);
    FFullPathNFSe.FileNameXML := concat(Lc_fileName,'.xml');
    FFullPathNFSe.FileNamePDF := concat(Lc_fileName,'.pdf');
  End
  else
  BEgin
    if Lc_Path = '' then
      Lc_Path := RetNFse.Config.Registro.CaminhoRPS;
    if not (Pos('\Recibos',Lc_Path) > 0) then
      FFullPathRPs.Path := concat(Lc_Path , '\Recibos')
    else
      FFullPathRPs.Path := concat(Lc_Path);
    if not DirectoryExists(FFullPathRPs.Path) then  ForceDirectories(FFullPathRPS.Path);
    FFullPathRps.FileNameXML := concat(Lc_fileName,'.xml');
    FFullPathRps.FileNamePDF := concat(Lc_fileName,'.pdf');
  End;

end;

procedure TFr_geranfe_Srv.Pc_EstadoEdicaoConfig;
Begin
  SB_Cfg_Alterar.Enabled := (It_Edicao_Config = 'B');
  SB_Cfg_Gravar.Enabled   := (It_Edicao_Config = 'I') OR (It_Edicao_Config = 'E');
  Sb_Cfg_Cancelar.Enabled   := (It_Edicao_Config = 'I') OR (It_Edicao_Config = 'E');
  Sb_Cfg_Sair.Enabled := (It_Edicao_Config = 'B');
  Pnl_Config_Geral.Enabled := (It_Edicao_Config = 'I') OR (It_Edicao_Config = 'E');
  Pnl_Config_Arquivos.Enabled := (It_Edicao_Config = 'I') OR (It_Edicao_Config = 'E');
end;

//Teclas de Atalho
procedure TFr_geranfe_Srv.Pc_TeclaAtalhoNFSE(Key: Word);
Begin


end;

procedure TFr_geranfe_Srv.PreparaLinkParaEnvio;
Var
  Lc_LinkString : String;
  Lc_pos : Integer;
begin
  FLinkNFSe := PWideChar(RetNFse.Registro.Arquivo);
  Lc_LinkString := RetNFse.Registro.Arquivo;
  Lc_pos := Pos('http',Lc_LinkString);
  if Lc_pos = 0 then
  Begin
    MensagemPadrao('Mensagem o',ATENCAO+EOLN+EOLN+
                   'Não foi possível achar o link para o envio.'+EOLN+
                   'Efetue uma consulta para atualizar o retorno.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Exit;
  End;
  Lc_LinkString := Copy(Lc_LinkString,Lc_pos,Length(Lc_LinkString));
  FLinkNFSe := PWideChar(Lc_LinkString);

end;

procedure TFr_geranfe_Srv.PrepararArquivoParaEnvio;
begin
  SplitPathFile(RetNFSe.Registro.Arquivo,'NFSE');
  with MM_Acompanhamento,RetNFse.Registro do
  Begin
    If not VerificaExistenciaArquivoXML then
    Begin
      exit;
    end;

    if not FileExists(Concat(FFullPathNFSE.Path,'\',FFullPathNFSe.FileNameXML)) then
    Begin
      MM_Acompanhamento.Lines.Add('Salvando o arquivo no Disco...');
      Pc_Salva_Arq_Disco(6,
                         'XML',
                         CodigoNotaFiscal,
                         Concat(FFullPathNFSE.Path,'\',FFullPathNFSe.FileNameXML));

    end;
    NFS_e.NotasFiscais.Clear;
    NFS_e.NotasFiscais.LoadFromFile(Concat(FFullPathNFSE.Path,'\',FFullPathNFSe.FileNameXML), False);
    NFS_e.Configuracoes.Arquivos.NomeLongoNFSe := True;

    NFS_e.DANFSe.MostraPreview := True;
    NFS_e.DANFSe.PathPDF := Concat(FFullPathNFSE.Path,'\',FFullPathNFSe.FileNamePDF);
    NFS_e.NotasFiscais.ImprimirPDF;
  End;
end;

procedure TFr_geranfe_Srv.Rg_TipoCertificadoClick(Sender: TObject);
begin
  Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(TRadioGroup(sender).ItemIndex);
end;

procedure TFr_geranfe_Srv.Sb_ConsultarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_AtivaConfiguracaoNFSe;
    Fc_AtivaDadosDaNota;
    if Fc_ValidaConsultar then
    Begin
      Fc_CarregaComponenente;
      executeConsulta('Consultar');
      if not mostraErrosConsulta then
      Begin
        MM_Acompanhamento.Lines.Add('Consulta Finalizada com Sucesso!');
        if Fc_Atualiza_NFSE_by_Consulta then;
        Begin
          Pc_Insere_Arq_Banco(FFullPathNFSe.Path,
                    FFullPathNFse.FileNameXML,
                    6,
                    'XML',
                    RetNFse.Registro.CodigoNotaFiscal);

        End;
      End;
    end;

  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.Activate;
    Self.BringToFront;
  end;
end;

procedure TFr_geranfe_Srv.Pc_TeclaAtalhoConfig(Key: Word);
Begin


end;

procedure TFr_geranfe_Srv.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //NFS-e
    Sb_Gerar.Glyph.Assign(Fc_CarregaImagemBotao('CONFERIR'));
    SB_Enviar.Glyph.Assign(Fc_CarregaImagemBotao('AUTORIZAR'));
    Sb_Consultar.Glyph.Assign(Fc_CarregaImagemBotao('CONSULTAR'));
    Sb_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR NFE'));
    Sb_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Envia_Mensagem.Glyph.Assign(Fc_CarregaImagemBotao('ENVIA EMAIL'));
    Sb_sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    //Config
    SB_Cfg_Alterar.Glyph.Assign(Fc_CarregaImagemBotao('ALTERAR'));
    SB_Cfg_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    Sb_Cfg_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Cfg_Sair.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;


end;

procedure TFr_geranfe_Srv.Pc_Inicia_variaveis;
Begin
  //Sobre o Certificado
  with nfs_e.Configuracoes.Certificados do
  Begin
    ArquivoPFX :='';
    DadosPFX := '';
    nfs_e.Configuracoes.Certificados.Name :='';
    NumeroSerie := '';
    Senha := '';
  End;
  //Pode user usado alguns dados compartilhados
  Pc_AtivaConfiguracaoNFSe;
  //Ativa dados do Estabelecimento
  Pc_AtivaEstabelecimento();
  //Ajusta as configurações de SSL
  Pc_SSL2_TLS1_NFSE;
  //Ativa os dados das configurações da Nfe
  Qr_Nota.Close;
  if It_Tipo_Operacao = 'NFS-e' then
  Begin
    Pc_Inicia_variaveisNFSe;
  end;
  if It_Tipo_Operacao = 'Config' then
  Begin
    Pc_Inicia_variaveisConfig
  end;
  MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);
  FConsumidorFinal := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
end;

procedure TFr_geranfe_Srv.Pc_Inicia_variaveisNFSe;
Begin
  try
    pg_Principal.ActivePage := tbs_NFS_e;
    RetNFse.inicializa;
    RetNFse.Config.ConfiguraComponente(NFS_e,dm.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString);
    FProvider := TACBrNFSeX(NFS_e).Provider;
  except
    on E : Exception do
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     E.Message  +EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
  end;
end;


procedure TFr_geranfe_Srv.Pc_Inicia_variaveisConfig;
var
  T: TSSLLib;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
  L: TLayoutNFSe;
  J: TFormatoDiscriminacao;
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

  cbLayoutNFSe.Items.Clear;
  for L := Low(TLayoutNFSe) to High(TLayoutNFSe) do
    cbLayoutNFSe.Items.Add(GetEnumName(TypeInfo(TLayoutNFSe), integer(L)));
  cbLayoutNFSe.ItemIndex := 0;

  cbFormatoDiscr.Items.Clear;
  for J := Low(TFormatoDiscriminacao) to High(TFormatoDiscriminacao) do
    cbFormatoDiscr.Items.Add(GetEnumName(TypeInfo(TFormatoDiscriminacao), integer(J)));
  cbFormatoDiscr.ItemIndex := 0;


  pg_Principal.ActivePage := tbs_config;
  Pg_NFeConfig.ActivePage := tbs_ConfigGeral;
  Pc_PreencherNFSE;
  It_Edicao_Config := 'B';
  Pc_EstadoEdicaoConfig;
  RetNFse.Config.CarregaDadosEmitente(NFS_e,dm.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString);
  Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(Rg_TipoCertificado.ItemIndex);
end;

procedure TFr_geranfe_Srv.Pc_FormataTela;
Begin


end;

procedure TFr_geranfe_Srv.Pc_PreencherNFSE;
Var
  i:iNTEGER;
Begin
  with RetNFse.Config do
  BEgin
    Registro.CodigoEstabelecimento := Gb_CodMha;
    get;
    with Registro do
    Begin
      if exist then
      Begin
        Rg_Ambiente.ItemIndex := StrtoIntDef(Ambiente,1);
        E_Serie_Certificado.Text := Certificado;
        E_User_Web.Text := UsuarioWeb;
        E_Pws_WEb.Text := SenhaWeb;
        E_Path_NFSe.Text := CaminhoNFSE;
        E_Frase_WEb.Text := FraseWeb;
        E_Path_RPS.Text := CaminhoRPS;
        E_NomePrefeitura.Text := Prefeitura;
        E_LogoPrefeitura.Text := LogoPrefeitura;
        E_Arq_Ini_Provedor.Text := ArquivoIniProvedor;
        E_Path_Schemas.Text := SchemasProvedor;
        chbx_Visualizar.Checked := (VisualizaMensagem = 'S');
        chbx_copia_nfe.Checked := (CopiaEmail = 'S');
        E_Nfse_Cd_LC116.Text := CodigoSrvLLC;
        E_CodigoTribMunicipio.Text := CodigoTributarioMunicipal;
        E_CodigoCnae.Text := CNAE;
        E_CodigoNBS.Text := CodigoNBS;
        Cb_CRET.ItemIndex := CodigoRegimeEspecialTributacao;
        for I := 0 to (Cb_Provedor.Items.Count - 1) do
        Begin
          if (Cb_Provedor.Items[I] = Provedor) then
            Cb_Provedor.ItemIndex := I;
        End;


        cbLayoutNFSe.ItemIndex := StrToIntDef( LayoutNFse,0);

        //TFormatoDiscriminacao(cbFormatoDiscr.ItemIndex);
        cbFormatoDiscr.ItemIndex := StrToIntDef(FormatoDiscr,0);

        for I := 0 to (Cb_Versao_utilizado.Items.Count - 1) do
        Begin
          if (Copy(Cb_Versao_utilizado.Items[I],1,20) = Copy(Versao,1,20)) then
            Cb_Versao_utilizado.ItemIndex := I;
        End;

      End;
    End;
  end;
  Rg_TipoCertificado.ItemIndex    := StrToIntDef( Fc_Aq_Geral('L', 'NFS', 'NFS_TIPO_CERT','0'),0);
  E_Senha_Certificado.Text  := Fc_Tb_Geral('L','NFS_SENHA_CERT','');
  cbSSLType.ItemIndex       := StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_TIPO_SSL','-1'),-1 );
  Rg_SSLTLS.ItemIndex       := StrToIntDef( Fc_Aq_Geral('L', 'NFS', 'NFS_SSLTLS','0'),0);

  cbSSLLib.ItemIndex        := StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_SSLLib','-1'),-1 );
  cbCryptLib.ItemIndex      := StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_CryptLib','-1'),-1 );
  cbHttpLib.ItemIndex       := StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_HttpLib','-1'),-1 );
  cbXmlSignLib.ItemIndex    := StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_XmlSignLib','-1'),-1 );

End;

procedure TFr_geranfe_Srv.Pc_PathClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(TEdit(Sender).Text) <= 0 then
     Dir := ExtractFileDir(application.ExeName)
  else
     Dir := TEdit(Sender).Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    TEdit(Sender).Text := Dir;
end;



function TFr_geranfe_Srv.Fc_AtivaDadosDaNota():Boolean;
begin
  RetNFse.getAll;
  with Qr_Nota do
  Begin
    Close;
    ParamByName('NFL_CODIGO').AsInteger := RetNFse.Registro.CodigoNotaFiscal;
    Active := True;
    FetchAll;
    Result := (RecordCount > 0);
  end;
end;



function TFr_geranfe_Srv.Fc_DefineNumeroRPS():Boolean;
Var
  Lc_Nr_Recibo : String;
  Lc_Rps : TControllerRpsNfse;
Begin
  Result := True;
  Lc_Nr_Recibo := '';
  if CkBx_Recibo_Manual.Checked then
  Begin
    if not(InputQuery('Autorização da NFS-e ', 'Número do Recibo Provisório', Lc_Nr_Recibo)) then
    Begin
      Result := False;
      exit;
    end;
    if StrToIntDef(Lc_Nr_Recibo,0) = 0 then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número de RPS Informado é inválido !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;

    Lc_Rps := TControllerRpsNfse.create(Self);
    Lc_Rps.Registro.CodigoEstabelecimento := RetNFse.Registro.CodigoEstabelecimento;
    Lc_RPS.Registro.Numero := StrToIntDef(Lc_Nr_Recibo,0);
    if Lc_RPS.exist then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número de RPS Informado já existe !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;
    MM_Acompanhamento.Lines.Add('Número do Recibo Provisório Informado: ' + Lc_Nr_Recibo);
    RetNFse.Rps.Registro.Numero := StrToIntDef(Lc_Nr_Recibo,0);
  end;
end;

function TFr_geranfe_Srv.Fc_DefineNumeroLOTE():Boolean;
Var
  Lc_Nr_Lote : String;
Begin
  Result := True;
  //Gerar o numero RPS
  if CkBx_Lote_Manual.Checked then
  begin
    if not(InputQuery('Autorização da NFS-e ', 'Informe um número de Lote', Lc_Nr_Lote)) then
    Begin
      Result := False;
      exit;
    end;
    if StrToIntDef(Lc_Nr_Lote,0) = 0 then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número de LOTE Informado é inválido !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;
    RetNFse.Lote.Registro.Numero := StrToIntDef(Lc_Nr_Lote,0);
    if RetNFse.Lote.existLote then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número de LOTE Informado já existe !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      RetNFse.Lote.Registro.Numero := 0;
      Result := False;
      exit;
    end;
    MM_Acompanhamento.Lines.Add('Lote Informado  - Número : ' + Lc_Nr_Lote);
  end;
end;


//Compoenente NFS-e
Function TFr_geranfe_Srv.Fc_CarregaComponenente():boolean;
var
 Lc_TaxAprox : Double;
 Lc_Ok : Boolean;
 Lc_I : Integer;
 Lc_Txt_Item : String;
 Lc_Txt_Itens : String;

begin
  Result := False;

  NFS_e.NotasFiscais.Clear;

  with NFS_e, RetNFse.Lote do
  begin

    NotasFiscais.NumeroLote:= IntToStr(Registro.Numero);
    NotasFiscais.Transacao := True;

    with NotasFiscais.new.NFSe , RetNFse do
    begin
      // Numero do DPS a ser gerado e enviado para o WebService
      Numero := RPS.Registro.Numero.ToString;

      verAplic := 'GestaoNFSE-1.00';

      IdentificacaoRps.Numero := FormatFloat('#########0', RPS.Registro.Numero);

      with Configuracoes.Geral do
      Begin
        if ( Configuracoes.WebServices.Ambiente = taHomologacao ) then
        Begin
          IdentificacaoRps.Serie := '001';
          // Para o provedor ISS.NET em ambiente de Homologação mudar a série para '8'
          if ( RetNFse.Config.Registro.Provedor = 'ISSNet' ) then
          Begin
            IdentificacaoRps.Serie := '8';
            // Para o provedor ISS.NET em ambiente de Homologação o Codigo CNAE tem que ser '6511102'
            //alterei por que em Santa Maria não deu certo com o o 6511102
          End;
          // Para o provedor IPM Sistema em ambiente de Homologação/Contngencia mudar a série para '8'
          if ( RetNFse.Config.Registro.Provedor = 'IPMSistemas' ) then
            IdentificacaoRps.Serie := '8';
        End
        else
        Begin
          //Geral - PadraoNacional
          IdentificacaoRps.Serie := '001';
          // Para o provedor ISS.NET em ambiente de Produção mudar a série para '20'
          if ( RetNFse.Config.Registro.Provedor = 'ISSNet' ) then
            IdentificacaoRps.Serie := '20';
          // Para o provedor ISS.NET em ambiente de Produção mudar a série para '20'
          if ( RetNFse.Config.Registro.Provedor = 'IPMSistemas' ) then
            IdentificacaoRps.Serie := '1';
        End;
      End;

      // Provedor Agili




      // TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
      IdentificacaoRps.Tipo := trRPS;
      //GRAVA EM NFS_DATETIME
      DataEmissaoRps := Now;
      DataEmissao := Now;
      Competencia := Now;
      if ( RetNFse.Config.Registro.Provedor = 'IPMSistemas' ) then
        NaturezaOperacao := no0
      else
        NaturezaOperacao := no1;
      // TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP );
      case RetNFse.Config.Registro.CodigoRegimeEspecialTributacao of
        0: RegimeEspecialTributacao := retNenhum;
        1: RegimeEspecialTributacao := retMicroempresaMunicipal;
        2: RegimeEspecialTributacao := retEstimativa;
        3: RegimeEspecialTributacao := retSociedadeProfissionais;
        4: RegimeEspecialTributacao := retCooperativa;
        5: RegimeEspecialTributacao := retMicroempresarioIndividual;
        6: RegimeEspecialTributacao := retMicroempresarioEmpresaPP;
        7: RegimeEspecialTributacao := retLucroReal;
        8: RegimeEspecialTributacao := retLucroPresumido;
        9: RegimeEspecialTributacao := retSimplesNacional;
      end;


      //rever - RegimeEspecialTributacao :=   StrToRegimeEspecialTributacao(Lc_ok, IntToStr( RetNFse.Config.Registro.CodigoRegimeTributario ));

      // TnfseSimNao = ( snSim, snNao );

      if (DM.Qr_Estabelecimento.FieldByName('EMP_CRT').AsInteger = 3) then
      Begin
        OptanteSimplesNacional := snNao
      End
      else
      Begin
        OptanteSimplesNacional := snSim;
        // TOptanteSN = (osnNaoOptante, osnOptanteMEI, osnOptanteMEEPP)
        OptanteSN := osnOptanteMEEPP;
      End;

      IncentivadorCultural := snNao;
      // snNao = Ambiente de Homologação - snSim = Ambiente de Produção
      if config.Registro.Ambiente ='0' then
        Producao := snSim
      else
        Producao := snNao;

      // TnfseStatusRPS = ( srNormal, srCancelado );
      IF (Qr_Nota.FieldByName('NFL_STATUS').AsString = 'F')  then
        StatusRps := srNormal
      else
        StatusRps := srCancelado;

      // Somente Os provedores Betha, FISSLex e SimplISS permitem incluir no RPS
      // a TAG: OutrasInformacoes os demais essa TAG é gerada e preenchida pelo
      // WebService do provedor.
      if Copy(Qr_nota.FieldByname('PED_PRAZO').AsString,1,3) = '000' then
      Begin
        CondicaoPagamento.Condicao := cpAVista;
      End
      else
      Begin
        CondicaoPagamento.Condicao := cpAPrazo;
        Qr_Parcelamento.Active := False;
        Qr_Parcelamento.ParamByName('PAR_CODPED').AsInteger := Qr_nota.FieldByname('PED_CODIGO').AsInteger;
        Qr_Parcelamento.Active := True;
        Qr_Parcelamento.FetchAll;
        CondicaoPagamento.QtdParcela := Qr_Parcelamento.RecordCount;
        Qr_Parcelamento.First;
        while not Qr_Parcelamento.Eof do
        Begin
          with CondicaoPagamento.Parcelas.Add do
          Begin
            Parcela := Qr_Parcelamento.FieldByname('PAR_PARCELA').AsString;
            DataVencimento := Qr_Parcelamento.FieldByname('PAR_DATA').AsDateTime;
            Valor := Qr_Parcelamento.FieldByname('PAR_VALOR').AsCurrency;
          End;
          Qr_Parcelamento.Next;
        End;
      End;

      // Usado quando o RPS for substituir outro
      //RpsSubstituido.Numero := FormatFloat('#########0', i);
      //TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
      //RpsSubstituido.Tipo   := trRPS;
      //Ativa dados dos itens

      with Servico, Qr_Itens do
      Begin
        OpenItens(Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);

        //Servico.Valores
        setValoresNFSE(Valores);

        //Servico.ItemListaServico
        //Servico.CodigoCnae
        //Servico.CodigoTributacaoMunicipio
        //Servico.xCodigoTributacaoMunicipio
        //Servico.CodigoMunicipio
        //Servico.CodigoPais
        //Servico.ExigibilidadeISS
        //Servico.MunicipioIncidencia
        //Servico.NumeroProcesso
        //Servico.xItemListaServico
        //Servico.ItemServico
        //Servico.ResponsavelRetencao
        //Servico.Descricao
        //Servico.Deducao
        //Servico.Tributacao
        //Servico.UFPrestacao
        //Servico.ValorCargaTributaria
        //Servico.PercentualCargaTributaria
        //Servico.FonteCargaTributaria

        if ( RetNFse.Config.Registro.Provedor = 'IPMSistemas' ) then
        Begin
          if Nfs_e.Configuracoes.Geral.Layout = loABRASF then
            CodigoTributacaoMunicipio := ''
          else
            CodigoTributacaoMunicipio := 'S'
        End
        else
          CodigoTributacaoMunicipio := RetNFse.Config.Registro.CodigoTributarioMunicipal;
        CodigoNBS := RetNFse.Config.Registro.CodigoNBS;// '100101010';
        CodigoMunicipio := DM.Qr_Estabelecimento.FieldByName('CDD_IBGE').AsString ;



        // TnfseResponsavelRetencao = ( ptTomador, rtPrestador );
        ResponsavelRetencao := rtTomador;
        if (RetNFse.Config.Registro.CodigoSrvLLC <> '') then
          ItemListaServico        := RetNFse.Config.Registro.CodigoSrvLLC;
        CodigoCnae                := RetNFse.Config.Registro.CNAE;

        //Esse controle deve ficar aqui por que está dentro de uma outra tag
        if ( Configuracoes.WebServices.Ambiente = taHomologacao ) then
        Begin
          if ( RetNFse.Config.Registro.Provedor = 'ISSNet' ) then
          Begin
            // Para o provedor ISS.NET em ambiente de Homologação o Codigo CNAE tem que ser '6511102'
            //alterei por que em Santa Maria não deu certo com o o 6511102
           CodigoCnae := '3311200';
          End;
        End;
        first;
        Lc_I := 1;
        Lc_Txt_Itens := '';
        Lc_Txt_Item := '';
        first;
        while not eof do
        Begin
          Lc_Txt_Item := FloattoStrF(FieldByName('ITF_QTDE').AsFloat, ffNumber,10,0) + ' - ' + TiraAcentos( FieldByName('PRO_DESCRICAO').AsString) + ' - R$ ' + FloattoStrF(FieldByName('ISS_VL_SUBTOTAL').AsCurrency, ffNumber,10,2);
          if Lc_I  = 1 then
            Lc_Txt_Itens := Lc_Txt_Item
          else
            Lc_Txt_Itens := Lc_Txt_Itens + #13 + Lc_Txt_Item;
          // Somente o provedor SimplISS permite infomar mais de 1 serviço
          with Servico.ItemServico.Add do
          begin
            if (RetNFse.Config.Registro.CodigoSrvLLC <> '') then
              ItemListaServico        := RetNFse.Config.Registro.CodigoSrvLLC;
            CodMunPrestacao := Qr_Nota.FieldByName('CDD_IBGE').asString;

            Descricao     := TiraAcentos( FieldByName('PRO_DESCRICAO').AsString);
            Quantidade    := FieldByName('ITF_QTDE').AsFloat;
            ValorUnitario := FieldByName('ITF_VL_UNIT').AsCurrency;
            ValorDeducoes := FieldByName('ITF_VL_DESC').AsCurrency;

            ValorTotal := (Quantidade * ValorUnitario) - ValorDeducoes;

            ValorTributavel := (Quantidade * ValorUnitario) - ValorDeducoes;
            ValorISSRetido := 0;


            if ( RetNFse.Config.Registro.Provedor = 'IPMSistemas' ) then
            Begin
              CodLCServ :=  FieldByName('PRO_CODIGO').AsString;
              Quantidade := FieldByName('ITF_QTDE').AsFloat;
            End;
          end;
          Next;
          inc(Lc_I);
        End;
        //Servico.Discriminacao;
        Discriminacao := Lc_Txt_Itens;
        CodigoCnae :=  RetNFse.Config.Registro.CNAE;

        //ObservaçoesInformaçoes de Interesse do Financeiro
        Qr_Observacao.Active := False;
        Qr_Observacao.ParamByName('NFL_CODIGO').AsInteger := RetNFse.Registro.CodigoNotaFiscal;
        Qr_Observacao.ParamByName('OBN_TIPO').AsString := 'S';
        Qr_Observacao.Active := True;
        Qr_Observacao.FetchAll;
        Qr_Observacao.First;
        if Qr_Observacao.RecordCount > 0 then
        Begin
          Lc_Txt_Itens := Lc_Txt_Itens + #13 + 'Observações: ';
          while not Qr_Observacao.Eof do
          Begin
            Lc_Txt_Itens := Lc_Txt_Itens + #13 + Alltrim(Qr_Observacao.FieldByName('OBN_DETALHE').Asstring);
            Qr_Observacao.Next;
          end;
          OutrasInformacoes := Lc_Txt_Itens;
        End;
        //Mensagem do Imposto Aproximado
        Lc_TaxAprox := StrToFloatDef(Fc_Tb_Geral('L','GRL_G_AQ_APROX_MUN',''),0);
        if ( Lc_TaxAprox > 0 ) then
        Begin
          Lc_Txt_Itens := concat(Lc_Txt_Itens, #13 ,
                                'Valor aprox. do Imp. Municipal R$ ',FloatToStrF( (Valores.BaseCalculo * Lc_TaxAprox)/100,ffFixed,10,2),
                                ' ('+ FloatToStrF(Lc_TaxAprox,ffFixed,10,2) +')%'
                                );
        End;
        //Registra no Componente
        Discriminacao := Lc_Txt_Itens;

        if ( Configuracoes.WebServices.Ambiente = taHomologacao ) then
        Begin
          // Para o provedor ISS.NET em ambiente de Homologação o Codigo do Municipio tem que ser '999'
          if ( RetNFse.Config.Registro.Provedor = 'ISSNet' ) then
          Begin
            CodigoMunicipio := '999';
          End;
        End;
        // Informar A Exigibilidade ISS para fintelISS [1/2/3/4/5/6/7]

        ExigibilidadeISS := FProvider.StrToExigibilidadeISS(Lc_Ok, Qr_nota.FieldByName('CLI_ISS_EXIGIB').asString);
                                ;
        // Informar para Saatri
        CodigoPais := 1058; // Brasil
        //MunicipioIncidencia := Qr_nota.FieldByName('CDD_IBGE').asInteger; Alterei para a HB em 11/03/2024
        MunicipioIncidencia := DM.Qr_Estabelecimento.FieldByName('CDD_IBGE').AsInteger;
      End;

      //=================================Empresa que prestou o serviço===================================

      with DM.Qr_Estabelecimento, Prestador do
      Begin
        // Identificador
        IdentificacaoPrestador.Cnpj     := FieldByName('EMP_CNPJ').asString;
        IdentificacaoPrestador.CpfCnpj  := FieldByName('EMP_CNPJ').asString;
        IdentificacaoPrestador.InscricaoMunicipal := FieldByName('EMP_INSC_MUN').asString;
        IdentificacaoPrestador.InscricaoEstadual  := FieldByName('EMP_INSC_EST').asString;
        //Prestador
        Prestador.cUF                 := FieldByName('UFE_CODIGO').asInteger;
        //Prestador
        //RazaoSocial                   := TiraAcentos( FieldByName('EMP_NOME').asString);
        //NomeFantasia                  := TiraAcentos(FieldByName('EMP_FANTASIA').asString);
        Endereco.Endereco             := TiraAcentos(FieldByName('END_ENDER').asString);
        Endereco.Numero               := FieldByName('END_NUMERO').asString;
        Endereco.Complemento          := TiraAcentos(FieldByName('END_COMPLEM').asString);
        Endereco.Bairro               := TiraAcentos(FieldByName('END_BAIRRO').asString);
        Endereco.CodigoMunicipio      := FieldByName('CDD_IBGE').asString;
        Endereco.UF                   := FieldByName('UFE_SIGLA').asString;
        Endereco.CodigoPais           := 1058; // Brasil
        Endereco.CEP                  := FieldByName('END_CEP').asString;
	      //Provedor Equiplano é obrigatório o pais e IE
        Endereco.xPais           := 'BRASIL';
        Contato.Telefone := FieldByName('END_FONE').asString;
        Contato.Email    := FieldByName('EMP_EMAIL').asString;

      End;

      //=================================Cliente que tomou o serviço=====================================

      with Tomador do
      Begin
        IdentificacaoTomador.CpfCnpj            := Qr_Nota.FieldByName('EMP_CNPJ').asString;
        IdentificacaoTomador.InscricaoMunicipal := Qr_Nota.FieldByName('EMP_INSC_MUN').asString;
        IdentificacaoTomador.InscricaoEstadual  := Qr_Nota.FieldByName('EMP_INSC_EST').asString;
        if Length(IdentificacaoTomador.CpfCnpj) = 11 then
          IdentificacaoTomador.Tipo := tpPF
        else
          if ( Qr_Nota.FieldByName('CDD_IBGE').asString = DM.Qr_Estabelecimento.FieldByName('CDD_IBGE').asString ) then
            IdentificacaoTomador.Tipo := tpPJdoMunicipio
          else
            IdentificacaoTomador.Tipo := tpPJforaMunicipio;

        RazaoSocial              := TiraAcentos(Qr_Nota.FieldByName('EMP_NOME').asString);
        Endereco.Endereco        := TiraAcentos(Qr_Nota.FieldByName('END_ENDER').asString);
        Endereco.Numero          := Qr_Nota.FieldByName('END_NUMERO').asString;
        Endereco.Complemento     := TiraAcentos(Qr_Nota.FieldByName('END_COMPLEM').asString);
        Endereco.Bairro          := TiraAcentos(Qr_Nota.FieldByName('END_BAIRRO').asString);
        Endereco.CodigoMunicipio := Qr_Nota.FieldByName('CDD_IBGE').asString;
        Endereco.UF              := Qr_Nota.FieldByName('UFE_SIGLA').asString;
        Endereco.CodigoPais      := 1058; // Brasil
        Endereco.CEP             := Qr_Nota.FieldByName('END_CEP').asString;
	      //Provedor Equiplano é obrigatório o pais e IE
        Endereco.xPais           := 'BRASIL';
        IdentificacaoTomador.InscricaoEstadual := Qr_Nota.FieldByName('EMP_INSC_EST').asString;
        Contato.Telefone := Qr_Nota.FieldByName('END_FONE').asString;
        Contato.Email    := Qr_Nota.FieldByName('EMP_EMAIL').asString;
        //Usado quando houver um intermediario na prestação do serviço
        //IntermediarioServico.RazaoSocial        := 'razao';
        //IntermediarioServico.CpfCnpj            := '00000000000';
        //IntermediarioServico.InscricaoMunicipal := '12547478';
        // Usado quando o serviço for uma obra
        //ConstrucaoCivil.CodigoObra := '88888';
        //ConstrucaoCivil.Art        := '433';
      end;
      if ( Fc_Tb_Geral('L','GRL_G_REF_TRIBUTARIA','N') = 'S') then
      Begin
        CarregaDadosReformaTributaria;
      End;


      Result := True;
      NotasFiscais[0].GerarXML;
    end;
  end;
end;


//Geração
function TFr_geranfe_Srv.Fc_ValidaGeracao():Boolean;
Begin
  Result := True;
  if VerificaNotaProcessada then
  Begin
    result := False;
    Exit;
  End;
end;

Function TFr_geranfe_Srv.Fc_Gera_RPS():Integer;
begin
  with RetNFse.Rps do
  Begin
    Registro.CodigoNotaFiscal := RetNFse.Registro.CodigoNotaFiscal;
    Registro.CodigoEstabelecimento := RetNFse.Registro.CodigoEstabelecimento;
    if Registro.Numero = 0 then
      RetNFse.Rps.insere
    else
      RetNFse.Rps.salva;
  end;
end;


//Enviar
function TFr_geranfe_Srv.Fc_ValidaEnvio():Boolean;
Var
  Lc_Verificacao : Integer;
Begin
  Result := true;
  OpenItens(Qr_Nota.FieldByName('NFL_CODIGO').AsInteger);
  if Qr_Itens.recordCount = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não foi possivel carregar os itens da Nota.' + EOLN +
                   ' Cancele e fature novamente' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if not VerificaCarregamentoNota then
  Begin
    Result := False;
    exit;
  end;

  if VerificaNotaProcessada then
  Begin
    Result := False;
    Exit;
  end;

  // Situações da Nota Fiscal em Curitiba /   1 – Não Recebido   2 – Não Processado   3 – Processado com Erro   4 – Processado com Sucesso
  VerificaRpsProcessadaComErro;

  if not Fc_DefineNumeroLote then
  Begin
    Result := False;
    Exit;
  end;

  if not Fc_DefineNumeroRPS then
  Begin
    Result := False;
    Exit;
  end;
end;

function TFr_geranfe_Srv.Pc_Envia_RPS:boolean;
Begin
  try
    MM_Acompanhamento.Lines.Add('Verficando Lote antes de Enviar...');
    RetNFse.Lote.Registro.Observacao := 'Enviado o RPS ' + IntToStr( RetNFse.RPS.Registro.numero );
    RetNFse.Lote.salva;
    MM_Acompanhamento.Lines.Add('Enviando R.P.S para autorização...');
    NFS_e.Emitir(RetNFse.Lote.Registro.Numero.ToString() );
    Result := True;
  Except
    on E : Exception do
    Begin
      MM_Acompanhamento.Lines.Add('Erro: ' + E.Message);
      Result := False;
    End;
  end;
end;

Function TFr_geranfe_Srv.Fc_Atualiza_RPS:Boolean;
begin
  Result := False;
  if Trim(NFS_e.WebService.ConsultaLoteRps.Protocolo) <> '' then
  Begin
    if NFS_e.WebService.Emite.Protocolo <> '' then
    Begin
      RetNFse.RPS.Registro.Protocolo    := NFS_e.WebService.Emite.Protocolo;
      RetNFse.RPS.Registro.Observacao   := NFS_e.WebService.Emite.Situacao;
      RetNFse.RPS.Registro.DataEmissao  := NFS_e.WebService.Emite.Data;
      RetNFse.RPS.salva;
    End
    else
    if NFS_e.WebService.ConsultaLoteRps.Protocolo <> '' then
    Begin
      RetNFse.RPS.Registro.Protocolo    := NFS_e.WebService.ConsultaLoteRps.Protocolo;
      RetNFse.RPS.Registro.Observacao   := NFS_e.WebService.ConsultaLoteRps.Situacao;
      RetNFse.RPS.Registro.DataEmissao  := NFS_e.WebService.ConsultaLoteRps.Data;
      RetNFse.RPS.salva;
    End;
    Result := True;
  End;
End;


function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Arquivo: Boolean;
Var
  Lc_Dialogo : TOpenDialog;
  Lc_I: Integer;
begin
  Try
     NFS_e.NotasFiscais.Clear;
    Lc_Dialogo := TOpenDialog.Create(self);
    // Allow only .dpr and .pas files to be selected
    Lc_Dialogo.Filter := 'Arquivos XML - NF-|*.xml';
    Lc_Dialogo.FilterIndex := 1;
    if Lc_Dialogo.execute then
    Begin
      SplitPathFile(Lc_Dialogo.FileName,'NFSE');
      NFS_e.NotasFiscais.LoadFromFile(concat(FFullPathNFSe.Path, '\', FFullPathNFSe.FileNameXML));
      with NFS_e,RetNFse do
      Begin
        with NotasFiscais.Items[0] do
        Begin
          Registro.ReciboProvisorios  := RetNFse.Rps.registro.numero;
          Registro.Lote               := StrToIntDef(NFSe.NumeroLote,1);
          Registro.CodigoVerificacao  := NFSe.CodigoVerificacao;
          Registro.Tipo               := '1';
          Registro.CodigoNAtureza     := 1;
          Registro.Data               := NFSe.DataEmissao;
          Registro.Sincrono           := 'S';
          Registro.Numero             := NFSe.Numero;
          if trim(NFSe.Numero) <> '' then
            Registro.CodigoSituacao     := 4
          else
            Registro.CodigoSituacao     := 3;
          Registro.Arquivo            := FFullPathNFSe.FileNameXML;
          Registro.Motivo             := WebService.ConsultaSituacao.DescSituacao;
          salva;
          Result := True;
        End;
      end;

    End;
  Finally
    FreeAndNil(Lc_Dialogo);
  End;
end;

function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Consulta: Boolean;
begin
  Result := False;
  SplitPathFile(NFS_e.NotasFiscais.Items[0].NomeArq,'NFSE');
  case NFS_e.Configuracoes.Geral.Provedor of
    proIPM: begin
      if Nfs_e.Configuracoes.Geral.Layout = loABRASF then
        Result := Fc_Atualiza_NFSE_by_Consulta_ProIPM
      else
        Result := Fc_Atualiza_NFSE_by_Consulta_ProIPM_V01;
    end;
    proISSNet:Result := Fc_Atualiza_NFSE_by_Consulta_proISSNet;
  else
    Result := Fc_Atualiza_NFSE_by_Consulta_General
  end;
end;


function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Consulta_General: Boolean;
begin
  Result := False;
  with NFS_e,RetNFse do
  Begin
    with NotasFiscais.Items[0] do
    Begin
      MM_Acompanhamento.Lines.Add('Atualizando retorno da Nota Fiscal...');
      //Verifica se a nota foi autorizada
      if ( ( NFSe.Situacao  = 4 ) or
           ( StrToIntDef(NFSe.Numero,0) > 0)) and
         ( Trim(NFSe.CodigoVerificacao)  <> '')  then
      Begin
        Registro.ReciboProvisorios  := RetNFse.Rps.registro.numero;
        Registro.Lote               := StrToIntDef(NFSe.NumeroLote,1);
        Registro.CodigoVerificacao  := NFSe.CodigoVerificacao;
        Registro.Tipo               := '1';
        Registro.CodigoNAtureza     := 1;
        Registro.Data               := NFSe.DataEmissao;
        Registro.Sincrono           := 'S';
        Registro.Numero             := NFSe.Numero;

        if (NFS_e.NotasFiscais.Items[0].NFse.SituacaoNfse = TStatusNFSe.snCancelado) then
          Registro.CodigoSituacao     := 5
        else
          if Trim(NFSe.Numero) <> '' then
            Registro.CodigoSituacao     := 4
          else
            Registro.CodigoSituacao     := 3;
        Registro.Arquivo            := FFullPathNFSe.FileNameXMl;
        Registro.Motivo             := WebService.ConsultaSituacao.DescSituacao;
        salva;
        Result := True;
      End;
    End;
  end;
end;

function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Consulta_ProIPM: Boolean;
begin
  Result := False;
  with NFS_e,RetNFse do
  Begin
    //WebService.ConsultaNFSe.Sucesso
    Registro.ReciboProvisorios  := 0;

    Registro.Lote               := StrToIntDef(NotasFiscais.Items[0].NFSe.NumeroLote,0);
    Registro.CodigoVerificacao  := NotasFiscais.Items[0].NFSe.CodigoVerificacao;
    Registro.Tipo               := '1';
    Registro.CodigoNAtureza     := 1;
    Registro.Data               := NotasFiscais.Items[0].NFSe.DataEmissao;
    Registro.Sincrono           := 'S';
    Registro.Numero             := NotasFiscais.Items[0].NFSe.Numero; //WebService.ConsultaNFSe.NumeroNota;

    Registro.Protocolo          := '';

    if Trim(NotasFiscais.Items[0].NFSe.Numero)<> '' then
      Registro.CodigoSituacao     := 4;
    if NotasFiscais.Items[0].NFSe.SituacaoNfse = ACBrNFSeXConversao.snCancelado then
      Registro.CodigoSituacao     := 5;

    Registro.Arquivo            := FFullPathNFSe.FileNameXML ;
    Registro.Motivo             := WebService.ConsultaNFSe.DescSituacao;
    salva;
    Result := True;
  end;
end;

function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Consulta_ProIPM_V01: Boolean;
Var
  Lc_Situacao : String;
begin
  Result := False;
  with RetNFse do
  Begin
      //WebService.ConsultaNFSe.Sucesso
      Registro.ReciboProvisorios  := 0;
      Registro.Lote               := StrToIntDef(NFS_e.WebService.ConsultaNFSe.NumeroLote,0);
      Registro.CodigoVerificacao  := NFS_e.WebService.ConsultaNFSe.CodigoVerificacao;
      Registro.Tipo               := '1';
      Registro.CodigoNAtureza     := 1;
      Registro.Data               := NFS_e.WebService.ConsultaNFSe.Data;
      Registro.Sincrono           := 'S';
      Registro.Numero             := NFS_e.WebService.ConsultaNFSe.NumeroNota; //WebService.ConsultaNFSe.NumeroNota;
      Registro.Protocolo          := NFS_e.WebService.ConsultaNFSe.Protocolo;

      if Trim(NFS_e.WebService.ConsultaNFSe.NumeroNota)<> '' then
        Registro.CodigoSituacao     := 4;
      Lc_Situacao := NFS_e.WebService.ConsultaNFSe.Situacao;
      //if WebService.Emite.Situacao = '' then //ACBrNFSeXConversao.snCancelado then
      //  Registro.CodigoSituacao     := 5;

      Registro.Arquivo            := NFS_e.WebService.ConsultaNFSe.Link;
      Registro.Motivo             := NFS_e.WebService.ConsultaNFSe.DescSituacao;
      salva;
      Result := True;
  end;
end;

function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Consulta_proISSNet: Boolean;
begin
  Result := False;
  with NFS_e,RetNFse do
  Begin
    with NotasFiscais[0] do
    Begin
      MM_Acompanhamento.Lines.Add('Atualizando retorno da Nota Fiscal...');
      //Verifica se a nota foi autorizada
      if ( ( NFSe.Situacao  = 4 ) or
           ( StrToIntDef(NFSe.Numero,0) > 0)) and
         ( Trim(NFSe.CodigoVerificacao)  <> '')  then
      Begin
        Registro.ReciboProvisorios  := RetNFse.Rps.registro.numero;
        Registro.Lote               := StrToIntDef(NFSe.NumeroLote,1);
        Registro.CodigoVerificacao  := NFSe.CodigoVerificacao;
        Registro.Tipo               := '1';
        Registro.CodigoNAtureza     := 1;
        Registro.Data               := NFSe.DataEmissao;
        Registro.Sincrono           := 'S';
        Registro.Numero             := NFSe.Numero;
        if Trim(NFSe.Numero) <> '' then
          Registro.CodigoSituacao     := 4
        else
          Registro.CodigoSituacao     := 3;
        Registro.Arquivo            := FFullPathNFSe.FileNameXMl;
        Registro.Motivo             := WebService.ConsultaNFSeporRps.DescSituacao;
      End;
        salva;
        Result := True;
      End;
    End;
end;

function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Emite: Boolean;
begin
  Result := True;
  MM_Acompanhamento.Lines.Add('Atualizando retorno da Nota Fiscal...');
  case NFS_e.Configuracoes.Geral.Provedor of
    proIPM:Fc_Atualiza_NFSE_by_Emite_proIPM;
  else
    Fc_Atualiza_NFSE_by_Emite_General
  end;
end;

function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Emite_General: Boolean;
begin
  with NFS_e,RetNFse do
  Begin
    with NotasFiscais.Items[0] do
    Begin

      //Verifica se a nota foi autorizada
      if ( ( NFSe.Situacao  = 4 ) or
           ( StrToIntDef(NFSe.Numero,0) > 0)) and
         ( Trim(NFSe.CodigoVerificacao)  <> '')  then
      Begin
        Registro.ReciboProvisorios  := RetNFse.Rps.registro.numero;
        Registro.Lote               := StrToIntDef(NFSe.NumeroLote,1);
        Registro.CodigoVerificacao  := NFSe.CodigoVerificacao;
        Registro.Tipo               := '1';
        Registro.CodigoNAtureza     := 1;
        Registro.Data               := NFSe.DataEmissao;
        Registro.Sincrono           := 'S';
        Registro.Numero             := NFSe.Numero;
        if Trim(NFSe.Numero) <> '' then
          Registro.CodigoSituacao     := 4
        else
          Registro.CodigoSituacao     := 3;
        Registro.Arquivo            := FFullPathNFSe.FileNameXML;
        Registro.Motivo             := WebService.Emite.DescSituacao;
        salva;
        Result := True;
      End;
    End;
  end;
end;

function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Emite_proIPM: Boolean;
begin
  Result := False;
  begin
    with NFS_e,RetNFse do
    Begin
      //WebService.ConsultaNFSe.Sucesso
      Registro.ReciboProvisorios  := StrtoIntDef(WebService.Emite.NumeroRps,RetNFse.Rps.registro.Numero);
      Registro.Lote               := StrtoIntDef(WebService.Emite.NumeroLote,RetNFse.Lote.registro.Numero);
      Registro.CodigoVerificacao  := WebService.Emite.idNota;
      Registro.Tipo               := '1';
      Registro.CodigoNAtureza     := 1;
      Registro.Data               := WebService.Emite.Data;
      Registro.Sincrono           := 'S';
      Registro.Numero             := WebService.Emite.NumeroNota;
      Registro.Protocolo          := WebService.Emite.Protocolo;
      if trim(WebService.Emite.NumeroNota) <>'' then
        Registro.CodigoSituacao     := 4;
      if WebService.ConsultaNFSe.Situacao = '2' then
        Registro.CodigoSituacao     := 5;
      Registro.Arquivo            := WebService.Emite.Link;
      Registro.Motivo             := WebService.Emite.DescSituacao;
      salva;
      Result := True;
    end;
  end;
end;




function TFr_geranfe_Srv.Fc_Atualiza_NFSE_by_Status(msg:String): Boolean;
begin
  Result := False;
  begin
    with NFS_e,RetNFse do
    Begin
      if (Pos('Lote já processado',msg) > 0) then
      Begin
        Registro.CodigoSituacao     := 3;
        Result := True;
        salva;
      End;
    end;
  end;

end;

function TFr_geranfe_Srv.Fc_ValidaConsultar():Boolean;
Begin
  Result := True;
  case NFS_e.Configuracoes.Geral.Provedor of
  proIPM:
    begin
      if not chbx_forcar_consulta.Checked then
      Begin
        if not VerificaRPSGerada then
        Begin
          Result := False;
          Exit;
        end;
      End;

      if not ValidarIPMSistemas then
      Begin
        Result := False;
        exit;
      End;

    End;
  end;
end;



//Cancelar
function TFr_geranfe_Srv.Fc_ValidaCancelar():Boolean;
Var
  Lc_tentativas : Integer;
Label
   lbValida;
Begin
  Result := True;
  Lc_tentativas := 0;
  if not VerificaNotaProcessada then
  Begin
    result := False;
    exit;
  End;

  if VerificaNotaCancelada then
  Begin
    result := False;
    exit;
  End;
lbValida:
  if VerificaNotaProduto then
  Begin
    if Lc_tentativas <=3 then
    Begin
      inc(Lc_tentativas);
      ChamarGeraNFE_VDA;
      goto lbValida
    End
    else
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     '3 tentativas e o cancelamento não foi efetuado.'+EOLN+
                     'Operação não pode avançar .'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      result := False;
      exit;
    End;
  End;




end;

procedure TFr_geranfe_Srv.AtualizaSSLLibsCombo;
begin
  with NFS_e.Configuracoes do
  begin
    cbSSLLib.ItemIndex := Integer(Geral.SSLLib);
    cbCryptLib.ItemIndex := Integer(Geral.SSLCryptLib);
    cbHttpLib.ItemIndex := Integer(Geral.SSLHttpLib);
    cbXmlSignLib.ItemIndex := Integer(Geral.SSLXmlSignLib);
    cbSSLType.Enabled := (Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]);
  end;
end;

procedure TFr_geranfe_Srv.Pc_Cancelar;
Var
  Lc_cd_Cancela : String;
  Lc_Nr_Nota : String;
  InfCancelamento: TInfCancelamento;
begin
  with MM_Acompanhamento,RetNFSe do
  Begin
    SplitPathFile(Registro.Arquivo,'NFSE');

    //Salva o Arquivo XML da NOta no diretorio
    If not VerificaExistenciaArquivoXML then
    Begin
      exit;
    end;
    if not FileExists(concat(FFullPathNFse.Path,'\',FFullPathNFse.FileNameXML)) then
    Begin
      Lines.Add('Salvando o arquivo em disco..');
      Pc_Salva_Arq_Disco(6,
                         'XML',
                         Registro.CodigoNotaFiscal,
                         concat(FFullPathNFse.Path,'\',FFullPathNFse.FileNameXML));

    end;
    with NFS_e do
    Begin
      Lines.Add('Carregando o arquivo para o cancelamento');
      NotasFiscais.Clear;
      NotasFiscais.LoadFromFile(concat(FFullPathNFse.Path, '\', FFullPathNFse.FileNameXML));
      Lines.Add('Solicitando autorização para o cancelamento');
      InfCancelamento := TInfCancelamento.Create;
      try
        with InfCancelamento do
        begin
          NumeroNFSe      := RetNFse.Registro.Numero;
          SerieNFSe       := '1';
          ChaveNFSe       := '';
          // Codigo de Cancelamento
          // 1 - Erro de emissão
          // 2 - Serviço não concluido
          // 3 - RPS Cancelado na Emissão
          Lc_cd_Cancela := IntToStr(Rg_Cancelamento.itemIndex + 1);
          CodCancelamento := Lc_cd_Cancela;
          MotCancelamento := 'Erro de emissão';
          NumeroLote      := RetNFse.Registro.Lote.ToString;
          NumeroRps       := RetNFse.Registro.ReciboProvisorios;
          SerieRps        := '1';
          ValorNFSe       := Qr_Nota.FieldByName('NFL_VL_TL_SRV').AsCurrency;
          CodVerificacao  := RetNFse.Registro.CodigoVerificacao;
          email           := Qr_Nota.FieldByName('EMP_EMAIL').AsString;
        end;
        CancelarNFSe(InfCancelamento);
        Lines.Add('Retorno do Cancelamento:');
        Lines.Add('Cód. Cancelamento: ' + WebService.CancelaNFSe.RetCancelamento.Situacao);
        if WebService.CancelaNFSe.RetCancelamento.DataHora <> 0 then
        Lines.Add('Data / Hora      : ' + DateTimeToStr(WebService.CancelaNFSe.RetCancelamento.DataHora));
        //Faz a consulta
        NFS_e.ConsultarNFSeporRps(
                              RetNFse.Rps.Registro.Numero.ToString,
                              NFS_e.NotasFiscais[0].NFSe.IdentificacaoRps.Serie,
                              FProvider.TipoRPSToStr(NFS_e.NotasFiscais[0].NFSe.IdentificacaoRps.Tipo),
                              '');
        if not mostraErrosConsulta then
        Begin
          if Fc_Atualiza_NFSE_by_Consulta then;
          Begin
            Pc_Insere_Arq_Banco(FFullPathNFSe.Path,
                      FFullPathNFse.FileNameXML,
                      6,
                      'XML',
                      RetNFse.Registro.CodigoNotaFiscal);

          End;

        End;

      finally
        InfCancelamento.Free;
      end;
    end;
  end;
end;


function TFr_geranfe_Srv.Fc_ValidaSituacao:Boolean;
Begin
  Result := True;
  with RetNFse.Registro do
  Begin



  End;
end;

function TFr_geranfe_Srv.VerificaCarregamentoNota: Boolean;
begin
  Result := true;
  if (Qr_Nota.RecordCount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Não foi possivel carregar a Nota.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;

function TFr_geranfe_Srv.VerificaExistenciaArquivoXML: boolean;
begin
  Result := True;
  with MM_Acompanhamento,RetNFSe.Registro do
  Begin
    If not Fc_VerificaExistenciaArquivoXML(6,CodigoNotaFiscal,FFullPathNFse.Path,FFullPathNFse.FileNameXML) then
    Begin
      Lines.Add('Arquivo XML não encontrado...');
      Lines.Add('Gerando Arquivo XML novamente...');
      Lines.Add('Execute uma consulta para baixar novamente o XML da Nota...');
      Result := False;
      exit;
    end;
  end;
end;

function TFr_geranfe_Srv.VerificaNotaProcessada: Boolean;
begin
  Result := true;
  if (RetNFse.Registro.CodigoSituacao <> 4) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Está nota ainda não foi processada.'+EOLN+
                   'Clique no botão Enviar ou consultar antes.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  End;
end;

function TFr_geranfe_Srv.VerificaNotaCancelada: Boolean;
begin
  Result := False;
  if RetNFse.Registro.CodigoSituacao = 5 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Nota já cancelada.'+EOLN+
                   'Apenas opção de consultar disponivel.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := True;
    Exit;
  End;

end;

function TFr_geranfe_Srv.VerificaNotaProduto: boolean;
begin
  Result := False;
  RetNfe.REtorno55.Registro.NotaFiscal := RetNFse.Registro.CodigoNotaFiscal;
  RetNfe.REtorno55.getByNotaFiscal;
  IF (RetNfe.REtorno55.Registro.Situacao = 2) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Existe uma nota de Produtos Vinculada.'+EOLN+
                   'Precisa cancelar a nota antes de Continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := True;
    Exit;
  End;

end;

function TFr_geranfe_Srv.VerificaRPSGerada: boolean;
begin
  Result := True;
  if (RetNFse.Registro.CodigoSituacao = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'R.P.S não gerada.'+EOLN+
                   'Gere o R.P.S ou envie direto para autorização.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TFr_geranfe_Srv.VerificaRpsGeradaNaoEnviada: Boolean;
begin
  Result := True;
  if (RetNFse.Registro.CodigoSituacao = 1) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'R.P.S gerada mas não foi enviada.'+EOLN+
                   'Envie o R.P.S para autorização.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TFr_geranfe_Srv.VerificaRpsProcessada: Boolean;
begin
  Result := True;
  if (RetNFse.Registro.CodigoSituacao = 2) then
  Begin
    MensagemPadrao('Mensagem o',ATENCAO+EOLN+EOLN+
                   'R.P.S não processado ainda.'+EOLN+
                   'Execute a operação de consulta antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TFr_geranfe_Srv.VerificaRpsProcessadaComErro: boolean;
begin
  Result := False;
  if (RetNFse.Registro.CodigoSituacao = 3) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Este RPS já foi processado com erros.'+EOLN+
                   'Verifique se o erro foi corrigido.'+EOLN+
                   'Resolva os problemas da Nota antes de enviar novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    //Vai alertar mas não vai travar o processo
  end;
end;

//Imprimir
function TFr_geranfe_Srv.Fc_ValidaImprimir():Boolean;
Begin
  Result := True;
  if not VerificaNotaProcessada then
  Begin
    Result := False;
    Exit;
  end;
end;

procedure TFr_geranfe_Srv.Pc_ImprimirIPMSistemas;
Var
  LcForm : TRL_NFSe_IPMSistemas;
  Lc_link : PWideChar;
  Lc_LinkString : String;
  Lc_pos : Integer;
begin
  Lc_link := PWideChar(RetNFse.Registro.Arquivo);
  Lc_LinkString := RetNFse.Registro.Arquivo;
  Lc_pos := Pos('http',Lc_LinkString);
  if Lc_pos = 0 then
  Begin
    MensagemPadrao('Mensagem o',ATENCAO+EOLN+EOLN+
                   'Não foi possível achar o link para impressão.'+EOLN+
                   'Efetue uma consulta para atualizar o retorno.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Exit;
  End;
  Lc_LinkString := Copy(Lc_LinkString,Lc_pos,Length(Lc_LinkString));
  Lc_link := PWideChar(Lc_LinkString);
  ShellExecute(Handle,
               'open',
               Lc_link ,
               nil,
               nil,
               SW_SHOWMAXIMIZED);
    {
  Try
    LcForm := TRL_NFSe_IPMSistemas.create(nil);
    LcForm.PAthFileNFse := RetNFse.Registro.Arquivo;
    LcForm.ShowModal;
  Finally
    FreeandNil(LcForm);
  End;
    }
end;

procedure TFr_geranfe_Srv.Pc_ImprimirPadraoNacional;
begin
  with MM_Acompanhamento do
  Begin
    //Salva o Arquivo XML da NOta no diretorio
    SplitPathFile(RetNFSe.Registro.Arquivo,'NFSE');
    If not VerificaExistenciaArquivoXML then
    Begin
      exit;
    end;
    if not FileExists(concat(FFullPathNFse.Path,'\',FFullPathNFse.FileNameXML)) then
    Begin
      Pc_Salva_Arq_Disco(6,
                        'XML',
                        RetNFSe.Registro.CodigoNotaFiscal,
                        concat(FFullPathNFse.Path,'\',FFullPathNFse.FileNameXMl));
    end;
  End;

  NFS_e.NotasFiscais.Clear;
  NFS_e.NotasFiscais.LoadFromFile(concat(FFullPathNFse.Path,'\',FFullPathNFse.FileNameXMl), False);
  NFS_e.Configuracoes.Arquivos.NomeLongoNFSe := True;

  NFS_e.DANFSe.MostraPreview := True;
  NFS_e.NotasFiscais.Imprimir;

end;

//Enviar E-mail
function TFr_geranfe_Srv.ValidaEnviarMensagem():Boolean;
Begin
  Result := True;
  if not VerificaNotaProcessada then
  Begin
    Result := False;
    Exit;
  end;
end;

function TFr_geranfe_Srv.ValidaEnviaWhatsApp: Boolean;
begin
  Result := True;
  if (FConsumidorFinal = Qr_Nota.FieldByName('EMP_CODIGO').asInteger) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Não é possivel enviar para o cliente Consumidor.' +EOLN +
                   ' Para enviar é necessário ter o telefone no cadastro'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;

  if (Length(Qr_Nota.FieldByName('END_CELULAR').AsString) = 0) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' O Campo celular do cadastro não foi informado.' +EOLN +
                   ' Verifique para continuar'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;

  if (Length(Qr_Nota.FieldByName('END_CELULAR').AsString) <8) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' O Campo celular do cadastro parece estar incompleto.' +EOLN +
                   ' Verifique para continuar'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End


end;

procedure TFr_geranfe_Srv.EnviarEmail;
Var
  Lc_Link : String;
  Lc_Corpo : String;
begin
  with MM_Acompanhamento,RetNFse.Registro do
  Begin
    Lc_Link := NFS_e.LinkNFSe( Numero,CodigoVerificacao,'');
    //Define o nome do arquivo em PDF
    Lc_Corpo := concat(
                '<html>',
                '<head>',
                '  <meta content="text/html; charset=ISO-8859-1"',
                ' http-equiv="content-type">',
                '</head>',
                '<body>',
                'Ol&aacute;,<br>',
                '<br>',
                'Segue em Anexo, documento referente a NFS-e do n&uacute;mero: '  + Numero,
                '<br>',
                'Também pode ser conferido pelo link abaixo.',
                '<br>',
                Lc_Link,
                '<br>',
                '</body>',
                '</html>'
                );
    Pc_EnviaEmailNFSe(Qr_Nota.FieldByName('EMP_CODIGO').AsString,
                      Numero,
                      Lc_Link,
                      FFullPathNFse.Path,
                      FFullPathNFse.FileNameXML,
                      FFullPathNFse.FileNamePDF,
                      Lc_Corpo);
  End;

end;

procedure TFr_geranfe_Srv.EnviarMensagem;
Begin
  FLinkNFSe := '';
  case NFS_e.Configuracoes.Geral.Provedor of
    proIPM: begin
      if Nfs_e.Configuracoes.Geral.Layout = loABRASF then
        PrepararArquivoParaEnvio
      else
        PreparaLinkParaEnvio;
    end;
    proISSNet:PrepararArquivoParaEnvio;
  else
    PrepararArquivoParaEnvio;
  end;

  Fc_EnviaEmailNfe(Qr_Nota.FieldByName('EMP_CODIGO').AsString,
              Qr_Nota.FieldByName('NFL_CODTRP').AsString,
              Qr_Nota.FieldByName('NFS_NUMERO').AsString,
              FFullPathNFSe.Path,
              FFullPathNFSe.FileNameXML,
              FFullPathNFSe.FileNamePDF,
              FLinkNFSe);
end;

procedure TFr_geranfe_Srv.EnviaWhatsApp;
Var
  LcW : TWhatsApp;
begin
  Try
    LcW := TWhatsApp.create(nil);
    LcW.Mensagem := concat('Ola, Sua nota de servico foi emitida, Segue o PDF em anexo');
    LcW.ReceiverNumber := Qr_Nota.FieldByName('END_CELULAR').AsString;
    //Agora Envia o Anexo PDF
    LcW.Arquivo := concat(FFullPathNFSe.Path,'\',FFullPathNFSe.FileNamePDF);
    LcW.RegisterMessage;
    //Agora Envia o Anexo XML
    LcW.Mensagem := concat('Segue também XML da NFS-e');
    LcW.Arquivo := concat(FFullPathNFSe.Path,'\',FFullPathNFSe.FileNameXML);
    LcW.RegisterMessage;
    LcW.Send;
  finally
    FreeAndNil(LcW);
  end;
end;

//Gravação
//Enviar E-mail
function TFr_geranfe_Srv.Fc_ValidaGravacao():Boolean;
Begin
  Result := True;

end;

procedure TFr_geranfe_Srv.Pc_Gravar;
Var
  Lc_Copia_nfe : String;
  Lc_Visualiza_Msg: String;
Begin
  if chbx_copia_nfe.Checked then Lc_Copia_nfe := 'S' else Lc_Copia_nfe := 'N';
  if chbx_Visualizar.Checked then Lc_Visualiza_Msg := 'S' else Lc_Visualiza_Msg := 'N';

  with RetNFse.Config.Registro do
  Begin
    CodigoEstabelecimento           := Gb_CodMha;
    Ambiente                        := IntToStr(Rg_Ambiente.ItemIndex);
    Certificado                     := E_Serie_Certificado.Text;
    CaminhoCertificado              := '';
    SenhaCertificado                := E_Senha_Certificado.text;
    UsuarioWeb                      := E_User_Web.Text;
    SenhaWeb                        := E_Pws_WEb.Text;
    CaminhoNFSE                     := E_Path_NFSe.Text;
    FraseWeb                        := E_Frase_WEb.Text;
    CaminhoRPS                      := E_Path_RPS.Text;
    Prefeitura                      := E_NomePrefeitura.Text;
    LogoPrefeitura                  := E_LogoPrefeitura.Text;
    ArquivoIniProvedor              := E_Arq_Ini_Provedor.Text;
    SchemasProvedor                 := E_Path_Schemas.Text;
    CopiaEmail                      := Lc_Copia_nfe;
    VisualizaMensagem               := Lc_Visualiza_Msg;
    CodigoSrvLLC                    := E_Nfse_Cd_LC116.Text;
    CodigoRegimeEspecialTributacao  := Cb_CRET.ItemIndex;
    CodigoTributarioMunicipal       := E_CodigoTribMunicipio.Text;
    CNAE                            := E_CodigoCnae.Text;
    CodigoNBS                       := E_CodigoNBS.Text;
    Provedor                        := Cb_Provedor.Text;
    LayoutNFse                      := IntToStr(cbLayoutNFSe.ItemIndex);
    FormatoDiscr                    := IntToStr(cbFormatoDiscr.ItemIndex);
    Versao                          := Cb_versao_utilizado.Text;
  End;
  RetNFse.Config.Salva;

  if Rg_TipoCertificado.ItemIndex = 1 then
    Fc_Aq_Geral('G', 'NFS', 'NFS_TIPO_CERT', '1')  //mODELO A3
  else
    Fc_Aq_Geral('G', 'NFS', 'NFS_TIPO_CERT', '0'); //MODELO A1
  Fc_Tb_Geral('G','NFS_SENHA_CERT',E_Senha_Certificado.Text);
  Fc_Aq_Geral('G', 'NFS', 'NFS_TIPO_SSL', IntToStr(cbSSLType.ItemIndex));

  if Rg_SSLTLS.ItemIndex = 1 then
    Fc_Aq_Geral('G', 'NFS', 'NFS_SSLTLS', '1')  //Usar SSL 3.0 / Usar TSL 1.0
  else
    Fc_Aq_Geral('G', 'NFS', 'NFS_SSLTLS', '0'); //Usar SSL 2.0 / Usar TSL 1.0

  Fc_Aq_Geral('G', 'NFS', 'NFS_TIPO_SSL', IntToStr(cbSSLType.ItemIndex));

  Fc_Aq_Geral('G', 'NFS', 'NFS_SSLLib', IntToStr(cbSSLLib.ItemIndex));
  Fc_Aq_Geral('G', 'NFS', 'NFS_CryptLib', IntToStr(cbCryptLib.ItemIndex));
  Fc_Aq_Geral('G', 'NFS', 'NFS_HttpLib', IntToStr(cbHttpLib.ItemIndex));
  Fc_Aq_Geral('G', 'NFS', 'NFS_XmlSignLib', IntToStr(cbXmlSignLib.ItemIndex));



end;

procedure TFr_geranfe_Srv.Sb_GerarClick(Sender: TObject);
Var
  Lc_Res : Boolean;
begin
  If Fc_ValidaGeracao then
  Begin
    Fc_Gera_RPS;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O R.P.S foi gerado com sucesso.'+EOLN+EOLN,
                    ['OK'],[bEscape],mpAlerta);

  end;
end;

procedure TFr_geranfe_Srv.Sb_EnviarClick(Sender: TObject);
VAr
  Lc_Res : Boolean;
  Lc_codigo_verificacao : String;
  Lc_I : Integer;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    MM_Acompanhamento.Lines.Clear;
    Self.Enabled := False;
    Pc_AtivaConfiguracaoNFSe;
    Fc_AtivaDadosDaNota;
    If Fc_ValidaEnvio then
    Begin
      Fc_Gera_RPS;
      //Atualizar dados da nota fiscal/Financeiro e Comissao
      Lc_Res := Fc_CarregaComponenente;
      if Lc_Res then
      Begin
        if Pc_Envia_RPS then
        Begin
          if NFS_e.WebService.Emite.Sucesso then
          Begin
            //Salvar o registro - RPS
            RetNFse.RPS.Registro.Protocolo    := NFS_e.WebService.Emite.Protocolo;
            RetNFse.RPS.Registro.Observacao   := NFS_e.WebService.Emite.Situacao;
            RetNFse.RPS.Registro.DataEmissao  := NFS_e.WebService.Emite.Data;
            RetNFse.RPS.salva;
            //Salva o Arquivo - RPS
            SplitPathFile(NFS_e.NotasFiscais[0].NomeArqRps,'RPS');
            Pc_Insere_Arq_Banco(FFullPathRps.Path,
                                FFullPathRps.FileNameXML,
                                5,
                                'XML',
                                RetNFse.Registro.CodigoNotaFiscal);

            with NFS_e,RetNFse do
            Begin
              Registro.ReciboProvisorios  := StrtoIntDef(WebService.Emite.NumeroRps,RetNFse.Rps.registro.Numero);
              Registro.Lote               := StrtoIntDef(WebService.Emite.NumeroLote,RetNFse.Lote.registro.Numero);
              Registro.CodigoVerificacao  := WebService.Emite.idNota;
              Registro.Tipo               := '1';
              Registro.CodigoNAtureza     := 1;
              Registro.Data               := WebService.Emite.Data;
              Registro.Sincrono           := 'S';
              Registro.Numero             := WebService.Emite.NumeroNota;
              Registro.Protocolo          := WebService.Emite.Protocolo;
              if Trim(WebService.Emite.NumeroNota) <> '' then
                Registro.CodigoSituacao     := 4;
              if WebService.ConsultaNFSe.Situacao = '2' then
                Registro.CodigoSituacao     := 5;
              Registro.Arquivo            := WebService.Emite.Link;
              Registro.Motivo             := WebService.Emite.DescSituacao;
              salva;
            End;
          End;
          if not mostraErrosEmite then
          Begin
            //Verifica se a nota está no dirtorio, caso contrario faz uma consulta
            SplitPathFile(NFS_e.NotasFiscais[0].NomeArq,'NFSE');
            if FilesExists(concat(FFullPathNFSe.Path,'\',FFullPathNFse.FileNameXML)) then
            Begin
              if Fc_Atualiza_NFSE_by_Emite then
              Begin
                Pc_Insere_Arq_Banco(FFullPathNFSe.Path,
                                    FFullPathNFse.FileNameXML,
                                    6,
                                    'XML',
                                    RetNFse.Registro.CodigoNotaFiscal);
              End;
            End
            else
            Begin
              MM_Acompanhamento.Lines.Add('A emissão não obteve o retorno automatico da nota!');
              MM_Acompanhamento.Lines.Add('O Sistema vai efetuar uma consulta para receber a situação atualizada!');
              executeConsulta('Autorizar');
              if not mostraErrosConsulta then
              Begin
                if Fc_Atualiza_NFSE_by_Consulta then
                Begin
                  Pc_Insere_Arq_Banco(FFullPathNFSe.Path,
                                      FFullPathNFse.FileNameXML,
                                      6,
                                      'XML',
                                      RetNFse.Registro.CodigoNotaFiscal);

                End;
                MM_Acompanhamento.Lines.Add('Utilize o botão imprimir para visualizar a Nota.');
              End
              else
              Begin
                MM_Acompanhamento.Lines.Add('Ainda não foi possivel coneguir o retorno aguard e tente mais tarde.');
              End;
            End;
          End;
        end;
      End;
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.Activate;
    Self.BringToFront;
  end;
end;

procedure TFr_geranfe_Srv.SB_Cfg_GravarClick(Sender: TObject);
begin
  If Fc_ValidaGravacao then
  Begin
    Pc_Gravar;
    It_Edicao_Config := 'B';
    Pc_EstadoEdicaoConfig;
  end;
end;

procedure TFr_geranfe_Srv.FormCreate(Sender: TObject);
begin
  RetNFse := TControllerRetornoNFS.create(Self);
  RetNfe := TControllerNotaFiscal.create(Self);
end;

procedure TFr_geranfe_Srv.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case pg_Principal.ActivePageIndex of
      0:Pc_TeclaAtalhoNFSE(Key);
      1:Pc_TeclaAtalhoConfig(Key);
    end;
  end;
end;

procedure TFr_geranfe_Srv.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_Inicia_variaveis;
  Pc_FormataTela;
end;

procedure TFr_geranfe_Srv.setValoresNFSE(valores: TValores);
begin

  with Valores,Qr_Itens do
  Begin
    ValorServicos          := Qr_Nota.FieldByName('NFL_VL_TL_SRV').AsCurrency;
    ValorDeducoes          := 0.00;
    ValorPis               := 0.00;
    ValorCofins            := 0.00;
    ValorInss              := 0.00;
    ValorIr                := 0.00;
    ValorCsll              := 0.00;
    OutrasRetencoes        := 0.00;
    //Calcula o desconto
    DescontoIncondicionado := 0;
    First;
    while not eof do
    Begin
      DescontoIncondicionado := DescontoIncondicionado  + FieldByName('ITF_VL_DESC').AsCurrency;
      next;
    End;
    DescontoCondicionado   := 0.00;

    tribMun.cPaisResult := 0;
    // TtribISSQN = (tiOperacaoTributavel, tiImunidade, tiExportacao, tiNaoIncidencia);
    tribMun.tribISSQN := tiOperacaoTributavel;
    tribMun.tpImunidade := timNenhum;
    tribMun.tpRetISSQN := trNaoRetido;
    totTrib.indTotTrib := indNao;

    if NFS_e.NotasFiscais[0].NFSe.OptanteSN = osnOptanteMEEPP then
    begin
      totTrib.indTotTrib := indSim;
      totTrib.pTotTribSN := Qr_Itens.FieldByName('ISS_AQ_NR').AsCurrency;
    end;

    BaseCalculo := ValorServicos -
                   ValorDeducoes -
                   DescontoIncondicionado;


    // No caso do provedor Ginfes devemos informar a aliquota já dividida por 100
    // para outros provedores devemos informar por exemplo 3, mas ao fazer o calculo
    // do valor do ISS devemos dividir por 100
    // Valor do ISS calculado multiplicando-se a base de calculo pela aliquota

    case NFS_e.Configuracoes.Geral.Provedor of
      proIPM:
      begin
        Aliquota  := Qr_Itens.FieldByName('ISS_AQ_NR').AsCurrency;
        ValorISS  := (BaseCalculo * Aliquota) / 100;
        ValorISS  := Fc_ArredondarParaCima(ValorISS,2);
        Aliquota  := RoundTo(Aliquota, -2);
      end;
      proPadraoNacional:
      Begin
        Aliquota  := Qr_Itens.FieldByName('ISS_AQ_NR').AsCurrency;
        //ValorISS  := (BaseCalculo * Aliquota) / 100;
        //ValorISS  := Fc_ArredondarParaCima(ValorISS,2);
        //Aliquota  := RoundTo(Aliquota, -2);

      End;
      proISSNet:
      Begin
        Aliquota  := Qr_Itens.FieldByName('ISS_AQ_NR').AsCurrency;
        ValorISS  := (BaseCalculo * Qr_Itens.FieldByName('ISS_AQ_NR').AsCurrency) / 100;
        ValorISS  := RoundABNT(ValorISS,2);
        Aliquota  := RoundTo(Aliquota, -2);
      End
    else
      Begin
        Aliquota    := ( Qr_Itens.FieldByName('ISS_AQ_NR').AsCurrency / 100 );
        ValorISS := (BaseCalculo * Aliquota);
        ValorISS  := Fc_ArredondarParaCima(ValorISS,2);
      End;
    end;


    //NFS_e.NotasFiscais[0].NFSe.Servico.Valores.ValorIss
    //NFS_e.NotasFiscais[0].NFSe.Servico.Valores.ValorIssRetido

    // TnfseSituacaoTributaria = ( stRetencao, stNormal, stSubstituicao );

    if (Qr_Nota.FieldByName('CLI_ISS_RET').AsString = 'S') then
    Begin
      IssRetido      := stRetencao;
      ValorIssRetido := ValorISS;
      //IP Sistema solicitou que o valor do ISS seja zerado quando informado o retito
      if ( RetNFse.Config.Registro.Provedor = 'ISSNet' ) then
        ValorISS := 0;
    end
    else
    Begin
      IssRetido      := stNormal;
      ValorIssRetido := 0.00;
    End;


    ValorLiquidoNfse := ValorServicos -
                        ValorPis -
                        ValorCofins -
                        ValorInss -
                        ValorIr -
                        ValorCsll -
                        OutrasRetencoes -
                        ValorIssRetido -
                        DescontoIncondicionado -
                        DescontoCondicionado;



  End;

end;

procedure TFr_geranfe_Srv.LoadXML(RetWS: String; MyWebBrowser: TWebBrowser;
  NomeArq: string; aTempo: Integer);
begin
  if RetWS <> '' then
  begin
    ACBrUtil.WriteToTXT(PathWithDelim(ExtractFileDir(application.ExeName)) + NomeArq,
                        AnsiString(RetWS), False, False);

    MyWebBrowser.Navigate(PathWithDelim(ExtractFileDir(application.ExeName)) + NomeArq);

    sleep(aTempo);
  end;
end;

function TFr_geranfe_Srv.mostraErrosConsulta: Boolean;
Var
  Lc_I : Integer;
begin
  Result := False;
  case NFS_e.Configuracoes.Geral.Provedor of
    proIPM:
    begin
      if NFS_e.WebService.ConsultaNFSe.Erros.Count >0 then
      Begin
        Result := True;
        for Lc_I := 0 to NFS_e.WebService.ConsultaNFSe.Erros.Count -1 do
        Begin
          MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Codigo,' - ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Descricao ));
          MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Descricao ));
        End;
      End;
    end;
  else
    Begin
      //ConsultaNFSeporRps - Erro
      if NFS_e.WebService.ConsultaNFSeporRps.Erros.Count >0 then
      Begin
        Result := True;
        for Lc_I := 0 to NFS_e.WebService.ConsultaNFSeporRps.Erros.Count -1 do
        Begin
          MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.ConsultaNFSeporRps.Erros[Lc_I].Codigo,' - ',NFS_e.WebService.ConsultaNFSeporRps.Erros[Lc_I].Descricao ));
          MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.ConsultaNFSeporRps.Erros[Lc_I].Descricao ));
        End;
      End;
      //ConsultaNFSeporRps - Alerta
      if NFS_e.WebService.ConsultaNFSeporRps.Alertas.Count >0 then
      Begin
        Result := True;
        for Lc_I := 0 to NFS_e.WebService.ConsultaNFSeporRps.Alertas.Count -1 do
        Begin
          MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.ConsultaNFSeporRps.Alertas[Lc_I].Codigo,' - ',NFS_e.WebService.ConsultaNFSeporRps.Alertas[Lc_I].Descricao ));
          MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.ConsultaNFSeporRps.Alertas[Lc_I].Descricao ));
        End;
      End;
      //ConsultaNFSe - Erro
      if NFS_e.WebService.ConsultaNFSe.Erros.Count >0 then
      Begin
        Result := True;
        for Lc_I := 0 to NFS_e.WebService.ConsultaNFSe.Erros.Count -1 do
        Begin
          MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Codigo,' - ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Descricao ));
          MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Descricao ));
        End;
      End;
      //ConsultaNFSe - Alertas
      if NFS_e.WebService.ConsultaNFSe.Alertas.Count >0 then
      Begin
        Result := True;
        for Lc_I := 0 to NFS_e.WebService.ConsultaNFSe.Alertas.Count -1 do
        Begin
          MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.ConsultaNFSe.Alertas[Lc_I].Codigo,' - ',NFS_e.WebService.ConsultaNFSe.Alertas[Lc_I].Descricao ));
          MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.ConsultaNFSe.Alertas[Lc_I].Descricao ));
        End;
      End;

    End;
  end;
end;

function TFr_geranfe_Srv.mostraErrosEmite: Boolean;
Var
  Lc_I : Integer;
begin
  Result := False;
  if NFS_e.WebService.Emite.Erros.Count >0 then
  Begin
    Result := True;
    for Lc_I := 0 to NFS_e.WebService.Emite.Erros.Count -1 do
    Begin
      MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.Emite.Erros[Lc_I].Codigo,' - ',NFS_e.WebService.Emite.Erros[Lc_I].Descricao ));
      MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.Emite.Erros[Lc_I].Descricao ));
      if Fc_Atualiza_NFSE_by_Status(NFS_e.WebService.Emite.Erros[Lc_I].Descricao) then
      Begin
        break;
      End;
    End;
  End;
  if NFS_e.WebService.Emite.Alertas.Count >0 then
  Begin
    Result := True;
    for Lc_I := 0 to NFS_e.WebService.Emite.Alertas.Count -1 do
    Begin
      MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.Emite.Alertas[Lc_I].Codigo,' - ',NFS_e.WebService.Emite.Alertas[Lc_I].Descricao ));
      MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.Emite.Alertas[Lc_I].Descricao ));
    End;
  End;

  //ConsultaNFSe - Erro
  if NFS_e.WebService.ConsultaNFSe.Erros.Count >0 then
  Begin
    Result := True;
    for Lc_I := 0 to NFS_e.WebService.ConsultaNFSe.Erros.Count -1 do
    Begin
      MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Codigo,' - ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Descricao ));
      MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.ConsultaNFSe.Erros[Lc_I].Descricao ));
    End;
  End;
  //ConsultaNFSe - Alertas
  if NFS_e.WebService.ConsultaNFSe.Alertas.Count >0 then
  Begin
    Result := True;
    for Lc_I := 0 to NFS_e.WebService.ConsultaNFSe.Alertas.Count -1 do
    Begin
      MM_Acompanhamento.Lines.Add(concat('Erro: ',NFS_e.WebService.ConsultaNFSe.Alertas[Lc_I].Codigo,' - ',NFS_e.WebService.ConsultaNFSe.Alertas[Lc_I].Descricao ));
      MM_Acompanhamento.Lines.Add(concat('Correção: ',NFS_e.WebService.ConsultaNFSe.Alertas[Lc_I].Descricao ));
    End;
  End;

end;

procedure TFr_geranfe_Srv.MostraValidade(pValidade, pCert_Validade,
  pCert_Expira: TPanel);
Var
  Lc_Date: TDate;
  Lc_Str_Date: String;
  Lc_Days_For: Integer;
  procedure errocertificado;
  BEgin
    // VAlidade
    pCert_Validade.Color := clBtnFace;
    pCert_Validade.Font.Color := clred;
    pCert_Validade.Caption := 'Não instalado/associado ao sistema';
    // Expira
    pCert_Expira.Color := clBtnFace;
    pCert_Expira.Font.Color := clGreen;
    pCert_Expira.Caption := 'Verifique!!!';
  End;

Begin
  Try
    Lc_Date := NFS_e.SSL.CertDataVenc;
    Lc_Str_Date := DateToStr(Lc_Date);
    Lc_Days_For := Round(Lc_Date - Date);
    if (Lc_Days_For <= 30) then
    Begin
      pCert_Validade.Color := clred;
      pCert_Validade.Font.Color := clBlack;
      pCert_Expira.Font.Color := clred;
    End
    else
    BEgin
      pCert_Validade.Color := clBtnFace;
      pCert_Validade.Font.Color := clBlack;
      pCert_Expira.Font.Color := clGreen;
    End;
    pCert_Validade.Caption := ' Validade do Certificado: ' + Lc_Str_Date;
    pCert_Expira.Caption := 'O Certificado expira em ' +
      IntToStr(Lc_Days_For) + ' dia(s)';
  Except
    errocertificado;
  End;
end;

procedure TFr_geranfe_Srv.OpenItens(nfl_codigo:Integer);
begin
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('NFL_CODIGO').AsInteger := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
  Qr_Itens.Active := True;
  Qr_Itens.FetchAll;
  Qr_Itens.first;
end;

procedure TFr_geranfe_Srv.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_geranfe_Srv.sbtnGetCertClick(Sender: TObject);
begin
  Lb_Explica_Certificado.Caption := DefineTipoCertificadoConfig(Rg_TipoCertificado.ItemIndex);
  NFS_e.Configuracoes.WebServices.SSLType :=  TSSLType( cbSSLType.ItemIndex );
  E_Serie_Certificado.Text := RetNFse.Config.CarregaCertificado(
                                          NFS_e,
                                          dm.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                                          E_Senha_Certificado.Text);
  MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);
end;

procedure TFr_geranfe_Srv.Sb_Path_NFSeClick(Sender: TObject);
begin
  Pc_PathClick(E_Path_NFSe);
end;

procedure TFr_geranfe_Srv.Sb_Path_RPSClick(Sender: TObject);
begin
  Pc_PathClick(e_Path_RPS);
end;

procedure TFr_geranfe_Srv.Sb_Path_SchemasClick(Sender: TObject);
begin
  Pc_PathClick(e_Path_Schemas);
end;

procedure TFr_geranfe_Srv.Sb_Arq_Ini_ProvedorClick(Sender: TObject);
begin
  Pc_PathClick(e_Arq_Ini_Provedor);
end;

procedure TFr_geranfe_Srv.Sb_LogoPrefeituraClick(Sender: TObject);
begin
 Pc_PathClick(E_LogoPrefeitura);
end;

procedure TFr_geranfe_Srv.SB_Cfg_AlterarClick(Sender: TObject);
begin
  It_Edicao_Config := 'E';
  Pc_EstadoEdicaoConfig;
end;

procedure TFr_geranfe_Srv.Sb_Cfg_CancelarClick(Sender: TObject);
begin
  It_Edicao_Config := 'B';
  Pc_EstadoEdicaoConfig;
end;

procedure TFr_geranfe_Srv.Sb_Cfg_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_geranfe_Srv.Sb_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_AtivaConfiguracaoNFSe;
    Fc_AtivaDadosDaNota;
    if Fc_ValidaImprimir then
    Begin
      case NFS_e.Configuracoes.Geral.Provedor of
        proIPM: begin
          if Nfs_e.Configuracoes.Geral.Layout = loABRASF then
            Pc_ImprimirPadraoNacional
          else
            Pc_ImprimirIPMSistemas;
        end;
        proISSNet:Pc_ImprimirPadraoNacional;
      else
        Pc_ImprimirPadraoNacional;
      end;
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.Activate;
    Self.BringToFront;
  end;
end;

procedure TFr_geranfe_Srv.Sb_sair_0Click(Sender: TObject);
begin
  Close;
end;


procedure TFr_geranfe_Srv.SpeedButton1Click(Sender: TObject);
begin
  pg_Principal.ActivePage := tbs_NFS_e;
end;

procedure TFr_geranfe_Srv.SpeedButton4Click(Sender: TObject);
begin
  pg_Principal.ActivePage := tbs_NFS_e;
end;

function TFr_geranfe_Srv.validaConsultaLote: Boolean;
Var
  Lc_Numero : String;
begin
  Result := True;
  //Lote
  if (RetNFse.Lote.Registro.Numero = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Número do lote é inválido.'+EOLN+
                   'Consulte na prefeitura e informe na próxima tela.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Lc_Numero := '';
    if not(InputQuery('Informe o Número do Lote', 'Número do Lote:', Lc_Numero)) then
    Begin
      Result := False;
      exit;
    End;
    RetNFse.Lote.Registro.Numero := StrTOIntDef(Lc_Numero,0);
    if RetNFse.Lote.Registro.Numero > 0 then
    Begin
      RetNFse.Lote.Salva;
    end
    else
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'O Número do lote é inválido.'+EOLN+
                     'Repita a operação.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
      result := False;
      Exit;
    end;
  End;
end;

function TFr_geranfe_Srv.validaConsultaProtocolo: Boolean;
Var
  Lc_Numero: String;
Begin
  Result := True;
  if (Trim(RetNFse.rps.Registro.protocolo)= '') or (Trim(RetNFse.rps.Registro.protocolo)= '0') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Protocolo desta nota é inválido.'+EOLN+
                   'Consulte na prefeitura e informe na próxima tela.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Lc_Numero := '';
    if not(InputQuery('Informe o Número do Protocolo', 'Número da Protocolo:', Lc_Numero)) then
    Begin
      Result := False;
      exit;
    End;
    RetNFse.Rps.Registro.Protocolo := Lc_Numero;
    if Length(RetNFse.Rps.Registro.Protocolo) > 5 then
    Begin
      RetNFse.Rps.salva;
    end
    else
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'O Número do protocolo é invalido.'+EOLN+
                     'Repita a operação.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
      result := False;
      Exit;
    end;
  end;
end;

function TFr_geranfe_Srv.ValidarIPMSistemas: Boolean;
Var
  Lc_Numero : String;
begin
  Result := True;
  if not validaConsultaLote then
  Begin
    Result := False;
    exit;
  End;

end;

procedure TFr_geranfe_Srv.Sb_Envia_MensagemClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_AtivaConfiguracaoNFSe;
    Fc_AtivaDadosDaNota;
    if ValidaEnviarMensagem then
      EnviarMensagem;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.Activate;
    Self.BringToFront;
  end;
end;

procedure TFr_geranfe_Srv.AtualizarAtravsdoXML1Click(Sender: TObject);
BEgin
  Fc_Atualiza_NFSE_by_Arquivo;
end;

procedure TFr_geranfe_Srv.Btn_CancelarClick(Sender: TObject);
begin
  Pnl_Botao.Enabled := True;
  Pnl_Cancelamento.Visible := False;
end;

procedure TFr_geranfe_Srv.Btn_ConfirmarClick(Sender: TObject);
begin
  try
    Pnl_Cancelamento.Visible := False;
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_AtivaConfiguracaoNFSe;
    Fc_AtivaDadosDaNota;

    if Fc_ValidaCancelar then Pc_Cancelar;
  finally
    E_Motivo_Cancelamento.clear;
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.Activate;
    Self.BringToFront;
    Pnl_Botao.Enabled := True;
  end;
end;

procedure TFr_geranfe_Srv.Btn_Xml_NotaClick(Sender: TObject);
begin
  pg_Principal.ActivePage := tbs_xml_nota
end;

procedure TFr_geranfe_Srv.Btn_Xml_retornoClick(Sender: TObject);
begin
  pg_Principal.ActivePage := tbs_xml_retorno
end;

procedure TFr_geranfe_Srv.CarregaDadosReformaTributaria;
begin
  with NFS_e.NotasFiscais[0].NFSe do
  Begin
    IBSCBS.finNFSe := fnfsRegular;
    IBSCBS.indFinal := ifSim;
    IBSCBS.cIndOp := '123456';
    // togNenhum, togFornecimento, togRecebimentoPag
    IBSCBS.tpOper := TtpOperGovNFSe(0);

    // Grupo de NFS-e referenciadas.
    {
    with IBSCBS.gRefNFSe.New do
    begin
      // Chave da NFS-e referenciada
      refNFSe := '12345678901234567890123456789012345678901234567890';
    end;
    }

    // tcgNenhum, tcgUniao, tcgEstados, tcgDistritoFederal, tcgMunicipios
    IBSCBS.tpEnteGov := tcgNenhum;
    // idTomadorAdquirenteDestinatarioIguais, idTomadorAdquirenteIguais,
    with Qr_Nota do
    Begin
      IBSCBS.indDest := idTomadorAdquirenteDestinatarioIguais;
      IBSCBS.dest.CNPJCPF           := FieldByName('EMP_CNPJ').asString;
      IBSCBS.dest.Nif               := '';
      IBSCBS.dest.cNaoNIF           := tnnNaoInformado;
      IBSCBS.dest.xNome             := TiraAcentos( FieldByName('EMP_NOME').asString);
      IBSCBS.dest.fone              := FieldByName('END_FONE').asString;
      IBSCBS.dest.email             := FieldByName('EMP_EMAIL').asString;
      IBSCBS.dest.ender.endNac.cMun := FieldByName('CDD_IBGE').asInteger;
      IBSCBS.dest.ender.endNac.CEP  := FieldByName('END_CEP').asString;
      IBSCBS.dest.ender.xLgr        := TiraAcentos(FieldByName('END_ENDER').asString);
      IBSCBS.dest.ender.nro         := FieldByName('END_NUMERO').asString;
      IBSCBS.dest.ender.xCpl        := FieldByName('END_COMPLEM').asString;
      IBSCBS.dest.ender.xBairro     := FieldByName('END_BAIRRO').asString;
    End;
    {
    IBSCBS.imovel.inscImobFisc := '12345678901';
    IBSCBS.imovel.cCIB := '12345678';
    IBSCBS.imovel.ender.cep := '14800000';
    IBSCBS.imovel.ender.endExt.cEndPost := 'cod. postal';
    IBSCBS.imovel.ender.endExt.xCidade := 'cidade do exterior';
    IBSCBS.imovel.ender.endExt.xEstProvReg := 'estado no exterior';
    IBSCBS.imovel.ender.xLgr := 'RUA PRINCIPAL';
    IBSCBS.imovel.ender.nro := '100';
    IBSCBS.imovel.ender.xCpl := '';
    IBSCBS.imovel.ender.xBairro := 'CENTRO';
    }
    with IBSCBS.valores.gReeRepRes.documentos.New do
    begin
      {
        Grupo de informações de documentos fiscais eletrônicos que se
        encontram no repositório nacional.
      }
      // tcNFSe, tcNFe, tcCTe, tcOutro
      dFeNacional.tipoChaveDFe := tcOutro;
      // Informar a descrição se o tipo for tcOutro
      dFeNacional.xtipoChaveDFe := 'outro tipo de documento';
      dFeNacional.ChaveDFe := ''; //'1234567890';

      {
        Grupo de informações de documento fiscais, eletrônicos ou não,
        que não se encontram no repositório nacional.
      }
      docFiscalOutro.cMunDocFiscal := 0;
      docFiscalOutro.nDocFiscal := '12345';
      docFiscalOutro.xDocFiscal := 'Carta Remessa de Mercadoria';

      {
        Grupo de informações de documento não fiscal.
      }
      docOutro.nDoc := '12345';
      docOutro.xDoc := 'Descricao do documento';

      // Os grupos: dFeNacional, docFiscalOutro e docOutro são mutuamente
      // excludentes, portanto somente um deles pode estar presente no XML

      {
        Grupo de informações do fornecedor do documento referenciado
      }
      {
      fornec.CNPJCPF := '12345678000123';
      fornec.NIF := '';
      // tnnNaoInformado, tnnDispensado, tnnNaoExigencia
      fornec.cNaoNIF := tnnNaoInformado;
      fornec.xNome := 'fornecedor xyz';
      }

      dtEmiDoc := Date;
      dtCompDoc := Date;
      // trrr01, trrr02, trrr03, trrr04, trrr99
      tpReeRepRes := trrr99;
      // Informar a descrição se o tipo for trrr99.
      xTpReeRepRes := '';
      vlrReeRepRes := 0;
    end;

    // cst000, cst010, cst011, cst200, cst210, cst221, cst400, cst410
    // cst510, cst550, cst800, cst820
    IBSCBS.valores.trib.gIBSCBS.CST := cst000;
    IBSCBS.valores.trib.gIBSCBS.cClassTrib := '000001';

    // cpNenhum, cp01, cp02, cp03, cp04, cp05, cp06, cp07, cp08, cp09, cp10,
    // cp11, cp12, cp13
    IBSCBS.valores.trib.gIBSCBS.cCredPres := cp01;

    IBSCBS.valores.trib.gIBSCBS.gTribRegular.CSTReg := cst000;
    IBSCBS.valores.trib.gIBSCBS.gTribRegular.cClassTribReg := '000001';

    IBSCBS.valores.trib.gIBSCBS.gDif.pDifUF := 5;
    IBSCBS.valores.trib.gIBSCBS.gDif.pDifMun := 5;
    IBSCBS.valores.trib.gIBSCBS.gDif.pDifCBS := 5;
  End;

end;

procedure TFr_geranfe_Srv.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      NFS_e.Configuracoes.Geral.SSLCryptLib :=
        TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TFr_geranfe_Srv.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      NFS_e.Configuracoes.Geral.SSLHttpLib :=
        TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TFr_geranfe_Srv.cbSSLLibChange(Sender: TObject);
begin
  try
    if cbSSLLib.ItemIndex <> -1 then
      NFS_e.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TFr_geranfe_Srv.cbSSLTypeChange(Sender: TObject);
begin
  if cbSSLType.ItemIndex <> -1 then
    NFS_e.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);
end;

procedure TFr_geranfe_Srv.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      NFS_e.Configuracoes.Geral.SSLXmlSignLib :=
        TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizaSSLLibsCombo;
  end;
end;

procedure TFr_geranfe_Srv.ChamarGeraNFE_VDA;
Var
  Lc_Form : TFr_GeraNFe_vda;
begin
  try
    TRy
      Lc_Form := TFr_GeraNFe_vda.Create(Self);
      Lc_Form.It_Cd_Pedido      := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;
      Lc_Form.It_cd_Cliente     := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
      Lc_Form.It_cd_Consumidor  := FConsumidorFinal;
      Lc_Form.It_Cd_Nota        := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
      Lc_Form.It_Nr_Nota        := StrToIntDef(Qr_Nota.FieldByName('NFL_NUMERO').AsString,0);
      Lc_Form.It_Nf_Terceiro    := false;
      Lc_Form.ValorRecebido     := 0;
      Lc_Form.ValorTroco        := 0;

      //Operação Normal
      Pc_CarregaDadosEmitente(true);
      Lc_Form.TipoOperacao := 'NF-e';
      Lc_Form.ShowModal;
    except
      on e:Exception do
        MensagemPadrao('NMensagem de erro', ATENCAO + EOLN + EOLN +
                       e.Message + EOLN +
                       'Informe ao Desenvolvedor do Sistema.' + EOLN,
                       ['OK'], [bEscape], mpErro);
    End;
  finally
    FreeAndNil(Lc_Form);
    SetWindowPos(Gb_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);
  end;
end;

procedure TFr_geranfe_Srv.ChecarResposta(aMetodo: TMetodo);
var
  i: Integer;
begin
  MM_Acompanhamento.Update;

  with NFs_e.WebService do
  begin
    case aMetodo of
      tmRecepcionar,
      tmTeste:
        begin
          with Emite do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + ModoEnvioToStr(ModoEnvio));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Data de Envio : ' + DateToStr(Data));
            MM_Acompanhamento.Lines.Add('Numero do Prot: ' + Protocolo);
            MM_Acompanhamento.Lines.Add('Numero da Nota: ' + NumeroNota);
            MM_Acompanhamento.Lines.Add('Link          : ' + Link);
            MM_Acompanhamento.Lines.Add('Código Verif. : ' + CodigoVerificacao);
            MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;

          if Nfs_e.Configuracoes.Geral.ConsultaLoteAposEnvio and
             (Emite.Protocolo <> '') then
          begin
            if Nfs_e.Provider.ConfigGeral.ConsultaSitLote then
            begin
              with ConsultaSituacao do
              begin
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(tmConsultarSituacao));
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
                MM_Acompanhamento.Lines.Add('Numero do Prot: ' + Protocolo);
                MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
                MM_Acompanhamento.Lines.Add('Situação Lote : ' + Situacao);
                MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

                LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml', 1000);

                if Erros.Count > 0 then
                begin
                  MM_Acompanhamento.Lines.Add(' ');
                  MM_Acompanhamento.Lines.Add('Erro(s):');
                  for i := 0 to Erros.Count -1 do
                  begin
                    MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                    MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                    MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                    MM_Acompanhamento.Lines.Add('---------');
                  end;
                end;

                if Alertas.Count > 0 then
                begin
                  MM_Acompanhamento.Lines.Add(' ');
                  MM_Acompanhamento.Lines.Add('Alerta(s):');
                  for i := 0 to Alertas.Count -1 do
                  begin
                    MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                    MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                    MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                    MM_Acompanhamento.Lines.Add('---------');
                  end;
                end;
              end;
            end;

            if Nfs_e.Provider.ConfigGeral.ConsultaLote then
            begin
              with ConsultaLoteRps do
              begin
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(tmConsultarLote));
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
                MM_Acompanhamento.Lines.Add('Numero do Prot: ' + Protocolo);
                MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
                MM_Acompanhamento.Lines.Add('Situação Lote : ' + Situacao);
                MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

                //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml', 1000);
                LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml', 1000);

                if Erros.Count > 0 then
                begin
                  MM_Acompanhamento.Lines.Add(' ');
                  MM_Acompanhamento.Lines.Add('Erro(s):');
                  for i := 0 to Erros.Count -1 do
                  begin
                    MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                    MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                    MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                    MM_Acompanhamento.Lines.Add('---------');
                  end;
                end;

                if Alertas.Count > 0 then
                begin
                  MM_Acompanhamento.Lines.Add(' ');
                  MM_Acompanhamento.Lines.Add('Alerta(s):');
                  for i := 0 to Alertas.Count -1 do
                  begin
                    MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                    MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                    MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                    MM_Acompanhamento.Lines.Add('---------');
                  end;
                end;
              end;
            end;
          end;
        end;

      tmRecepcionarSincrono,
      tmGerar:
        begin
          with Emite do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + ModoEnvioToStr(ModoEnvio));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Data de Envio : ' + DateToStr(Data));
            MM_Acompanhamento.Lines.Add('Numero do Prot: ' + Protocolo);
            MM_Acompanhamento.Lines.Add('Numero da Nota: ' + NumeroNota);
            MM_Acompanhamento.Lines.Add('Link          : ' + Link);
            MM_Acompanhamento.Lines.Add('Código Verif. : ' + CodigoVerificacao);
            MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;
        end;

      tmConsultarSituacao:
        begin
          with ConsultaSituacao do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(tmConsultarSituacao));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero do Prot: ' + Protocolo);
            MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Situação Lote : ' + Situacao);
            MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;
        end;

      tmConsultarLote:
        begin
          with ConsultaLoteRps do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(tmConsultarLote));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero do Prot: ' + Protocolo);
            MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Situação Lote : ' + Situacao);
            MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;
        end;

      tmConsultarNFSePorRps:
        begin

          with ConsultaNFSeporRps do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(tmConsultarNFSePorRps));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero do Rps : ' + NumeroRPS);
            MM_Acompanhamento.Lines.Add('Série do Rps  : ' + SerieRPs);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
            MM_Acompanhamento.Lines.Add('Numero do Prot: ' + Protocolo);
            MM_Acompanhamento.Lines.Add('Situação      : ' + Situacao);
            MM_Acompanhamento.Lines.Add('Data          : ' + DateToStr(Data));
            MM_Acompanhamento.Lines.Add('Desc. Situação: ' + DescSituacao);
            MM_Acompanhamento.Lines.Add('ID Nota       : ' + idNota);
            MM_Acompanhamento.Lines.Add('Link          : ' + Link);
            MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;
        end;

      tmConsultarNFSe,
      tmConsultarNFSePorFaixa,
      tmConsultarNFSeServicoPrestado,
      tmConsultarNFSeServicoTomado:
        begin
          with ConsultaNFSe do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(Metodo));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Num. Ini. NFSe: ' + InfConsultaNFSe.NumeroIniNFSe);
            MM_Acompanhamento.Lines.Add('Num. Fin. NFSe: ' + InfConsultaNFSe.NumeroFinNFSe);
            MM_Acompanhamento.Lines.Add('Data Inicial  : ' + DateToStr(InfConsultaNFSe.DataInicial));
            MM_Acompanhamento.Lines.Add('Data Final    : ' + DateToStr(InfConsultaNFSe.DataFinal));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;
        end;

      tmCancelarNFSe:
        begin
          with CancelaNFSe do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(tmCancelarNFSe));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero da NFSe: ' + InfCancelamento.NumeroNFSe);
            MM_Acompanhamento.Lines.Add('Série da NFSe : ' + InfCancelamento.SerieNFSe);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Situação: ' + Situacao);
            MM_Acompanhamento.Lines.Add('Link    : ' + Link);
            MM_Acompanhamento.Lines.Add('Sucesso : ' + BoolToStr(Sucesso, True));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Retorno do Pedido de Cancelamento:');
            MM_Acompanhamento.Lines.Add('Situação : ' + RetCancelamento.Situacao);
            MM_Acompanhamento.Lines.Add('Data/Hora: ' + DateToStr(RetCancelamento.DataHora));
            MM_Acompanhamento.Lines.Add('Mensagem : ' + RetCancelamento.MsgCanc);
            MM_Acompanhamento.Lines.Add('Sucesso  : ' + RetCancelamento.Sucesso);
            MM_Acompanhamento.Lines.Add('Link     : ' + RetCancelamento.Link);

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;

          if Nfs_e.Configuracoes.Geral.ConsultaAposCancelar and
             Nfs_e.Provider.ConfigGeral.ConsultaNFSe then
          begin
            with ConsultaNFSe do
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(Metodo));
              MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
              MM_Acompanhamento.Lines.Add('Num. Ini. NFSe: ' + InfConsultaNFSe.NumeroIniNFSe);
              MM_Acompanhamento.Lines.Add('Num. Fin. NFSe: ' + InfConsultaNFSe.NumeroFinNFSe);
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
              MM_Acompanhamento.Lines.Add('Sucesso       : ' + BoolToStr(Sucesso, True));

              //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml', 1000);
              LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml', 1000);

              if Erros.Count > 0 then
              begin
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Erro(s):');
                for i := 0 to Erros.Count -1 do
                begin
                  MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                  MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                  MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                  MM_Acompanhamento.Lines.Add('---------');
                end;
              end;

              if Alertas.Count > 0 then
              begin
                MM_Acompanhamento.Lines.Add(' ');
                MM_Acompanhamento.Lines.Add('Alerta(s):');
                for i := 0 to Alertas.Count -1 do
                begin
                  MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                  MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                  MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                  MM_Acompanhamento.Lines.Add('---------');
                end;
              end;
            end;
          end;
        end;

      tmSubstituirNFSe:
        begin
          with SubstituiNFSe do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + MetodoToStr(tmSubstituirNFSe));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero da NFSe: ' + InfCancelamento.NumeroNFSe);
            MM_Acompanhamento.Lines.Add('Série da NFSe : ' + InfCancelamento.SerieNFSe);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Situação: ' + Situacao);
            MM_Acompanhamento.Lines.Add('Link    : ' + Link);
            MM_Acompanhamento.Lines.Add('Sucesso : ' + BoolToStr(Sucesso, True));
            MM_Acompanhamento.Lines.Add('Numero da NFSe Substituida  : ' + NumNotaSubstituida);
            MM_Acompanhamento.Lines.Add('Numero da NFSe Substituidora: ' + NumNotaSubstituidora);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Retorno do Pedido de Cancelamento:');
            MM_Acompanhamento.Lines.Add('Situação : ' + RetCancelamento.Situacao);
            MM_Acompanhamento.Lines.Add('Data/Hora: ' + DateToStr(RetCancelamento.DataHora));
            MM_Acompanhamento.Lines.Add('Mensagem : ' + RetCancelamento.MsgCanc);
            MM_Acompanhamento.Lines.Add('Sucesso  : ' + RetCancelamento.Sucesso);
            MM_Acompanhamento.Lines.Add('Link     : ' + RetCancelamento.Link);

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;
        end;

      tmGerarLote:
        begin
          with Gerar do
          begin
            MM_Acompanhamento.Lines.Add('Método Executado: ' + ModoEnvioToStr(ModoEnvio));
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Envio');
            MM_Acompanhamento.Lines.Add('Numero do Lote: ' + NumeroLote);
            MM_Acompanhamento.Lines.Add(' ');
            MM_Acompanhamento.Lines.Add('Parâmetros de Retorno');
            MM_Acompanhamento.Lines.Add('Nome Arquivo : ' + NomeArq);

            //LoadXML(XmlEnvio, WBXmlEnvio, 'temp1.xml');
            LoadXML(XmlRetorno, WBXmlRetorno, 'temp2.xml');

            if Erros.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Erro(s):');
              for i := 0 to Erros.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Erros[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Erros[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Erros[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;

            if Alertas.Count > 0 then
            begin
              MM_Acompanhamento.Lines.Add(' ');
              MM_Acompanhamento.Lines.Add('Alerta(s):');
              for i := 0 to Alertas.Count -1 do
              begin
                MM_Acompanhamento.Lines.Add('Código  : ' + Alertas[i].Codigo);
                MM_Acompanhamento.Lines.Add('Mensagem: ' + Alertas[i].Descricao);
                MM_Acompanhamento.Lines.Add('Correção: ' + Alertas[i].Correcao);
                MM_Acompanhamento.Lines.Add('---------');
              end;
            end;
          end;
        end;

      tmAbrirSessao:
        begin
        end;

      tmFecharSessao:
        begin
        end;
    end;

  end;

  for i := 0 to Nfs_e.NotasFiscais.Count -1 do
  begin
    MM_Acompanhamento.Lines.Add(' ');
    MM_Acompanhamento.Lines.Add('NFS-e Numero....: ' + Nfs_e.NotasFiscais.Items[i].NFSe.Numero);
    MM_Acompanhamento.Lines.Add('Cod. Verificacao: ' + Nfs_e.NotasFiscais.Items[i].NFSe.CodigoVerificacao);
    MM_Acompanhamento.Lines.Add('Prestador.......: ' + Nfs_e.NotasFiscais.Items[i].NFSe.Prestador.RazaoSocial);
    MM_Acompanhamento.Lines.Add('Tomador.........: ' + Nfs_e.NotasFiscais.Items[i].NFSe.Tomador.RazaoSocial);

    if Nfs_e.NotasFiscais.Items[i].NFSe.SituacaoNfse = ACBrNFSeXConversao.snCancelado then
      MM_Acompanhamento.Lines.Add('A Nota encontra-se Cancelada.');

    if Nfs_e.NotasFiscais.Items[i].NomeArq <> '' then
    begin
      MM_Acompanhamento.Lines.Add('Nome do arquivo.: ' + Nfs_e.Configuracoes.Arquivos.GetPathNFSe() + '\' +
                                               Nfs_e.NotasFiscais.Items[i].NomeArq);
      if Nfs_e.Configuracoes.Arquivos.Salvar then
        MM_Acompanhamento.Lines.Add('==> Xml da nota salvo na pasta e com o nome informado acima.')
      else
        MM_Acompanhamento.Lines.Add('==> Xml da nota não salvo em disco.');

      // Na propriedade XmlNfse temos o XML da NFS-e
      LoadXML(Nfs_e.NotasFiscais.Items[i].XmlNfse, WBXmlNotas);
    end;
  end;

end;

function TFr_geranfe_Srv.executeConsulta(etapa :String): Boolean;
Var
  Lc_Escolha: Integer;
  NumeroNFSe : String;
  Lc_Protocolo : String;
  InfConsultaNFSe: TInfConsultaNFSe;
begin
  case NFS_e.Configuracoes.Geral.Provedor of
    proIPM:Begin
      if Nfs_e.Configuracoes.Geral.Layout = loABRASF then
        executeIPMSistemas(etapa)
      else
      Begin
        if RetNFse.Config.Registro.LayoutNFse = 've204' then
        Begin
          executeIPMSistemas(etapa);
        End
        else
        Begin
          executeIPMSistemasV01('');
        End;
      End;

    End;
    proPadraoNacional: executePadraoNacional(etapa);
    proISSNet:executeISSNet(etapa);
  else
    executeGeneral(etapa);
  end;
end;


function TFr_geranfe_Srv.executeGeneral(etapa: String): Boolean;
begin
  NFS_e.ConsultarNFSeporNumero(RetNFse.Registro.Numero);
end;

function TFr_geranfe_Srv.executeIPMSistemas(etapa: String): Boolean;
Var
  InfConsultaNFSe: TInfConsultaNFSe;
  Lc_Escolha : Integer;
  NumeroNFSe : String;
begin
  Lc_Escolha := 0;
  if etapa = 'Consultar' then
  Begin
    Lc_Escolha := (MensagemPadrao('Escolha o método da consulta.',
                                  'Escolha dentre as opções.',
                                  [' Por RPS (Padrão) ', ' POR NFSE '], [bNormal, bNormal], mpConfirmacao, clBtnFace));
  End;

  case Lc_Escolha of
    0:begin
        NFS_e.ConsultarNFSeporRps(
                              RetNFse.Rps.Registro.Numero.ToString,
                              NFS_e.NotasFiscais[0].NFSe.IdentificacaoRps.Serie,
                              FProvider.TipoRPSToStr(NFS_e.NotasFiscais[0].NFSe.IdentificacaoRps.Tipo),
                              '');

      end;
    1:begin
        try
          if (RetNFse.Registro.Numero = '') then
          Begin
            NumeroNFSe := '';
            if not(InputQuery('Informe o Número da Nota', 'Numero da NFSe:', NumeroNFSe)) then
              exit;
          end;

          InfConsultaNFSe := TInfConsultaNFSe.Create;
          with InfConsultaNFSe do
          begin
            tpConsulta := tcPorFaixa;
            NumeroIniNFSe := RetNFse.Registro.Numero;
            NumeroFinNFSe := RetNFse.Registro.Numero;
            SerieNFSe := '1';
            CadEconomico := DM.Qr_Estabelecimento.FieldByName('EMP_INSC_MUN').asString;
          end;
          NFS_e.ConsultarNFSeGenerico(InfConsultaNFSe);
        finally
          InfConsultaNFSe.Free;
        end;

        //NFS_e.ConsultarNFSePorNumero(NumeroNFSe);
      end;
  end;
end;

function TFr_geranfe_Srv.executeIPMSistemasV01(etapa: String): Boolean;
Var
  InfConsultaNFSe: TInfConsultaNFSe;
  Lc_Escolha : Integer;
  NumeroNFSe : String;
begin
  try
    if (RetNFse.Registro.Numero = '') then
    Begin
      NumeroNFSe := '';
      if not(InputQuery('Informe o Número da Nota', 'Numero da NFSe:', NumeroNFSe)) then
        exit;
      RetNFse.Registro.Numero := NumeroNFSe;
      RetNFse.salva;
    end;

    InfConsultaNFSe := TInfConsultaNFSe.Create;
    with InfConsultaNFSe do
    begin
      tpConsulta := tcPorNumero;
      NumeroIniNFSe := RetNFse.Registro.Numero;
      SerieNFSe := '1';
      CadEconomico := DM.Qr_Estabelecimento.FieldByName('EMP_INSC_MUN').asString;
    end;

    NFS_e.ConsultarNFSeGenerico(InfConsultaNFSe);

  finally
    InfConsultaNFSe.Free;
  end;
end;

function TFr_geranfe_Srv.executePadraoNacional(etapa: String): Boolean;
Var
  cChave : String;
begin
  cChave := RetNFse.Registro.CodigoVerificacao;


  if ( Length(RetNFse.Registro.CodigoVerificacao) <= 20 ) then
  Begin
    cChave := '';
    if not(InputQuery('Informe a chave da nota', 'Numero:', cChave)) then
      exit;
  End;

  NFS_e.ConsultarNFSePorChave( cChave );

end;

function TFr_geranfe_Srv.executeISSNet(etapa: String): Boolean;
begin
  NFS_e.ConsultarNFSeporRps(
                        RetNFse.Rps.Registro.Numero.ToString,
                        NFS_e.NotasFiscais[0].NFSe.IdentificacaoRps.Serie,
                        FProvider.TipoRPSToStr(NFS_e.NotasFiscais[0].NFSe.IdentificacaoRps.Tipo),
                        '');

end;

procedure TFr_geranfe_Srv.Sb_CancelarClick(Sender: TObject);
begin
  Pnl_Botao.Enabled := False;
  Pnl_Cancelamento.Visible := True;
end;

end.


