unit tblDistNfe;

interface

Uses
      SysUtils, Classes, GenericEntity, CAtribEntity;

type
  [TableName('TB_DIST_NFE')]
  TDistNfe = class(TGenericEntity)
  private
    FNSU: String;
    FKind: String;
    FChave: String;

    procedure SetNSU(const Value: String);
    procedure SetKind(const Value: String);
    procedure SetChave(const Value: String);

  public
    [KeyField('NSU')]
    [FieldName('NSU')]
    property NSU: String read FNSU write SetNSU;

    [FieldName('KIND')]
    property Kind: String read FKind write SetKind;

    [FieldName('CHAVE')]
    property Chave: String read FChave write SetChave;
  end;

implementation

{ TDistNfe }

procedure TDistNfe.SetChave(const Value: String);
begin
  FChave := Value;
end;

procedure TDistNfe.SetKind(const Value: String);
begin
  FKind := Value;
end;

procedure TDistNfe.SetNSU(const Value: String);
begin
  FNSU := Value;
end;

end.

