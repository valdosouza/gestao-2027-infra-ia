unit reg_ctrl_cheque;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, STQuery, ControllerCheque, ControllerNotaFiscal, ControllerFinanceiro;

type
  TRegCtrlCheque = class(TBaseRegistry)
    SB_Baixar: TSpeedButton;
    L_Emitente: TLabel;
    L_banco: TLabel;
    L_Agencia: TLabel;
    L_Cheque: TLabel;
    L_Valor: TLabel;
    L_Vl_Amor: TLabel;
    L_Quitado: TLabel;
    L_Codigo: TLabel;
    L_PreDatado: TLabel;
    L_Devolvido: TLabel;
    L_Qt_Rec: TLabel;
    L_Qt_Pag: TLabel;
    L_Conta: TLabel;
    E_Emitente: TEdit;
    E_Banco: TEdit;
    E_Agencia: TEdit;
    E_Cheque: TEdit;
    E_Valor: TEdit;
    E_Codigo: TEdit;
    Rg_TipoCheque: TRadioGroup;
    E_Vl_Amor: TEdit;
    E_Qt_Rec: TEdit;
    E_Qt_Pag: TEdit;
    E_Quitado: TMaskEdit;
    E_PreDatado: TDateTimePicker;
    E_Devolvido: TEdit;
    E_Conta: TEdit;
    DBG_ChqOrigem: TDBGrid;
    Dbg_ChqDestino: TDBGrid;
    Qr_Origem: TSTQuery;
    Qr_OrigemPED_NUMERO: TIntegerField;
    Qr_OrigemNFL_NUMERO: TStringField;
    Qr_OrigemFIN_NR_PARCELA: TIntegerField;
    Qr_OrigemEMP_NOME: TStringField;
    Qr_OrigemEMP_CODIGO: TIntegerField;
    Qr_OrigemPED_CODIGO: TIntegerField;
    Qr_Destino: TSTQuery;
    Qr_DestinoFIN_NUMERO: TStringField;
    Qr_DestinoNFL_NUMERO: TStringField;
    Qr_DestinoFIN_NR_PARCELA: TIntegerField;
    Qr_DestinoEMP_NOME: TStringField;
    Qr_DestinoEMP_CODIGO: TIntegerField;
    Ds_Origem: TDataSource;
    Ds_Destino: TDataSource;
    VincularOrigemdoCheque1: TMenuItem;
    VincularDestinodoCheque1: TMenuItem;
    LanarValordoChequenoCaixa1: TMenuItem;
    procedure SB_BaixarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Dbg_ChqDestinoDblClick(Sender: TObject);
    procedure DBG_ChqOrigemDblClick(Sender: TObject);
    procedure VincularOrigemdoCheque1Click(Sender: TObject);
    procedure VincularDestinodoCheque1Click(Sender: TObject);
    procedure LanarValordoChequenoCaixa1Click(Sender: TObject);
  private
    FDpLotes : Boolean;
    FOK : Boolean;
    FNota : TControllerNotaFiscal;
    FFinanceiro : TControllerFinanceiro;
    Function VerificaExisteRegistro():Boolean;
    function ValidaVinculoOrigem():Boolean;
    function ValidaVinculoDestino():Boolean;
    function ValidaLancaCaixa():Boolean;

    procedure Deposito;
    procedure Descontar;
    procedure Retornar;
    procedure ChequeDevolvido;
    procedure ChequeResgatado;
    procedure AbrirOrigem;
    procedure AbrirDestino;
    procedure Gera_NotaFiscal;
    procedure GeraFinanceiro;


  protected
    procedure setPerfil;Override;
    procedure ImagemBotao;Override;
    procedure ClearAllFields;Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
    procedure EditionControl;Override;
  public
    FValorPago : Real;
    Cheque : TControllerCheque;
  end;

var
  RegCtrlCheque: TRegCtrlCheque;

implementation

{$R *.dfm}

uses     Un_Funcoes, env, un_msg, un_sistema, Un_Baixa_Cheques, Un_DM, RI_MovimentoFinanceiro, Un_Lanca_Caixa, Un_Lanca_Banco, RN_FormaPagto, Un_Fornecedor, Un_Cliente, RN_Empresa,
  Un_Fc_Sored_Procedures, ControllerContaBancaria;
procedure TRegCtrlCheque.AbrirDestino;
begin
  Qr_Destino.Active := False;
  Qr_Destino.ParamByName('CHQ_QT_PAG').AsInteger := Cheque.Registro.QuitacaoPagamento;
  Qr_Destino.Active := True;
end;

procedure TRegCtrlCheque.AbrirOrigem;
begin
  Qr_Origem.Active := False;
  Qr_Origem.ParamByName('CHQ_QT_REC').AsInteger := Cheque.Registro.QuitacaoRecebimento;
  Qr_Origem.Active := True;
end;

procedure TRegCtrlCheque.Change;
begin
  inherited;
  Rg_TipoCheque.SetFocus;
end;

procedure TRegCtrlCheque.ChequeDevolvido;
Var
  Lc_Escolha: Integer;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
begin
  //vERIFICA SE O cLIETNE DE ORIGEM EXISTE
  Qr_Origem.Active := True;
  Qr_Origem.FetchAll;
  Qr_Origem.First;
  IF (Qr_Origem.RecordCount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Verifique a Origem do Cheque.' + EOLN +
                   'Informe o cliente de origem antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    exit;
  end;

  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Informe como este cheque será pago:'+EOLN+
                                'Retirar do caixa ou '+EOLN+
                                'Lançamento banc?rio por devolução da Conta Corrente.'+EOLN,
                                ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_Escolha of
    0:Begin // Faz a retirada do pagamento do cheque pelo Caixa
        if Fc_VErificaCaixaAberto(True) then
        Begin
          LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
          LfFormCaixa.Codigo           := 0;
          LfFormCaixa.Quitacao         := 0;
          LfFormCaixa.Titulo            := 'Lançamentos no caixa da Folha de Pagamento';
          LfFormCaixa.Operacao         := 'I';
          LfFormCaixa.PlanoResultado   := 0;
          LfFormCaixa.PlanoCentroCusto := 0;
          LfFormCaixa.Historico        := 'PAGTO CHEQUE DEVOLVIDO N? '+ Cheque.Registro.Numero;
          LfFormCaixa.ValorCredito     := 0;
          LfFormCaixa.ValorDebito      := Cheque.Registro.Valor;
          LfFormCaixa.FormaPagto       := Fc_PegaParteFormaPgto('DINHEIRO');
          LfFormCaixa.Mensagem         := True;
          LfFormCaixa.LiberaCampo      := False;
          LfFormCaixa.AutoFill;
          Try
            LfFormCaixa.ShowModal;
            FOK := LfFormCaixa.Resultado;
          Finally
            FreeAndNil(LfFormCaixa);
          End;
        End;
        if not FOK then exit;
      end;
    1:Begin //Faz O Lancamento em Banco por Devolução de cheque em Conta Corrente
        LfFormBanco := TFr_Lanca_Banco.Create(nil);
        LfFormBanco.Codigo           := 0;
        LfFormBanco.Quitacao         := 0;
        LfFormBanco.Data             := Date;
        LfFormBanco.ContaCorrente    := 0;
        LfFormBanco.Operacao         := 'I';
        LfFormBanco.PlanoResultado   := 0;
        LfFormBanco.PlanoCentroCusto := 0;
        LfFormBanco.Historico        := 'CHEQUE DEVOLVIDO N? '+  Cheque.Registro.Numero;
        LfFormBanco.HistoricoBanco   := 0;
        LfFormBanco.ValorCredito     := 0;
        LfFormBanco.ValorDebito      := Cheque.Registro.Valor;
        LfFormBanco.FormaPagto       := Fc_PegaParteFormaPgto('DINHEIRO');
        LfFormBanco.Mensagem         := True;
        LfFormBanco.LiberaCampo      := False;
        LfFormBanco.AutoFill;
        Try
          LfFormBanco.ShowModal;
          FOK := LfFormBanco.Resultado;
        Finally
          FreeAndNil(LfFormBanco);
        End;
        if not FOK then exit;
      end;
    else
      exit;
  end;

  Gera_NotaFiscal;
  GeraFinanceiro;

  //Atualiza o status do cheque
  if FOK then
  Begin
    Cheque.Registro.Devolvido := 'S';
    Cheque.update;
    MensagemPadrao('Mensagem Sucesso','S U C E S S O!.'+EOLN+EOLN+
                   'Transção realizada com sucesso!'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
  end;
end;

procedure TRegCtrlCheque.ChequeResgatado;
Var
  Lc_Escolha: Integer;
  Lc_Devolvido : String;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
begin
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Informe como este cheque será quitado.'+EOLN+
                                'Entrada de valor pelo caixa ou .'+EOLN+
                                'Deposito Bancario em Conta Corrente.'+EOLN,
                                ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));

  case Lc_Escolha of
    0:Begin // Faz a retirada do pagamento do cheque pelo Caixa
        if Fc_VErificaCaixaAberto(True) then
        Begin
          LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
          LfFormCaixa.Codigo           := 0;
          LfFormCaixa.Quitacao         := 0;
          LfFormCaixa.Caption          := '';
          LfFormCaixa.Operacao         := 'I';
          LfFormCaixa.PlanoResultado   := 0;
          LfFormCaixa.PlanoCentroCusto := 0;
          LfFormCaixa.Historico        := 'RECEBIMENTO CHEQUE DEVOLVIDO N? '+ Cheque.Registro.Numero;
          LfFormCaixa.ValorCredito     := Cheque.Registro.Valor - Cheque.Registro.ValorAmortizado;
          LfFormCaixa.ValorDebito      := 0;
          LfFormCaixa.FormaPagto       := 0;
          LfFormCaixa.Mensagem         := True;
          LfFormCaixa.LiberaCampo      := False;
          LfFormCaixa.AutoFill;
          Try
            LfFormCaixa.ShowModal;
            FOK := LfFormCaixa.Resultado;
          Finally
            FreeAndNil(LfFormCaixa);
          End;
        End;
        if not FOK then exit;
      end;
    1:Begin //Faz O Lancamento em Banco por Devolução de cheque em Conta Corrente
        LfFormBanco := TFr_Lanca_Banco.Create(nil);
        LfFormBanco.Codigo           := 0;
        LfFormBanco.Quitacao         := 0;
        LfFormBanco.Caption          := '';
        LfFormBanco.Data             := Date;
        LfFormBanco.ContaCorrente    := 0;
        LfFormBanco.Operacao         := 'I';
        LfFormBanco.PlanoResultado   := 0;
        LfFormBanco.PlanoCentroCusto := 0;
        LfFormBanco.Historico        := 'RECEBIMENTO CHEQUE DEVOLVIDO N? '+ Cheque.Registro.Numero;
        LfFormBanco.HistoricoBanco   := 0;
        LfFormBanco.ValorCredito     := Cheque.Registro.Valor - Cheque.Registro.ValorAmortizado;
        LfFormBanco.ValorDebito      := 0;
        LfFormBanco.FormaPagto       := 0;
        LfFormBanco.Mensagem         := True;
        LfFormBanco.LiberaCampo      := False;
        LfFormBanco.AutoFill;
        Try
          LfFormBanco.ShowModal;
          FOK := LfFormBanco.Resultado;
        Finally
          FreeAndNil(LfFormBanco);
        End;
      end;
    else
      exit;
  end;
  if (Cheque.Registro.ValorAmortizado + FValorPago ) >= Cheque.Registro.Valor then Lc_Devolvido := 'N' ELSE Lc_Devolvido := 'S';

  //Atualiza o status do cheque
  if FOK then
  Begin
    Cheque.Registro.Devolvido := Lc_Devolvido;
    Cheque.Registro.DataQuitacao := Date;
    Cheque.Registro.ValorAmortizado := Cheque.Registro.ValorAmortizado + FValorPago;
    Cheque.Resgate;

    MensagemPadrao('Mensagem Sucesso','S U C E S S O!.'+EOLN+EOLN+
                 'Transção realizada com sucesso!'+EOLN,
                 ['OK'],[bEscape],mpInformacao);

  end;
end;

procedure TRegCtrlCheque.ClearAllFields;
begin
  inherited;

end;

procedure TRegCtrlCheque.CriarVariaveis;
begin
  inherited;
  Cheque := TControllerCheque.create(self);
  FNota := TControllerNotaFiscal.create(self);
  FFinanceiro := TControllerFinanceiro.create(self);
end;

procedure TRegCtrlCheque.Dbg_ChqDestinoDblClick(Sender: TObject);
Var
  Lc_Form : TFr_Fornecedor;
begin
  if (Qr_Destino.FieldByName('EMP_CODIGO').AsInteger>0) then
  Begin
    Lc_Form := TFr_Fornecedor.Create(Self);
    Lc_Form.Empresa.Registro.Codigo := Qr_Destino.FieldByName('EMP_CODIGO').AsInteger;
    try
      Lc_Form.ShowModal;
      FOK := True;
    finally
      FreeAndNil(Lc_Form);
    end;
  end;
end;

procedure TRegCtrlCheque.DBG_ChqOrigemDblClick(Sender: TObject);
Var
  Lc_Form : TFr_Cliente;
begin
  if (Qr_Origem.FieldByName('EMP_CODIGO').AsInteger > 0) then
  Begin
    Lc_Form := TFr_Cliente.Create(Self);
    Try
      Lc_Form.Empresa.Registro.Codigo := Qr_Origem.FieldByName('EMP_CODIGO').AsInteger;
      Lc_Form.ShowModal;
      FOK := True;
    Finally
      FreeAndNil(Lc_Form);
    End;
  End;
end;

procedure TRegCtrlCheque.Delete;
begin
  Cheque.delete;
end;

procedure TRegCtrlCheque.Deposito;
Var
  Lc_Cd_FormaPagto : Integer;
  Lc_cd_Banco : Integer;
  Lc_cd_Conta : Integer;
  Lc_cd_Quitacao : Integer;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
  LcConta : TControllerContaBancaria;
begin
  MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                 'Esta transção executar? as seguintes operções de transfer?ncia.'+EOLN+
                 '1º - Retirar do caixa o valor correspondente.'+EOLN+
                 '? - Lan?ar este mesmo valor em conta corrente informada.'+EOLN,
                ['OK'],[bEscape],mpErro);
  //Define forma de pagmento
  Lc_Cd_FormaPagto := Fc_PegaFormaPgto('CHEQUE');
  Lc_cd_Quitacao := Fc_GeraCod_BAixa;
  Lc_cd_Banco := Lc_cd_Banco;
  if Fc_VErificaCaixaAberto(True) then
  Begin
    LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
    LfFormCaixa.Codigo           := 0;
    LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
    LfFormCaixa.Caption          := '';
    LfFormCaixa.Operacao         := 'I';
    LfFormCaixa.PlanoResultado   := 0;
    LfFormCaixa.PlanoCentroCusto := 0;
    LfFormCaixa.Historico        := 'CHEQUE DEPOSITADO N? '+ Cheque.Registro.Numero;
    LfFormCaixa.ValorCredito     := 0;
    LfFormCaixa.ValorDebito      := Cheque.Registro.Valor;
    LfFormCaixa.FormaPagto       := Lc_Cd_FormaPagto;
    LfFormCaixa.Mensagem         := True;
    LfFormCaixa.LiberaCampo      := False;
    LfFormCaixa.AutoFill;
    Try
      LfFormCaixa.ShowModal;
      FOK := LfFormCaixa.Resultado;
    Finally
      FreeAndNil(LfFormCaixa);
    End;
  End;
  if not FOK then exit;

  //Efetua a deposito na Conta corrente
  Lc_cd_Conta := 0;
  LfFormBanco := TFr_Lanca_Banco.Create(nil);
  LfFormBanco.Codigo           := 0;
  LfFormBanco.Quitacao         := Lc_cd_Quitacao;
  LfFormBanco.Caption          := '';
  LfFormBanco.Data             := Date;
  LfFormBanco.ContaCorrente    := Lc_cd_Conta;
  LfFormBanco.Operacao         := 'I';
  LfFormBanco.PlanoResultado   := 0;
  LfFormBanco.PlanoCentroCusto := 0;
  LfFormBanco.Historico        := 'CHEQUE DEPOSITADO N? '+ Cheque.Registro.Numero;
  LfFormBanco.HistoricoBanco   := 0;
  LfFormBanco.ValorCredito     := Cheque.Registro.Valor;
  LfFormBanco.ValorDebito      := 0;
  LfFormBanco.FormaPagto       := Lc_Cd_FormaPagto;
  LfFormBanco.Mensagem         := True;
  LfFormBanco.LiberaCampo      := False;
  LfFormBanco.AutoFill;
  Try
    LfFormBanco.ShowModal;
    FOK := LfFormBanco.Resultado;
  Finally
    if FOK then
    Begin
      try
        LcConta := TControllerContaBancaria.Create(nil);
        LcConta.Registro.Codigo := LfFormBanco.Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;
        LcConta.getById;
        Lc_cd_Banco := LcConta.Registro.CodigoBanco;
      finally
        FreeAndNil( LcConta );
      end;
    End;
    FreeAndNil(LfFormBanco);
  End;
  //Atualiza o status do cheque
  if FOK then
  Begin
    Cheque.Registro.Estado := 'B';
    Cheque.Registro.QuitacaoPagamento := Lc_cd_Quitacao;
    Cheque.Registro.CodigoFornecedor := Lc_cd_Banco;
    Cheque.Deposito;
    MensagemPadrao('Mensagem Sucesso','S U C E S S O!.'+EOLN+EOLN+
                   'Transção realizada com sucesso!'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    AbrirDestino;
  end;
end;

procedure TRegCtrlCheque.Descontar;
Var
  Lc_Escolha : Integer;
  Lc_Cd_Empresa:Integer;
  Lc_Cxa_Credito : integer;
  Lc_Cxa_Debito : integer;
  Lc_Bco_Credito : integer;
  Lc_Bco_Debito : integer;
  Lc_Retorno : TRetornoDados;
  Lc_Cd_Quitacao : Integer;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
begin
  MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                 'Esta transção executar? as seguintes operções de transfer?ncia.'+EOLN+
                 '1º - Informe o nome da Empresa com Sistema para factoring.'+EOLN+
                 '? - Retirar do caixa o valor correspondente.'+EOLN+
                 '3º - Lan?ar este mesmo valor em dinheiro em Caixa ou Banco.'+EOLN+
                 '4º - Lan?ar o custo financeiro desta operção.'+EOLN,
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
    LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
    LfFormCaixa.Codigo           := 0;
    LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
    LfFormCaixa.Caption          := 'Informe o Valor do cheque a ser retirado do Caixa';
    LfFormCaixa.Operacao         := 'I';
    LfFormCaixa.PlanoResultado   := Lc_Cxa_Credito;
    LfFormCaixa.PlanoCentroCusto := Lc_Cxa_Debito;
    LfFormCaixa.Historico        := 'CHEQUE DEPOSITADO N? '+ Cheque.Registro.Numero;
    LfFormCaixa.ValorCredito     := 0;
    LfFormCaixa.ValorDebito      := Cheque.Registro.Valor;
    LfFormCaixa.FormaPagto       := 0;
    LfFormCaixa.Mensagem         := True;
    LfFormCaixa.LiberaCampo      := False;
    LfFormCaixa.AutoFill;
    Try
      LfFormCaixa.ShowModal;
    Finally
      FOK := LfFormCaixa.Resultado;
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
          LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
          LfFormCaixa.Codigo           := 0;
          LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
          LfFormCaixa.Titulo          := 'Informe o Valor de entrada referente a operção.';
          LfFormCaixa.Operacao         := 'I';
          LfFormCaixa.PlanoResultado   := Lc_Cxa_Credito;
          LfFormCaixa.PlanoCentroCusto := Lc_Cxa_Debito;
          LfFormCaixa.Historico        := 'CREDITO CH. DESC. N? '+ Cheque.Registro.Numero;
          LfFormCaixa.ValorCredito     := Cheque.Registro.Valor;
          LfFormCaixa.ValorDebito      := 0;
          LfFormCaixa.FormaPagto       := 0;
          LfFormCaixa.Mensagem         := True;
          LfFormCaixa.LiberaCampo      := False;
          LfFormCaixa.AutoFill;
          Try
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
          LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
          LfFormCaixa.Codigo           := 0;
          LfFormCaixa.Quitacao         := Lc_cd_Quitacao;
          LfFormCaixa.Titulo          := 'Informe o Custo Financeiro da operção.';
          LfFormCaixa.Operacao         := 'I';
          LfFormCaixa.PlanoResultado   := Lc_Cxa_Credito;
          LfFormCaixa.PlanoCentroCusto := Lc_Cxa_Debito;
          LfFormCaixa.Historico        := 'TAXA DEBITO CH. DESC. N? '+ Cheque.Registro.Numero;
          LfFormCaixa.ValorCredito     := 0;
          LfFormCaixa.ValorDebito      := Cheque.Registro.Valor;
          LfFormCaixa.FormaPagto       := 0;
          LfFormCaixa.Mensagem         := True;
          LfFormCaixa.LiberaCampo      := True;
          LfFormCaixa.AutoFill;
          Try
            LfFormCaixa.ShowModal;
            FOK := LfFormCaixa.Resultado;
          Finally
            FreeAndNil(LfFormCaixa);
          End;
        End;
        if not FOK then exit;
      end;
    1:BEgin
        //Efetua a deposito na Conta corrente
        LfFormBanco := TFr_Lanca_Banco.Create(nil);
        LfFormBanco.Codigo           := 0;
        LfFormBanco.Quitacao         := Lc_cd_Quitacao;
        LfFormBanco.Data             := Date;
        LfFormBanco.ContaCorrente    := 0;
        LfFormBanco.Operacao         := 'I';
        LfFormBanco.PlanoResultado   := 0;
        LfFormBanco.PlanoCentroCusto := 0;
        LfFormBanco.Historico        := 'CREDITO CH. DESC. N? '+ Cheque.Registro.Numero;
        LfFormBanco.HistoricoBanco   := 0;
        LfFormBanco.ValorCredito     := Cheque.Registro.Valor;
        LfFormBanco.ValorDebito      := 0;
        LfFormBanco.FormaPagto       := 0;
        LfFormBanco.Mensagem         := True;
        LfFormBanco.LiberaCampo      := false;
        LfFormBanco.AutoFill;
        Try
          LfFormBanco.ShowModal;
          FOK := LfFormBanco.Resultado;
        Finally
          FreeAndNil(LfFormBanco);
        End;

        //Retira o Custo Financeiro da Transção
        LfFormBanco := TFr_Lanca_Banco.Create(nil);
        LfFormBanco.Codigo           := 0;
        LfFormBanco.Quitacao         := Lc_cd_Quitacao;
        LfFormBanco.Caption          := 'Informe o Custo Financeiro da operção.';
        LfFormBanco.Data             := Date;
        LfFormBanco.ContaCorrente    := 0;
        LfFormBanco.Operacao         := 'I';
        LfFormBanco.PlanoResultado   := 0;
        LfFormBanco.PlanoCentroCusto := 0;
        LfFormBanco.Historico        := 'DEBITO CH. DESC. N? '+ Cheque.Registro.Numero;
        LfFormBanco.HistoricoBanco   := 0;
        LfFormBanco.ValorCredito     := 0;
        LfFormBanco.ValorDebito      := 0;
        LfFormBanco.FormaPagto       := 0;
        LfFormBanco.Mensagem         := True;
        LfFormBanco.LiberaCampo      := True;
        LfFormBanco.AutoFill;
        Try
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
    Cheque.Registro.Estado := 'D';
    Cheque.Registro.QuitacaoPagamento :=  Lc_Cd_Quitacao;
    Cheque.Registro.CodigoFornecedor := Lc_Cd_Empresa;
    Cheque.Descontar;

    MensagemPadrao('Mensagem Sucesso','S U C E S S O!.'+EOLN+EOLN+
                   'Transção realizada com sucesso!'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    AbrirDestino;
  end;
end;

procedure TRegCtrlCheque.EditionControl;
begin
  inherited;
  SB_Baixar.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 )
end;

procedure TRegCtrlCheque.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil( Cheque );
  FreeAndNil( FNota );
  FreeAndNil( FFinanceiro );
end;

procedure TRegCtrlCheque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if shift = [] then
  begin
     if SB_Baixar.Enabled then SB_BaixarClick(Sender);
  end;
end;

procedure TRegCtrlCheque.GeraFinanceiro;
Begin
  with FFinanceiro.Registro do
  Begin
    Codigo              := 0;
    CodigoEmpresa       := Qr_OrigemEMP_CODIGO.AsInteger;
    DataFinanceiro      := Cheque.Registro.Data;
    CodigoPedido        := 0;
    CodigoNota          := fNota.Registro.Codigo;
    FormaPagamento      := Fc_PegaFormaPgto('CHEQUE');
    PrazoPagamento      := '';
    DataVencimento      := Cheque.Registro.Data;
    NumeroDuplicata     := concat('CHQ', Cheque.Registro.Numero);
    ValorParcela        := Cheque.Registro.Valor;
    NumeroParcela       := 1;
    ValorJuros          := 0;
    ValorMora           := 0;
    ValorDesconto       := 0;
    ValorPago           := 0;
    DocumentoBaixado    := 'N';
    TipoFinanceiro      := 'RA';
    SituacaoFinanceiro  := 'N';
    CodigoQuitacao      := 0;
    OperacaoFinanceiro  := 'C';
    EtapaFinaceiro      := 'N';
    Estabelecimento     := Gb_CodMha;
    CodigoCheque        := Cheque.Registro.Codigo;
  End;
  FFinanceiro.insere;
end;

procedure TRegCtrlCheque.Gera_NotaFiscal;
begin
  WITH FNota.Registro DO
  Begin
    Codigo                := 0;
    CodigoEstabelecimento := Gb_CodMha;
    Tipo                  :=  'EM';
    Finalidade            := '1';

    Numero                := concat('CDEV',Cheque.Registro.Numero);
    Serie                 := '1';
    CodigoCFOP            := 0;
    CodigoPedido          := 0;
    CodigoEmpresa         :=  Qr_OrigemEMP_CODIGO.AsInteger;
    DataEmissao           := E_PreDatado.Date;
    DataSaida             := E_PreDatado.Date;
    HoraSaida             := Now;
    ValorNota             := Cheque.Registro.Valor;
    ContaFrete            := 0;
    ControlaRetorno       := 'N';
    Situacao              := 'F';
    CFOP                  :=  '';
    Modelo                := '00';
  End;
  FNota.insere;
  Pc_Observacao(DM.IB_Transacao,
                'I',
                0,
                0,
                FNota.Registro.codigo,
                'M',
                concat(
                  'EMITENTE : ', Cheque.Registro.EMITENTE,EOLN,
                  'BANCO : ', Cheque.Registro.Numero, ' - AG: ', Cheque.Registro.Agencia,EOLN,
                  'VALOR CHEQUE : ', FloatToStrF(Cheque.Registro.Valor,ffNumber,10,2 ),EOLN,
                  'PEDIDO: ',Qr_OrigemPED_NUMERO.AsString
                ));
end;

procedure TRegCtrlCheque.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(SB_Baixar,'FATURAR');
end;

procedure TRegCtrlCheque.IniciaVariaveis;
begin
  pfMenu := 'Controle de Cheques';
  if Self.CodigoRegistro > 0 then
  Begin
    Cheque.Registro.Codigo := Self.CodigoRegistro;
    Cheque.Registro.CodigoEstabelecimento := Gb_CodMha;
    Cheque.getbyId;
  End;
  inherited;
end;

procedure TRegCtrlCheque.Insert;
begin
  inherited;
  Rg_TipoCheque.SetFocus;
  E_Devolvido.Text := NAO;
  E_PreDatado.Date :=Now;
end;

procedure TRegCtrlCheque.LanarValordoChequenoCaixa1Click(Sender: TObject);
Var
  LfFormCaixa : TFr_Lanca_Caixa;
begin
  if ValidaLancaCaixa then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Voc? está prestes a lan?ar um valor do cheque no caixa.'+EOLN+
                       'Antes de continuar tenha certeza de que este valor não foi lançado anteriormente.'+EOLN+
                       'Confirmar a operção ?',
                       [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      if Fc_VErificaCaixaAberto(True) then
      Begin
        LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
        LfFormCaixa.Codigo           := 0;
        LfFormCaixa.Quitacao         := Cheque.Registro.QuitacaoRecebimento;
        LfFormCaixa.Titulo         := '';
        LfFormCaixa.Operacao         := 'I';
        LfFormCaixa.PlanoResultado   := 0;
        LfFormCaixa.PlanoCentroCusto := 0;
        LfFormCaixa.Historico        := 'LANC. CHQ N? ' + Cheque.Registro.Numero;
        LfFormCaixa.ValorCredito     := Cheque.Registro.Valor;
        LfFormCaixa.ValorDebito      := 0;
        LfFormCaixa.FormaPagto       := Fc_PegaFormaPgto('CHEQUE');
        LfFormCaixa.Mensagem         := True;
        LfFormCaixa.LiberaCampo      := False;
        LfFormCaixa.AutoFill;
        Try
          LfFormCaixa.ShowModal;
        Finally
          FreeAndNil(LfFormCaixa);
        End;
      End;
    End;
  End;

end;

procedure TRegCtrlCheque.Retornar;
Var
  Lc_Escolha, Lc_I : Integer;
  Lc_StrDupl : String;
  Lc_Cxa_Credito : Integer;
  Lc_Cxa_Debito : Integer;
  Lc_Bco_Credito : Integer;
  Lc_Bco_Debito : Integer;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
begin
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Retornar o cheque N? '+ Cheque.Registro.numero +' do Desconto efetuado.'+EOLN+EOLN+
                                'Confirmar o Retorno ?',
                                [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace));
  if Lc_Escolha = 0 then
  Begin
    Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                  'Informe o local para lançamento do Valor.'+EOLN+EOLN+
                                  'Informe a opção.',
                                  ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    Cheque.Registro.Estado := 'N';
    Cheque.Registro.QuitacaoPagamento := 0;
    Cheque.Registro.CodigoFornecedor := 0;
    Cheque.UpdateEstado;
    case Lc_Escolha of
      0:Begin
          //Inclui o saldo obtido no caixa
          if Fc_VErificaCaixaAberto(True) then
          Begin
            LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
            LfFormCaixa.Codigo           := 0;
            LfFormCaixa.Quitacao         := 0;
            LfFormCaixa.Titulo         := 'Informe o Valor de entrada referente a operção.';
            LfFormCaixa.Operacao         := 'I';
            LfFormCaixa.PlanoResultado   := 0;
            LfFormCaixa.PlanoCentroCusto := 0;
            LfFormCaixa.Historico        := 'CREDITO CH. DESC. N? '+ Cheque.Registro.Numero;
            LfFormCaixa.ValorCredito     := Cheque.Registro.Valor;
            LfFormCaixa.ValorDebito      := 0;
            LfFormCaixa.FormaPagto       := 0;
            LfFormCaixa.Mensagem         := True;
            LfFormCaixa.LiberaCampo      := False;
            LfFormCaixa.AutoFill;
            Try
              LfFormCaixa.ShowModal;
              FOK := LfFormCaixa.Resultado;
            Finally
              FreeAndNil(LfFormCaixa);
            End;
          End;
          if not FOK then exit;
        end;
      1:BEgin
          //Efetua a deposito na Conta corrente
          LfFormBanco := TFr_Lanca_Banco.Create(nil);
          LfFormBanco.Codigo           := 0;
          LfFormBanco.Quitacao         := 0;
          LfFormBanco.Data             := Date;
          LfFormBanco.ContaCorrente    := 0;
          LfFormBanco.Operacao         := 'I';
          LfFormBanco.PlanoResultado   := 0;
          LfFormBanco.PlanoCentroCusto := 0;
          LfFormBanco.Historico        := 'CREDITO CH. DESC. N? '+ Cheque.Registro.Numero;
          LfFormBanco.HistoricoBanco   := 0;
          LfFormBanco.ValorCredito     := 0;
          LfFormBanco.ValorDebito      := Cheque.Registro.Valor;
          LfFormBanco.FormaPagto       := 0;
          LfFormBanco.Mensagem         := True;
          LfFormBanco.LiberaCampo      := False;
          LfFormBanco.AutoFill;
          Try
            LfFormBanco.ShowModal;
            FOK := LfFormBanco.Resultado;
          Finally
            FreeAndNil(LfFormBanco);
          End;
        end;
      else
        FOK := False;
      end;
    MensagemPadrao('Mensagem Sucesso','S U C E S S O!.'+EOLN+EOLN+
                   'Transção realizada com sucesso!'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
  End;
end;

procedure TRegCtrlCheque.Save;
begin
  with Cheque do
  Begin
    IF Rg_TipoCheque.ItemIndex = 0 then
      Registro.Tipo := 'P'
    else
      Registro.Tipo := 'T';
    Registro.Data                 := E_PreDatado.DateTime;
    Registro.Emitente             := E_Emitente.Text;
    Registro.NumeroBanco          := StrToInt(E_Banco.Text) ;
    Registro.Agencia              := E_Agencia.Text;
    Registro.ContaCorrente        := E_Conta.Text ;
    Registro.Numero               := E_Cheque.Text;
    Registro.Valor := StrToFloatDEf(E_Valor.Text,0);
    if ( E_Devolvido.Text = SIM ) then
      Registro.Devolvido    := 'S'
    else
      Registro.Devolvido    := 'N';
    Registro.ValorAmortizado      := StrtoFloatDef(E_Vl_Amor.Text,0);
    Registro.DataQuitacao         := StrToDate(E_Quitado.Text);
    Registro.QuitacaoRecebimento  := StrToIntDef(E_Qt_Rec.Text,0);
    Registro.QuitacaoPagamento    := StrToIntDef(E_Qt_Pag.Text,0);
  End;
end;

procedure TRegCtrlCheque.SB_BaixarClick(Sender: TObject);
Var
  Lc_Form : TFr_Baixa_Cheques;
  Lc_Escolha : Integer;
begin
  Lc_Form := TFr_Baixa_Cheques.create(self);
  try
    Lc_Form.ShowModal;
  finally
    Lc_Escolha := Lc_Form.Escolha;
    FreeAndNil( Lc_Form );
  end;

  case Lc_Escolha of
    0:Begin
        if (Cheque.Registro.Estado = 'N') then
        Begin
          Deposito;
        End
        else
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este cheque não pode ser depositado.'+EOLN+
                         'Consta resgistro de transção com este registro.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          exit;
        end;
      end;

    1:Begin
        if ( Cheque.Registro.Estado = 'N') then
        Begin
          Descontar;
        End
        else
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este cheque não pode ser descontado.'+EOLN+
                         'Consta resgistro de transção com este registro.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          exit;
        end;
      end;

    2:Begin
        if ( Cheque.Registro.Estado = 'D') then
          Retornar
      else
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este cheque não pode ser retornado.'+EOLN+
                         'Não consta nos registro uma transção que possibilite a operção.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          exit;
        end;
      end;

    3:Begin
        if Cheque.Registro.Devolvido = 'N' then
        Begin
          ChequeDevolvido;
        end
        else
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         'Este cheque não pode ser Devolvido.'+EOLN+
                         'Pelo registro esta operção já foi executada.'+EOLN,
                        ['OK'],[bEscape],mpErro);
          exit;
        end;
      end;
  end;
end;

procedure TRegCtrlCheque.setPerfil;
begin
  inherited;
  if Gb_Nivel = 1 then
  begin
    FDpLotes    := True;
  end
  else
  begin
    FDpLotes    := Fc_HabilitaPermissao(pfMenu,'DEPOSITO LOTE','S');
  end;
end;

procedure TRegCtrlCheque.ShowData;
begin
  with Cheque do
  Begin
    E_Codigo.Text := Registro.Codigo.ToString();
    IF Registro.Tipo = 'T' then
      Rg_TipoCheque.ItemIndex := 1
    else
      Rg_TipoCheque.ItemIndex := 0;
    E_PreDatado.DateTime := Registro.Data;
    E_Emitente.Text := Registro.Emitente;
    E_Banco.Text := StrZero(Registro.NumeroBanco,3,0);
    E_Agencia.Text := Registro.Agencia;
    E_Conta.Text := Registro.ContaCorrente;
    E_Cheque.Text := Registro.Numero;
    E_Valor.Text := FloatToStrF(Registro.Valor,ffFixed,10,2);
    IF Registro.Devolvido = 'S' then
      E_Devolvido.Text := SIM
    else
      E_Devolvido.Text := NAO;
    E_Vl_Amor.Text := FloatToStrF(Registro.ValorAmortizado,ffFixed,10,2);
    E_Quitado.Text := DateToStr(Registro.DataQuitacao);
    E_Qt_Rec.Text := Registro.QuitacaoRecebimento.ToString();
    E_Qt_Pag.Text := Registro.QuitacaoPagamento.ToString();

    AbrirOrigem;

    AbrirDestino;
  End;
  inherited;
end;

procedure TRegCtrlCheque.ShowNoData;
begin
  inherited;
  Qr_Origem.Active := False;
  Qr_Destino.Active := False;
end;

function TRegCtrlCheque.ValidaLancaCaixa: Boolean;
begin
  Result := True;
  if not VerificaExisteRegistro then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegCtrlCheque.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir '+ Cheque.Registro.Emitente +' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    Result := False;
    Exit;
  end;
end;

function TRegCtrlCheque.ValidateSave: boolean;
begin
  Result := True;
  if Trim(E_Emitente.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Emitente não preenchido.'+EOLN+
                   'Preencha antes de continuar!'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    E_Emitente.SetFocus;
    E_Emitente.SelectAll;
    exit;
  end;

  if Trim(E_Banco.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Banco não preenchido.'+EOLN+
                   'Preencha antes de continuar!'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    E_Banco.SetFocus;
    E_Banco.SelectAll;
    exit;
  end;

 if Trim(E_Agencia.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Agência não preenchido.'+EOLN+
                   'Preencha antes de continuar!'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    E_Agencia.SetFocus;
    E_Agencia.SelectAll;
    exit;
  end;

 if Trim(E_Cheque.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Cheque não preenchido.'+EOLN+
                   'Preencha antes de continuar!'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    E_Cheque.SetFocus;
    E_Cheque.SelectAll;
    exit;
  end;

 if StrToFloatDef(E_Valor.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Valor do Cheque não preenchido.'+EOLN+
                   'Preencha antes de continuar!'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := false;
    E_Valor.SetFocus;
    E_Valor.SelectAll;
    exit;
  end;
end;

function TRegCtrlCheque.ValidaVinculoDestino: Boolean;
begin
  REsult := True;
  if not VerificaExisteRegistro then
  Begin
    REsult := False;
    exit;
  End;

end;

function TRegCtrlCheque.ValidaVinculoOrigem: Boolean;
begin
  REsult := True;
  if not VerificaExisteRegistro then
  Begin
    REsult := False;
    exit;
  End;

end;

function TRegCtrlCheque.VerificaExisteRegistro: Boolean;
begin
  REsult := True;
  if (not Cheque.exist) then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Registro de cheque não encontrado.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;

end;

procedure TRegCtrlCheque.VincularDestinodoCheque1Click(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
  Lc_Cd_Empresa : Integer;
begin
  if ValidaVinculoDestino then
  BEgin
    Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
    if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
    begin
      Lc_Cd_Empresa := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
    end;
    if Lc_Cd_Empresa > 0 then
    Begin
      Cheque.registro.QuitacaoPagamento := cheque.getLastCodigoQuitacao(lc_Cd_Empresa);
      Cheque.registro.CodigoFornecedor := lc_Cd_Empresa;
      Cheque.update;
    end;
  end;
end;

procedure TRegCtrlCheque.VincularOrigemdoCheque1Click(Sender: TObject);
Var
  Lc_Cd_Empresa : Integer;
  Lc_Retorno :TRetornoDados;
begin
  if ValidaVinculoOrigem then
  Begin
    Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
    if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
    begin
      Lc_Cd_Empresa := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
    end;
    if Lc_Cd_Empresa > 0 then
    Begin
      Cheque.registro.QuitacaoPagamento := cheque.getLastCodigoQuitacao(lc_Cd_Empresa);
      Cheque.registro.CodigoFornecedor := lc_Cd_Empresa;
      Cheque.update;
    end;
  end;

end;

end.
