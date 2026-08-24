unit UnGeraLog;

interface

uses
       Windows, SysUtils, Classes, Vcl.Dialogs, Vcl.Forms;

    procedure GeralogCrashlytics(Origem,msg:String);
    procedure GeralogFile(Origem,msg:String);
  implementation

uses     tblCrashlytics, uDataCM, REST.Json, env;

procedure GeralogCrashlytics(Origem,msg:String);
Var
  LcCrash : TCrashlytics;
  LcJson : String;
  LcData : TDataCM;
begin
  LcData := TDataCM.Create(nil);
  LcCrash := TCrashlytics.Create;
  Try
    Try
      LcCrash.Estabelecimento := Gb_CodMha;
      LcCrash.Usuario         := GB_Cd_Usuario;
      LcCrash.Origem          := Copy(concat(GB_NM_Empresa,' - ',origem),1,100);
      LcCrash.Mensagem        := msg;
      LcCrash.RegistroCriado  := Now;
      LcCrash.RegistroAlterado  := Now;
      LcJson := TJson.ObjectToJsonString(LcCrash);
      LcData.SMServicesClient.setCrashlytics(LcJson);
    Except
      on E: Exception do
      ShowMessage(concat('Erro: ', E.Message ));

    End;
  Finally
    FreeAndNil(LcCrash);
    FreeAndNil(LcData);
  End;
end;

procedure GeralogFile(Origem,msg:String);
var
  Lc_File: TextFile;
  Lc_PathFileName : String;
  Lc_DateTime : String;
begin
  Try
    Lc_PathFileName := ExtractFilePath(Application.ExeName) + 'log_api_data.txt';
    AssignFile(Lc_File, Lc_PathFileName);
    if FileExists(Lc_PathFileName) then
      Append(Lc_File)
    else
      Rewrite(Lc_File);
    Lc_DateTime := DateTimeToStr(Now);
    Writeln(Lc_File, concat(Lc_DateTime , ' - ' , Origem , ' - ' , msg));
    Flush(Lc_File);
  Finally
    CloseFile(Lc_File);
  End;
end;

end.
