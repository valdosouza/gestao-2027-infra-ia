unit tblIbscbsTribcompraGov;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_TRIBCOMPRA_GOV')]
  TIbscbsTribcompraGov = class(TGenericEntity)
  private
    FVtribibsmun: Double;
    FVtribibsuf: Double;
    FPaliqcbs: Double;
    FPaliqibsmun: Double;
    FPaliqibsuf: Double;
    FIbscbsId: Integer;
    FVtribcbs: Double;
    procedure setFIbscbsId(const Value: Integer);
    procedure setFPaliqcbs(const Value: Double);
    procedure setFPaliqibsmun(const Value: Double);
    procedure setFPaliqibsuf(const Value: Double);
    procedure setFVtribcbs(const Value: Double);
    procedure setFVtribibsmun(const Value: Double);
    procedure setFVtribibsuf(const Value: Double);

  public
    [KeyField('TB_IBSCBS_ID')]
    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('PALIQIBSUF')]
    property Paliqibsuf: Double read FPaliqibsuf write setFPaliqibsuf;

    [FieldName('VTRIBIBSUF')]
    property Vtribibsuf: Double read FVtribibsuf write setFVtribibsuf;

    [FieldName('PALIQIBSMUN')]
    property Paliqibsmun: Double read FPaliqibsmun write setFPaliqibsmun;

    [FieldName('VTRIBIBSMUN')]
    property Vtribibsmun: Double read FVtribibsmun write setFVtribibsmun;

    [FieldName('PALIQCBS')]
    property Paliqcbs: Double read FPaliqcbs write setFPaliqcbs;

    [FieldName('VTRIBCBS')]
    property Vtribcbs: Double read FVtribcbs write setFVtribcbs;
  end;

implementation

{ TIbscbsTribcompraGov }

procedure TIbscbsTribcompraGov.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbscbsTribcompraGov.setFPaliqcbs(const Value: Double);
begin
  FPaliqcbs := Value;
end;

procedure TIbscbsTribcompraGov.setFPaliqibsmun(const Value: Double);
begin
  FPaliqibsmun := Value;
end;

procedure TIbscbsTribcompraGov.setFPaliqibsuf(const Value: Double);
begin
  FPaliqibsuf := Value;
end;

procedure TIbscbsTribcompraGov.setFVtribcbs(const Value: Double);
begin
  FVtribcbs := Value;
end;

procedure TIbscbsTribcompraGov.setFVtribibsmun(const Value: Double);
begin
  FVtribibsmun := Value;
end;

procedure TIbscbsTribcompraGov.setFVtribibsuf(const Value: Double);
begin
  FVtribibsuf := Value;
end;

end.
