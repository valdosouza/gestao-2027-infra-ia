unit api_route_itens_ifc;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, System.SysUtils, tblItensIfc, System.Contnrs, Generics.Collections;

type
  TListaItensIfc = TObjectList<TItensIfc>;

  TApiRouteItensIfc = class(TBaseApiAdmDesktop)
    private

    public
      ObjOperInterface : TItensIfc;
      Lista : TListaItensIfc;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function getList(Projeto:Integer): Boolean;
      function put: Boolean;
      function post: Boolean;
      function delete: Boolean;
  end;
implementation

{ TApiRouteItensIfc }

constructor TApiRouteItensIfc.Create(AOwner: TComponent);
begin
  inherited;
  ObjOperInterface := TItensIfc.create;
  Lista := TListaItensIfc.create;
end;

function TApiRouteItensIfc.delete: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('delete','itensifc','delete','');
  LcStrJSon := TJson.ObjectToJsonString(ObjOperInterface);
  Result := sendData(LcStrJSon);
end;

destructor TApiRouteItensIfc.Destroy;
begin
  FreeAndNil(ObjOperInterface);
  FreeAndNil(Lista);
  inherited;
end;

function TApiRouteItensIfc.getList(Projeto:Integer): Boolean;
Var
  Lc_item :TItensIfc;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  Result := False;
  Lista.Clear;
  configComponents('get','itensifc','getlist',IntToStr(Projeto));
  if not LoadJsonArrayFromGet('TApiRouteItensIfc.getList', LArray) then
    Exit;
  try
    for LValue in LArray do
    begin
      LJsonObject := TJSONObject.ParseJSONValue(LValue.ToJSON) as TJSONObject;
      if LJsonObject = nil then
        Continue;
      try
        Lc_item := TJSON.JsonToObject<TItensIfc>(LJsonObject);
        Lista.Add(Lc_item);
      finally
        LJsonObject.Free;
      end;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      LogRoute('TApiRouteItensIfc.getList', E.Message);
      Lista.Clear;
    end;
  end;
  LArray.Free;
end;

function TApiRouteItensIfc.post: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('post','itensifc','post','');
  LcStrJSon := TJson.ObjectToJsonString(ObjOperInterface);
  Result := sendData(LcStrJSon);
end;

function TApiRouteItensIfc.put: Boolean;
Var
  LcStrJSon : String;
begin
  configComponents('put','itensifc','put','');
  LcStrJSon := TJson.ObjectToJsonString(ObjOperInterface);
  Result := sendData(LcStrJSon);
end;

end.
