unit tblibsuf;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBS_UF')]
  TIbsUf = class(TGenericEntity)
  private
    FPibsuf: Double;
    FVibsuf: Double;
    FGdif: Double;
    FVdevtrib: Double;
    FId: Integer;
    FIbscbsId: Integer;
    FGred: Double;
    procedure setFGdif(const Value: Double);
    procedure setFGred(const Value: Double);
    procedure setFIbscbsId(const Value: Integer);
    procedure setFId(const Value: Integer);
    procedure setFPibsuf(const Value: Double);
    procedure setFVdevtrib(const Value: Double);
    procedure setFVibsuf(const Value: Double);
  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('PIBSUF')]
    property Pibsuf: Double read FPibsuf write setFPibsuf;


    [FieldName('VIBSUF')]
    property Vibsuf: Double read FVibsuf write setFVibsuf;
  end;

implementation

{ TIbsUf }

procedure TIbsUf.setFGdif(const Value: Double);
begin
  FGdif := Value;
end;

procedure TIbsUf.setFGred(const Value: Double);
begin
  FGred := Value;
end;

procedure TIbsUf.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbsUf.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TIbsUf.setFPibsuf(const Value: Double);
begin
  FPibsuf := Value;
end;

procedure TIbsUf.setFVdevtrib(const Value: Double);
begin
  FVdevtrib := Value;
end;

procedure TIbsUf.setFVibsuf(const Value: Double);
begin
  FVibsuf := Value;
end;

end.
