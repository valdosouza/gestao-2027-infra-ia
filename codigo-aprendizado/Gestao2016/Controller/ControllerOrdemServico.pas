unit ControllerOrdemServico;

interface

uses     STDatabase, STQuery, Classes, SysUtils, ControllerBase, tblOrdemServico, Md5, prm_ordem_servico;

Type
  TControllerOrdemServico = Class(TControllerBase)
  private
    FParametros: TOrdemServico;
    procedure setFParametros(const Value: TOrdemServico);
  public
    Registro : TOrdemServico;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getById:Boolean;
    property Parametros : TOrdemServico read FParametros write setFParametros;

  End;

implementation

{ TControllerOrdemServico }

constructor TControllerOrdemServico.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TOrdemServico.Create;
end;

function TControllerOrdemServico.delete: boolean;
begin
  deleteObj(Registro);
end;

destructor TControllerOrdemServico.Destroy;
begin
  FreeAndNil( Registro );
  inherited;
end;

function TControllerOrdemServico.getById: Boolean;
begin
  _getByKey(Registro);
end;

function TControllerOrdemServico.insert: boolean;
begin
  if ( Registro.Codigo = 0) then
    Registro.Codigo := Generator('GN_ORDEMSERVICO');
  insertObj(Registro);
end;

function TControllerOrdemServico.save: boolean;
begin
  if ( Registro.Codigo = 0) then
    Registro.Codigo := Generator('GN_ORDEMSERVICO');
  SaveObj(Registro);
end;

procedure TControllerOrdemServico.setFParametros(const Value: TOrdemServico);
begin
  FParametros := Value;
end;

end.
