unit ControllerIbsMun;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbsMun, Md5, STQuery, ControllerIbsCbsRed, ControllerIbsCbsDif, ControllerIbsCbsDevTrib;

type
  TControllerIbsMun = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbsMun;
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

{ TControllerIbsMun }

constructor TControllerIbsMun.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbsMun.Create;
  Red := TControllerIbsCbsRed.Create(self);
  Dif := TControllerIbsCbsDif.Create(self);
  DevTrib := TControllerIbsCbsDevtrib.Create(self);

end;

destructor TControllerIbsMun.Destroy;
begin
  FreeAndNil( Red );
  FreeAndNil( Dif );
  FreeAndNil( DevTrib );
  FreeAndNil( Registro);
  inherited;
end;

function TControllerIbsMun.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerIbsMun.deleteAll;
begin
  Red.Registro.IBSCBS_ID := Registro.IbscbsId;
  Red.Registro.Tipo   := 'MUN';
  Red.deleteByIBSCS;

  Dif.Registro.IBSCBS_ID := Registro.IbscbsId;
  Dif.Registro.Tipo   := 'MUN';
  Dif.deleteByIBSCS;

  DevTrib.Registro.IBSCBS_ID := Registro.IbscbsId;
  DevTrib.Registro.Tipo   := 'MUN';
  DevTrib.deleteByIBSCS;

  deleteByIBSCS;
end;

procedure TControllerIbsMun.deleteByIBSCS;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE '+
              'FROM TB_IBS_MUN '+
              ' WHERE TB_IBSCBS_ID =:TB_IBSCBS_ID ');
      ParamByName('TB_IBSCBS_ID').AsInteger := Registro.IbscbsId;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

function TControllerIbsMun.insert: Boolean;
begin
  Result := True;
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'ID',0);
    InsertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbsMun.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerIbsMun.getAll;
begin
  getByIbsCbs;

  Red.Registro.LinkID := Registro.Codigo;
  Red.Registro.Tipo := 'MUN';
  Red.Registro.IBSCBS_ID := Registro.IbscbsId;
  Red.getByKey;

  Dif.Registro.LinkID := Registro.Codigo;
  Dif.Registro.Tipo := 'MUN';
  Dif.Registro.IBSCBS_ID := Registro.IbscbsId;
  Dif.getByKey;

  DevTrib.Registro.LinkID := Registro.Codigo;
  DevTrib.Registro.Tipo := 'MUN';
  DevTrib.Registro.IBSCBS_ID := Registro.IbscbsId;
  DevTrib.getByKey;
end;

procedure TControllerIbsMun.getByIbsCbs;
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
              'FROM TB_IBS_MUN ',
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

function TControllerIbsMun.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

