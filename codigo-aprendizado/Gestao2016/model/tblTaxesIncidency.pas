unit tblTaxesIncidency;

interface

Uses     GenericEntity, CAtribEntity;

type
  [TableName('TB_TAXES_INCIDENCY')]
  TTaxesIncidency = class(TGenericEntity)
  private


  private
    FID: Integer;
    FDescription: String;
    FKIND: String;
    FGROUP_TRIB: String;
    procedure CreateTable;Override;
    procedure InsertData;Override;
    procedure SetFDescription(const Value: String);
    procedure SetFGROUP_TRIB(const Value: String);
    procedure SetFKIND(const Value: String);
    procedure SetID(const Value: Integer);
  public


    [FieldName('id')]
    [KeyField('ID')]
    property ID: Integer read FID write SetID;

    [FieldName('KIND')]
    property Tipo: String read FKIND write SetFKIND;

    [FieldName('description')]
    property Description: String read FDescription write SetFDescription;

    [FieldName('GROUP_TRIB')]
    property Grupo: String read FGROUP_TRIB write SetFGROUP_TRIB;

  end;

implementation

{ TTaxesIncidency }

procedure TTaxesIncidency.CreateTable;
begin
  inherited;

end;

procedure TTaxesIncidency.InsertData;
begin

end;

procedure TTaxesIncidency.SetFDescription(const Value: String);
begin
  FDescription := Value;
end;

procedure TTaxesIncidency.SetFGROUP_TRIB(const Value: String);
begin
  FGROUP_TRIB := Value;
end;

procedure TTaxesIncidency.SetFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TTaxesIncidency.SetID(const Value: Integer);
begin
  FID := Value;
end;

end.
