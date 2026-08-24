unit ControllerRetaguarda;

interface
uses     STDatabase, Classes, SysUtils, ControllerBase, tblRetaguarda, Generics.Collections, STQuery, ControllerRetaguardaSync, ControllerTrigger;


Type

  TControllerRetaguarda = Class(TControllerBase)
  private
    FBancoRetaguarda: TSTDatabase;
    FBancoPDV: TSTDatabase;
    FConectado: Boolean;

    procedure recebeDados;
    procedure EnviaDados;

    procedure setFBancoPDV(const Value: TSTDatabase);
    procedure execSQL(Qry:TSTQuery);
  public
    Registro : TRetaguarda;
    RetaguardaSync :TControllerRetaguardaSync;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateTrigguer;
    function save:boolean;
    function insert:boolean;
    function update:boolean;
    procedure getFirst;
    Function delete:boolean;
    Function ConfiguraBancoRetaguarda:Boolean;
    function ValidaConexaoRetaguarda:Boolean;
    procedure IniciaSincronia;
    function DevePararSync: Boolean;
    property BancoPDV : TSTDatabase read FBancoPDV write setFBancoPDV;
  End;

implementation

{ TControllerRetaguarda }

uses     un_sistema, Un_Regra_Negocio, System.SyncObjs;

Var
  //Garante que apenas uma sincronia de retaguarda execute por vez no
  //processo, mesmo que existam multiplas instancias do controller
  SincroniaLock: TCriticalSection;
function  TControllerRetaguarda.ConfiguraBancoRetaguarda:Boolean;
begin
  // Reutiliza conexao existente; reconecta apenas se necessario
  if FConectado and FBancoRetaguarda.Connected then
  begin
    Result := True;
    Exit;
  end;

  getFirst;
  FBancoRetaguarda.Connected := False;
  FConectado := False;

  if Registro.CaminhoBancoDados = '' then
  begin
    Result := False;
    Exit;
  end;

  with FBancoRetaguarda do
  begin
    LoginPrompt := False;
    Params.Clear;
    Params.add('user_name=SYSDBA');
    Params.add('password=masterkey');
    Params.add('lc_ctype=WIN1252');
    DatabaseName := Registro.CaminhoBancoDados;
  end;

  Try
    FBancoRetaguarda.Connected := True;
    FConectado := True;
    Result := True;
  Except
    FBancoRetaguarda.Connected := False;
    FConectado := False;
    Result := False;
  End;
end;

constructor TControllerRetaguarda.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetaguarda.Create;
  FBancoRetaguarda := TSTDatabase.Create(self);
  FConectado := False;
  //Essa variavel e passada via referencia
  //FBancoPDV        := TSTDatabase.Create(self);
  RetaguardaSync := TControllerRetaguardaSync.Create(self);
end;

procedure TControllerRetaguarda.CreateTrigguer;
Var
  Lc_Qry : TSTQuery;
  LcListaTrigger : TControllerTrigger;
  I : Integer;
  LcInsertSincronia : String;
begin
  DataBase := FBancoRetaguarda;
  Lc_Qry := GeraQuery;
  LcListaTrigger := TControllerTrigger.Create(nil);
  LcListaTrigger.getlistretaguarda;
  LcInsertSincronia := ' INSERT INTO TB_SINCRONIA(SRC_CODIGO, SRC_TABELA, SRC_CHAVE, SRC_OPER,SRC_REGISTRO, SRC_TIME) VALUES( ';
  Try
    for I := 0 to LcListaTrigger.Lista.Count - 1 do
    Begin
      if Trim( LcListaTrigger.Lista[I].Tabela)<> '' then
      Begin
        Lc_Qry.sql.Clear;
        Lc_Qry.sql.Add(concat(
                'CREATE OR ALTER TRIGGER TG_SRC_DEL_',LcListaTrigger.Lista[I].Tabela, ' FOR TB_',LcListaTrigger.Lista[I].Tabela,
                ' ACTIVE AFTER DELETE POSITION 0 ',
                'AS begin ',LcInsertSincronia,'0,','''TB_',LcListaTrigger.Lista[I].Tabela,''',''',LcListaTrigger.Lista[I].Campo,''',''D'',OLD.',LcListaTrigger.Lista[I].Campo,',CURRENT_TIMESTAMP);end '
        ));
        execSQL(Lc_Qry);
        //UPDATE
        Lc_Qry.sql.Clear;
        Lc_Qry.sql.Add(concat(
                'CREATE OR ALTER TRIGGER TG_SRC_EDI_',LcListaTrigger.Lista[I].Tabela, ' FOR TB_',LcListaTrigger.Lista[I].Tabela,
                ' ACTIVE AFTER UPDATE POSITION 0 ',
                'AS begin ',LcInsertSincronia,'0,','''TB_',LcListaTrigger.Lista[I].Tabela,''',''',LcListaTrigger.Lista[I].Campo,''',''U'',OLD.',LcListaTrigger.Lista[I].Campo,',CURRENT_TIMESTAMP);end '
        ));
        execSQL(Lc_Qry);
        //insert
        Lc_Qry.sql.Clear;
        Lc_Qry.sql.Add(concat(
                'CREATE OR ALTER TRIGGER TG_SRC_INS_',LcListaTrigger.Lista[I].Tabela, ' FOR TB_',LcListaTrigger.Lista[I].Tabela,
                ' ACTIVE AFTER INSERT POSITION 0 ',
                'AS begin ',LcInsertSincronia,'0,','''TB_',LcListaTrigger.Lista[I].Tabela,''',''',LcListaTrigger.Lista[I].Campo,''',''I'',NEW.',LcListaTrigger.Lista[I].Campo,',CURRENT_TIMESTAMP);end '
        ));
        execSQL(Lc_Qry);
      End;
    End;
  Finally
    FreeAndNil(LcListaTrigger);
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerRetaguarda.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerRetaguarda.Destroy;
begin
  FreeAndNil(RetaguardaSync);
  if Assigned(FBancoRetaguarda) then
  begin
    FBancoRetaguarda.Close;
    if FBancoRetaguarda.Connected then
      FBancoRetaguarda.Close;
  end;
  FreeAndNil(FBancoRetaguarda);
  //Essa variavel e passada via referencia
  //FreeAndNil(FBancoPDV);

  FreeAndNil(Registro);
  inherited;
end;

procedure TControllerRetaguarda.EnviaDados;
begin
    RetaguardaSync.Send;
end;

procedure TControllerRetaguarda.execSQL(Qry: TSTQuery);
begin
  with Qry do
  Begin
    try
      Prepare;
      ExecSQL;
    except
      Unprepare;
      Close;
    end;
  End;
end;

function TControllerRetaguarda.save: boolean;
begin
  SaveObj(Registro);
end;


procedure TControllerRetaguarda.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

function TControllerRetaguarda.update: boolean;
begin
  UpdateObj(Registro);
end;

function TControllerRetaguarda.ValidaConexaoRetaguarda: Boolean;
begin
  try
    Result := ConfiguraBancoRetaguarda;
  except
    Result := False;
  end;
end;

procedure TControllerRetaguarda.getFirst;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT first 1 * ',
                      'FROM TB_RETAGUARDA '));
      Active := True;
      FetchAll;
      First;
      exist  := ( RecordCount > 0 );
      if exist then
      Begin
        clearObj(Registro);
        get(Lc_Qry,Registro) ;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerRetaguarda.DevePararSync: Boolean;
begin
  Result := False;
end;

procedure TControllerRetaguarda.IniciaSincronia;
begin
  //Se ja existe uma sincronia em andamento, pula este ciclo em vez de
  //concorrer com ela (evita conflito de update na TB_RETAGUARDA_SYNC)
  if not SincroniaLock.TryEnter then
    Exit;
  try
    if ConfiguraBancoRetaguarda then
    begin
      try
        recebeDados;
        EnviaDados;
      except
        // Forca reconexao no proximo ciclo se o banco falhar durante a sincronia
        FConectado := False;
        FBancoRetaguarda.Connected := False;
      end;
    end;
  finally
    SincroniaLock.Leave;
  end;
end;

function TControllerRetaguarda.insert: boolean;
begin
  insertObj(Registro);
end;

procedure TControllerRetaguarda.recebeDados;
begin
  RetaguardaSync.BancoRetaguarda  := Self.FBancoRetaguarda;
  RetaguardaSync.BancoPDV         := Self.FBancoPDV;
  RetaguardaSync.receive;
end;

initialization
  SincroniaLock := TCriticalSection.Create;

finalization
  FreeAndNil(SincroniaLock);

end.