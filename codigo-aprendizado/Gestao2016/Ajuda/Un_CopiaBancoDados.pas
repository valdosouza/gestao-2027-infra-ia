unit Un_CopiaBancoDados;

interface

uses
      System.UITypes, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, uMySFTPClient, un_base, StdCtrls, ComCtrls, ExtCtrls, CheckLst, Vcl.Buttons, Vcl.Samples.Gauges, Vcl.Menus;

type
  TFr_CopiaBancoDAdos = class(TFr_Base)

    pnl_botoes: TPanel;
    SB_Copiar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Panel1: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    edHost: TLabeledEdit;
    edPort: TLabeledEdit;
    edUser: TLabeledEdit;
    edPass: TLabeledEdit;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    E_PathFileOrigem: TEdit;
    GroupBox2: TGroupBox;
    SpeedButton2: TSpeedButton;
    E_PathDestino: TEdit;
    Opd_Arquivo: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_CopiarClick(Sender: TObject);

  private
    SFTP: TSFTPClient;
    function Conectar:Boolean;
    function ValidateCopia:boolean;
    PRocedure Copia;
    procedure Desconectar;

    procedure OnProgress(ASender: TObject; const AFileName: WideString; ATransfered, ATotal: UInt64);
    procedure OnCantChangeStartDir(ASender: TObject; var Continue: Boolean);
    procedure OnAuthFailed(ASender: TObject; var Continue: Boolean);
    procedure OnKeybdInteractive(ASender: TObject; var Password: String);

  protected
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
  public
    { Public declarations }
  end;

var
  Fr_CopiaBancoDAdos: TFr_CopiaBancoDAdos;

implementation

uses
      WideStrUtils, FileCtrl, libssh2_sftp, Un_DM, Un_Msg, un_sistema, env;


{$R *.dfm}

function TFr_CopiaBancoDAdos.Conectar:boolean;
var
  Mode: TAuthModes;
begin
  Result := True;
  SFTP.UserName := edUser.Text;
  SFTP.Password := edPass.Text;
  SFTP.Host := edHost.Text;
  SFTP.Port := StrToIntDef(edPort.Text, 22);
  SFTP.KeepAlive := True;
  SFTP.IPVersion := IPv4;
  SFTP.AuthModes := [amTryAll];
  try
    Lb_Processamento.Caption := 'Conectando ao servidor';
    Lb_Processamento.Update;
    SFTP.Connect;
    if not SFTP.Connected then
    Begin
      Lb_Processamento.Caption := 'Falha ao conectar ao servidor';
      Result := False;
      Exit;
    End;
    SFTP.List;
  except
    on E: ESSH2Exception do
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Conexão com o Servidor Falhou.'+EOLN+
                     E.Message+EOLN,
                    ['OK'],[bEscape],mpErro);

    End;
  end;
end;

procedure TFr_CopiaBancoDAdos.Copia;
var
  Dir: String;
  FileName :String;
  FS: TFileStream;
  Lc_dirLocal : String;
  Lc_Date : String;
begin
  Lc_Date := DateTimeToStr(Now);
  Lc_Date := StringReplace(Lc_Date, '/', '-', [rfReplaceAll, rfIgnoreCase]);
  Lc_Date := StringReplace(Lc_Date, ' ', '_', [rfReplaceAll, rfIgnoreCase]);
  Lc_Date := StringReplace(Lc_Date, ':', '-', [rfReplaceAll, rfIgnoreCase]);
  FileName := 'IBGCOM' + Lc_Date +'.FDB';
  // the code below is put in a tworkerthread in the original program
  // this is just a demo, so :P
  FS := TFileStream.Create(CONCAT(E_PathDestino.Text,FileName), fmCreate);
  Gg_Progresso.Visible := True;
  Lb_Processamento.Caption := 'Copiando Arquivo';
  try
    SFTP.Get(E_PathFileOrigem.text, FS, False);
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Banco de Dados Copiado com sucesso.'+EOLN,
                  ['OK'],[bEscape],mpInformacao);

  except on E: ESSH2Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TFr_CopiaBancoDAdos.Desconectar;
begin
  SFTP.Disconnect;

end;


procedure TFr_CopiaBancoDAdos.FormCreate(Sender: TObject);
begin
  SFTP := TSFTPClient.Create(Self);
  SFTP.DebugMode := True; // ouput debug info over Windows.OutputDebugString
  SFTP.OnTransferProgress := OnProgress;
  SFTP.OnAuthFailed := OnAuthFailed;
  SFTP.OnCantChangeStartDir := OnCantChangeStartDir;
  SFTP.OnKeybdInteractive := OnKeybdInteractive;
end;

procedure TFr_CopiaBancoDAdos.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(SB_Copiar,'EXPORTAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TFr_CopiaBancoDAdos.IniciaVariaveis;
begin
  inherited;
  edHost.Text         := Fc_Tb_Geral('L','CP_BANCO_IP','');
  edUser.Text         := Fc_Tb_Geral('L','CP_BANCO_USERNAME','');
  edPass.Text         := Fc_Tb_Geral('L','CP_BANCO_PASSWORD','');
  E_PathFileOrigem.Text   := Fc_Aq_Geral('L','COPIABANCO','ORIGEM','');
  E_PathDestino.Text  := Fc_Aq_Geral('L','COPIABANCO','DESTINO','');
end;

procedure TFr_CopiaBancoDAdos.OnAuthFailed(ASender: TObject; var Continue: Boolean);
begin
  Continue := MessageDlg('Auth failed. Try again?', mtConfirmation, mbYesNo, 0) = mrYes;
end;

procedure TFr_CopiaBancoDAdos.OnCantChangeStartDir(ASender: TObject; var Continue: Boolean);
begin
  Continue := MessageDlg('Could not change to start dir. Continue?', mtConfirmation, mbYesNo, 0) = mrYes;
end;

procedure TFr_CopiaBancoDAdos.OnKeybdInteractive(ASender: TObject; var Password: String);
begin
  InputQuery('Enter password for kybdinteractive', 'Password', Password);
end;

procedure TFr_CopiaBancoDAdos.OnProgress(ASender: TObject; const AFileName: WideString; ATransfered, ATotal: UInt64);
begin
  Gg_Progresso.MaxValue := ATotal;
  Gg_Progresso.Progress := ATransfered;
  Lb_Processamento.Caption := AFileName;
  Gg_Progresso.Update;
  Application.ProcessMessages;
end;

procedure TFr_CopiaBancoDAdos.SB_CopiarClick(Sender: TObject);
begin
  if ValidateCopia then
    Copia;
end;

procedure TFr_CopiaBancoDAdos.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_CopiaBancoDAdos.SpeedButton1Click(Sender: TObject);
begin
  if Opd_Arquivo.Execute then
    E_PathFileOrigem.Text := Opd_Arquivo.FileName
  else
    E_PathFileOrigem.Clear;
end;

procedure TFr_CopiaBancoDAdos.SpeedButton2Click(Sender: TObject);
begin
   if Opd_Arquivo.Execute then
    E_PathDestino.Text := Opd_Arquivo.FileName
  else
    E_PathDestino.Clear;

end;

function TFr_CopiaBancoDAdos.ValidateCopia: boolean;
begin
  Result := True;
  if (edHost.Text = '')  then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe o IP do Servidor do Banco de dados.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result := FAlse;
    exit;
  end;

  if (edUser.Text = '')  then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe o usáario do Servidor do Banco de dados.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result := FAlse;
    exit;
  end;

  if (edPass.Text = '')  then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe o senha do Servidor do Banco de dados.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result := FAlse;
    exit;
  end;

  if (E_PathFileOrigem.Text = '')  then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe o caminho de origem do Banco de dados.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result := FAlse;
    exit;
  end;

  if (E_PathDestino.Text = '') then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe o caminho de Destino da cópia do Banco de dados.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result := FAlse;
    exit;
  End;
  Fc_Tb_Geral('G','CP_BANCO_IP',edHost.Text);
  Fc_Tb_Geral('G','CP_BANCO_USERNAME',edUser.Text);
  Fc_Tb_Geral('G','CP_BANCO_PASSWORD',edPass.Text);
  Fc_Aq_Geral('G','COPIABANCO','ORIGEM',E_PathFileOrigem.Text);
  Fc_Aq_Geral('G','COPIABANCO','DESTINO',E_PathDestino.Text);

  if not Conectar then
  Begin
    result := FAlse;
    exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Copiar o arquivo '+E_PathFileOrigem.Text +EOLN+EOLN+
                     'O Banco de Dados Não Pode Estar em Uso' + EOLN+
                     'Confirmar a Cópia ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Operação cancelada pelo usuário.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result := FAlse;
    exit;
  end;

end;

end.
