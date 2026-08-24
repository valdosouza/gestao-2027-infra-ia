unit ControllerIbsCbsDif;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, TblIbsCbsDif, Md5, STQuery;

type
  TControllerIbsCbsDif = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbsCbsDif;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure deleteByIBSCS;
  end;

implementation

{ TControllerIbsCbsDif }

constructor TControllerIbsCbsDif.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbsCbsDif.Create;
end;

destructor TControllerIbsCbsDif.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbsCbsDif.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerIbsCbsDif.deleteByIBSCS;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE '+
              'FROM TB_IBSCBS_DIF '+
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

function TControllerIbsCbsDif.insert: Boolean;
begin
  Result := True;
  try
    InsertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbsCbsDif.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbsCbsDif.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;


end.

