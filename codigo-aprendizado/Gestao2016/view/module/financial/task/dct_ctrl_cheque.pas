unit dct_ctrl_cheque;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Un_Fm_ListaContaBancaria, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons, Vcl.ExtCtrls, ControllerCheque, Datasnap.DBClient;

type
  TDctCtrlCheque = class(TFr_Base)
    Panel1: TPanel;
    SB_Add_Tudo_Descontar: TSpeedButton;
    SB_Retirar_Tudo_Descontar: TSpeedButton;
    ChLBx_Descontar: TCheckListBox;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    pnl_bottom: TPanel;
    Sb_Sair: TSpeedButton;
    Sb_Descontar: TSpeedButton;
    procedure SB_Retirar_Tudo_DescontarClick(Sender: TObject);
    procedure SB_Add_Tudo_DescontarClick(Sender: TObject);
    procedure Sb_DescontarClick(Sender: TObject);
    procedure Sb_SairClick(Sender: TObject);
  private
    Cheque : TControllerCheque;
    FCcds_search: TClientDataSet;
    procedure EfetuarDesconto;
    function  RelacaoChequesDescontado():String;
    function  SomaChequesDescontado():Real;
    Function ValidaDescontarLote:Boolean;
    procedure DescontarLote;
    procedure setFcds_search(const Value: TClientDataSet);

  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
  public
    FListaCodigos: Array of array of String;
    FOK : Boolean;
    property cds_search: TClientDataSet read FCcds_search write setFcds_search;
  end;

var
  DctCtrlCheque: TDctCtrlCheque;

implementation

uses
      RN_Empresa, Un_Lanca_Caixa, Un_Lanca_Banco, Un_MSG, env, UN_Sistema, RI_MovimentoFinanceiro;

{$R *.dfm}

procedure TDctCtrlCheque.CriarVariaveis;
begin
  inherited;
  Cheque := TControllerCheque.create(self);
end;

procedure TDctCtrlCheque.DescontarLote;
Var
  Lc_I: Integer;
begin
  with cds_search do
  Begin
    First;
    SetLength(FListaCodigos,4,RecordCount);
    ChLBx_Descontar.Clear;
    For Lc_I := 0 to RecordCount - 1  do
    Begin
      ChLBx_Descontar.Items.Add(FieldByName('CHQ_NR_BANCO').AsString + ' - ' + FieldByName('CHQ_AGENCIA').AsString + ' - ' + FieldByName('CHQ_NUMERO').AsString + ' - ' + FieldByName('CHQ_EMITENTE').AsString);
      ChLBx_Descontar.Checked[Lc_I] := True;
      FListaCodigos[0,Lc_I] := '1';
      FListaCodigos[1,Lc_I] := FieldByName('CHQ_CODIGO').AsString;
      FListaCodigos[2,Lc_I] := FieldByName('CHQ_NUMERO').AsString;
      FListaCodigos[3,Lc_I] := FieldByName('CHQ_VALOR').AsString;
      cds_search.Next;
    end;
  end
end;

procedure TDctCtrlCheque.EfetuarDesconto;
Var
  Lc_Escolha : Integer;
  Lc_Cd_Empresa:Integer;
  Lc_Cxa_CentroCusto : integer;
  Lc_Cxa_ContaResultado : integer;
  Lc_Bco_CentroCusto : integer;
  Lc_Cbo_ContaResultado : integer;
  LC_I : Integer;
  Lc_Retorno :TRetornoDados;
  Lc_Cd_Quitacao : Integer;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
Begin
  MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                 'Esta transção executar� as seguintes operções de transfer�ncia.'+EOLN+
                 '1º - Informe o nome da Empresa com Sistema para factoring.'+EOLN+
                 '� - Retirar do caixa o valor correspondente.'+EOLN+
                 '3º - Lan�ar este mesmo valor em dinheiro em Caixa ou Banco.'+EOLN+
                 '4�- Lan�ar o custo financeiro desta operção.'+EOLN,
                ['OK'],[bEscape],mpErro);

  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    Lc_Cd_Empresa := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
  end;
  //Verifica se uma empresa foi selecionada
  if Lc_Cd_Empresa = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'A empresa não foi selecionada.'+EOLN+
                   'O processo será abortado.' + EOLN,
                   ['OK'],[bEscape],mpAlerta);
    exit;
  end;
  Lc_Cd_Quitacao := Fc_GeraCod_BAixa;
  //Retira o Valor do caixa
  if Fc_VErificaCaixaAberto(True) then
  Begin
    Try
      LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
      LfFormCaixa.Codigo           := 0;
      LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
      LfFormCaixa.Titulo          := 'Informe o Valor do cheque a ser retirado do Caixa';
      LfFormCaixa.Operacao         := 'I';
      LfFormCaixa.PlanoResultado   := 0;
      LfFormCaixa.PlanoCentroCusto := 0;
      LfFormCaixa.Historico        := 'DEBITO CH. DESC. N� '+ RelacaoChequesDescontado;
      LfFormCaixa.ValorCredito     := 0;
      LfFormCaixa.ValorDebito      := SomaChequesDescontado;
      LfFormCaixa.FormaPagto       := 0;
      LfFormCaixa.Mensagem         := True;
      LfFormCaixa.LiberaCampo      := False;
      LfFormCaixa.AutoFill;
      LfFormCaixa.ShowModal;
      FOK := LfFormCaixa.Resultado;
    Finally
      FreeAndNil(LfFormCaixa);
    End;
  End;
  if not FOK then exit;

  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Informe o local para lançamento do Valor.'+EOLN+EOLN+
                                'Informe a opção.',
                                ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_Escolha of
    0:Begin
        //Inclui o saldo obtido no caixa
        if Fc_VErificaCaixaAberto(True) then
        Begin
          Try
            LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
            LfFormCaixa.Codigo           := 0;
            LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
            LfFormCaixa.Titulo          := 'Informe o Valor de entrada referente a operção.';
            LfFormCaixa.Operacao         := 'I';
            LfFormCaixa.PlanoResultado   := 0;
            LfFormCaixa.PlanoCentroCusto := 0;
            LfFormCaixa.Historico        := 'CREDITO CH. DESC. N� '+ RelacaoChequesDescontado;
            LfFormCaixa.ValorCredito     := SomaChequesDescontado;
            LfFormCaixa.ValorDebito      := 0;
            LfFormCaixa.FormaPagto       := 0;
            LfFormCaixa.Mensagem         := True;
            LfFormCaixa.LiberaCampo      := False;
            LfFormCaixa.AutoFill;
            LfFormCaixa.ShowModal;
            FOK := LfFormCaixa.Resultado;
          Finally
            FreeAndNil(LfFormCaixa);
          End;
        End;
        if not FOK then exit;

        //Retira o Custo Financeiro da Transção
        if Fc_VErificaCaixaAberto(True) then
        Begin
          Try
            LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
            LfFormCaixa.Codigo           := 0;
            LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
            LfFormCaixa.Titulo          := 'Informe o Custo Financeiro da operção.';
            LfFormCaixa.Operacao         := 'I';
            LfFormCaixa.PlanoResultado   := 0;
            LfFormCaixa.PlanoCentroCusto := 0;
            LfFormCaixa.Historico        := 'TAXA DEBITO CH. DESC. N� '+ RelacaoChequesDescontado;
            LfFormCaixa.ValorCredito     := 0;
            LfFormCaixa.ValorDebito      := 1;
            LfFormCaixa.FormaPagto       := 0;
            LfFormCaixa.Mensagem         := True;
            LfFormCaixa.LiberaCampo      := False;
            LfFormCaixa.AutoFill;
            LfFormCaixa.ShowModal;
            FOK := LfFormCaixa.Resultado;
          Finally
            FreeAndNil(LfFormCaixa);
          End;
        End;
      end;
    1:BEgin
        //Efetua a deposito na Conta corrente
        Try
          LfFormBanco := TFr_Lanca_Banco.Create(nil);
          LfFormBanco.Codigo           := 0;
          LfFormBanco.Quitacao         := Lc_Cd_Quitacao;
          LfFormBanco.Data             := Date;
          LfFormBanco.ContaCorrente    := 0;
          LfFormBanco.Operacao         := 'I';
          LfFormBanco.PlanoResultado   := 0;
          LfFormBanco.PlanoCentroCusto := 0;
          LfFormBanco.Historico        := 'CREDITO CH. DESC. N� '+ RelacaoChequesDescontado;
          LfFormBanco.HistoricoBanco   := 0;
          LfFormBanco.ValorCredito     := SomaChequesDescontado;
          LfFormBanco.ValorDebito      := 0;
          LfFormBanco.FormaPagto       := 0;
          LfFormBanco.Mensagem         := True;
          LfFormBanco.LiberaCampo      := False;
          LfFormBanco.AutoFill;
          LfFormBanco.ShowModal;
          FOK := LfFormBanco.Resultado;
        Finally
          FreeAndNil(LfFormBanco);
        End;
        //Retira o Custo Financeiro da Transção
        Try
          LfFormBanco := TFr_Lanca_Banco.Create(nil);
          LfFormBanco.Codigo           := 0;
          LfFormBanco.Quitacao         := Lc_Cd_Quitacao;
          LfFormBanco.Caption          := 'Informe o Custo Financeiro da operção';
          LfFormBanco.Data             := Date;
          LfFormBanco.ContaCorrente    := 0;
          LfFormBanco.Operacao         := 'I';
          LfFormBanco.PlanoResultado   := 0;
          LfFormBanco.PlanoCentroCusto := 0;
          LfFormBanco.Historico        := 'DEBITO CH. DESC. N� '+ RelacaoChequesDescontado;
          LfFormBanco.HistoricoBanco   := 0;
          LfFormBanco.ValorCredito     := 0;
          LfFormBanco.ValorDebito      := 1;
          LfFormBanco.FormaPagto       := 0;
          LfFormBanco.Mensagem         := True;
          LfFormBanco.LiberaCampo      := False;
          LfFormBanco.AutoFill;
          LfFormBanco.ShowModal;
          FOK := LfFormBanco.Resultado;
        Finally
          FreeAndNil(LfFormBanco);
        End;
      end;
      else
        FOK := False;
  end;

  if FOK then
  Begin
    For LC_I := 0 to ChLBx_Descontar.Items.Count -1 do
    Begin
      if (FListaCodigos[0,Lc_I] = '1') then
      Begin
        with Cheque.Registro do
        Begin
          Codigo := StrToIntDef(FListaCodigos[1,Lc_I],0);
          Estado := 'D';
          QuitacaoPagamento := Lc_Cd_Quitacao;
          CodigoFornecedor := Lc_Cd_Empresa;
          CodigoEstabelecimento := Gb_CodMha;
        End;
        Cheque.Descontar;
      end;
    end;
    MensagemPadrao('Mensagem Sucesso','S U C E S S O!.'+EOLN+EOLN+
                   'Transção realizada com sucesso!'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
  End;
end;


procedure TDctCtrlCheque.FinalizaVariaveis;
begin
  FreeAndNil( Cheque );
  inherited;
end;

procedure TDctCtrlCheque.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Descontar,'FATURAR');
  CarregaImagemBotao(Sb_Sair,'SAIR');
end;

procedure TDctCtrlCheque.IniciaVariaveis;
begin
  inherited;
  Fm_ListaContaBancaria.Listar;
end;

function TDctCtrlCheque.RelacaoChequesDescontado: String;
Var
  Lc_I : Integer;
Begin
  Result := '';
  For LC_I:= 0 to ChLBx_Descontar.Items.Count - 1 do
  Begin
    if (Lc_I = 0) then
      Result := FListaCodigos[2,LC_I]
    else
      Result := Result + '|' + FListaCodigos[2,LC_I];
  end;
end;

procedure TDctCtrlCheque.SB_Add_Tudo_DescontarClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to ChLBx_Descontar.Items.Count -1 do
  Begin
    ChLBx_Descontar.Checked[Lc_I] := True;
    FListaCodigos[0,Lc_I] := '1';
  end;
end;

procedure TDctCtrlCheque.Sb_DescontarClick(Sender: TObject);
begin
  if ValidaDescontarLote then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja Realmente Descontar cheques selecionados?'+EOLN+EOLN+
                       'Confirmar a operção ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
      try
        Pc_ProcesoAguarde(Self,'I');
        Self.Enabled := False;
        EfetuarDesconto;
      finally
        Pc_ProcesoAguarde(Self,'F');
        Self.Enabled := True;
      end;
    end;
  end;
end;

procedure TDctCtrlCheque.SB_Retirar_Tudo_DescontarClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For LC_I := 0 to ChLBx_Descontar.Items.Count - 1  do
  Begin
    ChLBx_Descontar.Checked[Lc_I] := False;
    FListaCodigos[0,Lc_I] := '0';
  end;
end;

procedure TDctCtrlCheque.Sb_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TDctCtrlCheque.setFcds_search(const Value: TClientDataSet);
begin
  FCcds_search := Value;
end;

function TDctCtrlCheque.SomaChequesDescontado: Real;
Var
  Lc_I : Integer;
Begin
  Result := 0;
  For LC_I:= 0 to ChLBx_Descontar.Items.Count - 1 do
  Begin
    Result := Result + StrToFloatDef(FListaCodigos[3,LC_I],0);
  end;
end;

function TDctCtrlCheque.ValidaDescontarLote: Boolean;
Var
  Lc_I, Lc_J : Integer;
  Lc_Imp : Boolean;
begin
  Result := True;
  if Trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = '' then
    begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor Selecione uma Conta Bancária.'+EOLN+
                   'Impossivel Continuar!'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := false;
    exit;
    end;

  Lc_Imp := False;
  Lc_J := 0;
  For LC_I:= 0 to ChLBx_Descontar.Items.Count - 1 do
    Begin
    if (ChLBx_Descontar.Checked[Lc_I]) then
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
                   'Impossivel Continuar'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    exit;
    end;
end;

end.
