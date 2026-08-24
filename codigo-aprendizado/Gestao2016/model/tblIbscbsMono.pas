unit tblIbscbsMono;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS_MONO')]
  TIbscbsMono = class(TGenericEntity)
  private
    FVibsmomoreten: Double;
    FAdremibs: Double;
    FVtotcbsmonoitem: Double;
    FAdremibsret: Double;
    FVcbsmonoreten: Double;
    FAdremcbs: Double;
    FVibsmomodif: Double;
    FAdremcbsret: Double;
    FVcbsmonodif: Double;
    FQbcmonoreten: Double;
    FVibsmono: Double;
    FVibsmomoret: Double;
    FVcbsmono: Double;
    FPdifibs: Double;
    FVcbsmonoret: Double;
    FAdremibsreten: Double;
    FIbscbsId: Integer;
    FPdifcbs: Double;
    FQbcmono: Double;
    FQbcmonoret: Double;
    FAdremcbsreten: Double;
    FVtotibsmonoitem: Double;
    procedure setFAdremcbs(const Value: Double);
    procedure setFAdremcbsret(const Value: Double);
    procedure setFAdremcbsreten(const Value: Double);
    procedure setFAdremibs(const Value: Double);
    procedure setFAdremibsret(const Value: Double);
    procedure setFAdremibsreten(const Value: Double);
    procedure setFIbscbsId(const Value: Integer);
    procedure setFPdifcbs(const Value: Double);
    procedure setFPdifibs(const Value: Double);
    procedure setFQbcmono(const Value: Double);
    procedure setFQbcmonoret(const Value: Double);
    procedure setFQbcmonoreten(const Value: Double);
    procedure setFVcbsmono(const Value: Double);
    procedure setFVcbsmonodif(const Value: Double);
    procedure setFVcbsmonoret(const Value: Double);
    procedure setFVcbsmonoreten(const Value: Double);
    procedure setFVibsmomodif(const Value: Double);
    procedure setFVibsmomoret(const Value: Double);
    procedure setFVibsmomoreten(const Value: Double);
    procedure setFVibsmono(const Value: Double);
    procedure setFVtotcbsmonoitem(const Value: Double);
    procedure setFVtotibsmonoitem(const Value: Double);

  public
    [KeyField('TB_IBSCBS_ID')]
    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('QBCMONO')]
    property Qbcmono: Double read FQbcmono write setFQbcmono;

    [FieldName('ADREMIBS')]
    property Adremibs: Double read FAdremibs write setFAdremibs;

    [FieldName('ADREMCBS')]
    property Adremcbs: Double read FAdremcbs write setFAdremcbs;

    [FieldName('VIBSMONO')]
    property Vibsmono: Double read FVibsmono write setFVibsmono;

    [FieldName('VCBSMONO')]
    property Vcbsmono: Double read FVcbsmono write setFVcbsmono;

    [FieldName('QBCMONORETEN')]
    property Qbcmonoreten: Double read FQbcmonoreten write setFQbcmonoreten;

    [FieldName('ADREMIBSRETEN')]
    property Adremibsreten: Double read FAdremibsreten write setFAdremibsreten;

    [FieldName('VIBSMONORETEN')]
    property Vibsmomoreten: Double read FVibsmomoreten write setFVibsmomoreten;

    [FieldName('ADREMCBSRETEN')]
    property Adremcbsreten: Double read FAdremcbsreten write setFAdremcbsreten;

    [FieldName('VCBSMONORETEN')]
    property Vcbsmonoreten: Double read FVcbsmonoreten write setFVcbsmonoreten;

    [FieldName('QBCMONORET')]
    property Qbcmonoret: Double read FQbcmonoret write setFQbcmonoret;

    [FieldName('ADREMIBSRET')]
    property Adremibsret: Double read FAdremibsret write setFAdremibsret;

    [FieldName('VIBSMONORET')]
    property Vibsmomoret: Double read FVibsmomoret write setFVibsmomoret;

    [FieldName('ADREMCBSRET')]
    property Adremcbsret: Double read FAdremcbsret write setFAdremcbsret;

    [FieldName('VCBSMONORET')]
    property Vcbsmonoret: Double read FVcbsmonoret write setFVcbsmonoret;

    [FieldName('PDIFIBS')]
    property Pdifibs: Double read FPdifibs write setFPdifibs;

    [FieldName('VIBSMONODIF')]
    property Vibsmomodif: Double read FVibsmomodif write setFVibsmomodif;

    [FieldName('PDIFCBS')]
    property Pdifcbs: Double read FPdifcbs write setFPdifcbs;

    [FieldName('VCBSMONODIF')]
    property Vcbsmonodif: Double read FVcbsmonodif write setFVcbsmonodif;

    [FieldName('VTOTIBSMONOITEM')]
    property Vtotibsmonoitem: Double read FVtotibsmonoitem write setFVtotibsmonoitem;

    [FieldName('VTOTCBSMONOITEM')]
    property Vtotcbsmonoitem: Double read FVtotcbsmonoitem write setFVtotcbsmonoitem;
  end;

implementation

{ TIbscbsMono }

procedure TIbscbsMono.setFAdremcbs(const Value: Double);
begin
  FAdremcbs := Value;
end;

procedure TIbscbsMono.setFAdremcbsret(const Value: Double);
begin
  FAdremcbsret := Value;
end;

procedure TIbscbsMono.setFAdremcbsreten(const Value: Double);
begin
  FAdremcbsreten := Value;
end;

procedure TIbscbsMono.setFAdremibs(const Value: Double);
begin
  FAdremibs := Value;
end;

procedure TIbscbsMono.setFAdremibsret(const Value: Double);
begin
  FAdremibsret := Value;
end;

procedure TIbscbsMono.setFAdremibsreten(const Value: Double);
begin
  FAdremibsreten := Value;
end;

procedure TIbscbsMono.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbscbsMono.setFPdifcbs(const Value: Double);
begin
  FPdifcbs := Value;
end;

procedure TIbscbsMono.setFPdifibs(const Value: Double);
begin
  FPdifibs := Value;
end;

procedure TIbscbsMono.setFQbcmono(const Value: Double);
begin
  FQbcmono := Value;
end;

procedure TIbscbsMono.setFQbcmonoret(const Value: Double);
begin
  FQbcmonoret := Value;
end;

procedure TIbscbsMono.setFQbcmonoreten(const Value: Double);
begin
  FQbcmonoreten := Value;
end;

procedure TIbscbsMono.setFVcbsmono(const Value: Double);
begin
  FVcbsmono := Value;
end;

procedure TIbscbsMono.setFVcbsmonodif(const Value: Double);
begin
  FVcbsmonodif := Value;
end;

procedure TIbscbsMono.setFVcbsmonoret(const Value: Double);
begin
  FVcbsmonoret := Value;
end;

procedure TIbscbsMono.setFVcbsmonoreten(const Value: Double);
begin
  FVcbsmonoreten := Value;
end;

procedure TIbscbsMono.setFVibsmomodif(const Value: Double);
begin
  FVibsmomodif := Value;
end;

procedure TIbscbsMono.setFVibsmomoret(const Value: Double);
begin
  FVibsmomoret := Value;
end;

procedure TIbscbsMono.setFVibsmomoreten(const Value: Double);
begin
  FVibsmomoreten := Value;
end;

procedure TIbscbsMono.setFVibsmono(const Value: Double);
begin
  FVibsmono := Value;
end;

procedure TIbscbsMono.setFVtotcbsmonoitem(const Value: Double);
begin
  FVtotcbsmonoitem := Value;
end;

procedure TIbscbsMono.setFVtotibsmonoitem(const Value: Double);
begin
  FVtotibsmonoitem := Value;
end;

end.
