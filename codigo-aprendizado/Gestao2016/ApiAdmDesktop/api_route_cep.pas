unit api_route_cep;

interface

uses
      windows, forms, Graphics, InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, Dialogs, STQuery, Un_DM, Classes, XMLDoc, XMLIntf, Wininet, shellapi, EncdDecd, synacode, acbrcep, System.SysUtils, //Para comunicação com o cep usando TRest
  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, REST.Json;

  type TCependereco = Record
      Fcep : String;
      FCd_UF : Integer;
      FUF : String;
      FCd_Cidade : Integer;
      FCidade : String;
      FLogradouro : String;
      FBairro : String;
  end;

  //Opção de cep 2 - sem o acbr
  TViaCEP = class
  public
    cep: string;
    logradouro: string;
    complemento: string;
    bairro: string;
    localidade: string;
    uf: string;
    ibge: string;
    gia: string;
    ddd: string;
    siafi: string;

    class function BuscarEnderecoPorCEP(const ACep: string): TViaCEP;
    class function Fc_BuscaPorCep(const ACep: string): TCependereco;
  end;

  function Fc_BuscaPorCep(Fc_Cep:String):TCependereco;

implementation

uses     un_msg, RN_Estados, Un_Regra_Negocio, env;

function Fc_BuscaPorCep(Fc_Cep:String):TCependereco;
Var
  cep : TAcbrCep;
Begin
  cep := TAcbrCep.Create(Application);
  with cep DO
  Begin
    WebService := wsViaCep;
    TRY
      BuscarPorCEP( Fc_CEP);
    Except
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Verifique a conexão com internet.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      exit;
    END;
    if Enderecos.Count > 0 then
    Begin
      with Enderecos[0] do
      Begin
        Result.FCep := Fc_Cep;
        Result.FCd_UF  := Fc_BuscaCodigoEstado(UF);
        Result.FUF  := UF;
        Result.FCd_Cidade := Fc_BuscaCodigoCidade(0,Municipio,UF);
        Result.FCidade := Municipio;
        if (Trim(Tipo_Logradouro) <> '') then
          Result.FLogradouro := Trim(Tipo_Logradouro) + ' ' + Logradouro
        else
          Result.FLogradouro := Logradouro;
        Result.FBairro := Bairro;
      End;
    End
    else
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Cep Não Encontrado.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpInformacao);
    End;
  end;
  FreeAndNil(Cep);
end;

class function TViaCEP.Fc_BuscaPorCep(const ACep: string): TCependereco;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JsonText: string;
  endereco: TViaCEP;
begin
  RESTClient   := TRESTClient.Create(nil);
  RESTRequest  := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTClient.BaseURL := 'https://viacep.com.br/ws';

    RESTRequest.Client   := RESTClient;
    RESTRequest.Response := RESTResponse;

    RESTRequest.Resource := '{cep}/json';
    RESTRequest.Method   := rmGET;

    RESTRequest.AddParameter('cep', ACep, pkURLSEGMENT);

    RESTRequest.Execute;

    JsonText := RESTResponse.Content;

    endereco := TJson.JsonToObject<TViaCEP>(JsonText);

    Result.FCep := endereco.cep;
    Result.FCd_UF  := Fc_BuscaCodigoEstado(endereco.uf);
    Result.FUF  := endereco.uf;
    Result.FCd_Cidade := Fc_BuscaCodigoCidade(0,endereco.localidade,endereco.uf);
    Result.FCidade := endereco.localidade;
    Result.FLogradouro := endereco.logradouro;
    Result.FBairro := endereco.bairro;
  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
  end;
end;

{ TViaCEP }
class function TViaCEP.BuscarEnderecoPorCEP(const ACep: string): TViaCEP;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JsonText: string;
begin
  RESTClient   := TRESTClient.Create(nil);
  RESTRequest  := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTClient.BaseURL := 'https://viacep.com.br/ws';

    RESTRequest.Client   := RESTClient;
    RESTRequest.Response := RESTResponse;

    RESTRequest.Resource := '{cep}/json';
    RESTRequest.Method   := rmGET;

    RESTRequest.AddParameter('cep', ACep, pkURLSEGMENT);

    RESTRequest.Execute;

    JsonText := RESTResponse.Content;

    Result := TJson.JsonToObject<TViaCEP>(JsonText);
  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
  end;
end;

end.
