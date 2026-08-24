unit dpt_ctrl_cheque;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, ControllerCheque, Un_Fm_ListaContaBancaria, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient;

type
  TDptCtrlCheque = class(TFr_Base)
    pnl_fundo: TPanel;
    SB_Add_Tudo_Depositar: TSpeedButton;
    SB_Retirar_Tudo_Depositar: TSpeedButton;
    ChLBx_Depositar: TCheckListBox;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    pnl_bottom: TPanel;
    Sb_Sair: TSpeedButton;
    Sb_Depositar: TSpeedButton;
    procedure Sb_DepositarClick(Sender: TObject);
    procedure Sb_SairClick(Sender: TObject);
    procedure SB_Retirar_Tudo_DepositarClick(Sender: TObject);
    procedure SB_Add_Tudo_DepositarClick(Sender: TObject);
  private
    Cheque : TControllerCheque;
    FCcds_search: TClientDataSet;
    function ValidaDepositarLote:Boolean;
    procedure EfetuarDeposito;

    procedure DepositarLote;
    procedure setFcds_search(const Value: TClientDataSet);
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
  public
    { Public declarations }
    FListaCodigos: Array of array of String;
    property cds_search: TClientDataSet read FCcds_search write setFcds_search;
  end;

var
  DptCtrlCheque: TDptCtrlCheque;

implementation

{$R *.dfm}

uses     Un_Fc_Sored_Procedures, env, Un_DM, Un_Lanca_PlanoContas, Un_Sistema, RN_FormaPagto, Un_MSg;

procedure TDptCtrlCheque.CriarVariaveis;
begin
  inherited;
  Cheque := TControllerCheque.create(self);
end;

procedure TDptCtrlCheque.DepositarLote;
Var
  Lc_I: Integer;
begin
  with cds_search do
  Begin
    First;
    SetLength(FListaCodigos,2,RecordCount);
    ChLBx_Depositar.Clear;
    For Lc_I := 0 to RecordCount - 1  do
    Begin
      ChLBx_Depositar.Items.Add(FieldByName('CHQ_NR_BANCO').AsString + ' - ' + FieldByName('CHQ_AGENCIA').AsString + ' - ' + FieldByName('CHQ_NUMERO').AsString + ' - ' + FieldByName('CHQ_EMITENTE').AsString);
      ChLBx_Depositar.Checked[Lc_I] := True;
      FListaCodigos[0,Lc_I] := '1';
      FListaCodigos[1,Lc_I] := FieldByName('CHQ_CODIGO').AsString;
      Next;
    end;
  end;
end;

procedure TDptCtrlCheque.EfetuarDeposito;
Var
  Lc_I :Integer;
  Lc_Historico : String;
  Lc_ContaResultadoCaixa :Integer;
  Lc_CentroCustoCaixa :Integer;
  Lc_ContaResultadoBanco :Integer;
  Lc_CentroCustoBanco :Integer;
  Lc_Form : TFr_Lanca_PlanoContas;
  Lc_Cd_Banco : Integer;
  Lc_Cd_Quitacao : Integer;
  Cheque : TControllerCheque;
Begin
  Lc_ContaResultadoCaixa := 0;
  Lc_CentroCustoCaixa := 0;
  Lc_ContaResultadoBanco := 0;
  Lc_CentroCustoBanco := 0;
  Lc_Form := TFr_Lanca_PlanoContas.Create(nil);
  Lc_Form.Caption := 'Informe as contas Gerenciais para o Caixa';
  try
    Lc_Form.ShowModal;
  finally
    Lc_ContaResultadoCaixa := Lc_Form.CentroCusto;
    Lc_CentroCustoCaixa := Lc_Form.ContaResultado;
    FreeAndNil(Lc_Form);
  end;

  Lc_Form := TFr_Lanca_PlanoContas.Create(nil);
  Lc_Form.Caption := 'Informe as contas Gerenciais para o Banco';
  try
    Lc_Form.ShowModal;
  finally
    Lc_ContaResultadoBanco := Lc_Form.CentroCusto;
    Lc_CentroCustoBanco := Lc_Form.ContaResultado;
    FreeAndNil(Lc_Form);
  end;

  //Atualiza o status do cheque
  Lc_Cd_Banco := Fm_ListaContaBancaria.Qr_ContaBancaria.FieldByname('EMP_CODIGO').AsInteger;
  For Lc_I := 0 to ChLBx_Depositar.Items.Count -1 do
  Begin
    if FListaCodigos[0,Lc_I] = '1' then
    Begin
      //Seleciona o Cheque
      Cheque.Registro.CodigoEstabelecimento := Gb_CodMha;
      Cheque.Registro.Codigo := StrToIntDef(FListaCodigos[1,Lc_I],0);
      Cheque.getById;

      if ( Cheque.Registro.Data > Date) then
        Lc_Historico := 'CHEQUE CUSTODIADO Nº '+ Cheque.Registro.Numero
      else
        Lc_Historico := 'CHEQUE DEPOSITO Nº '+ Cheque.Registro.Numero;

      Lc_Cd_Quitacao := Fc_GeraCod_BAixa;

      Pc_Movim_Financeiro(DM.IB_Transacao,
                          'I',
                          0,
                          0,
                          Gb_DataCaixa,
                          0,
                          Lc_ContaResultadoCaixa,
                          Lc_CentroCustoCaixa,
                          0,
                          Cheque.Registro.valor,
                          Lc_Historico,
                          'D',
                          Lc_cd_Quitacao,
                          Gb_Cd_Usuario,
                          0,
                          Cheque.Registro.Data,
                          '',
                          'N',
                          'S',
                          Gb_CodMha,
                          Fc_PegaFormaPgto('CHEQUE'));

      Pc_Movim_Financeiro(DM.IB_Transacao,
                          'I',
                          0,
                          Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue,
                          Cheque.Registro.Data,
                          1,
                          Lc_ContaResultadoBanco,
                          Lc_CentroCustoBanco,
                          Cheque.Registro.Valor,
                          0,
                          Lc_Historico,
                          'C',
                          Lc_cd_Quitacao,
                          Gb_Cd_Usuario,
                          0,
                          Cheque.Registro.Data,
                          '',
                          'N',
                          'N',
                          Gb_CodMha,
                          Fc_PegaFormaPgto('CHEQUE'));

      Cheque.Registro.Estado := 'B';
      Cheque.Registro.CodigoFornecedor := Lc_Cd_Banco;
      Cheque.Registro.QuitacaoPagamento := Lc_cd_Quitacao;
      Cheque.Deposito;

      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.commit;
      MensagemPadrao('Mensagem Sucesso','S U C E S S O!.'+EOLN+EOLN+
                     'Transção realizada com sucesso!'+EOLN,
                     ['OK'],[bEscape],mpInformacao);
    end;
  end;
end;

procedure TDptCtrlCheque.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil( Cheque );
end;

procedure TDptCtrlCheque.ImagemBotao;
begin
  CarregaImagemBotao(Sb_Depositar,'FATURAR');
  CarregaImagemBotao(Sb_Sair,'SAIR');
end;

procedure TDptCtrlCheque.IniciaVariaveis;
begin
  inherited;
  Fm_ListaContaBancaria.Listar;
end;

procedure TDptCtrlCheque.SB_Add_Tudo_DepositarClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to ChLBx_Depositar.Items.Count -1 do
  Begin
    ChLBx_Depositar.Checked[Lc_I] := True;
    FListaCodigos[0,Lc_I] := '1';
  end;
end;

procedure TDptCtrlCheque.Sb_DepositarClick(Sender: TObject);
begin
  if ValidaDepositarLote then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja Realmente Depositar os cheques selecionados?'+EOLN+EOLN+
                       'Confirmar a operção ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
      EfetuarDeposito;
    end;
  end;
end;

procedure TDptCtrlCheque.SB_Retirar_Tudo_DepositarClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to ChLBx_Depositar.Items.Count - 1  do
  Begin
    ChLBx_Depositar.Checked[Lc_I] := False;
    FListaCodigos[0,Lc_I] := '0';
  end;
end;

procedure TDptCtrlCheque.Sb_SairClick(Sender: TObject);
begin
  Close;
end;


procedure TDptCtrlCheque.setFcds_search(const Value: TClientDataSet);
begin
  FCcds_search := Value;
end;

function TDptCtrlCheque.ValidaDepositarLote: Boolean;
Var
  Lc_I, Lc_J : Integer;
  Lc_Imp : Boolean;
begin
  Result := True;
  if Trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
           'Por favor Selecione uma Conta Bancária.'+EOLN+
           'Impossivel Baixar!'+EOLN,
          ['OK'],[bEscape],mpAlerta);
    Result := false;
    exit;
  end;

  Lc_Imp := False;
  Lc_J := 0;
  For LC_I:= 0 to ChLBx_Depositar.Items.Count - 1 do
  Begin
    if (ChLBx_Depositar.Checked[Lc_I]) then
      Begin
      Lc_Imp := true;
      FListaCodigos[0,LC_I] := '1';
      end
    else
      FListaCodigos[0,LC_I] := '0';
  end;

  if not Lc_Imp then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor selecione um cheque.'+EOLN+
                   'Impossivel gerar Custódia'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    exit;
  end;

end;

end.
