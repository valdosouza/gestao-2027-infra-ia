unit ControllerNfEletronica;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblNfEletronica, prm_nf_eletronica;

Type

  TControllerNfEletronica = Class(TControllerBase)
  private
    FParametros: TPrmNfEletronica;
    procedure setFParametros(const Value: TPrmNfEletronica);
  public
    Registro : TNFEletronica;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure salva;
    procedure getbyId;
    procedure insert;
    procedure update;
    procedure delete;
    procedure clear;
    property Parametros : TPrmNfEletronica read FParametros write setFParametros;
  End;

implementation

{ TControllerNfEletronica }

procedure TControllerNfEletronica.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerNfEletronica.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNFEletronica.create;
  FParametros := TPrmNfEletronica.create;
end;

procedure TControllerNfEletronica.delete;
begin
  DeleteObj(Registro);
end;

destructor TControllerNfEletronica.Destroy;
begin
  FreeAndNil( Registro );
  FreeAndNil( FParametros );
  inherited;
end;

procedure TControllerNfEletronica.getbyId;
begin
  _getByKey(Registro);
end;

procedure TControllerNfEletronica.insert;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_NF_ELETRONICA');
  InsertObj(Registro);
end;

procedure TControllerNfEletronica.salva;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_NF_ELETRONICA');
  SaveObj(Registro);
end;

procedure TControllerNfEletronica.setFParametros(const Value: TPrmNfEletronica);
begin
  FParametros := Value;
end;

procedure TControllerNfEletronica.update;
begin
  UpdateObj(Registro);
end;

end.
