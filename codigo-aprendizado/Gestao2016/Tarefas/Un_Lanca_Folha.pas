unit Un_Lanca_Folha;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, DBCtrls, Mask, Buttons, ExtCtrls, DB, QEdit_Setes, DateUtils, Un_Fm_ListaColaboradores, STDataSet, ControllerFolhaPagto;

type
  TFr_Lanca_Folha = class(TForm)
    Ds_Colaborador: TDataSource;
    Panel1: TPanel;
    Label6: TLabel;
    Label8: TLabel;
    Label14: TLabel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Label15: TLabel;
    Lb_Vencimento: TLabel;
    Label10: TLabel;
    E_Hist_Folha: TEdit;
    E_Ano: TEdit;
    UpD_Ano: TUpDown;
    E_Credito: TEdit_Setes;
    E_Debito: TEdit_Setes;
    CB_Mes: TComboBox;
    E_DataLanc: TDateTimePicker;
    Fm_ListaColaborador: TFm_ListaColaboradores;
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure E_CreditoExit(Sender: TObject);
    procedure E_DebitoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FolhaPagto : TControllerFolhaPagto;
    function VAlidaGravacao:Boolean;
  public
    { Public declarations }
      Codigo : Integer;
      procedure Inicia_variaveis;
      procedure LimpaCampos;
      procedure preencheCampos;
      procedure Pc_LancaCaixaBanco;
      procedure ImprimeRecibo;
      procedure Gravar;
  end;

var
  Fr_Lanca_Folha: TFr_Lanca_Folha;

implementation

uses     Un_DM, UN_MSG, Un_Comissao, Un_Funcoes, UN_Flh_Pagto, UN_Sistema, reg_receipt, Un_Regra_Negocio, Un_Principal, env, Un_Lanca_Banco, Un_Lanca_Caixa, RI_MovimentoFinanceiro;

{$R *.dfm}

procedure TFr_Lanca_Folha.Pc_LancaCaixaBanco;
Var
  Lc_Escolha, Lc_I : Integer;
  Lc_StrPAgto : String;
  Lc_valor : Real;
  LfFormCaixa : TFr_Lanca_Caixa;
  LfFormBanco : TFr_Lanca_Banco;
begin
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                'Baixar as Folha do Mês Selecionado.'+EOLN+EOLN+
                                'Confirmar a Baixa ?',
                                ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  try
    Lc_valor := StrToFloatDef(E_Debito.Text, 0);
    case Lc_Escolha of
      0:Begin
          if Fc_VErificaCaixaAberto(True) then
          Begin
            Try
              LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
              LfFormCaixa.Codigo           := 0;
              LfFormCaixa.Quitacao         := 0;
              LfFormCaixa.Titulo          := 'Lançamentos no caixa da Folha de Pagamento';
              LfFormCaixa.Operacao         := 'I';
              LfFormCaixa.PlanoResultado   := 0;
              LfFormCaixa.PlanoCentroCusto := 0;
              LfFormCaixa.Historico        := Copy(E_Hist_Folha.Text,1,99);
              LfFormCaixa.ValorCredito     := 0;
              LfFormCaixa.ValorDebito      := Lc_valor;
              LfFormCaixa.FormaPagto       := 0;
              LfFormCaixa.Mensagem         := True;
              LfFormCaixa.LiberaCampo      := False;
              LfFormCaixa.AutoFill;
              LfFormCaixa.ShowModal;
            Finally
              FreeAndNil(LfFormCaixa);
            End;
          End;
        end;
      1:Begin
          Try
            LfFormBanco := TFr_Lanca_Banco.Create(nil);
            LfFormBanco.Codigo           := 0;
            LfFormBanco.Quitacao         := 0;
            LfFormBanco.Caption          := 'Lançamentos no caixa da Folha de Pagamento';
            LfFormBanco.Data             := Date;
            LfFormBanco.ContaCorrente    := 0;
            LfFormBanco.Operacao         := 'I';
            LfFormBanco.PlanoResultado   := 0;
            LfFormBanco.PlanoCentroCusto := 0;
            LfFormBanco.Historico        := Copy(E_Hist_Folha.Text,1,99);
            LfFormBanco.HistoricoBanco   := 0;
            LfFormBanco.ValorCredito     := 0;
            LfFormBanco.ValorDebito      := Lc_valor;
            LfFormBanco.FormaPagto       := 0;
            LfFormBanco.Mensagem         := True;
            LfFormBanco.LiberaCampo      := False;
            LfFormBanco.AutoFill;
            LfFormBanco.ShowModal;
          Finally
            FreeAndNil(LfFormBanco);
          End;
        end
      else
        Exit;
    end;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a Baixa dos Lançamentos.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Lanca_Folha.Inicia_variaveis;
Begin
  FolhaPagto := TControllerFolhaPagto.Create(Self);
  LimpaCampos;
  Fm_ListaColaborador.ListaColaborador;
  E_DataLanc.Date := StrToDateDef(Fc_Aq_Geral('L','LANCAFOLHA','DATA',DateToStr(E_DataLanc.Date)),Date);
  CB_Mes.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','LANCAFOLHA','MES',IntToStr(MonthOf(Date))),MonthOf(Date));
  E_Ano.Text := Fc_Aq_Geral('L','LANCAFOLHA','ANO',IntToStr(YearOf(Date)));

  FolhaPagto.Registro.Codigo := Codigo;
  FolhaPagto.getbyId;
  If FolhaPagto.exist then
  Begin
    preencheCampos;
  End;
end;

procedure TFr_Lanca_Folha.LimpaCampos;
Begin
  E_DataLanc.DateTime := Date;
  CB_Mes.ItemIndex := 0;
  E_Ano.Text := '2017';
  Fm_ListaColaborador.Dblcb_Vendedor.KeyValue := Null;
  E_Hist_Folha.clear;
  E_Credito.Text := '0,00';
  E_Debito.Text := '0,00';
End;

procedure TFr_Lanca_Folha.preencheCampos;
Begin
  with FolhaPagto do
  Begin
    Fm_ListaColaborador.Dblcb_Vendedor.KeyValue := Registro.Colaborador;
    E_DataLanc.Date   := Registro.Data;
    CB_Mes.ItemIndex  := Registro.Mes;
    E_Ano.Text        := Registro.Ano.ToString;
    E_Hist_Folha.Text := Registro.Historico;
    E_Credito.Text    := FloatToStrF(Registro.Credito,ffFixed,10,2);
    E_Debito.Text     := FloatToStrF(Registro.Debito,ffFixed,10,2);
  End;
End;

procedure TFr_Lanca_Folha.ImprimeRecibo;
Var
  Form : TRegReceipt;
Begin
  Pc_AtivaEstabelecimento;
  Form := TRegReceipt.create(nil);
  TRy
    Form.Recibo.Registro.Valor := StrToFloatDef(E_Debito.Text,0);
    Form.Recibo.Registro.Emitente := Fm_ListaColaborador.Dblcb_Vendedor.Text;
    Form.Recibo.Registro.Sacado := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
    Form.Recibo.Registro.Referencia := E_Hist_Folha.Text;
    Form.Recibo.Registro.Data := E_DataLanc.Date;
    Form.autofill := True;
    Form.ShowModal;
  Finally
    FreeAndNil(Form)
  End;

End;

procedure TFr_Lanca_Folha.SB_GravarClick(Sender: TObject);
Var
Lc_I : Integer;
begin
  if VAlidaGravacao then
  Begin
    Gravar;
    if (StrToFloatDef(E_Debito.Text,0) >0 )then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                          'Deseja imprimir um Recibo.' + EOLN + EOLN +
                          'Confirmar a impressão ?',
                          [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
      BEgin
         ImprimeRecibo;
      End;
      Pc_LancaCaixaBanco;
    End;

    Fc_Aq_Geral('G','LANCAFOLHA','DATA',DateToStr(E_DataLanc.Date));
    Fc_Aq_Geral('G','LANCAFOLHA','MES',IntToStr(CB_Mes.ItemIndex));
    Fc_Aq_Geral('G','LANCAFOLHA','ANO',E_Ano.Text);
    Self.Close;
  End;
end;

function TFr_Lanca_Folha.VAlidaGravacao: Boolean;
begin
  Result := True;
  if not (E_Credito.Visible) then
  Begin
    if StrToFloatDef(E_Debito.Text,0) = 0 then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'O Campo desconto deve ser maior que Zero.' + EOLN +
                     'Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    End;
  End;
end;

procedure TFr_Lanca_Folha.Gravar;
Begin
  with FolhaPagto do
  Begin
    Registro.Colaborador     := Fm_ListaColaborador.Dblcb_Vendedor.KeyValue;
    Registro.Data            := E_DataLanc.Date;
    Registro.Mes             := CB_Mes.ItemIndex;
    Registro.Ano             := StrToIntDef(E_Ano.Text,0);
    Registro.Historico       := E_Hist_Folha.Text;
    Registro.Credito         := StrToFloatDef(E_Credito.Text,0);
    Registro.Debito          := StrToFloatDef(E_Debito.Text,0);
    Registro.Estabelecimento := Gb_CodMha;
  End;
  FolhaPagto.salva;
end;

procedure TFr_Lanca_Folha.SB_CancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFr_Lanca_Folha.E_CreditoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Credito.Text,0);
  E_Credito.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Lanca_Folha.E_DebitoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Debito.Text,0);
  E_Debito.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
end;

procedure TFr_Lanca_Folha.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Lanca_Folha.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Lanca_Folha.FormShow(Sender: TObject);
begin
  Inicia_variaveis;
end;

end.

