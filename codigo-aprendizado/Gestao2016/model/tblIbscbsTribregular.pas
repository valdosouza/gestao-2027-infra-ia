unit tblIbscbsTribregular;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_TRIBREGULAR')]
  TIbscbsTribregular = class(TGenericEntity)
  private
    FPaliqefetregcbs: Double;
    FPaliqefetregibsmun: Double;
    FPaliqefetregibsuf: Double;
    FCstreg: String;
    FVtribregcbs: Double;
    FVtribregibsmun: Double;
    FVtribregibsuf: Double;
    FIbscbsId: Integer;
    FCclasstribreg: String;
    procedure setFCclasstribreg(const Value: String);
    procedure setFCstreg(const Value: String);
    procedure setFIbscbsId(const Value: Integer);
    procedure setFPaliqefetregcbs(const Value: Double);
    procedure setFPaliqefetregibsmun(const Value: Double);
    procedure setFPaliqefetregibsuf(const Value: Double);
    procedure setFVtribregcbs(const Value: Double);
    procedure setFVtribregibsmun(const Value: Double);
    procedure setFVtribregibsuf(const Value: Double);

  public
    [KeyField('TB_IBSCBS_ID')]
    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('CSTREG')]
    property Cstreg: String read FCstreg write setFCstreg;

    [FieldName('CCLASSTRIBREG')]
    property Cclasstribreg: String read FCclasstribreg write setFCclasstribreg;

    [FieldName('PALIQEFETREGIBSUF')]
    property Paliqefetregibsuf: Double read FPaliqefetregibsuf write setFPaliqefetregibsuf;

    [FieldName('VTRIBREGIBSUF')]
    property Vtribregibsuf: Double read FVtribregibsuf write setFVtribregibsuf;

    [FieldName('PALIQEFETREGIBSMUN')]
    property Paliqefetregibsmun: Double read FPaliqefetregibsmun write setFPaliqefetregibsmun;

    [FieldName('VTRIBREGIBSMUN')]
    property Vtribregibsmun: Double read FVtribregibsmun write setFVtribregibsmun;

    [FieldName('PALIQEFETREGCBS')]
    property Paliqefetregcbs: Double read FPaliqefetregcbs write setFPaliqefetregcbs;

    [FieldName('VTRIBREGCBS')]
    property Vtribregcbs: Double read FVtribregcbs write setFVtribregcbs;
  end;

implementation

{ TIbscbsTribregular }

procedure TIbscbsTribregular.setFCclasstribreg(const Value: String);
begin
  FCclasstribreg := Value;
end;

procedure TIbscbsTribregular.setFCstreg(const Value: String);
begin
  FCstreg := Value;
end;

procedure TIbscbsTribregular.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbscbsTribregular.setFPaliqefetregcbs(const Value: Double);
begin
  FPaliqefetregcbs := Value;
end;

procedure TIbscbsTribregular.setFPaliqefetregibsmun(const Value: Double);
begin
  FPaliqefetregibsmun := Value;
end;

procedure TIbscbsTribregular.setFPaliqefetregibsuf(const Value: Double);
begin
  FPaliqefetregibsuf := Value;
end;

procedure TIbscbsTribregular.setFVtribregcbs(const Value: Double);
begin
  FVtribregcbs := Value;
end;

procedure TIbscbsTribregular.setFVtribregibsmun(const Value: Double);
begin
  FVtribregibsmun := Value;
end;

procedure TIbscbsTribregular.setFVtribregibsuf(const Value: Double);
begin
  FVtribregibsuf := Value;
end;

end.
