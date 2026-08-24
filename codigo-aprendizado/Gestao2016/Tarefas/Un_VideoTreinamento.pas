unit Un_VideoTreinamento;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.OleCtrls, SHDocVw;


type
  TFr_VideoTreinamento = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Img_LinkVideo: TImage;
    SB_Sair_0: TSpeedButton;
    Image1: TImage;
    WebBrowser: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Interface : String;
    It_Numero : String;
    It_Link:String;
    procedure Pc_PegaLinkInternet;
  end;

var
  Fr_VideoTreinamento: TFr_VideoTreinamento;

implementation



{$R *.dfm}

procedure TFr_VideoTreinamento.Pc_PegaLinkInternet;
Begin
end;

procedure TFr_VideoTreinamento.FormShow(Sender: TObject);
begin
  Pc_PegaLinkInternet;
  WebBrowser.Navigate(It_Link);
end;

procedure TFr_VideoTreinamento.SB_Sair_0Click(Sender: TObject);
begin
Close
end;

procedure TFr_VideoTreinamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  Begin
    if (Key = VK_Escape) then Sb_Sair_0Click(Sender);
  end;
end;

end.
