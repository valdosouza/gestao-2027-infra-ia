unit tas_retaguarda_web;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, ControllerRetaguardaWEB, Datasnap.DBClient, Datasnap.Provider, ControllerPDV;

type
  TTasRetaguardaWeb = class(TFr_Base)
    pnl_geral: TPanel;
    chbx_Retaguarda_ativa: TCheckBox;
    pnl_botoes: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    pnl_row_01: TPanel;
    e_terminal: TEdit;
    Label1: TLabel;
    dbg_reta_sync: TDBGrid;
    e_path_bd: TEdit;
    Label2: TLabel;
    cds_retaguarda_sync: TClientDataSet;
    ds_retaguarda_sync: TDataSource;
    cds_retaguarda_syncID: TWideStringField;
    cds_retaguarda_syncWAY: TWideStringField;
    cds_retaguarda_syncDataTempo: TDateTimeField;
    PreparaBancoLocal1: TMenuItem;
    PreparabancoRetaguarda1: TMenuItem;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    E_Path_server: TEdit;
    E_Porta_server: TEdit;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    E_User_name: TEdit;
    E_User_phrase: TEdit;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure PreparaBancoLocal1Click(Sender: TObject);
    procedure PreparabancoRetaguarda1Click(Sender: TObject);
  private
    function ValidaPreparaBancoLocal:boolean;
    procedure PreparaBancoLocal;

    function ValidaPreparaBancoRetaguarda:boolean;
    procedure PreparaBancoRetaguarda;

    procedure OpenRetaguardaSync;
    function ValidaConfirma:Boolean;
    procedure PreencheRetaguardaWEb;
    procedure Confirma;
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure setPerfil;Override;
    procedure FormataTela;Override;
    procedure AtivaTabelas;Override;
  public
    { Public declarations }
    Retaguarda : TControllerRetaguardaWEB;
    PDV : TControllerPDV;
  end;

var
  TasRetaguardaWeb: TTasRetaguardaWeb;

implementation

{$R *.dfm}

uses     Un_Msg, Un_DM, env;

procedure TTasRetaguardaWeb.AtivaTabelas;
begin
  inherited;

end;

procedure TTasRetaguardaWeb.Confirma;
begin
  PreencheRetaguardaWEb;
  Retaguarda.save;
  Close;
end;


procedure TTasRetaguardaWeb.CriarVariaveis;
begin
  inherited;
  RetaGuarda := TControllerRetaguardaWEB.create(Self);
  RetaGuarda.getFirst;
  RetaGuarda.ConfiguraBancoRetaguarda;
end;

procedure TTasRetaguardaWeb.FinalizaVariaveis;
begin
  FreeAndNil(RetaGuarda);
  inherited;
end;

procedure TTasRetaguardaWeb.FormataTela;
begin
  inherited;

end;

procedure TTasRetaguardaWeb.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');
end;

procedure TTasRetaguardaWeb.IniciaVariaveis;
begin
  inherited;
  Retaguarda.getFirst;
  if Retaguarda.exist then
  Begin
    chbx_Retaguarda_ativa.Checked := (Retaguarda.Registro.Ativo = 'S');
    E_Path_server.Text  :=  Retaguarda.Registro.CaminhoServidor;
    E_Porta_server.Text :=  Retaguarda.Registro.PortaBanco;
    e_terminal.Text     := Retaguarda.Registro.Terminal.ToString();
    e_path_bd.Text      := Retaguarda.Registro.CaminhoBancoDados;
    E_User_name.Text    :=  Retaguarda.Registro.UserName;
    E_User_phrase.Text  :=  Retaguarda.Registro.UserFrase;
  End;
  OpenRetaguardaSync;
end;

procedure TTasRetaguardaWeb.OpenRetaguardaSync;
Var
  I : Integer;
begin
  if not cds_retaguarda_sync.Active then cds_retaguarda_sync.CreateDataSet;
  cds_retaguarda_sync.EmptyDataSet;
  Retaguarda.RetaguardaSync.getList;
  for I := 0 to Retaguarda.RetaguardaSync.Lista.Count-1 do
  Begin
    cds_retaguarda_sync.Append;
    cds_retaguarda_syncID.AsString := Retaguarda.RetaguardaSync.Lista[I].Codigo;
    cds_retaguarda_syncDataTempo.AsDateTime := Retaguarda.RetaguardaSync.Lista[I].Tempo;
    cds_retaguarda_syncWAY.AsString := Retaguarda.RetaguardaSync.Lista[I].Sentido;
    cds_retaguarda_sync.Post;
  End;
end;

procedure TTasRetaguardaWeb.PreencheRetaguardaWEb;
begin
  Retaguarda.Registro.Codigo := 1;
  if chbx_Retaguarda_ativa.Checked then
    Retaguarda.Registro.Ativo := 'S'
  else
    Retaguarda.Registro.Ativo := 'N';
  Retaguarda.Registro.CaminhoServidor := E_Path_server.Text;
  Retaguarda.Registro.PortaBanco := E_Porta_server.Text;
  Retaguarda.Registro.CaminhoBancoDados := e_path_bd.Text;
  Retaguarda.Registro.Terminal := StrToIntDef(e_terminal.Text,0);
  Retaguarda.Registro.UserName := E_User_name.Text;
  Retaguarda.Registro.UserFrase := E_User_phrase.Text;
end;

procedure TTasRetaguardaWeb.PreparaBancoLocal;
begin
  try
    PDV.CreateTrigguer;
    MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                   'Trigguers no PDV criados com sucesso.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  except

  end;
end;

procedure TTasRetaguardaWeb.PreparaBancoLocal1Click(Sender: TObject);
begin
  if ValidaPreparaBancoLocal then
    PreparaBancoLocal;
end;

procedure TTasRetaguardaWeb.PreparaBancoRetaguarda;
begin
  Try
    Retaguarda.CreateTrigguer;
    MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                   'Trigguers na retaguarda criados com sucesso.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  except

  End;
end;

procedure TTasRetaguardaWeb.PreparabancoRetaguarda1Click(Sender: TObject);
begin
  if ValidaPreparaBancoretaguarda then
    PreparaBancoretaguarda;
end;

procedure TTasRetaguardaWeb.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidaConfirma then
    Confirma;
end;

procedure TTasRetaguardaWeb.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TTasRetaguardaWeb.setPerfil;
begin
  inherited;

end;


function TTasRetaguardaWeb.ValidaConfirma: Boolean;
begin
  Result := true;
  if chbx_Retaguarda_ativa.Checked then
  Begin
    if E_Path_server.Text = '' then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Para manter a retaguarda Ativa.' + EOLN+
                     'Precisa informar o caminho do Servidor na WEB.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      E_Path_server.SetFocus;
      Result := False;
      exit;
    End;

    if E_Porta_server.Text = '' then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Para manter a retaguarda Ativa.' + EOLN+
                     'Precisa informar a porta de conexão no Servidor na WEB.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      E_Porta_server.SetFocus;
      Result := False;
      exit;
    End;

    if e_path_bd.Text = '' then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Para manter a retaguarda Ativa.' + EOLN+
                     'Precisa informar o caminho do banco de dados da Retaguarda WEB'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      e_path_bd.SetFocus;
      Result := False;
      exit;
    End;

    if E_User_name.Text = '' then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Para manter a retaguarda Ativa.' + EOLN+
                     'Precisa informar um usuário do banco de dados para a conexão aoe dados da Retaguarda WEB'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      E_User_name.SetFocus;
      Result := False;
      exit;
    End;

    if E_User_phrase.Text = '' then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Para manter a retaguarda Ativa.' + EOLN+
                     'Precisa informar um Senha do banco de dados para a conexão aoe dados da Retaguarda WEB'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      E_User_phrase.SetFocus;
      Result := False;
      exit;
    End;

    if (DM.IBD_Gestao.DatabaseName = e_path_bd.Text ) then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'O Banco de dados da Retaguarda não deve ser o mesmo utilizado neste computador.' + EOLN+
                     'Verifique o caminho e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      e_path_bd.SetFocus;
      Result := False;
      exit;
    End;

    PreencheRetaguardaWEb;
    if not Retaguarda.ValidaConexaoRetaguarda then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Não foi possível conectar ao Banco de dados da Retaguarda.' + EOLN+
                     'Verifique o caminho e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      e_path_bd.SetFocus;
      Result := False;
      exit;
    End;

    if StrToIntDef(e_terminal.Text,0) = 0 then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Para manter a retaguarda Ativa.' + EOLN+
                     'Precisa informar o Número deste Terminal'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      e_terminal.SetFocus;
      Result := False;
      exit;
    End;
  End;
end;

function TTasRetaguardaWeb.ValidaPreparaBancoLocal: boolean;
begin
  Result := True;
end;

function TTasRetaguardaWeb.ValidaPreparaBancoRetaguarda: boolean;
begin
  Result := True;
end;

end.
