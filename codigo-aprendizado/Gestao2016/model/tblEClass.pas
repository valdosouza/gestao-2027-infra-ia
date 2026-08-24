unit tblEClass;

interface

uses
      System.SysUtils, GenericEntity, CAtribEntity;

type
  [TableName('TB_ECLASS')]
  TEClass = class(TGenericEntity)
  private
    FCST: string;
    FCST_DESCRIPTION: string;
    FCLASSE: string;
    FCLASS_NAME: string;
    FCLASSTRIB_DESCRIPTION: string;
    FESSAY: string;
    FLC_214_25: string;
    FRATE_TYPE: string;
    FPREDIBS: Double;
    FPREDCBS: Double;
    FIND_REDUTORBC: string;
    FIND_GTRIBREGULAR: Integer;
    FIND_CREDPRES: Integer;
    FIND_MONO: Integer;
    FIND_MONORETEN: Integer;
    FIND_MONORET: Integer;
    FIND_MONODIF: Integer;
    FCREDIT_FOR: string;
    FDINIVIG: TDateTime;
    FDFIMVIG: TDateTime;
    FUPDATE_DATE: TDateTime;

    procedure SetCST(const Value: string);
    procedure SetCST_DESCRIPTION(const Value: string);
    procedure SetCLASSE(const Value: string);
    procedure SetCLASS_NAME(const Value: string);
    procedure SetCLASSTRIB_DESCRIPTION(const Value: string);
    procedure SetESSAY(const Value: string);
    procedure SetLC_214_25(const Value: string);
    procedure SetRATE_TYPE(const Value: string);
    procedure SetPREDIBS(const Value: Double);
    procedure SetPREDCBS(const Value: Double);
    procedure SetIND_REDUTORBC(const Value: string);
    procedure SetIND_GTRIBREGULAR(const Value: Integer);
    procedure SetIND_CREDPRES(const Value: Integer);
    procedure SetIND_MONO(const Value: Integer);
    procedure SetIND_MONORETEN(const Value: Integer);
    procedure SetIND_MONORET(const Value: Integer);
    procedure SetIND_MONODIF(const Value: Integer);
    procedure SetCREDIT_FOR(const Value: string);
    procedure SetDINIVIG(const Value: TDateTime);
    procedure SetDFIMVIG(const Value: TDateTime);
    procedure SetUPDATE_DATE(const Value: TDateTime);

    procedure CreateTable;Override;
    procedure InsertData;Override;

  public
    [KeyField('CST')]
    [FieldName('CST')]
    property CST: string read FCST write SetCST;

    [FieldName('CST_DESCRIPTION')]
    property CST_DESCRIPTION: string read FCST_DESCRIPTION write SetCST_DESCRIPTION;

    [FieldName('CLASSE')]
    property CLASSE: string read FCLASSE write SetCLASSE;

    [FieldName('CLASS_NAME')]
    property CLASS_NAME: string read FCLASS_NAME write SetCLASS_NAME;

    [FieldName('CLASSTRIB_DESCRIPTION')]
    property CLASSTRIB_DESCRIPTION: string read FCLASSTRIB_DESCRIPTION write SetCLASSTRIB_DESCRIPTION;

    [FieldName('ESSAY')]
    property ESSAY: string read FESSAY write SetESSAY;

    [FieldName('LC_214_25')]
    property LC_214_25: string read FLC_214_25 write SetLC_214_25;

    [FieldName('RATE_TYPE')]
    property RATE_TYPE: string read FRATE_TYPE write SetRATE_TYPE;

    [FieldName('PREDIBS')]
    property PREDIBS: Double read FPREDIBS write SetPREDIBS;

    [FieldName('PREDCBS')]
    property PREDCBS: Double read FPREDCBS write SetPREDCBS;

    [FieldName('IND_REDUTORBC')]
    property IND_REDUTORBC: string read FIND_REDUTORBC write SetIND_REDUTORBC;

    [FieldName('IND_GTRIBREGULAR')]
    property IND_GTRIBREGULAR: Integer read FIND_GTRIBREGULAR write SetIND_GTRIBREGULAR;

    [FieldName('IND_CREDPRES')]
    property IND_CREDPRES: Integer read FIND_CREDPRES write SetIND_CREDPRES;

    [FieldName('IND_MONO')]
    property IND_MONO: Integer read FIND_MONO write SetIND_MONO;

    [FieldName('IND_MONORETEN')]
    property IND_MONORETEN: Integer read FIND_MONORETEN write SetIND_MONORETEN;

    [FieldName('IND_MONORET')]
    property IND_MONORET: Integer read FIND_MONORET write SetIND_MONORET;

    [FieldName('IND_MONODIF')]
    property IND_MONODIF: Integer read FIND_MONODIF write SetIND_MONODIF;

    [FieldName('CREDIT_FOR')]
    property CREDIT_FOR: string read FCREDIT_FOR write SetCREDIT_FOR;

    [FieldName('DINIVIG')]
    property DINIVIG: TDateTime read FDINIVIG write SetDINIVIG;

    [FieldName('DFIMVIG')]
    property DFIMVIG: TDateTime read FDFIMVIG write SetDFIMVIG;

    [FieldName('UPDATE_DATE')]
    property UPDATE_DATE: TDateTime read FUPDATE_DATE write SetUPDATE_DATE;
  end;

implementation

{ TEClass }

procedure TEClass.SetCLASS_NAME(const Value: string);
begin
  FCLASS_NAME := Value;
end;

procedure TEClass.CreateTable;
begin
  inherited;


end;

procedure TEClass.InsertData;
begin
  FFileName := FFileName + 'tb_eclass.sql';
  ExecSqlScriptFromFile;
end;

procedure TEClass.SetCLASSE(const Value: string);
begin
  FCLASSE := Value;
end;

procedure TEClass.SetCLASSTRIB_DESCRIPTION(const Value: string);
begin
  FCLASSTRIB_DESCRIPTION := Value;
end;

procedure TEClass.SetCREDIT_FOR(const Value: string);
begin
  FCREDIT_FOR := Value;
end;

procedure TEClass.SetCST(const Value: string);
begin
  FCST := Value;
end;

procedure TEClass.SetCST_DESCRIPTION(const Value: string);
begin
  FCST_DESCRIPTION := Value;
end;

procedure TEClass.SetDFIMVIG(const Value: TDateTime);
begin
  FDFIMVIG := Value;
end;

procedure TEClass.SetDINIVIG(const Value: TDateTime);
begin
  FDINIVIG := Value;
end;

procedure TEClass.SetESSAY(const Value: string);
begin
  FESSAY := Value;
end;

procedure TEClass.SetIND_CREDPRES(const Value: Integer);
begin
  FIND_CREDPRES := Value;
end;

procedure TEClass.SetIND_GTRIBREGULAR(const Value: Integer);
begin
  FIND_GTRIBREGULAR := Value;
end;

procedure TEClass.SetIND_MONO(const Value: Integer);
begin
  FIND_MONO := Value;
end;

procedure TEClass.SetIND_MONODIF(const Value: Integer);
begin
  FIND_MONODIF := Value;
end;

procedure TEClass.SetIND_MONORET(const Value: Integer);
begin
  FIND_MONORET := Value;
end;

procedure TEClass.SetIND_MONORETEN(const Value: Integer);
begin
  FIND_MONORETEN := Value;
end;

procedure TEClass.SetIND_REDUTORBC(const Value: string);
begin
  FIND_REDUTORBC := Value;
end;

procedure TEClass.SetLC_214_25(const Value: string);
begin
  FLC_214_25 := Value;
end;

procedure TEClass.SetPREDIBS(const Value: Double);
begin
  FPREDIBS := Value;
end;

procedure TEClass.SetPREDCBS(const Value: Double);
begin
  FPREDCBS := Value;
end;

procedure TEClass.SetRATE_TYPE(const Value: string);
begin
  FRATE_TYPE := Value;
end;

procedure TEClass.SetUPDATE_DATE(const Value: TDateTime);
begin
  FUPDATE_DATE := Value;
end;

end.

