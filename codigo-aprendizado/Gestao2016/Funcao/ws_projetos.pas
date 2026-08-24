unit ws_projetos;

interface

uses     windows, forms, Graphics, InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, Dialogs, STQuery, Un_DM, Classes, SysUtils, XMLDoc, XMLIntf, Wininet, shellapi, EncdDecd, synacode, acbrcep;

 //-------------------------Funções do WebService---------------------------------------------
type
   TWebServiceProjetos = interface(IInvokable)
  ['{36883690-3BAD-B725-CDD4-C015ACFD0ED9}']
    function  servico(const token: WideString; const area: WideString; const op: WideString; const xml: WideString): WideString; stdcall;

  end;

  function Fc_WebService_Prj(Fc_WSDL: Boolean=System.False; Fc_Endereco: string=''; Fc_HTTPRIO: THTTPRIO = nil): TWebServiceProjetos;
  Function Fc_Ws_Prj_Gera_Token:String;

  //-----------------Gera o email informando que o cliente não está cadastrado --------------
  function Fc_GeraEmailCadastroCliente: String;

  //-------------------------Constroi e Destroi objetos autxiliares -------------------------
  Function  Fc_Ws_Prj_Construtor():Boolean;
  procedure Pc_Ws_Prj_Destrutor;
  //------------------------- Projetos do Gestão---------------------------------------------
  Procedure Pc_InformacaoProjeto;
  procedure Pc_EnviaEmailClienteNaoCadastrado;
  function Fc_Ws_prj_Ver_AtulizacaoVersao:boolean;
  function Fc_Ws_prj_Ver_ScriptSQL: WideString;
  procedure Pc_Ws_Prj_Atu_Web_ConfirmaExecucaoSQL(Pc_Cd_Script,Pc_resultado:String);

  //-------------------------Interface do Gestão---------------------------------------------
  procedure Pc_Ws_prj_Ver_AtulizacaoInterface;
  procedure Pc_Ws_Prj_Atu_Web_ConfirmaAtualizacao;
  procedure Pc_Ws_prj_Atu_Dkp_OperInterface;
  procedure Pc_Ws_prj_Atu_Dkp_Interface;
  procedure Pc_Ws_prj_Atu_Dkp_ItensInterface;
  procedure teste;

Var
  It_Qr_Consulta_PRJ : TSTQuery;
  It_Inet_PRJ : dword;
  It_XML_PRJ : TStringList;
  It_ws_PRJ: TWebServiceProjetos;
  It_XML_Doc_PRJ : TXMLDocument;
implementation

uses     SysUtils, DB, Un_Funcoes, Un_sistema, Un_envia_email, UN_MSG, Un_Regra_Negocio, Md5, RN_Estados, UN_Principal, env;
Function Fc_Ws_Prj_Gera_Token:String;
Begin
  Result := MD5String('webservice_setes_2011');
end;

function Fc_WebService_Prj(Fc_WSDL: Boolean; Fc_Endereco: string; Fc_HTTPRIO: THTTPRIO): TWebServiceProjetos;
const
  defWSDL = 'http://www.setes.com.br/ws2016/index.php?wsdl';
  defURL  = 'http://www.setes.com.br/ws2016/index.php';
  defSvc  = 'SETES.webservice';
  defPrt  = 'SETES.webservicePort';
var
  RIO: THTTPRIO;
begin
  if not Fc_PingConectadoSetes then exit;
  Result := nil;
  if (Fc_Endereco = '') then
    begin
    if Fc_WSDL then
      Fc_Endereco := defWSDL
    else
      Fc_Endereco := defURL;
    end;
  if Fc_HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := Fc_HTTPRIO;
  try
    if Fc_VerificaProxy then
      Begin
      RIO.HTTPWebNode.Proxy    := Gb_Pxy_Path + ':' + IntToStr(Gb_Pxy_Porta) ;
      RIO.HTTPWebNode.UserName := Gb_Pxy_User;
      RIO.HTTPWebNode.Password := Gb_pxy_Pws;
      RIO.Port := IntToStr(Gb_Pxy_Porta);
      end;
   
    Result := (RIO as TWebServiceProjetos);
    if Fc_WSDL then
    begin
      RIO.WSDLLocation := Fc_Endereco;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Fc_Endereco;
  finally
    if (Result = nil) and (Fc_HTTPRIO = nil) then
      RIO.Free;
   Pc_Define_FormatoRegional;
  end;
end;

//-------------------------Gera o email informando que o cliente não está cadastrado -------------------------
function Fc_GeraEmailCadastroCliente: String;
var
   lc_Data: string;
   Lc_Ano, Lc_mes, Lc_dia: string;
Begin
  Pc_AtivaEstabelecimento;
  Lc_dia := Copy(DatetoStr(Date), 1, 2);
  Lc_mes := Fc_DesMes(Fc_Month(date), True);
  Lc_Ano := Copy(DatetoStr(Date), 7, 4);

  Lc_Data := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de ' + Lc_Ano +' / ' + TimeToStr(Now);
  Result := '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> ';
  Result := Result + '<html>';
  Result := Result + '<head>';
  Result := Result + '  <meta content="text/html; charset=ISO-8859-1"';
  Result := Result + ' http-equiv="content-type">';
  Result := Result + '  <title></title>';
  Result := Result + '</head>';
  Result := Result + '<body>';
  Result := Result + 'O cliente Abaixo n&atilde;o tem o cadastro correto no Sistema de';
  Result := Result + 'Controle da setes.<br>';
  Result := Result + '<br>';
  Result := Result + '<table style="text-align: left; width: 100%;" border="1"';
  Result := Result + ' cellpadding="2" cellspacing="2">';
  Result := Result + '  <tbody>';

  Result := Result + '    <tr>';
  Result := Result + '      <td style="width: 125px;">Data</td>';
  Result := Result + '      <td style="width: 842px;">'+ lc_Data + '</td>';
  Result := Result + '    </tr>';
  Result := Result + '    <tr>';
  Result := Result + '      <td style="width: 125px;">Serial do HD</td>';
  Result := Result + '      <td style="width: 842px;">'+ Gb_Serial_HD + '</td>';
  Result := Result + '    </tr>';
  //Gera Informações sobre o Cliente Se houver
  Pc_AtivaEstabelecimento;
  with DM.Qr_Estabelecimento do
  Begin
    if (RecordCount > 0) then
      Begin
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Nome</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('EMP_NOME').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Fantasia</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('EMP_FANTASIA').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">CNPJ</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('EMP_CNPJ').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Insc. Estadual</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('EMP_INSC_EST').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">CEP</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('END_CEP').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Logradouro</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('END_ENDER').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Numero</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('END_NUMERO').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Bairro</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('END_BAIRRO').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Cidade</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('CDD_DESCRICAO').AsString + '</td>';
      Result := Result + '    </tr>';
      Result := Result + '    <tr>';
      Result := Result + '      <td style="width: 125px;">Estado</td>';
      Result := Result + '      <td style="width: 842px;">'+ FieldByname('UFE_SIGLA').AsString + '</td>';
      Result := Result + '    </tr>';
      end;
  End;
  Result := Result + '  </tbody>';
  Result := Result + '</table>';
  Result := Result + '<br>';
  Result := Result + 'Sistema de Controle de Projetos<br>';
  Result := Result + 'www.setes.com.br<br>';
  Result := Result + '<br>';
  Result := Result + '</body>';
  Result := Result + '</html>';
end;


  //-------------------------Constroi e Destroi objetos autxiliares -------------------------
Function Fc_Ws_Prj_Construtor():Boolean;
Begin
  IF not (DirectoryExists(GbPathExe+'temp\')) then ForceDirectories(GbPathExe+'temp\');
  Result := false;
  if Fc_PingConectadoSetes then
  Begin
    It_Qr_Consulta_PRJ := TSTQuery.Create(nil);
    It_Qr_Consulta_PRJ.Database := DM.IBD_Gestao;
    It_Qr_Consulta_PRJ.Transaction := DM.IB_Transacao;
    It_Qr_Consulta_PRJ.ForcedRefresh := True;

    It_XML_Prj := TStringList.Create;
    Result := true;
  end;
end;

procedure Pc_Ws_Prj_Destrutor;
Begin
  FreeAndNil(It_Qr_Consulta_PRJ);
  FreeAndNil(It_XML_Prj);
  Pc_Define_FormatoRegional;
end;

//------------------------- Projetos do Gestão---------------------------------------------

Procedure Pc_InformacaoProjeto;
var
  Lc_Resultado : String;
  Lc_SqlTxt : String;
  Lc_Dados: IXMLNode;
  Lc_Achou : boolean;
Begin
  Gb_Cd_Cliente_Setes := StrToIntDef(Fc_Tb_Geral('L','CD_CLIENTE_SETES',''),0);
  Gb_Cd_Projeto_setes := StrToIntDef(Fc_Tb_Geral('L','CD_PROJETO_SETES',''),0);
  if (Gb_Cd_Cliente_Setes = 0) then
  Begin
    //Posiciona o Cadastro da minha Empresa
    Pc_AtivaEstabelecimento;
    if (DM.Qr_Estabelecimento.RecordCount > 0) then
    Begin
      if Fc_Ws_Prj_Construtor then
      Begin
        Lc_SqlTxt := 'SELECT PJC_CODPRJ,PJC_CODCLI                                  '+
                     'FROM tb_proj_cliente projeto                                  '+
                     '  inner join tb_entidade cliente                              '+
                     '  on (cliente.ETD_CODIGO = projeto.PJC_CODCLI)                '+
                     ' WHERE ETD_CNPJ_CPF = ''' + DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString + '''';
        //Envia a consulta para o WebService
        It_XML_Prj.Clear;
        It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
        It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
        It_XML_Prj.Add('    <QUERY>'+Lc_SqlTxt +'</QUERY>                               ');
        It_XML_Prj.Add('</projeto>                                                      ');
        try
          It_ws_PRJ := Fc_WebService_Prj();
          Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
        except
          Pc_Ws_Prj_Destrutor;
          exit;
        end;
        It_XML_Doc_prj := TXMLDocument.Create(Application);
        It_XML_Doc_PRJ.XML.Clear;
        It_XML_Doc_PRJ.XML.Add(Lc_Resultado);
        It_XML_Doc_PRJ.Active := true;
        Lc_Dados := It_XML_Doc_PRJ.DocumentElement.ChildNodes [0];
        Lc_achou := (Lc_Dados.ChildNodes.Count > 0);
        if Lc_achou then
        Begin
          Gb_Cd_Projeto_setes := StrtoIntDef(Lc_Dados.ChildNodes[0].NodeValue,0);
          Gb_Cd_Cliente_Setes := StrtoIntDef(Lc_Dados.ChildNodes[1].NodeValue,0);
          Fc_Tb_Geral('G','CD_CLIENTE_SETES',InttoStr(Gb_Cd_Cliente_Setes));
          Fc_Tb_Geral('G','CD_PROJETO_SETES',InttoStr(Gb_Cd_Projeto_setes));
        end
        else
        Begin
          Gb_Cd_Projeto_setes := 0;
          Gb_Cd_Cliente_Setes := 0;
        end;
        Pc_Ws_Prj_Destrutor;
      end;
    end;
  end;
end;

procedure Pc_EnviaEmailClienteNaoCadastrado;
Var
  Lc_Destinatario, Lc_Anexo: TStringlist;
  LcEnviaemail : TFr_envia_email;
  LcThread : TThread;
Begin
  LcThread  := TThread.CreateAnonymousThread(
  procedure
  begin
    //Enviar um email para a setes informando falta de cadastro de um cliente
    if (Gb_Cd_Cliente_Setes = 0) or (Gb_Cd_Cliente_Setes = 325 ) then
    Begin
      try
        //Define quem recebe os email
        Lc_Destinatario := TStringList.Create;
        Lc_Destinatario.Add(' valdo@setes.com.br');

        //Cria o paramentro de Anexo mesmo sem ter o anexo
        Lc_Anexo        := TStringList.Create;
        Lc_Anexo.Add('Sem anexo');

        //Chama o Formulario e comeca o envio
        LcEnviaemail := TFr_envia_email.create(nil);
        with LcEnviaemail do
        Begin
          Terminado := False;
          It_Tipo_Envio := 'A';
          It_Assunto  := 'Cliente sem o Cadastro na Web';
          It_Destino  := Lc_Destinatario;
          It_Corpo    := Fc_GeraEmailCadastroCliente;
          It_Anexo    := lc_anexo;
          Pc_Define_Rementente;
          Fc_EnviaEmail;
        end;
      finally
        //Destroy as StringList
        FreeAndNil(Lc_Destinatario);
        FreeAndNil(Lc_Anexo);
        //Destroy as StringList
        LcEnviaemail.Close;
        FreeAndNil(LcEnviaemail);
      end;
    end;
  end);
  LcThread.FreeOnTerminate := True;
  LcThread.start();
end;

function Fc_Ws_prj_Ver_AtulizacaoVersao:boolean;
Var
  Lc_Resultado : String;
  Lc_SqlTxt : String;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  Result := False;
  if (Gb_Cd_Projeto_setes = 0) then Gb_Cd_Projeto_setes := 44;
  if Fc_Ws_Prj_Construtor then
    Begin
    Lc_SqlTxt := 'SELECT PRJ_ATUALIZACAO '+
                 ' FROM tb_projeto '+
                 ' WHERE (PRJ_CODIGO = ''' + IntToStr(Gb_Cd_Projeto_setes) + ''') ';

     //Envia a consulta para o WebService
    It_XML_Prj.Clear;
    It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
    It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
    It_XML_Prj.Add('    <QUERY><![CDATA['+Lc_SqlTxt +']]></QUERY>                   ');
    It_XML_Prj.Add('</projeto>                                                      ');
    try
      It_ws_PRJ := Fc_WebService_Prj();
      Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
    except
        Pc_Ws_Prj_Destrutor;
        exit;
    end;
    It_XML_Doc_Prj := TXMLDocument.Create(Application);
    It_XML_Doc_Prj.XML.Clear;
    It_XML_Doc_Prj.XML.Add(Lc_Resultado);
    It_XML_Doc_Prj.Options := [];
    It_XML_Doc_Prj.NodeIndentStr := '<tab>';
    It_XML_Doc_Prj.Active := true;

    Lc_NodePai := It_XML_Doc_PRJ.DocumentElement.childNodes.First;
    //Se o nº for Zero não tem dados então sai.
    if (Lc_NodePai.ChildNodes.Count > 0) then
      Begin
      Lc_Dados := Lc_NodePai;
      Lc_Resultado := Copy(Lc_Dados.ChildNodes[0].text,1,16);
      Result := (StrToDateTimeDef(Gb_data_Criacao,Now) < StrToDateTimeDef(Lc_Resultado,Now))
      end;
    Pc_Ws_Prj_Destrutor;
    end;    
end;

function Fc_Ws_prj_Ver_ScriptSQL: WideString;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT SCP_CODIGO, SCP_COMANDO '+
               'FROM tb_script '+
               'WHERE SCP_CODIGO not in ( '+
               'select SCX_CODSCP '+
               'FROM tb_script_exec '+
               'WHERE SCX_CODCLI = ''' + IntToStr(Gb_Cd_Cliente_Setes) + ''')';

  //Envia a consulta para o WebService
  It_XML_Prj.Clear;
  It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?> ');
  It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/"> ');
  It_XML_Prj.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML_Prj.Add('</projeto> ');
  try
    It_ws_PRJ := Fc_WebService_Prj();
    Result := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
  except
    Result := '';
  end;
end;


procedure Pc_Ws_Prj_Atu_Web_ConfirmaExecucaoSQL(Pc_Cd_Script,Pc_resultado:String);
Var
  Lc_Data : String;
  Lc_Resultado : String;
  Lc_SqlTxt : String;
Begin
  Lc_Data := FormatDateTime('yyyy-MM-dd hh:mm:ss',now);
  Lc_SqlTxt := 'INSERT INTO tb_script_exec (   '+
               '  SCX_CODSCP,                  '+
               '  SCX_DATATIME,                '+
               '  SCX_CODCLI,                  '+
               '  SCX_RESULTADO)               '+
               'VALUES(                        '+
               '''' + Pc_Cd_Script          +''','+
               '''' + Lc_Data               +''','+
               '''' + IntToStr(Gb_Cd_Cliente_Setes) +''','+
               '''' + Pc_resultado          +''')';
   //Envia a consulta para o WebService
  It_XML_Prj.Clear;
  It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
  It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
  It_XML_Prj.Add('    <QUERY><![CDATA['+Lc_SqlTxt +']]></QUERY>                               ');
  It_XML_Prj.Add('</projeto>                                                      ');
  try
    It_ws_PRJ := Fc_WebService_Prj();
    Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
  except
    Lc_Resultado := '';
  end;
end;

//-------------------------Interface do Gestão---------------------------------------------
procedure Pc_Ws_prj_Ver_AtulizacaoInterface;
Var
  Lc_Resultado : String;
  Lc_SqlTxt : String;
  Lc_NodePai: IXMLNode;
Begin
  if (Gb_Cd_Cliente_Setes > 0) then
  Begin
    if Fc_Ws_Prj_Construtor then
    Begin
      Lc_SqlTxt := 'SELECT CLI_ATUALIZAR '+
                   ' FROM tb_cliente '+
                   ' WHERE (CLI_ATUALIZAR = ''S'') '+
                   ' AND (CLI_CODETD = '''+ IntToStr(Gb_Cd_Cliente_Setes) + ''')'+
                   ' LIMIT 0 , 1 ';

       //Envia a consulta para o WebService
      It_XML_Prj.Clear;
      It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
      It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
      It_XML_Prj.Add('    <QUERY><![CDATA['+Lc_SqlTxt +']]></QUERY>                   ');
      It_XML_Prj.Add('</projeto>                                                      ');
      try
        It_ws_PRJ := Fc_WebService_Prj();
        Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
      except
        Pc_Ws_Prj_Destrutor;
        exit;
      end;
      It_XML_Doc_PRJ := TXMLDocument.Create(Application);
      It_XML_Doc_PRJ.XML.Clear;
      It_XML_Doc_PRJ.XML.Add(Lc_Resultado);
      It_XML_Doc_PRJ.Options := [];
      It_XML_Doc_PRJ.NodeIndentStr := '<tab>';
      It_XML_Doc_PRJ.Active := true;

      Lc_NodePai := It_XML_Doc_PRJ.DocumentElement.childNodes.First;
      //Se o nº for Zero não tem dados então sai.
      if (Lc_NodePai.ChildNodes.Count > 0) then
      Begin
        Pc_Ws_prj_Atu_Dkp_OperInterface;
        Pc_Ws_prj_Atu_Dkp_Interface;
        Pc_Ws_prj_Atu_Dkp_ItensInterface;
        Pc_Ws_Prj_Atu_Web_ConfirmaAtualizacao;
      end;
      Pc_Ws_Prj_Destrutor;
    End;
  end;
end;

procedure Pc_Ws_prj_Atu_Dkp_OperInterface;
Var
  Lc_SqlTxt : String;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  Lc_SqlTxt := 'SELECT OPF_CODIGO, OPF_DESCRICAO,OPF_IMAGEM '+
               'FROM tb_oper_interface  ';

   //Envia a consulta para o WebService
  It_XML_Prj.Clear;
  It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
  It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
  It_XML_Prj.Add('    <QUERY><![CDATA['+Lc_SqlTxt +']]></QUERY>                   ');
  It_XML_Prj.Add('</projeto>                                                      ');
  try
    It_ws_PRJ := Fc_WebService_Prj();
    Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
  except
    exit;
  end;
  //Insere o Xml dentro do Componente
  It_XML_Doc_PRJ := TXMLDocument.Create(Application);
  It_XML_Doc_PRJ.XML.Clear;
  It_XML_Doc_PRJ.XML.Add(Lc_Resultado);
  It_XML_Doc_PRJ.Options := [];
  It_XML_Doc_PRJ.NodeIndentStr := '<tab>';
  It_XML_Doc_PRJ.Active := true;
  Lc_NodePai := It_XML_Doc_PRJ.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  //Cria o Sql para a Atualizaçõp
  It_Qr_Consulta_PRJ.Active := False;
  It_Qr_Consulta_PRJ.SQL.Clear;
  Lc_SqlTxt := 'UPDATE OR INSERT INTO TB_OPER_INTERFACE (OPF_CODIGO, OPF_DESCRICAO, OPF_IMAGEM) '+
               '                         VALUES (:OPF_CODIGO, :OPF_DESCRICAO,:OPF_IMAGEM) '+
               '                       MATCHING (OPF_CODIGO);';
  It_Qr_Consulta_PRJ.SQL.Add(Lc_SqlTxt);

  // Posiciona o primeiro elemento encontrado
  Lc_Dados:= Lc_NodePai;
  Lc_Dados.ChildNodes.First;
  repeat
    Try
      // pega os dados que vc quiser dentro da tag <dados>
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      It_Qr_Consulta_PRJ.Active := False;
      It_Qr_Consulta_PRJ.ParamByName('OPF_CODIGO').AsString := Lc_Dados.ChildNodes[0].text;
      It_Qr_Consulta_PRJ.ParamByName('OPF_DESCRICAO').AsString := Lc_Dados.ChildNodes[1].text;
      if trim(Lc_Dados.ChildNodes[2].text)<> '' then
        It_Qr_Consulta_PRJ.ParamByName('OPF_IMAGEM').AsString := DecodeBase64 (Lc_Dados.ChildNodes[2].text)
      else
        It_Qr_Consulta_PRJ.ParamByName('OPF_IMAGEM').AsString := '';
      It_Qr_Consulta_PRJ.ExecSQL;
    Except
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     concat('Operação Interface : ', Lc_Dados.ChildNodes[1].text) + EOLN + EOLN,
                     ['OK'], [bEscape], mpInformacao);
    End;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;
end;

procedure Pc_Ws_prj_Atu_Dkp_Interface;
Var
  Lc_SqlTxt : String;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_Excecao : String;
Begin
  Lc_SqlTxt := 'SELECT '+
               ' IFC_CODIGO, '+
               ' IFC_DESCRICAO, '+
               ' IFC_FR_NAME, '+
               ' IFC_CODMNU, '+
               ' IFC_MENU, '+ 
               ' CIF_ATIVO '+
               'FROM tb_interface '+
               '  INNER JOIN tb_cli_interface '+
               '  ON (tb_cli_interface.CIF_CODIFC = tb_interface.IFC_CODIGO) '+
               'WHERE (CIF_CODCLI = ''' + IntToStr(Gb_Cd_Cliente_Setes) + ''')'+
               '  AND (CIF_CODPRJ = ''' + IntToStr(Gb_Cd_Projeto_setes) + ''')';

   //Envia a consulta para o WebService
  It_XML_Prj.Clear;
  It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
  It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
  It_XML_Prj.Add('    <QUERY><![CDATA['+Lc_SqlTxt +']]></QUERY>                   ');
  It_XML_Prj.Add('</projeto>                                                      ');
  try
    It_ws_PRJ := Fc_WebService_Prj();
    Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
  except
    exit;
  end;
  //Insere o Xml dentro do Componente
  It_XML_Doc_PRJ := TXMLDocument.Create(Application);
  It_XML_Doc_PRJ.XML.Clear;
  It_XML_Doc_PRJ.XML.Add(Lc_Resultado);
  It_XML_Doc_PRJ.Options := [];
  It_XML_Doc_PRJ.NodeIndentStr := '<tab>';
  It_XML_Doc_PRJ.Active := true;
  Lc_NodePai := It_XML_Doc_PRJ.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  //Cria o Sql para a Atualizaçõp
  It_Qr_Consulta_PRJ.Active := False;
  It_Qr_Consulta_PRJ.SQL.Clear;
  Lc_SqlTxt := 'UPDATE OR INSERT INTO TB_INTERFACE (IFC_CODIGO, IFC_DESCRICAO, IFC_FR_NAME, IFC_CODMNU, IFC_SISTEMA, IFC_MENU)      '+
               '                            VALUES (:IFC_CODIGO, :IFC_DESCRICAO, :IFC_FR_NAME, :IFC_CODMNU, :IFC_SISTEMA, :IFC_MENU) '+
               '                          MATCHING (IFC_CODIGO);';
  It_Qr_Consulta_PRJ.SQL.Add(Lc_SqlTxt);

  // Posiciona o primeiro elemento encontrado
  Lc_Dados:= Lc_NodePai;
  Lc_Dados.ChildNodes.First;
  //Receber as execções dos que serão excluidos depois
  Lc_Excecao := 'where IFC_CODIGO NOT IN (';


  repeat
    try
      try
        // pega os dados que vc quiser dentro da tag <dados>
        Lc_Excecao := Lc_Excecao + Lc_Dados.ChildNodes[0].text + ',';
        if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
        It_Qr_Consulta_PRJ.Active := False;
        It_Qr_Consulta_PRJ.ParamByName('IFC_CODIGO').AsString := Lc_Dados.ChildNodes[0].text;
        It_Qr_Consulta_PRJ.ParamByName('IFC_DESCRICAO').AsString := Lc_Dados.ChildNodes[1].text;
        It_Qr_Consulta_PRJ.ParamByName('IFC_FR_NAME').AsString := Lc_Dados.ChildNodes[2].text;
        It_Qr_Consulta_PRJ.ParamByName('IFC_CODMNU').AsString := Lc_Dados.ChildNodes[3].text;
        It_Qr_Consulta_PRJ.ParamByName('IFC_MENU').AsString := Lc_Dados.ChildNodes[4].text;
        It_Qr_Consulta_PRJ.ParamByName('IFC_SISTEMA').AsString := Lc_Dados.ChildNodes[5].text;
        It_Qr_Consulta_PRJ.ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Except
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       concat('Operação Interface : ', Lc_Dados.ChildNodes[0].text,' - ',Lc_Dados.ChildNodes[1].text) + EOLN + EOLN,
                       ['OK'], [bEscape], mpInformacao);
      End;
    finally
      Lc_Dados := Lc_Dados.NextSibling;
    end;
  until Lc_Dados = nil;
  //Prepara o Sql para Deletar as interfaces que foram retiradas da Web
  if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
  It_Qr_Consulta_PRJ.Active := False;
  It_Qr_Consulta_PRJ.SQL.Clear;
  Lc_SqlTxt := 'DELETE FROM TB_INTERFACE '+ Lc_Excecao +'0)';
  It_Qr_Consulta_PRJ.SQL.Add(Lc_SqlTxt);
  It_Qr_Consulta_PRJ.ExecSQL;
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
end;

procedure teste;
Var
  Lc_SqlTxt : String;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
   //Envia a consulta para o WebService
  It_XML_Prj.Clear;
  It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
  It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
  It_XML_Prj.Add('    <QUERY><![CDATA[SELECT * FROM tb_cep WHERE (NUMERO =83409010)]]></QUERY>                   ');
  It_XML_Prj.Add('</projeto>                                                      ');
  try
    It_ws_PRJ := Fc_WebService_Prj();
    Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
  except
    exit;
  end;
End;

procedure Pc_Ws_prj_Atu_Dkp_ItensInterface;
Var
  Lc_SqlTxt : String;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  Lc_SqlTxt := 'SELECT DISTINCT '+
               ' IIF_CODIGO, '+
               ' IIF_CODIFC, '+
               ' IIF_CODOPF '+
               'FROM tb_itens_ifc '+
               '  INNER JOIN tb_interface '+
               '  ON (IIF_CODIFC = IFC_CODIGO) '+
               'WHERE IFC_CODPRJ = ''' + IntToStr(Gb_Cd_Projeto_setes) + '''';

   //Envia a consulta para o WebService
  It_XML_Prj.Clear;
  It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
  It_XML_Prj.Add('<projeto xmlns="http://www.setes.com.br/">                      ');
  It_XML_Prj.Add('    <QUERY><![CDATA['+Lc_SqlTxt +']]></QUERY>                   ');
  It_XML_Prj.Add('</projeto>                                                      ');
  try
    It_ws_PRJ := Fc_WebService_Prj();
    Lc_Resultado := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projeto','C',It_XML_Prj.Text);
  except
    exit;
  end;
  //Insere o Xml dentro do Componente
  It_XML_Doc_PRJ := TXMLDocument.Create(Application);
  It_XML_Doc_PRJ.XML.Clear;
  It_XML_Doc_PRJ.XML.Add(Lc_Resultado);
  It_XML_Doc_PRJ.Options := [];
  It_XML_Doc_PRJ.NodeIndentStr := '<tab>';
  It_XML_Doc_PRJ.Active := true;
  Lc_NodePai := It_XML_Doc_PRJ.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  if NOT DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
  It_Qr_Consulta_PRJ.Active := False;
  It_Qr_Consulta_PRJ.SQL.Clear;
  It_Qr_Consulta_PRJ.SQL.Add('DELETE FROM TB_ITENS_IFC');
  It_Qr_Consulta_PRJ.ExecSQL;
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;

  //Cria o Sql para a Atualizaçõp
  It_Qr_Consulta_PRJ.Active := False;
  It_Qr_Consulta_PRJ.SQL.Clear;
  Lc_SqlTxt := 'UPDATE OR INSERT INTO TB_ITENS_IFC  (IIF_CODIFC, IIF_CODOPF, IIF_CODIGO) '+
               '  VALUES (:IIF_CODIFC, :IIF_CODOPF, :IIF_CODIGO) '+
               ' MATCHING (IIF_CODIGO); ';

  It_Qr_Consulta_PRJ.SQL.Add(Lc_SqlTxt);

  // Posiciona o primeiro elemento encontrado
  Lc_Dados:= Lc_NodePai;
  Lc_Dados.ChildNodes.First;


  repeat
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    It_Qr_Consulta_PRJ.Active := False;
    It_Qr_Consulta_PRJ.ParamByName('IIF_CODIGO').AsString := Lc_Dados.ChildNodes[0].text;
    It_Qr_Consulta_PRJ.ParamByName('IIF_CODIFC').AsString := Lc_Dados.ChildNodes[1].text;
    It_Qr_Consulta_PRJ.ParamByName('IIF_CODOPF').AsString := Lc_Dados.ChildNodes[2].text;
    It_Qr_Consulta_PRJ.ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;
end;

procedure Pc_Ws_Prj_Atu_Web_ConfirmaAtualizacao;
var
  Lc_result: String;
  Lc_SqlTxt : String;
begin
  Lc_SqlTxt := 'Update tb_cliente set '+
               'CLI_ATUALIZAR= ''N'' '+
               'WHERE CLI_CODETD = ''' + IntToStr(Gb_Cd_Cliente_Setes) + '''';
  It_XML_Prj.Clear;
  It_XML_Prj.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?>   ');
  It_XML_Prj.Add('<projetocliente xmlns="http://www.setes.com.br/">               ');
  It_XML_Prj.Add('    <QUERY>'+ Lc_SqlTxt +'</QUERY>                ');
  It_XML_Prj.Add('</projetocliente>                                               ');
  try
    It_ws_PRJ := Fc_WebService_Prj();
    lc_result := It_ws_PRJ.servico(Fc_Ws_Prj_Gera_Token,'projetocliente','C',It_XML_Prj.Text);
    It_XML_Prj.Clear;
  except
    lc_result := '';
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(TWebServiceProjetos), 'urn:SETES.webservice', 'ISO-8859-1', '', 'SETES.webservicePortType');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(TWebServiceProjetos), 'urn:SETES.webservice#%operationName%');
end.
