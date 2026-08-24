unit TblCBS;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_CBS')]
  TCBS = Class(TGenericEntity)
  private
    FPCBS: Double;
    FVCBS: Double;
    FID: Integer;
    FIbscbsId: Integer;
    procedure setFIbscbsId(const Value: Integer);
    procedure setFID(const Value: Integer);
    procedure setFPCBS(const Value: Double);
    procedure setFVCBS(const Value: Double);
  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('PCBS')]
    property Pcbs: Double read FPCBS write setFPCBS;

    [FieldName('VCBS')]
    property Vcbs: Double read FVCBS write setFVCBS;

  End;

implementation

{ TCBS }

procedure TCBS.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TCBS.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCBS.setFPCBS(const Value: Double);
begin
  FPCBS := Value;
end;

procedure TCBS.setFVCBS(const Value: Double);
begin
  FVCBS := Value;
end;

end.
