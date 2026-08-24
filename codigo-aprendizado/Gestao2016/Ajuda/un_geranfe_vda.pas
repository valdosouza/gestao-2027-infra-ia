unit un_geranfe_vda;

interface
uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.AppEvnts, Vcl.Menus, Data.DB, STQuery, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, tas_gera_nfe_autorizacao, ControllerBoletoBancario, STDataSet;

type
  TFr_GeraNfe_vda = class(TTasGeraNfeAutorizacao)
    Chbx_boleto: TCheckBox;
    Chbx_Duplicata: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    Boleto : TControllerBoletoBancario;
    function ValidaEnvioEmail:Boolean;
    procedure EnviaEmailBoleto;
    function ValidaImpressao:boolean;
    procedure ImprimeBoleto;

    function ValidaEnviaWhatsAppBoleto:Boolean;
    procedure  EnviaWhatsAppBoleto;
  protected
    procedure FormataTela;Override;
    procedure IniciaVariaveis;Override;
    procedure ImprimeDuplicata;Override;
    procedure ConfirmaEnviaBoleto;Override;
    procedure ConfirmaImprimeBoleto;Override;
    procedure Pc_CancelaNFe_Pendente;Override;
  public
    { Public declarations }
  end;

var
  Fr_GeraNfe_vda: TFr_GeraNfe_vda;

implementation

{$R *.dfm}

uses     UN_Sistema, RN_Financeiro, Un_Msg, RN_BoletoEletronico, Un_DM, ACBrBoleto, UN_Principal, env, ControllerFinanceiro, WhatsApp, Un_envia_email, RN_NotaFiscalEletronica3X, Un_Fc_Sored_Procedures, un_Regra_Negocio;

{ TFr_GeraNfe_vda }

procedure TFr_GeraNfe_vda.ConfirmaEnviaBoleto;
Var
  Lc_Escolha: Integer;
  Lc_Financeiro : TControllerFinanceiro;
begin
  if Chbx_boleto.Checked then
  Begin
    Try
      Lc_Financeiro := TControllerFinanceiro.Create(Self);
      Lc_Financeiro.Registro.CodigoNota := It_Cd_Nota;
      Lc_Financeiro.getlistBoleto;
      if (Lc_Financeiro.Lista.Count > 0 ) then
      Begin
        if ValidaEnvioEmail then
          EnviaEmailBoleto;
      End;
    Finally
      FreeAndNil(Lc_Financeiro);
    End;
  End;

end;

procedure TFr_GeraNfe_vda.ConfirmaImprimeBoleto;
Var
  Lc_Escolha: Integer;
  Lc_Financeiro : TControllerFinanceiro;
begin
  if Chbx_boleto.Checked then
  Begin
    Try
      Lc_Financeiro := TControllerFinanceiro.Create(Self);
      Lc_Financeiro.Registro.CodigoNota := It_Cd_Nota;
      Lc_Financeiro.getlistBoleto;
      if (Lc_Financeiro.Lista.Count > 0 ) then
      Begin
        Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                      'Deseja Imprimir o boleto? ',
                                      ['Confirma', 'Cancelar'], [bNormal, bEscape],mpConfirmacao, clBtnFace));
        if Lc_Escolha = 0 then
          ImprimeBoleto;
      End;
    Finally
      FreeAndNil(Lc_Financeiro);
    End;
  End;
end;

procedure TFr_GeraNfe_vda.EnviaEmailBoleto;
Var
  Lc_Mail : String;
  Lc_Assunto : String;
  Lc_Email: string;
  Lc_Destinatario : TStringList;
  Lc_Anexo : TStringList;
  Lc_AssuntoEmail : string;
  Lc_Obs : TMemo;
  Lc_Texto: TMemoryStream;
  LcEnviaemail : TFr_envia_email;
begin
  try
    Lc_Destinatario := TStringList.Create;
    Lc_Anexo        := TStringList.Create;
    LcEnviaemail := TFr_envia_email.create(nil);
    with boleto,LcEnviaemail do
    Begin
      CodigoNota := It_Cd_Nota;
      Estabelecimento := Gb_CodMha;
      CarregaDadosGeral;
      ConfiguraComponente;
      CarregaComponente;

      //Prepara o envio do email
      Lc_AssuntoEmail :=  'Envio de Boleto - ' + DM.Qr_Estabelecimento.FieldByName('EMP_FANTASIA').AsString;
      It_Tipo_Envio := 'S';
      It_Assunto := Lc_AssuntoEmail;
      Pc_Define_RemententeAtivo;
      Lc_Destinatario.Clear;
      Lc_Destinatario.Add(' ' + Cliente.Empresa.Registro.Email );
      ListarEmailParaEnvio(DM.Qr_Estabelecimento.FieldByName('EMP_CODIGO').AsString,['FINANCEIRO'],Lc_Destinatario) ;
      it_Anexo.Add( GerarPDF );
      It_Destino := Lc_Destinatario;
      It_Corpo   := GeraEmail;
    ShowModal;
    End;
  Finally
    FReeAndNil(Lc_Destinatario);
    FreeAndNil(LcEnviaemail);
  End;
end;

procedure TFr_GeraNfe_vda.EnviaWhatsAppBoleto;
Var
  LcW : TWhatsApp;
begin
  try
    LcW := TWhatsApp.create(nil);
    with boleto do
    Begin
      CodigoNota := It_Cd_Nota;
      Estabelecimento := Gb_CodMha;
      CarregaDadosGeral;
      ConfiguraComponente;
      CarregaComponente;
      //Prepara o envio
      LcW.Mensagem := 'Ola, Seu pedido foi faturado , Segue anexo o Boleto';
      LcW.ReceiverNumber := Cliente.Empresa.Endereco.Registro.Celular;
      //Agora Envia o Anexo
      LcW.Arquivo := GerarPDF;
      LcW.RegisterMessage;
      LcW.Send;
    End;
  Finally
    FreeAndNil(LcW);
  End;
end;


procedure TFr_GeraNfe_vda.FormataTela;
begin
  inherited;
  Chbx_boleto.Enabled := ( Fc_Tb_Geral('L','FIN_FAT_GER_AUTO_BOLETO','N') = 'S');
  Chbx_boleto.Checked := Chbx_boleto.Enabled;
end;

procedure TFr_GeraNfe_vda.FormCreate(Sender: TObject);
begin
  inherited;
  Boleto := TControllerBoletoBancario.Create(Self);
end;

procedure TFr_GeraNfe_vda.ImprimeBoleto;
begin
  if ValidaImpressao then
  Begin
    with boleto do
    Begin
      CodigoNota := It_Cd_Nota;
      Estabelecimento := Gb_CodMha;
      if CarregaDadosGeral then
      Begin
        ConfiguraComponente;
        CarregaComponente;
        BoletoFortes.Filtro := fiNenhum;
        BoletoFortes.NomeArquivo := '';
        BoletoFortes.MostrarPreview := Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S'  ;
        Boleto.Imprimir;
      End;
    End;
  end;
end;

procedure TFr_GeraNfe_vda.ImprimeDuplicata;
begin
  inherited;
  if chbx_Duplicata.checked then
    Pc_Imprime_Duplicata(It_Cd_Nota);

end;


procedure TFr_GeraNfe_vda.IniciaVariaveis;
begin
  inherited;

end;

procedure TFr_GeraNfe_vda.Pc_CancelaNFe_Pendente;
var
  Lc_nfl_tipo: String;
Begin
  Try
    IF (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SC') or (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EC') THEN  // diferente de  COMPLEMENTAR
      Lc_nfl_tipo := 'C' // complementar
    else
      Lc_nfl_tipo := 'N';
    if Lc_nfl_tipo = 'N' then
    BEGIN
      //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
      Financeiro.Clear;
      Financeiro.Registro.CodigoNota := It_Cd_Nota;
      Financeiro.deleteByNota;

      Pc_ApagaComissaoFaturamento( It_Cd_Pedido);

      NotaFiscal.Pedido.Itens.ItensIcms.registro.Nota := It_Cd_Nota;
      NotaFiscal.Pedido.Itens.ItensIcms.deletebyNF;

      NotaFiscal.Pedido.Itens.ItensIpi.Registro.Nota := It_Cd_Nota;
      NotaFiscal.Pedido.Itens.ItensIpi.deletebyNF;

      NotaFiscal.Pedido.Itens.ItensPis.Registro.Nota := It_Cd_Nota;
      NotaFiscal.Pedido.Itens.ItensPis.deletebyNF;

      NotaFiscal.Pedido.Itens.ItensCofins.Registro.Nota := It_Cd_Nota;
      NotaFiscal.Pedido.Itens.ItensCofins.DeleteByNF;

      NotaFiscal.Pedido.Itens.ItensISSQN.Registro.Nota := It_Cd_Nota;
      NotaFiscal.Pedido.Itens.ItensISSQN.deleteByNF;

      NotaFiscal.Pedido.Itens.Ibscbs.Registro.Nota := It_Cd_Nota;
      NotaFiscal.Pedido.Itens.Ibscbs.deleteAllByNF;

      Pc_ApagaRetornoNFE( It_Cd_Nota);
      Pc_CancelaVendaComercioEletronico(It_Cd_Pedido);
      Pc_ApagaObservacao( It_Cd_Nota);

      NotaFiscal.Delete;

      Pc_Apaga_conserto( It_Cd_Pedido);
      Pc_ApagaVendedor( It_Cd_Nota);
      Pc_Retornodevolucao(Qr_Itens); // Devolução modelo Genio
      NotaFiscal.AtualizaSeries(Qr_Nota.FieldByName('NFL_TIPO').AsString, Qr_Itens);
      Pc_AtualizarItensNota(Qr_Nota.FieldByName('NFL_TIPO').AsString, 'PENDENTE', It_Cd_Nota, It_Cd_Pedido, Qr_Itens);
      Pc_ApagaICMS_FCP(It_Cd_Nota);
      Pc_AtualizacaoEstoqueNota('PENDENTE', Qr_Nota.FieldByName('PED_TIPO').AsInteger, Qr_Nota.FieldByName('PED_CODIGO').AsInteger);
      Pc_AtualizarItensDevolucao(Qr_Nota.FieldByName('NFL_TIPO').AsString,Qr_ItensDev); // Devolução modelo Winkert

      NotaFiscal.Pedido.Registro.Codigo   := It_Cd_Pedido;
      NotaFiscal.Pedido.Registro.Faturado := 'N';
      NotaFiscal.Pedido.alteraStatus;

      NotaFiscal.Pedido.Despacho.Registro.Pedido := It_Cd_Pedido;
      NotaFiscal.Pedido.Despacho.deleteByPedido;
      if (Fc_Tb_Geral('L', 'VDA_G_CTRL_PARCELA', '') = 'C') then
      Begin
        NotaFiscal.Pedido.Parcelamento.Registro.CodigoPedido := NotaFiscal.Pedido.Registro.Codigo;
        NotaFiscal.Pedido.Parcelamento.deletebyPedido;
      end;
      ApagarPrePaid;
      ApagarPayBAck;
    END
    ELSE
    BEGIN
      cancelaNotaComplementar;
    END;
  Finally
    //Finaliza com mensagem
    Pc_Log_Sistema( Gb_CodMha,
                    GB_Cd_Usuario,
                    (Now),
                    'Operações NF-e - Vendas',
                    Qr_Nota.FieldByName('PED_CODIGO').AsInteger,
                    'Cancelamento NF-e',
                    concat('PEDIDO: ',Qr_Nota.FieldByName('PED_NUMERO').AsString ));

    MensagemPadrao(MENSAGEM, 'S U C E S S O !.' + EOLN + EOLN +
                   'Nota Fiscal Cancelada com Sucesso.' + EOLN +
                   '  Clique em OK para continuar.' + EOLN, ['OK'], [bEscape], mpInformacao);

  End;

end;

function TFr_GeraNfe_vda.ValidaEnviaWhatsAppBoleto: Boolean;
begin
  Result := True;
  boleto.CodigoNota := It_Cd_Nota;
  boleto.Estabelecimento := Gb_CodMha;
  boleto.CarregaDadosGeral;

  if (Length(boleto.Cliente.Empresa.Endereco.Registro.Celular) = 0) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' O Campo celular do cadastro não foi informado.' +EOLN +
                   ' Verifique para continuar'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;

  if (Length(boleto.Cliente.Empresa.Endereco.Registro.Celular) <8) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' O Campo celular do cadastro parece estar incompleto.' +EOLN +
                   ' Verifique para continuar'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End


end;

function TFr_GeraNfe_vda.ValidaEnvioEmail: Boolean;
begin
  Result := True;
end;

function TFr_GeraNfe_vda.ValidaImpressao: boolean;
begin
  Result := True;
end;

end.
