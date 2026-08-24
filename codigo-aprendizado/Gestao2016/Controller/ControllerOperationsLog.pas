unit ControllerOperationsLog;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblOperationsLog, prm_operations_log;

Type
  TListOperationsLog = TObjectList<TOperationsLog>;
  TControllerOperationsLog = Class(TControllerBase)
  private
    FParametros: TPrmOperationsLog;
    procedure setFParametros(const Value: TPrmOperationsLog);
  public
    Registro : TOperationsLog;
    Lista : TListOperationsLog;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmOperationsLog read FParametros write setFParametros;
  End;

implementation

function TControllerOperationsLog.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerOperationsLog.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TOperationsLog.Create;
  FParametros := TPrmOperationsLog.Create;
  Lista := TListOperationsLog.Create;
end;

function TControllerOperationsLog.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerOperationsLog.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  FreeAndNil(FParametros);
  inherited;
end;

function TControllerOperationsLog.insert: boolean;
begin
  Result := True;
  Registro.Codigo := Generator('GN_LOG_OPERACAO');
  Try
    InsertObj(Registro);
  Except
    Result := False;
    setGenerator('GN_LOG_OPERACAO',IntToStr(getNextByField(Registro,'LOG_CODIGO',0)));
  End;
end;

function TControllerOperationsLog.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_LOG_OPERACAO');
  Try
    SaveObj(Registro);
  except
    setGenerator('GN_LOG_OPERACAO',IntToStr(getNextByField(Registro,'LOG_CODIGO',0)));
  End;
end;

procedure TControllerOperationsLog.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TOperationsLog;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM TB_LOG_OPERACAO WHERE 1=1 ');

      if FParametros.FieldName.Codigo > 0 then
        SQL.Add(' AND LOG_CODIGO = :LOG_CODIGO');

      if FParametros.FieldName.Descricao <> EmptyStr then
        SQL.Add(' AND LOG_DESCRICAO LIKE :LOG_DESCRICAO');

      SQL.Add(' ORDER BY LOG_DESCRICAO ');

      if FParametros.FieldName.Codigo > 0 then
        ParamByName('LOG_CODIGO').AsInteger := FParametros.FieldName.Codigo;

      if FParametros.FieldName.Descricao <> EmptyStr then
        ParamByName('LOG_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TOperationsLog.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerOperationsLog.setFParametros(const Value: TPrmOperationsLog);
begin
  FParametros := Value;
end;

procedure TControllerOperationsLog.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerOperationsLog.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

