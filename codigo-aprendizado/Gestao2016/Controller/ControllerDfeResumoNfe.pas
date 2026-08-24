unit ControllerDfeResumoNfe;

interface

uses
      System.Classes, System.SysUtils, System.Generics.Collections, STDatabase, STQuery, ControllerBase, tblDfeResumoNfe;

type
  TListaDfeResumoNfe = TObjectList<TDfeResumoNfe>;

  TControllerDfeResumoNfe = class(TControllerBase)
  private

  public
    Registro: TDfeResumoNfe;
    Lista: TListaDfeResumoNfe;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;

    function Insert: Boolean;
    function Update: Boolean;
    function Save: Boolean;
    function Delete: Boolean;

  end;

implementation

{ TControllerDfeResumoNfe }

procedure TControllerDfeResumoNfe.Clear;
begin
  FreeAndNil(Registro);
  Registro := TDfeResumoNfe.Create;
end;

constructor TControllerDfeResumoNfe.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDfeResumoNfe.Create;
  Lista    := TListaDfeResumoNfe.Create;
end;

function TControllerDfeResumoNfe.Delete: Boolean;
begin
  Result := True;
  deleteObj(Registro);
end;

destructor TControllerDfeResumoNfe.Destroy;
begin
  Lista.Free;
  Registro.Free;
  inherited;
end;


function TControllerDfeResumoNfe.Insert: Boolean;
begin
  Result := True;
  insertObj(Registro);
end;

function TControllerDfeResumoNfe.Save: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerDfeResumoNfe.Update: Boolean;
begin
  Result := True;
  updateObj(Registro);
end;

end.

