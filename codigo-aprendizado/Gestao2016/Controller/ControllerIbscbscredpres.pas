unit ControllerIbscbscredpres;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbscredpres, Md5, STQuery;

Type
  TControllerIbscbscredpres = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbscredpres;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerIbscbscredpres }

constructor TControllerIbscbscredpres.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbscredpres.Create;
end;

destructor TControllerIbscbscredpres.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbscbscredpres.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbscredpres.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbscredpres.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbscredpres.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

