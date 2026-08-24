unit api_route_script;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, System.SysUtils, tblScript, System.Contnrs, Generics.Collections;

type
  TListaScript = TObjectList<TScript>;

  TApiRouteScript = class(TBaseApiAdmDesktop)
    private

    public
      ObjScript : TScript;
      Lista : TListaScript;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function getList(Cliente:Integer): Boolean;
  end;
implementation

{ TApiRouteScript }

constructor TApiRouteScript.Create(AOwner: TComponent);
begin
  inherited;
  ObjScript := TScript.create;
  Lista := TListaScript.create;
end;

destructor TApiRouteScript.Destroy;
begin
  FreeAndNil(ObjScript);
  FreeAndNil(Lista);
  inherited;
end;

function TApiRouteScript.getList(Cliente: Integer): Boolean;
Var
  Lc_item :Tscript;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  Result := False;
  Lista.Clear;
  configComponents('get','script','getlist',IntToStr(Cliente));
  if not LoadJsonArrayFromGet('TApiRouteScript.getList', LArray) then
    Exit;
  try
    for LValue in LArray do
    begin
      LJsonObject := TJSONObject.ParseJSONValue(LValue.ToJSON) as TJSONObject;
      if LJsonObject = nil then
        Continue;
      try
        Lc_item := TJSON.JsonToObject<TScript>(LJsonObject);
        Lista.Add(Lc_item);
      finally
        LJsonObject.Free;
      end;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      LogRoute('TApiRouteScript.getList', E.Message);
      Lista.Clear;
    end;
  end;
  LArray.Free;
end;

end.
