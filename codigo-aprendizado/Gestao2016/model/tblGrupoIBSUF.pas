unit GrupoIBSUF;

interface

uses
      GenericEntity, CAtribEntity;

type
  // nome da classe de entidade
  [TableName('TB_GRUPO_IBSUF')]
  TGrupoIBSUF = class(TGenericEntity)
  private
    FpIBSUF: Double;          // UB18: Alíquota do IBS da UF
    FvTribOp: Currency;       // UB20: Valor bruto do tributo na operção
    FpDif: Double;            // UB22: Percentual do diferimento
    FvDif: Currency;          // UB23: Valor do Diferimento
    FvDevTrib: Currency;      // UB25: Valor do tributo devolvido
    FpRedAliq: Double;        // UB27: Percentual da redução de alíquota
    FpAliqEfet: Double;       // UB28: Alíquota Efetiva do IBS da UF

    procedure setFpIBSUF(const Value: Double);
    procedure setFvTribOp(const Value: Currency);
    procedure setFpDif(const Value: Double);
    procedure setFvDif(const Value: Currency);
    procedure setFvDevTrib(const Value: Currency);
    procedure setFpRedAliq(const Value: Double);
    procedure setFpAliqEfet(const Value: Double);

  public
    [FieldName('IBSUF')]
    property IBSUF: Double read FpIBSUF write setFpIBSUF;

    [FieldName('TribOp')]
    property TribOp: Currency read FvTribOp write setFvTribOp;

    [FieldName('Dif')]
    property Dif: Double read FpDif write setFpDif;

    [FieldName('UB23')]
    property vDif: Currency read FvDif write setFvDif;

    [FieldName('DevTrib')]
    property DevTrib: Currency read FvDevTrib write setFvDevTrib;

    [FieldName('RedAliq')]
    property RedAliq: Double read FpRedAliq write setFpRedAliq;

    [FieldName('AliqEfet')]
    property AliqEfet: Double read FpAliqEfet write setFpAliqEfet;
  end;

implementation

{ TGrupoIBSUF }

procedure TGrupoIBSUF.setFpIBSUF(const Value: Double);
begin
  FpIBSUF := Value;
end;

procedure TGrupoIBSUF.setFvTribOp(const Value: Currency);
begin
  FvTribOp := Value;
end;

procedure TGrupoIBSUF.setFpDif(const Value: Double);
begin
  FpDif := Value;
end;

procedure TGrupoIBSUF.setFvDif(const Value: Currency);
begin
  FvDif := Value;
end;

procedure TGrupoIBSUF.setFvDevTrib(const Value: Currency);
begin
  FvDevTrib := Value;
end;

procedure TGrupoIBSUF.setFpRedAliq(const Value: Double);
begin
  FpRedAliq := Value;
end;

procedure TGrupoIBSUF.setFpAliqEfet(const Value: Double);
begin
  FpAliqEfet := Value;
end;

end.



implementation

end.
