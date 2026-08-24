unit ControllerIbsCbsRed;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, TblIbsCbsRed, Md5, STQuery;

type
  TControllerIbsCbsRed = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbsCbsRed;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure deleteByIBSCS;
  end;

implementation

{ TControllerIbsCbsRed }

constructor TControllerIbsCbsRed.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbsCbsRed.Create;
end;

destructor TControllerIbsCbsRed.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbsCbsRed.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerIbsCbsRed.deleteByIBSCS;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE '+
              'FROM TB_IBSCBS_RED '+
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

function TControllerIbsCbsRed.insert: Boolean;
begin
  Result := True;
  try
    InsertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbsCbsRed.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbsCbsRed.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;


end.

