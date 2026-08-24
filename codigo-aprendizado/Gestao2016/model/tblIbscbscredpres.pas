unit tblIbscbscredpres;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_IBSCREDPRES')]
  TIbscbscredpres = class(TGenericEntity)
  private
    FPcredpres: Double;
    FVcredpres: Double;
    FVcredprescondsus: Double;
    FIbscbsId: Integer;
    FCcredpres: String;
    procedure setFCcredpres(const Value: String);
    procedure setFIbscbsId(const Value: Integer);
    procedure setFPcredpres(const Value: Double);
    procedure setFVcredpres(const Value: Double);
    procedure setFVcredprescondsus(const Value: Double);
  public
    [KeyField('TB_IBSCBS_ID')]
    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('CCREDPRES')]
    property Ccredpres: String read FCcredpres write setFCcredpres;

    [FieldName('PCREDPRES')]
    property Pcredpres: Double read FPcredpres write setFPcredpres;

    [FieldName('VCREDPRES')]
    property Vcredpres: Double read FVcredpres write setFVcredpres;

    [FieldName('VCREDPRESCONDSUS')]
    property Vcredprescondsus: Double read FVcredprescondsus write setFVcredprescondsus;
  end;

implementation

{ TIbscbscredpres }

procedure TIbscbscredpres.setFCcredpres(const Value: String);
begin
  FCcredpres := Value;
end;

procedure TIbscbscredpres.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbscbscredpres.setFPcredpres(const Value: Double);
begin
  FPcredpres := Value;
end;

procedure TIbscbscredpres.setFVcredpres(const Value: Double);
begin
  FVcredpres := Value;
end;

procedure TIbscbscredpres.setFVcredprescondsus(const Value: Double);
begin
  FVcredprescondsus := Value;
end;

end.
