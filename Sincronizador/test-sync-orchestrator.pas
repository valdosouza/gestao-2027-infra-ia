{ TTestSyncOrchestrator — Script de teste incremental do sincronizador

  AVISO: Este é um template Delphi/Pascal. Adaptar conforme a estrutura real do projeto.

  Princípios:
  1. Testes ordenados por dependência (Level 0 → 1 → 2 → ...)
  2. Para em caso de erro (não continua para dependentes)
  3. Aguarda aprovação para reset + retry
  4. Logs centralizados na API (setes_central.tb_sync_test_log)
}

unit TestSyncOrchestrator;

interface

uses
  SysUtils, Classes, StrUtils, Variants, DateUtils,
  // Supostamente já existentes no projeto:
  HTTPClient, RESTClient, JSON,
  Logger; // sua classe de log

type
  // Estrutura de uma tabela + suas dependências
  TTableDependency = record
    Level: Integer;
    TableName: string;
    SendClass: string;
    Endpoint: string;
    Dependencies: TArray<string>;
  end;

  // Resultado de teste de uma tabela
  TTestTableResult = record
    TableName: string;
    Status: string; // 'success', 'failed', 'reset'
    RegisterCount: Integer;
    ErrorMessage: string;
    Timestamp: TDateTime;
  end;

  TTestSyncOrchestrator = class
  private
    FApiClient: TRESTClient;
    FLogger: TLogger;
    FSessionId: string;
    FDependencyMap: TArray<TTableDependency>;
    FResults: TArray<TTestTableResult>;
    FStoppedAtTable: string;
    procedure LoadDependencyMap;
    procedure LogMessage(const AMessage: string);
    procedure LogError(const AMessage, ADetails: string);
    function GetTableByName(const ATableName: string): TTableDependency;
    function CountRecords(const ATableName: string): Integer;
    procedure ExecuteSendClass(const ASendClass, AEndpoint: string);
    function HasAllDependenciesPassed(const ATable: TTableDependency): Boolean;
  public
    constructor Create(AApiBaseUrl: string; ALogger: TLogger);
    destructor Destroy; override;

    { Iniciar uma nova sessão de testes }
    procedure CreateTestSession(const AUsuario, AObservacoes: string);

    { Executar testes em ordem de dependência }
    procedure RunTests;

    { Obter status da sessão atual }
    function GetSessionStatus: string;

    { Resetar uma tabela e marcar para retry }
    procedure ResetTable(const ATableName: string; const AApprovedBy: string);

    { Retomar testes após uma correção }
    procedure ResumeTests;

    property SessionId: string read FSessionId;
    property StoppedAtTable: string read FStoppedAtTable;
  end;

implementation

{ ============================================================================ }
{ TTestSyncOrchestrator }
{ ============================================================================ }

constructor TTestSyncOrchestrator.Create(AApiBaseUrl: string;
  ALogger: TLogger);
begin
  inherited Create;
  FApiClient := TRESTClient.Create(AApiBaseUrl);
  FLogger := ALogger;
  FSessionId := '';
  SetLength(FResults, 0);
end;

destructor TTestSyncOrchestrator.Destroy;
begin
  FApiClient.Free;
  inherited;
end;

procedure TTestSyncOrchestrator.LogMessage(const AMessage: string);
begin
  if Assigned(FLogger) then
    FLogger.Info('[TEST] ' + AMessage)
  else
    WriteLn('[TEST] ' + AMessage);
end;

procedure TTestSyncOrchestrator.LogError(const AMessage, ADetails: string);
begin
  if Assigned(FLogger) then
    FLogger.Error('[TEST ERROR] ' + AMessage + ' | ' + ADetails)
  else
    WriteLn('[TEST ERROR] ' + AMessage + ' | ' + ADetails);
end;

procedure TTestSyncOrchestrator.LoadDependencyMap;
var
  Response: TJSONObject;
  MapArray: TJSONArray;
  I: Integer;
  Item: TJSONObject;
  DepsArray: TJSONArray;
  J: Integer;
begin
  LogMessage('Carregando mapa de dependências...');
  try
    Response := FApiClient.Get('/api/test/dependency-map') as TJSONObject;

    if not Assigned(Response) then
    begin
      LogError('LoadDependencyMap', 'Resposta vazia do servidor');
      Exit;
    end;

    SetLength(FDependencyMap, Response.Count);

    for I := 0 to Response.Count - 1 do
    begin
      Item := Response.Items[I] as TJSONObject;

      FDependencyMap[I].Level := Item.Get('level').AsInteger;
      FDependencyMap[I].TableName := Item.Get('table_name').AsString;
      FDependencyMap[I].SendClass := Item.Get('send_class', '').AsString;
      FDependencyMap[I].Endpoint := Item.Get('endpoint').AsString;

      { Carregar dependências }
      DepsArray := Item.Get('dependencies', TJSONArray.Create) as TJSONArray;
      SetLength(FDependencyMap[I].Dependencies, DepsArray.Count);

      for J := 0 to DepsArray.Count - 1 do
        FDependencyMap[I].Dependencies[J] := DepsArray.Items[J].AsString;

      LogMessage(Format('  Level %d: %s → %s',
        [FDependencyMap[I].Level, FDependencyMap[I].TableName,
         FDependencyMap[I].Endpoint]));
    end;

    Response.Free;
  except
    on E: Exception do
      LogError('LoadDependencyMap', E.Message);
  end;
end;

function TTestSyncOrchestrator.GetTableByName(const ATableName: string)
  : TTableDependency;
var
  I: Integer;
begin
  for I := Low(FDependencyMap) to High(FDependencyMap) do
  begin
    if FDependencyMap[I].TableName = ATableName then
    begin
      Result := FDependencyMap[I];
      Exit;
    end;
  end;

  Result.TableName := '';
end;

function TTestSyncOrchestrator.CountRecords(const ATableName: string): Integer;
begin
  { TODO: Implementar contagem no Firebird local
    Usar TFDQuery ou similar para:
    SELECT COUNT(*) FROM TB_XXXX WHERE DELETED = 'N'

    Por enquanto, retorna 0 como placeholder }

  LogMessage('Contando registros de ' + ATableName + '...');
  Result := 42; // placeholder
end;

function TTestSyncOrchestrator.HasAllDependenciesPassed(
  const ATable: TTableDependency): Boolean;
var
  I, J: Integer;
  DepName: string;
begin
  Result := True;

  { Se não tem dependências, passou }
  if Length(ATable.Dependencies) = 0 then
    Exit;

  { Verificar se cada dependência passou nos resultados }
  for I := Low(ATable.Dependencies) to High(ATable.Dependencies) do
  begin
    DepName := ATable.Dependencies[I];

    { Buscar resultado da dependência }
    for J := Low(FResults) to High(FResults) do
    begin
      if FResults[J].TableName = DepName then
      begin
        if FResults[J].Status <> 'success' then
        begin
          Result := False;
          Exit;
        end;
        Break;
      end;
    end;
  end;
end;

procedure TTestSyncOrchestrator.CreateTestSession(const AUsuario,
  AObservacoes: string);
var
  Request: TJSONObject;
  Response: TJSONObject;
begin
  LogMessage('Criando nova sessão de testes para: ' + AUsuario);

  try
    Request := TJSONObject.Create;
    Request.AddPair('usuario', AUsuario);
    Request.AddPair('observacoes', AObservacoes);

    Response := FApiClient.Post('/api/test/sessions', Request) as TJSONObject;

    if Assigned(Response) then
    begin
      FSessionId := Response.Get('session_id').AsString;
      LogMessage('Sessão criada: ' + FSessionId);
      Response.Free;
    end
    else
      LogError('CreateTestSession', 'Falha ao criar sessão');

    Request.Free;
  except
    on E: Exception do
      LogError('CreateTestSession', E.Message);
  end;
end;

procedure TTestSyncOrchestrator.ExecuteSendClass(const ASendClass,
  AEndpoint: string);
begin
  { Chamar o endpoint de sincronização já existente
    com header X-Test-Session para marcar como teste }

  LogMessage('Executando: ' + ASendClass + ' → ' + AEndpoint);

  try
    FApiClient.SetHeader('X-Test-Session', FSessionId);
    FApiClient.Post(AEndpoint, nil); // nil body, pode ser vazio
  except
    on E: Exception do
      raise Exception.Create('Erro ao executar ' + ASendClass + ': ' +
        E.Message);
  end;
end;

procedure TTestSyncOrchestrator.RunTests;
var
  Level: Integer;
  MaxLevel: Integer;
  I: Integer;
  Table: TTableDependency;
  RegisterCount: Integer;
  StartTime: TDateTime;
  Duration: Int64;
  Response: TJSONObject;
  Request: TJSONObject;
  Result: TTestTableResult;
  ErrorMsg: string;
begin
  if FSessionId = '' then
  begin
    LogError('RunTests', 'Nenhuma sessão ativa');
    Exit;
  end;

  { Carregar mapa de dependências }
  LoadDependencyMap;

  { Encontrar nível máximo }
  MaxLevel := 0;
  for I := Low(FDependencyMap) to High(FDependencyMap) do
    if FDependencyMap[I].Level > MaxLevel then
      MaxLevel := FDependencyMap[I].Level;

  { Executar por nível }
  Level := 0;
  while Level <= MaxLevel do
  begin
    LogMessage('');
    LogMessage('=== LEVEL ' + IntToStr(Level) + ' ===');
    LogMessage('');

    for I := Low(FDependencyMap) to High(FDependencyMap) do
    begin
      Table := FDependencyMap[I];

      { Pular se não é este nível }
      if Table.Level <> Level then
        Continue;

      { Verificar se dependências passaram }
      if not HasAllDependenciesPassed(Table) then
      begin
        LogMessage('⊘ ' + Table.TableName + ' (bloqueado - dependência falhou)');
        Continue;
      end;

      { Contar registros }
      RegisterCount := CountRecords(Table.TableName);

      { Registrar início }
      try
        Request := TJSONObject.Create;
        Request.AddPair('registros_esperados', RegisterCount);

        FApiClient.Post(Format('/api/test/sessions/%s/tables/%s/start',
          [FSessionId, Table.TableName]), Request);

        Request.Free;
      except
        on E: Exception do
          LogError('Start log', E.Message);
      end;

      { Executar sincronização }
      StartTime := Now;
      try
        ExecuteSendClass(Table.SendClass, Table.Endpoint);
        Duration := MilliSecondsBetween(Now, StartTime);

        { Registrar sucesso }
        LogMessage(Format('✓ %s (%d regs) — %d ms',
          [Table.TableName, RegisterCount, Duration]));

        Request := TJSONObject.Create;
        Request.AddPair('status', 'success');
        Request.AddPair('registros_enviados', RegisterCount);

        FApiClient.Post(Format('/api/test/sessions/%s/tables/%s/finish',
          [FSessionId, Table.TableName]), Request);

        Request.Free;

        { Salvar resultado }
        SetLength(FResults, Length(FResults) + 1);
        FResults[High(FResults)].TableName := Table.TableName;
        FResults[High(FResults)].Status := 'success';
        FResults[High(FResults)].RegisterCount := RegisterCount;
        FResults[High(FResults)].Timestamp := Now;

      except
        on E: Exception do
        begin
          ErrorMsg := E.Message;
          LogMessage('✗ ' + Table.TableName + ' — FALHOU');
          LogError('ExecuteSendClass', ErrorMsg);

          { Registrar falha }
          Request := TJSONObject.Create;
          Request.AddPair('status', 'failed');
          Request.AddPair('registros_enviados', 0);
          Request.AddPair('erro_mensagem', ErrorMsg);

          FApiClient.Post(Format('/api/test/sessions/%s/tables/%s/finish',
            [FSessionId, Table.TableName]), Request);

          Request.Free;

          { Salvar resultado }
          SetLength(FResults, Length(FResults) + 1);
          FResults[High(FResults)].TableName := Table.TableName;
          FResults[High(FResults)].Status := 'failed';
          FResults[High(FResults)].RegisterCount := RegisterCount;
          FResults[High(FResults)].ErrorMessage := ErrorMsg;
          FResults[High(FResults)].Timestamp := Now;

          { PARAR - não continuar }
          FStoppedAtTable := Table.TableName;
          LogMessage('');
          LogMessage('╔════════════════════════════════════════╗');
          LogMessage('║ TESTES INTERROMPIDOS POR ERRO          ║');
          LogMessage('║ Tabela: ' + Table.TableName);
          LogMessage('║ Aguardando correção e aprovação...     ║');
          LogMessage('╚════════════════════════════════════════╝');
          LogMessage('');
          Exit;
        end;
      end;
    end;

    Inc(Level);
  end;

  { Finalizar sessão }
  FApiClient.Post(Format('/api/test/sessions/%s/finalize', [FSessionId]), nil);
  LogMessage('✓ Testes finalizados com sucesso!');
end;

function TTestSyncOrchestrator.GetSessionStatus: string;
var
  Response: TJSONObject;
  Summary: TJSONObject;
begin
  try
    Response := FApiClient.Get(Format('/api/test/sessions/%s', [FSessionId]))
      as TJSONObject;

    if Assigned(Response) then
    begin
      Summary := Response.Get('summary').AsObject;
      Result := Format('Total: %d | Sucesso: %d | Falha: %d | Pendente: %d',
        [Summary.Get('total').AsInteger,
         Summary.Get('succeeded').AsInteger,
         Summary.Get('failed').AsInteger,
         Summary.Get('pending').AsInteger]);

      Response.Free;
    end;
  except
    Result := 'Erro ao obter status';
  end;
end;

procedure TTestSyncOrchestrator.ResetTable(const ATableName,
  AApprovedBy: string);
var
  Request: TJSONObject;
begin
  LogMessage(Format('Resetando tabela: %s (aprovado por: %s)',
    [ATableName, AApprovedBy]));

  try
    Request := TJSONObject.Create;
    Request.AddPair('approved_by', AApprovedBy);

    FApiClient.Post(Format('/api/test/sessions/%s/tables/%s/reset',
      [FSessionId, ATableName]), Request);

    Request.Free;

    { Limpar resultado anterior }
    for var I := Low(FResults) to High(FResults) do
    begin
      if FResults[I].TableName = ATableName then
      begin
        FResults[I].Status := 'reset';
        Break;
      end;
    end;

    LogMessage('✓ Tabela resetada e pronta para retry');
  except
    on E: Exception do
      LogError('ResetTable', E.Message);
  end;
end;

procedure TTestSyncOrchestrator.ResumeTests;
begin
  LogMessage('Retomando testes a partir de: ' + FStoppedAtTable);
  { Executar novamente, desta vez deve passar }
  RunTests;
end;

end.
