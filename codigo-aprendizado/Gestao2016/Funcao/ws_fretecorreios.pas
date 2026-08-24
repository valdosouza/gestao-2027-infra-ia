// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\CalcPrecoPrazo.asmx.xml
// Encoding : utf-8
// Version  : 1.0
// (01/12/2012 10:42:46 - 1.33.2.5)
// ************************************************************************ //

unit ws_fretecorreios;

interface

uses     windows, forms, Graphics, InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, Dialogs, SysUtils, STQuery, Un_DM, Classes, XMLDoc, XMLIntf, Wininet, shellapi, StrUtils, Un_sistema, Variants;
type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"

  cServico             = class;                 { "http://tempuri.org/" }
  cResultado           = class;                 { "http://tempuri.org/" }



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  cServico = class(TRemotable)
  private
    FCodigo: Integer;
    FValor: WideString;
    FPrazoEntrega: WideString;
    FValorMaoPropria: WideString;
    FValorAvisoRecebimento: WideString;
    FValorValorDeclarado: WideString;
    FEntregaDomiciliar: WideString;
    FEntregaSabado: WideString;
    FErro: WideString;
    FMsgErro: WideString;
  published
    property Codigo: Integer read FCodigo write FCodigo;
    property Valor: WideString read FValor write FValor;
    property PrazoEntrega: WideString read FPrazoEntrega write FPrazoEntrega;
    property ValorMaoPropria: WideString read FValorMaoPropria write FValorMaoPropria;
    property ValorAvisoRecebimento: WideString read FValorAvisoRecebimento write FValorAvisoRecebimento;
    property ValorValorDeclarado: WideString read FValorValorDeclarado write FValorValorDeclarado;
    property EntregaDomiciliar: WideString read FEntregaDomiciliar write FEntregaDomiciliar;
    property EntregaSabado: WideString read FEntregaSabado write FEntregaSabado;
    property Erro: WideString read FErro write FErro;
    property MsgErro: WideString read FMsgErro write FMsgErro;
  end;

  ArrayOfCServico = array of cServico;          { "http://tempuri.org/" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  cResultado = class(TRemotable)
  private
    FServicos: ArrayOfCServico;
  public
    destructor Destroy; override;
  published
    property Servicos: ArrayOfCServico read FServicos write FServicos;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CalcPrecoPrazoWSSoap
  // service   : CalcPrecoPrazoWS
  // port      : CalcPrecoPrazoWSSoap
  // URL       : http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx
  // ************************************************************************ //
  TWebServiceFreteCorreio = interface(IInvokable)
  ['{4C9F7BEE-B55A-93AA-20B6-26C24AB41701}']
    function  CalcPrecoPrazo(const nCdEmpresa: WideString; const sDsSenha: WideString; const nCdServico: WideString; const sCepOrigem: WideString; const sCepDestino: WideString; const nVlPeso: WideString; const nCdFormato: Integer; const nVlComprimento: TXSDecimal; const nVlAltura: TXSDecimal; const nVlLargura: TXSDecimal;
                             const nVlDiametro: TXSDecimal; const sCdMaoPropria: WideString; const nVlValorDeclarado: TXSDecimal; const sCdAvisoRecebimento: WideString): cResultado; stdcall;
    function  CalcPreco(const nCdEmpresa: WideString; const sDsSenha: WideString; const nCdServico: WideString; const sCepOrigem: WideString; const sCepDestino: WideString; const nVlPeso: WideString; const nCdFormato: Integer; const nVlComprimento: TXSDecimal; const nVlAltura: TXSDecimal; const nVlLargura: TXSDecimal;
                        const nVlDiametro: TXSDecimal; const sCdMaoPropria: WideString; const nVlValorDeclarado: TXSDecimal; const sCdAvisoRecebimento: WideString): cResultado; stdcall;
    function  CalcPrazo(const nCdServico: WideString; const sCepOrigem: WideString; const sCepDestino: WideString): cResultado; stdcall;

    function fnValor(Valor: String): TXSDecimal;

  end;

function Fc_WS_FreteCorreio(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): TWebServiceFreteCorreio;
    //-------------------------Cadastro de Empresas--------------------------------------------
    function Fc_Gst_Clt_Frete():cResultado;

Var
  It_Qr_Consulta : TSTQuery;
  It_Qr_Update : TSTQuery;
  It_ws: TWebServiceFreteCorreio;
  It_Inet : dword;
  It_XML : TStringList;
  It_Xml_Doc : TXMLDocument;
  It_SqlTxt : String;
  It_Resultado : String;
  It_SalvaXMl : Boolean;

implementation

function Fc_WS_FreteCorreio(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): TWebServiceFreteCorreio;
const
  defWSDL = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx';
  defURL  = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx';
  defSvc  = 'CalcPrecoPrazoWS';
  defPrt  = 'CalcPrecoPrazoWSSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;

  try
    if Fc_VerificaProxy then
      Begin
      RIO.HTTPWebNode.Proxy    := Gb_Pxy_Path + ':' + IntToStr(Gb_Pxy_Porta) ;
      RIO.HTTPWebNode.UserName := Gb_Pxy_User;
      RIO.HTTPWebNode.Password := Gb_pxy_Pws;
      RIO.Port := IntToStr(Gb_Pxy_Porta);
      end;

    Result := (RIO as TWebServiceFreteCorreio);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      FreeAndNil(RIO);
  end;
end;

function fnValor(Valor: String): TXSDecimal;
begin
   Result.DecimalString := Valor;
end;

//-------------------------Cadastro de Empresas--------------------------------------------
function Fc_Gst_Clt_Frete():cResultado;
Var
  Lc_SqlTxt : String;
Begin
  {
  //Envia a consulta para o WebService
  It_XML.Clear;
  It_XML.Add('<?xml version="1.0" encoding="utf-8"?> '+
             '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
             'xmlns:xsd="http://www.w3.org/2001/XMLSchema" '+
             'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> '+
             '  <soap:Body> '+
             '    <CalcPrecoPrazo xmlns="http://tempuri.org/"> '+
             '      <nCdEmpresa>long</nCdEmpresa> '+
             '      <sDsSenha>string</sDsSenha> '+
             '      <nCdServico>string</nCdServico> '+
             '      <nCdServico>string</nCdServico> '+
             '      <nCdServico>string</nCdServico> '+
             '      <sCepOrigem>string</sCepOrigem> '+
             '      <sCepDestino>string</sCepDestino> '+
             '      <nVlPeso>string</nVlPeso> '+
             '      <nCdFormato>int</nCdFormato> '+
             '      <nVlComprimento>long</nVlComprimento> '+
             '      <nVlAltura>long</nVlAltura> '+
             '      <nVlLargura>long</nVlLargura> '+
             '      <nVlDiametro>long</nVlDiametro> '+
             '      <sCdMaoPropria>string</sCdMaoPropria> '+
             '      <nVlValorDeclarado>long</sCdValorDeclarado> '+
             '      <sCdAvisoRecebimento>string</sCdAvisoRecebimento> '+
             '    </CalcPrecoPrazo> '+
             '  </soap:Body> '+
             '</soap:Envelope> ');
   }
  Try
    It_ws := Fc_WS_FreteCorreio();
    Result := It_ws.CalcPrecoPrazo('0',           // nCdEmpresa: WideString;
                                   '',            // sDsSenha: WideString;
                                   '41106',       // nCdServico: WideString;
                                   '81330110',    //const sCepOrigem: WideString;
                                   '81770090',    //const sCepDestino: WideString;
                                   '300',         //const nVlPeso: WideString;
                                   1,             //const nCdFormato: Integer;
                                   fnValor('20'), //const nVlComprimento: TXSDecimal;
                                   fnValor('20'),       //const nVlAltura: TXSDecimal;
                                   fnValor('20'),  //const nVlLargura: TXSDecimal;
                                   fnValor('20'), //const nVlDiametro: TXSDecimal;
                                   'S',           //const sCdMaoPropria: WideString;
                                   fnValor('20'), //const nVlValorDeclarado: TXSDecimal;
                                   'S' );         //const sCdAvisoRecebimento: WideString);

  except

  end;
  ShowMessage('Deu Certo');
  Application.ProcessMessages;

end;

destructor cResultado.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FServicos)-1 do
    if Assigned(FServicos[I]) then
      FreeAndNil(FServicos[I]);
  SetLength(FServicos, 0);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(TWebServiceFreteCorreio), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(TWebServiceFreteCorreio), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(TWebServiceFreteCorreio), ioDocument);
  RemClassRegistry.RegisterXSClass(cServico, 'http://tempuri.org/', 'cServico');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfCServico), 'http://tempuri.org/', 'ArrayOfCServico');
  RemClassRegistry.RegisterXSClass(cResultado, 'http://tempuri.org/', 'cResultado');

end.