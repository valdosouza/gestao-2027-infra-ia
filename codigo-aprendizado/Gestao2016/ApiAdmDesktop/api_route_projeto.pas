unit api_route_projeto;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, System.SysUtils;

type
  TApiRouteProjeto = class(TBaseApiAdmDesktop)
    private

    public
      ObjProjeto : TProjeto;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function get(Codigo:Integer): Boolean;
  end;
implementation

{ TApiRouteProjeto }

constructor TApiRouteProjeto.Create(AOwner: TComponent);
begin
  inherited;
  ObjProjeto := TProjeto.create;
end;

destructor TApiRouteProjeto.Destroy;
begin
  FreeAndNil(ObjProjeto);
  inherited;
end;

function TApiRouteProjeto.get(Codigo: Integer): Boolean;
Var
  LcStrJSon : String;
  LcNovo: TProjeto;
begin
  Result := False;
  configComponents('get','projeto','get',IntToStr(Codigo));
  if not getData then
    Exit;
  if not verificaretorno then
    Exit;
  try
    LcStrJSon := RESTResponse.Content;
    LcNovo := TJson.JsonToObject<TProjeto>(LcStrJSon);
    FreeAndNil(ObjProjeto);
    ObjProjeto := LcNovo;
    Result := True;
  except
    on E: Exception do
      LogRoute('TApiRouteProjeto.get', E.Message);
  end;
end;

end.
