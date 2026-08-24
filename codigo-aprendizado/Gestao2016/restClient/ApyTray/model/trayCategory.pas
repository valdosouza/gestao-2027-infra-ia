unit trayCategory;

interface

Type
  //nome da classe de entidade
  TTrayCategory = Class
  private
    Fname: String;
    Fparent_id: String;
    Fid: String;
    Fdescription: String;
    procedure setFdescription(const Value: String);
    procedure setFid(const Value: String);
    procedure setFname(const Value: String);
    procedure setFparent_id(const Value: String);

  public
    property id : String read Fid write setFid;
    property parent_id : String read Fparent_id write setFparent_id;
    property name : String read Fname write setFname;
    property description : String read Fdescription write setFdescription;


  End;

implementation


{ TTrayCategory }

procedure TTrayCategory.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TTrayCategory.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TTrayCategory.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TTrayCategory.setFparent_id(const Value: String);
begin
  Fparent_id := Value;
end;

end.
