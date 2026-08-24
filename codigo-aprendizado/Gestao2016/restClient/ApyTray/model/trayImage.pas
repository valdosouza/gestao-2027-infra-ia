unit trayImage;

interface

Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  TTrayImage = Class(TGenericEntity)
  private
    Fpicture_source_2: String;
    Fpicture_source_3: String;
    Fpicture_source_1: String;
    Fpicture_source_6: String;
    Fpicture_source_4: String;
    Fid: String;
    Fpicture_source_5: String;
    procedure setFid(const Value: String);
    procedure setFpicture_source_1(const Value: String);
    procedure setFpicture_source_2(const Value: String);
    procedure setFpicture_source_3(const Value: String);
    procedure setFpicture_source_4(const Value: String);
    procedure setFpicture_source_5(const Value: String);
    procedure setFpicture_source_6(const Value: String);

  public
    property id : String read Fid write setFid;

    property picture_source_1 : String read Fpicture_source_1 write setFpicture_source_1;
    property picture_source_2 : String read Fpicture_source_2 write setFpicture_source_2;
    property picture_source_3 : String read Fpicture_source_3 write setFpicture_source_3;
    property picture_source_4 : String read Fpicture_source_4 write setFpicture_source_4;
    property picture_source_5 : String read Fpicture_source_5 write setFpicture_source_5;
    property picture_source_6 : String read Fpicture_source_6 write setFpicture_source_6;

  End;

implementation

{ TTrayImage }

procedure TTrayImage.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TTrayImage.setFpicture_source_1(const Value: String);
begin
  Fpicture_source_1 := Value;
end;

procedure TTrayImage.setFpicture_source_2(const Value: String);
begin
  Fpicture_source_2 := Value;
end;

procedure TTrayImage.setFpicture_source_3(const Value: String);
begin
  Fpicture_source_3 := Value;
end;

procedure TTrayImage.setFpicture_source_4(const Value: String);
begin
  Fpicture_source_4 := Value;
end;

procedure TTrayImage.setFpicture_source_5(const Value: String);
begin
  Fpicture_source_5 := Value;
end;

procedure TTrayImage.setFpicture_source_6(const Value: String);
begin
  Fpicture_source_6 := Value;
end;

end.
