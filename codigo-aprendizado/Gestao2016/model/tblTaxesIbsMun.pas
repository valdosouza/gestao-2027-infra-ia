unit tblTaxesIbsMun;

interface

uses
      GenericEntity, CAtribEntity, System.SysUtils;

type
  [TableName('TB_TAXES_IBS_MUN')]
  TTaxesIbsMun = class(TGenericEntity)
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

{ TTaxesIbsMun }

procedure TTaxesIbsMun.CreateTable;
begin
  inherited;

end;

procedure TTaxesIbsMun.Setaliquota(const Value: Real);
begin
  Faliquota := Value;
end;

procedure TTaxesIbsMun.Setaliq_dif(const Value: Real);
begin
  Faliq_dif := Value;
end;

procedure TTaxesIbsMun.Setaliq_efe(const Value: Real);
begin
  Faliq_efe := Value;
end;

procedure TTaxesIbsMun.Setaliq_red(const Value: Real);
begin
  Faliq_red := Value;
end;

procedure TTaxesIbsMun.Settb_taxes_id(const Value: Integer);
begin
  Ftb_taxes_id := Value;
end;

end.

