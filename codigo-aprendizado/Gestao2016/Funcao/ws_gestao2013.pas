unit ws_gestao2013;

interface

uses     windows, forms, Graphics, InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, Dialogs, SysUtils, STQuery, Un_DM, Classes, XMLDoc, XMLIntf, Wininet, shellapi, StrUtils, Un_sistema, Variants, EncdDecd, synacode, ControllerEmpresa;


type
  TWebServiceGestao2013 = interface(IInvokable)
  ['{8713586A-5D7E-C6F1-FF6A-C73A3185A7B8}']
    function  servico(const token: WideString; const area: WideString; const op: WideString; const xml: WideString; const pk: WideString): WideString; stdcall;
    function  cep(const cep: WideString): WideString; stdcall;
    function  frete(const cepOrigem: WideString; const cepDestino: WideString; const peso: WideString; const valorDeclarado: WideString; const codServico: WideString): WideString; stdcall;
  end;


  //-------------------------Funções ligadas ao WebService ----------------------------------

  function Fc_Ws_Gst2013(Fc_WSDL: Boolean=System.False; Fc_Endereco: string=''; Fc_HTTPRIO: THTTPRIO = nil): TWebServiceGestao2013;
  Function Fc_Ws_Gst2013_Gera_Token:String;
  function createXMLDOC(res_xml: WideString):TXMLDocument;
  Function Fc_Ws_Gst2013_Gera_XML(Fc_SqlTxt,Fc_servico,Fc_Parametro,fc_Cd_Chave:String):boolean;
  procedure Fc_Ws_Gst2013_Cmd_Customizado(Fc_servico,fc_SqlTxt:String);
  //Procedimentos de manipulação

  //-------------------------Constroi e Destroi objetos autxiliares -------------------------
  function Fc_Ws_Gst2013_Construtor:boolean;
  procedure Pc_Ws_Gst2013_Destrutor;
  //-------------------------Cadastro de Entidades - Entity -------------------------------------------
  function Fc_Gst2013_Atu_Web_Entity(Pc_Operacao,Pc_ID,Pc_CNPJ: string):String;
  //-------------------------Cadastro de Juridica - Companys -------------------------------------------
  function Fc_Gst2013_Atu_Web_Company(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
  function  Fc_Gst2013_Clt_Web_Company(Fc_CNPJ:String):String;
  //-------------------------Cadastro de Cargo - Profession-------------------------------------------
  procedure Pc_Gst2013_Atu_Web_Profession(Pc_Operacao,Pc_Codigo: string);
  //-------------------------Cadastro de Fisica - Person -------------------------------------------
  function Fc_Gst2013_Atu_Web_Person(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
  function Fc_Gst2013_Clt_Web_Person(Fc_CPF:String):String;

  //-------------------------Cadastro de Estabelecimento - institution -----------------------------
  function Fc_Gst2013_Atu_Web_Institution(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
  function Fc_Gst2013_Atu_Web_Institution_Has_Entity(Pc_Operacao,Pc_Entity_ID: string):String;
  function Fc_Gst2013_Atu_Web_Virtual_Shop(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
  //-------------------------Cadastro de Cliente - Customer -----------------------------
  function Fc_Gst2013_Atu_Web_Customer(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;


  //-------------------------Cadastro de Endereço ---------------------------------------------------
  Function GetCodigoEndereco(CNPJ_CFP:String):Integer;
  function Fc_Gst2013_Atu_Web_Country(Fc_Operacao,Fc_Id: string):String;
  function Fc_Gst2013_Atu_Web_State(Fc_Operacao,Fc_Id: string):String;
  function Fc_Gst2013_Atu_Web_City(Fc_Operacao,Fc_Id: string):String;
  function Fc_Gst2013_Atu_Web_Address(Fc_Operacao,Fc_CNPJ,Fc_Id_Entity,Fc_Kind: string):String;
  function Fc_Gst2013_Atu_Web_Phone(Fc_Operacao,Fc_Id_Entity,Fc_KindPhone,Fc_KindAddress,Fc_Number,Fc_Contact: string):String;

  //-------------------------Cadastro de Usuario - user -------------------------------------------
  procedure Pc_Gst2013_Atu_Web_Mailing(Pc_Codigo,Pc_Operacao,Pc_email,Pc_Tipo,Pc_News: string);
  function  Fc_Gst2013_Clt_Web_Mailing(Fc_email:String):String;
  procedure Pc_Gst2013_Atu_Web_User(Pc_Operacao,Pc_Codigo: string);
  procedure Pc_Gst2013_Atu_Web_Send_Email(Pc_Operacao,Pc_Codigo: string);

  //-------------------------Cadastro de Produtos - Product--------------------------------------
  procedure Pc_Gst2013_Atu_Web_Product(Pc_Operacao,Pc_Codigo: string);
  procedure Pc_Gst2013_Atu_Web_Brand(Pc_Operacao,Pc_Codigo: string);
  procedure Pc_Gst2013_Atu_Web_Merchandise(Pc_Operacao,Pc_Codigo: string);

  //-------------------------Cadastro de medidas - Measure---------------------------------
  procedure Pc_Gst2013_Atu_Web_Measure(Pc_Operacao,pc_codigo: string);

  //-------------------------Cadastro de Embalagem - Packing---------------------------------
  procedure Pc_Gst2013_Atu_Web_Package(Pc_Operacao,pc_codigo: string);
  //-------------------------Cadastro de Categorias - Category-------------------------------
  procedure Pc_Gst2013_Atu_Web_Category(Pc_Operacao,pc_codigo: string);
  //-------------------------Cadastro de Cores - Color --------------------------------------
  procedure Pc_Gst2013_Atu_Web_Color(Pc_Operacao,pc_codigo: string);


  //-------------------------Cadastro de Preço - List_Price-------------------------------------
  procedure Pc_Gst2013_Atu_Web_PriceList(Pc_Operacao,pc_codigo: string);
  procedure Pc_Gst2013_Atu_Web_Price(Pc_Operacao,Pc_Cd_Tabela,Pc_Cd_Produto: string);

  //-------------------------Cadastro de Estoque - Stock-------------------------------------
  procedure Pc_Gst2013_Atu_Web_Stockes(Pc_Operacao,Pc_codigo: string);
  procedure Pc_Gst2013_Atu_Web_Stock(Pc_Operacao,Pc_Cd_Tabela,Pc_Cd_Produto: string);

  //-------------------------Cadastro de Imagens---------------------------------------------
  procedure Pc_Gst2013_Atu_Web_Imagem(Pc_Operacao,Pc_cd_Imagem,Pc_PAth:String);
  procedure Pc_Gst2013_Del_Web_Imagem(Pc_Operacao,Pc_cd_Imagem,Pc_PAth:String);

  procedure Pc_Gst2013_Atu_Web_CapaAlbum(Pc_cd_Imagem,Pc_cd_Produto:String);
  procedure Pc_Gst2013_Atu_Web_DeletaImagemAlbum(Pc_cd_Imagem,Pc_cd_Produto:String);

  procedure Pc_Gst2013_Env_TRay_Imagem(Pc_Operacao,Pc_cd_Imagem,Pc_PAth:String);

  //-------------------------Controle de Cotação - Budget--------------------------------
  function Fc_Gst2013_Atu_Web_Budget():WideString;
  function Fc_Gst2013_Atu_Dkp_Budget(Fc_Operacao,Fc_codigo: string):boolean;
  //-------------------------Controle Itens da Cotação - itembudget----------------------
  function Fc_Gst2013_Clt_Web_Itens_Budget(Pc_Cd_Cotacao: String):WideString;
  function Fc_Gst2013_Atu_Dkp_Itens_Budget(Fc_Cd_Cotacao,Fc_Cd_Pedido:Integer;Fc_Cd_Budget:String; Fc_Aq_Desc:Real):TStringList;

  //-------------------------Controle de Pedido - Order--------------------------------
  function Fc_Gst2013_Clta_Web_Order(codigoVendedor:Integer):WideString;
  function Fc_Gst2013_Atu_Dkp_Order(CodigoVendedor : Integer):boolean;

  //-------------------------Resultado de Operação Financeira Externa----------------------------------

  function  Fc_Gst2013_Clt_Web_Ext_Fin_Oper:WideString;
  function  Fc_Gst2013_Atu_Dkp_Ext_Fin_Oper(Fc_Operacao,Fc_codigo: string):boolean;
  procedure Pc_Gst2013_Atu_Dkp_Web_Ext_Fin_Oper(Pc_Cd_Web: string);

  //-------------------------Controle de Remessas - Shipping ---------------------------------
  function Fc_Gst2013_Clt_Web_shipping(Fc_order_id:String):WideString;

  //-------------------------Controle Itens do Pedido - orderItem----------------------
  function Fc_Gst2013_Clt_Web_Order_Item(tb_order_id, tb_institution_id,tb_salesman_id:Integer):WideString;
  function Fc_Gst2013_Atu_Dkp_Order_Item(Fc_Cd_Dkp,tb_order_id, tb_institution_id,tb_salesman_id:Integer;dt_record:TDateTime):boolean;
  //--------------------Controle Ordem de Servico - ServiceOrder----------------


  //-------------------------Cadastro de Veiculos - Vehicle---------------------
  procedure Pc_Gst2013_Atu_Web_Vehicle_Type(Pc_Operacao,Pc_codigo:String);
  procedure Pc_Gst2013_Atu_Web_Vehicle_Mark(Pc_Operacao,Pc_codigo:String);
  procedure Pc_Gst2013_Atu_Web_Vehicle_Model(Pc_Operacao,Pc_codigo:String);
  procedure Pc_Gst2013_Atu_Web_Vehicle(Pc_Operacao,Pc_codigo:String);

  function Fc_Gst2013_Clt_Web_Vehicle(Fc_id:String):WideString;
  function Fc_Gst2013_Atu_Dkp_Vehicle(Fc_id:String):Boolean;

  function Fc_Gst2013_Clt_Web_VehicleSo(Fc_Cd_Budget:String):WideString;
  function Fc_Gst2013_Atu_Dkp_VehicleSo(Fc_Cd_Cotacao,Fc_Cd_Budget,Fc_cd_Pedido:String):Boolean;

  function Fc_Gst2013_Clt_Web_VehicleCheckList(Fc_Cd_Budget:String):WideString;
  function Fc_Gst2013_Atu_Dkp_VehicleCheckList(Fc_Cd_Cotacao,Fc_Cd_Budget:String):Boolean;

  //-----------------------Atualiza cadastro da empresa no Desktop------------------------------
  function Fc_Gst_Clt_Web_Entity(Fc_CNPJ_CPF:String):WideString;
  function Fc_Gst_Atu_Dkp_Entity(Fc_CNPJ_CPF:String):Integer;
  function Fc_Gst_Clt_ZipCode(Pc_cd_Cidade:string):String;
  function Fc_Gst_Clt_Web_Address(Fc_Tipo,Fc_CNPJ_CPF:String):WideString;
  function Fc_Gst_Atu_Dkp_Address(Fc_Tipo,Fc_CNPJ_CPF:String):Integer;
  function Fc_VerificaEnderecoEmpresa(fc_Tipo,Fc_CNPJCPF: string):Integer;
  function Fc_Gst_Clt_Web_Phone(Fc_cd_phone,Fc_tipo:String):String;
  //-----------------------funcao------------------------------------
  function Fc_DataMysql(fc_Data:String):String;
  //-----------------------Link da Internet-------------------------------------
  function Fc_Gst_Clt_LinkVideoTreinamento(Fc_Cd_Interface,Fc_Numero:String):String;

  //-----------------------Tabela de Frete-------------------------------------
  procedure Pc_Gst_del_Web_Frete;
  procedure Pc_Gst_Atu_Web_Frete(Pc_Operacao,pc_codigo: string);
  procedure Pc_Gst_Atu_Web_Frete_Destino(Pc_Operacao,pc_codigo,Pc_cd_Frete: string);
  procedure Pc_Gst_Atu_Web_Frete_Peso(Pc_Operacao,pc_codigo,Pc_cd_Frete: string);
  procedure Pc_Gst_Atu_Web_Frete_Destino_Peso(Pc_Operacao,Pc_Cd_frete,Pc_Cd_Destino,Pc_Cd_Peso:string;Pc_Valor:Real);


Var
  It_tb_Institution_id : String;
  It_Qr_Consulta : TSTQuery;
  It_Qr_Update : TSTQuery;
  It_ws: TWebServiceGestao2013;
  It_Inet : dword;
  It_XML : TStringList;
  It_Xml_Doc : TXMLDocument;
  It_Xml_Pk : String;
  It_SqlTxt : String;
  It_Resultado : String;
  It_SalvaXMl : Boolean;
  it_enconding : String;
implementation

uses     DB, Un_Funcoes, UN_MSG, Un_Regra_Negocio, Un_Fc_Sored_Procedures, un_Padrao, ws_projetos, RN_FormaPagto, RN_Cotacao, RN_VehicleSo, RN_Veiculo, RN_VehicleCheckList, RN_Estoque, RN_SyncTable, RN_Crud, RN_Pedido, RN_Empresa, RN_Cliente, UN_TabelasEmListas, ControllerEndereco, ControllerPedido, UN_Principal, env;
function Fc_WS_Gst2013(Fc_WSDL: Boolean; Fc_Endereco: string; Fc_HTTPRIO: THTTPRIO): TWebServiceGestao2013;
const
  defSvc  = 'SETES.webservice';
  defPrt  = 'SETES.webservicePort';
var
  RIO: THTTPRIO;
  defWSDL : String;
  defURL : String;
begin
  if not Fc_PingConectadoSetes then exit;
  defWSDL := gb_webservice + '?wsdl';
  defURL  := gb_webservice ;

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

    Result := (RIO as TWebServiceGestao2013);
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

Function Fc_Ws_Gst2013_Gera_Token:String;
Begin
//  Result := MD5String('webservice_setes_2013');
  Result := 'd2Vic2VydmljZV9zZXRlc18yMDEx';
end;

function createXMLDOC(res_xml: WideString):TXMLDocument;
BEgin
  Result := TXMLDocument.Create(Application);
  with Result do
  Begin
    XML.Clear;
    if Length(res_xml) > 0 then
    Begin
      XML.Add(res_xml);
      Options := [];
      NodeIndentStr := '<tab>';
      Active := true;
    End;
  End;
end;

Function Fc_Ws_Gst2013_Gera_XML(Fc_SqlTxt,Fc_servico,Fc_Parametro,fc_Cd_Chave:String):boolean;
Var
  Lc_Campo : String;
  Lc_Data : String;
  Lc_I : Integer;
Begin
  Try
    //Faz a consulta no Banco
    with It_Qr_Consulta do
    Begin
      Active := false;
      Transaction := DM.IBT_Atualiza;
      ForcedRefresh := True;

      SQL.Clear;
      SQL.Add(Fc_SqlTxt);
      ParamByName(Fc_Parametro).AsString := fc_Cd_Chave;
      Active := True;
      FetchAll;
      It_XML.Clear;
      It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
      It_XML.Add('<' + Fc_servico + ' xmlns="' + Gb_Site + '/"> ');
      for Lc_I := 0 to Fields.Count -1 do
      Begin
        Lc_Campo := LowerCase(Fields[Lc_I].FieldName);
        //Trata a informaçao se for Dados do Tipo Data
        if (Fields.Fields[Lc_I].DataType = ftDate) then
        Begin
          Lc_Data := FormatDateTime('yyyy-MM-dd',FieldByname(Lc_campo).AsDateTime);
          It_XML.Add('    <' + Lc_Campo + '>'+Lc_Data+'</' + Lc_Campo + '> ');
        end
        else
        //Trata a informaçao se for Dados do Tipo Data hora
        if (Fields.Fields[Lc_I].DataType = ftDateTime) then
        Begin
          Lc_Data := FormatDateTime('yyyy-MM-dd hh:mm:ss',FieldByname(Lc_campo).AsDateTime);
          It_XML.Add('    <' + Lc_Campo + '>'+Lc_Data+'</' + Lc_Campo + '> ');
        end
        else
        //Trata a informaçao se for Dados do Tipo Inteiro
        if (Fields.Fields[Lc_I].DataType = ftinteger) then
        Begin
          It_XML.Add('    <' + Lc_Campo + '>'+FieldByname(Lc_Campo).AsString+'</' + Lc_Campo + '> ');
        end
        else
        //Trata a informaçao se for Dados do Tipo real/Float
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) OR (Fields.Fields[Lc_I].DataType =  ftFMTBcd) then
        Begin
          if (trim(FieldByname(Lc_Campo).AsString) <> '') then
            It_XML.Add('    <' + Lc_Campo + '>'+BuscaTroca(FieldByname(Lc_Campo).AsString,',','.')+'</' + Lc_Campo + '> ')
          else
            It_XML.Add('    <' + Lc_Campo + '>0</' + Lc_Campo + '> ')
        end
        else
        //Trata a informaçao se for Dados do Tipo Blob
        if (Fields.Fields[Lc_I].DataType = ftblob) then
        Begin
          It_XML.Add('    <' + Lc_Campo + '>'+  EncodeBase64(FieldByname(Lc_Campo).AsString)+'</' + Lc_Campo + '> ');
        end
        else
        Begin
          //Trata a informaçao especificas de tabelas
          if (Lc_Campo = 'PRO_DETALHES') then
          Begin
            It_XML.Add('    <' + Lc_Campo + '><![CDATA['+ FieldByname(Lc_Campo).AsString +']]></' + Lc_Campo + '> ');
          end
          else
          Begin
            IF ( pos('www',FieldByname(Lc_Campo).AsString)>0 ) OR ( pos('@',FieldByname(Lc_Campo).AsString)>0 ) then
              It_XML.Add('    <' + Lc_Campo + '><![CDATA['+ FieldByname(Lc_Campo).AsString +']]></' + Lc_Campo + '> ')
            else
              It_XML.Add('    <' + Lc_Campo + '><![CDATA['+ UCWord(FieldByname(Lc_Campo).AsString) +']]></' + Lc_Campo + '> ');
          end;
        end;
      end;
      It_XML.Add('</' + Fc_servico + '> ');
      Result := True;
    end;
  Except
    Result := False;
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não foi possível geral o XML.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
  end;
end;

//-------------------------Constroi e Destroi objetos autxiliares -------------------------
Function  Fc_Ws_Gst2013_Construtor:Boolean;
Begin
  DM_ListaConsultas.Pc_ListaVendedor;
  IF not (DirectoryExists(GbPathExe+'temp\')) then ForceDirectories(GbPathExe+'temp\');
  Result := False;
  if Fc_PingConectadoSetes then
  Begin
    //Query de Consulta
    It_Qr_Consulta := TSTQuery.Create(nil);
    It_Qr_Consulta.Database := DM.IBD_Gestao;
    It_Qr_Consulta.Transaction := DM.IB_Transacao;
    It_Qr_Consulta.ForcedRefresh := True;
    //Query de Atualização
    It_Qr_Update := TSTQuery.Create(nil);
    It_Qr_Update.Database := DM.IBD_Gestao;
    It_Qr_Update.Transaction := DM.IB_Transacao;
    It_Qr_Update.ForcedRefresh := True;


    It_XML := TStringList.Create;
    It_Xml_Doc := createXMLDOC('');

    It_SalvaXMl := (Fc_Aq_Geral('L','GERAL','DESENVOLVE','N') = 'S');

    It_tb_Institution_id := '1';
    it_enconding := 'ISO-8859-1';
    Pc_AtivaEstabelecimento;
    with DM.Qr_Estabelecimento do
      Begin
      if (FieldByName('EMP_PESSOA').AsString = 'F') then
        It_tb_Institution_id := Fc_Gst2013_Clt_Web_Person(FieldByName('EMP_CNPJ').AsString)
      else
        It_tb_Institution_id := Fc_Gst2013_Clt_Web_Company(FieldByName('EMP_CNPJ').AsString);
      end;
    Result := True;
    end;
end;

procedure Pc_Ws_Gst2013_Destrutor;
Begin
  FreeAndNil(It_Qr_Consulta);
  FreeAndNil(It_XML);
  Pc_Define_FormatoRegional;
end;




//-------------------------Verifica qual o codigo da Web------------------------------------

procedure Fc_Ws_Gst2013_Cmd_Customizado(Fc_servico,fc_SqlTxt:String);
Begin
  It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
               '<chaves xmlns="' + Gb_Site + '/">'+
               '<id>0</id>'+
               '</chaves>';

  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<' + Fc_servico + ' xmlns="' + Gb_Site + '/"> ');
  It_XML.Add('<QUERY>'+ Fc_SqlTxt +'</QUERY> ');
  It_XML.Add('</' + Fc_servico + '>');

  if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_customizado.xml');
  It_ws := Fc_WS_Gst2013;
  It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Fc_servico,'C',It_XML.Text,It_Xml_Pk);
  //Repassa a Xml ao Componente para ser analisado
  {Desativado em 11/12/20161
    It_Xml_Doc.Active := False;
    It_Xml_Doc.XML.Clear;
    It_Xml_Doc.XML.Add(It_Resultado);
    It_Xml_Doc.Encoding := it_enconding;
    It_Xml_Doc.Active := true;
  }
end;

//-------------------------Cadastro de Entidades - Entity -------------------------------------------
function Fc_Gst2013_Atu_Web_Entity(Pc_Operacao,Pc_ID,Pc_CNPJ: string):String;
Var
  Lc_Area : String;
  Lc_ID : Integer;
Begin
  Lc_Area := 'entity';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado('entity','DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_ID);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_ID + '</id>'+
                 '</chaves>';

      It_SqlTxt := 'SELECT '+
                    Pc_ID + ' id,'+
                   'EMP_NOME name_company, '+
                   'EMP_FANTASIA nick_trade '+
                   'FROM TB_EMPRESA tb_entity '+
                   'WHERE (EMP_CNPJ=:EMP_CNPJ) '+
                   'Order by EMP_TIPO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMP_CNPJ',Pc_CNPJ) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_ID + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
      //Repassa a Xml ao Componente para ser analisado
      It_Xml_Doc.Active := False;
      It_Xml_Doc.XML.Clear;
      It_Xml_Doc.XML.Add(Result);
      It_Xml_Doc.Active := true;
      Lc_ID := StrToIntDef(It_Xml_Doc.ChildNodes.Nodes[1].Text,0);
      if (Pc_ID <> '0') then
        Result :=  Pc_ID
      else
        Result := IntToStr(Lc_ID);

    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_ID + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

function Fc_Gst2013_Atu_Web_Company(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'company';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado('entity','DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Id);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<cnpj>' + Pc_CNPJ + '</cnpj>'+
                 '</chaves>';
      It_SqlTxt := 'SELECT '+
                    Pc_Id + ' id,'+
                   'EMP_CNPJ cnpj, '+
                   'EMP_INSC_EST ie, '+
                   'EMP_INSC_MUN im, '+
                   'EMP_DT_FUNDA dt_foundation '+
                   'FROM TB_EMPRESA tb_company '+
                   'WHERE (EMP_CNPJ=:EMP_CNPJ) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMP_CNPJ',Pc_CNPJ) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

function  Fc_Gst2013_Clt_Web_Company(Fc_CNPJ:String):String;
Var
  Lc_ID:Integer;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
               '<chaves xmlns="' + Gb_Site + '/">'+
               '<id>0</id>'+
               '</chaves>';

  It_SqlTxt := 'SELECT id FROM tb_company WHERE (cnpj = ''' + Fc_CNPJ + ''')';

  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
             '<company xmlns="' + Gb_Site + '/">'+
             '<QUERY><![CDATA['+ It_SqlTxt +']]></QUERY>'+
             '</company>');

  if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_clta_Company.xml');
  It_ws := Fc_WS_Gst2013;
  It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'company','C',It_XML.Text,It_Xml_Pk);
  //Repassa a Xml ao Componente para ser analisado
  It_Xml_Doc.Active := False;
  It_Xml_Doc.XML.Clear;
  It_Xml_Doc.XML.Add(It_Resultado);
  It_Xml_Doc.Active := true;

  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count > 0) then
  Begin
    Lc_Dados := Lc_NodePai;
    Result := Lc_Dados.ChildNodes[0].text;
  end
  else
  Begin
    Result := '0';
  end;
end;

//-------------------------Cadastro de Cargo - Profession-------------------------------------------
procedure Pc_Gst2013_Atu_Web_Profession(Pc_Operacao,Pc_Codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'profession';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado('entity','DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_Codigo + '</id>'+
                 '</chaves>';

      It_SqlTxt := 'SELECT '+
                   'CRG_CODIGO id,'+
                   'CRG_DESCRICAO description '+
                   'FROM TB_CARGO tb_profession '+
                   'WHERE (CRG_CODIGO=:CRG_CODIGO) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'CRG_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;


function Fc_Gst2013_Atu_Web_Person(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'person';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado('person','DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Id);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<cpf>' + Pc_CNPJ + '</cpf>'+
                 '</chaves>';

      It_SqlTxt := 'SELECT '+
                   Pc_Id + ' id,'+
                   'EMP_CNPJ cpf, '+
                   'EMP_INSC_EST rg, '+
                   'substring(CAST (EMP_DT_FUNDA AS VARCHAR(10)) from 9 for 2) || substring(CAST (EMP_DT_FUNDA AS VARCHAR(10)) from 5 for 3) birthday, '+
                   '2 tb_profession_id '+
                   'FROM TB_EMPRESA tb_person '+
                   'WHERE (EMP_CNPJ=:EMP_CNPJ) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMP_CNPJ',Pc_CNPJ) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

function  Fc_Gst2013_Clt_Web_Person(Fc_CPF:String):String;
Var
  Lc_ID:Integer;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
               '<chaves xmlns="' + Gb_Site + '/">'+
               '<id>0</id>'+
               '</chaves>';

  It_SqlTxt := 'SELECT id FROM tb_person WHERE (cpf = ''' + Fc_CPF + ''') ';

  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>');
  It_XML.Add('<company xmlns="' + Gb_Site + '/">');
  It_XML.Add('<QUERY><![CDATA['+ It_SqlTxt +']]></QUERY>');
  It_XML.Add('</company>');

  if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_clta_Person.xml');
  It_ws := Fc_WS_Gst2013;
  It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'person','C',It_XML.Text,It_Xml_Pk);
  //Repassa a Xml ao Componente para ser analisado
  It_Xml_Doc.Active := False;
  It_Xml_Doc.XML.Clear;
  It_Xml_Doc.XML.Add(It_Resultado);
  It_Xml_Doc.Active := true;

  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count > 0) then
    Begin
    Lc_Dados := Lc_NodePai;
    Result := Lc_Dados.ChildNodes[0].text;
    end
  else
    Begin
    Result := '0';
    end;
end;

//-------------------------Cadastro de Estabelecimento - institution -------------------------------------------
function Fc_Gst2013_Atu_Web_Institution(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'institution';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado('entity','DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Id);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Id + '</id>'+
                   '</chaves>';

      It_SqlTxt := 'SELECT '+
                   Pc_Id +' id,'+
                   'EMP_ATIVA active '+
                   'FROM TB_EMPRESA tb_institution '+
                   'WHERE (EMP_CNPJ=:EMP_CNPJ) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMP_CNPJ',Pc_CNPJ) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

function Fc_Gst2013_Atu_Web_Institution_Has_Entity(Pc_Operacao,Pc_Entity_ID: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'institution_has_entity';
  if Pc_Operacao = 'D' then
  Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Entity_ID);
  end
  else
  Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                   '<tb_entity_id>' + Pc_Entity_ID + '</tb_entity_id>'+
                   '</chaves>';
      It_Xml.Clear;
      It_Xml.Add( '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                  '<institution_has_entity xmlns="' + Gb_Site + '/">'+
                  '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                  '<tb_entity_id>' + Pc_Entity_ID + '</tb_entity_id>'+
                  '</institution_has_entity>');

      //Função que pega os dados e gera o XMl
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Entity_ID + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Entity_ID + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

function Fc_Gst2013_Atu_Web_Virtual_Shop(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
Var
  Lc_Area : String;
  Lc_Virtual_Shop : String;
Begin
  Lc_Area := 'virtual_shop';
  if Fc_Tb_Geral('L','GRL_G_COM_ELETRONICO','S') = 'S' then
    Lc_Virtual_Shop := 'Y'
  else
    Lc_Virtual_Shop := 'N';
    
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado('entity','DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Id);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<tb_institution_id>' + Pc_Id + '</tb_institution_id>'+
                   '</chaves>';

      It_SqlTxt := 'select distinct '+
                    It_tb_Institution_id + ' tb_institution_id, '+
                    ''''+ Lc_Virtual_Shop + ''' enabled, '+
                    ' INT_WWW domain, '+
                    ' INT_CODTPR tb_price_list_id, '+
                    ' INT_VITRINE vitrine, '+
                    ' INT_DEALER dealer, '+
                    ' INT_TITLE title, '+
                    ' INT_CODETS tb_stockes_id, '+
                    ' INT_ID_GOOGLE_ANALYTIC google_analytics_id, '+
                    ' INT_DIR_IMAGES image_path '+
                    'from tb_internet '+
                    '  inner join tb_empresa '+
                    '  on (emp_codigo = int_codMHA) '+
                    'WHERE INT_WWW is not null and (EMP_CNPJ=:EMP_CNPJ) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMP_CNPJ',Pc_CNPJ) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;


  //-------------------------Cadastro de Cliente - Customer -----------------------------
function Fc_Gst2013_Atu_Web_Customer(Pc_Operacao,Pc_Id,Pc_CNPJ: string):String;
Var
  Lc_Area : String;
Begin
    Lc_Area := 'customer';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado('entity','DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Id);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Id + '</id>'+
                   '<tb_institution_id> '+ It_tb_Institution_id + '</tb_institution_id> '+
                   '</chaves>';

      It_SqlTxt := 'select '+
                   Pc_Id + ' id, '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   '  EMP_CODVDOR tb_vendor_id, '+
                   '  EMP_CODTRANSP tb_carrier_id, '+
                   '  EMP_STCRED credit_status, '+
                   '  EMP_VL_CRED credit_value, '+
                   '  ''S'' wallet, '+
                   '  EMP_OBSERV note, '+
                   '  EMP_CONSUMIDOR consumer, '+
                   '  EMP_LOJISTA dealer, '+
                   '  CLI_ATIVO enabled '+
                   'from TB_EMPRESA tb_customer  '+
                   '  INNER JOIN TB_CLIENTE '+
                   '  ON (CLI_CODEMP = EMP_CODIGO) '+
                   'WHERE (EMP_CNPJ=:EMP_CNPJ) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMP_CNPJ',Pc_CNPJ) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);

    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

  //-------------------------Cadastro de Endereço ---------------------------------------------------
function Fc_Gst2013_Atu_Web_Country(Fc_Operacao,Fc_Id: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'country';
  if Fc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Fc_Id);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Fc_Id + '</id>'+
                 '</chaves>';
      It_SqlTxt := 'SELECT '+
                    Fc_Id + ' id,'+
                   'PAI_DESCRICAO name '+
                   'FROM TB_PAIS tb_country '+
                   'WHERE (PAI_CODBACEN=:PAI_CODBACEN) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'PAI_CODBACEN',Fc_Id) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Fc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Fc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Fc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;

end;

function Fc_Gst2013_Atu_Web_State(Fc_Operacao,Fc_Id: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'state';
  if Fc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Fc_Id);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Fc_Id + '</id>'+
                 '</chaves>';
      It_SqlTxt := 'SELECT '+
                    Fc_Id + ' id,'+
                   '1058 tb_country_id,'+
                   'UFE_SIGLA abbreviation, '+
                   'UFE_DESCRICAO name '+
                   'FROM TB_UF tb_state '+
                   'WHERE (UFE_CODIGO=:UFE_CODIGO) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'UFE_CODIGO',Fc_Id) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Fc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Fc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Fc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;

end;

function Fc_Gst2013_Atu_Web_City(Fc_Operacao,Fc_Id: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'city';
  if Fc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Fc_Id);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Fc_Id + '</id>'+
                 '</chaves>';
      It_SqlTxt := 'select '+
                    Fc_Id + ' id,'+
                   ' CDD_IBGE ibge , '+
                   ' CDD_DESCRICAO name, '+
                   ' UFE_CODIGO tb_state_id '+
                   'from TB_CIDADE tb_city '+
                   '   INNER JOIN TB_UF '+
                   '   ON (tb_uf.ufe_sigla = tb_city.cdd_uf) '+
                   'WHERE (CDD_CODIGO=:CDD_CODIGO) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'CDD_CODIGO',Fc_Id) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Fc_Id + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Fc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Fc_Id + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;

end;

function Fc_Gst2013_Atu_Web_Address(Fc_Operacao,Fc_CNPJ,Fc_Id_Entity,Fc_Kind: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'address';
  if Fc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Fc_Id_Entity);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Fc_Id_Entity + '</id>'+
                 '<kind>' + Fc_Kind + '</kind>'+
                 '</chaves>';
      It_SqlTxt := 'SELECT '+
                    Fc_Id_Entity + ' id, '+
                   'END_TIPO      kind, '+
                   'END_ENDER street, '+
                   'END_COMPLEM    complement, '+
                   'END_BAIRRO     neighborhood, '+
                   'END_CEP       zip_code, '+
                   'END_PRINCIPAL  main,  '+
                   'END_REGIAO     region,  '+
                   'END_NUMERO    nmbr, '+
                   'END_PAIS       tb_country_id,  '+
                   'END_CODCDD     tb_city_id, '+
                   'END_CODUFE     tb_state_id '+
                   'FROM TB_ENDERECO tb_address '+
                   '  INNER JOIN tb_empresa '+
                   '  ON (EMP_CODIGO = END_CODEMP) '+
                   'WHERE (emp_cnpj=:emp_cnpj) and (END_TIPO = '''+ Fc_Kind + ''')'; 

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMP_CNPJ',Fc_CNPJ) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Fc_CNPJ + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Fc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Fc_CNPJ + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;

end;

function Fc_Gst2013_Atu_Web_Phone(Fc_Operacao,Fc_Id_Entity,Fc_KindPhone,Fc_KindAddress,Fc_Number,Fc_Contact: string):String;
Var
  Lc_Area : String;
Begin
  Lc_Area := 'phone';
  if Fc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Fc_Id_Entity);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Fc_Id_Entity + '</id>'+
                   '<kind>' + Fc_KindPhone + '</kind>'+
                   '</chaves>';
      //Função que pega os dados e gera o XMl
      It_XML.Clear;
      It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<phone xmlns="' + Gb_Site + '/">'+
                 '<id>'+ Fc_Id_Entity +'</id>'+
                 '<kind>'+ Fc_KindPhone +'</kind>'+
                 '<contact><![CDATA['+ Fc_Contact +']]></contact>'+
                 '<number>'+ Fc_RemoveCaracterInformado(Fc_Number, ['(',')','-','-',' ']) +'</number> '+
                 '<address_kind>'+ Fc_KindAddress +'</address_kind>'+
                 '</phone>');


      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Fc_Id_Entity + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Fc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Fc_Id_Entity + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;


end;

//-------------------------Cadastro de Usuario - user -------------------------------------------
procedure Pc_Gst2013_Atu_Web_Mailing(Pc_Codigo,Pc_Operacao,Pc_email,Pc_Tipo,Pc_News: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'mailing';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_email);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Codigo + '</id>'+
                   '<kind>' + Pc_Tipo + '</kind>'+ 
                   '</chaves>';
      It_XML.Clear;
      It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
      It_XML.Add('<mailing xmlns="' + Gb_Site + '/"> ');
      It_XML.Add('<id>'+ Pc_Codigo +'</id> ');
      It_XML.Add('<email>'+ Pc_email +'</email> ');
      It_XML.Add('<kind>'+ Pc_Tipo +'</kind> ');
      It_XML.Add('<news>'+ Pc_News +'</news> ');
      It_XML.Add('</mailing>');

      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_mailing.xml');
      It_ws := Fc_WS_Gst2013;
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,'A',It_XML.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

function  Fc_Gst2013_Clt_Web_Mailing(Fc_email:String):String;
Var
  Lc_ID : Integer;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>0</id>'+
                 '</chaves>';

  It_SqlTxt := 'SELECT id FROM tb_mailing WHERE (email = ''' + Fc_email + ''') ';


  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>');
  It_XML.Add('<company xmlns="' + Gb_Site + '/">');
  It_XML.Add('<QUERY><![CDATA['+ It_SqlTxt +']]></QUERY>');
  It_XML.Add('</company>');

  if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_clta_Company.xml');
  It_ws := Fc_WS_Gst2013;
  It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'mailing','C',It_XML.Text,It_Xml_Pk);
  //Repassa a Xml ao Componente para ser analisado
  It_Xml_Doc.Active := False;
  It_Xml_Doc.XML.Clear;
  It_Xml_Doc.XML.Add(It_Resultado);
  It_Xml_Doc.Active := true;

  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count > 0) then
    Begin
    if (Lc_NodePai.ChildValues['id'] <> null) then
      Result := Lc_NodePai.ChildNodes[0].text;//Result.Add(Lc_NodePai.ChildValues['id']);
    end
  else
    Begin
    Result := '0';//Result.Clear;
    end;
end;

procedure Pc_Gst2013_Atu_Web_User(Pc_Operacao,Pc_Codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'user';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Codigo + '</id>'+
                   '</chaves>';
      It_SqlTxt := 'select '+
                   'USU_CODIGO id, '+
                   '1 tb_mailing_id, '+
                   'tb_usuario.USU_SENHA password, '+
                   '''Sistema'' kind, '+
                   ''''' salt, '+
                   ''''' active, '+
                   ''''' activation_key '+
                   'from tb_usuario '+
                   'WHERE (USU_CODIGO=:USU_CODIGO) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'USU_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

procedure Pc_Gst2013_Atu_Web_Send_Email(Pc_Operacao,Pc_Codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'send_email';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_Codigo + '</id>'+
                 '</chaves>';
                 
      It_SqlTxt := 'SELECT '+
                   'tb_usuario.usu_codigo id, '+
                   'tb_usuario.usu_lbl_email label, '+
                   'tb_usuario.usu_srv_smtp smtp, '+
                   'tb_usuario.usu_lgn_email user_name, '+
                   'tb_usuario.usu_pwd_email password, '+
                   'tb_usuario.usu_porta_email port, '+
                   'tb_usuario.usu_req_aut_ssl auth_ssl, '+
                   'tb_usuario.usu_req_aut_email auth_req '+
                   'FROM tb_usuario '+
                   'WHERE (USU_CODIGO=:USU_CODIGO) and tb_usuario.usu_srv_smtp is not null ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'USU_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;


//-------------------------Cadastro de Produtos -------------------------------------------
procedure Pc_Gst2013_Atu_Web_Product(Pc_Operacao,Pc_Codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'product';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_Codigo + '</id>'+
                 '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                 '</chaves>';

      It_SqlTxt := 'SELECT '+
                   ' PRO_CODIGO id '+
                   ',PRO_CODIGOFAB identifier '+
                   ',' + It_tb_Institution_id + ' tb_institution_id '+
                   ',PRO_DESCRICAO description '+
                   ',PRO_CODCAT tb_category_id '+
                   ',PRO_CAMPANHA promotion '+
                   ',PRO_DESTAQUE highlights '+
                   ',PRO_ATIVO enabled '+
                   ',PRO_INTERNET published '+
                   ',PRO_DETALHES note '+
                   'FROM tb_produto tb_product '+
                   'WHERE (PRO_CODIGO=:PRO_CODIGO) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'PRO_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

procedure Pc_Gst2013_Atu_Web_Brand(Pc_Operacao,Pc_Codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'brand';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Codigo + '</id>'+
                   '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                   '</chaves>';
      It_SqlTxt := 'SELECT '+
                   '     MRC_CODIGO id, '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   '     MRC_DESCRICAO description, '+
                   '     MRC_CODFAB tb_provider_id '+
                   ' FROM TB_MARCA_PRODUTO  tb_brand '+
                   'WHERE (MRC_CODIGO=:MRC_CODIGO) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'MRC_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

procedure Pc_Gst2013_Atu_Web_Merchandise(Pc_Operacao,Pc_Codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'merchandise';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Codigo + '</id>'+
                   '</chaves>';
      It_SqlTxt := 'SELECT '+
                   'PRO_CODIGO id, '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   'PRO_CODIGOFAB id_internal, '+
                   'PRO_CODIGOFOR id_provider, '+
                   'PRO_CODIGONCM id_tributary, '+
                   'PRO_ORIGEM source, '+
                   'PRO_TIPO kind, '+
                   'PRO_CODMRC tb_brand_id, '+
                   'PRO_IMPRIME print, '+
                   'PRO_SERIE controlseries, '+
                   'PRO_EXCLUSIVO exclusive_dealer, '+
                   'PRO_APLICACAO application '+
                   'FROM TB_PRODUTO tb_merchandise '+
                   'WHERE (PRO_CODIGO=:PRO_CODIGO) ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'PRO_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

 //-------------------------Cadastro de medidas - Measure---------------------------------
procedure Pc_Gst2013_Atu_Web_Measure(Pc_Operacao,pc_codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'measure';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_Codigo + '</id>'+
                 '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                 '</chaves>';
      It_SqlTxt := 'select '+
                   'MED_CODIGO id, '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   'MED_DESCRICAO description, '+
                   'MED_ABREVIATURA abbreviation, '+
                   'MED_ESCALA escale '+
                   'FROM tb_medida tb_measure '+
                   'WHERE MED_CODIGO=:MED_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'MED_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;
//-------------------------Cadastro de Embalagem - Packing--------------------------------
procedure Pc_Gst2013_Atu_Web_Package(Pc_Operacao,pc_codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'package';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ Pc_Codigo);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_Codigo + '</id>'+
                 '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                 '</chaves>';
      It_SqlTxt := 'select '+
                   'EMB_CODIGO id, '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   'EMB_DESCRICAO description, '+
                   'EMB_ABREVIATURA abbreviation '+
                   'FROM tb_embalagem '+
                   'WHERE EMB_CODIGO=:EMB_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EMB_CODIGO',Pc_Codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

//-------------------------Cadastro de Categorias - Category-------------------------------
procedure Pc_Gst2013_Atu_Web_Category(Pc_Operacao,pc_codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'category';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_Codigo + '</id>'+
                 '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                 '</chaves>';
                 
      It_SqlTxt := 'SELECT '+
                   'id, '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   'description, '+
                   'posit_level, '+
                   'kind, '+
                   'enabled '+
                   'From tb_category '+
                   'WHERE id =:id ';
      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'id',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);

    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;


//-------------------------Cadastro de Cores - Color --------------------------------------
procedure Pc_Gst2013_Atu_Web_Color(Pc_Operacao,pc_codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'color';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + Pc_Codigo + '</id>'+
                 '</chaves>';
                 
      It_SqlTxt := 'SELECT '+
                   'id, '+
                   'description '+
                   'From tb_color '+
                   'WHERE id =:id ';
      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'id',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;


//-------------------------Cadastro de Marcas ---------------------------------------------

//-------------------------Cadastro de Tabela de Preço-------------------------------------
procedure Pc_Gst2013_Atu_Web_PriceList(Pc_Operacao,pc_codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'price_list';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Codigo + '</id>'+
                   '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                   '</chaves>';

      It_SqlTxt := 'SELECT '+
                   '  TPR_CODIGO id, '+
                   It_tb_Institution_id + ' tb_institution_id,'+
                   '  TPR_NOME description, '+
                   '  TPR_VALIDADE validity, '+
                   '  TPR_MODALIDADE modality, '+
                   '  TPR_MAR_LRC aliq_profit '+
                   'FROM tb_tabela_preco '+
                   'WHERE TPR_CODIGO=:TPR_CODIGO '+
                   ' AND ( TPR_ATIVA = ''S'') ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'TPR_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;
procedure Pc_Gst2013_Atu_Web_Price(Pc_Operacao,Pc_Cd_Tabela,Pc_Cd_Produto: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'price';
  if Pc_Operacao = 'D' then
  Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ Pc_Cd_Produto);
  end
  else
  Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<tb_institution_id>'  + It_tb_Institution_id + '</tb_institution_id>'+
                   '<tb_product_id>'      + Pc_Cd_Produto + '</tb_product_id>'+
                   '<tb_price_list_id>'   + Pc_Cd_Tabela + '</tb_price_list_id>'+
                   '</chaves>';

      It_SqlTxt := 'SELECT '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   ' PRC_CODTPR tb_price_list_id, '+
                   ' PRC_CODPRO tb_product_id, '+
                   ' PRC_VL_VDA price_tag, '+
                   ' PRC_AQ_COM aliq_profit, '+
                   ' PRC_MAR_LRC aliq_kickback, '+
                   ' PRC_QT_MIN quantity '+
                   ' FROM TB_PRECO '+
                   'WHERE (PRC_CODPRO =:PRC_CODPRO) '+
                   'AND   (PRC_CODTPR ='+ Pc_Cd_Tabela +')';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'PRC_CODPRO',Pc_Cd_Produto) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ Pc_Cd_Produto + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ Pc_Cd_Produto + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

//-------------------------Cadastro de Estoque-------------------------------------
procedure Pc_Gst2013_Atu_Web_Stockes(Pc_Operacao,pc_codigo: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'stockes';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + Pc_Codigo + '</id>'+
                   '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                   '</chaves>';
      It_SqlTxt := 'SELECT '+
                   '    ETS_CODIGO id, '+
                   It_tb_Institution_id + ' tb_institution_id, '+
                   '    ETS_DESCRICAO description, '+
                   '    ETS_PRINCIPAL kind '+
                   'FROM TB_ESTOQUES '+
                   'WHERE ETS_CODIGO=:ETS_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'ETS_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

procedure Pc_Gst2013_Atu_Web_Stock(Pc_Operacao,Pc_Cd_Tabela,Pc_Cd_Produto: string);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'stock';
  if Pc_Operacao = 'D' then
    Begin
    //Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<tb_institution_id>'  + It_tb_Institution_id + '</tb_institution_id>'+
                   '<tb_stockes_id>'      + Pc_Cd_Tabela + '</tb_stockes_id>'+
                   '<tb_merchandise_id>'   + Pc_Cd_Produto + '</tb_merchandise_id>'+
                   '</chaves>';
                       
      It_SqlTxt := 'SELECT '+
                   It_tb_Institution_id + ' tb_institution_id,'+
                   '  EST_CODETS tb_stockes_id, '+
                   '  PRO_CODIGO tb_merchandise_id, '+                   
                   '  PRO_CODEMB tb_packing_id, '+
                   '  PRO_CODMED tb_measure_id, '+
                   '  1 tb_color_id, '+
                   '  EST_QTDE quantity, '+
                   '  PRO_QTDE_MIN minimum, '+
                   '  PRO_DIVISOR divisor, '+
                   '  PRO_LOCAL location, '+
                   '  PRO_PESO weight, '+
                   '  PRO_LARGURA width, '+
                   '  PRO_COMPRIMENTO length, '+
                   '  PRO_ALTURA height, '+
                   '  PRO_VL_FABRICA cost_manufactures, '+
                   '  PRO_VL_CUSTOMED actual_cost, '+
                   '  PRO_VL_CUSTO cost_price, '+
                   '  PRO_EST_NEG negative '+
                   'FROM tb_produto '+
                   '  INNER JOIN TB_ESTOQUE '+
                   '  ON (EST_CODPRO = PRO_CODIGO) '+
                   '  INNER JOIN TB_ESTOQUES '+
                   '  ON (ETS_CODIGO = EST_CODETS) '+ 
                   'WHERE (EST_CODPRO =:EST_CODPRO) and '+
                   ' (ETS_CODIGO = ' + Pc_Cd_Tabela + ') and '+
                   ' (ETS_CODMHA = ' + IntToStr(Gb_CodMha) + ')';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'EST_CODPRO',Pc_Cd_Produto) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ Pc_Cd_Produto + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ Pc_Cd_Produto + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

//-------------------------Cadastro de Imagens---------------------------------------------
procedure Pc_Gst2013_Atu_Web_Imagem(Pc_Operacao,Pc_cd_Imagem,Pc_PAth:String);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'images';
  if Pc_Operacao = 'D' then
  Begin
    Pc_Gst2013_Del_Web_Imagem(Pc_Operacao,Pc_cd_Imagem,Pc_PAth);
  end
  else
  Begin
    It_Resultado := '';
    try
      It_SqlTxt := 'SELECT '+
                   'id, '+
                    It_tb_Institution_id + ' tb_institute_id, '+
                   ' kind, '+
                   ' target, '+
                   ' table_id, '+
                   ' file_name, '+
                   ' extension, '+
                   ' content, '+
                   ' link '+
                   'from tb_images '+
                   'where id=:id ';
      with It_Qr_Consulta do
      Begin
        Active := false;
        SQL.Clear;
        SQL.Add(It_SqlTxt);
        ParamByName('id').AsString := Pc_Cd_Imagem;
        Active := True;
        FetchAll;
        It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                     '<chaves xmlns="' + Gb_Site + '/">'+
                     '<id>'                 + FieldByName('id').AsString + '</id>'+
                     '<tb_institution_id>'  + It_tb_Institution_id + '</tb_institution_id>'+

                     '</chaves>';
        //'<table_id>' + FieldByName('table_id').AsString + '</table_id>'+
        It_Xml_Doc := createXMLDOC('');
        with It_Xml_Doc.XML do
        Begin
          Add('<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>');
          Add('<images xmlns="' + Gb_Site + '">');
          Add('<id>'               + FieldByName('id').AsString       + '</id>');
          Add('<tb_institution_id>'+ It_tb_Institution_id + '</tb_institution_id>');
          Add('<kind>' + FieldByName('kind').AsString + '</kind>');
          Add('<target>' + FieldByName('target').AsString + '</target>');
          Add('<table_id>' + FieldByName('table_id').AsString + '</table_id>');
          Add('<file_name>' + FieldByName('file_name').AsString + '</file_name>');
          Add('<content><![CDATA[' + EncodeBase64(FieldByName('content').AsString) +']]></content>');
          Add('<extension>' + FieldByName('extension').AsString + '</extension>');
          Add('<link>' + FieldByName('link').AsString + '</link>');
          Add('<path_img>' + Pc_PAth + '</path_img>');
          Add('</images>');

        end;
        It_Xml_Doc.Active := True;
        if It_SalvaXMl then It_Xml_Doc.SaveToFile(GbPathExe +'xml_images' + FieldByName('table_id').AsString + '.xml');
      end;
      //Função que pega os dados e gera o XMl
      It_ws := Fc_Ws_Gst2013();
      Try
        It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_operacao,It_Xml_Doc.XML.Text,It_Xml_Pk);
      Except
        on E : Exception do
          It_Resultado := '<resultado>Erro:'+ E.Message +'</resultado>';
      End;
      It_XML.Clear;
    except
      It_Xml_Doc.SaveToFile(GbPathExe +'xml_imagem' + It_Qr_Consulta.FieldByName('table_id').AsString + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível enviar a imagem para o Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;
procedure Pc_Gst2013_Del_Web_Imagem(Pc_Operacao,Pc_cd_Imagem,Pc_PAth:String);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'images';
  It_Resultado := '';
  try
      It_SqlTxt := 'SELECT '+
                   'id, '+
                    It_tb_Institution_id + ' tb_institute_id, '+
                   ' target, '+
                   ' table_id, '+
                   ' file_name '+
                   'from tb_images '+
                   'where id=:id ';

    with It_Qr_Consulta do
    Begin
      Active := false;
      SQL.Clear;
      SQL.Add(It_SqlTxt);
      ParamByName('id').AsString := Pc_Cd_Imagem;
      Active := True;
      FetchAll;
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>'                 + FieldByName('id').AsString + '</id>'+
                   '<tb_institution_id>'  + It_tb_Institution_id + '</tb_institution_id>'+
                   '</chaves>';
      It_Xml_Doc := createXMLDOC('');
      with It_Xml_Doc.XML do
      Begin
        Add('<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>');
        Add('<images xmlns="' + Gb_Site + '">');
        Add('<id>'               + FieldByName('id').AsString       + '</id>');
        Add('<tb_institution_id>'+ It_tb_Institution_id + '</tb_institution_id>');
        Add('<target>' + FieldByName('target').AsString + '</target>');
        Add('<file_name>' + FieldByName('file_name').AsString + '</file_name>');
        Add('<path_img>' + Pc_PAth + '</path_img>');
        Add('</images>');
      end;
      It_Xml_Doc.Active := True;
      if It_SalvaXMl then It_Xml_Doc.SaveToFile(GbPathExe +'del_xml_images' + FieldByName('table_id').AsString + '.xml');
      end;
    //Função que pega os dados e gera o XMl
    It_ws := Fc_Ws_Gst2013();
    try
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_operacao,It_Xml_Doc.XML.Text,It_Xml_Pk);
    finally
      It_Xml_Doc.XML.Clear;
    end;
  except
    It_Xml_Doc.SaveToFile(GbPathExe +'del_xml_imagem' + It_Qr_Consulta.FieldByName('table_id').AsString + '.xml');
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não foi possível enviar a imagem para o Site.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
  end;
end;

procedure Pc_Gst2013_Atu_Web_CapaAlbum(Pc_cd_Imagem,Pc_cd_Produto:String);
Begin
  //Altera todas para normal
  Fc_Ws_Gst2013_Cmd_Customizado('image','UPDATE tb_image set kind = ''N'' where link_id = '+ Pc_cd_Produto);
  //Altera a escolhida como capa
  Fc_Ws_Gst2013_Cmd_Customizado('image','UPDATE tb_image set kind = ''C'' where id = '+ Pc_cd_Imagem);
end;

procedure Pc_Gst2013_Atu_Web_DeletaImagemAlbum(Pc_cd_Imagem,Pc_cd_Produto:String);
Begin
  try
    It_XML := TStringList.Create;
    It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
    It_XML.Add('<image xmlns="' + Gb_Site + '"> ');
    It_XML.Add('		<id>' + Pc_cd_Imagem + '</id> ');
    It_XML.Add('		<bond_id>' + Pc_cd_Produto + '</bond_id> ');
    It_XML.Add('		<kind>C</kind> ');
    It_XML.Add('	</image>' );
    if It_SalvaXMl then It_xml.SaveToFile(GbPathExe +'Deleta_imagem' + Pc_cd_Produto + '.xml');
    //Função que pega os dados e gera o XMl
    It_ws := Fc_Ws_Gst2013();
    It_Xml_Pk := '';
    It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'image','DP',It_xml.Text,It_Xml_Pk);
    It_XML.Clear;
  except
    It_xml.SaveToFile(GbPathExe +'Deleta_imagem' + Pc_cd_Produto + '.xml');
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não foi possível alterar a capa do àlbum.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
  end;
end;

procedure Pc_Gst2013_Env_TRay_Imagem(Pc_Operacao,Pc_cd_Imagem,Pc_PAth:String);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'imagesfiles';

  if Pc_Operacao = 'D' then
  Begin

  end
  else
    Begin
    It_Resultado := '';
    try
      It_SqlTxt := 'SELECT '+
                   'id, '+
                    It_tb_Institution_id + ' tb_institute_id, '+
                   ' kind, '+
                   ' target, '+
                   ' table_id, '+
                   ' file_name, '+
                   ' extension, '+
                   ' content, '+
                   ' link '+
                   'from tb_images '+
                   'where id=:id ';
      with It_Qr_Consulta do
      Begin
        Active := false;
        SQL.Clear;
        SQL.Add(It_SqlTxt);
        ParamByName('id').AsString := Pc_Cd_Imagem;
        Active := True;
        FetchAll;
        It_Xml_Pk := concat(
                      '<?xml version="1.0" encoding="', it_enconding , '" standalone="yes"?>',
                      '<chaves xmlns="' , Gb_Site , '/">',
                      '<id>'                , FieldByName('id').AsString , '</id>',
                      '<tb_institution_id>' , It_tb_Institution_id , '</tb_institution_id>',
                     '</chaves>');
        //'<table_id>' + FieldByName('table_id').AsString + '</table_id>'+
        It_Xml_Doc := createXMLDOC('');
        with It_Xml_Doc.XML do
        Begin
          Add(concat(
                '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>',
                '<images xmlns="' , Gb_Site , '">',
                '<id>', FieldByName('id').AsString ,'</id>',
                '<tb_institution_id>', It_tb_Institution_id ,'</tb_institution_id>',
                '<kind>' , FieldByName('kind').AsString , '</kind>',
                '<target>' , FieldByName('target').AsString , '</target>',
                '<table_id>' , FieldByName('table_id').AsString , '</table_id>',
                '<file_name>' , FieldByName('file_name').AsString , '</file_name>',
                '<content><![CDATA[' , EncodeBase64(FieldByName('content').AsString),']]></content>',
                '<extension>' + FieldByName('extension').AsString , '</extension>',
                '<link>' , FieldByName('link').AsString , '</link>',
                '<path_img>' ,Pc_PAth , '</path_img>',
                '</images>'));

        end;
        It_Xml_Doc.Active := True;
        if It_SalvaXMl then It_Xml_Doc.SaveToFile(GbPathExe +'xml_images' + FieldByName('table_id').AsString + '.xml');
        end;
      //Função que pega os dados e gera o XMl
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_operacao,It_Xml_Doc.XML.Text,It_Xml_Pk);
      It_XML.Clear;
    except
      It_Xml_Doc.SaveToFile(GbPathExe +'xml_imagem' + It_Qr_Consulta.FieldByName('table_id').AsString + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível enviar a imagem para o Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
End;
//-------------------------Orçamentos - Budget--------------------------------

function  Fc_Gst2013_Atu_Web_Budget():WideString;
Var
  Lc_SqlTxt : String;
Begin
  Result := '';
  Lc_SqlTxt := 'SELECT id,dt_record,nickname,phone, discount_aliq, discount_value, additional_value, email from tb_budget '+
               ' WHERE (desktop_id is null) ';

  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
             '<budget xmlns="' + gb_site + '">'+
             '<QUERY>'+Lc_SqlTxt +'</QUERY>'+
             '</budget>');
  It_Xml_Pk := '';
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'budget','C',It_xml.Text,It_Xml_Pk);
  It_XML.Clear;
end;

function Fc_Gst2013_Atu_Dkp_Budget(Fc_Operacao,Fc_codigo: string):boolean;
Var
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_Cd_Cotacao : Integer;
  Lc_Cd_Pedido : Integer;
  Lc_Cd_Vendedor : String;
  Lc_Vl_Itens:TStringList;
  Lc_VL_Cotacao : REal;
  Lc_VL_Produto : Real;
  Lc_VL_Servico : Real;
  Lc_VL_Adicional : Real;
  Lc_Vl_Desconto : Real;
Begin
  Result := false;
  Lc_Resultado := Fc_Gst2013_Atu_Web_Budget;
  It_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.

  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  Lc_Dados:= Lc_NodePai;
  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  repeat
    //id,dt_record,nickname,phone, discount_aliq, discount_value, additional_value, email
    //Pega os dados dentro do Componenente conforme a Tag
    //21/12/2017 - Foi retirada pois a função será desativada
    Lc_Cd_Pedido  := 0;
    if (GB_Cd_Vendedor > 0) then
      Lc_Cd_Vendedor := IntToStr(GB_Cd_Vendedor)
    else
      Lc_Cd_Vendedor := IntToStr(DM_ListaConsultas.Qr_ListaVendedor.FieldByname('CLB_CODIGO').AsInteger);
    Lc_Cd_Cotacao := Fc_AtualizaCotacao('0',
                                        IntToStr(Lc_Cd_Pedido),
                                        '',//Fc_NUMERO,
                                        '0',//Fc_TIPO,
                                        IntToStr(Gb_Cd_Usuario),
                                        Fc_DataMysql(Lc_Dados.ChildNodes[1].text),
                                        '0',
                                        Lc_Dados.ChildNodes[2].text,
                                        IntToStr(Fc_PegaParteFormaPgto('DINHEIRO')),
                                        '000 - A VISTA',
                                        'N', //Fc_APROVADO,
                                        '0', //Qt_produto
                                        '0', //Fc_VL_PRODUTO,
                                        '0', //Fc_VL_SERVICO,
                                        '0', //Fc_VL_FRETE,
                                        Lc_Dados.ChildNodes[4].text, //Aliq Desconto
                                        Lc_Dados.ChildNodes[5].text, //Fc_VL_DESCONTO,
                                        '0', //Fc_VL_COTACAO,
                                        Lc_Dados.ChildNodes[3].text, //Fc_CONTATO,
                                        '', //Fc_VALIDADE,
                                        '', //Fc_PRZ_ENTREGA,
                                        '', //Fc_GARANTIA,
                                        '', //Fc_FROTA,
                                        '', //Fc_EQUIPAMENTO,
                                        '', //Fc_TP_FRETE,
                                        Lc_Dados.ChildNodes[7].text, //Fc_EMAIL_E,
                                        Lc_Cd_Vendedor,
                                        '', //Fc_TP_CONTATO,
                                        IntToStr(Gb_CodMha),
                                        '', //Fc_CONTATOEMPRESA,
                                        '0', //Fc_CODTRP,
                                        '0', //Fc_VL_CUSTO,
                                        '', //Fc_OBS_CORTE,
                                        '', //Fc_OBS,
                                        '', //Fc_DT_ENV_EMAIL,
                                        '0', //Fc_CODSIT,
                                        '', //Fc_SOLICITANTE,
                                        Lc_Dados.ChildNodes[6].text);
    //Atualiza os Itens da Cotação
    Lc_Vl_Itens := TStringList.Create;
    Lc_Vl_Itens := Fc_Gst2013_Atu_Dkp_Itens_Budget(Lc_Cd_Cotacao,Lc_Cd_Pedido, Lc_Dados.ChildNodes[0].text,StrToFloatDef(Lc_Dados.ChildNodes[4].text,0));
    //Atualiza Service Order
    Fc_Gst2013_Atu_Dkp_VehicleSo(IntToStr(Lc_Cd_Cotacao),Lc_Dados.ChildNodes[0].text,IntToStr(Lc_Cd_Pedido));
    //Check List
    Fc_Gst2013_Atu_Dkp_VehicleCheckList(IntToStr(Lc_Cd_Cotacao),Lc_Dados.ChildNodes[0].text);
    //Calcula os totais para atualizar a cotação
    Lc_VL_Produto := StrToFloatDef(Lc_Vl_Itens.Strings[0],0);
    Lc_VL_Servico := StrToFloatDef(Lc_Vl_Itens.Strings[1],0);
    Lc_Vl_Desconto := StrToFloatDef(Lc_Dados.ChildNodes[5].text,0);
    Lc_VL_Adicional := StrToFloatDef(Lc_Dados.ChildNodes[6].text,0);
    Lc_VL_Cotacao := Lc_VL_Produto +
                     Lc_VL_Servico +
                     Lc_VL_Adicional -
                     Lc_Vl_Desconto;

    Pc_AtualizaTotalCotacao(IntToStr(Lc_Cd_Cotacao),
                                    Lc_Vl_Itens.Strings[2],
                                    Lc_Vl_Itens.Strings[0],
                                    Lc_Vl_Itens.Strings[1],
                                    '0',
                                    Lc_Dados.ChildNodes[4].text, //Aliq Desconto
                                    Lc_Dados.ChildNodes[5].text, //Fc_VL_DESCONTO,
                                    FloatToStr(Lc_VL_COTACAO),
                                    '0',
                                    Lc_Dados.ChildNodes[6].text);


    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;
  Result := true;
end;

//-------------------------Controle Itens da Cotação - itembudget----------------------
function Fc_Gst2013_Clt_Web_Itens_Budget(Pc_Cd_Cotacao: String):WideString;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT '+
               ' bond_id, '+
               ' kind, '+
               ' description, '+
               ' qtty, '+
               ' unit_value '+
               'from tb_item_budget '+
               'WHERE tb_institution_id = '''+ It_tb_Institution_id + '''' +
               ' and tb_budget_id      = '''+ Pc_Cd_Cotacao + '''';
  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<cotacao xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</cotacao> ');
  It_Xml_Pk := '';
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'itembudget','C',It_xml.Text,It_Xml_Pk);
  It_XML.Clear;
end;

function Fc_Gst2013_Atu_Dkp_Itens_Budget(Fc_Cd_Cotacao,Fc_Cd_Pedido:Integer; Fc_Cd_Budget:String; Fc_Aq_Desc:Real):TStringList;
Var
  Lc_Xml_Doc : TXMLDocument;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  lc_Vl_Desc:Real;
  Lc_Vl_Produto:Real;
  Lc_Qt_Produto : Real;
  Lc_VL_Servico : Real;

Begin
  Result := TStringList.Create;
  //Verifica se há conexao com a Internet
  Lc_Resultado := Fc_Gst2013_Clt_Web_Itens_Budget(Fc_Cd_Budget);
  Lc_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := Lc_Xml_Doc.DocumentElement.childNodes.First;

  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  //Cria a consulta
  Lc_Dados:= Lc_NodePai;
  Lc_Vl_Produto := 0;
  Lc_Qt_Produto := 0;
  Lc_VL_Servico := 0;

  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  repeat
    //Pega os dados dentro do Componenente conforme a Tag
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if (Lc_Dados.ChildNodes[1].text = 'P') then
      Begin
      Lc_Vl_Produto := Lc_Vl_Produto + StrTofloatDef(Lc_Dados.ChildNodes[3].text,0) * StrTofloatDef(Lc_Dados.ChildNodes[4].text,0);
      Lc_Qt_Produto := Lc_Qt_Produto + StrTofloatDef(Lc_Dados.ChildNodes[3].text,0);

      end
    else
      Begin
      Lc_VL_Servico := Lc_VL_Servico + StrTofloatDef(Lc_Dados.ChildNodes[3].text,0) * StrTofloatDef(Lc_Dados.ChildNodes[4].text,0)
      end;

    lc_Vl_Desc := StrTofloatDef(Lc_Dados.ChildNodes[3].text,0) * StrTofloatDef(Lc_Dados.ChildNodes[4].text,0);
    lc_Vl_Desc := lc_Vl_Desc * (Fc_Aq_Desc/100);
    // bond_id  kind  description  qtty unit_value
    Fc_AtualizaItensCotacao('0',
                            IntToStr(Fc_Cd_Cotacao),
                            Lc_Dados.ChildNodes[1].text,
                            Lc_Dados.ChildNodes[0].text, // FieldByname('PPD_CODPRO_D').AsString,
                            Lc_Dados.ChildNodes[2].text, //FieldByname('PRO_DESCRICAO').AsString,
                            Lc_Dados.ChildNodes[3].text,
                            Lc_Dados.ChildNodes[4].text,
                            'S',
                            '0',
                            FloatToStr(lc_Vl_Desc),
                            FloatToStr(Fc_Aq_Desc),
                            '0',
                            '0',
                            IntToStr(Gb_Estoque),
                            '1',
                            '0',
                            '',   //FC_MR_LUCRO,
                            '',   //FC_ALIQ_CT_FINANCEIRO,
                            '',   //FC_PRZ_PRATICADO,
                            '',   //FC_VL_PRATICADO,
                            '',   //FC_AQ_VENDEDOR,
                            '',   //FC_TECIDO,
                            '',   //FC_COR,
                            IntToStr(Fc_Cd_Pedido));
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;
  Result.Clear;
  Result.Add(FloatToStr(Lc_Vl_Produto));
  Result.Add(FloatToStr(Lc_VL_Servico));
  Result.Add(FloatToStr(Lc_Qt_Produto));
end;


//-------------------------Controle de Pedido - Order--------------------------------
function Fc_Gst2013_Clta_Web_Order(codigoVendedor:Integer):WideString;
Var
  Lc_SqlTxt : String;
  Lc_DateTime : String;
Begin
  Result := '';
  Lc_DateTime := Fc_SyncTableGetUpdateAt('tb_order_sale',CodigoVendedor);
  Lc_SqlTxt := 'SELECT tb_order.id, '+
              '  tb_order.tb_institution_id, '+
              '  tb_order.dt_record, '+
              '  tb_order.note, '+
              '  tb_order.status, '+
              '  tb_order_sale.tb_salesman_id, '+
              '  tb_order_sale.tb_customer_id, '+
              '  tb_order_sale.number, '+
              '  tb_person.cpf doc, '+
              '  tb_address.kind, '+
              '  tb_address.tb_city_id, '+
              '  tb_order.updated_at '+
              'FROM tb_order '+
              'INNER JOIN tb_order_sale ON ( tb_order_sale.id = tb_order.id ) '+
              'INNER JOIN tb_person ON ( tb_person.id = tb_order_sale.tb_customer_id ) '+
              'INNER JOIN tb_address ON ( tb_address.id = tb_order_sale.tb_customer_id ) '+
              'WHERE ( tb_order.updated_at  > '''+ Lc_DateTime + ''' ) '+
              ' and (tb_order_sale.tb_salesman_id = ' + IntToStr(codigoVendedor) + ') '+
              ' AND (tb_order.tb_institution_id = '''+ It_tb_Institution_id + ''' ) '+
              ' AND ('+
              '         ((tb_address.kind = ''Entrega'') XOR (tb_address.kind = ''Cobranca'')) '+
              '      XOR '+
              '         ((tb_address.kind = ''Entrega'') XOR (tb_address.kind = ''Comercial'')) '+
              '      ) '+
              'UNION '+
              'SELECT tb_order.id, '+
              '  tb_order.tb_institution_id, '+
              '  tb_order.dt_record, '+
              '  tb_order.note, '+
              '  tb_order.status, '+
              '  tb_order_sale.tb_salesman_id, '+
              '  tb_order_sale.tb_customer_id, '+
              '  tb_order_sale.number, '+
              '  tb_company.cnpj doc,' +
              '  kind, '+
              '  tb_city_id, '+
              '  tb_order_sale.updated_at '+
              'FROM tb_order '+
              'INNER JOIN tb_order_sale ON ( tb_order_sale.id = tb_order.id ) '+
              'INNER JOIN tb_company ON ( tb_company.id = tb_order_sale.tb_customer_id ) '+
              'INNER JOIN tb_address ON ( tb_address.id = tb_order_sale.tb_customer_id ) '+
              'WHERE ( tb_order.updated_at  > '''+ Lc_DateTime + ''' ) '+
              ' and (tb_order_sale.tb_salesman_id = ' + IntToStr(codigoVendedor) + ') '+
              ' AND (tb_order.tb_institution_id  = '''+ It_tb_Institution_id + ''' ) '+
              ' AND ('+
              '         ((tb_address.kind = ''Entrega'') XOR (tb_address.kind = ''Cobranca'')) '+
              '      XOR '+
              '         ((tb_address.kind = ''Entrega'') XOR (tb_address.kind = ''Comercial'')) '+
              '      ) '+
              'order by 12 asc ';

  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
             '<order xmlns="' + gb_site + '">'+
             '<QUERY>'+Lc_SqlTxt +'</QUERY>'+
             '</order>');
  It_Xml_Pk := '';
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'order','C',It_xml.Text,It_Xml_Pk);
  It_XML.Clear;


end;

Function GetCodigoEmpresa(CNPJ_CFP:String):Integer;
Var
  Empresa : TControllerEmpresa;
Label
  Volta;
Begin
  Empresa := TControllerEmpresa.Create(Application);
Volta:
  Empresa.Registro.CpfCNPJ := CNPJ_CFP;
  Empresa.getByDocumento;
  if Empresa.Registro.Codigo > 0  then
  Begin
    
    Result := Empresa.Registro.Codigo;
  end
  else
  Begin
    Fc_Gst_Atu_Dkp_Entity(CNPJ_CFP);
    Goto Volta;
  end;
  FreeAndNil(Empresa);
End;

Function GetCodigoEndereco(CNPJ_CFP:String):Integer;
Var
  Endereco : TControllerEndereco;
Label
  Volta;
Begin
  Endereco := TControllerEndereco.Create(Application);
Volta:
  Endereco.getByDocumento(CNPJ_CFP);
  if Endereco.Registro.Codigo > 0  then
  Begin
    Result := Endereco.Registro.Codigo;
  end
  else
  Begin
    Fc_Gst_Atu_Dkp_Address('',CNPJ_CFP);
    Goto Volta;
  end;
  FreeAndNil(Endereco);
End;

function Fc_Gst2013_Atu_Dkp_Order(CodigoVendedor : Integer):boolean;
Var
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_cd_Empresa : Integer;
  Lc_cd_Endereco : Integer;
  Lc_Vl_Pedido : Real;
  Lc_CNPJ_CFP:String;
  Lc_order_id, Lc_institution_id,Lc_salesman_id:integer;
  Lc_dt_record:TDateTime;
  Lc_Cd_Vendedor : Integer;
  Pedido : TControllerPedido;
Begin
  Result := false;
  Lc_Resultado := Fc_Gst2013_Clta_Web_Order(CodigoVendedor);
  It_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.

  if (Lc_NodePai.ChildNodes.Count = 0) then exit;

  if GB_Cd_Vendedor > 0 then
  Begin
    Lc_Cd_Vendedor := GB_Cd_Vendedor;
  End
  else
  Begin
    DM_ListaConsultas.Pc_ListaVendedor;
    Lc_Cd_Vendedor := DM_ListaConsultas.Qr_ListaVendedor.FieldByName('CLB_CODIGO').AsInteger;
  End;
  Pedido := TControllerPedido.Create(Application);
  Lc_Dados:= Lc_NodePai;
  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  repeat
    Pedido.Clear;
    with Pedido.Registro do
    Begin
      codigo := 0;
      if (Lc_Dados.ChildValues['id'] <> null) then
        CodigoWeb := StrToIntDef(Lc_Dados.ChildValues['id'],0)
      else
        CodigoWeb := 0;


      Vendedor := Lc_Cd_Vendedor;
      if (Lc_Dados.ChildValues['tb_salesman_id'] <> null) then
        if StrToIntdef(Lc_Dados.ChildValues['tb_salesman_id'],0) > 0 then
          Vendedor := StrToInt( Lc_Dados.ChildValues['tb_salesman_id']);
      //veririfca se o pedido já não está faturado no sistema (Codigo do pedido e vendedor)
      if not Pedido.WebFaturado then
      Begin
        if not Pedido.Numerado then
        Begin
        //Verifica se o cliente já existe e o endereço existe
        Lc_cd_Empresa := 0;
        Lc_cd_Endereco := 0;
        if (Lc_Dados.ChildValues['doc'] <> null) then
        Begin
          Lc_CNPJ_CFP := Lc_Dados.ChildValues['doc'];
          if (Lc_cd_Empresa = 0) then
            Lc_cd_Empresa := GetCodigoEmpresa(Lc_CNPJ_CFP);
          if (Lc_cd_Endereco = 0) then
            Lc_cd_Endereco := GetCodigoEndereco(Lc_CNPJ_CFP);
        end;
        Empresa := Lc_cd_Empresa;
        //Apaga os itens do pedido para garantir a gravação caso tenha acontecido algum erro anterior
        if (Lc_Dados.ChildValues['number'] <> null) then
        Begin
          if (Lc_Dados.ChildValues['id'] <> null) then
            Pedido.DeletaItens;
        end;
        //Prepara a inserção
        Tipo := 1;
        Numero := 0;
        //Verifica o usuario que fez o donwload do Pedido
        Usuario := GB_Cd_Usuario;
        Data := Date;
        if (Lc_Dados.ChildValues['dt_record'] <> null) then
          Data := StrToDateDef(Lc_Dados.ChildValues['dt_record'],Date);

        //TRAZER UM CODIGO DE FORMA DE PAGAMENTO
        FormaPagto := Fc_PegaParteFormaPgto('DINHEIRO');
        Prazo := '000 - VISTA';
        Endereco := Lc_cd_Endereco;
        Faturado := 'N';
        TipoContato   := '3'; //TIPO DE cONTATO PELO SITE
        DataEntrega := Date + 3;
        EnderecoEntrega := Lc_cd_Endereco;
        EnderecoFaturamento := Lc_cd_Endereco;
        EnderecoCobranca := Lc_cd_Endereco;
        CodigoEstabelecimento := Gb_CodMha;
        Aprovado := 'N';
        Validade := Date + 5;
        if ( Lc_Dados.ChildValues['note'] <> null ) then
          Observacao := Lc_Dados.ChildValues['note']
        else
          Observacao := '';
        Pedido.salvaPedidoInternet;
        //Atualizar os itens do pedido
        Lc_order_id       := StrToIntDef(Lc_Dados.ChildValues['id'],0);
        Lc_institution_id := StrToIntDef(Lc_Dados.ChildValues['tb_institution_id'],0);
        Lc_salesman_id    := Pedido.Registro.Vendedor; // StrToIntDef(Lc_Dados.ChildValues['tb_salesman_id'],0);
        Lc_dt_record := StrToDateDef(Lc_Dados.ChildValues['dt_record'],Date);
        Fc_Gst2013_Atu_Dkp_Order_Item(Pedido.Registro.codigo,Lc_order_id,Lc_institution_id,Pedido.Registro.Vendedor,Lc_dt_record);
        end;
        //Registra a ultima data que foi atualizada da internet
        Fc_SyncTableUpdate('tb_order_sale',Lc_Dados.ChildValues['updated_at'],IntToStr(Pedido.Registro.Vendedor) );
      End;
      Lc_Dados := Lc_Dados.NextSibling;

    End;
  until Lc_Dados = nil;
  FreeAndNil(Pedido);
  Result := true;
end;

  //-------------------------Resultado de Operação Financeira Externa----------------------------------
function  Fc_Gst2013_Clt_Web_Ext_Fin_Oper:WideString;
Var
  Lc_SqlTxt : String;
  Lc_Situacao : String;
  Lc_DateTime : String;
Begin
  Lc_DateTime := Fc_SyncTableGetUpdateAt('tb_ext_fin_oper',0);

  It_Xml_Pk := '';
  Lc_Situacao := 'S';
  Lc_SqlTxt := 'select '+
               '  id, '+
               '  external_id, '+
               '  dt_transation, '+
               '  dt_credit, '+
               '  original_value, '+
               '  shop_value, '+
               '  total_value, '+
               '  discount, '+
               '  addition, '+
               '  pay_method, '+
               '  parcel, '+
               '  status_id, '+
               '  status, '+
               '  updated_at '+
               'from tb_ext_fin_oper '+
               'WHERE ( updated_at  > '''+ Lc_DateTime + ''' ) ';

  //Envia a consulta para o WebService
  It_XML := TStringList.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<pagamentodigital xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</pagamentodigital> ');
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'extfinoper','C',It_XML.Text,It_Xml_Pk);
  It_XML.Clear;

end;


function  Fc_Gst2013_Atu_Dkp_Ext_Fin_Oper(Fc_Operacao,Fc_codigo: string):boolean;
Var
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_Dados_shipping: IXMLNode;
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
Begin
  Result := false;
  Lc_Resultado := Fc_Gst2013_Clt_Web_Ext_Fin_Oper;
  It_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.

  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  Lc_Dados:= Lc_NodePai;
  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    Active := False;
    SQL.Clear;

    repeat
      //Cria a consulta
      Lc_SqlTxt := 'UPDATE OR INSERT INTO "TB_PAG_ELETRONICO" ( '+
                   '   "PGE_CODIGO" '+
                   ' , "PGE_CODPED" '+
                   ' , "PGE_TRANSACAO" '+
                   ' , "PGE_DATA" ';

      if (Lc_Dados.ChildValues['dt_credit'] <> null) then
        Lc_SqlTxt := Lc_SqlTxt + ' , "PGE_DT_CREDITO" ';

      Lc_SqlTxt := Lc_SqlTxt +
                   ' , "PGE_VL_ORIGNAL" '+
                   ' , "PGE_VL_LOJA" '+
                   ' , "PGE_VL_TOTAL" '+
                   ' , "PGE_VL_DESCONTO" '+
                   ' , "PGE_VL_ACRESCIMO" '+
                   ' , "PGE_FRM_PAGTO" '+
                   ' , "PGE_PARCELAS" '+
                   ' , "PGE_STATUS" '+
                   ' , "PGE_CD_STATUS" '+
                   ' , "PGE_VL_FRETE" '+
                   ' , "PGE_TIPO_FRETE" ) '+
                   ' values( '+
                   '   :"PGE_CODIGO" '+
                   ' , :"PGE_CODPED" '+
                   ' , :"PGE_TRANSACAO" '+
                   ' , :"PGE_DATA" ';

      if (Lc_Dados.ChildValues['dt_credit'] <> null) then
        Lc_SqlTxt := Lc_SqlTxt + ' , :"PGE_DT_CREDITO" ';

      Lc_SqlTxt := Lc_SqlTxt +
                   ' , :"PGE_VL_ORIGNAL" '+
                   ' , :"PGE_VL_LOJA" '+
                   ' , :"PGE_VL_TOTAL" '+
                   ' , :"PGE_VL_DESCONTO" '+
                   ' , :"PGE_VL_ACRESCIMO" '+
                   ' , :"PGE_FRM_PAGTO" '+
                   ' , :"PGE_PARCELAS" '+
                   ' , :"PGE_STATUS" '+
                   ' , :"PGE_CD_STATUS" '+
                   ' , :"PGE_VL_FRETE" '+
                   ' , :"PGE_TIPO_FRETE" ) '+
                   ' MATCHING (PGE_CODPED) ';

      Active := False;
      SQL.Clear;
      SQL.Add(Lc_SqlTxt);


      //Pega os dados dentro do Componenente conforme a Tag
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      Active := False;

      ParamByName('PGE_CODIGO').AsInteger := Fc_Generator('GN_PAG_ELETRONICO','TB_PAG_ELETRONICO','PGE_CODIGO');
      ParamByName('PGE_CODPED').AsInteger := StrToIntDef(Lc_Dados.ChildValues['id'],0);
      ParamByName('PGE_TRANSACAO').AsString := Lc_Dados.ChildValues['external_id'];
      ParamByName('PGE_DATA').Asdate := StrToDateDef(Lc_Dados.ChildValues['dt_transation'],Date);
      if (Lc_Dados.ChildValues['dt_credit'] <> null) then
        ParamByName('PGE_DT_CREDITO').Asdate := StrToDateDef(Lc_Dados.ChildValues['dt_credit'],Date);
      ParamByName('PGE_VL_ORIGNAL').AsCurrency :=  StrToFloatDef(Lc_Dados.ChildValues['original_value'],0);
      ParamByName('PGE_VL_LOJA').AsCurrency :=   StrToFloatDef(Lc_Dados.ChildValues['shop_value'],0);
      ParamByName('PGE_VL_TOTAL').AsCurrency :=  StrToFloatDef(Lc_Dados.ChildValues['total_value'],0);
      if (Lc_Dados.ChildValues['dt_credit'] <> null) then
        ParamByName('PGE_VL_DESCONTO').AsCurrency := StrToFloatDef(Lc_Dados.ChildValues['discount'],0);
      if (Lc_Dados.ChildValues['discount'] <> null) then
        ParamByName('PGE_VL_ACRESCIMO').AsCurrency := StrToFloatDef(Lc_Dados.ChildValues['addition'],0)
      else
        ParamByName('PGE_VL_ACRESCIMO').AsCurrency := 0;
      if (Lc_Dados.ChildValues['pay_method'] <> null) then
        ParamByName('PGE_FRM_PAGTO').AsString := Lc_Dados.ChildValues['pay_method']
      else
        ParamByName('PGE_FRM_PAGTO').AsString := 'Não informado';
      if (Lc_Dados.ChildValues['parcel'] <> null) then
        ParamByName('PGE_PARCELAS').AsString := Lc_Dados.ChildValues['parcel']
      else
        ParamByName('PGE_PARCELAS').AsString := '1';

      if (Lc_Dados.ChildValues['status'] <> null) then
        ParamByName('PGE_STATUS').AsString := Lc_Dados.ChildValues['status'];

      if (Lc_Dados.ChildValues['status_id'] <> null) then
        ParamByName('PGE_CD_STATUS').AsString := Lc_Dados.ChildValues['status_id'];

      //Consulta dados do Entrega pois nesta versão estão em tabelas diferentes
      Lc_Resultado := Fc_Gst2013_Clt_Web_shipping(Lc_Dados.ChildValues['id']);
      It_Xml_Doc.XML.Clear;
      It_Xml_Doc.XML.Add(Lc_Resultado);
      It_Xml_Doc.Options := [];
      It_Xml_Doc.NodeIndentStr := '<tab>';
      It_Xml_Doc.Active := true;
      Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
      //Se o nº for Zero não tem dados então sai.
      if (Lc_NodePai.ChildNodes.Count > 0) then
        Begin
        Lc_Dados_shipping := Lc_NodePai;
        // Posiciona o primeiro elemento encontrado
        Lc_Dados_shipping.ChildNodes.First;
        if (Lc_Dados_shipping.ChildValues['value'] <> null) then
          ParamByName('PGE_VL_FRETE').AsCurrency := StrToFloatDef(Lc_Dados_shipping.ChildValues['value'],0);
        if (Lc_Dados_shipping.ChildValues['kind'] <> null) then
          ParamByName('PGE_TIPO_FRETE').AsString := Lc_Dados_shipping.ChildValues['kind'];
        end;
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      //Registra a ultima data que foi atualizada da internet
      Fc_SyncTableUpdate('tb_ext_fin_oper',Lc_Dados.ChildValues['updated_at'],'0');
      Lc_Dados := Lc_Dados.NextSibling;
    until Lc_Dados = nil;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
  Result := true;


end;

procedure Pc_Gst2013_Atu_Dkp_Web_Ext_Fin_Oper(Pc_Cd_Web: string);
BEgin



end;

//-------------------------Controle de Remessas - Shipping ---------------------------------
function Fc_Gst2013_Clt_Web_shipping(Fc_order_id:String):WideString;
Var
  Lc_SqlTxt : String;
Begin
  It_Xml_Pk := '';
  Lc_SqlTxt := 'select '+
               '  kind, '+
               '  value '+
               'from tb_shipping '+
               'where id = ' + Fc_order_id;

  //Envia a consulta para o WebService
  It_XML := TStringList.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<pagamentodigital xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</pagamentodigital> ');
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'shipping','C',It_XML.Text,It_Xml_Pk);
  It_XML.Clear;
end;

//-------------------------Controle Itens do Pedido - orderItem----------------------
function Fc_Gst2013_Clt_Web_Order_Item(tb_order_id, tb_institution_id,tb_salesman_id:Integer):WideString;
Var
  Lc_SqlTxt : String;
  Lc_DateTime : String;
Begin
  Lc_DateTime := Fc_SyncTableGetUpdateAt('tb_order_sale_item', tb_salesman_id );
  Lc_SqlTxt := 'SELECT tb_product_id,  qtty,  unit_value,  discount_aliquot, discount_value, updated_at '+
               'FROM tb_order_sale_item '+
               'WHERE (tb_order_sale_id = ' + IntToStr(tb_order_id) + ') ' +
                     ' and (tb_institution_id = ' + IntToStr(tb_institution_id) + ') '+
                     ' and (tb_salesman_id = ' + IntToStr(tb_salesman_id) + ') '+
                     ' and ( tb_order_sale_item.updated_at  > '''+ Lc_DateTime + ''' ) ';


  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<pedido xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</pedido> ');
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'order','C',It_XML.Text,It_XML.Text);
  It_XML.Clear;



end;

function Fc_Gst2013_Atu_Dkp_Order_Item(Fc_Cd_Dkp,tb_order_id, tb_institution_id,tb_salesman_id:Integer;dt_record:TDatetime):boolean;
Var
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_Operacao: string;
  Lc_Cd_Item: Integer;
  Lc_Cd_Pedido: Integer;
  Lc_Cd_Nota: Integer;
  Lc_Cd_Produto: Integer;
  Lc_Qtde: Real;
  Lc_VL_Custo: Real;
  Lc_VL_Unitario: Real;
  Lc_AQ_Desconto: Real;
  Lc_VL_Desconto: Real;
  Lc_Aliq_COM: Real;
  Lc_OPER: string;
  Lc_Estoque: string;
  Lc_Despacho: string;
  Lc_Aliq_IPI: Real;
  Lc_Aliq_ICMS: Real;
  Lc_Cd_Estoque: Integer;
  Lc_Cd_Tabela: Integer;
  Lc_Altura:double;
  Lc_Largura:double;
  Lc_sentido:String;
  Lc_Memo : TStringList;
  Lc_Qry_Item : TSTQuery;
Begin
  Result := false;
  Lc_Resultado := Fc_Gst2013_Clt_Web_Order_Item(tb_order_id, tb_institution_id,tb_salesman_id);
  It_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.

  if (Lc_NodePai.ChildNodes.Count = 0) then exit;

  Lc_Dados:= Lc_NodePai;
  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  //Ativa a Tabela de internet para pegar o codigo da Tabela de Preço

  //Garante que o Lancamento no Estoque não será efeutado duas Vezes
  Lc_Cd_Pedido := Fc_Cd_Dkp;

  Lc_Memo := TStringList.Create;
  Lc_Memo.Clear;
  //Cria Query para saber se insere ou atualiza item
  Lc_Qry_Item := TSTQuery.Create(Application);
  with Lc_Qry_Item do
  begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IBT_Consulta;
    ForcedRefresh := True;
    active := FAlse;
    Sql.Clear;
    Sql.Add('SELECT ITF_CODIGO '+
            'FROM TB_ITENS_NFL ' +
            'WHERE ITF_CODPED=:PED_CODIGO '+
            'AND ITF_CODPRO =:PRO_CODIGO ');
  end;
  repeat
    //Pega os dados dentro do Componenente conforme a Tag
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if (Lc_Dados.ChildValues['tb_product_id'] <> null) then
      Lc_Cd_Produto := StrToInt(Lc_Dados.ChildValues['tb_product_id'])
    else
      Lc_Cd_Produto := 0;
    Lc_Qry_Item.Active := False;
    Lc_Qry_Item.ParamByName('PED_CODIGO').AsInteger := Lc_Cd_Pedido;
    Lc_Qry_Item.ParamByName('PRO_CODIGO').AsInteger := Lc_Cd_Produto;
    Lc_Qry_Item.Active := True;
    Lc_Qry_Item.FetchAll;
    if Lc_Qry_Item.RecordCount > 0 then
    Begin
      Lc_Operacao := 'E';
      Lc_Cd_Item := Lc_Qry_Item.FieldByName('ITF_CODIGO').AsInteger;
    End
    else
    Begin
      Lc_Operacao := 'I';
      Lc_Cd_Item := 0;
      Lc_Cd_Nota := 0;
    End;

    Pc_Define_DecimalSeparator('.',',');
    if (Lc_Dados.ChildValues['qtty'] <> null) then
      Begin
        Lc_Qtde := StrtoFloatDef( Trim(Lc_Dados.ChildValues['qtty']),0)
      end
    else
      Lc_Qtde := 1;

    Lc_VL_Custo := 0;
    if (Lc_Dados.ChildValues['unit_value'] <> null) then
      Lc_VL_Unitario := StrtoFloatDEf( Lc_Dados.ChildValues['unit_value'],0)
    else
      Lc_VL_Unitario := 1;
    Pc_Define_DecimalSeparator(',','.');


    Lc_AQ_Desconto := 0;
    Lc_VL_Desconto := 0;
    Lc_Aliq_COM    := 0;
    Lc_OPER := 'V';
    Lc_Estoque := 'S';
    Lc_Despacho := 'N';
    Lc_Aliq_IPI := 0;
    Lc_Aliq_ICMS := 0;
    Lc_Cd_Estoque := Gb_Estoque;

    Lc_Altura := 0;
    Lc_Largura :=0;
    Lc_sentido := '';
    //Inclui os itens no Pedido
    Lc_Cd_Item := Fc_AtualizaItensNfl(dm.IB_Transacao,
                                      Lc_Operacao,
                                      Lc_Cd_Item,
                                      Lc_Cd_Pedido,
                                      Lc_Cd_Nota,
                                      Lc_Cd_Produto,
                                      Lc_Qtde,
                                      Lc_VL_Custo,
                                      Lc_VL_Unitario,
                                      Lc_AQ_Desconto,
                                      Lc_VL_Desconto,
                                      Lc_Aliq_COM,
                                      Lc_OPER,
                                      Lc_Estoque,
                                      Lc_Despacho,
                                      Lc_Aliq_IPI,
                                      Lc_Aliq_ICMS,
                                      Lc_Cd_Estoque,
                                      Lc_Cd_Tabela,
                                      Lc_sentido,
                                      0,0,0);
    Fc_SyncTableUpdate('tb_order_sale_item',Lc_Dados.ChildValues['updated_at'],IntToStr(tb_salesman_id));
    if Lc_Cd_Item > 0 then
    Begin

      //Efetua o lancamento no Estoque

      //Atualiza estoque na internet
      //***Não implementado

      //Verifica se controla a separação
      if (Fc_Tb_Geral('L','DSP_G_CTRL_SEPARACAO','S') = 'S') then
      Begin
        Pc_SeparacaoMercadoria(Lc_Cd_Pedido,
                             Lc_Cd_Item,
                             Lc_Cd_Produto,
                             Date,
                             Lc_Qtde);
      end;

    end
    else
    Begin
      if Lc_Memo.Count = 0 then
      Begin
        Lc_Memo.Append('Verifique o(s) produto(s):');
        Lc_Memo.Append('Código     |   Qtde    | Valor Unitário');
      End;
      Lc_Memo.Append(Lc_Dados.ChildValues['tb_product_id'] + ' | ' + FloattoStrF( Lc_Qtde, ffFixed, 10, 2) + ' | ' + FloattoStrF( Lc_VL_Unitario, ffFixed, 10, 2));
    End;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;

  if Lc_Memo.Count > 0 then
  Begin
    Pc_AtualizaObsPedido(Lc_Cd_Pedido,Lc_Memo);
  End;
  Lc_Qry_Item.Close;
  FReeAndNil(Lc_Qry_Item);
  FReeAndNil(Lc_Memo);
  Result := true;
end;


function Fc_Gst2013_Clt_Web_Vehicle(Fc_id:String):WideString;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT  * FROM tb_vehicle wHERE id = '''+ Fc_id + '''' ;

  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<cotacao xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</cotacao> ');
  It_Xml_Pk := '';
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'vehicle','C',It_xml.Text,It_Xml_Pk);
  It_XML.Clear;
end;

function Fc_Gst2013_Atu_Dkp_Vehicle(Fc_Id:String):Boolean;
Var
  Lc_Xml_Doc : TXMLDocument;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  Result := True;
  //Verifica se há conexao com a Internet
  Lc_Resultado := Fc_Gst2013_Clt_Web_Vehicle(Fc_Id);
  Lc_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := Lc_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  //Cria a consulta
  Lc_Dados:= Lc_NodePai;
  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  repeat
    //Pega os dados dentro do Componenente conforme a Tag
    //0 - id/1 - fleet/2 - tb_vehicle_type_id/3 - tb_vehicle_mark_id/4 - tb_vehicle_model_id/5 - year_model/6 - cylinder/7 - tb_color_id
    Fc_AtualizaVeiculo(0,
                       Gb_CodMha,//   Pc_CODEMP: integer;
                       Lc_Dados.ChildNodes[0].text,           //     Pc_PLACA:String;
                       Lc_Dados.ChildNodes[1].text,           //     Pc_FROTA: String;
                       StrToInt(Lc_Dados.ChildNodes[2].text), //     Pc_CODTPV: integer;
                       StrToInt(Lc_Dados.ChildNodes[3].text), //     Pc_CODMRC: integer;
                       StrToInt(Lc_Dados.ChildNodes[4].text), //     Pc_CODMOD: integer;
                       Lc_Dados.ChildNodes[5].text,           //     Pc_ANO:String;
                       StrToInt(Lc_Dados.ChildNodes[7].text),  //     Pc_CODCOR: integer;
                       StrToInt(Lc_Dados.ChildNodes[6].text),           //     Pc_CILINDRADA: integer;
                       '');                                   //    Pc_KM:String):Integer;
    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;


end;

function Fc_Gst2013_Clt_Web_VehicleSo(Fc_Cd_Budget:String):WideString;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT  tb_institution_id,tb_budget_id , mobile, tb_vehicle_id '+
               'from tb_vehicle_so '+
               'WHERE tb_institution_id = '''+ It_tb_Institution_id + '''' +
               ' and tb_budget_id      = '''+ Fc_Cd_Budget + '''';
  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<cotacao xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</cotacao> ');
  It_Xml_Pk := '';
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'vehicle','C',It_xml.Text,It_Xml_Pk);
  It_XML.Clear;
end;

function Fc_Gst2013_Atu_Dkp_VehicleSo(Fc_Cd_Cotacao,Fc_Cd_Budget,Fc_cd_Pedido:String):Boolean;
Var
  Lc_Xml_Doc : TXMLDocument;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  Result := True;
  //Verifica se há conexao com a Internet
  Lc_Resultado := Fc_Gst2013_Clt_Web_VehicleSo(Fc_Cd_Budget);
  Lc_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := Lc_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  //Cria a consulta
  Lc_Dados:= Lc_NodePai;
  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  repeat
    //Atualiza o Vehicle
    Fc_Gst2013_Atu_Dkp_Vehicle(Lc_Dados.ChildNodes[3].text);
    // tb_institution_id,tb_budget_id , mobile, tb_vehicle_id
    Fc_UpdateVehicleSo(IntToStr(Gb_CodMha),
                       Fc_Cd_Cotacao,
                       Lc_Dados.ChildNodes[2].text,
                       Lc_Dados.ChildNodes[3].text,
                       Fc_cd_Pedido);
    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;
end;

function Fc_Gst2013_Clt_Web_VehicleCheckList(Fc_Cd_Budget:String):WideString;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT  * '+
               'from tb_vehicle_checklist '+
               'WHERE tb_institution_id = '''+ It_tb_Institution_id + '''' +
               ' and TB_BUDGET_ID = '''+ Fc_Cd_Budget + '''';
  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<cotacao xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</cotacao> ');
  It_Xml_Pk := '';
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'vehicle','C',It_xml.Text,It_Xml_Pk);
  It_XML.Clear;
end;

function Fc_Gst2013_Atu_Dkp_VehicleCheckList(Fc_Cd_Cotacao,Fc_Cd_Budget:String):Boolean;
Var
  Lc_Xml_Doc : TXMLDocument;
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
Begin
  Result := True;
  //Verifica se há conexao com a Internet
  Lc_Resultado := Fc_Gst2013_Clt_Web_VehicleCheckList(Fc_Cd_Budget);
  Lc_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := Lc_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  //Cria a consulta
  Lc_Dados:= Lc_NodePai;
  // Posiciona o primeiro elemento encontrado
  Lc_Dados.ChildNodes.First;
  repeat
    Fc_UpdateVehicleCheckList(IntToStr(Gb_CodMha),
                              Fc_Cd_Cotacao,
                              Lc_Dados.ChildNodes[2].text,
                              Lc_Dados.ChildNodes[3].text,
                              Lc_Dados.ChildNodes[4].text,
                              Lc_Dados.ChildNodes[5].text,
                              Lc_Dados.ChildNodes[6].text,
                              Lc_Dados.ChildNodes[7].text,
                              Lc_Dados.ChildNodes[8].text,
                              Lc_Dados.ChildNodes[9].text,
                              Lc_Dados.ChildNodes[10].text,
                              Lc_Dados.ChildNodes[11].text,
                              Lc_Dados.ChildNodes[12].text,
                              Lc_Dados.ChildNodes[13].text,
                              Lc_Dados.ChildNodes[14].text,
                              Lc_Dados.ChildNodes[15].text,
                              Lc_Dados.ChildNodes[16].text,
                              Lc_Dados.ChildNodes[17].text,
                              Lc_Dados.ChildNodes[18].text,
                              Lc_Dados.ChildNodes[19].text,
                              Lc_Dados.ChildNodes[20].text,
                              Lc_Dados.ChildNodes[21].text,
                              Lc_Dados.ChildNodes[22].text,
                              Lc_Dados.ChildNodes[23].text,
                              Lc_Dados.ChildNodes[24].text,
                              Lc_Dados.ChildNodes[25].text,
                              Lc_Dados.ChildNodes[26].text,
                              Lc_Dados.ChildNodes[27].text,
                              Lc_Dados.ChildNodes[28].text,
                              Lc_Dados.ChildNodes[29].text,
                              '');
    Lc_Dados := Lc_Dados.NextSibling;
  until Lc_Dados = nil;
end;



//-------------------------Cadastro de Veiculos - Vehicle---------------------------------------------
procedure Pc_Gst2013_Atu_Web_Vehicle_Type(Pc_Operacao,Pc_codigo:String);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'vehicle_type';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>'   + Pc_codigo + '</id>'+
                   '</chaves>';

      It_SqlTxt := 'SELECT '+
                   ' TPV_CODIGO id, '+
                   ' TPV_DESCRICAO description '+
                   'FROM TB_TP_VEICULO '+
                   'WHERE TPV_CODIGO=:TPV_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'TPV_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;


procedure Pc_Gst2013_Atu_Web_Vehicle_Mark(Pc_Operacao,Pc_codigo:String);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'vehicle_mark';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>'   + Pc_codigo + '</id>'+
                   '</chaves>';
                   
      It_SqlTxt := 'SELECT '+
                   ' MRC_CODIGO id, '+
                   ' MRC_DESCRICAO description '+
                   'FROM TB_MARCA_VEICULO '+
                   'WHERE MRC_CODIGO=:MRC_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'MRC_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

procedure Pc_Gst2013_Atu_Web_Vehicle_Model(Pc_Operacao,Pc_codigo:String);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'vehicle_model';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>'   + Pc_codigo + '</id>'+
                   '</chaves>';
                   
      It_SqlTxt := 'SELECT '+
                   ' MOD_CODIGO id, '+
                   ' MOD_CODMRC tb_vehicle_mark_id, '+
                   ' MOD_DESCRICAO description '+
                   ' FROM TB_MODELO '+
                   'WHERE MOD_CODIGO=:MOD_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'MOD_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

procedure Pc_Gst2013_Atu_Web_Vehicle(Pc_Operacao,Pc_codigo:String);
Var
  Lc_Area : String;
Begin
  Lc_Area := 'vehicle';
  if Pc_Operacao = 'D' then
    Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_'+Lc_Area +' where id = '+ pc_codigo);
    end
  else
    Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>'   + Pc_codigo + '</id>'+
                   '</chaves>';
                   
      It_SqlTxt := 'SELECT '+
                   ' VEI_PLACA id, '+
                   ' VEI_FROTA fleet, '+
                   ' VEI_CODTPV  tb_vehicle_type_id, '+
                   ' VEI_CODMRC  tb_vehicle_mark_id, '+
                   ' VEI_CODMOD  tb_vehicle_model_id, '+
                   ' VEI_CODCOR tb_color_id, '+
                   ' VEI_ANO     year_model, '+
                   ' VEI_CILINDRADA cylinder '+
                   ' FROM TB_VEICULO '+
                   'WHERE VEI_PLACA=:VEI_PLACA ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'VEI_PLACA',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      It_Resultado := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+ Lc_Area + '_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
    end;
end;

  //-----------------------Atualiza cadastro da empresa no Desktop------------------------------

function Fc_Gst_Clt_Web_Entity(Fc_CNPJ_CPF:String):WideString;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT tb_entity.name_company, tb_entity.nick_trade, tb_person.cpf cpf_cnpj, tb_person.rg rg_ie, '+
               'tb_customer.credit_status, tb_customer.note, tb_mailing.email, tb_customer.dealer '+
               'from tb_entity '+
               '  inner join tb_person on (tb_person.id = tb_entity.id) '+
               '  left outer join tb_customer on (tb_entity.id = tb_customer.id) '+
               '  left outer join tb_mailing on (tb_entity.id = tb_mailing.id) '+
               'WHERE (tb_person.cpf = ''' + Fc_CNPJ_CPF + ''')'+
               'UNION '+
               'SELECT tb_entity.name_company, tb_entity.nick_trade, tb_company.cnpj cpf_cnpj, tb_company.ie rg_ie, '+
               'tb_customer.credit_status, tb_customer.note, tb_mailing.email, tb_customer.dealer '+
               'from tb_entity '+
               '  inner join tb_company on (tb_company.id = tb_entity.id) '+
               '  left outer join tb_customer on (tb_entity.id = tb_customer.id) '+
               '  left outer join tb_mailing on (tb_entity.id = tb_mailing.id) '+
               'WHERE (tb_company.cnpj = ''' + Fc_CNPJ_CPF + ''')';

  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<entidade xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</entidade> ');
  It_ws := Fc_Ws_Gst2013();
  Try
    Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'entity','C',It_XML.Text,It_XML.Text);
  except
    Result := '';
  end;

end;

function  Fc_Gst_Atu_Dkp_Entity(Fc_CNPJ_CPF:String):Integer;
Var
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Empresa : TControllerEmpresa;
Begin
  Lc_Resultado := Fc_Gst_Clt_Web_Entity(Fc_CNPJ_CPF);
  It_Xml_Doc := createXMLDOC(Lc_Resultado);
  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.

  if (Lc_NodePai.ChildNodes.Count = 0) then exit;
  //Cria a consulta
  Empresa := TControllerEmpresa.Create(Application);
  with Empresa.Registro do
  Begin
    Lc_Dados:= Lc_NodePai;
    // Posiciona o primeiro elemento encontrado
    Lc_Dados.ChildNodes.First;
    //Pega os dados dentro do Componenente conforme a Tag
    if (Lc_Dados.ChildValues['cpf_cnpj'] <> NULL) then
      CpfCNPJ := Lc_Dados.ChildValues['cpf_cnpj'];
    Empresa.getByDocumento;
    codigo := Empresa.Registro.Codigo;
    Tipo := 1;
    IF Lc_Dados.ChildValues['name_company'] <> NULL then
      NomeRazaoSocial := Upper(Lc_Dados.ChildValues['name_company'])
    else
      NomeRazaoSocial := 'NOME DO CLIENTE VEIO EM BRANCO';

    IF Lc_Dados.ChildValues['nick_trade'] <> NULL then
      ApelidoFantasia := Upper(Lc_Dados.ChildValues['nick_trade'])
    else
      ApelidoFantasia := 'NOME DO CLIENTE VEIO EM BRANCO';

    IF Lc_Dados.ChildValues['cpf_cnpj']  <> NULL then
    Begin
      CpfCNPJ := Lc_Dados.ChildValues['cpf_cnpj'];
      IF Length(Lc_Dados.ChildValues['cpf_cnpj']) = 11 then
        TipoPessoa :=  'F'
      else
        TipoPessoa := 'J';
    end
    else
    Begin
      CpfCNPJ := '00000000000';
      TipoPessoa :=  'F';
    end;

    IF Lc_Dados.ChildValues['rg_ie'] <> NULL then
      InscricaoEstadual := Lc_Dados.ChildValues['rg_ie']
    else
      InscricaoEstadual := '';

    if Lc_Dados.ChildValues['credit_status'] <> Null then
      SituacaoCredito := Lc_Dados.ChildValues['credit_status']
    else
      SituacaoCredito := 'N';

    IF (Lc_Dados.ChildValues['note'] <> Null) then
      Observacao := Lc_Dados.ChildValues['note']
    else
      Observacao := '';

    IF (Lc_Dados.ChildValues['email']<> Null) then
      Email := Lc_Dados.ChildValues['email']
    else
      Email := '';

    ConsumidorFinal := 'N';
    OptantePeloSimples := 'N';
    Multiplicador := 1;
    Ativa :=  'S';
    Status := 'L';

    IF (Lc_Dados.ChildValues['dealer']<> Null) then
      Lojista := Lc_Dados.ChildValues['dealer']
    else
      Lojista := 'A';
  end;
  Empresa.salva;
  Result := Empresa.Registro.Codigo;
  FreeAndNil(Empresa);
end;

function  Fc_Gst_Clt_ZipCode(Pc_cd_Cidade:string):String;
Var
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
BEgin
  It_SqlTxt := 'SELECT CDD_CEP '+
                 'FROM tb_cidade '+
                 'WHERE CDD_CODIGO = '+Pc_cd_Cidade;

  //Executa a consulta Cusotmizada
  Fc_Ws_Gst2013_Cmd_Customizado('CEP',It_SqlTxt);

  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  if (Lc_NodePai.ChildNodes.Count > 0) then
    Begin
    Lc_Dados := Lc_NodePai;
    Result := Lc_Dados.ChildNodes[0].text;
    end
  else
    Begin
    Result := '0';
    end;

end;

function  Fc_Gst_Clt_Web_Address(Fc_Tipo,Fc_CNPJ_CPF:String):WideString;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT tb_address.*, tb_person.cpf doc '+
               'FROM tb_address '+
               '  INNER JOIN tb_person '+
               '  ON (tb_person.id = tb_address.id) '+
               'WHERE (tb_person.cpf = ''' + Fc_CNPJ_CPF + ''') '+
               'UNION '+
               'SELECT tb_address.*, tb_company.cnpj doc '+
               'FROM tb_address '+
               '  INNER JOIN tb_company '+
               '  ON (tb_company.id = tb_address.id) '+
               'WHERE (tb_company.cnpj = ''' + Fc_CNPJ_CPF + ''') ';
  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<endereco xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</endereco> ');
  It_ws := Fc_Ws_Gst2013();
  Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'address','C',It_XML.Text,It_XML.Text);
  It_XML.Clear;

end;

function Fc_VerificaEnderecoEmpresa(fc_Tipo,Fc_CNPJCPF: string):Integer;
var
  Lc_SqlTxt: string;
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    Active := False;
    SQL.Clear;
    Lc_SqlTxt:=' select END_CODIGO '+
               'from tb_endereco    '+
               '  INNER JOIN TB_EMPRESA '+
               '  ON (EMP_CODIGO = END_CODEMP) '+
               'WHERE (END_TIPO = :END_TIPO) and (EMP_CNPJ =:EMP_CNPJ) ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('EMP_CNPJ').AsString:= Fc_CNPJCPF;
    ParamByName('END_TIPO').AsString:= fc_Tipo;
    Active:=TRUE;
    FetchAll;
    if (RecordCount > 0) then
      Result:= FieldByName('END_CODIGO').AsInteger
    else
      Result:= 0;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function  Fc_Gst_Atu_Dkp_Address(Fc_Tipo,Fc_CNPJ_CPF:String):Integer;
Var
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_cd_empresa : Integer;
  Lc_CNPJ : String;
  Endereco : TControllerEndereco;
  Empresa : TControllerEmpresa;
Begin
  Result := 0;
  Lc_Resultado := Fc_Gst_Clt_Web_Address(Fc_Tipo,Fc_CNPJ_CPF);
  It_Xml_Doc := createXMLDOC(Lc_Resultado);

  Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.
  Empresa := TControllerEmpresa.Create(Application);
  Empresa.Registro.CpfCNPJ := Fc_CNPJ_CPF;
  Empresa.getByDocumento;
  Lc_cd_Empresa := Empresa.Registro.Codigo;
  FreeAndNil(Empresa);
  if (Lc_NodePai.ChildNodes.Count > 0) then
  Begin
    Lc_Dados:= Lc_NodePai;
    // Posiciona o primeiro elemento encontrado
    Lc_Dados.ChildNodes.First;
    Endereco := TControllerEndereco.Create(Application);
    Pc_AtivaEstabelecimento;
    repeat
      with Endereco.Registro do
      Begin
        Codigo := 0;
        if (Lc_Dados.ChildValues['main'] <> null) then
        Begin
          if (Lc_Dados.ChildValues['main'] = 'S') or (Lc_Dados.ChildValues['main'] = 'Y') then
          EnderecoPrincipal := 'S'
        End
        else
          CNPJ := Lc_Dados.ChildValues['main'];

        EnderecoPrincipal := 'S';
        CodigoEmpresa := Lc_cd_Empresa;
        //Documento
        CNPJ := '';
        if (Lc_Dados.ChildValues['doc'] <> null) then
          Cnpj := Lc_Dados.ChildValues['doc'];
        //Tipo de Endereco
        Tipo := 'COMERCIAL';
        if (Lc_Dados.ChildValues['kind'] <> null) then
          Tipo := Upper(Lc_Dados.ChildValues['kind']);

        //Logradouro
        Logradouro := 'NÃO INFORMADO';
        if (Lc_Dados.ChildValues['street'] <> null) then
          Logradouro := Upper(Lc_Dados.ChildValues['street']);

        //Complemento
        Complemento := '';
        if (Lc_Dados.ChildValues['complement'] <> null) then
          Complemento := Copy(Upper(Lc_Dados.ChildValues['complement']),1,25);

        //Numero do Predio
        NumeroPredial := 'S/N';
        if (Lc_Dados.ChildValues['nmbr'] <> null) then
          NumeroPredial := Lc_Dados.ChildValues['nmbr'];

        //Bairro
        Bairro := '';
        if (Lc_Dados.ChildValues['neighborhood'] <> null) then
          BAirro := Upper(Lc_Dados.ChildValues['neighborhood']);

        //CEP
        cep := '80000000';
        if (Lc_Dados.ChildValues['zip_code'] <> null) then
          cep := Lc_Dados.ChildValues['zip_code'];

        //Pais
        CodigoPais := 1058;
        //Estado
        CodigoEstado := DM.Qr_Estabelecimento.FieldByName('END_CODUFE').AsInteger;
        if (Lc_Dados.ChildValues['tb_state_id'] <> null) then
          if StrToIntDef(Lc_Dados.ChildValues['tb_state_id'],0) > 0 then
            CodigoEstado := Lc_Dados.ChildValues['tb_state_id'];

        //Cidade
        CodigoCidade := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;
        if (Lc_Dados.ChildValues['tb_city_id'] <> null) then
          if (StrToIntDef(Lc_Dados.ChildValues['tb_city_id'],0) > 0) then
            CodigoCidade := Lc_Dados.ChildValues['tb_city_id'] ;

        //Contato no endereco
        Contato := '';
        if (Lc_Dados.ChildValues['END_CONTATO'] <> null) then
          Contato := Upper(Lc_Dados.ChildValues['END_CONTATO']);

        //Regiao
        Regiao := '';
        if (Lc_Dados.ChildValues['region'] <> null) then
          Regiao := Upper(Lc_Dados.ChildValues['region']);

        //Telefones
        Fone := Fc_Gst_Clt_Web_Phone(Lc_Dados.ChildValues['id'],'PRINCIPAL');
        Fax := Fc_Gst_Clt_Web_Phone(Lc_Dados.ChildValues['id'],'FAX/OUTRO');
        Celular := Fc_Gst_Clt_Web_Phone(Lc_Dados.ChildValues['id'],'CELULAR');
        FoneComercial := Fc_Gst_Clt_Web_Phone(Lc_Dados.ChildValues['id'],'COMERCIAL');
        FonePortaria := Fc_Gst_Clt_Web_Phone(Lc_Dados.ChildValues['id'],'PORTARIA');
      End;
      endereco.salva;
      Lc_Dados := Lc_Dados.NextSibling;
    until Lc_Dados = nil;
  End
  else
  Begin
    with Endereco.Registro do
    Begin
      Codigo := 0;
      EnderecoPrincipal := 'S';
      CodigoEmpresa := Lc_cd_Empresa;
      Tipo := 'COMERCIAL';
      Logradouro := 'Não identificado';
      NumeroPredial := 'NI';
      Bairro := 'Bairro';
      Cep := DM.Qr_Estabelecimento.FieldByName('END_CEP').AsString;
      CodigoPais := 1058;
      CodigoEstado := DM.Qr_Estabelecimento.FieldByName('END_CODUFE').AsInteger;
      CodigoCidade := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;
    End;
    endereco.salva;
  End;

  Result := endereco.Registro.Codigo;
  FreeAndNil(Endereco);
end;

function Fc_Gst_Clt_Web_Phone(Fc_cd_phone,Fc_tipo:String):String;
Var
  Lc_SqlTxt : String;
  Lc_Fone :WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_Xml_Doc : TXMLDocument;

Begin
  Lc_SqlTxt := 'SELECT number '+
               'FROM tb_phone '+
               'WHERE (id = ''' + Fc_cd_phone + ''') AND (kind = ''' + Fc_tipo + ''') ';

  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<fone xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</fone> ');
  It_ws := Fc_Ws_Gst2013();
  Lc_Fone := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'phone','C',It_XML.Text,It_XML.Text);

  Lc_Xml_Doc := createXMLDOC(Lc_Fone);
  Lc_NodePai := Lc_Xml_Doc.DocumentElement.childNodes.First;
  //Se o nº for Zero não tem dados então sai.

  if (Lc_NodePai.ChildNodes.Count = 0) then
    Begin
    Result := '';
    exit;
    end
  else
    Begin
    Lc_Dados := Lc_NodePai;
    // Posiciona o primeiro elemento encontrado
    Lc_Dados.ChildNodes.First;
    if (Lc_Dados.ChildValues['number'] <> null) then
      Begin
      Result := Lc_Dados.ChildValues['number'];
      Result := Fc_RemoveCaracterInformado(Result, ['.',',','/','-',' ']);
      end
    else
      Result := '';
    end;
  FreeAndNil(Lc_Xml_Doc);
end;



//-----------------------funcao------------------------------------
function Fc_DataMysql(fc_Data:String):String;
Var
  Lc_Dia,Lc_Mes,Lc_Ano:String;
Begin
  //2013-08-13
  Lc_Dia := Copy(fc_Data,9,2);
  Lc_Mes := Copy(fc_Data,6,2);
  Lc_Ano := Copy(fc_Data,1,4);
  Result := Lc_dia + '/' + Lc_Mes + '/' + Lc_Ano;
end;

function Fc_Gst_Clt_LinkVideoTreinamento(Fc_Cd_Interface,Fc_Numero:String):String;
Var
  Lc_SqlTxt : String;
Begin
  Lc_SqlTxt := 'SELECT vdt_link '+
               'FROM tb_video_treinamento '+
               'WHERE (vdt_codif = '''+ Fc_Cd_Interface + ''') and (vdt_numero = ''' + Fc_Numero + ''')';

  //Envia a consulta para o WebService
  if (It_XML = nil) then It_XML.Create;
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes" ?> ');
  It_XML.Add('<entidade xmlns="' + gb_site + '"> ');
  It_XML.Add('<QUERY>'+Lc_SqlTxt +'</QUERY> ');
  It_XML.Add('</entidade> ');
  It_ws := Fc_Ws_Gst2013();
  Try
    Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,'entity','C',It_XML.Text,It_XML.Text);
  except
    Result := '';
  end;
end;

//-------------------------Cadastro da Tabela de Frete ---------------------------------------------
procedure Pc_Gst_del_Web_Frete;
Var
  Lc_Sql : String;
Begin
  Lc_Sql := 'delete from tb_freight where 	(tb_institution_id = ' + It_tb_Institution_id + ')';
  Fc_Ws_Gst2013_Cmd_Customizado('freight',Lc_Sql);
  Lc_Sql := 'delete from tb_freight_destiny where 	(tb_institution_id = ' + It_tb_Institution_id + ')';
  Fc_Ws_Gst2013_Cmd_Customizado('freight',Lc_Sql);
  Lc_Sql := 'delete from tb_freight_weight where 	(tb_institution_id = ' + It_tb_Institution_id + ')';
  Fc_Ws_Gst2013_Cmd_Customizado('freight',Lc_Sql);
  Lc_Sql := 'delete from tb_freight_weight_destiny where 	(tb_institution_id = ' + It_tb_Institution_id + ')';
  Fc_Ws_Gst2013_Cmd_Customizado('freight',Lc_Sql);
End;


procedure Pc_Gst_Atu_Web_Frete(Pc_Operacao,pc_codigo: string);
Var
  Lc_Area : String;
  Lc_ID : Integer;
  Lc_Result : String;
Begin
  Lc_Area := 'freight';
  if Pc_Operacao = 'D' then
  Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ pc_codigo);
  end
  else
  Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                 '<id>' + pc_codigo + '</id>'+
                 '</chaves>';

    It_SqlTxt := 'select '+
                 ' FRT_CODIGO id '+
                 ' ,' + It_tb_Institution_id + 'tb_Institution_id' +
                 ' ,FRT_CODEMP tb_entity_id '+
                 ' ,FRT_DESCRICAO description '+
                 ' ,FRT_VL_DESPACHO dispatch_value '+
                 ' ,FRT_VL_TAS tas_value '+
                 ' ,FRT_GRIS_MIN gris_min '+
                 ' ,FRT_TAXA_GRIS taxa_gris '+
                 ' ,FRT_VL_PEDAGIO toll_value '+
                 'from "TB_FRETE"  tb_freight '+
                 'WHERE FRT_CODIGO =:FRT_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'FRT_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Lc_Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

procedure Pc_Gst_Atu_Web_Frete_Destino(Pc_Operacao,pc_codigo,Pc_cd_Frete: string);
Var
  Lc_Area : String;
  Lc_ID : Integer;
  Lc_Result : String;
Begin
  Lc_Area := 'freight_destiny';
  if Pc_Operacao = 'D' then
  Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ pc_codigo);
  end
  else
  Begin
    try
    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<id>' + pc_codigo + '</id>'+
                 '<tb_freight_id>' + Pc_cd_Frete + '</tb_freight_id>'+
                 '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                 '</chaves>';

    It_SqlTxt := 'select '+
                 '  FDT_CODIGO id '+
                 ' ,FDT_CODFRT tb_freight_id '+
                 ' ,' + It_tb_Institution_id + 'tb_Institution_id' +
                 ' ,FDT_CODCDD tb_city_id '+
                 ' ,FDT_ADV adv '+
                 ' ,FDT_LOCAL local '+
                 ' from TB_FRETE_DESTINO tb_freight_destiny '+
                 'WHERE FDT_CODIGO =:FDT_CODIGO ';

      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'FDT_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Lc_Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

procedure Pc_Gst_Atu_Web_Frete_Peso(Pc_Operacao,pc_codigo,Pc_cd_Frete: string);
Var
  Lc_Area : String;
  Lc_ID : Integer;
  Lc_Result : String;
Begin
  Lc_Area := 'freight_weight';
  if Pc_Operacao = 'D' then
  Begin
    Fc_Ws_Gst2013_Cmd_Customizado(Lc_Area,'DELETE FROM tb_' + Lc_Area + ' where id = '+ pc_codigo);
  end
  else
  Begin
    try
      It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                   '<chaves xmlns="' + Gb_Site + '/">'+
                   '<id>' + pc_codigo + '</id>'+
                   '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                   '<tb_freight_id>' + Pc_cd_Frete + '</tb_freight_id>'+
                   '</chaves>';

      It_SqlTxt := 'select '+
                   ' FPS_CODIGO id '+
                   ' ,FPS_CODFRT tb_freight_id '+
                   ' ,' + It_tb_Institution_id + 'tb_Institution_id' +
                   ' ,FPS_POSICAO position_weight '+
                   ' ,FPS_LARGURA width_weight '+
                   ' ,FPS_VALOR value_weight '+
                   'from TB_FRETE_PESO tb_freight_weight '+
                   'WHERE (FPS_CODFRT = '+ Pc_cd_Frete + ') '+
                   ' AND (FPS_CODIGO =:FPS_CODIGO) ';


      //Função que pega os dados e gera o XMl
      if not Fc_Ws_Gst2013_Gera_XML(It_SqlTxt,Lc_Area,'FPS_CODIGO',pc_codigo) then exit;
      if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  pc_codigo + '.xml');
      It_ws := Fc_Ws_Gst2013();
      Lc_Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
    except
      It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ pc_codigo + '.xml');
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                     'Verifique antes de continuar.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

procedure Pc_Gst_Atu_Web_Frete_Destino_Peso(Pc_Operacao,Pc_Cd_frete,Pc_Cd_Destino,Pc_Cd_Peso:string;Pc_Valor:Real);
Var
  Lc_Area : String;
  Lc_ID : Integer;
  Lc_Result : String;
Begin
  try
    Lc_Area := 'freight_weight_destiny';

    It_Xml_Pk := '<?xml version="1.0" encoding="'+ it_enconding + '" standalone="yes"?>'+
                 '<chaves xmlns="' + Gb_Site + '/">'+
                 '<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>'+
                 '<tb_freight_id>'+ Pc_Cd_frete + '</tb_freight_id> '+
                 '<tb_destiny_freight_id>'+ Pc_Cd_Destino +'</tb_destiny_freight_id>'+
                 '<tb_weight_freight_id>'+ Pc_Cd_Peso +'</tb_weight_freight_id>'+
                 '</chaves>';

    //Envia a consulta para o WebService
    if (It_XML = nil) then It_XML.Create;
    It_XML.Clear;
    It_XML.Add('<?xml version="1.0" encoding="ISO-8859-1" standalone="yes" ?> ');
    It_XML.Add('<tb_freight_weight_destiny xmlns="' + Gb_Site + '/"> ');
    It_XML.Add('<tb_institution_id>' + It_tb_Institution_id + '</tb_institution_id>');
    It_XML.Add('<tb_freight_id>'+ Pc_Cd_frete + '</tb_freight_id> ');
    It_XML.Add('<tb_destiny_freight_id>'+ Pc_Cd_Destino +'</tb_destiny_freight_id> ');
    It_XML.Add('<tb_weight_freight_id>'+ Pc_Cd_Peso +'</tb_weight_freight_id> ');
    It_XML.Add('<fwd_value>' + BuscaTroca(floatToStr(Pc_Valor),',','.')+ '</fwd_value> ');
    It_XML.Add('</tb_freight_weight_destiny> ');

    //Função que pega os dados e gera o XMl
    if It_SalvaXMl then It_XML.SaveToFile(GbPathExe +'xml_' + Lc_Area  +'_'+  Pc_Cd_frete + '.xml');
    It_ws := Fc_Ws_Gst2013();
    Lc_Result := It_ws.servico(Fc_Ws_Gst2013_Gera_Token,Lc_Area,Pc_Operacao,It_xml.Text,It_Xml_Pk);
  except
    It_XML.SaveToFile(GbPathExe +'xml_'+Lc_Area +'_'+ Pc_Cd_frete + '.xml');
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não foi possível cadastrar a '+ Lc_Area +' no Site.' + EOLN +
                   'Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
  end;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(TWebServiceGestao2013), 'urn:SETES2013.webservice', it_enconding , '', 'SETES2013.webservicePortType');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(TWebServiceGestao2013), '|urn:SETES2013.webservice#servico|urn:SETES.webservice#cep');

end.
