unit ControllerIbscbsCbscredpres;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbsCbscredpres, Md5, STQuery;

Type
  TControllerIbscbsCbscredpres = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbsCbscredpres;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerIbscbsCbscredpres }

constructor TControllerIbscbsCbscredpres.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbsCbscredpres.Create;
end;

destructor TControllerIbscbsCbscredpres.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbscbsCbscredpres.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsCbscredpres.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsCbscredpres.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsCbscredpres.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

