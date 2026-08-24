unit ControllerIbscbsTribcompraGov;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbsTribcompraGov, Md5, STQuery;

Type
  TControllerIbscbsTribcompraGov = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbsTribcompraGov;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerIbscbsTribcompraGov }

constructor TControllerIbscbsTribcompraGov.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbsTribcompraGov.Create;
end;

destructor TControllerIbscbsTribcompraGov.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbscbsTribcompraGov.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTribcompraGov.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTribcompraGov.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTribcompraGov.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

