unit uDataComandaCC;

interface

uses     System.JSON, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type

  TSMCommandClient = class(TDSAdminRestClient)
  private
    FsaveCommand: TDSRestCommand;
    FsaveCommand_Cache: TDSRestCommand;
    FgetCommand: TDSRestCommand;
    FgetCommand_Cache: TDSRestCommand;
    FgetByProdutoCommand: TDSRestCommand;
    FgetByProdutoCommand_Cache: TDSRestCommand;
    FgetListCommand: TDSRestCommand;
    FgetListCommand_Cache: TDSRestCommand;
    FPc_ErroCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function save(par: string; const ARequestFilter: string = ''): TJSONObject;
    function save_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function get(par: string; const ARequestFilter: string = ''): TJSONObject;
    function get_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function getByProduto(par: string; const ARequestFilter: string = ''): TJSONObject;
    function getByProduto_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function getList(par: string; const ARequestFilter: string = ''): TJSONObject;
    function getList_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    procedure Pc_Erro(Pc_MsgErro: string);
  end;



const

  TSMCommand_save: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMCommand_save_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMCommand_get: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMCommand_get_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMCommand_getByProduto: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMCommand_getByProduto_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMCommand_getList: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMCommand_getList_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMCommand_Pc_Erro: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Pc_MsgErro'; Direction: 1; DBXType: 26; TypeName: 'string')
  );


implementation

function TSMCommandClient.save(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FsaveCommand = nil then
  begin
    FsaveCommand := FConnection.CreateCommand;
    FsaveCommand.RequestType := 'GET';
    FsaveCommand.Text := 'TSMCommand.save';
    FsaveCommand.Prepare(TSMCommand_save);
  end;
  FsaveCommand.Parameters[0].Value.SetWideString(par);
  FsaveCommand.Execute(ARequestFilter);
  Result := TJSONObject(FsaveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMCommandClient.save_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FsaveCommand_Cache = nil then
  begin
    FsaveCommand_Cache := FConnection.CreateCommand;
    FsaveCommand_Cache.RequestType := 'GET';
    FsaveCommand_Cache.Text := 'TSMCommand.save';
    FsaveCommand_Cache.Prepare(TSMCommand_save_Cache);
  end;
  FsaveCommand_Cache.Parameters[0].Value.SetWideString(par);
  FsaveCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FsaveCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMCommandClient.get(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FgetCommand = nil then
  begin
    FgetCommand := FConnection.CreateCommand;
    FgetCommand.RequestType := 'GET';
    FgetCommand.Text := 'TSMCommand.get';
    FgetCommand.Prepare(TSMCommand_get);
  end;
  FgetCommand.Parameters[0].Value.SetWideString(par);
  FgetCommand.Execute(ARequestFilter);
  Result := TJSONObject(FgetCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMCommandClient.get_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FgetCommand_Cache = nil then
  begin
    FgetCommand_Cache := FConnection.CreateCommand;
    FgetCommand_Cache.RequestType := 'GET';
    FgetCommand_Cache.Text := 'TSMCommand.get';
    FgetCommand_Cache.Prepare(TSMCommand_get_Cache);
  end;
  FgetCommand_Cache.Parameters[0].Value.SetWideString(par);
  FgetCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FgetCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMCommandClient.getByProduto(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FgetByProdutoCommand = nil then
  begin
    FgetByProdutoCommand := FConnection.CreateCommand;
    FgetByProdutoCommand.RequestType := 'GET';
    FgetByProdutoCommand.Text := 'TSMCommand.getByProduto';
    FgetByProdutoCommand.Prepare(TSMCommand_getByProduto);
  end;
  FgetByProdutoCommand.Parameters[0].Value.SetWideString(par);
  FgetByProdutoCommand.Execute(ARequestFilter);
  Result := TJSONObject(FgetByProdutoCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMCommandClient.getByProduto_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FgetByProdutoCommand_Cache = nil then
  begin
    FgetByProdutoCommand_Cache := FConnection.CreateCommand;
    FgetByProdutoCommand_Cache.RequestType := 'GET';
    FgetByProdutoCommand_Cache.Text := 'TSMCommand.getByProduto';
    FgetByProdutoCommand_Cache.Prepare(TSMCommand_getByProduto_Cache);
  end;
  FgetByProdutoCommand_Cache.Parameters[0].Value.SetWideString(par);
  FgetByProdutoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FgetByProdutoCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMCommandClient.getList(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FgetListCommand = nil then
  begin
    FgetListCommand := FConnection.CreateCommand;
    FgetListCommand.RequestType := 'GET';
    FgetListCommand.Text := 'TSMCommand.getList';
    FgetListCommand.Prepare(TSMCommand_getList);
  end;
  FgetListCommand.Parameters[0].Value.SetWideString(par);
  FgetListCommand.Execute(ARequestFilter);
  Result := TJSONObject(FgetListCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMCommandClient.getList_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FgetListCommand_Cache = nil then
  begin
    FgetListCommand_Cache := FConnection.CreateCommand;
    FgetListCommand_Cache.RequestType := 'GET';
    FgetListCommand_Cache.Text := 'TSMCommand.getList';
    FgetListCommand_Cache.Prepare(TSMCommand_getList_Cache);
  end;
  FgetListCommand_Cache.Parameters[0].Value.SetWideString(par);
  FgetListCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FgetListCommand_Cache.Parameters[1].Value.GetString);
end;

procedure TSMCommandClient.Pc_Erro(Pc_MsgErro: string);
begin
  if FPc_ErroCommand = nil then
  begin
    FPc_ErroCommand := FConnection.CreateCommand;
    FPc_ErroCommand.RequestType := 'GET';
    FPc_ErroCommand.Text := 'TSMCommand.Pc_Erro';
    FPc_ErroCommand.Prepare(TSMCommand_Pc_Erro);
  end;
  FPc_ErroCommand.Parameters[0].Value.SetWideString(Pc_MsgErro);
  FPc_ErroCommand.Execute;
end;

constructor TSMCommandClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSMCommandClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSMCommandClient.Destroy;
begin
  FreeAndNil(FsaveCommand);
  FreeAndNil(FsaveCommand_Cache);
  FreeAndNil(FgetCommand);
  FreeAndNil(FgetCommand_Cache);
  FreeAndNil(FgetByProdutoCommand);
  FreeAndNil(FgetByProdutoCommand_Cache);
  FreeAndNil(FgetListCommand);
  FreeAndNil(FgetListCommand_Cache);
  FreeAndNil(FPc_ErroCommand);
  inherited;
end;

end.

