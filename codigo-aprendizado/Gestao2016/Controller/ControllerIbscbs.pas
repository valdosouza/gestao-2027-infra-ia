unit ControllerIbscbs;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbs, Md5, STQuery, System.Generics.Collections, ControllerIbsUf, ControllerIbsMun, ControllerCbs, ControllerIbscbsTribregular, ControllerIbscbscredpres, ControllerIbscbsTribcompraGov, ControllerIbscbsMono, ControllerIbscbsTransfcred, ControllerIbscbsCredpresIbszfm;
Type
  TListaIbscbs = TObjectList<TIbscbs>;
  TControllerIbscbs = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbs;
    Lista : TListaIbscbs;
    IbsUF : TControllerIbsUf;
    IbsMUN : TControllerIbsMun;
    CBS : TControllerCbs;
    Tribregular : TControllerIbscbsTribregular;
    Credpres : TControllerIbscbscredpres;
    TribcompraGov : TControllerIbscbsTribcompraGov;
    Mono : TControllerIbscbsMono;
    Transfcred : TControllerIbscbsTransfcred;
    CredpresIbszfm : TControllerIbscbsCredpresIbszfm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure getByItemNF;
    procedure getAll;
    procedure deleteByNF;
    procedure deleteAllByNF;
    procedure getlistByNF;
  end;

implementation

{ TControllerIbscbs }

constructor TControllerIbscbs.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbs.Create;
  IbsUF := TControllerIbsUf.Create(Self);
  IbsMUN := TControllerIbsMun.Create(Self);
  CBS := TControllerCbs.Create(Self);
  Tribregular := TControllerIbscbsTribregular.Create(Self);
  Credpres := TControllerIbscbscredpres.Create(Self);
  TribcompraGov := TControllerIbscbsTribcompraGov.Create(Self);
  Mono := TControllerIbscbsMono.Create(Self);
  Transfcred := TControllerIbscbsTransfcred.Create(Self);
  CredpresIbszfm := TControllerIbscbsCredpresIbszfm.Create(Self);
  Lista := TListaIbscbs.create;
end;

function TControllerIbscbs.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerIbscbs.deleteAllByNF;
var
  I: Integer;
begin
  getlistByNF;
  for I := 0 to Lista.Count -1 do
  Begin
    IbsUF.Registro.IbscbsId := Lista[I].Codigo;
    IbsUF.deleteAll;

    IbsMUN.Registro.IbscbsId := Lista[I].Codigo;
    IbsMUN.deleteaLL;

    CBS.Registro.IbscbsId := Lista[I].Codigo;
    CBS.deleteAll;

    Tribregular.Registro.IbscbsId := Lista[I].Codigo;
    Tribregular.delete;

    Credpres.Registro.IbscbsId := Lista[I].Codigo;
    Credpres.delete;

    TribcompraGov.Registro.IbscbsId := Lista[I].Codigo;
    TribcompraGov.delete;

    Mono.Registro.IbscbsId := Lista[I].Codigo;
    Mono.delete;

    Transfcred.Registro.IbscbsId := Lista[I].Codigo;
    Transfcred.delete;

    CredpresIbszfm.Registro.IbscbsId := Lista[I].Codigo;
    CredpresIbszfm.delete;
  End;
  deleteByNF;
end;

procedure TControllerIbscbs.deleteByNF;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE '+
              'FROM TB_IBSCBS '+
              ' WHERE CODNFL =:NFL_CODIGO ');
      ParamByName('NFL_CODIGO').AsInteger := Registro.nota;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

destructor TControllerIbscbs.Destroy;
begin
  FreeAndNil( Lista );
  FreeAndNil( CredpresIbszfm );
  FreeAndNil( Transfcred );
  FreeAndNil( Mono );
  FreeAndNil( TribcompraGov );
  FreeAndNil( Credpres );
  FreeAndNil( Tribregular );
  FreeAndNil( CBS );
  FreeAndNil( IbsMUN );
  FreeAndNil( IbsUF );
  FreeAndNil( Registro );
  inherited;
end;

function TControllerIbscbs.insert: Boolean;
begin
  Result := True;
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'ID',0);
    insertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbs.save: Boolean;
begin
  Result := True;
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'ID',0);
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerIbscbs.getAll;
begin
  getByItemNF;

  IbsUF.Registro.IbscbsId := Registro.Codigo;
  IbsUF.getAll;

  IbsMUN.Registro.IbscbsId := Registro.Codigo;
  IbsMUN.getAll;

  CBS.Registro.IbscbsId := Registro.Codigo;
  CBS.getAll;

  Tribregular.Registro.IbscbsId := Registro.Codigo;
  Tribregular.getByKey;

  //Credpres
  //TribcompraGov
  //Mono
  //Transfcred
  //CredpresIbszfm
end;

procedure TControllerIbscbs.getByItemNF;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add(concat(
              'SELECT * ',
              'FROM TB_IBSCBS ',
              'WHERE ( CODNFL =:CODNFL ) ',
              ' AND (CODITF =:CODITF )'
      ));
      ParamByName('CODNFL').AsInteger := Registro.nota;
      ParamByName('CODITF').AsInteger := Registro.ItemNF;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerIbscbs.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

procedure TControllerIbscbs.getlistByNF;
var
  Lc_Qry : TSTQuery;
  LITem : TIBSCBS;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IBSCBS ',
                      'WHERE CODNFL=:NFL_CODIGO '));

      ParamByName('NFL_CODIGO').AsInteger := Registro.Nota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIBSCBS.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

end.

