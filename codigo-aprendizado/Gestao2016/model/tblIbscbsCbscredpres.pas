unit tblIbscbsCbscredpres;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_CBSCREDPRES')]
  TIbscbsCbscredpres = class(TGenericEntity)
  private
    FCcredpresp01: String;
    FPcredpres: Double;
    FVcredpres: Double;
    FId: Integer;
    FVcredprescondsus: Double;
    FIbscbsId: Integer;
    procedure setFCcredpresp01(const Value: String);
    procedure setFIbscbsId(const Value: Integer);
    procedure setFId(const Value: Integer);
    procedure setFPcredpres(const Value: Double);
    procedure setFVcredpres(const Value: Double);
    procedure setFVcredprescondsus(const Value: Double);
  public
    [FieldName('ID')]
    [KeyField('ID')]
    property Id: Integer read FId write setFId;

    [FieldName('IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('CCREDPRESP01')]
    property Ccredpresp01: String read FCcredpresp01 write setFCcredpresp01;

    [FieldName('PCREDPRES')]
    property Pcredpres: Double read FPcredpres write setFPcredpres;

    [FieldName('VCREDPRES')]
    property Vcredpres: Double read FVcredpres write setFVcredpres;

    [FieldName('VCREDPRESCONDSUS')]
    property Vcredprescondsus: Double read FVcredprescondsus write setFVcredprescondsus;
  end;

implementation

{ TIbscbsCbscredpres }

procedure TIbscbsCbscredpres.setFCcredpresp01(const Value: String);
begin
  FCcredpresp01 := Value;
end;

procedure TIbscbsCbscredpres.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbscbsCbscredpres.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TIbscbsCbscredpres.setFPcredpres(const Value: Double);
begin
  FPcredpres := Value;
end;

procedure TIbscbsCbscredpres.setFVcredpres(const Value: Double);
begin
  FVcredpres := Value;
end;

procedure TIbscbsCbscredpres.setFVcredprescondsus(const Value: Double);
begin
  FVcredprescondsus := Value;
end;

end.
