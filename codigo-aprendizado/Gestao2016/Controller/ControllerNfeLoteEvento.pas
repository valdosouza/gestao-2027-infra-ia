unit ControllerNfeLoteEvento;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblNfeLoteEvento, Md5, STQuery;

Type
  TControllerNfeLoteEvento = class(TControllerBase)
  private
    Registro: TNfeLoteEvento;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerNfeLoteEvento }

constructor TControllerNfeLoteEvento.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNfeLoteEvento.Create;
end;

Destructor TControllerNfeLoteEvento.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerNfeLoteEvento.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerNfeLoteEvento.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerNfeLoteEvento.delete: Boolean;
begin
  Result := True;
  try
    DeleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerNfeLoteEvento.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

