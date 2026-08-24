unit Un_FTP;

interface

uses
      SysUtils, IdFTP, Graphics, Classes, Dialogs, Gauges, Forms;

type
  TFTP = class
  private
    clientFTP : TIdFTP;
  public
    constructor Create(idFTP: TIdFTP; host: String; username: String; password : String); overload;
    function enviar(filePathOrigem: String; fileNameOrigem: String; filePathDestino: String; fileNameDestino: String; Gg_Progresso:TGauge) : Boolean;
  end;

implementation

  constructor TFTP.Create(idFTP: TIdFTP; host: String; username: String; password : String);
  begin
    clientFTP := idFTP;
    clientFTP.Host := host;
    clientFTP.Username := username;
    clientFTP.Password := password;
  end;

  function TFTP.enviar(filePathOrigem: String; fileNameOrigem: String; filePathDestino: String; fileNameDestino: String; Gg_Progresso:TGauge) : Boolean;
  var
     fileOrigem : String;
     i : Integer;
  begin
    fileOrigem  := filePathOrigem + fileNameOrigem;

    if ( FileExists(fileOrigem) ) then
    begin
      try
        Gg_Progresso.Visible := True;
        Gg_Progresso.Progress := 0;

        clientFTP.Connect;

        for i := 0 to clientFTP.Greeting.Text.Count-1 do
          Application.ProcessMessages;

        clientFTP.ChangeDir(filePathDestino);
        clientFTP.Put(fileOrigem, fileNameOrigem);
        Gg_Progresso.Visible := False;
        clientFTP.Disconnect;
        result := true;
      except
        ShowMessage('Erro no FTP');
        result := false;
      end
    end
    else
    begin
      result := false;
    end;
  end;

end.

