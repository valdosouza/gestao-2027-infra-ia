// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\CalcPrecoPrazo.asmx.xml
// Encoding : utf-8
// Version  : 1.0
// (01/12/2012 10:42:46 - 1.33.2.5)
// ************************************************************************ //

unit ws_correios;

interface

uses     InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, SysUtils;

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
  CalcPrecoPrazoWSSoap = interface(IInvokable)
  ['{4C9F7BEE-B55A-93AA-20B6-26C24AB41701}']
    function  CalcPrecoPrazo(const nCdEmpresa: WideString; const sDsSenha: WideString; const nCdServico: WideString; const sCepOrigem: WideString; const sCepDestino: WideString; const nVlPeso: WideString; const nCdFormato: Integer; const nVlComprimento: TXSDecimal; const nVlAltura: TXSDecimal; const nVlLargura: TXSDecimal; 
                             const nVlDiametro: TXSDecimal; const sCdMaoPropria: WideString; const nVlValorDeclarado: TXSDecimal; const sCdAvisoRecebimento: WideString): cResultado; stdcall;
    function  CalcPreco(const nCdEmpresa: WideString; const sDsSenha: WideString; const nCdServico: WideString; const sCepOrigem: WideString; const sCepDestino: WideString; const nVlPeso: WideString; const nCdFormato: Integer; const nVlComprimento: TXSDecimal; const nVlAltura: TXSDecimal; const nVlLargura: TXSDecimal; 
                        const nVlDiametro: TXSDecimal; const sCdMaoPropria: WideString; const nVlValorDeclarado: TXSDecimal; const sCdAvisoRecebimento: WideString): cResultado; stdcall;
    function  CalcPrazo(const nCdServico: WideString; const sCepOrigem: WideString; const sCepDestino: WideString): cResultado; stdcall;
  end;

function GetCalcPrecoPrazoWSSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CalcPrecoPrazoWSSoap;


implementation

function GetCalcPrecoPrazoWSSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CalcPrecoPrazoWSSoap;
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
    Result := (RIO as CalcPrecoPrazoWSSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(CalcPrecoPrazoWSSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CalcPrecoPrazoWSSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CalcPrecoPrazoWSSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(cServico, 'http://tempuri.org/', 'cServico');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfCServico), 'http://tempuri.org/', 'ArrayOfCServico');
  RemClassRegistry.RegisterXSClass(cResultado, 'http://tempuri.org/', 'cResultado');

end.