unit RN_NotaFiscalEletronica3X;

interface

uses
      STDatabase, STQuery, SysUtils, ControllerItensNfl, ControllerBase, Classes, System.Math, ACBrNFeDANFeESCPOS, ACBrNFe, pcnConversao, ACBrNFeDANFEClass, pcnLeitor, ACBrDFeSSL, ACBrNFeNotasFiscais, ACBrNFeWebServices, pcnConversaoNFe, ACBrNFeDANFeRLClass, ACBrPosPrinter, ACBrValidador, Vcl.StdCtrls, Vcl.ExtCtrls, blcksock, Vcl.Dialogs, Winapi.Windows, Printers, Xml.XMLDoc, un_geranfe_cpa, un_geranfe_ajt;

  function Fc_VerificaCodigoVinculoNFeArquivo(Fc_cd_Nota:Integer):Integer;
  function Fc_VerificaCodigoVinculoCartaCorrecao(Fc_cd_Nota:Integer):Integer;
  function Fc_VerificaCodigoVinculoNFCeArquivo(Fc_cd_Nota:Integer):Integer;

  function Fc_VerificaExistenciaArquivoNFEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
  function Fc_VerificaExistenciaArquivoNFCEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):boolean;

  procedure Pc_VerificaExistenciaArquivoCartaXML(Pc_Tipo:Integer;Pc_Cd_Carta:Integer;Pc_Path,Pc_FileXMl:String);
  procedure Pc_CarregaComponenteNFE(Pc_Path,Pc_FileXMl:String);
  procedure Pc_SalvaNfeArquivoPDF(Pc_Path:String);
  procedure Pc_ImprimeNfeDanfe(Pc_Cd_Nota:Integer);
  procedure Pc_SalvaNFCEArquivoPDF(Pc_Path:String);
  procedure Pc_ImprimeNFCEDanfe(Pc_Cd_Nota:Integer);

  procedure Pc_CarregaComponenteEvento(Pc_cd_Evento,CodigoOrgao:Integer;Pc_Path,Pc_FileXMl,Pc_Status,Pc_Protocolo:String;Pc_Dt_Protocolo:TDate);
  procedure Pc_ImprimeCCEEvento();
  procedure Pc_SalvaEventoArquivoPDF(Pc_PathPDF,Pc_FilePDF:String);

  procedure Pc_AtivaConfiguracaoNFe;
  procedure Pc_CarregaDadosEmitente(Pc_Logo:Boolean);

  //Validações

  function Fc_VerificaNotaXMLCompra(Pc_Cd_Nota:Integer):Integer;

  function Fc_EnviaEmailNFE(Pc_cd_Empresa,Pc_Cd_Tranporte,Pc_Nr_Nota,Pc_Path,Pc_FileXML,Pc_FilePDF,LinkNFSe:String):Boolean;
  function Fc_EnviaEmailNFCE(Fc_Nome,Fc_Email,Fc_Nr_Nota,Fc_Path,Fc_FileXML,Fc_FilePDF:String):Boolean;

  Function Fc_ValidaEnvioNfePDF(Fc_Cd_Cliente:Integer):Boolean;
  function Fc_Valida_enderecoPedido(Pc_cd_Endereco:Integer;Pc_Endereco:String): Boolean;

  procedure Pc_GravaEvento(Pc_Codigo        : Integer;
                           Pc_NUMERO        : Integer;
                           Pc_CHAVE         : String;
                           Pc_CODNVT        : Integer;
                           Pc_DATA          : TDateTime;
                           Pc_SEQUENCIA     : String;
                           Pc_SIT_NFE       : String;
                           Pc_SIT_CONF      : String;
                           Pc_TP_NF         : String;
                           Pc_JUSTIFICATIVA : String;
                           PC_STATUS        : String);
  function Fc_BuscaEventoManifestacao(Fc_Chave:String):Boolean;
  function Fc_BuscaCodigoDescricaoCFOP(Fc_CFOP:String):TStringList;
  function Fc_BuscaCodigoReferenciaCFOP(Fc_CFOP:String):TStringList;
  function Fc_BuscaCodigoReferenciaCST(Fc_CST:String):Integer;
  function Fc_BuscaCodigoReferenciaCSOSN(Fc_CSOSN:String):Integer;
  procedure Pc_VincularCodigosCFOP(Fc_Cd_CFOP_Origem,Fc_Cd_CFOP_Destino:String);


  function Fc_Valida_CNPJ (Fc_Numero,Fc_Tipo : string) : Boolean;
  function Fc_Valida_CPF (Fc_Numero,Fc_Tipo : string) : Boolean;

  function Fc_Valida_Tel_Endereco(Fc_cd_endereco:Integer): Boolean;
  procedure Pc_FormataModeloNFe;
  procedure Pc_FormataModeloNFCe;
  procedure AtivaESCPOS;
  procedure Pc_FormataModeloCartaCorrecao;

  Function Fc_VerificaStatusServicoNfe(Fc_Alerta:Boolean):Boolean;
  Function Fc_TrazRepositorio(Pc_Campo:String):string;
  function Fc_DownloadNFeXML(Fc_Path,Fc_Chave,FcCNPJ:String;Resp:TMEmo):Boolean;
  procedure Pc_MostraNumeroNFC_Nao_Utilizada;
  procedure Pc_SalvarArquivoTexto(Pc_Path,Pc_File, Texto:String);
  function Fc_AnexarXmlNFe(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
  function DefineTipoCertificadoConfig(Tipo:Integer):String;
  function CarregaCertificado(senha:String):String;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, un_Padrao, Un_Regra_Negocio, UN_Principal, env, Un_envia_email, Un_Funcoes, RN_Permissao, RN_Estoque, RN_Empresa, ACBrNFeConfiguracoes, RN_Mailing, RN_NotaFiscal;
function Fc_VerificaCodigoVinculoNFeArquivo(Fc_cd_Nota:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery; 
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NFE_CODIGO from TB_RETORNO_NFE WHERE NFE_CODNFL =:NFE_CODNFL';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFE_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('NFE_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

function Fc_VerificaCodigoVinculoCartaCorrecao(Fc_cd_Nota:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select CCE_CODIGO from TB_CARTA_CORRECAO WHERE CCE_CODNFL =:CCE_CODNFL';
      SQL.Add(Lc_SqlTxt);
      ParamByName('CCE_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('CCE_CODIGO').AsInteger
      else
        Result := 0;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  end;

end;

function Fc_VerificaCodigoVinculoNFCeArquivo(Fc_cd_Nota:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NFC_CODIGO from TB_RETORNO_NFC WHERE NFC_CODNFL =:NFC_CODNFL';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFC_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('NFC_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_VerificaExistenciaArquivoNFEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
Var
  Lc_Cd_Vinculo : Integer;
Begin
  Result := True;
  case pc_tipo of
    1: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNfeArquivo(Pc_Cd_Nota);
    2: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoCartaCorrecao(Pc_Cd_Nota);
    3: Lc_Cd_Vinculo := Pc_Cd_Nota;
  end;

  //Salva o Arquivo XML da NOta no diretorio
  if (Lc_Cd_Vinculo > 0 ) then
  Begin
    Pc_Salva_Arq_Disco(Pc_Tipo,
                       'XML',
                       Lc_Cd_Vinculo ,
                       Pc_Path + '\' +  Pc_FileXML);
    //Se o Arquivo não existir e se o conteudo é maior do zero
    if (not FileExists(Pc_Path + '\' +  Pc_FileXML)) or (Fc_BuscaTamArquivo(Pc_Path + '\' +  Pc_FileXML) = 0) then
    Begin
      Result := False;
    end;
  end
  else
  Begin
    Result := False;
  end;
end;

function Fc_VerificaExistenciaArquivoNFCEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):boolean;
Var
  Lc_Cd_Vinculo : Integer;
Begin
  Result := True;
  Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNFCeArquivo(Pc_Cd_Nota);
  //Salva o Arquivo XML da NOta no diretorio
  if (Lc_Cd_Vinculo > 0 ) then
  Begin
    Pc_Salva_Arq_Disco(Pc_Tipo,
                       'XML',
                       Lc_Cd_Vinculo ,
                       Pc_Path + '\' +  Pc_FileXML);
    //Se o Arquivo não existir e se o conteudo é maior do zero
    if (not FileExists(Pc_Path + '\' +  Pc_FileXML)) or (Fc_BuscaTamArquivo(Pc_Path + '\' +  Pc_FileXML) = 0) then
    Begin
      Result := False;
    end;
  end
  else
  Begin
    Result := False;
  end;
end;

procedure Pc_VerificaExistenciaArquivoCartaXML(Pc_Tipo:Integer;Pc_Cd_Carta:Integer;Pc_Path,Pc_FileXMl:String);
Begin
  //Salva o Arquivo XML da NOta no diretorio
  Pc_Salva_Arq_Disco(Pc_Tipo,
                     'XML',
                     Pc_Cd_Carta ,
                     Pc_Path + '\' +  Pc_FileXML);
  //Se o Arquivo não existir e se o conteudo é maior do zero
  if (not FileExists(Pc_Path + '\' +  Pc_FileXML)) or (Fc_BuscaTamArquivo(Pc_Path + '\' +  Pc_FileXML) = 0) then
    Begin


    end;
end;

procedure Pc_CarregaComponenteNFE(Pc_Path,Pc_FileXMl:String);
Var
  wnProt: TLeitor;
Begin
  //Carrega o XMl no Componente
  with fr_Principal do
  Begin
    Nfe.NotasFiscais.Clear;
    Nfe.NotasFiscais.LoadFromFile(Pc_Path + '\' + Pc_FileXML);
    wnProt := TLeitor.Create;
    wnProt.CarregarArquivo(Pc_Path + '\' +  Pc_FileXML);
    wnProt.Grupo := wnProt.Arquivo;
//    Nfe.DANFE.ProtocoloNFe := wnProt.rCampo(tcStr,'nProt');
  end;
end;

procedure Pc_SalvaNfeArquivoPDF(Pc_Path:String);
Begin
  with fr_Principal do
  Begin
    Nfe.DANFE.PathPDF := Pc_Path;
    Nfe.DANFE.MostraPreview := true;
    Nfe.NotasFiscais.ImprimirPDF;
  end;
end;

procedure Pc_ImprimeNfeDanfe(Pc_Cd_Nota:Integer);
Begin
  with fr_Principal do
    Begin
    Nfe.DANFE.MostraPreview := True;
    Nfe.NotasFiscais.Imprimir;
    end;
end;

procedure Pc_SalvaNFCEArquivoPDF(Pc_Path:String);
Begin
  with fr_Principal do
  Begin
    Nfe.DANFE.PathPDF := Pc_Path;
    Nfe.DANFE.MostraPreview := true;
    Nfe.NotasFiscais.ImprimirPDF;
  end;
end;

procedure Pc_ImprimeNFCEDanfe(Pc_Cd_Nota:Integer);
Begin
  with fr_Principal do
  Begin
    Nfe.DANFE.MostraPreview := True;
    Nfe.NotasFiscais.Imprimir;
  end;
end;



procedure Pc_CarregaComponenteEvento(Pc_cd_Evento,CodigoOrgao:Integer;
                                     Pc_Path,Pc_FileXMl,Pc_Status,Pc_Protocolo:String;
                                     Pc_Dt_Protocolo:TDate);
Var
  wnProt: TLeitor;
  Lc_Content_Xml : String;
Begin
  //Salva o arquivo XMl da Carta no Diretorio
  Pc_Salva_Arq_Disco( 2,
                     'XML',
                     Pc_cd_Evento ,
                     Pc_Path + '\' +  Pc_FileXML );
  //Carrega o XMl no Componente
  with fr_Principal do
  Begin
    Nfe.EventoNFe.Evento.Clear;
    Nfe.EventoNFe.LerXML(Pc_Path + '\' +  Pc_FileXML) ;
//    Nfe.EventoNFe.Evento.Items[0].RetInfEvento.
    NFe.EventoNFe.Evento.Items[0].InfEvento.cOrgao := CodigoOrgao;
    Nfe.EventoNFe.Evento.Items[0].RetInfEvento.dhRegEvento := Pc_Dt_Protocolo;

    if Nfe.EventoNFe.Evento.Count > 0 then
    Begin
      IF Trim(Pc_Protocolo)<> '' then
      Begin
        Nfe.EventoNFe.Evento.Items[0].RetInfEvento.xMotivo := Pc_Status;
        Nfe.EventoNFe.Evento.Items[0].RetInfEvento.nProt := Pc_Protocolo;
        Nfe.EventoNFe.Evento.Items[0].RetInfEvento.dhRegEvento := Pc_Dt_Protocolo;

      end;
    end;
  end;
end;



procedure Pc_ImprimeCCEEvento();
Begin
  with fr_Principal do
  Begin
    Nfe.DANFE := Dfe_Fortes;
    Nfe.DANFE.MostraPreview := true;
    Nfe.DANFE.ImprimirEVENTO();
  end;
end;

procedure Pc_SalvaEventoArquivoPDF(Pc_PathPDF,Pc_FilePDF:String);
Begin
  with fr_Principal do
  Begin
    Nfe.DANFE :=Dfe_Fortes;
    Nfe.DANFE.MostraPreview := False;
    Nfe.CartaCorrecao.CCe.ObterNomeArquivo(teCCe);
    Nfe.DANFE.PathPDF := Pc_PathPDF;
    Nfe.DANFE.ImprimirEVENTOPDF;
  end;
end;

procedure Pc_AtivaConfiguracaoNFe;
Begin
  with DM.Qr_Nf_Eletronica do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
    First;
  end;
end;

procedure Pc_CarregaDadosEmitente(Pc_Logo:Boolean);
Var
  Lc_Ok : Boolean;
  Ex_Logo: TImage;
  Lc_Arq_Logo : String;
  LcIndSSL : Integer;
Begin
  //Ativa o Estabelecimeto
  Pc_AtivaEstabelecimento();

  //CONFIGURAÇÕES DA NFE
  Pc_AtivaConfiguracaoNFe;

  with Fr_Principal,DM.Qr_Nf_Eletronica do
  Begin
    if recordcount > 0 then
    Begin
      Nfe.NotasFiscais.Clear;
      Nfe.DANFE.Logo := '';
      if Pc_Logo then
      Begin
        Try
          //Verificar se há arquivo para a logomarca da Empresa
          Lc_Arq_Logo := 'logo_' + IntToStr(Gb_CodMha) + '.jpg';
          ex_logo:= TImage.create(nil);
          Fc_BuscaImagemEmpresa(Ex_Logo.Picture,'LOGO');
          DeleteFile(Pchar( GbPathExe  + Lc_Arq_Logo));
          //sALVA LOGO NO DISCO PASTA BIN
          if (Ex_Logo.Picture.Graphic <> nil) then
            ex_logo.Picture.SaveToFile(GbPathExe + Lc_Arq_Logo);
          if FileExists(GbPathExe + Lc_Arq_Logo) then
            Nfe.DANFE.Logo       := GbPathExe + Lc_Arq_Logo;

          //Verificar se há arquivo para a Marca D'agua da Empresa
          if FileExists(GbPathExe+'marcadagua.jpg') then DeleteFile(Pchar( GbPathExe+'marcadagua.jpg'));
          Ex_Logo.Picture.Graphic := nil;
          //sALVA MARCA D´GUA NO DISCO PASTA BIN
          Fc_BuscaImagemEmpresa(Ex_Logo.Picture,'MARCADAGUA');

          if (Ex_Logo.Picture.Graphic <> nil) then
            ex_logo.Picture.SaveToFile(GbPathExe+'marcadagua.jpg');
        Finally
          FreeAndNil(ex_logo);
        End;
      end;

      Gb_Cd_Crt  := StrToIntdef(DM.Qr_Estabelecimento.FieldByName('EMP_CRT').AsString,3);
      Nfe.Configuracoes.Arquivos.PathSchemas := GbPathExe + 'Schemas\';
      Nfe.Configuracoes.Geral.FormaEmissao := StrToTpEmis(Lc_Ok,IntToStr(StrToIntDef(FieldByName('NFE_EMISSAO').AsString,0)+1));
      Nfe.Configuracoes.Geral.Salvar       := true;

      if Trim(FieldByName('NFE_REPOSITORIO').AsString) <> '' then
      Begin
        if not DirectoryExists(FieldByName('NFE_REPOSITORIO').AsString) then
          ForceDirectories(FieldByName('NFE_REPOSITORIO').AsString);
      end
      else
      Begin
        if not DirectoryExists(GbPathExe + '\xml\nfe\') then
          ForceDirectories(GbPathExe + '\xml\nfe\');
      End;

      if Trim(FieldByName('NFE_REPOSITORIO_NFCE').AsString) <> '' then
      Begin
        if not DirectoryExists(FieldByName('NFE_REPOSITORIO_NFCE').AsString) then
          ForceDirectories(FieldByName('NFE_REPOSITORIO_NFCE').AsString);
      end
      else
      Begin
        if not DirectoryExists(GbPathExe + '\xml\nfce\') then
          ForceDirectories(GbPathExe + '\xml\nfce\');
      End;


      Nfe.Configuracoes.WebServices.UF            := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
      Nfe.Configuracoes.WebServices.Ambiente      := StrToTpAmb(Lc_Ok,IntToStr(StrToIntDef(FieldByName('NFE_AMBIENTE').AsString,0)+1));
      Nfe.Configuracoes.WebServices.Visualizar    := (FieldByName('NFE_DFE_VISUALIZAR').AsString = 'S');
      Nfe.Configuracoes.Arquivos.SalvarEvento     := true;
      Nfe.Configuracoes.Arquivos.SepararPorCNPJ   := False;
      Nfe.Configuracoes.Arquivos.SepararPorIE     := False;
      Nfe.Configuracoes.Arquivos.SepararPorModelo := False;
      Nfe.Configuracoes.Arquivos.SepararPorAno    := False;
      Nfe.Configuracoes.Arquivos.SepararPorMes    := False;
      Nfe.Configuracoes.Arquivos.SepararPorDia    := False;
      Nfe.Configuracoes.Geral.AtualizarXMLCancelado := True;
      Nfe.Configuracoes.Geral.ValidarDigest := False;

      Fr_Principal.Nfe.Configuracoes.Geral.SSLLib        := TSSLLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_SSLLib','-1'),-1 ));
      Fr_Principal.Nfe.Configuracoes.Geral.SSLCryptLib   := TSSLCryptLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_CryptLib','-1'),-1 ));
      Fr_Principal.Nfe.Configuracoes.Geral.SSLHttpLib    := TSSLHttpLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_HttpLib','-1'),-1 ));
      Fr_Principal.Nfe.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_XmlSignLib','-1'),-1 ));

      LcIndSSL := StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_TIPO_SSL','-1'),-1 );
      if LcIndSSL >=0 then
        Nfe.Configuracoes.WebServices.SSLType :=  TSSLType( LcIndSSL )
      else
        Nfe.Configuracoes.WebServices.SSLType :=  LT_TLSv1_2;

      IF StrToIntDef( Fc_Aq_Geral('L', 'NFE', 'NFE_TIPO_CERT','0'),0) = 0 THEN
      Begin
        Nfe.Configuracoes.Certificados.ArquivoPFX     :=  concat(
                                                              GbPathExe,
                                                              'cert_',
                                                              DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                                                              '.pfx'
                                                            );
        Nfe.Configuracoes.Certificados.Senha          := Fc_Tb_Geral('L','NFE_SENHA_CERT','');
      End
      else
      Begin
        Nfe.Configuracoes.Certificados.ArquivoPFX  :=  '';
        Nfe.Configuracoes.Certificados.Senha       := '';
        Nfe.Configuracoes.Certificados.NumeroSerie := FieldByName('NFE_CERTIFICADO').AsString;
      End;

      //Nfe.DANFE.Fax    := DM.Qr_Estabelecimento.FieldByName('END_FAX').AsString;
      Nfe.DANFE.Email  := DM.Qr_Estabelecimento.FieldByName('EMP_EMAIL').AsString;
      Nfe.DANFE.Site   := DM.Qr_Estabelecimento.FieldByName('EMP_SITE').AsString;
      //Versao
      Nfe.Configuracoes.Geral.VersaoDF := ve400
    end;
  end;
end;


function Fc_VerificaNotaXMLCompra(Pc_Cd_Nota:Integer):Integer;
Var
  Lc_SqlTxt : String;
  qr_aux:TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    qr_aux := LcBase.GeraQuery;
    with qr_aux do
    BEgin
      SQL.Clear;
      Lc_SqlTxt := 'SELECT NFL_CODIGO '+
                   'FROM TB_NOTA_FISCAL '+
                   '  INNER JOIN TB_PEDIDO '+
                   '  ON (PED_CODIGO = NFL_CODPED) '+
                   'WHERE (NFL_CODIGO=:NFL_CODIGO) AND (PED_TIPO = ''2'')';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_Cd_Nota;
      Active := True;
      FetchAll;
      result := FieldByName('NFL_CODIGO').AsInteger;
    end;
  Finally
    if LcBase <> nil then
    begin
      LcBase.FinalizaQuery(qr_aux);
      FreeAndNil(LcBase);
    end;
  End;

end;




function Fc_EnviaEmailNfe(Pc_cd_Empresa,Pc_Cd_Tranporte,Pc_Nr_Nota,Pc_Path,Pc_FileXML,Pc_FilePDF, LinkNFSe:String):Boolean;
Var
  wnProt: TLeitor;
  Lc_Aux : String;
  Lc_Destinatario : TStringList;
  Lc_AssuntoEmail : string;
  Lc_Corpo : String;
  Lc_arq_pdf : string;
  lc_anexo :TStringList;
  LcEnviaemail : TFr_envia_email;
begin
  Lc_Destinatario := TStringList.Create;
  Lc_Anexo        := TStringList.Create;
  //Envia email para a propria empresa
  if DM.Qr_Nf_Eletronica.FieldByName('NFE_COPIA_EMAIL').AsString = 'S' then
    Pc_ListaEmailParaEnvio(DM.Qr_Estabelecimento.FieldByName('EMP_CODIGO').AsString,['PRINCIPAL%','NF-e%'],Lc_Destinatario) ;
  //Verifica se o cliente Possue email
  Pc_ListaEmailParaEnvio(Pc_cd_Empresa,['PRINCIPAL%','NF-e%'],Lc_Destinatario) ;
  //Verifica se o contador Possue email
  if Length(DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString)>0 then
    Lc_Destinatario.Add(' ' + DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString);
  //Verifica se tem transportadora e se tem email
  Pc_ListaEmailParaEnvio(Pc_Cd_Tranporte,['PRINCIPAL%','NF-e%'],Lc_Destinatario) ;

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
              '<br>';
              if (LinkNFSe <> '') then
                Lc_Corpo := Lc_Corpo + 'Segue o link para emissão da NFS-e Nº ' + Pc_Nr_Nota + ' - ' +LinkNFSe
              else
                Lc_Corpo := Lc_Corpo + 'Segue em Anexo, documento referente a NFE do n&uacute;mero: '  + Pc_Nr_Nota;
  Lc_Corpo := Lc_Corpo +
              '<br>'+
              '</body>'+
              '</html>';
  try
    LcEnviaemail := TFr_envia_email.create(nil);
    with LcEnviaemail do
    Begin
      Lc_AssuntoEmail := 'Envio de NF-e Nº '+ Pc_Nr_Nota;
      lc_anexo.Add(Pc_Path + '\' +  Pc_FileXML);
      if (Trim(Pc_FilePDF)<> '') then
        lc_anexo.Add(Pc_Path + '\' +  Pc_FilePDF);
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
  finally
    FreeAndNil(LcEnviaemail);
  end;
end;

function Fc_EnviaEmailNFCE(Fc_Nome,Fc_Email,Fc_Nr_Nota,Fc_Path,Fc_FileXML,Fc_FilePDF:String):Boolean;
Var
  wnProt: TLeitor;
  Lc_Aux : String;
  Lc_Destinatario : TStringList;
  Lc_AssuntoEmail : string;
  Lc_Corpo : String;
  Lc_arq_pdf : string;
  lc_anexo :TStringList;
  LcEnviaemail : TFr_envia_email;
begin
  Lc_Destinatario := TStringList.Create;
  Lc_Anexo        := TStringList.Create;
  //Envia email para a propria empresa
  if DM.Qr_Nf_Eletronica.FieldByName('NFE_COPIA_EMAIL').AsString = 'S' then
    Pc_ListaEmailParaEnvio(DM.Qr_Estabelecimento.FieldByName('EMP_CODIGO').AsString,['PRINCIPAL%','NF-e%'],Lc_Destinatario) ;
  //Verifica se o cliente Possue email
  IF (trim(Fc_Email) = '') then
  Begin
    InputQuery('Enviar Email', 'Email de destino',Fc_Email );
  end;
  if Fc_ValidaEmail(fc_email) then
  Begin
    Lc_Destinatario.Add(' ' + Fc_Email);
  end
  else
  begin
    Result := False;
    Exit;
  end;
  //Verifica se o email do Destinatario informado e mostra o imput
  if Lc_Destinatario.Count = 0 then
  Begin
  end;
  if Lc_Destinatario.Count = 0 then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'e-mail não encontrado no Cadastro e/ou não informado.' + EOLN +
                   '          Verifique  e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);

    Result := False;

    exit;
  end;

  //Verifica se o contador Possue email
  if Length(DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString)>0 then
    Lc_Destinatario.Add(' ' + DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString);

  Lc_Corpo := '<html>'+
              '<head>'+
              '  <meta content="text/html; charset=ISO-8859-1"'+
              ' http-equiv="content-type">'+
              '</head>'+
              '<body>'+
              'Ol&aacute;, ' + Fc_Nome + '<br>'+
              '<br>'+
              'Segue em Anexo, documento referente a NFC-e do n&uacute;mero: '  + Fc_Nr_Nota+
              '<br>'+
              '</body>'+
              '</html>';
  Try
    LcEnviaemail := TFr_envia_email.create(nil);
    with LcEnviaemail do
    Begin
        Lc_AssuntoEmail := 'Envio de NFC-e Nº '+ Fc_Nr_Nota;
        lc_anexo.Add(Fc_Path + '\' +  Fc_FileXML);
        if (Trim(fc_FilePDF)<> '') then
          lc_anexo.Add(Fc_Path + '\' +  Fc_FilePDF);
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


Function Fc_ValidaEnvioNfePDF(Fc_Cd_Cliente:Integer):Boolean;
Var
  Lc_SqlTxt : String;
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    //faz a cnsulta na tabela de retono

    Result := True;

    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'SELECT CLI_JUST_XML_NFE '+
                   'FROM TB_CLIENTE '+
                   'WHERE CLI_CODEMP=:EMP_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
      Active := True;
      FetchAll;
      First;
      Result := (FieldByName('CLI_JUST_XML_NFE').AsString <> 'S');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_Valida_enderecoPedido(Pc_cd_Endereco:Integer;Pc_Endereco:String): Boolean;
Var
  Lc_Qry:TSTQuery;
  Lc_Bairro : String;
  Lc_Cep : String;
  Lc_Numero : String;
  Lc_Endereco : String;
  LcBase : TControllerBase;
Begin
  Result:=true;
  if (Trim(Pc_Endereco) = '') then
  Begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Endereço de entrega não informado.'+EOLN+EOLN+
                   ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result := False;
    exit;
  end;

  if (Pc_cd_Endereco = 0) then
  Begin
    MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                   ' Verifique os dados do endereço.'+EOLN+EOLN+
                   ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result := False;
    exit;
  end;

  try
    //faz a cnsulta na tabela de retono
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT end_bairro,end_cep, end_numero, end_ender FROM tb_endereco ');
      SQL.Add(' WHERE end_codigo =:end_codigo  ');
      ParamByName('end_codigo').AsInteger:= Pc_cd_Endereco;
      Active:=true;
      Lc_Bairro := trim(FieldByName('end_bairro').AsString);
      Lc_Cep := trim(FieldByName('end_cep').AsString);
      Lc_Numero := Trim(FieldByName('end_numero').AsString);
      Lc_Endereco := trim(FieldByName('end_ender').AsString);
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  end;

  If  Lc_Bairro = '' then
  Begin
      MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                     ' O Bairro do endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

  If Lc_Cep = '' then
  Begin
      MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                     ' O CEP do endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

  If Lc_Numero = '' then
  Begin
      MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                     ' O Número do endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

  If Lc_Endereco = '' then
  Begin
      MensagemPadrao(' Mensagem',ATENCAO+EOLN+EOLN+
                     ' O endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

end;

procedure Pc_GravaEvento(Pc_Codigo        : Integer;
                         Pc_NUMERO        : Integer;
                         Pc_CHAVE         : String;
                         Pc_CODNVT        : Integer;
                         Pc_DATA          : TDateTime;
                         Pc_SEQUENCIA     : String;
                         Pc_SIT_NFE       : String;
                         Pc_SIT_CONF      : String;
                         Pc_TP_NF         : String;
                         Pc_JUSTIFICATIVA : String;
                         PC_STATUS        : String);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'insert into "TB_NFE_LOTE_EVENTO"( '+
                   '   "NLT_CODIGO" '+
                   ' , "NLT_NUMERO" '+
                   ' , "NLT_CHAVE" '+
                   ' , "NLT_CODNVT" '+
                   ' , "NLT_DATA" '+
                   ' , "NLT_SEQUENCIA" '+
                   ' , "NLT_SIT_NFE" '+
                   ' , "NLT_SIT_CONF" '+
                   ' , "NLT_TP_NF" '+
                   ' , "NLT_JUSTIFICATIVA" '+
                   ' , "NLT_STATUS" '+
                   ' )values( '+
                   '   :"NLT_CODIGO" '+
                   ' , :"NLT_NUMERO" '+
                   ' , :"NLT_CHAVE" '+
                   ' , :"NLT_CODNVT" '+
                   ' , :"NLT_DATA" '+
                   ' , :"NLT_SEQUENCIA" '+
                   ' , :"NLT_SIT_NFE" '+
                   ' , :"NLT_SIT_CONF" '+
                   ' , :"NLT_TP_NF" '+
                   ' , :"NLT_JUSTIFICATIVA" '+
                   ' , :"NLT_STATUS") ';
      SQL.Add(Lc_SqlTxt);

      ParamByName('NLT_CODIGO').AsInteger := Fc_Generator('GN_NFE_LOTE_EVENTO','TB_NFE_LOTE_EVENTO','NLT_CODIGO');
      ParamByName('NLT_NUMERO').AsInteger := Pc_NUMERO;
      ParamByName('NLT_CHAVE').AsString := Pc_CHAVE;
      ParamByName('NLT_CODNVT').AsInteger := Pc_CODNVT;
      ParamByName('NLT_DATA').AsDateTime := Pc_DATA;
      ParamByName('NLT_SEQUENCIA').AsString := Pc_SEQUENCIA;
      ParamByName('NLT_SIT_NFE').AsString := Pc_SIT_NFE;
      ParamByName('NLT_SIT_CONF').AsString := Pc_SIT_CONF;
      ParamByName('NLT_TP_NF').AsString := Pc_TP_NF;
      ParamByName('NLT_JUSTIFICATIVA').AsString := Pc_JUSTIFICATIVA;
      ParamByName('NLT_STATUS').AsString := PC_STATUS;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_BuscaEventoManifestacao(Fc_Chave:String):Boolean;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    Result := False;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NLT_CODIGO from TB_NFE_LOTE_EVENTO '+
                   ' WHERE NLT_CHAVE =:NLT_CHAVE';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NLT_CHAVE').AsString := Fc_Chave;
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_BuscaCodigoDescricaoCFOP(Fc_CFOP:String):TStringList;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    Result := TStringList.Create;
    Result.Clear;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NAT_CODIGO, NAT_CFOP, NAT_DESCRICAO from TB_NATUREZA '+
                   ' WHERE NAT_CFOP =:NAT_CFOP';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NAT_CFOP').AsString := Fc_CFOP;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Begin
        Result.Add(FieldByname('NAT_CODIGO').AsString);
        Result.Add(FieldByname('NAT_CFOP').AsString);
        Result.Add(FieldByname('NAT_DESCRICAO').AsString);
        end
      else
        Begin
        Result.Add('');
        Result.Add('');
        Result.Add('');
        end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_BuscaCodigoReferenciaCFOP(Fc_CFOP:String):TStringList;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  TRy
    Result := TStringList.Create;
    Result.Clear;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select DISTINCT NAT_CODIGO, NAT_CFOP, NAT_DESCRICAO '+
                   'FROM tb_natureza '+
                   '   INNER JOIN TB_CFOP_CFOP '+
                   '   ON (NAT_CODIGO = NAT_CODDEST) '+
                   'WHERE NAT_CODORIG =:NAT_CODORIG ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NAT_CODORIG').AsString := Fc_CFOP;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Begin
        Result.Add(FieldByname('NAT_CODIGO').AsString);
        Result.Add(FieldByname('NAT_CFOP').AsString);
        Result.Add(FieldByname('NAT_DESCRICAO').AsString);
        end
      else
        Begin
        Result.Add('');
        Result.Add('');
        Result.Add('');
        end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_BuscaCodigoReferenciaCST(Fc_CST:String):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select TBi_CODIGO '+
                   'FROM TB_TRIB_ICMS_NR  '+
                   'WHERE TBI_GRUPO =:TBI_GRUPO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('TBI_GRUPO').ASString := Fc_CST;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByname('TBI_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_BuscaCodigoReferenciaCSOSN(Fc_CSOSN:String):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select TBi_CODIGO '+
                   'FROM TB_TRIB_ICMS_SN  '+
                   'WHERE TBI_GRUPO =:TBI_GRUPO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('TBI_GRUPO').ASString := Fc_CSOSN;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByname('TBI_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_VincularCodigosCFOP(Fc_Cd_CFOP_Origem,Fc_Cd_CFOP_Destino:String);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'UPDATE OR INSERT INTO TB_CFOP_CFOP (NAT_CODORIG, NAT_CODDEST) '+
                   ' VALUES (:NAT_CODORIG, :NAT_CODDEST) '+
                   ' MATCHING (NAT_CODORIG, NAT_CODDEST) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NAT_CODORIG').AsString := Fc_Cd_CFOP_Origem;
      ParamByName('NAT_CODDEST').AsString := Fc_Cd_CFOP_Destino;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;





function Fc_Valida_CNPJ (Fc_Numero,Fc_Tipo : string) : Boolean;
Var
  Lc_DocFiscal : String;
Begin
  Result := True;
  Lc_DocFiscal := ValidDocFiscal(Fc_Numero);
  if not (Lc_DocFiscal = OK) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Número de C.N.P.J. do ' + Fc_Tipo +'Inválido.' + EOLN +
                   ' Verifique o C.N.P.J.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;
end;

function Fc_Valida_CPF (Fc_Numero,Fc_Tipo : string) : Boolean;
Var
  Lc_DocFiscal : String;
Begin
  Result := True;
  Lc_DocFiscal := ValidDocFiscal(Fc_Numero);
  if not (Lc_DocFiscal = OK) then
  Begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Número de C.P.F. do ' + Fc_Tipo +' Inválido.' + EOLN +
                   ' Verifique o C.P.F.' + EOLN,
                   ['OK'], [bEscape], mpErro);
     Result := False;
     exit;
  end;
end;

function Fc_Valida_Tel_Endereco(Fc_cd_endereco:Integer): Boolean;
var
  Lc_Qry : TSTQuery;
  Lc_aux:String;
  LcBase : TControllerBase;
begin
  TRy
    Result:=true;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Sql.Clear;
      SQL.Add('select end_fone from tb_endereco where end_codigo =:end_codigo');
      ParamByName('end_codigo').AsInteger:= Fc_cd_endereco;
      Active:=True;
      Lc_Aux := TRim(fieldbyname('END_FONE').AsString);
      Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-','(',')']);
      if(trim(Lc_Aux) <> '') and (Length(trim(Lc_Aux)) < 10) then
        Result:=false;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_FormataModeloNFE;
Var
  Lc_Ok : Boolean;
Begin
  Pc_AtivaConfiguracaoNFe;
  with Fr_Principal,DM.Qr_Nf_Eletronica do
  Begin
    Dfe_Fortes.ExibeDadosISSQN := True;
    Nfe.Configuracoes.Geral.ModeloDF := moNFe;
    Dfe_Fortes.ACBrNFe := Nfe;
    //MArgem Direita
    Dfe_Fortes.MargemEsquerda := StrToIntDef(Fc_Tb_Geral('L','NFE_MARGEM_ESQUERDA','5'),5);
    Dfe_Fortes.MargemSuperior := StrToIntDef(Fc_Tb_Geral('L','NFE_MARGEM_SUPERIOR','5'),5);
    Dfe_Fortes.MargemInferior := StrToIntDef(Fc_Tb_Geral('L','NFE_MARGEM_INFERIOR','10'),10);

    Nfe.DANFE := Dfe_Fortes;
    //Nfe.DANFE.Impressora := Printer.Printers[Printer.PrinterIndex];
    Dfe_Fortes.ACBrNFe := Nfe;

    if recordCount > 0 then
    Begin
      Nfe.DANFE.TipoDANFE  := StrToTpImp(Lc_Ok,IntToStr(FieldByName('NFE_DFE_ORIENTACAO').AsInteger+1));

      if (FieldByName('NFE_POS_CANH').AsString = '0') then
        Dfe_Fortes.PosCanhoto := TPosRecibo.prCabecalho
      else
        Dfe_Fortes.PosCanhoto := TPosRecibo.prRodape;
      Nfe.Configuracoes.Arquivos.PathNFe    := FieldByName('NFE_REPOSITORIO').AsString;
      Nfe.Configuracoes.Arquivos.PathInu    := FieldByName('NFE_REPOSITORIO').AsString;
      Nfe.Configuracoes.Arquivos.PathEvento := FieldByName('NFE_REPOSITORIO').AsString;
    End;
  end;
end;

procedure AtivaESCPOS;
Begin
  with Fr_Principal,DM.Qr_Nf_Eletronica do
  Begin
      Try
        ACBrPosPrinter.Modelo        := TACBrPosPrinterModelo(StrToIntDef(Fc_Aq_Geral('L','NFCE','NFCE_MARCA_IMP', '0'),0));
        ACBrPosPrinter.Device.Porta  := Fc_Aq_Geral('L','NFCE','NFCE_PORTA', 'COM1');
        ACBrPosPrinter.Device.Baud   := StrToIntDef(Fc_Aq_Geral('L','NFCE','NFCE_VELOC', '9600'),9600);
        ACBrPosPrinter.IgnorarTags   := false;
        ACBrPosPrinter.ControlePorta := true; // True faz com que o componente abra e feche a porta conforme a necessidade automaticamente
        ACBrPosPrinter.CortaPapel := true;
        ACBrPosPrinter.LinhasEntreCupons := StrToIntDef(Fc_Aq_Geral('L','NFCE','LHA_ENTRE_CUP', '5'),5);
        if ( Fc_Aq_Geral('L','NFCE','NFCE_ESCPOS_ATIVA_INI', 'N') = 'S' ) then
          ACBrPosPrinter.Device.Ativar;
      Except
        MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                       'Não foi possível ativar o ESC/POS.' + EOLN +
                       'Verifique e tente novamente.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);

      End;
  End;
End;

procedure Pc_FormataModeloNFCe;
Begin
  with Fr_Principal,DM.Qr_Nf_Eletronica do
  Begin
    Nfe.Configuracoes.Geral.ModeloDF          := moNFCe;
    Nfe.Configuracoes.Arquivos.PathNFe        := FieldByName('NFE_REPOSITORIO_NFCE').AsString;
    Nfe.Configuracoes.Arquivos.PathEvento     := FieldByName('NFE_REPOSITORIO_NFCE').AsString;
    Nfe.Configuracoes.Arquivos.PathInu        :=FieldByName('NFE_REPOSITORIO_NFCE').AsString;
    Nfe.Configuracoes.Geral.ExibirErroSchema  := True;
    Nfe.Configuracoes.Geral.VersaoQRCode      := veqr200;
    Nfe.Configuracoes.Geral.IdCSC             := FieldByName('NFE_IDTOKEN').AsString;
    Nfe.Configuracoes.Geral.CSC               := FieldByName('NFE_TOKEN').AsString;
    if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_ESCPOS', 'N') = 'S') then
    Begin
      Nfe.DANFE := Danfe_NFCe_S;
      Nfe.DANFE.TipoDANFE  := tiNFCe;
      Nfe.DANFE.MostraPreview := False;
      //Nfe.DANFE.FormularioContinuo := True;
      //Nfe.DANFE.ViaConsumidor := true;
      Nfe.Configuracoes.Geral.Salvar  := True;
      Danfe_NFCe_S.ACBrNFe := Nfe;
      Danfe_NFCe_S.ImprimeEmUmaLinha  := (Fc_Aq_Geral('L','NFCE','NFCE_SHW_DESCACRESITEM', 'N') = 'S');
      Danfe_NFCe_S.ImprimeDescAcrescItem := (Fc_Aq_Geral('L','NFCE','NFCE_SHW_DESCACRESITEM', 'N') = 'S');
      Danfe_NFCe_S.PosPrinter := ACBrPosPrinter;
      Danfe_NFCe_S.LarguraBobina := StrToIntDef(Fc_Aq_Geral('L','NFCE','LARGURA_BOBINA', '302'),302);
      AtivaESCPOS;
    end
    else
    BEgin
      Nfe.DANFE := Danfe_NFCe_F;
      Nfe.DANFE.TipoDANFE  := tiNFCe;
      Nfe.DANFE.MostraPreview := True;
      //Nfe.DANFE.FormularioContinuo := True;
      //Nfe.DANFE.ViaConsumidor := true;
      Nfe.Configuracoes.Geral.Salvar  := True;
      Danfe_NFCe_F.ACBrNFe := Nfe;
      Danfe_NFCe_F.ImprimeEmUmaLinha  := (Fc_Aq_Geral('L','NFCE','NFCE_SHW_DESCACRESITEM', 'N') = 'S');
      Danfe_NFCe_F.ImprimeDescAcrescItem := (Fc_Aq_Geral('L','NFCE','NFCE_SHW_DESCACRESITEM', 'N') = 'S');
      Danfe_NFCe_F.LarguraBobina := StrToIntDef(Fc_Aq_Geral('L','NFCE','LARGURA_BOBINA', '302'),302);
    End;
  end;
end;


procedure Pc_FormataModeloCartaCorrecao;
Var
  Lc_Ok : Boolean;
Begin
  with Fr_Principal,DM.Qr_Nf_Eletronica do
  Begin
    if recordcount > 0 then
    Begin
      Dfe_Fortes.ACBrNFe := Nfe;
      Nfe.DANFE := Dfe_Fortes;
      Nfe.Configuracoes.Geral.ModeloDF := moNFe;
      Nfe.DANFE.TipoDANFE  :=  tiRetrato;
      Nfe.Configuracoes.Arquivos.PathSalvar   := FieldByName('NFE_REPOSITORIO').AsString;
    end;
  end;
end;



Function Fc_VerificaStatusServicoNfe(Fc_Alerta:Boolean):Boolean;
Begin
  Result := True;
  with Fr_Principal.Nfe.WebServices do
  Begin
    try
      try
        StatusServico.Executar;
      finally
        if Fc_Alerta then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Status do Serviço : ' + StatusServico.xMotivo + EOLN,
                         ['OK'], [bEscape], mpInformacao);
        end;
        if (StatusServico.cStat <> 107) AND (Trim(StatusServico.xMotivo) <> '') then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Status do Serviço : ' + StatusServico.xMotivo + EOLN,
                         ['OK'], [bEscape], mpInformacao);
          Result := False;
        end;
      end;
    except
    on E : Exception do
      ShowMessage(E.ClassName+' Ocoreu um erro com a mensagem : '+E.Message);
    end;
  end;end;

Function Fc_TrazRepositorio(Pc_Campo:String):string;
begin
  Pc_AtivaConfiguracaoNFe;
  with DM.Qr_Nf_Eletronica do
  BEgin
    if Trim(fieldbyname(PC_CAMPO).AsString) = '' then
    Begin
      if not DirectoryExists(GbPathExe + '\xml'+PC_CAMPO) then
        CreateDir(GbPathExe + '\xml-'+PC_CAMPO);
      Result := GbPathExe + '\xml-'+PC_CAMPO;

    end
    else
    Begin
      if not DirectoryExists(fieldbyname(PC_CAMPO).AsString) then
        CreateDir(fieldbyname(PC_CAMPO).AsString);
      Result:= fieldbyname(PC_CAMPO).AsString;
    end;
  end;
  if Fr_Principal.Nfe.Configuracoes.Arquivos.SepararPorCNPJ then
  Begin
    Result := concat(Result,'\',DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString);
  End;

end;

Function Fc_DownloadNFeXML(Fc_Path,Fc_Chave,FcCNPJ:String;Resp:TMEmo):Boolean;
vaR
  Res : String;
  i:Integer;
  ArqXML : TStringStream;
  XMLDoc: TXMLDocument;
  UF : Integer;
  LC_ULTNSU : sTRING;
begin
  Result:= False;
  //Deve ser informado o Estado em que foi emitida
  UF := StrToIntDef(Copy(fc_chave,1,2),DM.Qr_Estabelecimento.FieldByName('END_CODUFE').asInteger);
  with Fr_Principal.Nfe do
  Begin
    try
      DistribuicaoDFePorChaveNFe(UF,FcCNPJ,Fc_Chave);
      with WebServices.DistribuicaoDFe.retDistDFeInt do
      begin
        LC_ULTNSU := ultNSU;
        if cStat = 138 then
        begin
          XMLDoc := TXMLDocument.Create(nil);
          for i := 0 to docZip.Count - 1 do
          begin
            if docZip.Items[i].schema = schprocNFe then //verifica se o arquivo é o XML da NFe (-nfe.xml)
            begin
              XML := docZip.Items[i].XML;
              ArqXML := TStringStream.Create(XML);
              XMLDoc.XML.Clear;
              XMLDoc.LoadFromStream(ArqXML);
              XMLDoc.Active;
              XMLDoc.SaveToFile(fc_Path + '\' + fc_chave + '-nfe.xml');
              Result:= True;
            end;
          end;
        end
      end;
    except
      on E : Exception do
      Begin
        Resp.Lines.Add('Erro econtrado : '+ E.Message);
        Resp.Lines.Add('Não foi possivel baixar o arquivo');
      End;
    end;
  end;
end;


procedure Pc_MostraNumeroNFC_Nao_Utilizada;
var
  Lc_Qry : TSTQuery;
  Lc_Ult_NFCe :Integer;
  Lc_Contador : Integer;
  Lc_I : Integer;
  Lc_Lista : TListBox;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_Lista := TListBox.Create(Fr_Principal);
    Lc_Lista.Parent := Fr_Principal;
    Lc_Lista.Visible := False;
    with Lc_Qry do
    Begin
      Sql.Clear;
      //Consulta para pegar o maior numero
      SQL.Add('select max(NFC_CODIGO) NUMERO '+
              'FROM TB_RETORNO_NFC ');
      Active := True;
      Lc_Ult_NFCe := fieldbyname('NUMERO').AsInteger;
      //consulta para saber quais notas existem
      Sql.Clear;
      SQL.Add('select NFC_CODIGO '+
              'FROM TB_RETORNO_NFC '+
              'where nfc_codigo=:NFC_CODIGO');
      Lc_Contador := 0;
      Lc_Lista.Items.Clear;
      For Lc_I := 1 to Lc_Ult_NFCe do
      Begin
        Active := false;
        ParamByName('NFC_CODIGO').AsInteger := Lc_i;
        Active := True;
        FetchAll;
        if recordcount = 0 then
          Lc_Lista.Items.Append(IntToStr(Lc_I));
      end;
      Lc_Lista.Items.SaveToFile('c:\NFCE_INEXISTENTE.TXT');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
    FreeAndNil(Lc_Lista);
  End;
end;

procedure Pc_SalvarArquivoTexto(Pc_Path,Pc_File, Texto:String);
var
  txt: textfile;
  Lc_Memo:TStringList;
begin
  Try
    Lc_Memo := TStringList.Create;
    Lc_Memo.Append(Texto);
    Lc_Memo.SaveToFile(Pc_Path + '\' + Pc_File);
  Finally
    FreeAndNil(Lc_Memo);
  End;
end;

function Fc_AnexarXmlNFe(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
Var
  Lc_Cd_Vinculo : Integer;
Begin
  Result := False;
  case pc_tipo of
    1: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNfeArquivo(Pc_Cd_Nota);
    2: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoCartaCorrecao(Pc_Cd_Nota);
    3: Lc_Cd_Vinculo := Pc_Cd_Nota;
    4: Lc_Cd_Vinculo := Pc_Cd_Nota;
    5: Lc_Cd_Vinculo := Pc_Cd_Nota;
    6: Lc_Cd_Vinculo := Pc_Cd_Nota;
  end;

  //Salva o Arquivo XML da NOta no diretorio
  if (Lc_Cd_Vinculo > 0 ) then
  Begin
    Try
      Result := True;
      Pc_Insere_Arq_Banco(Pc_Path,
                          Pc_FileXMl,
                          Pc_Tipo,
                          'XML',
                          Lc_Cd_Vinculo);
    Except
      Result := False;
    End;
  End;

End;

function DefineTipoCertificadoConfig(Tipo:Integer):String;
Begin
  if  Tipo = 0 then
  BEgin
    Result :=
          concat('O certificado deve estar na pasta do Sistema.',#13,
                 'O nome do certificado deve ser ',
                 'cert_',
                 DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                 '.pfx'
          );
  End
  else
  Begin
    Result :=
          concat('Verifique a instalação dos drives do dispositivo.',#13,
                 'Utilize o botão "Carregar o certificado".'
          );
  End;
End;

function CarregaCertificado(senha:String):String;
Var
  LcNomeCert : String;
begin
  try
    with Fr_Principal.Nfe do
    Begin
      SSL.DescarregarCertificado;
      SSL.SSLType := TSSLType(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_TIPO_SSL','-1'),-1 ));
      with Configuracoes do
      Begin
        WebServices.SSLType :=  TSSLType(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_TIPO_SSL','-1'),-1 ));
        Geral.SSLLib        := TSSLLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_SSLLib','-1'),-1 ));
        Geral.SSLCryptLib   := TSSLCryptLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_CryptLib','-1'),-1 ));
        Geral.SSLHttpLib    := TSSLHttpLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_HttpLib','-1'),-1 ));
        Geral.SSLXmlSignLib := TSSLXmlSignLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFE', 'NFE_XmlSignLib','-1'),-1 ));

      End;

      if StrToIntDef( Fc_Aq_Geral('L', 'NFE', 'NFE_TIPO_CERT','0'),0) = 0 then
      Begin
        if Configuracoes.Certificados.NumeroSerie = '' then
        Begin
          Pc_AtivaEstabelecimento;
          LcNomeCert := concat(
                          GbPathExe,
                          'cert_',
                          DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                          '.pfx'
                        );
          Configuracoes.Certificados.ArquivoPFX  :=  LcNomeCert;
          Configuracoes.Certificados.Senha       := Senha;
          Result := SSL.CertNumeroSerie;
        End
        else
        BEgin
          REsult := Configuracoes.Certificados.NumeroSerie;
        End;
      End
      else
      BEgin
        Configuracoes.Certificados.ArquivoPFX  :=  '';
        Configuracoes.Certificados.Senha       := '';
        Configuracoes.Certificados.NumeroSerie := ssl.SelecionarCertificado;
        Result  := Configuracoes.Certificados.NumeroSerie;
      End;
    End;
  except
    on E : Exception do
      ShowMessage(E.ClassName+' Erro: '+E.Message);
  end;
End;

end.







