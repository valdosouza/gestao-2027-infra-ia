unit uDataUsuarioCC;

interface

uses     System.JSON, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type

    TSMUsuarioClient = class(TDSAdminRestClient)
  private
    FGetAuthenticationCommand: TDSRestCommand;
    FPc_ErroCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function GetAuthentication(par: string; const ARequestFilter: string = ''): string;
    procedure Pc_Erro(Pc_MsgErro: string);
  end;

const
  TSMUsuario_GetAuthentication: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'par'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSMUsuario_Pc_Erro: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Pc_MsgErro'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

implementation

function TSMUsuarioClient.GetAuthentication(par: string; const ARequestFilter: string): string;
begin
  if FGetAuthenticationCommand = nil then
  begin
    FGetAuthenticationCommand := FConnection.CreateCommand;
    FGetAuthenticationCommand.RequestType := 'GET';
    FGetAuthenticationCommand.Text := 'TSMUsuario.GetAuthentication';
    FGetAuthenticationCommand.Prepare(TSMUsuario_GetAuthentication);
  end;
  FGetAuthenticationCommand.Parameters[0].Value.SetWideString(par);
  FGetAuthenticationCommand.Execute(ARequestFilter);
  Result := FGetAuthenticationCommand.Parameters[1].Value.GetWideString;
end;

procedure TSMUsuarioClient.Pc_Erro(Pc_MsgErro: string);
begin
  if FPc_ErroCommand = nil then
  begin
    FPc_ErroCommand := FConnection.CreateCommand;
    FPc_ErroCommand.RequestType := 'GET';
    FPc_ErroCommand.Text := 'TSMUsuario.Pc_Erro';
    FPc_ErroCommand.Prepare(TSMUsuario_Pc_Erro);
  end;
  FPc_ErroCommand.Parameters[0].Value.SetWideString(Pc_MsgErro);
  FPc_ErroCommand.Execute;
end;

constructor TSMUsuarioClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSMUsuarioClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSMUsuarioClient.Destroy;
begin
  FreeAndNil(FGetAuthenticationCommand);
  FreeAndNil(FPc_ErroCommand);
  inherited;
end;


end.
