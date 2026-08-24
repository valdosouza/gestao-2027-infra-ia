unit ControllerDfeResumoEvento;

interface

uses
      System.Classes, System.SysUtils, System.Generics.Collections, STDatabase, STQuery, ControllerBase, tblDfeResumoEvento;

type
  TListaDfeResumoEvento = TObjectList<TDfeResumoEvento>;

  TControllerDfeResumoEvento = class(TControllerBase)
  private

  public
    Registro: TDfeResumoEvento;
    Lista: TListaDfeResumoEvento;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;

    function Insert: Boolean;
    function Update: Boolean;
    function Save: Boolean;
    function Delete: Boolean;
  end;

implementation

{ TControllerDfeResumoEvento }

procedure TControllerDfeResumoEvento.Clear;
begin
  FreeAndNil(Registro);
  Registro := TDfeResumoEvento.Create;
end;

constructor TControllerDfeResumoEvento.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDfeResumoEvento.Create;
  Lista    := TListaDfeResumoEvento.Create;
end;

function TControllerDfeResumoEvento.Delete: Boolean;
begin
  Result := True;
  deleteObj(Registro);
end;

destructor TControllerDfeResumoEvento.Destroy;
begin
  Lista.Free;
  Registro.Free;
  inherited;
end;


function TControllerDfeResumoEvento.Insert: Boolean;
begin
  Result := False;
  insertObj(Registro);
end;

function TControllerDfeResumoEvento.Save: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerDfeResumoEvento.Update: Boolean;
begin
  Result := True;
  updateObj(Registro);
end;

end.
