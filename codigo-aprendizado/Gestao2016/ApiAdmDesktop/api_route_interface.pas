unit api_route_interface;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, System.SysUtils, tblInterface, System.Contnrs, Generics.Collections;

type
  TListaInterface = TObjectList<TInterface>;

  TApiRouteInterface = class(TBaseApiAdmDesktop)
    private

    public
      ObjInterface : TInterface;
      Lista : TListaInterface;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function getList(cliente,projeto:Integer): Boolean;
      function put: Boolean;
      function post: Boolean;
      function delete: Boolean;
  end;
implementation

{ TApiRouteInterface }

constructor TApiRouteInterface.Create(AOwner: TComponent);
begin
  inherited;
  ObjInterface := TInterface.create;
  Lista := TListaInterface.create;
end;

function TApiRouteInterface.delete: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('delete','interface','delete','');
  LcStrJSon := TJson.ObjectToJsonString(ObjInterface);
  Result := sendData(LcStrJSon);
end;

destructor TApiRouteInterface.Destroy;
begin
  FreeAndNil(ObjInterface);
  FreeAndNil(Lista);
  inherited;
end;

function TApiRouteInterface.getList(cliente,projeto:Integer): Boolean;
Var
  Lc_item :TInterface;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  Result := False;
  Lista.Clear;
  configComponents('get','interface','getlist',concat(IntToStr(cliente),'/',IntToStr(projeto)));
  if not LoadJsonArrayFromGet('TApiRouteInterface.getList', LArray) then
    Exit;
  try
    for LValue in LArray do
    begin
      LJsonObject := TJSONObject.ParseJSONValue(LValue.ToJSON) as TJSONObject;
      if LJsonObject = nil then
        Continue;
      try
        Lc_item := TJSON.JsonToObject<TInterface>(LJsonObject);
        Lista.Add(Lc_item);
      finally
        LJsonObject.Free;
      end;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      LogRoute('TApiRouteInterface.getList', E.Message);
      Lista.Clear;
    end;
  end;
  LArray.Free;
end;

function TApiRouteInterface.post: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('post','interface','post','');
  LcStrJSon := TJson.ObjectToJsonString(ObjInterface);
  Result := sendData(LcStrJSon);
end;

function TApiRouteInterface.put: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('put','interface','put','');
  LcStrJSon := TJson.ObjectToJsonString(ObjInterface);
  Result := sendData(LcStrJSon);
end;

end.
