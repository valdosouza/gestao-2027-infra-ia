unit ControllerIbscbsCredpresIbszfm;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbsCredpresIbszfm, Md5, STQuery;

Type
  TControllerIbscbsCredpresIbszfm = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbsCredpresIbszfm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerIbscbsCredpresIbszfm }

constructor TControllerIbscbsCredpresIbszfm.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbsCredpresIbszfm.Create;
end;

destructor TControllerIbscbsCredpresIbszfm.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbscbsCredpresIbszfm.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsCredpresIbszfm.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsCredpresIbszfm.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsCredpresIbszfm.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

