unit api_route_cliente;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, tblProjCliente, tblAdmCliente, System.SysUtils;

type
  TApiRouteCliente = class(TBaseApiAdmDesktop)
    private

    public
      ObjCliente : TAdmCliente;
      ObjProjCliente : TProjCliente;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function get(Codigo:Integer): Boolean;
      function getProject(CNPJ:String): Boolean;
      function put: Boolean;
  end;
implementation

{ TApiRouteCliente }

constructor TApiRouteCliente.Create(AOwner: TComponent);
begin
  inherited;
  ObjCliente := TAdmCliente.create;
  ObjProjCliente := TProjCliente.create;
end;

destructor TApiRouteCliente.Destroy;
begin
  FreeAndNil(ObjCliente);
  FreeAndNil(ObjProjCliente);
  inherited;
end;

function TApiRouteCliente.get(Codigo: Integer): Boolean;
Var
  LcStrJSon : String;
  LcNovo: TAdmCliente;
begin
  Result := False;
  configComponents('get','cliente','get',IntToStr(Codigo));
  if not getData then
    Exit;
  if not verificaretorno then
    Exit;
  try
    LcStrJSon := RESTResponse.Content;
    LcNovo := TJson.JsonToObject<TAdmCliente>(LcStrJSon);
    FreeAndNil(ObjCliente);
    ObjCliente := LcNovo;
    Result := True;
  except
    on E: Exception do
      LogRoute('TApiRouteCliente.get', E.Message);
  end;
end;

function TApiRouteCliente.getProject(CNPJ:String): Boolean;
Var
  LcStrJSon : String;
  LcNovo: TProjCliente;
begin
  Result := False;
  configComponents('get','cliente','getProject',CNPJ);
  if not getData then
    Exit;
  if not verificaretorno then
    Exit;
  try
    LcStrJSon := RESTResponse.Content;
    LcNovo := TJson.JsonToObject<TProjCliente>(LcStrJSon);
    FreeAndNil(ObjProjCliente);
    ObjProjCliente := LcNovo;
    Result := True;
  except
    on E: Exception do
      LogRoute('TApiRouteCliente.getProject', E.Message);
  end;
end;

function TApiRouteCliente.put: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('put','cliente','put','');
  LcStrJSon := TJson.ObjectToJsonString(ObjCliente);
  Result := sendData(LcStrJSon);
end;

end.
