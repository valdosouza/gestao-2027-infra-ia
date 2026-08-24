unit tblTaxes;

interface

Uses     GenericEntity, CAtribEntity;

type
  [TableName('tb_taxes')]
  TTaxes = class(TGenericEntity)
  private


  private
    Fclasstrib: String;
    FID: Integer;
    FDescription: String;
    FTaxesIncidencyId: Integer;
    Fcst: String;
    FTB_INSTITUTION_ID: Integer;
    procedure CreateTable;Override;
    procedure Setclasstrib(const Value: String);
    procedure Setcst(const Value: String);
    procedure SetDescription(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetTaxesIncidencyId(const Value: Integer);
    procedure SetTB_INSTITUTION_ID(const Value: Integer);
  public


    [FieldName('id')]
    [KeyField('ID')]
    property ID: Integer read FID write SetID;

    [FieldName('TB_INSTITUTION_ID')]
    [KeyField('TB_INSTITUTION_ID')]
    property Institution: Integer read FTB_INSTITUTION_ID write SetTB_INSTITUTION_ID;

    [FieldName('description')]
    property Description: String read FDescription write SetDescription;

    [FieldName('tb_taxes_incidency_id')]
    property TaxesIncidencyId: Integer read FTaxesIncidencyId write SetTaxesIncidencyId;

    [FieldName('CST')]
    property cst: String read Fcst write Setcst;

    [FieldName('CLASSTRIB')]
    property classtrib: String read Fclasstrib write Setclasstrib;

  end;

implementation


{ TTaxes }

procedure TTaxes.CreateTable;
begin
  inherited;

end;

procedure TTaxes.Setclasstrib(const Value: String);
begin
  Fclasstrib := Value;
end;

procedure TTaxes.Setcst(const Value: String);
begin
  Fcst := Value;
end;

procedure TTaxes.SetDescription(const Value: String);
begin
  FDescription := Value;
end;

procedure TTaxes.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TTaxes.SetTaxesIncidencyId(const Value: Integer);
begin
  FTaxesIncidencyId := Value;
end;

procedure TTaxes.SetTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

end.

