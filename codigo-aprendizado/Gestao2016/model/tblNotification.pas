unit tblNotification;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_NOTIFICATION')]
  TNotification = Class(TGenericEntity)
  private
    FNOTE: String;
    FACTIVE: String;
    FID: Integer;
    FUPDATED_AT: TDateTime;
    FCATEGORY: String;
    FCREATED_AT: TDateTime;
    FTB_INSTITUTION_ID: Integer;
    procedure setFACTIVE(const Value: String);
    procedure setFCATEGORY(const Value: String);
    procedure setFCREATED_AT(const Value: TDateTime);
    procedure setFID(const Value: Integer);
    procedure setFNOTE(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFUPDATED_AT(const Value: TDateTime);

  public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento : Integer  read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer  read FID write setFID;

    [FieldName('CATEGORY')]
    property Categoria: String   read FCATEGORY write setFCATEGORY;

    [FieldName('NOTE')]
    property Observacao: String read FNOTE write setFNOTE;

    [FieldName('ACTIVE')]
    property Ativo : String  read FACTIVE write setFACTIVE;

    [FieldName('CREATED_AT')]
    property createdAt: TDateTime  read FCREATED_AT write setFCREATED_AT;

    [FieldName('UPDATED_AT')]
    property updatedAt: TDateTime   read FUPDATED_AT write setFUPDATED_AT;

  End;

implementation

{ TNotification }

procedure TNotification.setFACTIVE(const Value: String);
begin
  FACTIVE := Value;
end;

procedure TNotification.setFCATEGORY(const Value: String);
begin
  FCATEGORY := Value;
end;

procedure TNotification.setFCREATED_AT(const Value: TDateTime);
begin
  FCREATED_AT := Value;
end;

procedure TNotification.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TNotification.setFNOTE(const Value: String);
begin
  FNOTE := Value;
end;

procedure TNotification.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TNotification.setFUPDATED_AT(const Value: TDateTime);
begin
  FUPDATED_AT := Value;
end;

end.
