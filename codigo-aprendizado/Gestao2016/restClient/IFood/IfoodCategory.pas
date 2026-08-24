unit IfoodCategory;

interface

Type
  TIfoodPUTCategory = Class
  private
    Fname: String;
    Findex: String;
    Fstatus: String;
    FexternalCode: String;
    procedure setFexternalCode(const Value: String);
    procedure setFindex(const Value: String);
    procedure setFname(const Value: String);
    procedure setFstatus(const Value: String);

  public
    property name         : String read Fname write setFname;
    property externalCode : String read FexternalCode write setFexternalCode;
    property status       : String read Fstatus write setFstatus;
    property indexador    : String read Findex write setFindex;
  End;



  TIfoodPOSTCategory = Class
  private
    Fname: String;
    Findex: String;
    Ftemplate: String;
    FId: String;
    Fstatus: String;
    FexternalCode: String;
    procedure setFexternalCode(const Value: String);
    procedure setFId(const Value: String);
    procedure setFindex(const Value: String);
    procedure setFname(const Value: String);
    procedure setFstatus(const Value: String);
    procedure setFtemplate(const Value: String);


  public
    property Id           : String read FId write setFId;
    property name         : String read Fname write setFname;
    property externalCode : String read FexternalCode write setFexternalCode;
    property status       : String read Fstatus write setFstatus;
    property indexador    : String read Findex write setFindex;
    property template     : String read Ftemplate write setFtemplate;
  End;

implementation


{ TIfoodPUTCategory }

procedure TIfoodPUTCategory.setFexternalCode(const Value: String);
begin
  FexternalCode := Value;
end;

procedure TIfoodPUTCategory.setFindex(const Value: String);
begin
  Findex := Value;
end;

procedure TIfoodPUTCategory.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TIfoodPUTCategory.setFstatus(const Value: String);
begin
  Fstatus := Value;
end;

{ TIfoodPOSTCategory }

procedure TIfoodPOSTCategory.setFexternalCode(const Value: String);
begin
  FexternalCode := Value;
end;

procedure TIfoodPOSTCategory.setFId(const Value: String);
begin
  FId := Value;
end;

procedure TIfoodPOSTCategory.setFindex(const Value: String);
begin
  Findex := Value;
end;

procedure TIfoodPOSTCategory.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TIfoodPOSTCategory.setFstatus(const Value: String);
begin
  Fstatus := Value;
end;

procedure TIfoodPOSTCategory.setFtemplate(const Value: String);
begin
  Ftemplate := Value;
end;

end.
