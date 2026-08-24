unit ControllerIbsCbsDevTrib;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, TblIbsCbsDevTrib, Md5, STQuery;

type
  TControllerIbsCbsDevTrib = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbsCbsDevtrib;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure deleteByIBSCS;
  end;

implementation

{ TControllerIbsCbsDevTrib }

constructor TControllerIbsCbsDevTrib.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbsCbsDevtrib.Create;
end;

destructor TControllerIbsCbsDevTrib.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbsCbsDevTrib.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerIbsCbsDevTrib.deleteByIBSCS;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE '+
              'FROM TB_IBSCBS_DEVTRIB  '+
              ' WHERE TB_IBSCBS_ID =:TB_IBSCBS_ID '+
              ' and (LINK_KIND=:LINK_KIND) ');
      ParamByName('LINK_KIND').AsString     := Registro.Tipo;
      ParamByName('TB_IBSCBS_ID').AsInteger := Registro.IBSCBS_ID;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

function TControllerIbsCbsDevTrib.insert: Boolean;
begin
  Result := True;
  try
    InsertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbsCbsDevTrib.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbsCbsDevTrib.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;


end.

