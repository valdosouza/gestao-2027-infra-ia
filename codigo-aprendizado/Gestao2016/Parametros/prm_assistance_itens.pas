unit prm_assistance_itens;

interface

uses
      prm_dsk_base, tblAssistenciaItens, System.SysUtils;

Type
  TPrmAssistanceItens = class(TPrmDskBase)
  private
    FFieldName: TAssistenciaItens;
    procedure setFFieldName(const Value: TAssistenciaItens);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TAssistenciaItens read FFieldName write setFFieldName;
  end;

implementation

{ TPrmAssistanceItens }

procedure TPrmAssistanceItens.Clear;
begin
  clearObj(FFieldName);
end;

constructor TPrmAssistanceItens.Create;
begin
  FFieldName := TAssistenciaItens.Create;
end;

destructor TPrmAssistanceItens.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmAssistanceItens.setFFieldName(const Value: TAssistenciaItens);
begin
  FFieldName := Value;
end;

end.
