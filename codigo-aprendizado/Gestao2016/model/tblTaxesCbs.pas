unit tblTaxesCbs;

interface

uses
      GenericEntity, CAtribEntity, System.SysUtils;

type
  [TableName('TB_TAXES_CBS')]
  TTaxesCbs = class(TGenericEntity)
  private


  private
    Faliq_efe: Real;
    Faliq_red: Real;
    Faliquota: Real;
    Faliq_dif: Real;
    Ftb_taxes_id: Integer;
    procedure CreateTable;Override;
    procedure Setaliq_dif(const Value: Real);
    procedure Setaliq_efe(const Value: Real);
    procedure Setaliq_red(const Value: Real);
    procedure Setaliquota(const Value: Real);
    procedure Settb_taxes_id(const Value: Integer);
  public


    [FieldName('TB_TAXES_ID')]
    [KeyField('TB_TAXES_ID')]
    property tb_taxes_id: Integer read Ftb_taxes_id write Settb_taxes_id;

    [FieldName('ALIQUOTA')]
    property aliquota: Real read Faliquota write Setaliquota;

    [FieldName('ALIQ_RED')]
    property aliq_red: Real read Faliq_red write Setaliq_red;

    [FieldName('ALIQ_EFE')]
    property aliq_efe: Real read Faliq_efe write Setaliq_efe;

    [FieldName('ALIQ_DIF')]
    property aliq_dif: Real read Faliq_dif write Setaliq_dif;
  end;

implementation

{ TTaxesCbs }

procedure TTaxesCbs.CreateTable;
begin
  inherited;

end;

procedure TTaxesCbs.Setaliquota(const Value: Real);
begin
  Faliquota := Value;
end;

procedure TTaxesCbs.Setaliq_dif(const Value: Real);
begin
  Faliq_dif := Value;
end;

procedure TTaxesCbs.Setaliq_efe(const Value: Real);
begin
  Faliq_efe := Value;
end;

procedure TTaxesCbs.Setaliq_red(const Value: Real);
begin
  Faliq_red := Value;
end;

procedure TTaxesCbs.Settb_taxes_id(const Value: Integer);
begin
  Ftb_taxes_id := Value;
end;

end.

