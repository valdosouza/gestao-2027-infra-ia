unit TblIbsCbsDevTrib;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_DEVTRIB')]
  TIBSCBSDEVTRIB = Class(TGenericEntity)
  private
    FTB_IBSCBS_ID: Integer;
    FVDEVTRIB: Double;
    FLINK_ID: Integer;
    FLINK_KIND: String;
    procedure setFLINK_ID(const Value: Integer);
    procedure setFLINK_KIND(const Value: String);
    procedure setFTB_IBSCBS_ID(const Value: Integer);
    procedure setFVDEVTRIB(const Value: Double);


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

    [FieldName('VDEVTRIB')]
    property VDEVTRIB: Double read FVDEVTRIB write setFVDEVTRIB;
  End;


implementation


{ TIBSCBSDEVTRIB }

procedure TIBSCBSDEVTRIB.setFLINK_ID(const Value: Integer);
begin
  FLINK_ID := Value;
end;

procedure TIBSCBSDEVTRIB.setFLINK_KIND(const Value: String);
begin
  FLINK_KIND := Value;
end;

procedure TIBSCBSDEVTRIB.setFTB_IBSCBS_ID(const Value: Integer);
begin
  FTB_IBSCBS_ID := Value;
end;

procedure TIBSCBSDEVTRIB.setFVDEVTRIB(const Value: Double);
begin
  FVDEVTRIB := Value;
end;

end.
