unit api_route_script_exec;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, tblScriptExec, tblAdmCliente, System.SysUtils;

type

  TApiRouteScriptExec = class(TBaseApiAdmDesktop)
    private

    public
      ObjScriptExec : TScriptExec;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function post(): Boolean;
  end;
implementation

{ TApiRouteScriptExec }

constructor TApiRouteScriptExec.Create(AOwner: TComponent);
begin
  inherited;
  ObjScriptExec := TScriptexec.create;
end;

destructor TApiRouteScriptExec.Destroy;
begin
  FreeAndNil(ObjScriptExec);
  inherited;
end;

function TApiRouteScriptExec.post: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('post','scriptexec','post','');
  LcStrJSon := TJson.ObjectToJsonString(ObjScriptExec);
  Result := sendData(LcStrJSon);
end;

end.
