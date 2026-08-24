unit un_proj_log_changes;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw;

type
  TFr_ProjLogChanges = class(TForm)
    WebBrowser: TWebBrowser;
    Panel1: TPanel;
    SB_Sair_0: TSpeedButton;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_ProjLogChanges: TFr_ProjLogChanges;

implementation

{$R *.dfm}

procedure TFr_ProjLogChanges.FormCreate(Sender: TObject);
begin
  WebBrowser.Navigate('http://200.150.205.102:8074');
  {$IFDEF DEBUG}
    WebBrowser.Navigate('http://localhost:8074');
  {$ENDIF }
end;

procedure TFr_ProjLogChanges.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.
