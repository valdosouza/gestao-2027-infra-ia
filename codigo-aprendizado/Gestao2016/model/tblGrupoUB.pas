unit GrupoUB;

interface

uses
      GenericEntity, CAtribEntity, ImpostoSeletivo, IBSCBS;

type
  [TableName('TB_GRUPO_UB')]
  TGrupoUB = class(TGenericEntity)
  private
    FImpostoSeletivo: TImpostoSeletivo;
    FIBSCBS: TIBSCBS;

    procedure setFImpostoSeletivo(const Value: TImpostoSeletivo);
    procedure setFIBSCBS(const Value: TIBSCBS);

  public
    constructor Create;
    destructor Destroy; override;

    property ImpostoSeletivo: TImpostoSeletivo read FImpostoSeletivo write setFImpostoSeletivo;
    property IBSCBS: TIBSCBS read FIBSCBS write setFIBSCBS;
  end;

implementation

{ TGrupoUB }

constructor TGrupoUB.Create;
begin
  inherited Create;
  FImpostoSeletivo := TImpostoSeletivo.Create;
  FIBSCBS          := TIBSCBS.Create;
end;

destructor TGrupoUB.Destroy;
begin
  FImpostoSeletivo.Free;
  FIBSCBS.Free;
  inherited Destroy;
end;

procedure TGrupoUB.setFImpostoSeletivo(const Value: TImpostoSeletivo);
begin

end;

procedure TGrupoUB.setFIBSCBS(const Value: TIBSCBS);
begin

end;

end.


