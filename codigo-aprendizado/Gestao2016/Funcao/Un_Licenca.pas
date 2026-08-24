unit Un_Licenca;

interface

uses
       SysUtils, Classes, DB, STDatabase, STQuery, StrUtils, IBUpdateSQL, forms, dialogs, Un_funcoes, windows, XMLDoc, Graphics, WinInet, ControllerBase;

  Procedure Pc_Licenca;
  function fc_PrimeiroAcesso:Boolean;
  Procedure Pc_RegistraAcessoWeb;


  procedure Pc_ValidaLicencaWeb;
  Procedure Pc_AtualizaAcessoWeb;

  procedure Pc_AtualizarDadosCliente;
  function Fc_ValidaDadosCliente():Boolean;
  Procedure Pc_EnviarDadosCliente;

Var
  It_Inet : dword;
  It_BloqueiaWeb : Boolean;
  It_SolicitaWeb : Boolean;
  It_Qr_Consulta  :TSTQuery;
  It_Xml_Lcs : TXMLDocument;
  It_XML_Doc_PRJ : TXMLDocument;

implementation

uses     UN_Sistema, Un_DM, UN_Principal, env, UN_MSG, Un_Serial_HD, Un_MinhaEmpresa, Un_Regra_Negocio;
procedure Pc_Licenca;
BEgin
  if (Gb_Cd_Cliente_Setes = 0) or (Gb_Cd_Cliente_Setes = 325 ) then
  Begin
    if fc_PrimeiroAcesso then
    Begin
      Pc_RegistraAcessoWeb;
    end
    else
    Begin
      //Atualiza o Acesso no site e verifica se está liberado
      Pc_AtualizaAcessoWeb;
      //Envia dados do cliente para a Setes se for solicitado via WebService
      IF It_BloqueiaWeb then Pc_ValidaLicencaWeb;
      IF It_SolicitaWeb then Pc_AtualizarDadosCliente;
    end;
  end;
end;

procedure Pc_ValidaLicencaWeb;
Begin
  MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                 'A Licença de uso do Software foi Bloqueada.' + EOLN +
                 'Entre em contato com a Setes, para maiores informações.' + EOLN,
                 ['OK'], [bEscape], mpInformacao);
end;

function fc_PrimeiroAcesso:Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select COUNT(EMP_CODIGO) EMP_QTDE FROM TB_EMPRESA WHERE EMP_TIPO = 0 ');
      Active := True;
      FetchAll;
      Result := (fieldByName('EMP_QTDE').AsInteger = 0);
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


Procedure Pc_RegistraAcessoWeb;
var
   result: String;
   Lc_XML : TStringList;
   Lc_Data : String;
begin
  if Fc_PingConectadoSetes then
  Begin
    Lc_XML := TStringList.Create;
    Lc_Data := FormatDateTime('yyyy-MM-dd HH:MM:ss',Now);

    Lc_XML.Add('<licenca xmlns="http://www.setes.com.br/">                   ');
    Lc_XML.Add('    <LCS_CODIGO>0</LCS_CODIGO>                               ');
    Lc_XML.Add('    <LCS_CODCLI>1</LCS_CODCLI>                               ');
    Lc_XML.Add('    <LCS_VOLUME_HD>'+Gb_Serial_HD+'</LCS_VOLUME_HD>          ');
    Lc_XML.Add('    <LCS_TIME_INSTALA>'+Lc_Data+'</LCS_TIME_INSTALA>         ');
    Lc_XML.Add('    <LCS_IP_INSTALA>'+Fc_GetIPFromNet+'</LCS_IP_INSTALA>     ');
    Lc_XML.Add('    <LCS_LIBERADO>S</LCS_LIBERADO>                           ');
    Lc_XML.Add('    <LCS_SOLICITA>N</LCS_SOLICITA>                           ');
    Lc_XML.Add('</licenca>                                                   ');
    try
      Lc_Data := FormatDateTime('dd/MM/yyyy',Now);
      //It_ws := Fc_WebService_Prj;
//      result := It_ws.servico(Fc_Ws_Prj_Gera_Token,'licenca','I',Lc_XML.Text);
    except
      Exit;
    end;
  end;
end;

function Fc_ValidaDadosCliente():Boolean;
Begin
  Result := False;
  Pc_AtivaEstabelecimento;
  if DM.Qr_Estabelecimento.RecordCount = 0 then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Os seus dados não foram devidamente preechidos.' + EOLN +
                   'Clique em OK para Preencher os dados.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if not Assigned(Fr_MinhaEmpresa) then (Application.CreateForm(TFr_MinhaEmpresa, Fr_MinhaEmpresa));
    Fr_MinhaEmpresa.ShowModal;
    Pc_AtivaEstabelecimento;
    if DM.Qr_Estabelecimento.RecordCount = 0 then
      Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'No prximo acesso será solicitado a atualização.' + EOLN +
                     'Mantenha seu cadastro atualizado e evite transtornos.' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      Result := False;
      end
    else
      Result := True;
    end
  else
    Begin
    Result := True;
    end;
end;

Procedure Pc_EnviarDadosCliente;
Var
  Lc_Msg : String;
  Lc_time: String;
  Lc_SqlTxt : String;
Begin
  {
  if Fc_Ws_Prj_Construtor then
    Begin
    //Define a Saudação após a atualização
    Lc_time := TimeToStr(Time);
    if (Lc_time > '00:00:00') and (Lc_time < '12:00:00') then
      Lc_Msg := 'Agredecemos pela compreensão e tenha um bom Dia.'
    else
    if (Lc_time >= '12:00:00') and (Lc_time < '18:00:00') then
      Lc_Msg := 'Agredecemos pela compreensão e tenha uma boa Tarde.'
    else
    if (Lc_time >= '18:00:00') and (Lc_time < '23:59:00') then
      Lc_Msg := 'Agredecemos pela compreensão e tenha uma boa Noite.';

    try
    //Inicia o envio dos dados

    Lc_SqlTxt := 'UPDATE tb_licenca SET '+
                 'LCS_CODCLI = ''' + IntToStr(Gb_Cd_Cliente_Setes) + ''','+
                 'LCS_SOLICITA = ''N'' '+
                 'WHERE LCS_VOLUME_HD = ''' + Gb_Serial_HD + '''';

    //Envia a consulta para o WebService
    It_XML_PRJ.Clear;
    It_XML_PRJ.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
    It_XML_PRJ.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
    It_XML_PRJ.Add('    <QUERY>'+Lc_SqlTxt +'</QUERY>                               ');
    It_XML_PRJ.Add('</projeto>                                                      ');
    //It_ws := Fc_WebService_Prj();
    //It_ws.servico(Fc_Ws_Prj_Gera_Token,'licenca','C',It_XML_PRJ.Text);
    Pc_Ws_Prj_Destrutor;
    MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                   'Cadastro atualizado com sucesso.' + EOLN +
                   Lc_Msg + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    except
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Um erro impossibitou a atualização do cadastro.' + EOLN +
                   'Verifique se sua conexão com a internet está ativa.' + EOLN +
                   Lc_Msg + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    end
    end;
  }
end;


Procedure Pc_AtualizarDadosCliente;
Begin
  if Fc_PingConectadoSetes then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'A Setes solicita atualização de seu cadastro para continuar a usar o Software.' + EOLN + EOLN +
                       'Confirmar o envio dos dados para atualização ?',
                       [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      if Fc_ValidaDadosCliente then
          Pc_EnviarDadosCliente;
    end;
  end;
end;

Procedure Pc_AtualizaAcessoWeb;
var
  Lc_Resultado : String;
  Lc_solicita : String;
  Lc_XML : TStringList;
Begin
  //Atualiza o numero de Acesso do Sistema na web e retorna se o software está liberado
  if Fc_PingConectadoSetes then
    Begin
    try
      It_BloqueiaWeb := False;
      It_SolicitaWeb := False;
      Lc_XML := TStringList.Create;
      Lc_XML.Add('<licenca xmlns="http://www.setes.com.br/">         ');
      Lc_XML.Add('<LCS_VOLUME_HD>'+ Gb_Serial_HD + '</LCS_VOLUME_HD> ');
      Lc_XML.Add('</licenca>                                         ');
      It_XML_Doc_PRJ := TXMLDocument.Create(Application);
      It_XML_Doc_PRJ.Active := False;
      //It_ws := Fc_WebService_Prj;
      //Lc_Resultado := It_ws.servico(Fc_Ws_Prj_Gera_Token,'licenca','L',Lc_XML.Text);
      It_XML_Doc_PRJ.XML.Clear;
      It_XML_Doc_PRJ.XML.Add(Lc_Resultado);
      It_XML_Doc_PRJ.Active := true;
      if (It_XML_Doc_PRJ.DocumentElement.ChildNodes.Count > 0) then
      Begin
        It_BloqueiaWeb := (It_XML_Doc_PRJ.DocumentElement.ChildNodes[0].NodeValue = 'N');
        It_SolicitaWeb := (It_XML_Doc_PRJ.DocumentElement.ChildNodes[1].NodeValue = 'S');
      end
      else
      Begin
        Pc_RegistraAcessoWeb;
      end;
    finally
      FreeAndNil(It_XML_Doc_PRJ);
    end;
    end;
end;


end.

