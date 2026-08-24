unit TblIbsCbsRed;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_RED')]
  TIBSCBSRED = Class(TGenericEntity)
  private
    FPALIQEFET: Double;
    FTB_IBSCBS_ID: Integer;
    FPREDALIQ: Double;
    FLINK_ID: Integer;
    FLINK_KIND: String;
    procedure setFLINK_ID(const Value: Integer);
    procedure setFLINK_KIND(const Value: String);
    procedure setFPALIQEFET(const Value: Double);
    procedure setFPREDALIQ(const Value: Double);
    procedure setFTB_IBSCBS_ID(const Value: Integer);



  public
    [KeyField('LINK_ID')]
    [FieldName('LINK_ID')]
    property LinkID: Integer read FLINK_ID write setFLINK_ID;

    [KeyField('LINK_KIND')]
    [FieldName('LINK_KIND')]
    property Tipo: String read FLINK_KIND write setFLINK_KIND;

    [KeyField('TB_IBSCBS_ID')]
    [FieldName('TB_IBSCBS_ID')]
    property IBSCBS_ID: Integer read FTB_IBSCBS_ID write setFTB_IBSCBS_ID;

    [FieldName('PREDALIQ')]
    property PREDALIQ: Double read FPREDALIQ write setFPREDALIQ;

    [FieldName('PALIQEFET')]
    property pAliqEfet: Double read FPALIQEFET write setFPALIQEFET;

  End;
implementation


{ TIBSCBSRED }

procedure TIBSCBSRED.setFLINK_ID(const Value: Integer);
begin
  FLINK_ID := Value;
end;

procedure TIBSCBSRED.setFLINK_KIND(const Value: String);
begin
  FLINK_KIND := Value;
end;

procedure TIBSCBSRED.setFPALIQEFET(const Value: Double);
begin
  FPALIQEFET := Value;
end;

procedure TIBSCBSRED.setFPREDALIQ(const Value: Double);
begin
  FPREDALIQ := Value;
end;

procedure TIBSCBSRED.setFTB_IBSCBS_ID(const Value: Integer);
begin
  FTB_IBSCBS_ID := Value;
end;

end.
