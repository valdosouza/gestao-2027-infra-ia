unit tas_mdfe_operacoes;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Buttons, Vcl.StdCtrls, StrUtils, Vcl.ExtCtrls, Vcl.Menus, ACBrBase, ACBrDFe, ACBrMDFe, ControllerMdfe, pcnConversao, pmdfeConversaoMDFe, TblMdfeloadLocal, TblMdfeUnloadLocal, tblMdfeConductor, Un_DM, Data.DB, STQuery;

type
  TTasMdfeOperacoes = class(TFr_Base)
    pnl_Mdfe: TPanel;
    Lb_titulo_mdfeoperacoes: TLabel;
    MM_Acompanhamento: TMemo;
    E_Obs: TMemo;
    pnl_buttom: TPanel;
    Sb_Transmitir: TSpeedButton;
    Sb_Encerrar: TSpeedButton;
    Sb_sair: TSpeedButton;
    Sb_Envia_Email: TSpeedButton;
    Sb_Imprimir: TSpeedButton;
    Sb_Consultar: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Pnl_Validade: TPanel;
    Pnl_Cert_Validade: TPanel;
    Pnl_Cert_Expira: TPanel;
    ChBx_forca_cosulta: TCheckBox;
    pnl_option: TPanel;
    ACBrMDFe1: TACBrMDFe;
    procedure Sb_EncerrarClick(Sender: TObject);
    procedure Sb_TransmitirClick(Sender: TObject);
    procedure Sb_ConsultarClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure Sb_ImprimirClick(Sender: TObject);
    procedure Sb_Envia_EmailClick(Sender: TObject);
    procedure Sb_sairClick(Sender: TObject);
  private
    { Private declarations }
    //Encerrar , Transmitir , Consultar , Cancelar , Imprimir , E-mail , Sair
    procedure MensagemRetorno;
    function validaEncerrar:Boolean;
    procedure Encerrar;
    function validaTransmitir:Boolean;
    procedure Transmitir;
    function validaConsultar:Boolean;
    procedure Consultar;
    function validaCancelar:Boolean;
    procedure Cancelar;
    function validaImprimir:Boolean;
    procedure Imprimir;
    function validaEnviaEmail:Boolean;
    procedure EnviaEmail;
    function VerificaCancelamento:Boolean;
    function VerificaEncerramento:Boolean;
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    procedure ImagemBotao;Override;
  public
    { Public declarations }
    MotivoCancelamento : String;
    MDFe : TControllerMdfe
  end;

var
  TasMdfeOperacoes: TTasMdfeOperacoes;

implementation

{$R *.dfm}

uses     UN_Sistema, Un_Msg, Un_envia_email, env;

{ TTasMdfeOperacoes }

procedure TTasMdfeOperacoes.CriarVariaveis;
begin
  inherited;
  MDFe := TControllerMdfe.Create(Self);
end;

procedure TTasMdfeOperacoes.FormataTela;
begin
  inherited;

end;


procedure TTasMdfeOperacoes.ImagemBotao;
begin
  CarregaImagemBotao(Sb_Encerrar,'CONFERIR');
  CarregaImagemBotao(Sb_Transmitir,'AUTORIZAR');
  CarregaImagemBotao(Sb_Consultar,'CONSULTAR');
  CarregaImagemBotao(Sb_Cancelar,'CANCELAR NFE');
  CarregaImagemBotao(Sb_Imprimir,'IMPRIMIR');
  CarregaImagemBotao(Sb_Envia_Email,'ENVIA EMAIL');
  CarregaImagemBotao(Sb_sair,'SAIR');
end;

procedure TTasMdfeOperacoes.IniciaVariaveis;
begin
  MDFe.getAllbyId;
  //Passa o operador para ser configurado
  MDFe.Config.Operador := MDFe.Operador;
  MDFe.Config.Configura;
  MDFe.Config.MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);

end;

procedure TTasMdfeOperacoes.MensagemRetorno;
begin
  MM_Acompanhamento.Lines.Add(concat('Situação: ',
                                      MDFe.Retorno.Registro.Situacao.ToString,' - ',
                                      MDFe.Retorno.Registro.Motivo));
  MM_Acompanhamento.Lines.Add('Salvando arquivo no banco ...');
  MM_Acompanhamento.Update;
end;


procedure TTasMdfeOperacoes.Cancelar;
Var
  Lc_NumeroLote: Integer;
  LcPathFile : String;
begin
  with MM_Acompanhamento, MDFe.Operador do
  Begin
    Try
      try
        Clear;
        Lines.Add('Carregando arquivo...');
        MM_Acompanhamento.Update;
        LcPathFile := concat(mdfe.Config.Registro.RepositorioMdfe,'\',
                             mdfe.Retorno.Registro.Arquivo);
        MDFe.Arquivo.Salva_Arq_disco(LcPathFile);
        MDFe.Operador.Manifestos.LoadFromFile(LcPathFile);

        Lines.Add('Iniciando operação de cancelamento..');
        MM_Acompanhamento.Update;
        MDFe.MotivoCancelamento :=Self.MotivoCancelamento;
        MDFe.Cancelar;
        MDFe.Consultar;
        if (MDFe.Retorno.Registro.Situacao = 101) then
        Begin
          MensagemPadrao(MENSAGEM, 'S U C E S S O!' + EOLN + EOLN +
                         'MDFe Cancelada com Sucesso!' + EOLN + EOLN +
                         'Código: ' +IntToStr(MDFe.Retorno.Registro.Situacao) + EOLN +
                         'Motivo: ' + MDFe.Retorno.Registro.Motivo + EOLN,
                         ['OK'], [bEscape], mpInformacao);
          MDFe.SalvaRetorno;
          self.MensagemRetorno;
          MDFe.SalvaArquivoBanco;
        end
        else
        Begin
          MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!' + EOLN + EOLN +
                         'MDfe não pode ser Cancelada!' + EOLN + EOLN +
                        'Código: ' +IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + EOLN +
                        'Motivo: ' + WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo + EOLN,
                         ['OK'], [bEscape], mpAlerta);
        end;
      except
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                       'Houve um erro ao tentar cancelar a MDFe' + EOLN +
                       'Código: ' +IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + EOLN +
                       'Motivo: ' + WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo + EOLN,
                       ['OK'], [bEscape], mpAlerta);
      end;
    Finally
      Lines.Add('Processamento Finalizado!');
      MM_Acompanhamento.Update;
    End;
  end;

end;

procedure TTasMdfeOperacoes.Consultar;
Var
  Lc_Cd_Retorno: Integer;
begin
  if Mdfe.Arquivo.exist and (Mdfe.Retorno.Registro.Situacao > 0) then
  Begin
    MM_Acompanhamento.Lines.Add('Carregando arquivo...');
    MM_Acompanhamento.Update;
    MDFe.Arquivo.Salva_Arq_disco(concat(
                          mdfe.Config.Registro.RepositorioMdfe,'\',
                          mdfe.Retorno.Registro.Arquivo
    ));
    MDFe.Operador.Manifestos.LoadFromFile(concat(
                          mdfe.Config.Registro.RepositorioMdfe,'\',
                          mdfe.Retorno.Registro.Arquivo
    ));
  end
  else
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Update;
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
    MM_Acompanhamento.Update;
    Mdfe.Gerar;
  End;
  if Trim(ExtractFileName(MDFe.Operador.Manifestos[0].NomeArq)) <> '' then
  Begin
    MM_Acompanhamento.Lines.Add('Consultando a MDFe...');
    MM_Acompanhamento.Update;
    MDFe.Consultar;

    MM_Acompanhamento.Lines.Add('Salvando retorno...');
    MM_Acompanhamento.Update;
    MDFe.SalvaRetorno;
    self.MensagemRetorno;
    MM_Acompanhamento.Update;
    MDFe.SalvaArquivoBanco;
  end;
end;

procedure TTasMdfeOperacoes.EnviaEmail;
Var
  Lc_Aux : String;
  Lc_Destinatario : TStringList;
  Lc_AssuntoEmail : string;
  Lc_Corpo : String;
  lc_anexo :TStringList;
  LcEnviaemail : TFr_envia_email;
begin
  Lc_Destinatario := TStringList.Create;
  Lc_Anexo        := TStringList.Create;
  //Verifica se o email do Destinatario informado e mostra o imput
  InputQuery('Enviar Email', 'Email de destino',Lc_Aux );
  if Length(Trim(Lc_Aux))>0 then Lc_Destinatario.Add(' '+Lc_Aux);

  if Lc_Destinatario.Count = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'e-mail não encontrado no Cadastro e/ou não informado.' + EOLN +
                   '          Verifique  e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);

    exit;
  end;

  Lc_Corpo := Concat(
                  '<html>',
                  '<head>',
                  '  <meta content="text/html; charset=ISO-8859-1"',
                  ' http-equiv="content-type">',
                  '</head>',
                  '<body>',
                  'Ol&aacute;,<br>',
                  '<br>',
                  'Segue em Anexo, documento referente a MDFE do n&uacute;mero: ',MDFe.Registro.Numero,
                  '<br>',
                  '</body>',
                  '</html>'
            );
  LcEnviaemail := TFr_envia_email.Create(nil);
  Try
    with LcEnviaemail do
    Begin
      Lc_AssuntoEmail := 'Envio de MDFE Nº '+ MDFe.Registro.Numero;
      //Gera o PDF
      MDFe.ImprimirPDF;
      lc_anexo.Add(MDFe.Operador.Manifestos[0].NomeArq);
      lc_anexo.Add( MDFe.Operador.DAMDFE.ArquivoPDF);
      if (Fc_Tb_Geral('L','GRL_G_EMAIL_SISTEMANFE','S') = 'S') then
        It_Tipo_Envio := 'N'
      else
        It_Tipo_Envio := 'S';
      It_Assunto := Lc_AssuntoEmail;
      It_Destino := Lc_Destinatario;
      It_Corpo := Lc_Corpo;
      It_Anexo   := lc_anexo;
      ShowModal;
    end;
  Finally
    FreeAndNil(LcEnviaemail);
  End;
end;

procedure TTasMdfeOperacoes.Encerrar;
Var
  Lc_NumeroLote: Integer;
  LcPathFile : String;
begin
  with MM_Acompanhamento, MDFe.Operador do
  Begin
    Try
      try
        Clear;
        Lines.Add('Carregando arquivo...');
        MM_Acompanhamento.Update;
        LcPathFile := concat(mdfe.Config.Registro.RepositorioMdfe,'\',
                             mdfe.Retorno.Registro.Arquivo);
        MDFe.Arquivo.Salva_Arq_disco(LcPathFile);
        MDFe.Operador.Manifestos.LoadFromFile(LcPathFile);

        Lines.Add('Iniciando operação de Encerramento..');
        MM_Acompanhamento.Update;
        MDFe.Encerrar;
        MDFe.Consultar;
        if (MDFe.Retorno.Registro.Situacao = 132) then
        Begin
          MensagemPadrao('Mensagem', 'S U C E S S O!' + EOLN + EOLN +
                         'MDFe Encerrada com Sucesso!' + EOLN + EOLN +
                         'Código: ' +IntToStr(MDFe.Retorno.Registro.Situacao) + EOLN +
                         'Motivo: ' + MDFe.Retorno.Registro.Motivo + EOLN,
                         ['OK'], [bEscape], mpInformacao);
          MDFe.SalvaRetorno;
          self.MensagemRetorno;
          MM_Acompanhamento.Update;
          MDFe.SalvaArquivoBanco;
        end
        else
        Begin
          MensagemPadrao('Mensagem', 'I N F O R M A Ç Ã O!' + EOLN + EOLN +
                         'MDFe não pode ser Encerrada!' + EOLN + EOLN +
                        'Código: ' +IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + EOLN +
                        'Motivo: ' + WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo + EOLN,
                         ['OK'], [bEscape], mpAlerta);
        end;
      except
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                       'Houve um erro ao tentar Encerrar a MDFe' + EOLN +
                       'Código: ' +IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + EOLN +
                       'Motivo: ' + WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo + EOLN,
                       ['OK'], [bEscape], mpAlerta);
      end;
    Finally
      Lines.Add('Processamento Finalizado!');
      MM_Acompanhamento.Update;
    End;
  end;

end;

procedure TTasMdfeOperacoes.Imprimir;
begin
//  MM_Acompanhamento.Lines.Add('Carregando arquivo...');
  MM_Acompanhamento.Lines.Add('Imprimindo...');
  MM_Acompanhamento.Update;
  MDFe.Imprimir;
end;

procedure TTasMdfeOperacoes.Transmitir;
Begin
  if Trim(ExtractFileName(MDFe.Operador.Manifestos[0].NomeArq)) <> '' then
  Begin
    MM_Acompanhamento.Lines.Add('Consultando o Arquivo...');
    MM_Acompanhamento.Update;
    MDFe.Transmitir;
    MDFe.SalvaRetorno;
    self.MensagemRetorno;
    MM_Acompanhamento.Update;
    MDFe.SalvaArquivoBanco;
  end;
end;

procedure TTasMdfeOperacoes.Sb_CancelarClick(Sender: TObject);
begin
  Pc_ProcesoAguarde(self, 'I');
  self.Enabled := False;
  try
    if validaCancelar then
      Cancelar;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
  end;

end;

procedure TTasMdfeOperacoes.Sb_ConsultarClick(Sender: TObject);
begin
  Pc_ProcesoAguarde(self, 'I');
  MM_Acompanhamento.Update;
  self.Enabled := False;
  try
    Try
      MM_Acompanhamento.Clear;
      if validaConsultar then
        Consultar;
    except
      on E: Exception do
        MM_Acompanhamento.Lines.Add(E.ClassName + ' Erro Encontrado : ' + E.Message);
    end;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
    MM_Acompanhamento.Lines.Add('Finalização do processo!');
    MM_Acompanhamento.Update;
  end;
end;

procedure TTasMdfeOperacoes.Sb_EncerrarClick(Sender: TObject);
begin
  Pc_ProcesoAguarde(self, 'I');
  self.Enabled := False;
  try
    if validaEncerrar then
        Encerrar;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
  end;


end;

procedure TTasMdfeOperacoes.Sb_Envia_EmailClick(Sender: TObject);
begin
  Pc_ProcesoAguarde(self, 'I');
  self.Enabled := False;
  try
    if validaEnviaEmail then
        EnviaEmail;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
  end;
end;

procedure TTasMdfeOperacoes.Sb_ImprimirClick(Sender: TObject);
begin
  Pc_ProcesoAguarde(self, 'I');
  self.Enabled := False;
  try
    if validaImprimir then
    Begin
      Imprimir;
    End;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
  end;
end;

procedure TTasMdfeOperacoes.Sb_sairClick(Sender: TObject);
begin
  close;
end;

procedure TTasMdfeOperacoes.Sb_TransmitirClick(Sender: TObject);
begin
  if validaTransmitir then
  begin
    Try
      Try
        Pc_ProcesoAguarde(self, 'I');
        MM_Acompanhamento.Update;

        self.Enabled := False;
        MM_Acompanhamento.Lines.Add('Carregando Certificado...');
        MM_Acompanhamento.Update;
        MDFe.Config.CarregaCertificado;
        Consultar;
        if MDFe.Retorno.Registro.Situacao = 0 then
        Begin
          MM_Acompanhamento.Lines.Add('Gerando Arquivo...');
          MM_Acompanhamento.Update;
          MDFe.Gerar;
          MM_Acompanhamento.Lines.Add('Transmitindo arquivo...');
          MM_Acompanhamento.Update;
          Transmitir;
        End;
      except
        on E: Exception do
          MM_Acompanhamento.Lines.Add(E.ClassName + ' Erro Encontrado : ' + E.Message);
      end;
    Finally
      Pc_ProcesoAguarde(self, 'F');
      self.Enabled := True;
      self.Activate;
      self.BringToFront;
    End;
  end;
end;

procedure TTasMdfeOperacoes.setPerfil;
begin
  inherited;

end;

function TTasMdfeOperacoes.validaCancelar: Boolean;
begin
  Result := True;
  // Limpa as consultas do webservice;
  if not Mdfe.VerificaStatusServico then
  Begin
    Result := False;
    Exit;
  end;

  if not MDFe.exist then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não foi possivel Carregar os dados da MDFe.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 0) then
  Begin
    MensagemPadrao(ATENCAO,
                   'MDFe não enviada para autorização.' + EOLN +
                   'Impossível continuar.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if VerificaCancelamento then
  Begin
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 4) then
  Begin
    MensagemPadrao(ATENCAO,
                   'MDFe já encerrada.' + EOLN +
                   'Impossível continuar.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 1) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe enviada mas ainda não possue autorização.' + EOLN +
                   'Consulte antes de tentar cancelar.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if not Mdfe.Arquivo.exist then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Arquivo XML não encontrado.' + EOLN +
                   'Consulte antes de tentar cancelar.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

  MotivoCancelamento := '';
  if not(InputQuery('WebServices Cancelamento', 'Justificativa',MotivoCancelamento)) then
  Begin
    MensagemPadrao(ATENCAO,
                   'Justificativa de cancelamento deve ser informada' + EOLN +
                   'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if Length(Trim(MotivoCancelamento)) < 15 then
  Begin
    MensagemPadrao(ATENCAO,
                    'Justificativa de cancelamento não' + EOLN +
                    'pode ser inferior a 15 caracteres.' + EOLN +
                    'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasMdfeOperacoes.validaConsultar: Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  MM_Acompanhamento.Lines.Add('Validando informações...');
  MM_Acompanhamento.Update;
  // Limpa as consultas do webservice;
  if not Mdfe.VerificaStatusServico then
  Begin
    Result := False;
    Exit;
  end;

  if not MDFe.exist then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não foi possivel Carregar os dados da MDFe.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;
  if ChBx_forca_cosulta.checked then
  Begin
    MDFe.Retorno.Registro.Situacao := 2;
  End;

  if (MDFe.Retorno.Registro.Situacao = 0) then
  Begin
    MensagemPadrao(ATENCAO,
                   'MDFe não enviada para autorização.' + EOLN +
                   'Envie antes de tentar Consultar.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfeOperacoes.validaEnviaEmail: Boolean;
begin
  Result := True;
  // Limpa as consultas do webservice;
  if not Mdfe.VerificaStatusServico then
  Begin
    Result := False;
    Exit;
  end;

  if not MDFe.exist then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não foi possivel Carregar os dados da MDFe.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 0) then
  Begin
    MensagemPadrao(ATENCAO,
                   'MDFe não enviada para autorização.' + EOLN +
                   'Envie antes de tentar Imprimir.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 1) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe enviada mas ainda não possue autorização.' + EOLN +
                   'Consulte antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if not Mdfe.Arquivo.exist then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Arquivo XML não encontrado.' + EOLN +
                   'Consulte antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfeOperacoes.validaEncerrar: Boolean;
begin
  Result := True;
  // Limpa as consultas do webservice;
  if not Mdfe.VerificaStatusServico then
  Begin
    Result := False;
    Exit;
  end;

  if not MDFe.exist then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não foi possivel Carregar os dados da MDFe.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 0) then
  Begin
    MensagemPadrao(ATENCAO,
                   'MDFe não enviada para autorização.' + EOLN +
                   'Envie antes de tentar Imprimir.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if not (MDFe.Retorno.Registro.Situacao = 2) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe sem autorização não pode ser encerrada.' + EOLN +
                   'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasMdfeOperacoes.validaImprimir: Boolean;
begin
  Result := True;
  // Limpa as consultas do webservice;
  if not Mdfe.VerificaStatusServico then
  Begin
    Result := False;
    Exit;
  end;

  if not MDFe.exist then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não foi possivel Carregar os dados da MDFe.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 0) then
  Begin
    MensagemPadrao(ATENCAO,
                   'MDFe não enviada para autorização.' + EOLN +
                   'Envie antes de tentar Imprimir.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (MDFe.Retorno.Registro.Situacao = 1) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe enviada mas ainda não possue autorização.' + EOLN +
                   'Consulte antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

  if not Mdfe.Arquivo.exist then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Arquivo XML não encontrado.' + EOLN +
                   'Consulte antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasMdfeOperacoes.validaTransmitir: Boolean;
begin
  Result := true;
  // Limpa as consultas do webservice;
  if not Mdfe.VerificaStatusServico then
  Begin
    Result := False;
    Exit;
  end;

  if not MDFe.exist then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Não foi possivel Carregar os dados da MDFe.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasMdfeOperacoes.VerificaCancelamento: Boolean;
begin

end;

function TTasMdfeOperacoes.VerificaEncerramento: Boolean;
begin

end;

end.
