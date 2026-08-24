unit TblIbsCbsDif;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_DIF')]
  TIBSCBSDIF = Class(TGenericEntity)
  private
    FTB_IBSCBS_ID: Integer;
    FPDIF: Double;
    FVDIF: Double;
    FLINK_ID: Integer;
    FLINK_KIND: String;
    procedure setFLINK_ID(const Value: Integer);
    procedure setFLINK_KIND(const Value: String);
    procedure setFPDIF(const Value: Double);
    procedure setFTB_IBSCBS_ID(const Value: Integer);
    procedure setFVDIF(const Value: Double);



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

    [FieldName('PDIF')]
    property PDIF: Double read FPDIF write setFPDIF;

    [FieldName('VDIF')]
    property VDIF: Double read FVDIF write setFVDIF;

  End;


implementation

{ TIBSCBSDIF }

procedure TIBSCBSDIF.setFLINK_ID(const Value: Integer);
begin
  FLINK_ID := Value;
end;

procedure TIBSCBSDIF.setFLINK_KIND(const Value: String);
begin
  FLINK_KIND := Value;
end;

procedure TIBSCBSDIF.setFPDIF(const Value: Double);
begin
  FPDIF := Value;
end;

procedure TIBSCBSDIF.setFTB_IBSCBS_ID(const Value: Integer);
begin
  FTB_IBSCBS_ID := Value;
end;

procedure TIBSCBSDIF.setFVDIF(const Value: Double);
begin
  FVDIF := Value;
end;

end.
