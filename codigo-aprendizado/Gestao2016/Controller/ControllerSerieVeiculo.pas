unit ControllerSerieVeiculo;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblSerieVeiculo, prm_serie_veiculo;

Type
  TListaSerieVeiculo  = TObjectList<TSerieVeiculo>;

  TControllerSerieVeiculo = Class(TControllerBase)
  private
    FParametros: TPrmSerieVeiculo;
    procedure setFParametros(const Value: TPrmSerieVeiculo);

  public
    Registro : TSerieVeiculo;
    Lista : TListaSerieVeiculo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    function salva:boolean;
    Function delete:boolean;
    procedure clear;
    procedure Search;
    property Parametros : TPrmSerieVeiculo read FParametros write setFParametros;
  End;


implementation

{ TControllerSerieVeiculo }

procedure TControllerSerieVeiculo.clear;
begin

end;

constructor TControllerSerieVeiculo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSerieVeiculo.create;
  Lista := TListaSerieVeiculo.create;
  FParametros := TPrmSerieVeiculo.create;
end;

function TControllerSerieVeiculo.delete: boolean;
begin

end;

destructor TControllerSerieVeiculo.Destroy;
begin
  FreeAndNil( Registro );
  FreeAndNil( Lista );
  FreeAndNil( FParametros );
  inherited;
end;

procedure TControllerSerieVeiculo.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerSerieVeiculo.insert: boolean;
begin
  insertObj(Registro);
end;

function TControllerSerieVeiculo.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerSerieVeiculo.salva: boolean;
begin
  saveObj(Registro);
end;

procedure TControllerSerieVeiculo.Search;
begin

end;

procedure TControllerSerieVeiculo.setFParametros(const Value: TPrmSerieVeiculo);
begin
  FParametros := Value;
end;

function TControllerSerieVeiculo.update: boolean;
begin
  updateObj(Registro);
end;

end.
