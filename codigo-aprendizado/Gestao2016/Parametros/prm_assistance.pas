unit prm_assistance;

interface

uses
      prm_dsk_base, tblAssistencia, System.SysUtils;

Type
  TPrmAssistance = class(TPrmDskBase)
  private
    FFieldName: TAssistencia;
    procedure setFFieldName(const Value: TAssistencia);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TAssistencia read FFieldName write setFFieldName;
  end;

implementation

{ TPrmAssistance }

procedure TPrmAssistance.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmAssistance.Create;
begin
  FFieldName := TAssistencia.Create;
end;

destructor TPrmAssistance.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmAssistance.setFFieldName(const Value: TAssistencia);
begin
  FFieldName := Value;
end;

end.
