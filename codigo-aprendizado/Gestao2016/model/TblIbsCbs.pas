unit TblIbsCbs;

interface

Uses     GenericEntity, CAtribEntity;

Type
  [TableName('TB_IBSCBS')]
  TIBSCBS = Class(TGenericEntity)
  private
    FCODITF: Integer;
    FCLASSTRIB: String;
    FVBC: Double;
    FID: Integer;
    FCODNFL: Integer;
    FVIBC: Double;
    FCST: String;
    procedure setFCLASSTRIB(const Value: String);
    procedure setFCODITF(const Value: Integer);
    procedure setFCODNFL(const Value: Integer);
    procedure setFCST(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFVBC(const Value: Double);
    procedure setFVIBC(const Value: Double);



  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('CODNFL')]
    property Nota: Integer read FCODNFL write setFCODNFL;

    [FieldName('CODITF')]
    property ItemNF: Integer read FCODITF write setFCODITF;

    [FieldName('CST')]
    property CST: String read FCST write setFCST;

    [FieldName('CLASSTRIB')]
    property CLASSTRIB: String read FCLASSTRIB write setFCLASSTRIB;

    [FieldName('VBC')]
    property VBC: Double read FVBC write setFVBC;

    [FieldName('VIBS')]
    property VIBS: Double read FVIBC write setFVIBC;

  End;

implementation

{ TIBSCBS }

procedure TIBSCBS.setFCLASSTRIB(const Value: String);
begin
  FCLASSTRIB := Value;
end;

procedure TIBSCBS.setFCODITF(const Value: Integer);
begin
  FCODITF := Value;
end;

procedure TIBSCBS.setFCODNFL(const Value: Integer);
begin
  FCODNFL := Value;
end;

procedure TIBSCBS.setFCST(const Value: String);
begin
  FCST := Value;
end;

procedure TIBSCBS.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TIBSCBS.setFVBC(const Value: Double);
begin
  FVBC := Value;
end;

procedure TIBSCBS.setFVIBC(const Value: Double);
begin
  FVIBC := Value;
end;

end.
