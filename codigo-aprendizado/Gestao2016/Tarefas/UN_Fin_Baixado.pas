unit UN_Fin_Baixado;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, Buttons, ComCtrls, STStoredProc, STQuery, Printers, jpeg, Menus, ControllerCartaoEletronico, ControllerDskCashier, Controllerfinanceiro;

type
  TFr_Fin_Baixado = class(TForm)
    Ds_Financeiro: TDataSource;
    Qr_Cheque: TSTQuery;
    Ds_Cheque: TDataSource;
    Qr_Boleto: TSTQuery;
    Ds_Boleto: TDataSource;
    Qr_Financeiro: TSTQuery;
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Panel2: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label29: TLabel;
    Label24: TLabel;
    Label1: TLabel;
    E_N_Parcela: TDBEdit;
    E_Vl_Pagar: TDBEdit;
    E_Vencimento: TDBEdit;
    E_Juros: TDBEdit;
    E_Desconto: TDBEdit;
    E_Valor_Pago: TDBEdit;
    E_Data_Pagto: TDBEdit;
    E_Mora: TDBEdit;
    E_FormaPagto: TDBEdit;
    Pnl_Boleto: TPanel;
    DBG_Boleto: TDBGrid;
    Pnl_Cheque: TPanel;
    Label35: TLabel;
    E_vl_Cheque: TEdit;
    Mostracheque: TDBGrid;
    Qr_Acao: TSTQuery;
    Pnl_Cartao: TPanel;
    DBG_CARTAO: TDBGrid;
    Qr_Cartao: TSTQuery;
    Ds_Cartao: TDataSource;
    SB_Comissao: TSpeedButton;
    Sb_Cartao: TSpeedButton;
    procedure Tb_ItensDupAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Tb_ChequesAfterPost(DataSet: TDataSet);
    procedure Qr_FinanceiroAfterOpen(DataSet: TDataSet);
    procedure SB_CancelarClick(Sender: TObject);
    procedure SB_ComissaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_CartaoClick(Sender: TObject);
  private
    FTipoOperacao: String;
    FCodigoFinanceiro: Integer;

    { Private declarations }
    procedure Pc_SomaChq;
    function ConfirmebaixaMultipla:Boolean;
    procedure IniciaVariaveis;
    procedure setFTipoOperacao(const Value: String);
    procedure setFCodigoFinanceiro(const Value: Integer);

  public
    { Public declarations }
    tc:string;
    PathExe,PortaNota:String;

    CartaoEletronico : TControllerCartaoEletronico;
    Financeiro : TControllerfinanceiro;
    Cashier : TControllerDskCashier;
    procedure Pc_AtivarTabelas;

    function RegistraCancelamento:Boolean;
    procedure Pc_CancelaBaixa;
    procedure Pc_Cheques;
    procedure Pc_Cartao;
    procedure Pc_Boleto;
    procedure Pc_ImagemBotao;
    Procedure Pc_Baixar_Comissao;
    function Fc_ValidaCancelamentoBaixa:Boolean;
    property TipoOperacao:String read FTipoOperacao write setFTipoOperacao;
    property CodigoFinanceiro : Integer read FCodigoFinanceiro write setFCodigoFinanceiro;
  end;

var
  Fr_Fin_Baixado: TFr_Fin_Baixado;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, Un_Pagar_Multipla, Un_Fc_Sored_Procedures, Un_Regra_Negocio, Un_Fc_Comissao, UN_Principal, env, Un_RL_ControleCartao, RN_Permissao, RI_MovimentoFinanceiro, RN_Financeiro, un_frx_ControleCartao;
{$R *.dfm}

procedure TFr_Fin_Baixado.Pc_Cheques;
Var
  Lc_SqlTxt : String;
Begin
  Qr_Cheque.SQL.Clear;
  Lc_SqlTxt := 'SELECT CHQ_CODIGO, CHQ_EMITENTE, CHQ_NR_BANCO, CHQ_AGENCIA, CHQ_NUMERO, '+
               'CHQ_VALOR, CHQ_DATA, CHQ_DEVOLVIDO, CHQ_DT_QUITACAO, CHQ_TIPO, CHQ_ESTADO, '+
               'CHQ_RETORNO, CHQ_QT_REC '+
               'FROM TB_CHEQUES ';

  if FTipoOperacao = 'ContasReceber' then
    Lc_SqlTxt := Lc_SqlTxt + 'WHERE (CHQ_QT_REC=:CHQ_QT_REC) '
  else
    Lc_SqlTxt := Lc_SqlTxt + 'WHERE (CHQ_QT_PAG=:CHQ_QT_PAG) ';

  Qr_Cheque.SQL.Add(Lc_SqlTxt);

  Pnl_Cheque.Visible := true;
  Qr_Cheque.Active := False;
  if FTipoOperacao = 'ContasReceber' then
    Qr_Cheque.ParamByName('CHQ_QT_REC').AsInteger := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger
  else
    Qr_Cheque.ParamByName('CHQ_QT_PAG').AsInteger := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
  Qr_Cheque.Active := True;
end;

procedure TFr_Fin_Baixado.Pc_Cartao;
BEgin
  Pnl_Cartao.Visible := true;
  Qr_Cartao.Active := False;
  Qr_Cartao.ParamByName('CRT_CODQT_REC').AsInteger := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
  Qr_Cartao.Active := True;
end;

procedure TFr_Fin_Baixado.Pc_Boleto;
Var
  Lc_SqlTxt : String;
BEgin
  Pnl_Boleto.Visible := True;
  Qr_Boleto.Active := False;

  Qr_Boleto.SQL.Clear;
  Lc_SqlTxt := 'SELECT DISTINCT BLT_CODIGO, BLT_DATA, Tb_Cliente.EMP_NOME, BLT_NUMERO, '+
               '    (tb_banco.EMP_NOME || '' / '' || CTB_AGENCIA || '' / '' || CTB_CONTA)  AS BLT_CONTA '+
               ' FROM  TB_BOLETO Tb_boleto '+
               '    INNER JOIN TB_FINANCEIRO tb_financeiro '+
               '    ON (tb_financeiro.FIN_CODQTC = Tb_boleto.BLT_CODQTC) '+
               '    INNER JOIN TB_EMPRESA Tb_Cliente '+
               '    ON  (Tb_Cliente.EMP_CODIGO = Tb_Boleto.BLT_CODEMP) '+
               '    INNER JOIN TB_CONTABANCARIA Tb_contabancaria '+
               '    ON  (Tb_contabancaria.CTB_CODIGO = Tb_Boleto.BLT_CODCTB) '+
               '    INNER JOIN TB_EMPRESA tb_banco '+
               '    ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO) '+
               ' WHERE BLT_CODQTC =:BLT_CODQTC ';

  if FTipoOperacao = 'ContasReceber' then
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) '
  else
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (FIN_TIPO = ''PA'') OR (FIN_TIPO = ''PM'')) ';

  Qr_Boleto.SQL.Add(Lc_SqlTxt);
  Qr_Boleto.ParamByName('BLT_CODQTC').AsInteger := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
  Qr_Boleto.Active := True;

end;

function TFr_Fin_Baixado.RegistraCancelamento:Boolean;
Var
  Lc_Sqltxt : String;
  Lc_DataCaixa : TDate;
  Lc_cd_Usuario : Integer;
  Lc_QrUser : TSTQuery;
  Lc_Vl_Debito : REal;
  Lc_Vl_Credito : REal;
  LcTipoOperacao :String;
  Lc_Codigo : Integer;
  I : Integer;
Begin
  Result := True;
  //Verifica o Lançamento no Caixa
  if Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger > 0 then
  Begin
    Financeiro.Movimento.Registro.Quitacao := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
    Financeiro.Movimento.getList;
    if Financeiro.Movimento.Lista.Count > 0 then
    Begin
      for I := 0 to Financeiro.Movimento.Lista.Count -1 do
      Begin
        //Determina a data do caixa
        Lc_DataCaixa := Financeiro.Movimento.Lista[I].Data;
        Lc_cd_Usuario := Financeiro.Movimento.Lista[I].usuario;
        //Verifica se o lancamento foi efetuado no caixa
        if ( Financeiro.Movimento.Lista[I].ContaCorrente = 0) then
        Begin
          //Verifica o caixa aberto
          Lc_cd_Usuario := GB_Cd_Usuario;
          Cashier.clear;
          Cashier.Registro.Usuario := Lc_cd_Usuario;
          Cashier.VerificaCaixaAberto;
          Lc_DataCaixa := Cashier.Registro.Data;
          //Se o Caixa retornar com data zero, verifica o caixa do usuario atual
          //SÓ registra o cancelamento se for no caixa, no caso do banco não - 28/05/2018
          if Lc_DataCaixa = 0 then
          Begin
            MensagemPadrao('Mensagem ','A V I S O!.'+EOLN+EOLN+
                           'Para cancelar este lançamento.'+EOLN+EOLN +
                           'O usuário que está fazendo o cancelamento deve estar com o caixa aberto.'+EOLN+EOLN+
                           'Este Cancelamento não poderé ser efetuado neste momento.'+EOLN+EOLN,
                          ['OK'],[bEscape],mpAlerta);
            REsult:= False;
            exit;
          End;
          LcTipoOperacao := 'I';
          if Lc_cd_Usuario > 0 then
          Begin
            if ( DateToStr(Lc_DataCaixa) = DateToStr( Financeiro.Movimento.Lista[I].Data )) and
               ( Lc_cd_Usuario = Financeiro.Movimento.Lista[I].Usuario )  then
              LcTipoOperacao := 'A';
          End
          else
            Lc_cd_Usuario := GB_Cd_Usuario;

          Financeiro.ClonarObj(Financeiro.Movimento.Lista[I], Financeiro.Movimento.Registro);
          Financeiro.Movimento.Registro.Codigo := 0;
          Financeiro.Movimento.Registro.Data := Lc_DataCaixa;
          Financeiro.Movimento.Registro.Historico := Copy('CANCELAMENTO - ' + Financeiro.Movimento.Lista[I].Historico ,1,100);
          Financeiro.Movimento.Registro.Tipo := 'D';
          Financeiro.Movimento.Registro.Usuario := Lc_cd_Usuario;
          //Lançamento invertido devido ao cancelamento
          Financeiro.Movimento.Registro.ValorDebito := Financeiro.Movimento.Lista[I].ValorCredito;
          //Lançamento invertido devido ao cancelamento
          Financeiro.Movimento.Registro.ValorCredito := Financeiro.Movimento.Lista[I].ValorDebito;
          Financeiro.Movimento.Registro.ValorFuturo := 0;
          Financeiro.Movimento.insere;
        End
        else
        Begin
          if Lc_cd_Usuario = 0 then
            Lc_cd_Usuario := GB_Cd_Usuario;
          Financeiro.Movimento.Registro.Codigo := Financeiro.Movimento.Lista[I].Codigo;
          Financeiro.Movimento.Delete;
        End;
      End;
    End;
  End;
End;

procedure TFr_Fin_Baixado.Pc_CancelaBaixa;
VAr
  Lancamento : Boolean;
  I : Integer;
Begin
  //fAZ O LANÇAMENTO DO cANCELAMENTO
  Lancamento := RegistraCancelamento;
  if Lancamento then
  Begin
    if Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger > 0 then
    Begin
      Financeiro.Registro.CodigoQuitacao := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
      Financeiro.cancelaBaixaByQuitacao;
    End
    else
    Begin
      Financeiro.Registro.Codigo := Qr_Financeiro.FieldByName('FIN_CODIGO').AsInteger;
      Financeiro.cancelaBaixa;
    End;
    if ( FTipoOperacao = 'ContasReceber' ) then
    Begin
      if (Fc_Tb_Geral('L','TP_COMISSAO','')='R') then
      Begin
        Pc_Construtor_Comissao(DM.IB_Transacao);
        Financeiro.Clear;
        if Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger > 0 then
          Financeiro.Registro.CodigoQuitacao := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger
        else
        Financeiro.Registro.Codigo := Qr_Financeiro.FieldByName('FIN_CODIGO').AsInteger;

        Financeiro.getlist;
        for I := 0 to Financeiro.Lista.Count -1 do
        Begin
          Pc_DeletaComissao(DM.IB_Transacao,0,Financeiro.Lista[I].Codigo);
        End;
        Pc_Destrutor_Comissao;
      End;
      Pc_Log_Sistema( Gb_CodMha, Gb_Cd_Usuario, (Now),'Contas á Receber',Qr_Financeiro.FieldByName('FIN_CODIGO').AsInteger,
                    'Cancelamento', 'Cancelando Baixa Financeiro: '+Qr_Financeiro.FieldByName('FIN_NUMERO').AsString);
    end;
    if assigned(fr_Pagar_Multipla) then
    Begin
      Pc_Log_Sistema( Gb_CodMha, Gb_Cd_Usuario, (Now),'Contas é Pagar',Qr_Financeiro.FieldByName('FIN_CODIGO').AsInteger,
                   'Cancelamento', 'Cancelando Baixa Financeiro: '+Qr_Financeiro.FieldByName('FIN_NUMERO').AsString);
    end;
  End;
  Self.close;
end;



procedure TFr_Fin_Baixado.Pc_SomaChq;
Var
  Lc_Total : Real;
begin
  Lc_Total := 0;
  Qr_Cheque.First;
  while not Qr_Cheque.Eof do
  begin
    Lc_Total := Lc_Total + Qr_Cheque.FieldByName('CHQ_VALOR').AsCurrency;
    Qr_Cheque.Next;
  end;
  E_vl_Cheque.Text := FloatToStrF(Lc_Total,ffFixed,10,2);
end;



procedure TFr_Fin_Baixado.Tb_ItensDupAfterScroll(DataSet: TDataSet);
begin
  Qr_Cheque.Close;
  Qr_Cheque.Open;
  Qr_Boleto.Close;
  Qr_Boleto.Open;
end;

procedure TFr_Fin_Baixado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
    end;
end;

procedure TFr_Fin_Baixado.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Fin_Baixado.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;


procedure TFr_Fin_Baixado.setFCodigoFinanceiro(const Value: Integer);
begin
  FCodigoFinanceiro := Value;
end;

procedure TFr_Fin_Baixado.setFTipoOperacao(const Value: String);
begin
  //ContasReceber / ContasPagar
  FTipoOperacao := Value;
end;

procedure TFr_Fin_Baixado.FormCreate(Sender: TObject);
begin
  Pnl_Cheque.Visible := False;
  Pnl_Boleto.Visible := False;
  CartaoEletronico := TControllerCartaoEletronico.Create(self);
  Financeiro := TControllerfinanceiro.Create(self);
  Cashier := TControllerDskCashier.Create(self);
end;


procedure TFr_Fin_Baixado.Pc_AtivarTabelas;
Begin
  Qr_Financeiro.Active := true;
  Qr_Financeiro.FetchAll;
end;



procedure TFr_Fin_Baixado.Tb_ChequesAfterPost(DataSet: TDataSet);
begin
  Pc_SomaChq;
end;

procedure TFr_Fin_Baixado.Qr_FinanceiroAfterOpen(DataSet: TDataSet);
begin
  with Qr_Financeiro do
  Begin
    if RecordCount > 0 then
    Begin
      if FieldByName('FPT_DESCRICAO').AsString = 'BOLETO' then
      Begin
        Pc_Boleto;
      End
      else
      Begin
        if FieldByName('FPT_DESCRICAO').AsString = 'CHEQUE' then
        Begin
          Pc_Cheques
        End
        else
        Begin
          CartaoEletronico.Registro.FormaPagamento := FieldByName('FIN_CODFPG').asInteger;
          CartaoEletronico.getbyFormaPagto;
        if (copy(FieldByName('FPT_DESCRICAO').AsString,1,6) = 'CARTÃO') or
           (copy(FieldByName('FPT_DESCRICAO').AsString,1,6) = 'CARTAO')or
           ( CartaoEletronico.exist ) then
          Pc_Cartao;
        End;
      End;
    End;
  End;
end;

function TFr_Fin_Baixado.ConfirmebaixaMultipla: Boolean;
var

  LcMesssage : STring;
  I:Integer;
begin
  Result := False;
  if Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger > 0 then
  Begin
    Financeiro.Clear;
    Financeiro.Registro.CodigoQuitacao := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
    Financeiro.getlist;
    LcMesssage := '';
    if Financeiro.Lista.Count > 1 then
    Begin
      for I := 0 to Financeiro.Lista.Count -1 do
      Begin
        LcMesssage := concat(LcMesssage, IntTostr(I +1),' - ', Financeiro.Lista[I].NumeroDuplicata , EOLN);
      End;
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                          'Baixa múltipla verifica, portanto os seguintes documentos seráo cancelados.'+EOLN+EOLN+
                          LcMesssage+EOLN+
                          'Confirmar o Cancelamento ?',
                         [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
      Begin
        REsult := True;
      End;
    end;
  End;
end;

function TFr_Fin_Baixado.Fc_ValidaCancelamentoBaixa:Boolean;
Var
  Lc_Cancelamento : Boolean;
Begin
  Result := true;
  if FTipoOperacao = 'ContasReceber' then
    Lc_Cancelamento :=  Fc_VerificaPermissao('Fr_Receber_Multipla','Contasá Receber','CANCELAR',GB_Cd_Usuario,'S')
  else
    Lc_Cancelamento :=  Fc_VerificaPermissao('Fr_Pagar_Multipla','Contas É Pagar','CANCELAR',GB_Cd_Usuario,'S');

  if not Lc_Cancelamento then
  Begin
    result := False;
    exit;
  end;

  if ConfirmebaixaMultipla then
  Begin
    result := False;
    exit;
  end;
end;

procedure TFr_Fin_Baixado.SB_CancelarClick(Sender: TObject);
begin
  if Fc_ValidaCancelamentoBaixa then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Cancelar a baixa nº'+Qr_Financeiro.FieldByName('FIN_NUMERO').AsString +' de seus arquivos.'+EOLN+EOLN+
                       'Confirmar o Cancelamento ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    begin
      Pc_CancelaBaixa;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    end;
  end;
end;

Procedure TFr_Fin_Baixado.Pc_Baixar_Comissao;
Var
  Lc_I : Integer;
  Lc_cd_Financeiro : Integer;
  Lc_cd_Pedido : Integer;
Begin
  Pc_Construtor_Comissao(DM.IB_Transacao);
  Lc_cd_Financeiro := Qr_Financeiro.FieldByName('FIN_CODIGO').AsInteger;
  Lc_Cd_Pedido     := Qr_Financeiro.FieldByName('FIN_CODPED').AsInteger;
  Pc_DeletaComissao(DM.IB_Transacao, 0,Lc_cd_Financeiro);
  Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Lc_cd_Pedido);
  Pc_Gerar_Comissao_Vda_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
  Pc_Gerar_Comissao_Srv_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
  Pc_Gerar_Comissao_Srv_Vdo_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
  Pc_Destrutor_Comissao;



end;

procedure TFr_Fin_Baixado.SB_ComissaoClick(Sender: TObject);
Var
  Lc_Cd_Pedido : Integer;
  Lc_Cd_Financeiro : Integer;
begin
  if Fc_Tb_Geral('L','TP_COMISSAO','') ='R' then
    Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja recalcular a comissão do Pedido Nº '+ Qr_Financeiro.FieldByName('PED_NUMERO').AsString +'.'+EOLN+EOLN+
                       'Confirmar o recálculo ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
      begin
      Pc_Baixar_Comissao;
      MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O !.'+EOLN+EOLN+
                     'Operação Realizada com sucesso.'+EOLN,
                     ['OK'],[bEscape],mpInformacao);
      end;
    end
  else
    Begin
    MensagemPadrao(MENSAGEM,'I N F O R M A Ç Ã O !.'+EOLN+EOLN+
                   'Por favor configure a comissão para pagar pela baixa no Financeiro.'+EOLN,
                  ['OK'],[bEscape],mpInformacao);
    end;
end;

procedure TFr_Fin_Baixado.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  IniciaVariaveis;
  Pc_AtivarTabelas;
end;

procedure TFr_Fin_Baixado.IniciaVariaveis;
begin
  Qr_Financeiro.Close;
  Qr_Financeiro.ParamByName('FIN_CODIGO').AsInteger := FCodigoFinanceiro;
end;

procedure TFr_Fin_Baixado.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    SB_Comissao.Glyph.Assign(Fc_CarregaImagemBotao('RECALCULAR COMISSÃO'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    Sb_Cartao.Glyph.Assign(Fc_CarregaImagemBotao('CARTÃO'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;
procedure TFr_Fin_Baixado.Sb_CartaoClick(Sender: TObject);
Var
  Form : Tfrx_ControleCartao;
begin
  CartaoEletronico.Registro.FormaPagamento  := Qr_Financeiro.FieldByName('FIN_CODFPG').AsInteger;
  CartaoEletronico.getbyFormaPagto;

  if (E_FormaPagto.Text = 'CARTÃO') OR
     (E_FormaPagto.Text = 'CARTAO') OR
      CartaoEletronico.exist then
  Begin
    {
    Lc_Form := TForm.Create(RL_ControleCartao);
    Application.CreateForm(TRL_ControleCartao, Lc_Form);
    TRL_ControleCartao(Lc_Form).It_Cd_Quitacao := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
    TRL_ControleCartao(Lc_Form).Qrpt.Preview;
    FreeAndNil(Lc_Form);
    }
    Form := Tfrx_ControleCartao.create(nil);
    Try
      Try
        Form.Caption := 'Controle de Cartões';
        Form.CodigoQuitacao := Qr_Financeiro.FieldByName('FIN_CODQTC').AsInteger;
        Form.CodigoFinanceiro := Qr_Financeiro.FieldByName('FIN_CODIGO').AsInteger;
        Form.Buscar;
        Form.frxBase.PrepareReport;
        Form.frxBase.ShowReport;
      Except
        on e:Exception do
          raise Exception.create('Erro ao efetuar a copia do arquivo:' + e.Message);
      End;
    Finally
      FreeAndNil(Form);
    End;
  end
  else
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Este comprovante é apenas'+EOLN+
                   'Forma de pagamento em Cartão.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);


  end;
end;

end.
