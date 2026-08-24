unit Un_Lanca_Caixa;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Mask, StdCtrls, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls, ComCtrls, DB, STQuery, Menus, QEdit_Setes, Un_Fm_CentroCusto, Un_Fm_CentroResultado, Un_Fm_FormaPagto, ControllerMovimentoFinanceiro;

type
   TFr_Lanca_Caixa = class(TForm)
      Pg_Lanca_Banco: TPageControl;
    Panel8: TPanel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    E_Lancamento: TEdit_Setes;
    E_Historico: TEdit;
    E_Credito: TEdit_Setes;
    E_Debito: TEdit_Setes;
    Label6: TLabel;
    E_Dt_Caixa: TMaskEdit;
    Fm_CentroCusto: TFm_CentroCusto;
    Fm_CentroResultado: TFm_CentroResultado;
    Fm_FormaPagto: TFm_FormaPagto;
    pnl_bottom: TPanel;
    Lb_Qtty_Caracter: TLabel;
      procedure SB_GravarClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure SB_CancelarClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
    procedure E_CreditoExit(Sender: TObject);
    procedure E_DebitoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_HistoricoChange(Sender: TObject);
   private
    FHistorico: String;
    FValorCredito: Real;
    FOperacao: String;
    FFormaPagto: Integer;
    FPlanoResultado: Integer;
    FValorDebito: Real;
    FCodigo: Integer;

    FLiberaCampo: Boolean;
    FQuitacao: Integer;
    FMensagem: Boolean;
    FPlanoCentroCusto: Integer;
    FTitulo: String;

    { Private declarations }
      procedure Pc_AtivarTabelas;


    procedure setFCodigo(const Value: Integer);
    procedure setFFormaPagto(const Value: Integer);
    procedure setFHistorico(const Value: String);
    procedure setFLiberaCampo(const Value: Boolean);
    procedure setFMensagem(const Value: Boolean);
    procedure setFOperacao(const Value: String);
    procedure setFPlanoCentroCusto(const Value: Integer);
    procedure setFPlanoResultado(const Value: Integer);
    procedure setFQuitacao(const Value: Integer);
    procedure setFValorCredito(const Value: Real);
    procedure setFValorDebito(const Value: Real);
    procedure setFTitulo(const Value: String);
   public
    { Public declarations }
      Resultado: Boolean;
      //IT_cd_Quitacao : Integer;
      It_MostraTransferencia : Boolean;
      Movimento : TControllerMovimentoFinanceiro;
      procedure CriarVariaveis;
      procedure IniciaVariaveis;


      Function Fc_valida_Gravacao():boolean;
      procedure Gravar;
      procedure Pc_FormataTela;
      procedure Pc_ImagemBotao;
      PROCEDURE ShowDAta;
      procedure ShowNoData;
      procedure AutoFill;

      property Codigo : Integer read FCodigo write setFCodigo;
      property Quitacao : Integer read FQuitacao write setFQuitacao;
      property Titulo : String read FTitulo write setFTitulo;
      property Operacao : String read FOperacao write setFOperacao;
      property PlanoResultado : Integer read FPlanoResultado write setFPlanoResultado;
      property PlanoCentroCusto : Integer read FPlanoCentroCusto write setFPlanoCentroCusto;
      property Historico : String read FHistorico write setFHistorico;
      property ValorCredito : Real read FValorCredito write setFValorCredito;
      property ValorDebito : Real read FValorDebito write setFValorDebito;
      property FormaPagto : Integer read FFormaPagto write setFFormaPagto;
      property Mensagem : Boolean read FMensagem write setFMensagem;
      property LiberaCampo:Boolean read FLiberaCampo write setFLiberaCampo;

   end;

var
   Fr_Lanca_Caixa: TFr_Lanca_Caixa;

implementation

uses     Un_DM, sea_banking_account, Un_Msg, UN_Receber_Multipla, UN_Sistema, Un_Caixa, Un_Pagar_Multipla, UN_Flh_Pagto, Un_Lanca_PlanoContas, Un_Fc_Sored_Procedures, Un_Regra_Negocio, UN_Principal, env, RN_PlanoContas, RN_FormaPagto, RI_MovimentoFinanceiro;



{$R *.dfm}


PROCEDURE TFr_Lanca_Caixa.ShowData;
begin
  with Movimento do
  Begin
    getByID;
    if exist then
    Begin
      E_Dt_Caixa.Text                         := DateToStr(Registro.Data);
      Fm_CentroCusto.E_Codigo_Plano.Text      := Registro.PL_Debito.ToString;
      Fm_CentroCusto.DBLCB_Plano.KeyValue     := Registro.PL_Debito;
      Fm_CentroResultado.E_Codigo_Plano.Text  := Registro.PL_Credito.ToString;
      Fm_CentroResultado.DBLCB_Plano.KeyValue := Registro.PL_Credito;
      E_Historico.Text                        := Registro.Historico;
      Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := Registro.FormaPagto;

      E_Credito.Text                          := FloatToStrF(Registro.ValorCredito,ffFixed,10,2);
      E_Debito.Text                           := FloatToStrF(Registro.ValorDEbito,ffFixed, 10,2);

      IF (Registro.Quitacao = 0) and (Registro.Data = Gb_DataCaixa)  then
      Begin
        E_Credito.ReadOnly := False;
        E_Debito.ReadOnly := False;
      end
      else
      Begin
        E_Credito.ReadOnly := True;
        E_Debito.ReadOnly := True;
      end
    end;
  End;
end;


procedure TFr_Lanca_Caixa.ShowNoData;
begin

end;

procedure TFr_Lanca_Caixa.Pc_FormataTela;
Begin

end;

Function TFr_Lanca_Caixa.Fc_valida_Gravacao():boolean;
Begin
  Result := True;
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
end;



procedure TFr_Lanca_Caixa.SB_GravarClick(Sender: TObject);
begin
  if Fc_valida_Gravacao then
  Begin
    Gravar;
    Resultado := True;
    Close;
  end;
end;


procedure TFr_Lanca_Caixa.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TFr_Lanca_Caixa.setFFormaPagto(const Value: Integer);
begin
  FFormaPagto := Value;
end;

procedure TFr_Lanca_Caixa.setFHistorico(const Value: String);
begin
  FHistorico := Value;
end;

procedure TFr_Lanca_Caixa.setFLiberaCampo(const Value: Boolean);
begin
  FLiberaCampo := Value;
end;

procedure TFr_Lanca_Caixa.setFMensagem(const Value: Boolean);
begin
  FMensagem := Value;
end;

procedure TFr_Lanca_Caixa.setFOperacao(const Value: String);
begin
  FOperacao := Value;
end;

procedure TFr_Lanca_Caixa.setFPlanoCentroCusto(const Value: Integer);
begin
  FPlanoCentroCusto := Value;
end;

procedure TFr_Lanca_Caixa.setFPlanoResultado(const Value: Integer);
begin
  FPlanoResultado := Value;
end;

procedure TFr_Lanca_Caixa.setFQuitacao(const Value: Integer);
begin
  FQuitacao := Value;
end;

procedure TFr_Lanca_Caixa.setFTitulo(const Value: String);
begin
  FTitulo := Value;
end;

procedure TFr_Lanca_Caixa.setFValorCredito(const Value: Real);
begin
  FValorCredito := Value;
end;

procedure TFr_Lanca_Caixa.setFValorDebito(const Value: Real);
begin
  FValorDebito := Value;
end;

procedure TFr_Lanca_Caixa.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_F6: if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
      end;
    end;
end;

procedure TFr_Lanca_Caixa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Lanca_Caixa.FormCreate(Sender: TObject);
begin
  CriarVariaveis;
end;

procedure TFr_Lanca_Caixa.Pc_AtivarTabelas;
begin
  Fm_FormaPagto.Pc_Listar(0,False,0);
  Fm_CentroCusto.Pc_ListaParaUsar;
  Fm_CentroResultado.Pc_ListaParaUsar;
end;

procedure TFr_Lanca_Caixa.SB_CancelarClick(Sender: TObject);
begin
  Resultado := False;
  Close;
end;

procedure TFr_Lanca_Caixa.FormShow(Sender: TObject);
begin
  IniciaVariaveis;
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_AtivarTabelas;
end;

procedure TFr_Lanca_Caixa.Gravar;
begin
  with Movimento do
  Begin
    //Registro.Codigo            :=
    Registro.ContaCorrente     := 0;
    Registro.Data              := StrToDate(E_Dt_Caixa.Text);
    Registro.HistoricoBancario := 0;
    if (Fm_CentroResultado.DBLCB_Plano.Text <>'') then
      Registro.PL_Credito := Fm_CentroResultado.DBLCB_Plano.KeyValue
    else
      Registro.PL_Credito        := 0;

    if (Fm_CentroCusto.DBLCB_Plano.Text <> '') then
      Registro.PL_Debito         := Fm_CentroCusto.DBLCB_Plano.KeyValue
    else
      Registro.PL_Debito         := 0;

    Registro.ValorCredito      := StrToFloatDef(E_Credito.Text,0);
    Registro.ValorDebito       := StrToFloatDef(E_Debito.Text,0);
    Registro.Historico         := Copy(E_Historico.Text,1,100);
    if Registro.ValorCredito > 0 then
      Registro.Tipo              := 'C'
    else
      Registro.Tipo              := 'D';
    Registro.Quitacao          := FQuitacao;
    Registro.Usuario           := Gb_Cd_Usuario;
    Registro.Especie           := 'N';
    Registro.ValorFuturo       := 0;
    Registro.DataOriginal      := StrToDate(E_Dt_Caixa.Text);
    Registro.NrDocumento       := '';
    Registro.Conferido         := 'N';
    Registro.FormaPagto        := Fm_FormaPagto.DBLCB_formaPagto.KeyValue;
    Registro.Estabelecimento   := Gb_CodMha
  End;
  Movimento.salva;
end;

procedure TFr_Lanca_Caixa.IniciaVariaveis;
begin
  Resultado := False;
  if ( Movimento.Registro.Codigo > 0 ) then
    Showdata;
end;

procedure TFr_Lanca_Caixa.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;

procedure TFr_Lanca_Caixa.AutoFill;
begin
  Movimento.registro.codigo := FCodigo;
  if Trim(FTitulo) <>'' then
    Caption := FTitulo;
  E_Dt_Caixa.Text := DateToStr( Gb_DataCaixa );
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
  if Fm_FormaPagto.DBLCB_formaPagto.text <> '' then
    Self.FormaPagto := Fm_FormaPagto.DBLCB_formaPagto.KeyValue;
end;

procedure TFr_Lanca_Caixa.CriarVariaveis;
begin
  Movimento := TControllerMovimentoFinanceiro.Create(self);
end;

procedure TFr_Lanca_Caixa.E_CreditoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Credito.Text,0);
  E_Credito.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  if Lc_Valor > 0 then E_Debito.Text := '0,00';
end;

procedure TFr_Lanca_Caixa.E_DebitoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Debito.Text,0);
  E_Debito.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  if Lc_Valor > 0 then E_Credito.Text := '0,00';
end;

procedure TFr_Lanca_Caixa.E_HistoricoChange(Sender: TObject);
begin
  Lb_Qtty_Caracter.Caption := concat(  Length(E_Historico.Text).ToString(),' caracter(es)/100 Máx');
end;

end.


