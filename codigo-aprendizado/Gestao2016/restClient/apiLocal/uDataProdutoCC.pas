//
// Created by the DataSnap proxy generator.
// 28/05/2019 00:15:02
//

unit uDataProdutoCC;

interface

uses     System.JSON, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TSMProdutoClient = class(TDSAdminRestClient)
  private
    FsaveCommand: TDSRestCommand;
    FsaveCommand_Cache: TDSRestCommand;
    FgetListCommand: TDSRestCommand;
    FgetListCommand_Cache: TDSRestCommand;
    FgetItemCheckOutCommand: TDSRestCommand;
    FgetItemCheckOutCommand_Cache: TDSRestCommand;
    FgetByIdCommand: TDSRestCommand;
    FgetByIdCommand_Cache: TDSRestCommand;
    FPc_ErroCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function save(par: string; const ARequestFilter: string = ''): TJSONValue;
    function save_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONValue;
    function getList(par: string; const ARequestFilter: string = ''): TJSONObject;
    function getList_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function getItemCheckOut(par: string; const ARequestFilter: string = ''): TJSONObject;
    function getItemCheckOut_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function getById(par: string; const ARequestFilter: string = ''): TJSONObject;
    function getById_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    procedure Pc_Erro(Pc_MsgErro: string);
  end;



const
  TSMProduto_save: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  TSMProduto_save_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMProduto_getList: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMProduto_getList_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMProduto_getItemCheckOut: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMProduto_getItemCheckOut_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMProduto_getById: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMProduto_getById_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMProduto_Pc_Erro: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Pc_MsgErro'; Direction: 1; DBXType: 26; TypeName: 'string')
  );


implementation

function TSMProdutoClient.save(par: string; const ARequestFilter: string): TJSONValue;
begin
  if FsaveCommand = nil then
  begin
    FsaveCommand := FConnection.CreateCommand;
    FsaveCommand.RequestType := 'GET';
    FsaveCommand.Text := 'TSMProduto.save';
    FsaveCommand.Prepare(TSMProduto_save);
  end;
  FsaveCommand.Parameters[0].Value.SetWideString(par);
  FsaveCommand.Execute(ARequestFilter);
  Result := TJSONValue(FsaveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMProdutoClient.save_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONValue;
begin
  if FsaveCommand_Cache = nil then
  begin
    FsaveCommand_Cache := FConnection.CreateCommand;
    FsaveCommand_Cache.RequestType := 'GET';
    FsaveCommand_Cache.Text := 'TSMProduto.save';
    FsaveCommand_Cache.Prepare(TSMProduto_save_Cache);
  end;
  FsaveCommand_Cache.Parameters[0].Value.SetWideString(par);
  FsaveCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONValue.Create(FsaveCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMProdutoClient.getList(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FgetListCommand = nil then
  begin
    FgetListCommand := FConnection.CreateCommand;
    FgetListCommand.RequestType := 'GET';
    FgetListCommand.Text := 'TSMProduto.getList';
    FgetListCommand.Prepare(TSMProduto_getList);
  end;
  FgetListCommand.Parameters[0].Value.SetWideString(par);
  FgetListCommand.Execute(ARequestFilter);
  Result := TJSONObject(FgetListCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMProdutoClient.getList_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FgetListCommand_Cache = nil then
  begin
    FgetListCommand_Cache := FConnection.CreateCommand;
    FgetListCommand_Cache.RequestType := 'GET';
    FgetListCommand_Cache.Text := 'TSMProduto.getList';
    FgetListCommand_Cache.Prepare(TSMProduto_getList_Cache);
  end;
  FgetListCommand_Cache.Parameters[0].Value.SetWideString(par);
  FgetListCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FgetListCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMProdutoClient.getItemCheckOut(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FgetItemCheckOutCommand = nil then
  begin
    FgetItemCheckOutCommand := FConnection.CreateCommand;
    FgetItemCheckOutCommand.RequestType := 'GET';
    FgetItemCheckOutCommand.Text := 'TSMProduto.getItemCheckOut';
    FgetItemCheckOutCommand.Prepare(TSMProduto_getItemCheckOut);
  end;
  FgetItemCheckOutCommand.Parameters[0].Value.SetWideString(par);
  FgetItemCheckOutCommand.Execute(ARequestFilter);
  Result := TJSONObject(FgetItemCheckOutCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMProdutoClient.getItemCheckOut_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FgetItemCheckOutCommand_Cache = nil then
  begin
    FgetItemCheckOutCommand_Cache := FConnection.CreateCommand;
    FgetItemCheckOutCommand_Cache.RequestType := 'GET';
    FgetItemCheckOutCommand_Cache.Text := 'TSMProduto.getItemCheckOut';
    FgetItemCheckOutCommand_Cache.Prepare(TSMProduto_getItemCheckOut_Cache);
  end;
  FgetItemCheckOutCommand_Cache.Parameters[0].Value.SetWideString(par);
  FgetItemCheckOutCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FgetItemCheckOutCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMProdutoClient.getById(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FgetByIdCommand = nil then
  begin
    FgetByIdCommand := FConnection.CreateCommand;
    FgetByIdCommand.RequestType := 'GET';
    FgetByIdCommand.Text := 'TSMProduto.getById';
    FgetByIdCommand.Prepare(TSMProduto_getById);
  end;
  FgetByIdCommand.Parameters[0].Value.SetWideString(par);
  FgetByIdCommand.Execute(ARequestFilter);
  Result := TJSONObject(FgetByIdCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMProdutoClient.getById_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FgetByIdCommand_Cache = nil then
  begin
    FgetByIdCommand_Cache := FConnection.CreateCommand;
    FgetByIdCommand_Cache.RequestType := 'GET';
    FgetByIdCommand_Cache.Text := 'TSMProduto.getById';
    FgetByIdCommand_Cache.Prepare(TSMProduto_getById_Cache);
  end;
  FgetByIdCommand_Cache.Parameters[0].Value.SetWideString(par);
  FgetByIdCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FgetByIdCommand_Cache.Parameters[1].Value.GetString);
end;

procedure TSMProdutoClient.Pc_Erro(Pc_MsgErro: string);
begin
  if FPc_ErroCommand = nil then
  begin
    FPc_ErroCommand := FConnection.CreateCommand;
    FPc_ErroCommand.RequestType := 'GET';
    FPc_ErroCommand.Text := 'TSMProduto.Pc_Erro';
    FPc_ErroCommand.Prepare(TSMProduto_Pc_Erro);
  end;
  FPc_ErroCommand.Parameters[0].Value.SetWideString(Pc_MsgErro);
  FPc_ErroCommand.Execute;
end;

constructor TSMProdutoClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSMProdutoClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSMProdutoClient.Destroy;
begin
  FreeAndNil(FsaveCommand);
  FreeAndNil(FsaveCommand_Cache);
  FreeAndNil(FgetListCommand);
  FreeAndNil(FgetListCommand_Cache);
  FreeAndNil(FgetItemCheckOutCommand);
  FreeAndNil(FgetItemCheckOutCommand_Cache);
  FreeAndNil(FgetByIdCommand);
  FreeAndNil(FgetByIdCommand_Cache);
  FreeAndNil(FPc_ErroCommand);
  inherited;
end;

end.

