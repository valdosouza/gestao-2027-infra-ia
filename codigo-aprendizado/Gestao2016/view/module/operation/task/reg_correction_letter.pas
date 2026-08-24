unit reg_correction_letter;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, STQuery, Vcl.DBCtrls, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, ACBrNFe, pcnConversao, ACBrNFeDANFEClass, controllerCartaCorrecao, AcbrUtil, pcnLeitor, ACBrNFeNotasFiscais, ACBrNFeWebServices, ACBrNFeDANFeRLClass, STDataSet,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TRegCorrectionLetter = class(TBaseRegistry)
    Sb_Confirmar: TSpeedButton;
    Sb_Enviar: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Label1: TLabel;
    E_Detalhe: TMemo;
    Qr_Carta_Correcao: TSTQuery;
    Ds_Qr_Correcao: TDataSource;
    Lb_DetalhesPedido: TLabel;
    DBG_Pesquisa: TDBGrid;
    Pnl_EnviaCarta: TPanel;
    Label2: TLabel;
    Sb_FechaEnvio: TButton;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    MM_Acompanhamento: TMemo;
    TabSheet1: TTabSheet;
    WBResposta: TWebBrowser;
    TabSheet3: TTabSheet;
    MemoResp: TMemo;
    procedure Sb_ConfirmarClick(Sender: TObject);
    procedure Sb_EnviarClick(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure Qr_Carta_CorrecaoAfterOpen(DataSet: TDataSet);
    procedure Qr_Carta_CorrecaoAfterScroll(DataSet: TDataSet);
    procedure Sb_FechaEnvioClick(Sender: TObject);
  private
    CartaCorrecao : TControllerCartaCorrecao;
    FFileXML : String;
    FFilePDF : String;
    FPath : String;
    FCodigoNotaFiscal: Integer;
    FChaveXML: String;

    procedure AtualizaLista;


    Function ValidaEnvioCartaCorrecao():Boolean;
    procedure EnviarCartaCorrecao;
    procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);

    Procedure TrataRetorno(var Pc_Cd_Retorno:Integer;Pc_Motivo,Pc_Protocolo :String;Pc_Dt_Protocolo:Tdate);
    function EnviaNfeEmail:Boolean;

    procedure PreparaArquivoParaEnvio;

    function ValidaEnviaWhatsApp:Boolean;
    procedure EnviaWhatsApp;

    function ValidaEnvioEmail:Boolean;
    procedure EnvioEmail;

    function ValidaImpressao():Boolean;
    function CarregaNotaFiscal:Boolean;
    procedure setFCodigoNotaFiscal(const Value: Integer);
    procedure setFChaveXML(const Value: String);


  protected
    procedure execShorCutKeyF9;Override;
    procedure execShorCutKeyF10;Override;
    procedure execShorCutKeyF11;Override;

    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

    procedure EditionControl;Override;

  public
    property CodigoNotaFiscal : Integer read FCodigoNotaFiscal write setFCodigoNotaFiscal;
    property ChaveXML : String read FChaveXML write setFChaveXML;
  end;

var
  RegCorrectionLetter: TRegCorrectionLetter;

implementation

{$R *.dfm}

uses     Un_DM, UN_Sistema, UN_MSG, un_Padrao, UN_Principal, env, Un_Nota_Fiscal, Un_Regra_Negocio, Un_envia_email, RN_NotaFiscalEletronica3X, WhatsApp;
procedure TRegCorrectionLetter.AtualizaLista;
begin
  Qr_Carta_Correcao.Active := False;
  Qr_Carta_Correcao.ParamByName('NFL_CODIGO').AsInteger := FCodigoNotaFiscal;
  Qr_Carta_Correcao.Active := true;
  Qr_Carta_Correcao.Last;

end;

procedure TRegCorrectionLetter.Cancel;
begin
  inherited;

end;

function TRegCorrectionLetter.CarregaNotaFiscal: Boolean;
Var
  Lc_Path : String;
  Lc_FileXML : String;
  Lc_Cd_Nota : Integer;
begin
  Result := True;
  Lc_Cd_Nota := Qr_Carta_Correcao.FieldByName('NFL_CODIGO').asInteger;
  //Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Fc_ChaveDanfe_XMl(Lc_Cd_Nota);
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  //Salva o Arquivo XML da NOta no diretorio
  If not Fc_VerificaExistenciaArquivoNFEXML(1,Lc_Cd_Nota,Lc_Path,Lc_FileXMl) then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML da Nota não encontrado...');
    MM_Acompanhamento.Lines.Add('Fa�a uma consulta para baixar o xml da nota e depois continue...');
    Result := False;
    exit;
    //Prepara a danfe para o envio
  end;
  if Trim(Lc_FileXML)<>'' then
  Begin
    Pc_CarregaComponenteNFE(Lc_Path,Lc_FileXMl);
  end;
end;

procedure TRegCorrectionLetter.Change;
begin
  inherited;
  e_Detalhe.SetFocus;
end;

procedure TRegCorrectionLetter.ClearAllFields;
begin
  inherited;

end;

procedure TRegCorrectionLetter.CriarVariaveis;
begin
  inherited;
  CartaCorrecao := TControllerCartaCorrecao.Create(self);
end;

procedure TRegCorrectionLetter.Delete;
begin
  inherited;
  CartaCorrecao.Delete;
  AtualizaLista;
end;

procedure TRegCorrectionLetter.EditionControl;
begin
  inherited;
  Sb_Confirmar.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 );
  Sb_Enviar.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 );
  SB_Imprimir.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 );
  e_Detalhe.ReadOnly := ( EditionState = 'B' );
end;

function TRegCorrectionLetter.EnviaNfeEmail: Boolean;
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
  if (DM.Qr_Estabelecimento.FieldByName('EMP_EMAIL').AsString) <> '' then         //Verifica se a empresa tem email, se tem email entra no begin
    begin
    if DM.Qr_Nf_Eletronica.FieldByName('NFE_COPIA_EMAIL').AsString = 'S' then  // se tive marcado pra manda copia da nfe para email da empresa
      Lc_Destinatario.Add(' ' + DM.Qr_Estabelecimento.FieldByName('EMP_EMAIL').AsString);
    end;

  //Verifica se o cliente Possue email
  if Length(Qr_Carta_Correcao.FieldByName('EMP_EMAIL').AsString)>0 then
    Lc_Destinatario.Add(' ' + Qr_Carta_Correcao.FieldByName('EMP_EMAIL').AsString) ;
  //Verifica se o contador Possue email
  if Length(DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString)>0 then
    Lc_Destinatario.Add(' ' + DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString);
  //Verifica se tem transportadora e se tem email
  Pc_AtivaTransportadora(Qr_Carta_Correcao.FieldByName('NFL_CODTRP').AsInteger);
  if Length(DM.Qr_Transportadora.FieldByName('EMP_EMAIL').AsString)>0 then
    Lc_Destinatario.Add(' ' + DM.Qr_Transportadora.FieldByName('EMP_EMAIL').AsString);

  Lc_AssuntoEmail := 'Envio de NF-e N� '+ Qr_Carta_Correcao.FieldByName('NFL_NUMERO').AsString;

  //Verifica se o email do Destinatario informado e mostra o imput
  if Lc_Destinatario.Count = 0 then
    Begin
    InputQuery('Enviar Email', 'Email de destino',Lc_Aux );
    if Length(Trim(Lc_Aux))>0 then Lc_Destinatario.Add(' '+Lc_Aux)
    end;

  if Lc_Destinatario.Count = 0 then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'e-mail não encontrado no Cadastro e/ou não informado.' + EOLN +
                   '          Verifique  e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);

    exit;
    end;
  Lc_Corpo := '<html>'+
              '<head>'+
              '  <meta content="text/html; charset=ISO-8859-1"'+
              ' http-equiv="content-type">'+
              '</head>'+
              '<body>'+
              'Ol&aacute;,<br>'+
              '<br>'+
              'Segue em Anexo, documento referente a Carta de Correção referente a NF-e do n&uacute;mero: '  + Qr_Carta_Correcao.FieldByName('NFL_NUMERO').AsString+
              '<br>'+
              '</body>'+
              '</html>';

  TRy
    LcEnviaemail := TFr_envia_email.create(nil);
    with LcEnviaemail do
    Begin
      Lc_AssuntoEmail := 'Carta de Correção Referente a NF-e: ' + Qr_Carta_Correcao.FieldByName('NFL_NUMERO').AsString;
      lc_anexo.Add(FPath + '\' +  FFileXML);
      lc_anexo.Add(FPath + '\' +  FFilePDF);
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

procedure TRegCorrectionLetter.EnviarCartaCorrecao;
var
  Lc_idLote, Lc_codOrgao, Lc_nSeqEvento : Integer;
  Lc_Chave, Lc_CNPJ, Lc_Correcao : string;
  Lc_Stat : Integer;
  Lc_Motivo : String;
  Lc_Protocolo : String;
  Lc_Dt_Protocolo : TDate;
  lc_Arquivo : STring;
begin

  MM_Acompanhamento.Lines.Clear;
  MM_Acompanhamento.Lines.Add('CARREGANDO OS DADOS DA CARTA DE CORRE��O...');
  MM_Acompanhamento.Update;
  //

  //WebServices Carta de Correção', 'Chave da NF-e'
  Lc_Chave := Qr_Carta_Correcao.FieldByName('CCE_CHAVE').AsString;

  //WebServices Carta de Correção', 'Identificador de controle do Lote de envio do Evento
  Lc_idLote := Qr_Carta_Correcao.FieldByName('CCE_CODIGO').AsInteger;

  //WebServices Carta de Correção', 'Código do �rg�o de recepção do Evento
  Lc_codOrgao := Qr_Carta_Correcao.FieldByName('CCE_CODUFE').AsInteger;

  //WebServices Carta de Correção', 'CNPJ ou o CPF do autor do Evento
  Lc_CNPJ := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;

  //WebServices Carta de Correção', 'Sequencial do evento para o mesmo tipo de evento',
  Lc_nSeqEvento := Qr_Carta_Correcao.FieldByName('CCE_SEQUENCIA').AsInteger;

  //WebServices Carta de Correção', 'Correção a ser considerada
  Lc_Correcao := Qr_Carta_Correcao.FieldByName('CCE_DETALHE').AsString;

  MM_Acompanhamento.Lines.Add('PREPARANDO O ENVIO...');
  MM_Acompanhamento.Update;
  with Fr_Principal do
  Begin
    Nfe.EventoNFe.Evento.Clear;
    Nfe.EventoNFe.idLote := Lc_idLote ;
    with Nfe.EventoNFe.Evento.Add do
    begin
       infEvento.chNFe := Lc_Chave;
       infEvento.CNPJ   := Lc_CNPJ;
       infEvento.dhEvento := now;
       infEvento.tpEvento := teCCe;
       infEvento.nSeqEvento := Lc_nSeqEvento;
       infEvento.detEvento.xCorrecao := Lc_Correcao;
       infEvento.cOrgao := Lc_codOrgao;
    end;
    TRY
      MM_Acompanhamento.Lines.Add('ENVIANDO OS DADOS');
      MM_Acompanhamento.Update;
      Nfe.EnviarEvento(Lc_idLote);
    finally
      Lc_Stat         := Nfe.WebServices.EnvEvento.cStat;
      Lc_Motivo       := Nfe.WebServices.EnvEvento.xMotivo;
      MM_Acompanhamento.Lines.Add(concat(IntToStr(Lc_Stat),' -' , Lc_Motivo));
      MemoResp.Lines.Text := UTF8Encode(Nfe.WebServices.EnvEvento.RetWS);
      MM_Acompanhamento.Lines.Add('VERIFICANDO RETORNO...');
      MM_Acompanhamento.Update;
      with Nfe.WebServices.EnvEvento.EventoRetorno do
      Begin
        Lc_Stat         := retEvento.Items[0].RetInfEvento.cStat;
        Lc_Motivo       := retEvento.Items[0].RetInfEvento.xMotivo;
        Lc_Protocolo    := retEvento.Items[0].RetInfEvento.nProt;
        Lc_Dt_Protocolo := retEvento.Items[0].RetInfEvento.dhRegEvento;
      End;
      MM_Acompanhamento.Lines.Add(concat(IntToStr(Lc_Stat),' -' , Lc_Motivo));
      LoadXML(MemoResp, WBResposta);
      if Lc_Stat = 135 then
      Begin
        TrataRetorno(Lc_Stat,Lc_Motivo, Lc_Protocolo, Lc_Dt_Protocolo);
      End;
      MM_Acompanhamento.Lines.Add('FINALIZÇÃO DO PROCESSO...');
      MM_Acompanhamento.Update;
      Sb_FechaEnvio.Enabled := True;
    end;
  end;


end;

procedure TRegCorrectionLetter.EnviaWhatsApp;
Var
  LcW : TWhatsApp;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    PreparaArquivoParaEnvio;

    LcW := TWhatsApp.create(nil);
    LcW.Mensagem := concat('Ola, Segue PDF da carta de correcao referente a NF-e N� '+ Qr_Carta_Correcao.FieldByName('NFL_NUMERO').AsString);
    LcW.ReceiverNumber := Qr_Carta_Correcao.FieldByName('END_CELULAR').AsString;
    //Agora Envia o Anexo PDF
    LcW.Arquivo := concat(FPath,'\',FFilePDF);
    LcW.RegisterMessage;
    //Agora Envia o Anexo XML
    LcW.Mensagem := concat('Segue Tamb�m XML da carta de correção referente a NF-e N� '+ Qr_Carta_Correcao.FieldByName('NFL_NUMERO').AsString);
    LcW.Arquivo := concat(FPath,'\',FFileXML);
    LcW.RegisterMessage;
    LcW.Send;
  finally
    FreeAndNil(LcW);
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TRegCorrectionLetter.EnvioEmail;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    PreparaArquivoParaEnvio;
    EnviaNfeEmail;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TRegCorrectionLetter.execShorCutKeyF10;
begin
  if Sb_Enviar.Enabled then Sb_EnviarClick(Self);
end;

procedure TRegCorrectionLetter.execShorCutKeyF11;
begin
  if SB_Imprimir.Enabled then SB_ImprimirClick(Self);
end;

procedure TRegCorrectionLetter.execShorCutKeyF9;
begin
  if Sb_Confirmar.Enabled then Sb_ConfirmarClick(Self);
end;

procedure TRegCorrectionLetter.FormataTela;
Var
  Lc_top,lc_left : Integer;
Begin
  Pnl_EnviaCarta.Visible := False;
  Lc_top := trunc((Height - Pnl_EnviaCarta.Height)/2);
  lc_left := trunc((Width - Pnl_EnviaCarta.Width)/2);
  Pnl_EnviaCarta.Top := Lc_top;
  Pnl_EnviaCarta.Left := lc_left;
end;

procedure TRegCorrectionLetter.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(Sb_Enviar,'ENVIA EMAIL');
  CarregaImagemBotao(SB_Imprimir,'IMPRIMIR');
end;

procedure TRegCorrectionLetter.IniciaVariaveis;
Var
  Lc_Ok : Boolean;
Begin
  Pc_CarregaDadosEmitente(true);
  AtualizaLista;
  Pc_AtivaConfiguracaoNFe;
  Pc_FormataModeloCartaCorrecao;
  ShowData;
end;

procedure TRegCorrectionLetter.Insert;
begin

  if not Qr_Carta_Correcao.Active then  Qr_Carta_Correcao.Active := True;
  Qr_Carta_Correcao.Last;
  CartaCorrecao.clear;
  CartaCorrecao.Registro.Codigo := 0;
  if (Qr_Carta_Correcao.RecordCount >0 ) then
    CartaCorrecao.Registro.Sequencia := Qr_Carta_Correcao.FieldByName('CCE_SEQUENCIA').AsInteger + 1
  else
    CartaCorrecao.Registro.Sequencia := 1;
  inherited;
  e_Detalhe.SetFocus;
end;

procedure TRegCorrectionLetter.LoadXML(MyMemo: TMemo;
  MyWebBrowser: TWebBrowser);
begin
  MyMemo.Lines.SaveToFile(ExtractFileDir(application.ExeName)+'temp.xml');
  MyWebBrowser.Navigate(ExtractFileDir(application.ExeName)+'temp.xml');

end;


procedure TRegCorrectionLetter.PreparaArquivoParaEnvio;
Var
  CodigoOrgao : Integer;
begin
  //Ativa dados do Estabelecimento
  Pc_AtivaEstabelecimento();
  //Ativa os dados das configurções da Nfe
  Pc_AtivaConfiguracaoNFe;
  //Define o caminho e o arquivo da Nota Fiscal
  FFileXML := Fc_ChaveDanfe_XMl(FCodigoNotaFiscal);
  FPath := Fc_TrazRepositorio('NFE_REPOSITORIO');
  //Salva o Arquivo XML da NOta no diretorio
  Fc_VerificaExistenciaArquivoNFEXML(1,FCodigoNotaFiscal,FPath,FFileXMl);
  CodigoOrgao := StrToIntDef(copy(FFileXMl,1,2),0);
  Pc_CarregaComponenteNFE(FPath,FFileXMl);
  //Define o nome do arquivo do XML
  FFileXML := Copy(FFileXML,1,(Length(FFileXML) - 4))+ '-ProcEventoNFe.xml';
  //Salva o Arquivo XML da NOta no diretorio
  Fc_VerificaExistenciaArquivoNFEXML(2,CartaCorrecao.Registro.Codigo,FPath,FFileXMl);
  //Carrega o arquivo no componente
  Pc_CarregaComponenteEvento(Qr_Carta_Correcao.FieldByName('CCE_CODIGO').asinteger,
                             CodigoOrgao,
                             FPath,FFileXMl,'','',Date);
    //Define o nome do arquivo do PDF
  with Fr_Principal.Nfe do
  Begin
    //Lc_FilePDF := Copy(Lc_FileXML,1,(Length(Lc_FileXML) - 4))+ 'evento.pdf';
    FFilePDF := OnlyNumber(EventoNFe.Evento[0].InfEvento.Id);
    FFilePDF := FFilePDF + '-procEventoNFe.pdf';
    //PathWithDelim(DANFE.PathPDF) +
  end;
  //Salva o Arquivo em formato PDF
  Pc_SalvaEventoArquivoPDF(FPath,FFilePDF);
end;

procedure TRegCorrectionLetter.Qr_Carta_CorrecaoAfterOpen(DataSet: TDataSet);
begin
  Qr_Carta_Correcao.FetchAll;
  ShowData;
end;

procedure TRegCorrectionLetter.Qr_Carta_CorrecaoAfterScroll(DataSet: TDataSet);
begin
  ShowData;
end;

procedure TRegCorrectionLetter.Save;
begin
  with CartaCorrecao do
  Begin
    Registro.Codnfl       := FCodigoNotaFiscal;
    Registro.Data         := Date;
    Registro.Chave        := FChaveXML;
    Registro.Codufe       := DM.Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsInteger;
    //Registro.Sequencia  :=
    Registro.Detalhe      :=  e_Detalhe.Text;
    //Registro.Codsit       :=
    //Registro.Motivo       :=
    //Registro.Protocolo    :=
    //Registro.DtProtocolo  :=
  End;
  CartaCorrecao.save;
  AtualizaLista;
  inherited;
end;

procedure TRegCorrectionLetter.Sb_ConfirmarClick(Sender: TObject);
begin
  //Envia a Carta de Correção
  if ValidaEnvioCartaCorrecao then
  Begin
    //Desativa as outras edições
    Pnl_Botao.Enabled := False;
    //Mostra o Panel de Envio
    Pnl_EnviaCarta.Visible := True;
    //Inicia o processo de envio
    EnviarCartaCorrecao;
  end;
end;

procedure TRegCorrectionLetter.Sb_EnviarClick(Sender: TObject);
begin
  //Envia a Carta de Correção por email
  if ValidaEnvioEmail then
    EnvioEmail
end;

procedure TRegCorrectionLetter.Sb_FechaEnvioClick(Sender: TObject);
begin
  //Mostra o Panel de Envio
  Pnl_EnviaCarta.Visible := False;

  //Desativa as outras edições
  Pnl_Botao.Enabled := TRue;
end;

procedure TRegCorrectionLetter.SB_ImprimirClick(Sender: TObject);
Var
  wnProt: TLeitor;
  Lc_Path : String;
  Lc_FileXML : String;
  Lc_Cd_vinculo : integer;
  CodigoOrgao : Integer;
begin
  if ValidaImpressao then
  Begin
    try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      //Define o caminho e o arquivo da Nota Fiscal
      Lc_FileXML := Fc_ChaveDanfe_XMl(FCodigoNotaFiscal);
      Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
      Lc_Cd_vinculo := 0;
      //Salva o Arquivo XML da NOta no diretorio
      Fc_VerificaExistenciaArquivoNFEXML(1,FCodigoNotaFiscal,Lc_Path,Lc_FileXMl);
      Pc_CarregaComponenteNFE(Lc_Path,Lc_FileXMl);
      CodigoOrgao := StrToIntDef(copy(Lc_FileXMl,1,2),0);
      //Salva o arquivo XMl da Carta no Diretorio

      Lc_FileXML := Qr_Carta_Correcao.FieldByName('CCE_CODIGO').AsString + '-ped-eve.xml';
      Fc_VerificaExistenciaArquivoNFEXML(2,FCodigoNotaFiscal,Lc_Path,Lc_FileXMl);
      Pc_CarregaComponenteEvento(Qr_Carta_Correcao.FieldByName('CCE_CODIGO').asinteger,
                                 CodigoOrgao,
                                  Lc_Path,
                                  Lc_FileXMl,
                                  Qr_Carta_Correcao.FieldByName('CCE_MOTIVO').AsString,
                                  Qr_Carta_Correcao.FieldByName('CCE_PROTOCOLO').AsString,
                                  Qr_Carta_Correcao.FieldByName('CCE_DT_PROTOCOLO').AsDateTime);
      Pc_ImprimeCCEEvento;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    end;
  end;
end;

procedure TRegCorrectionLetter.setFChaveXML(const Value: String);
begin
  FChaveXML := Value;
end;

procedure TRegCorrectionLetter.setFCodigoNotaFiscal(const Value: Integer);
begin
  FCodigoNotaFiscal := Value;
end;

procedure TRegCorrectionLetter.setPerfil;
begin
  Pf_Inserir := True;
  Pf_Alterar := True;
  Pf_Excluir := True;
  Pf_Visualizar := True;
end;

procedure TRegCorrectionLetter.ShowData;
begin
  CartaCorrecao.Registro.Codigo := Qr_Carta_Correcao.FieldByName('CCE_CODIGO').AsInteger;
  CartaCorrecao.getByKey;
  CodigoRegistro := CartaCorrecao.Registro.Codigo;
  if ( CodigoRegistro > 0 ) then
    E_Detalhe.Text := CartaCorrecao.Registro.Detalhe
  else
    E_Detalhe.clear;
  EditionState := 'B';
  EditionControl;

end;

procedure TRegCorrectionLetter.ShowNoData;
begin
  inherited;
  E_Detalhe.Clear;
end;

procedure TRegCorrectionLetter.TrataRetorno(var Pc_Cd_Retorno: Integer; Pc_Motivo,Pc_Protocolo: String; Pc_Dt_Protocolo: Tdate);
Var
  Lc_Caminho, nome_xml,lc_path,lc_conteudo:String;
  lc_tamanho:integer;
  Lc_Arquivo : String;
begin

  //Mostra a mensagem na tela de acompanhamento
  MM_Acompanhamento.Lines.Add('SALVANDO ARQUIVO RETORNO..');
  MM_Acompanhamento.Update;

  Lc_Caminho := Fc_TrazRepositorio('NFE_REPOSITORIO');
  lc_Arquivo := Fr_Principal.nfe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML;
  lc_conteudo := Fr_Principal.nfe.EventoNFe.ObterNomeArquivo(teCCe);

  Pc_SalvarArquivoTexto(LC_CAMINHO,
                        LC_CONTEUDO,
                        lc_Arquivo);
  Pc_Insere_Arq_Banco(LC_CAMINHO,
                      LC_CONTEUDO,
                       2,
                      'XML',
                      CartaCorrecao.Registro.Codigo);
  MM_Acompanhamento.Lines.Add('ATUALIZANDO A SITUÇÃO NO SISTEMA..');
  MM_Acompanhamento.Update;
  ShowData;

  CartaCorrecao.Registro.Codsit := 1;
  CartaCorrecao.Registro.Motivo :=  InttoStr(Pc_Cd_Retorno) + ' - ' +  Pc_Motivo;
  CartaCorrecao.Registro.Protocolo := Pc_Protocolo;
  CartaCorrecao.Registro.DtProtocolo := Pc_Dt_Protocolo;
  CartaCorrecao.update;
  AtualizaLista;

end;

function TRegCorrectionLetter.ValidaEnviaWhatsApp: Boolean;
begin
  REsult := True;
end;

function TRegCorrectionLetter.ValidaEnvioCartaCorrecao: Boolean;
begin
  Result := True;
  if not Fc_VerificaStatusServicoNfe(False) then
  Begin
    Result:=FALSE;
    exit;
  end;

  if not CarregaNotaFiscal then
  Begin
    Result:=FALSE;
    exit;
  end;


  if not Qr_Carta_Correcao.Active then Qr_Carta_Correcao.Active := True;
  if (Qr_Carta_Correcao.RecordCount = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Nenhum registro encontrado para enviar.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

  If (Qr_Carta_Correcao.FieldByName('CCE_CODSIT').AsInteger = 1) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Esta carta de correção já foi enviada.' + EOLN +
                   'Não � permitida esta operção.' + EOLN,
          ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

end;

function TRegCorrectionLetter.ValidaEnvioEmail: Boolean;
begin
  Result := True;
  if not Qr_Carta_Correcao.Active then Qr_Carta_Correcao.Active := True;
  if (Qr_Carta_Correcao.RecordCount = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Nenhum registro encontrado para enviar.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

  If (Qr_Carta_Correcao.FieldByName('CCE_CODSIT').AsInteger <> 1) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Esta carta de correção não foi enviada.' + EOLN +
                   'Não � permitida esta operção.' + EOLN,
          ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

end;

function TRegCorrectionLetter.ValidaImpressao: Boolean;
begin
  Result := True;
  if not Qr_Carta_Correcao.Active then Qr_Carta_Correcao.Active := True;
  if (Qr_Carta_Correcao.RecordCount = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Nenhum registro encontrado para enviar.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

  If (Qr_Carta_Correcao.FieldByName('CCE_CODSIT').AsInteger <> 1) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Esta carta de correção não foi enviada.' + EOLN +
                   'Não � permitida esta operção.' + EOLN,
          ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

end;

function TRegCorrectionLetter.ValidaInsert: boolean;
begin
  Result := true;
end;

function TRegCorrectionLetter.ValidateCancel: boolean;
begin
  Result := true;
end;

function TRegCorrectionLetter.ValidateChange: boolean;
begin
  Result := True;
  If (Qr_Carta_Correcao.FieldByName('CCE_CODSIT').AsInteger = 1) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Esta carta de correção já foi enviada.' + EOLN +
                   'Não � permitida a edição.' + EOLN,
          ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

end;

function TRegCorrectionLetter.ValidateDelete: boolean;
begin
  Result := True;
  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;

  If (Qr_Carta_Correcao.FieldByName('CCE_CODSIT').AsInteger = 1) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Esta carta de correção já foi enviada.' + EOLN +
                   'Não � permitida a exclusão.' + EOLN,
          ['OK'], [bEscape], mpAlerta);
    Result:=FALSE;
    exit;
  end;

end;

function TRegCorrectionLetter.ValidateSave: boolean;
begin
  Result := True;
  If (Trim(e_Detalhe.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O preenchimento do campo Detalhe da Correção � obrigatório.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    e_Detalhe.SetFocus;
    Result := False;
    exit;
  end;

  If (Length(Trim(e_Detalhe.Text))<15) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O número de caracteres deve ser maior ou igual a 15.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    e_Detalhe.SetFocus;
    Result := False;
    exit;
  end;

end;

end.

