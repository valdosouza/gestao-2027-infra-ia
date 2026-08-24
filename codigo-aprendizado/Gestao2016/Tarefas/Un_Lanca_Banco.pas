unit Un_Lanca_Banco;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Mask, StdCtrls, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls, ComCtrls, DB, STQuery, Menus, QEdit_Setes, Un_Fm_CentroCusto, Un_Fm_CentroResultado, Un_Fm_ListaHistoricoBancario, Un_Fm_ListaContaBancaria, Un_Fm_FormaPagto, ControllerMovimentoFinanceiro;

type
  TFr_Lanca_Banco = class(TForm)
    Ds_ContaBancaria: TDataSource;
    Panel8: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    SB_Gravar: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    E_Lancamento: TEdit;
    E_Historico: TEdit;
    E_Credito: TEdit_Setes;
    E_Debito: TEdit_Setes;
    E_Dt_Original: TMaskEdit;
    E_Nr_Doc: TEdit;
    E_Data: TDateTimePicker;
    Fm_CentroCusto: TFm_CentroCusto;
    Fm_CentroResultado: TFm_CentroResultado;
    Fm_ListaHistoricoBancario: TFm_ListaHistoricoBancario;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    Fm_FormaPagto: TFm_FormaPagto;
    pnl_Bottom: TPanel;
    Lb_Qtty_Caracter: TLabel;
    procedure SB_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure E_CreditoExit(Sender: TObject);
    procedure E_DebitoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_HistoricoChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FHistoricoBanco: Integer;
    FHistorico: String;
    FValorCredito: Real;
    FOperacao: String;
    FFormaPagto: Integer;
    FPlanoResultado: Integer;
    FValorDebito: Real;
    FCodigo: Integer;
    FContaCorrente: Integer;

    FLiberaCampo: Boolean;
    FQuitacao: Integer;
    FMensagem: Boolean;
    FData: TDate;
    FPlanoCentroCusto: Integer;
    FTitulo: String;
    FForcarLancamento: Boolean;
    { Private declarations }
    procedure Pc_AtivarTabelas;

    procedure setFCodigo(const Value: Integer);
    procedure setFContaCorrente(const Value: Integer);
    procedure setFData(const Value: TDate);
    procedure setFFormaPagto(const Value: Integer);
    procedure setFHistorico(const Value: String);
    procedure setFHistoricoBanco(const Value: Integer);
    procedure setFLiberaCampo(const Value: Boolean);
    procedure setFMensagem(const Value: Boolean);
    procedure setFOperacao(const Value: String);
    procedure setFPlanoCentroCusto(const Value: Integer);
    procedure setFPlanoResultado(const Value: Integer);
    procedure setFQuitacao(const Value: Integer);
    procedure setFValorCredito(const Value: Real);
    procedure setFValorDebito(const Value: Real);
    procedure setFTitulo(const Value: String);
    procedure setFForcarLancamento(const Value: Boolean);

  public
    { Public declarations }
      Resultado : Boolean;
      Movimento : TControllerMovimentoFinanceiro;
      Function Fc_valida_Gravacao():boolean;
      procedure Gravar;
      procedure Pc_IniciaVariaveis;
      procedure Pc_PreencheTela;
      procedure Pc_FormataTela;
      procedure Pc_ImagemBotao;

      procedure AutoFill;

      property Codigo : Integer read FCodigo write setFCodigo;
      property Quitacao : Integer read FQuitacao write setFQuitacao;
      property ContaCorrente : Integer read FContaCorrente write setFContaCorrente;
      property Data : TDate read FData write setFData;
      property Titulo : String read FTitulo write setFTitulo;
      property Operacao : String read FOperacao write setFOperacao;
      property PlanoResultado : Integer read FPlanoResultado write setFPlanoResultado;
      property PlanoCentroCusto : Integer read FPlanoCentroCusto write setFPlanoCentroCusto;
      property Historico : String read FHistorico write setFHistorico;
      property HistoricoBanco : Integer read FHistoricoBanco write setFHistoricoBanco;
      property ValorCredito : Real read FValorCredito write setFValorCredito;
      property ValorDebito : Real read FValorDebito write setFValorDebito;
      property FormaPagto : Integer read FFormaPagto write setFFormaPagto;
      property Mensagem : Boolean read FMensagem write setFMensagem;
      property LiberaCampo:Boolean read FLiberaCampo write setFLiberaCampo;
      property ForcarLancamento : Boolean read FForcarLancamento write setFForcarLancamento;
  end;

var
  Fr_Lanca_Banco: TFr_Lanca_Banco;

implementation

uses      Un_DM, sea_banking_account, Un_Msg, UN_Receber_Multipla, UN_Sistema, Un_Pagar_Multipla, UN_Flh_Pagto, Un_Regra_Negocio, Un_Fc_Sored_Procedures, UN_Principal, env, RN_PlanoContas, RN_FormaPagto;

{$R *.dfm}

procedure TFr_Lanca_Banco.Pc_FormataTela;
Begin

end;

Function TFr_Lanca_Banco.Fc_valida_Gravacao():boolean;
Begin
  Result := True;
  if TRIM(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN+EOLN+
                   ' Campo Conta Bancária não informado.'+EOLN+
                   ' Preencha para continuar o Lançamento.'+EOLN,
                   [' OK'],[bEscape],mpErro);
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    Result:=False;
    Exit;
  end;

  if TRIM(E_Historico.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN+EOLN+
                   ' Campo histórico não informado.'+EOLN+
                   ' Preencha para continuar o Lançamento.'+EOLN,
                   [' OK'],[bEscape],mpErro);
    E_Historico.SetFocus;
    Result:=False;
    Exit;
  end;

  if Length(TRIM(E_Historico.Text)) > 99 then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN+EOLN+
                   ' Campo histórico com mais de 100 caracteres.'+EOLN+
                   ' Verifique antes de continuar.'+EOLN,
                   [' OK'],[bEscape],mpErro);
    E_Historico.SetFocus;
    Result:=False;
    Exit;
  end;

  if TRIM(Fm_FormaPagto.DBLCB_formaPagto.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN+EOLN+
                   ' Campo Forma de pagamento não informado.'+EOLN+
                   ' Preencha para continuar o Lançamento.'+EOLN,
                   [' OK'],[bEscape],mpErro);
    Fm_FormaPagto.DBLCB_formaPagto.SetFocus;
    Result:=False;
    Exit;
  end;

  if TRIM(Fm_ListaHistoricoBancario.DBLCB_Historico.Text) = '' then
    begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN+EOLN+
                   ' Campo histórico Lançamento não informado.'+EOLN+
                   ' Preencha para continuar o Lançamento.'+EOLN,
                   [' OK'],[bEscape],mpErro);
    Fm_ListaHistoricoBancario.DBLCB_Historico.SetFocus;
    Result:=False;
    Exit;
    end;

end;

procedure TFr_Lanca_Banco.SB_GravarClick(Sender: TObject);
begin
  if Fc_valida_Gravacao then
  Begin
    Gravar;
    Resultado := True;
    FForcarLancamento := False;
    Close;
  end;
end;

procedure TFr_Lanca_Banco.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TFr_Lanca_Banco.setFContaCorrente(const Value: Integer);
begin
  FContaCorrente := Value;
end;

procedure TFr_Lanca_Banco.setFData(const Value: TDate);
begin
  FData := Value;
end;

procedure TFr_Lanca_Banco.setFForcarLancamento(const Value: Boolean);
begin
  FForcarLancamento := Value;
end;

procedure TFr_Lanca_Banco.setFFormaPagto(const Value: Integer);
begin
  FFormaPagto := Value;
end;

procedure TFr_Lanca_Banco.setFHistorico(const Value: String);
begin
  FHistorico := Value;
end;

procedure TFr_Lanca_Banco.setFHistoricoBanco(const Value: Integer);
begin
  FHistoricoBanco := Value;
end;

procedure TFr_Lanca_Banco.setFLiberaCampo(const Value: Boolean);
begin
  FLiberaCampo := Value;
end;

procedure TFr_Lanca_Banco.setFMensagem(const Value: Boolean);
begin
  FMensagem := Value;
end;

procedure TFr_Lanca_Banco.setFOperacao(const Value: String);
begin
  FOperacao := Value;
end;

procedure TFr_Lanca_Banco.setFPlanoCentroCusto(const Value: Integer);
begin
  FPlanoCentroCusto := Value;
end;

procedure TFr_Lanca_Banco.setFPlanoResultado(const Value: Integer);
begin
  FPlanoResultado := Value;
end;

procedure TFr_Lanca_Banco.setFQuitacao(const Value: Integer);
begin
  FQuitacao := Value;
end;

procedure TFr_Lanca_Banco.setFTitulo(const Value: String);
begin
  FTitulo := Value;
end;

procedure TFr_Lanca_Banco.setFValorCredito(const Value: Real);
begin
  FValorCredito := Value;
end;

procedure TFr_Lanca_Banco.setFValorDebito(const Value: Real);
begin
  FValorDebito := Value;
end;

procedure TFr_Lanca_Banco.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Lanca_Banco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Lanca_Banco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
end;

procedure TFr_Lanca_Banco.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if FForcarLancamento then
  Begin
    MensagemPadrao(' Mensagem de Alerta', ATENCAO + EOLN+EOLN+
                   ' Não é possível cancelar está operação.'+EOLN+
                   ' Ela faz parte de um processo que deve ser Finalizado'+EOLN,
                   [' OK'],[bEscape],mpAlerta);
    CanClose := False;
  End
end;

procedure TFr_Lanca_Banco.FormCreate(Sender: TObject);
begin
  FForcarLancamento := False;
  Movimento := TControllerMovimentoFinanceiro.Create(Self);
end;

procedure TFr_Lanca_Banco.Pc_AtivarTabelas;
begin
  Fm_FormaPagto.Pc_Listar(1,False,0);
  Fm_ListaContaBancaria.Listar;
  Fm_CentroCusto.Pc_ListaParaUsar;
  Fm_CentroResultado.Pc_ListaParaUsar;
  Fm_ListaHistoricoBancario.AtivaLista;
end;

procedure TFr_Lanca_Banco.SB_CancelarClick(Sender: TObject);
begin
  Resultado := False;
  Close;
end;

procedure TFr_Lanca_Banco.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_IniciaVAriaveis;
  Pc_FormataTela;
  Pc_ImagemBotao;

end;

procedure TFr_Lanca_Banco.Gravar;
begin
  with Movimento do
  Begin
    //Registro.Codigo            :=
    Registro.ContaCorrente     := 0;
    Registro.Data              := E_Data.Date;
    REgistro.ContaCorrente     := Fm_ListaContaBancaria.DBLCB_ContaBancaria.Keyvalue;

    if (Fm_CentroResultado.DBLCB_Plano.Text <>'') then
      Movimento.Registro.PL_Credito := Fm_CentroResultado.DBLCB_Plano.KeyValue;

    if (Fm_CentroCusto.DBLCB_Plano.Text <> '') then
      Movimento.Registro.PL_Debito :=  Fm_CentroCusto.DBLCB_Plano.KeyValue;

    Registro.Historico         := Copy(E_Historico.Text,1,100);
    Registro.DataOriginal    := StrToDateDef(E_Dt_Original.Text,E_Data.Date);
    Registro.NrDocumento       := E_Nr_Doc.text;
    Registro.FormaPagto        := Fm_FormaPagto.DBLCB_formaPagto.KeyValue;
    Registro.HistoricoBancario := Fm_ListaHistoricoBancario.DBLCB_Historico.keyValue;

    if (Registro.Data >now) then
    Begin
      if (StrToFloatDef(E_Credito.Text,0) > 0) then
      Begin
        Movimento.Registro.ValorFuturo  := StrToFloatDef(E_Credito.Text,0);
        Registro.Tipo := 'C';
      End
      else
      Begin
        Registro.ValorFuturo  := StrToFloatDef(E_Debito.Text,0) * -1;
        Registro.Tipo := 'D';
      End;
      Registro.ValorDebito  := 0;
      Registro.ValorCredito  := 0;
    end
    else
    Begin
      Registro.ValorCredito :=StrToFloatDef(E_Credito.Text,0);
      Registro.ValorDebito  :=StrToFloatDef(E_Debito.Text,0);
      Registro.ValorFuturo  := 0;
      if Registro.ValorCredito > 0 then
        Registro.Tipo := 'C'
      else
        Registro.Tipo := 'D';
    end;
    Registro.Quitacao          := FQuitacao;
    Registro.Usuario           := Gb_Cd_Usuario;
    Registro.Especie           := 'N';
    Registro.Conferido         := 'N';
    Registro.Estabelecimento   := Gb_CodMha
  End;
  Movimento.salva;
end;

procedure TFr_Lanca_Banco.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;

procedure TFr_Lanca_Banco.Pc_PreencheTela;
begin
  Movimento.Registro.Codigo := FCodigo;
  Movimento.getByID;
  with Movimento do
  Begin
    if ( Movimento.exist ) then
    Begin
      FOperacao := 'E';
      E_Data.Date                                         := Registro.Data;
      Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue  := Registro.ContaCorrente;
      Fm_CentroCusto.E_Codigo_Plano.Text                  := Registro.PL_Debito.ToString;
      Fm_CentroCusto.DBLCB_Plano.KeyValue                 := Registro.PL_Debito;
      Fm_CentroResultado.E_Codigo_Plano.Text              := Registro.PL_Credito.ToString;
      Fm_CentroResultado.DBLCB_Plano.KeyValue             := Registro.PL_Credito;
      Fm_ListaHistoricoBancario.DBLCB_Historico.KeyValue  := Registro.HistoricoBancario;
      E_Historico.Text                                    := Registro.Historico;
      E_Dt_Original.Text                                  := DateToStr(Registro.DataOriginal);
      E_Nr_Doc.Text                                       := Registro.NrDocumento;
      Fm_FormaPagto.DBLCB_FormaPagto.KeyValue             := Registro.FormaPagto;
      if (Registro.ValorFuturo =0) then
      Begin
        E_Credito.Text := FloatToStrF(Registro.ValorCredito,ffFixed,10,2);
        E_Debito.Text := FloatToStrF(Registro.ValorDebito,ffFixed,10,2);
      end
      else
      Begin
        if (Registro.ValorFuturo >0) then
        Begin
          E_Credito.Text := FloatToStrF(Registro.ValorFuturo,ffFixed,10,2);
          E_Debito.Text := FloatToStrF(0,ffFixed,10,2);
        end
        else
        Begin
          E_Credito.Text := FloatToStrF(0,ffFixed,10,2);
          E_Debito.Text := FloatToStrF(Registro.ValorFuturo * -1,ffFixed,10,2);
        end;
      end;
      FQuitacao := Registro.Quitacao;
      IF (FQuitacao = 0) or (Fc_Tb_Geral('L','FIN_LIB_DIG_BANCO','N') = 'S') then
      Begin
        E_Credito.ReadOnly := False;
        E_Debito.ReadOnly := False;
      end
      else
      Begin
        E_Credito.ReadOnly := True;
        E_Debito.ReadOnly := True;
      end
    End;
  end;
end;


procedure TFr_Lanca_Banco.Pc_IniciaVariaveis;
Begin

  E_Data.Date := Date;
  Resultado := False;
  if FCodigo > 0 then
  Begin
    Pc_PreencheTela;
  end;
end;

procedure TFr_Lanca_Banco.AutoFill;
begin
  if Trim(FTitulo) <>'' then
    Caption := FTitulo;
  E_Data.Date := FData;
  Fm_CentroCusto.E_Codigo_Plano.Text := InttoStr(FPlanoCentroCusto);
  Fm_CentroCusto.DBLCB_Plano.KeyValue := FPlanoCentroCusto;
  Fm_CentroResultado.E_Codigo_Plano.Text := InttoStr(FPlanoResultado);
  Fm_CentroREsultado.DBLCB_Plano.KeyValue := FPlanoResultado;
  E_Historico.Text := FHistorico;
  if FValorCredito > 0 then
  Begin
    E_Credito.Text := FloatToStrF(FValorCredito,ffFixed,10,2);
    E_Debito.Text := '0,00';
  end
  else
  Begin
    E_Credito.Text := '0,00';
    E_Debito.Text := FloatToStrF(FValorDebito,ffFixed,10,2);
  end;
  Fm_FormaPagto.DBLCB_formaPagto.KeyValue := FFormaPagto;
  Fm_ListaHistoricoBancario.DBLCB_Historico.KeyValue := FHistoricoBanco;
  if LiberaCampo then
  Begin
    E_Credito.ReadOnly := False;
    E_Debito.ReadOnly := False;
  End
  else
  Begin
    E_Credito.ReadOnly := ( FQuitacao > 0) or not LiberaCampo;
    E_Debito.ReadOnly := ( FQuitacao > 0) or not LiberaCampo;
  End;
  //Grava caso a função precise de retorno
  if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <>'' then
    Self.ContaCorrente := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;
  if Fm_FormaPagto.DBLCB_formaPagto.text <> '' then
    Self.FormaPagto := Fm_FormaPagto.DBLCB_formaPagto.KeyValue;
end;

procedure TFr_Lanca_Banco.E_CreditoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Credito.Text,0);
  E_Credito.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  if Lc_Valor > 0 then E_Debito.Text := '0,00';
end;

procedure TFr_Lanca_Banco.E_DebitoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Debito.Text,0);
  E_Debito.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  if Lc_Valor > 0 then E_Credito.Text := '0,00';
end;

procedure TFr_Lanca_Banco.E_HistoricoChange(Sender: TObject);
begin
  Lb_Qtty_Caracter.Caption := concat(  Length(E_Historico.Text).ToString(),' caracter(es)/100 Máx');
end;

end.




