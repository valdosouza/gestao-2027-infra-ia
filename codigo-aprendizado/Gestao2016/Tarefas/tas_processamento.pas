unit tas_processamento;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrGIF, Vcl.ExtCtrls, Vcl.Imaging.GIFImg;

type
  TTasProcessamento = class(TForm)
    pnl_processo: TPanel;
    Image: TACBrGIF;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ImageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    private
      FFinalizado: Boolean;
    public
      Procedure Finalizar;

  end;
var
  TasProcessamento: TTasProcessamento;

implementation

{$R *.dfm}

uses     UN_Sistema, env;

procedure TTasProcessamento.Finalizar;
begin
  FFinalizado := True;
  Close;
end;

procedure TTasProcessamento.FormActivate(Sender: TObject);
begin
   self.Image.Update;
end;

procedure TTasProcessamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Image.Active := False;
end;

procedure TTasProcessamento.FormCreate(Sender: TObject);
begin
  FFinalizado := False;
  Image.Active := False;
  Image.Filename := concat(GbPathExe , '/aguarde.gif');
  Image.Active := True;
end;

procedure TTasProcessamento.ImageClick(Sender: TObject);
begin
  close;
end;


end.
