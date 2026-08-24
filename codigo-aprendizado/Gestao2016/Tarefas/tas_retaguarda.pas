unit tas_retaguarda;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, ControllerRetaguarda, Datasnap.DBClient, Datasnap.Provider, ControllerPDV;

type
  TTasRetaguarda = class(TFr_Base)
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
    Retaguarda : TControllerRetaguarda;
    PDV : TControllerPDV;
  end;

var
  TasRetaguarda: TTasRetaguarda;

implementation

{$R *.dfm}

uses     Un_Msg, Un_DM, env;

procedure TTasRetaguarda.AtivaTabelas;
begin
  inherited;

end;

procedure TTasRetaguarda.Confirma;
begin
  Retaguarda.Registro.Codigo := 1;
  if chbx_Retaguarda_ativa.Checked then
    Retaguarda.Registro.Ativo := 'S'
  else
    Retaguarda.Registro.Ativo := 'N';
  Retaguarda.Registro.CaminhoBancoDados := e_path_bd.Text;
  Retaguarda.Registro.Termina := StrToIntDef(e_terminal.Text,0);
  Retaguarda.save;
  Close;
end;


procedure TTasRetaguarda.CriarVariaveis;
begin
  inherited;
  RetaGuarda := TControllerRetaguarda.create(Self);
  RetaGuarda.ConfiguraBancoRetaguarda;
  PDV := TControllerPDV.Create(self);
  PDV.BancoPDV := DM.IBD_Gestao;
end;

procedure TTasRetaguarda.FinalizaVariaveis;
begin
  FreeAndNil(PDV);
  FreeAndNil(RetaGuarda);
  inherited;
end;

procedure TTasRetaguarda.FormataTela;
begin
  inherited;

end;

procedure TTasRetaguarda.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');
end;

procedure TTasRetaguarda.IniciaVariaveis;
begin
  inherited;
  Retaguarda.getFirst;
  if Retaguarda.exist then
  Begin
    chbx_Retaguarda_ativa.Checked := (Retaguarda.Registro.Ativo = 'S');
    e_terminal.Text := Retaguarda.Registro.Termina.ToString();
    e_path_bd.Text := Retaguarda.Registro.CaminhoBancoDados;
  End;
  OpenRetaguardaSync;
end;

procedure TTasRetaguarda.OpenRetaguardaSync;
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

procedure TTasRetaguarda.PreparaBancoLocal;
begin
  try
    PDV.CreateTrigguer;
    MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                   'Trigguers no PDV criados com sucesso.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  except

  end;
end;

procedure TTasRetaguarda.PreparaBancoLocal1Click(Sender: TObject);
begin
  if ValidaPreparaBancoLocal then
    PreparaBancoLocal;
end;

procedure TTasRetaguarda.PreparaBancoRetaguarda;
begin
  Try
    Retaguarda.CreateTrigguer;
    MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                   'Trigguers na retaguarda criados com sucesso.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  except

  End;
end;

procedure TTasRetaguarda.PreparabancoRetaguarda1Click(Sender: TObject);
begin
  if ValidaPreparaBancoretaguarda then
    PreparaBancoretaguarda;
end;

procedure TTasRetaguarda.SB_ConfirmarClick(Sender: TObject);
begin
  if ValidaConfirma then
    Confirma;
end;

procedure TTasRetaguarda.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TTasRetaguarda.setPerfil;
begin
  inherited;

end;


function TTasRetaguarda.ValidaConfirma: Boolean;
begin
  Result := true;
  if chbx_Retaguarda_ativa.Checked then
  Begin
    if e_path_bd.Text = '' then
    Begin
      MensagemPadrao(MENSAGEM, 'A L E R T A!.' + EOLN + EOLN +
                     'Para manter a retaguarda Ativa.' + EOLN+
                     'Precisa informar o caminho do banco de dados da Retaguarda'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      e_path_bd.SetFocus;
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

    Retaguarda.Registro.CaminhoBancoDados := e_path_bd.Text;
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

function TTasRetaguarda.ValidaPreparaBancoLocal: boolean;
begin
  Result := True;
end;

function TTasRetaguarda.ValidaPreparaBancoRetaguarda: boolean;
begin
  Result := True;
end;

end.
