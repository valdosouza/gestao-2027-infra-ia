unit ControllerIbscbsMono;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbsMono, Md5, STQuery;

Type
  TControllerIbscbsMono = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbsMono;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerIbscbsMono }

constructor TControllerIbscbsMono.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbsMono.Create;
end;

destructor TControllerIbscbsMono.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbscbsMono.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsMono.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsMono.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsMono.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

