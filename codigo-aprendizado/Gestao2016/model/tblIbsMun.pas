unit tblIbsMun;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBS_MUN')]
  TIbsMun = class(TGenericEntity)
  private
    FPibsmun: Double;
    FVibsmun: Double;
    FPaliqefet: Double;
    FVdevtrib: Double;
    FPdif: Double;
    FVdif: Double;
    FPredaliq: Double;
    FIbscbsId: Integer;
    FID: Integer;
    procedure setFIbscbsId(const Value: Integer);
    procedure setFPaliqefet(const Value: Double);
    procedure setFPdif(const Value: Double);
    procedure setFPibsmun(const Value: Double);
    procedure setFPredaliq(const Value: Double);
    procedure setFVdevtrib(const Value: Double);
    procedure setFVdif(const Value: Double);
    procedure setFVibsmun(const Value: Double);
    procedure setFID(const Value: Integer);

  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_IBSCBS_ID')]
    property IbscbsId: Integer read FIbscbsId write setFIbscbsId;

    [FieldName('PIBSMUN')]
    property Pibsmun: Double read FPibsmun write setFPibsmun;

    [FieldName('PDIF')]
    property Pdif: Double read FPdif write setFPdif;

    [FieldName('VDIF')]
    property Vdif: Double read FVdif write setFVdif;

    [FieldName('VDEVTRIB')]
    property Vdevtrib: Double read FVdevtrib write setFVdevtrib;

    [FieldName('PREDALIQ')]
    property Predaliq: Double read FPredaliq write setFPredaliq;

    [FieldName('PALIQEFET')]
    property Paliqefet: Double read FPaliqefet write setFPaliqefet;

    [FieldName('VIBSMUN')]
    property Vibsmun: Double read FVibsmun write setFVibsmun;
  end;

implementation


{ TIbsMun }

procedure TIbsMun.setFIbscbsId(const Value: Integer);
begin
  FIbscbsId := Value;
end;

procedure TIbsMun.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TIbsMun.setFPaliqefet(const Value: Double);
begin
  FPaliqefet := Value;
end;

procedure TIbsMun.setFPdif(const Value: Double);
begin
  FPdif := Value;
end;

procedure TIbsMun.setFPibsmun(const Value: Double);
begin
  FPibsmun := Value;
end;

procedure TIbsMun.setFPredaliq(const Value: Double);
begin
  FPredaliq := Value;
end;

procedure TIbsMun.setFVdevtrib(const Value: Double);
begin
  FVdevtrib := Value;
end;

procedure TIbsMun.setFVdif(const Value: Double);
begin
  FVdif := Value;
end;

procedure TIbsMun.setFVibsmun(const Value: Double);
begin
  FVibsmun := Value;
end;

end.
