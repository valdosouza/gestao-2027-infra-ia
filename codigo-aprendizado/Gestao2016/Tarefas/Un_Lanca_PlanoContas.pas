unit Un_Lanca_PlanoContas;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Mask, StdCtrls, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls, ComCtrls, DB, STQuery, Menus, Un_Fm_CentroResultado, Un_Fm_CentroCusto, un_base;

type
  TFr_Lanca_PlanoContas = class(TFr_Base)
    Panel8: TPanel;
    Lb_Instrucao: TLabel;
    Panel1: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Fm_CentroCusto: TFm_CentroCusto;
    Fm_CentroResultado: TFm_CentroResultado;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_CancelarClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
    Confirma : Boolean;
    CentroCusto, ContaResultado : Integer;

    function fc_Valida_Gravacao():boolean;
  end;

var
  Fr_Lanca_PlanoContas: TFr_Lanca_PlanoContas;

implementation

uses      Un_DM, UN_Receber_Multipla, UN_Sistema, Un_Msg, Un_Caixa, Un_Pagar_Multipla, UN_Flh_Pagto, un_receber_baixa_lote, RN_PlanoContas, env, sea_banking_account;

{$R *.dfm}

procedure TFr_Lanca_PlanoContas.FormataTela;
begin
  inherited;

end;

procedure TFr_Lanca_PlanoContas.FormCreate(Sender: TObject);
begin
  Confirma := False;
  Inherited;


end;

procedure TFr_Lanca_PlanoContas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6 : If SB_Cancelar.Enabled then SB_CancelarClick(Sender);
    end;
  end;
end;

procedure TFr_Lanca_PlanoContas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Lanca_PlanoContas.ImagemBotao;
begin
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(SB_Cancelar,'CANCELAR');
end;

procedure TFr_Lanca_PlanoContas.IniciaVariaveis;
begin
  inherited;
  Fm_CentroCusto.Pc_ListaParaUsar;
  Fm_CentroResultado.Pc_ListaParaUsar;
end;


procedure TFr_Lanca_PlanoContas.SB_CancelarClick(Sender: TObject);
begin
  confirma := False;
  Close;
end;

function TFr_Lanca_PlanoContas.fc_Valida_Gravacao():boolean;
Begin
  Result:=TRUE;
  CentroCusto := 0;
  ContaResultado := 0;
  if  Fm_CentroCusto.DBLCB_Plano.Text = '' then
  Begin
    MensagemPadrao(ATENCAO,
                   ' Campo Conta Débito não preenchido.' + EOLN +
                   ' Preencha o Plano de Conta Débito.' + EOLN,
                   ['OK'], [bEscape], mpErro);

    Result := False;
    Fm_CentroCusto.DBLCB_Plano.SetFocus;
    Exit;
  end;

  IF Fm_CentroCusto.Visible then
  Begin
    if Fm_CentroCusto.DBLCB_Plano.Text = '' then
    Begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' Campo Conta Crédito não preenchido.' + EOLN +
                     ' Preencha o Plano de Conta Crédito.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      Fm_CentroCusto.DBLCB_Plano.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFr_Lanca_PlanoContas.SB_GravarClick(Sender: TObject);
begin
  if fc_Valida_Gravacao then
  Begin
    Confirma := True;
    CentroCusto := Fm_CentroCusto.DBLCB_Plano.KeyValue;
    if Fm_CentroResultado.Visible then
      ContaResultado := Fm_CentroResultado.DBLCB_Plano.KeyValue;
    Close;
  end;
end;


end.
