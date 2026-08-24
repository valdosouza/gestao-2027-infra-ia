unit GenericEntity;

interface

Uses     System.SysUtils, System.Classes, System.IOUtils, env, ControllerBase, STQuery, STScript;


Type
  TGenericEntity = class(TObject)
  private
    Base : TcontrollerBase;
  protected
    FFileName : String;
    function existDomain(Domain : String):Boolean;
    function existTable(Tabela : String):Boolean;
    function existField(Tabela,campo : String):Boolean;

    procedure ExecSqlScriptFromFile;

    procedure RunScript(Script: String);

    procedure CreateDomains;Virtual;
    procedure CreateTable;Virtual;
    procedure CreateField;Virtual;
    procedure InsertData;Virtual;
  public
    constructor Create; Virtual;
    destructor Destroy; Virtual;
  end;

implementation

{ TGenericEntity }

constructor TGenericEntity.Create;
begin
  FFileName :=  GbPathExe;
  Base := TcontrollerBase.Create(nil);
  CreateDomains;
  CreateTable;
  CreateField;
  InsertData;
end;

procedure TGenericEntity.CreateDomains;
begin
  //impementado nos descendentes
end;

procedure TGenericEntity.CreateField;
begin
  //impementado nos descendentes
end;

procedure TGenericEntity.CreateTable;
begin
  //impementado nos descendentes
end;

destructor TGenericEntity.Destroy;
begin
  FreeAndNil(Base);
end;

procedure TGenericEntity.ExecSqlScriptFromFile;
var
  Script: TSTScript;
  Src: string;
begin
  if FileExists(FFileName) then
  Begin
    try
      Src := TFile.ReadAllText(FFileName); // fallback (ANSI/Windows-1252)
    except
      Src := TFile.ReadAllText(FFileName, TEncoding.UTF8);
    end;

    Script := base.GeraScript;
    try
      // Deixe o próprio script controlar transções (se o arquivo tiver COMMIT)
      Script.Script.Append(Src);
      // TODO : Script.ExecuteScript
      //Script.ExecuteScript;
    finally
      FreeAndNil(Script);
      DeleteFile(FFileName);
    end;
  end;
end;

function TGenericEntity.existDomain(Domain: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := Base.GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select RDB$FIELD_NAME ',
                'from RDB$FIELDS ',
                'where upper(RDB$FIELD_NAME) = :DOMAIN '
        ));
      ParamByName('DOMAIN').AsString := UpperCase(Domain);
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;

end;

function TGenericEntity.existField(Tabela, campo: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := Base.GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'select 1 ',
                'from rdb$relation_fields ',
                'where RDB$RELATION_FIELDS.rdb$relation_name =:TABELA AND ',
                'RDB$RELATION_FIELDS.RDB$FIELD_NAME =:CAMPO '
        ));
      ParamByName('TABELA').AsString := Tabela;
      ParamByName('CAMPO').AsString := campo;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

function TGenericEntity.existTable(Tabela: String): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := Base.GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
              'select rdb$relation_name ',
              'from rdb$relations ',
              'where rdb$view_blr is null ',
              'and (rdb$system_flag is null or rdb$system_flag = 0) ',
              ' and (rdb$relation_name=:rdb$relation_name); '
      ));
      ParamByName('rdb$relation_name').AsString := Tabela;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    Base.FinalizaQuery(Lc_Qry);
  End;
end;

procedure TGenericEntity.InsertData;
begin

end;

procedure TGenericEntity.RunScript(Script: String);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := Base.GeraQuery;
  try
    with Lc_Qry do
    Begin
      try
        SQL.Clear;
        SQL.Add(Script);
        Prepare;
        ExecSQL;
        if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Commit;
      EXCEPT
        if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Rollback;
      END;
    end;
  finally
    Base.FinalizaQuery(Lc_Qry);
  end;

end;

end.

