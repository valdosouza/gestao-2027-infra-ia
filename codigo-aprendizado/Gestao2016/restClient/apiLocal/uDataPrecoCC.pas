unit uDataPrecoCC;

interface

uses     System.JSON, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type

  TSMPrecoClient = class(TDSAdminRestClient)
  private
    FsaveCommand: TDSRestCommand;
    FsaveCommand_Cache: TDSRestCommand;
    FgetListByProdutoCommand: TDSRestCommand;
    FgetListByProdutoCommand_Cache: TDSRestCommand;
    FPc_ErroCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function save(par: string; const ARequestFilter: string = ''): TJSONValue;
    function save_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONValue;
    function getListByProduto(par: string; const ARequestFilter: string = ''): TJSONObject;
    function getListByProduto_Cache(par: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    procedure Pc_Erro(Pc_MsgErro: string);
  end;

const

  TSMPreco_save: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  TSMPreco_save_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMPreco_getListByProduto: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TSMPreco_getListByProduto_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSMPreco_Pc_Erro: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Pc_MsgErro'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

implementation

function TSMPrecoClient.save(par: string; const ARequestFilter: string): TJSONValue;
begin
  if FsaveCommand = nil then
  begin
    FsaveCommand := FConnection.CreateCommand;
    FsaveCommand.RequestType := 'GET';
    FsaveCommand.Text := 'TSMPreco.save';
    FsaveCommand.Prepare(TSMPreco_save);
  end;
  FsaveCommand.Parameters[0].Value.SetWideString(par);
  FsaveCommand.Execute(ARequestFilter);
  Result := TJSONValue(FsaveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMPrecoClient.save_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONValue;
begin
  if FsaveCommand_Cache = nil then
  begin
    FsaveCommand_Cache := FConnection.CreateCommand;
    FsaveCommand_Cache.RequestType := 'GET';
    FsaveCommand_Cache.Text := 'TSMPreco.save';
    FsaveCommand_Cache.Prepare(TSMPreco_save_Cache);
  end;
  FsaveCommand_Cache.Parameters[0].Value.SetWideString(par);
  FsaveCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONValue.Create(FsaveCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMPrecoClient.getListByProduto(par: string; const ARequestFilter: string): TJSONObject;
begin
  if FgetListByProdutoCommand = nil then
  begin
    FgetListByProdutoCommand := FConnection.CreateCommand;
    FgetListByProdutoCommand.RequestType := 'GET';
    FgetListByProdutoCommand.Text := 'TSMPreco.getListByProduto';
    FgetListByProdutoCommand.Prepare(TSMPreco_getListByProduto);
  end;
  FgetListByProdutoCommand.Parameters[0].Value.SetWideString(par);
  FgetListByProdutoCommand.Execute(ARequestFilter);
  Result := TJSONObject(FgetListByProdutoCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TSMPrecoClient.getListByProduto_Cache(par: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FgetListByProdutoCommand_Cache = nil then
  begin
    FgetListByProdutoCommand_Cache := FConnection.CreateCommand;
    FgetListByProdutoCommand_Cache.RequestType := 'GET';
    FgetListByProdutoCommand_Cache.Text := 'TSMPreco.getListByProduto';
    FgetListByProdutoCommand_Cache.Prepare(TSMPreco_getListByProduto_Cache);
  end;
  FgetListByProdutoCommand_Cache.Parameters[0].Value.SetWideString(par);
  FgetListByProdutoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FgetListByProdutoCommand_Cache.Parameters[1].Value.GetString);
end;

procedure TSMPrecoClient.Pc_Erro(Pc_MsgErro: string);
begin
  if FPc_ErroCommand = nil then
  begin
    FPc_ErroCommand := FConnection.CreateCommand;
    FPc_ErroCommand.RequestType := 'GET';
    FPc_ErroCommand.Text := 'TSMPreco.Pc_Erro';
    FPc_ErroCommand.Prepare(TSMPreco_Pc_Erro);
  end;
  FPc_ErroCommand.Parameters[0].Value.SetWideString(Pc_MsgErro);
  FPc_ErroCommand.Execute;
end;

constructor TSMPrecoClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSMPrecoClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSMPrecoClient.Destroy;
begin
  FreeAndNil(FsaveCommand);
  FreeAndNil(FsaveCommand_Cache);
  FreeAndNil(FgetListByProdutoCommand);
  FreeAndNil(FgetListByProdutoCommand_Cache);
  FreeAndNil(FPc_ErroCommand);
  inherited;
end;

end.
