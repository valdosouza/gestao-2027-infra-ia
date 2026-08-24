unit ControllerFolhaPagto;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblFolhaPAgto, prm_package;

Type
  TControllerFolhaPagto = Class(TControllerBase)

  private

  public
    Registro : TFolhaPAgto;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    Function delete:boolean;
    procedure clear;
  End;


implementation

{ TControllerFolhaPagto }

procedure TControllerFolhaPagto.clear;
begin
  clearObj(Registro);
end;

constructor TControllerFolhaPagto.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFolhaPagto.Create;
end;

function TControllerFolhaPagto.delete: boolean;
begin
  deleteObj(Registro);
end;

destructor TControllerFolhaPagto.Destroy;
begin
  FreeAndNil( Registro);
  inherited;
end;

procedure TControllerFolhaPagto.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerFolhaPagto.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_FLHPAGTO');
  insertObj(Registro);
end;

function TControllerFolhaPagto.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerFolhaPagto.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_FLHPAGTO');
  saveObj(Registro);
end;

function TControllerFolhaPagto.update: boolean;
begin
  updateObj(Registro);
end;

end.
