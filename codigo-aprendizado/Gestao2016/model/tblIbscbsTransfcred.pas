unit tblIbscbsTransfcred;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_TRANSFCRED')]
  TIbscbsTransfcred = class(TGenericEntity)
  private
    FVcbs: Double;
    FIbscbsId: Integer;
    FVibs: Double;
    procedure setFIbscbsId(const Value: Integer);
    procedure setFVcbs(const Value: Double);
    procedure setFVibs(const Value: Double);

  public
    [KeyField('TB_IBSCBS_ID')]
    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('VIBS')]
    property Vibs: Double read FVibs write setFVibs;

    [FieldName('VCBS')]
    property Vcbs: Double read FVcbs write setFVcbs;
  end;

implementation


{ TIbscbsTransfcred }

procedure TIbscbsTransfcred.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbscbsTransfcred.setFVcbs(const Value: Double);
begin
  FVcbs := Value;
end;

procedure TIbscbsTransfcred.setFVibs(const Value: Double);
begin
  FVibs := Value;
end;

end.
