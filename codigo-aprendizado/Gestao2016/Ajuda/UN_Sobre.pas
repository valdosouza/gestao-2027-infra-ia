unit UN_Sobre;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.Imaging.pngimage;


type
  TFr_Sobre = class(TForm)
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    IM_Logo: TImage;
    Label3: TLabel;
    procedure IM_LogoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Sobre: TFr_Sobre;

implementation

{$R *.dfm}

procedure TFr_Sobre.IM_LogoClick(Sender: TObject);
begin
  close;
end;

end.
