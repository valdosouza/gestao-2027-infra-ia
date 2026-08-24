unit un_receber_tef_avulso;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrTEFD, DateUtils, Actions, Vcl.ActnList, STDatabase, Vcl.StdCtrls, ACBrUtil, Vcl.Mask, QEdit_Setes, Vcl.Buttons, Vcl.ExtCtrls, env, ControllerTefMovimento, ACBrTEFDClass, ACBrTEFDCliSiTef, System.Math, Un_Fm_FormaPagto, Vcl.DBCtrls, Vcl.Touch.Keyboard, Un_Cupom_Fiscal;

type
  TFr_receber_tef_avulso = class(TFr_Cupom_Fiscal)
    TEF: TACBrTEFD;
    Pnl_TEF_Geral: TPanel;
    Pnl_Msg_TEF: TPanel;
    lMensagemOperador: TLabel;
    Label48: TLabel;
    Panel3: TPanel;
    mm_Tef: TMemo;
    Panel4: TPanel;
    bCancelarResp: TButton;
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure TEFAguardaResp(Arquivo: string; SegundosTimeOut: Integer;
      var Interromper: Boolean);
    procedure TEFAntesFinalizarRequisicao(Req: TACBrTEFDReq);
    procedure TEFBloqueiaMouseTeclado(Bloqueia: Boolean;
      var Tratado: Boolean);
    procedure TEFComandaECF(Operacao: TACBrTEFDOperacaoECF;
      Resp: TACBrTEFDResp; var RetornoECF: Integer);
    procedure TEFComandaECFAbreVinculado(COO, IndiceECF: string;
      Valor: Double; var RetornoECF: Integer);
    procedure TEFComandaECFImprimeVia(
      TipoRelatorio: TACBrTEFDTipoRelatorio; Via: Integer;
      ImagemComprovante: TStringList; var RetornoECF: Integer);
    procedure TEFComandaECFSubtotaliza(DescAcre: Double;
      var RetornoECF: Integer);
    procedure TEFDepoisConfirmarTransacoes(
      RespostasPendentes: TACBrTEFDRespostasPendentes);
    procedure TEFExibeMsg(Operacao: TACBrTEFDOperacaoMensagem;
      Mensagem: string; var AModalResult: TModalResult);
    procedure TEFInfoECF(Operacao: TACBrTEFDInfoECF;
      var RetornoECF: string);
    procedure ACBrTEFD1CliSiTefExibeMenu(Titulo: string; Opcoes: TStringList;
      var ItemSelecionado: Integer; var VoltarMenu: Boolean);
    procedure ACBrTEFD1CliSiTefObtemCampo(Titulo: string; TamanhoMinimo,
      TamanhoMaximo, TipoCampo: Integer;
      Operacao: TACBrTEFDCliSiTefOperacaoCampo; var Resposta: AnsiString;
      var Digitado, VoltarMenu: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fCancelado : Boolean ;
    TEF_Ativo : Boolean;
    IndiceTransacaoTef : Integer;
    estadoSimuladoEcf : TEstadoEcfSimulado;
    TEFformapagto : String;
    CtrlTEF : TControllerTefMovimento;
    Function  Valida():Boolean;Override;
    procedure Pc_Executar;Override;
    procedure ImprimeComprovante(c:TStringList);
    Function EfetuaPagamentoTEF(Valor:Real; Parcela:Integer;Pagto:String;NrNFCE:String):Boolean;
    procedure ConfigAtivaTEF;
    Procedure Pc_Inicia_Variaveis;Override;
  public
    { Public declarations }
    function chamarTEF:Boolean;override;
  end;

var
  Fr_receber_tef_avulso: TFr_receber_tef_avulso;

implementation

uses
      UN_Principal, Un_DM, Un_TEF_ExibeMenu, BematechPrint, EpsonPrint, Un_TEF_ObtemCampo, tributacao, UN_Sistema, Un_Msg, Un_Regra_Negocio, GeneralPrint;

{$R *.dfm}

procedure TFr_receber_tef_avulso.TEFAguardaResp(Arquivo: string;
    SegundosTimeOut: Integer; var Interromper: Boolean);
var
  Msg : String ;
begin
  Msg := '' ;
  if (TEF.GPAtual in [gpCliSiTef, gpVeSPague]) then   // TEF dedicado ?
  begin
    if (Arquivo = '23') and (not Sb_Cancelar.Visible) then  // Esta aguardando Pin-Pad ?
    begin
      if TEF.TecladoBloqueado then
      begin
        TEF.BloquearMouseTeclado(False);  // Desbloqueia o Teclado
        // TODO: nesse ponto é necessário desbloquear o Teclado, mas permitir
        // um clique apenas no botão cancelar.... FALTA CORRIGIR NO DEMO
      end ;
      Msg := 'Tecle "ESC" para cancelar.';
      Sb_Cancelar.Visible := True ;
      fCancelado := False;
    end;
  end
  else
    Msg := 'Aguardando: '+Arquivo+' '+IntToStr(SegundosTimeOut) ;

  if Msg <> '' then mm_Tef.Lines.Add( Msg );
  Application.ProcessMessages;

  if fCancelado then
     Interromper := True ;


end;

procedure TFr_receber_tef_avulso.TEFAntesFinalizarRequisicao(
  Req: TACBrTEFDReq);
begin
   if Req.Header = 'CRT' then
      Req.GravaInformacao(777,777,'TESTE REDECARD');
   mm_Tef.Lines.Add('Enviando: '+Req.Header+' ID: '+IntToStr( Req.ID ) );
end;

procedure TFr_receber_tef_avulso.TEFBloqueiaMouseTeclado(
  Bloqueia: Boolean; var Tratado: Boolean);
begin
  self.Enabled := not Bloqueia ;
  If Bloqueia then
    mm_Tef.Lines.Add('BloqueiaMouseTeclado = SIM')
  else
    mm_Tef.Lines.Add('BloqueiaMouseTeclado = NAO');
  Tratado := False ;  { Deixa executar o código de Bloqueio do ACBrTEFD }
end;

procedure TFr_receber_tef_avulso.ACBrTEFD1CliSiTefExibeMenu(Titulo: string;
  Opcoes: TStringList; var ItemSelecionado: Integer; var VoltarMenu: Boolean);
Var
  AForm : TFr_TEF_ExibeMenu ;
  MR    : TModalResult ;
Label
  lbTEfForma;
begin
  try
    AForm := TFr_TEF_ExibeMenu.Create(self);
    AForm.Panel1.Caption := Titulo;
    AForm.ListBox1.Items.AddStrings(Opcoes);
    MR := AForm.ShowModal ;
    VoltarMenu := (MR = mrRetry) ;
    if (MR = mrOK) then
      ItemSelecionado := AForm.ListBox1.ItemIndex;
  finally
    FreeAndNil(AForm);
  end;

  {
    case AnsiIndexStr(Titulo, ['Selecione a forma de pagamento', 'Selecione o tipo do Cartao de Credito']) of
      0:Begin
          case AnsiIndexStr(UpperCase(TEFformapagto), ['DEBITO', 'CREDITO']) of
            0 : Begin
                  ItemSelecionado := 0;
                End;
            1 : Begin
                  if (UpperCase(AForm.ListBox1.Items.Strings[0]) = 'CREDITO' ) then
                    ItemSelecionado := 1
                  else
                    ItemSelecionado := 0;
                End;
          else
            Goto lbTEfForma;
          end;
        end;
      1:Begin
          ItemSelecionado := 0;
        End;
      else
        BEgin

        End;
    end;
}
end;

procedure TFr_receber_tef_avulso.TEFComandaECF(
  Operacao: TACBrTEFDOperacaoECF; Resp: TACBrTEFDResp; var RetornoECF: Integer);
begin
  try
    case Operacao of
      opeAbreGerencial :
         mm_Tef.Lines.Add('Abre Gerencial') {ACBrECF1.AbreRelatorioGerencial} ;

      opeFechaCupom :
         estadoSimuladoEcf := tpsLivre;

      opeSubTotalizaCupom :
         mm_Tef.Lines.Add('Sub Totaliza');

      opeFechaGerencial, opeFechaVinculado :
         estadoSimuladoEcf := tpsRelatorio;

      opePulaLinhas :
        begin
          mm_Tef.Lines.Add('PulaLinhas');
          Sleep(200);
        end;

      opeImprimePagamentos :
        begin
          mm_Tef.Lines.Add('ImprimePagamentos');
        end;
    end;
    RetornoECF := 1 ;
  except
    RetornoECF := 0 ;
  end;

end;

procedure TFr_receber_tef_avulso.TEFComandaECFAbreVinculado(COO,
  IndiceECF: string; Valor: Double; var RetornoECF: Integer);
begin
  try
     RetornoECF := 1 ;
  except
     RetornoECF := 0 ;
  end;
end;

procedure TFr_receber_tef_avulso.TEFComandaECFImprimeVia(
  TipoRelatorio: TACBrTEFDTipoRelatorio; Via: Integer;
  ImagemComprovante: TStringList; var RetornoECF: Integer);
begin
  try
     case TipoRelatorio of
       trGerencial :
         ImprimeComprovante(ImagemComprovante); //mm_Tef.Lines.Add('GERENCIAL:' + ImagemComprovante.Text);
       trVinculado :
         ImprimeComprovante(ImagemComprovante); //mm_Tef.Lines.Add('VINCULADO:' + ImagemComprovante.Text);
     end;
     RetornoECF := 1 ;
  except
     RetornoECF := 0 ;
  end;
end;

procedure TFr_receber_tef_avulso.TEFComandaECFSubtotaliza(
  DescAcre: Double; var RetornoECF: Integer);
begin
  estadoSimuladoEcf := tpsPagamento;
  RetornoECF := 1 ;
end;

procedure TFr_receber_tef_avulso.TEFDepoisConfirmarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
begin
  CtrlTEF.Clear;
  CtrlTEF.Registro.CodigoPedido := Self.It_Cd_Pedido ;
  CtrlTEF.Registro.Estabelecimento := Gb_CodMha; ;
  CtrlTEF.Registro.status := 'F';
  CtrlTEF.finaliza;
end;

procedure TFr_receber_tef_avulso.TEFExibeMsg(
  Operacao: TACBrTEFDOperacaoMensagem; Mensagem: string;
  var AModalResult: TModalResult);
var
   Fim : TDateTime;
   OldMensagem : String;
begin
  case Operacao of
    opmOK :
       AModalResult := MessageDlg( Mensagem, mtInformation, [mbOK], 0);

    opmYesNo :
       AModalResult := MessageDlg( Mensagem, mtConfirmation, [mbYes,mbNo], 0);

    opmExibirMsgOperador, opmRemoverMsgOperador :
         lMensagemOperador.Caption := Mensagem ;

    //  opmExibirMsgCliente, opmRemoverMsgCliente :
    //     lMensagemCliente.Caption := Mensagem ;
    opmDestaqueVia :
      begin
        OldMensagem := lMensagemOperador.Caption ;
        try
          lMensagemOperador.Caption := Mensagem ;
          { Aguardando 3 segundos }
          Fim := IncSecond( now, 3)  ;
          repeat
            sleep(200) ;
            lMensagemOperador.Caption := Mensagem + ' ' + IntToStr(SecondsBetween(Fim,now));
            Application.ProcessMessages;
          until (now > Fim) ;

        finally
          lMensagemOperador.Caption := OldMensagem ;
        end;
      end;
  end;
  Application.ProcessMessages;

end;

procedure TFr_receber_tef_avulso.TEFInfoECF(Operacao: TACBrTEFDInfoECF;
  var RetornoECF: string);
var
   ASubTotal: Double;
begin
  { Para CliSiTEF ou V&SPague aplique o IF abaixo em sua aplicação, que
    permite saber se o Cupom foi concluido mesmo com o ECF desligado }

  if (not TEF.TEF.Inicializado) and   { Esta na inicialização ? }
       (TEF.GPAtual in [gpCliSiTef,gpVeSPague]) then
  begin
    { Leia o último Documento Gravado no seu Banco de Dados, e verifique
      se o Cupom já foi finalizado,ou se já foi aberto um CCD ou Gerencial...
      Exemplo:}

    CtrlTEF.Registro.Usuario := GB_Cd_Usuario;
    if CtrlTEF.getByStatus('I') then
      RetornoECF := 'O'
    else
      RetornoECF := 'R';

    //RetornoECF := 'O';    // ExecutarÉ CancelarTransacoesPendentes;
    //RetornoECF := 'R';    // ExecutarÉ ConfirmarESolicitarImpressaoTransacoesPendentes;
    exit ;
  end ;

  case Operacao of
    ineSubTotal :
      begin
        ASubTotal := StringToFloatDef(E_VL_Total.Text, 0);
        //ASubTotal := ASubTotal - StringToFloatDef(EditTotalPago.Text, 0){ + Tratar Desconto e Acrescimo aqui: StringToFloatDef(edValorDescAcre.Text, 0)};
        RetornoECF := FloatToStr(ASubTotal);
        if estadoSimuladoEcf = tpsPagamento then
          RetornoECF := FloatToStr(0);
      end;

    ineTotalAPagar :
        RetornoECF := '0';

    ineEstadoECF :
      begin
        Case estadoSimuladoEcf of
          tpsLivre     : RetornoECF := 'L' ;
          tpsVenda     : RetornoECF := 'V' ;
          tpsPagamento : RetornoECF := 'P' ;
          tpsRelatorio : RetornoECF := 'R' ;
        else
          RetornoECF := 'O' ;
        end;
      end;
   end;
end;

procedure TFr_receber_tef_avulso.Pc_Executar;
var
  Lc_ResTEF : Boolean;
Begin
  Lc_ResTEF := chamarTEF;
end;

procedure TFr_receber_tef_avulso.Pc_Inicia_Variaveis;
Begin
  It_CodigoFPagto.Add( '1' );
  Pc_CriarFrame('DINHEIRO',0,155);
end;

procedure TFr_receber_tef_avulso.Sb_ConfirmaClick(Sender: TObject);
begin
  Try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Fechar := False;
    if Valida then
    Begin
      Pc_Executar;
    end;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := true;
    if Fechar then
      Self.Close;
  end;
end;

function TFr_receber_tef_avulso.Valida: Boolean;
Var
  Lc_Valor : Real;
  Lc_Est : String ;
Begin
  Result := True;
  Pnl_Caixa.Caption := 'Validando informações...';
  Application.ProcessMessages;
  if not ValidaPreenchimentoParcelamento then
  Begin
    Result := False;
    exit;
  End;

  Lc_Valor := StrToFloatDef(e_vl_recebido.Text,0);
  if (Lc_Valor = 0) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O valor recebido não pode ser igual a Zero.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;


  Lc_Valor := StrToFloatDef(E_Vl_Pagar.Text,0);
  if (Lc_Valor > 0) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O valor a pagar não pode ser maior do que Zero.' + EOLN +
                   'Verifique os valores recebidos e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

end;

procedure TFr_receber_tef_avulso.ACBrTEFD1CliSiTefObtemCampo(Titulo: string;
  TamanhoMinimo, TamanhoMaximo, TipoCampo: Integer;
  Operacao: TACBrTEFDCliSiTefOperacaoCampo; var Resposta: AnsiString;
  var Digitado, VoltarMenu: Boolean);
Var
  AForm : TFr_TEF_ObtemCampo ;
  MR    : TModalResult ;
  LcShow : Boolean;
begin
  AForm := TFr_TEF_ObtemCampo.Create(self);
  try
    LcShow := True;
    AForm.Caption := 'TEF - Setes';
    AForm.Panel1.Caption := Titulo;

    { Indica, na coleta, que o campo em questão é o valor do troco em dinheiro
      a ser devolvido para o cliente.
      Na devolução de resultado (Comando = 0) contém o valor efetivamente aprovado para o troco}
    //tAXA DE sERVIçO - 130
    if TipoCampo=130 then
    Begin
      Digitado := True;
      Resposta := '0';
      LcShow := False;
    End;

    //Digitar senha
    if TipoCampo=500 then
    Begin
      AForm.Panel1.Caption := 'Forneça a Senha do Supervisor';
      AForm.Edit1.PasswordChar:='*';
      TamanhoMinimo := 5;
    end
    else
    Begin
      AForm.Edit1.PasswordChar:=#0;
    End;

    AForm.TamanhoMaximo  := TamanhoMaximo;
    AForm.TamanhoMinimo  := TamanhoMinimo;
    AForm.Operacao       := Operacao;
    AForm.TipoCampo      := TipoCampo;
    AForm.Edit1.Text     := Resposta; { Para usar Valores Previamente informados }

    //tAXA DE sERVIçO - 504
    if TipoCampo=504 then
    Begin
      Digitado := True;
      Resposta := '';
      LcShow := False;
    End;

    //Número do Cartão de Crédito Digitado
    if TipoCampo = 512 then
    Begin
      AForm.Panel1.Caption := 'Forneça o Número do Cartão';
      AForm.Edit1.MaxLength :=  16;
      TamanhoMinimo := 16;
      TamanhoMaximo := 16;
    End;


    //Código de segurança do Cartão - 514
    if TipoCampo=514 then
    Begin
      AForm.Panel1.Caption := 'Informe o Código de segurança do Cartão';
      TamanhoMinimo := 3;
      TamanhoMaximo := 5;
    End;


    //DATA DA TRANSAÇÃO - 515
    if TipoCampo=515 then
    Begin
      AForm.Panel1.Caption := 'Informe Data da Transação (DDMMAAAA)';
      TamanhoMinimo := 8;
      TamanhoMaximo := 8;
    End;
    //Número do documento a ser cancelado ou a ser re-impresso - 516
    if TipoCampo=516 then
    Begin
      AForm.Panel1.Caption := 'Forneça o número a ser cancelado ou re-impresso';
      TamanhoMinimo := 6;
    End;


    //Vai abrir o formulario para solicitar dados
    if LcShow then
    Begin
      MR := AForm.ShowModal ;

      Digitado   := (MR = mrOK) ;
      VoltarMenu := (MR = mrRetry) ;
      if Digitado then
         Resposta := AForm.Edit1.Text;
    End;

  finally
    FreeAndNil(AForm);
  end;


end;

function TFr_receber_tef_avulso.chamarTEF: Boolean;
var
  I : Integer;
  //Novos
  Lc_Edit: TEdit;
  Lc_Valor :real;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_cd_Forma_Pagto : Integer;
  Lc_Combo : TComboBox;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  Lc_PagtoNFCe : String;
begin
  Result := True;
  mm_Tef.Clear;
  if TEF_Ativo  then
  Begin
    IndiceTransacaoTef     := -1;
    estadoSimuladoEcf := tpsVenda;
    for I := 0 to It_CodigoFPagto.Count - 1 do
    begin
     //Encontrar os campos para pegar os valores
      variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
      //Encontra a forma de pagamento
      MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
      Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
      Lc_PagtoNFCe := Lc_Dblookup.ListSource.DataSet.FieldByName('FPT_TIPO_NFCE').AsString;
      //Verifica
      if (Lc_PagtoNFCe = '03') or (Lc_PagtoNFCe = '04') then
      Begin
        //Encontra o valor a receber
        Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
        Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
        TEFformapagto := UpperCase(Lc_Dblookup.Text);
        Result := EfetuaPagamentoTEF(Lc_Valor,I, Lc_PagtoNFCe, IntToStr( It_Cd_Pedido ));
        if Not Result then
        Begin
          mm_Tef.Lines.Add('Operação abortada');
          break;
        End;
      End;
      {
      //Encontra o parcelamento
      Lc_Combo := TComboBox(Fc_LocalizaComponente(variavel,TComboBox));
      Lc_Parcelas := StrToIntDef( Lc_Combo.Text , 1);
      }
    end;
    Tef.ImprimirTransacoesPendentes;
    estadoSimuladoEcf := tpsLivre;
  End;
end;

procedure TFr_receber_tef_avulso.ConfigAtivaTEF;
var
  stringCNPJCliente : String;
  stringCNPJSoftwareHouse : String;
Begin
  with TEF do
  Begin
    AutoAtivarGP := True;
    MultiplosCartoes := True;
    EsperaSleep := 250;
    EsperaSTS := 7;
    TEFCliSiTef.CodigoLoja := Fc_Tb_Geral('L','TEF_ID_LOJA','0'); //'00000000';
    TEFCliSiTef.EnderecoIP := Fc_Tb_Geral('L','TEF_IP_SERVIDOR','0'); // '127.0.0.1';
    TEFCliSiTef.NumeroTErminal := Fc_Aq_Geral('L','TEF','TEF_ID_TERMINAL','0'); //'SE000001';
    TEFCliSiTef.PortaPinPad := StrToIntDef( Fc_Aq_Geral('L','TEF','TEF_PORTA_PINPAD','0'), 8);// 8;
    ExibirMsgAutenticacao := fALSE;
    Identificacao.NomeAplicacao := 'Gestão Setes';
    Identificacao.VersaoAplicacao := '2.016';
    Identificacao.SoftwareHouse := 'GESTAO COMPUTACIONAL SETES ';
    Identificacao.RazaoSocial := 'F. D. SOUZA DESENVOLVIMENTO E LICENCIAMENTO DE PROGRAMAS';
    //Identificacao.RegistroCertificacao := '';
    //stringCNPJCliente := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
    //stringCNPJSoftwareHouse := '07742094000113';
    //TEFCliSiTef.ParametrosAdicionais.Text := 'ParmsClient=1='+stringCNPJCliente+';2='+stringCNPJSoftwareHouse;
    TEFCliSiTef.PathDLL := GbPathExe;
    estadoSimuladoEcf := tpsLivre;
    lMensagemOperador.Font.color := clBlack;
    Application.ProcessMessages;
    if not Inicializado( gpCliSiTef ) then
    Begin
      try
        try
          Inicializar( gpCliSiTef );
          //Encerra tef pendente
          CtrlTEF.Registro.Estabelecimento := Gb_CodMha;
          CtrlTEF.Registro.Usuario := GB_Cd_Usuario;

          CtrlTEF.encerraPendentes;
          //Conclui tef pendente
          CtrlTEF.Registro.Estabelecimento := Gb_CodMha;
          CtrlTEF.Registro.Usuario := GB_Cd_Usuario;
          CtrlTEF.ConcluiPendentes;
        finally
          lMensagemOperador.Font.Color := clBlack;
          mm_Tef.Lines.Add('TEF Inicializado');
          Application.ProcessMessages;
        end;
       except
          on E : Exception do
          Begin
            ShowMessage(E.ClassName+' Erro enontrado: '+E.Message);
            lMensagemOperador.Font.Color := clRed;
            lMensagemOperador.Caption := 'TEF NÃO FOI ATIVADO. VERIFIQUE!!';
            Application.ProcessMessages;
          End;
       end;
    end;
  End;

end;

function TFr_receber_tef_avulso.EfetuaPagamentoTEF(Valor: Real;
  Parcela: Integer; Pagto, NrNFCE: String): Boolean;
var
  StatusTransacao : Boolean;
  CtrlTEF : TControllerTefMovimento;
begin
  Result := True;
  with TEF do
  Begin
    //Inicia a Gravação da operação
    CtrlTEF := TControllerTefMovimento.Create(Self);
    CtrlTEF.Clear;
    CtrlTEF.Registro.CodigoPedido := It_Cd_Pedido ;
    CtrlTEF.Registro.Estabelecimento := Gb_CodMha;
    CtrlTEF.Registro.Parcela := Parcela;
    CtrlTEF.Registro.Usuario := GB_Cd_Usuario;
    CtrlTEF.Registro.status := 'I';
    CtrlTEF.insert;
    //Efetua a operação
    StatusTransacao := tef.CRT( Valor , Pagto, trim(NrNFCE));

    if StatusTransacao then
    begin
      Inc(IndiceTransacaoTef);
      if not(AutoFinalizarCupom) then
      Begin
        CtrlTEF.Registro.CRT := RespostasPendentes[IndiceTransacaoTef].ID;
        CtrlTEF.Registro.DocumentoVinculado := RespostasPendentes[IndiceTransacaoTef].DocumentoVinculado;
        CtrlTEF.Registro.ValorTotal := RespostasPendentes[IndiceTransacaoTef].ValorTotal ;
        CtrlTEF.Registro.Rede := RespostasPendentes[IndiceTransacaoTef].Rede;
        CtrlTEF.Registro.NSU := RespostasPendentes[IndiceTransacaoTef].NSU;
        CtrlTEF.Registro.DataHora := RespostasPendentes[IndiceTransacaoTef].DataHoraTransacaoHost;
        CtrlTEF.Registro.Instituicao := StrToIntDef( RespostasPendentes[IndiceTransacaoTef].Instituicao,0);
        CtrlTEF.Registro.Campo11 := Copy(RespostasPendentes[IndiceTransacaoTef].LeInformacao(11,0).AsString,1,100) ;
      End;
      //Application.MessageBox('Transação aprovada, Favor Travar o dados do comprovante', 'Informação', MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      mm_Tef.Lines.Add('Transação Negada');
      Application.MessageBox('Transação Negada', 'Informação', MB_OK + MB_ICONWARNING);
      Result := False;
      Exit;
    end;
    //TErmina da gravação da Operação
    CtrlTEF.Registro.status := 'T';
    CtrlTEF.update;
    FreeAndNil(CtrlTEF);
  end;
end;

procedure TFr_receber_tef_avulso.FormCreate(Sender: TObject);
begin
  inherited;
  CtrlTEF := TControllerTefMovimento.Create(Self);
end;

procedure TFr_receber_tef_avulso.FormShow(Sender: TObject);
begin
  inherited;
  //Ativa o TEF
  TEF_Ativo := ( Fc_Aq_Geral('L','TEF','TEF_LC_ATIVO','N') = 'S'); //( Fc_Tb_Geral('L','FIN_G_TEF','S') = 'S');
  Pnl_TEF_Geral.Visible := TEF_Ativo;
  CtrlTEF := TControllerTefMovimento.Create(Self);
  if (TEF_Ativo) then
  Begin
    ConfigAtivaTEF;
  End;
  Pc_AtivaEstabelecimento;
end;

procedure TFr_receber_tef_avulso.ImprimeComprovante(c: TStringList);
VAR
  PrtGeneral : TGeneralPrint;
  I : Integer;
  Lc_Porta : String;
  Lcmodelo : Integer;
  Lc_Saltos : Integer;
Begin
  Lcmodelo := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL','1'),0);
  Lc_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
  Lc_Saltos := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'),2);
  if Lcmodelo = 1 then
  Begin
    PrtGeneral := TPrintGeneralFactory.criarPrint('EPSON - TM-T20');
    With PrtGeneral Do
    begin
      Porta := Lc_Porta;
      Iniciar;
      for I := 0 to c.Count - 1 do
        TextOutLC(1,1,c.Strings[I]);
      Saltar(Lc_Saltos);
      CortarPapel(0);
      Fechar;
    end;
    FreeAndNil(PrtGeneral);
  End
  else
  Begin
    try
      PrtGeneral := TPrintGeneralFactory.criarPrint('BEMATECH - MP4200');
      with  PrtGeneral do
      Begin
        case Lcmodelo of
          2:ModeloImpressora := 7;
          3:ModeloImpressora := 5;
          4:ModeloImpressora := 5;
          6:ModeloImpressora := 8;
        end;
        Porta := Lc_Porta;
        TamanhoMargem := 3;
        Iniciar;
        for I := 0 to c.Count - 1 do
          TextOutLC(1,1,c.Strings[I]);
        Saltar(Lc_Saltos);
        CortarPapel(0);
        Fechar;
      End;
    finally
      FreeAndNil(PrtGeneral);
    end;
  End



end;

end.


