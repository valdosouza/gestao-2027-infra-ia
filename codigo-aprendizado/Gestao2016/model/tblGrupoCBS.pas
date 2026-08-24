unit GrupoCBS;

interface

uses
      GenericEntity, CAtribEntity;

type
  // nome da classe de entidade
  [TableName('TB_GRUPO_CBS')]
  TGrupoCBS = class(TGenericEntity)
  private
    FpCBS: Double;            // UB56: Alíquota da CBS
    FvTribOp: Currency;       // UB58: Valor bruto do tributo na operção
    FpDif: Double;            // UB60: Percentual do diferimento
    FvDif: Currency;          // UB61: Valor do Diferimento
    FvDevTrib: Currency;      // UB63: Valor do tributo devolvido
    FpRedAliq: Double;        // UB65: Percentual da redução de alíquota
    FpAliqEfet: Double;       // UB66: Alíquota Efetiva da CBS

    procedure setFpCBS(const Value: Double);
    procedure setFvTribOp(const Value: Currency);
    procedure setFpDif(const Value: Double);
    procedure setFvDif(const Value: Currency);
    procedure setFvDevTrib(const Value: Currency);
    procedure setFpRedAliq(const Value: Double);
    procedure setFpAliqEfet(const Value: Double);

  public
    [FieldName('CBS')]
    property CBS: Double read FpCBS write setFpCBS;

    [FieldName('TribOp')]
    property TribOp: Currency read FvTribOp write setFvTribOp;

    [FieldName('Dif')]
    property pDif: Double read FpDif write setFpDif;

    [FieldName('Dif')]
    property vDif: Currency read FvDif write setFvDif;

    [FieldName('DevTrib')]
    property DevTrib: Currency read FvDevTrib write setFvDevTrib;

    [FieldName('RedAliq')]
    property RedAliq: Double read FpRedAliq write setFpRedAliq;

    [FieldName('AliqEfet')]
    property AliqEfet: Double read FpAliqEfet write setFpAliqEfet;
  end;

implementation

{ TGrupoCBS }

procedure TGrupoCBS.setFpCBS(const Value: Double);
begin
  FpCBS := Value;
end;

procedure TGrupoCBS.setFvTribOp(const Value: Currency);
begin
  FvTribOp := Value;
end;

procedure TGrupoCBS.setFpDif(const Value: Double);
begin
  FpDif := Value;
end;

procedure TGrupoCBS.setFvDif(const Value: Currency);
begin
  FvDif := Value;
end;

procedure TGrupoCBS.setFvDevTrib(const Value: Currency);
begin
  FvDevTrib := Value;
end;

procedure TGrupoCBS.setFpRedAliq(const Value: Double);
begin
  FpRedAliq := Value;
end;

procedure TGrupoCBS.setFpAliqEfet(const Value: Double);
begin
  FpAliqEfet := Value;
end;

end.

