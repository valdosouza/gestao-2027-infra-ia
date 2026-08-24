unit api_route_oper_interface;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, System.SysUtils, tblOperInterface, System.Contnrs, Generics.Collections;

type
  TListaOperInterface = TObjectList<TOperInterface>;

  TApiRouteOperInterface = class(TBaseApiAdmDesktop)
    private

    public
      ObjOperInterface : TOperInterface;
      Lista : TListaOperInterface;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function getList(): Boolean;
  end;
implementation

{ TApiRouteOperInterface }

constructor TApiRouteOperInterface.Create(AOwner: TComponent);
begin
  inherited;
  ObjOperInterface := TOperInterface.create;
  Lista := TListaOperInterface.create;
end;

destructor TApiRouteOperInterface.Destroy;
begin
  FreeAndNil(ObjOperInterface);
  FreeAndNil(Lista);
  inherited;
end;

function TApiRouteOperInterface.getList(): Boolean;
Var
  Lc_item :TOperInterface;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  Result := False;
  Lista.Clear;
  configComponents('get','operinterface','getlist','');
  if not LoadJsonArrayFromGet('TApiRouteOperInterface.getList', LArray) then
    Exit;
  try
    for LValue in LArray do
    begin
      LJsonObject := TJSONObject.ParseJSONValue(LValue.ToJSON) as TJSONObject;
      if LJsonObject = nil then
        Continue;
      try
        Lc_item := TJSON.JsonToObject<TOperInterface>(LJsonObject);
        Lista.Add(Lc_item);
      finally
        LJsonObject.Free;
      end;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      LogRoute('TApiRouteOperInterface.getList', E.Message);
      Lista.Clear;
    end;
  end;
  LArray.Free;
end;

end.
