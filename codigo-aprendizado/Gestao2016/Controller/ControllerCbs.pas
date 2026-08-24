unit ControllerCbs;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblCbs, Md5, STQuery, ControllerIbsCbsRed, ControllerIbsCbsDif, ControllerIbsCbsDevTrib;

Type
  TControllerCbs = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TCbs;
    Red : TControllerIbsCbsRed;
    Dif : TControllerIbsCbsDif;
    DevTrib : TControllerIbsCbsDevtrib;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure getByIbsCbs;
    procedure getAll;
    procedure deleteAll;
    procedure deleteByIBSCS;
  end;

implementation

{ TControllerCbs }

constructor TControllerCbs.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCbs.Create;
  Red := TControllerIbsCbsRed.Create(self);
  Dif := TControllerIbsCbsDif.Create(self);
  DevTrib := TControllerIbsCbsDevtrib.Create(self);
end;

destructor TControllerCbs.Destroy;
begin
  FreeAndNil( Red );
  FreeAndNil( Dif );
  FreeAndNil( DevTrib );
  FreeAndNil( Registro );
  inherited;
end;

function TControllerCbs.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerCbs.deleteAll;
begin
  Red.Registro.IBSCBS_ID := Registro.IbscbsId;
  Red.Registro.Tipo   := 'CBS';
  Red.deleteByIBSCS;

  Dif.Registro.IBSCBS_ID := Registro.IbscbsId;
  Dif.Registro.Tipo   := 'CBS';
  Dif.deleteByIBSCS;

  DevTrib.Registro.IBSCBS_ID := Registro.IbscbsId;
  DevTrib.Registro.Tipo   := 'CBS';
  DevTrib.deleteByIBSCS;

  deleteByIBSCS;
end;

procedure TControllerCbs.deleteByIBSCS;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE '+
              'FROM TB_CBS  '+
              ' WHERE TB_IBSCBS_ID =:TB_IBSCBS_ID ');
      ParamByName('TB_IBSCBS_ID').AsInteger := Registro.IbscbsId;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

function TControllerCbs.insert: Boolean;
begin
  Result := True;
  try
    if (Registro.Codigo = 0) then
      Registro.Codigo := getNextByField(Registro,'ID',0);
    InsertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerCbs.save: Boolean;
begin
  Result := True;
  try
    if (Registro.Codigo = 0) then
      Registro.Codigo := getNextByField(Registro,'ID',0);
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerCbs.getAll;
begin
  getByIbsCbs;

  Red.Registro.LinkID := Registro.Codigo;
  Red.Registro.Tipo := 'CBS';
  Red.Registro.IBSCBS_ID := Registro.IbscbsId;
  Red.getByKey;

  Dif.Registro.LinkID := Registro.Codigo;
  Dif.Registro.Tipo := 'CBS';
  Dif.Registro.IBSCBS_ID := Registro.IbscbsId;
  Dif.getByKey;

  DevTrib.Registro.LinkID := Registro.Codigo;
  DevTrib.Registro.Tipo := 'CBS';
  DevTrib.Registro.IBSCBS_ID := Registro.IbscbsId;
  DevTrib.getByKey;

end;

procedure TControllerCbs.getByIbsCbs;
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
              'FROM TB_CBS ',
              'WHERE ( TB_IBSCBS_ID =:TB_IBSCBS_ID )'
      ));
      ParamByName('TB_IBSCBS_ID').AsInteger := Registro.IbscbsId;
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

function TControllerCbs.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

