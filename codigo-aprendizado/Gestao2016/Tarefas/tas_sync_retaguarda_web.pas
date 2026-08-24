unit tas_sync_retaguarda_web;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Un_Base, StdCtrls, Spin, ComCtrls, ExtCtrls, DB, ADODB, IniFiles, Clipbrd, Mask, DBCtrls, Grids, Buttons, ShellAPI, Menus, registry, OleCtrls, Vcl.Samples.Gauges, ControllerSincronia, ControllerretaguardawebSync;

type

  TTasSyncRetaguardaWeb = class(TFr_Base)
    pnl_Botao: TPanel;
    Gg_Progresso: TGauge;
    Lb_Processamento: TLabel;
    Lst_Process: TListBox;
    SB_Sair_0: TSpeedButton;
    Sb_Confirmar: TSpeedButton;
    SincronizartodososClientes1: TMenuItem;
    Pg_Principal: TPageControl;
    Tbs_Processamento: TTabSheet;
    tbs_envio: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    tbs_recebimento: TTabSheet;
    Pnl_Top: TPanel;
    pnl_top_Left: TPanel;
    chbx_setTimeTo: TCheckBox;
    Dtp_Inicio: TDateTimePicker;
    Dtp_Hora: TDateTimePicker;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Label4: TLabel;
    AjustarCNPJDuplicados1: TMenuItem;
    ValidaCNPJs1: TMenuItem;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Sb_ConfirmarClick(Sender: TObject);
    procedure SincronizartodososClientes1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AjustarCNPJDuplicados1Click(Sender: TObject);
    procedure ValidaCNPJs1Click(Sender: TObject);

  private
    LoadSyncroniaRecebimento : TThread;
    LoadSyncroniaEnvio : TThread;
    FEstabelecimento: Integer;
    procedure setFEstabelecimento(const Value: Integer);

    function ValidaProcessamento:Boolean;
    procedure Recebimentos;
    procedure Envios;
  protected
    procedure FormataTela;Override;
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure execShorCutKeyF10;Override;
    procedure execShorCutEsc;Override;

  public
    { Public declarations }
    Retaguarda : TControllerretaguardawebSync;
    property Estabelecimento : Integer read FEstabelecimento write setFEstabelecimento;
  end;

var
  TasSyncRetaguardaWeb: TTasSyncRetaguardaWeb;

implementation

{$R *.dfm}

uses     Un_DM, Un_Sistema, Un_Msg;





procedure TTasSyncRetaguardaWeb.AjustarCNPJDuplicados1Click(Sender: TObject);
Var
  CnpjDuplicatados : TThread;
begin
  CnpjDuplicatados := TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(CnpjDuplicatados,
      procedure
      begin
        Pnl_Top.Enabled := False;
        self.SB_Confirmar.Enabled := False;
        self.Lst_Process.Clear;
      end);
      self.Retaguarda.DesativarAllTriggers;
      Lst_Process.Items.Add('Ajustando CNPJs duplicados');
      //self.Retaguarda.ControlePDV.JuntarCNPJDuplicados;
      //self.Retaguarda.AtivarAllTriggers;
      TThread.Synchronize(CnpjDuplicatados,
      procedure
      begin
        self.SB_Confirmar.Enabled := True;
        Pnl_Top.Enabled := True;
        self.chbx_setTimeTo.Checked := False;
      end);
      CnpjDuplicatados.Terminate;
    end
  );
  CnpjDuplicatados.FreeOnTerminate := True;
  CnpjDuplicatados.Start;
end;

procedure TTasSyncRetaguardaWeb.CriarVariaveis;
begin
  inherited;
  Retaguarda := TControllerretaguardaWebSync.create(self);
end;

procedure TTasSyncRetaguardaWeb.Envios;
begin
  LoadSyncroniaEnvio := TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(LoadSyncroniaEnvio,
      procedure
      begin
        Pnl_Top.Enabled := False;
        self.SB_Confirmar.Enabled := False;
        self.Lst_Process.Clear;
      end);
      self.Retaguarda.DataInicial := E_Data_Ini.Date;
      self.Retaguarda.DataFinal := E_Data_Fim.Date;
      {
      self.Retaguarda.Terminal := Gb_Terminal;
      self.Retaguarda.ControlePDV.DataInicial := E_Data_Ini.Date;
      self.Retaguarda.ControlePDV.DataFinal := E_Data_Fim.Date;

      self.Retaguarda.ControlePDV.AjustarDadosClientes('Periodo');
      self.Retaguarda.ColocarDadosnaTabelaSincronia;
      self.Retaguarda.SincronizarPdvToRetaguarda;
      }
      TThread.Synchronize(LoadSyncroniaEnvio,
      procedure
      begin
        self.SB_Confirmar.Enabled := True;
        Pnl_Top.Enabled := True;
        self.chbx_setTimeTo.Checked := False;
      end);
      LoadSyncroniaEnvio.Terminate;
    end
  );
  LoadSyncroniaEnvio.FreeOnTerminate := True;
  LoadSyncroniaEnvio.Start;
end;

procedure TTasSyncRetaguardaWeb.execShorCutEsc;
begin
  Sb_Sair_0Click(Self);
end;

procedure TTasSyncRetaguardaWeb.execShorCutKeyF10;
begin
  if Sb_Confirmar.Enabled then Sb_ConfirmarClick(Self);
end;

procedure TTasSyncRetaguardaWeb.FormataTela;
begin
  Pg_Principal.ActivePage := tbs_recebimento
end;

procedure TTasSyncRetaguardaWeb.FormShow(Sender: TObject);
begin
  if Sb_Confirmar.Enabled then
  Begin
    inherited;
  end
  else
  Begin
    Pg_Principal.ActivePage := Tbs_Processamento;
  end;
end;

procedure TTasSyncRetaguardaWeb.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(SB_Sair_0,'SAIR');

end;

procedure TTasSyncRetaguardaWeb.IniciaVariaveis;
begin
  inherited;
  Dtp_Inicio.DateTime := Now;
  E_Data_Ini.DateTime := Now;
  E_Data_Fim.DateTime := Now;
  {
  Retaguarda.Estabelecimento  := FEstabelecimento;
  Retaguarda.BancoPDV         := DM.IBD_Gestao;
  Retaguarda.Progresso        := Gg_Progresso;
  Retaguarda.LogListBox       := Lst_Process;
  Retaguarda.MsgProcessamento := Lb_Processamento;

  Retaguarda.ControlePDV.BancoPDV         := Retaguarda.BancoPDV;
  Retaguarda.ControlePDV.BancoRetaguarda  := Retaguarda.BancoRetaguarda;
  Retaguarda.ControlePDV.Progresso        := Gg_Progresso;
  Retaguarda.ControlePDV.LogListBox       := Lst_Process;

  Retaguarda.ControleRetaguarda.BancoPDV        := Retaguarda.BancoPDV;
  Retaguarda.ControleRetaguarda.BancoRetaguarda := Retaguarda.BancoRetaguarda;
  Retaguarda.ControleRetaguarda.Progresso       := Gg_Progresso;
  Retaguarda.ControleRetaguarda.LogListBox      := Lst_Process;
  }
end;


procedure TTasSyncRetaguardaWeb.Recebimentos;
begin
  LoadSyncroniaRecebimento := TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(LoadSyncroniaRecebimento,
      procedure
      begin
        Pnl_Top.Enabled := False;
        self.SB_Confirmar.Enabled := False;
        self.Lst_Process.Clear;
      end);

      if chbx_setTimeTo.Checked then
      Begin

        self.Retaguarda.Registro.Tempo := StrToDateTime(concat(DatetoStr(Dtp_Inicio.Date), ' ' ,TimeToStr(Dtp_Hora.Time)));
        self.Retaguarda.Registro.Sentido := 'R';
        self.Lst_Process.Items.Add('Reiniciando as Datas');
        self.Retaguarda.resetDataRecebimento;

      end;

      //self.Retaguarda.SincronizarRetaguardaToPdv;

      TThread.Synchronize(LoadSyncroniaRecebimento,
      procedure
      begin
        self.SB_Confirmar.Enabled := True;
        Pnl_Top.Enabled := True;
        self.chbx_setTimeTo.Checked := False;
      end);
      LoadSyncroniaRecebimento.Terminate;
    end
  );
  LoadSyncroniaRecebimento.FreeOnTerminate := True;
  LoadSyncroniaRecebimento.Start;
end;

procedure TTasSyncRetaguardaWeb.Sb_Sair_0Click(Sender: TObject);
begin
  inherited;
  self.Hide;
end;

procedure TTasSyncRetaguardaWeb.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TTasSyncRetaguardaWeb.SincronizartodososClientes1Click(Sender: TObject);
Begin
  LoadSyncroniaRecebimento := TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(LoadSyncroniaRecebimento,
      procedure
      begin
        Pnl_Top.Enabled := False;
        self.SB_Confirmar.Enabled := False;
        self.Lst_Process.Clear;
      end);
      self.Retaguarda.DesativarAllTriggers;
      //self.Retaguarda.AjustarDadosBases;
      //self.Retaguarda.AtivarAllTriggers;
      TThread.Synchronize(LoadSyncroniaRecebimento,
      procedure
      begin
        self.SB_Confirmar.Enabled := True;
        Pnl_Top.Enabled := True;
        self.chbx_setTimeTo.Checked := False;
      end);
      LoadSyncroniaRecebimento.Terminate;
    end
  );
  LoadSyncroniaRecebimento.FreeOnTerminate := True;
  LoadSyncroniaRecebimento.Start;
end;

procedure TTasSyncRetaguardaWeb.ValidaCNPJs1Click(Sender: TObject);
Var
  CnpjValidados : TThread;
begin
  CnpjValidados := TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(CnpjValidados,
      procedure
      begin
        Pnl_Top.Enabled := False;
        self.SB_Confirmar.Enabled := False;
        self.Lst_Process.Clear;
      end);
      self.Retaguarda.DesativarAllTriggers;
      Lst_Process.Items.Add('Ajustando CNPJs duplicados');
      //self.Retaguarda.ControlePDV.CNPJInvalidosParaConsusmidor;
      //self.Retaguarda.AtivarAllTriggers;
      TThread.Synchronize(CnpjValidados,
      procedure
      begin
        self.SB_Confirmar.Enabled := True;
        Pnl_Top.Enabled := True;
        self.chbx_setTimeTo.Checked := False;
      end);
      CnpjValidados.Terminate;
    end
  );
  CnpjValidados.FreeOnTerminate := True;
  CnpjValidados.Start;
end;

function TTasSyncRetaguardaWeb.ValidaProcessamento: Boolean;
begin
  Result := True;
  if Gb_Terminal = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não configuração de utilização de Retaguarda e '+EOLN+
                   'determinação do código de Terminal.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    Exit;
  end;

  if Pg_Principal.ActivePageIndex = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor escolha uma das abas Recebimentos ou Envio '+EOLN+
                   'A aba ativa determina que operação será executada.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    Exit;
  end;
end;

procedure TTasSyncRetaguardaWeb.Sb_ConfirmarClick(Sender: TObject);
Var
  Lc_Opcao : Integer;
begin
  if ValidaProcessamento then
  begin
    Try
      Lc_Opcao := Pg_Principal.ActivePageIndex;
      Pg_Principal.ActivePage := Tbs_Processamento;
      Lb_Processamento.Caption := 'Preprando o processamento - Aguarde.....';
      Sb_Confirmar.Enabled := False;
      Application.ProcessMessages;
      case Lc_Opcao of
        1:Recebimentos;
        2:Envios;
      end;
    Finally
      Sb_Confirmar.Enabled := True;
      Lb_Processamento.Caption := 'Processamento Finalizado';
      Application.ProcessMessages;
    End;
  end;
end;

end.




