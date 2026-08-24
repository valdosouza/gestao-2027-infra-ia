unit Un_RL_NFSe_IPMSistemas;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.OleCtrls, SHDocVw, Vcl.Menus, Vcl.Buttons, Vcl.ComCtrls, Vcl.ToolWin, ImageList, Vcl.ImgList;

type
  TRL_NFSe_IPMSistemas = class(TFr_Base)
    WebBrowser: TWebBrowser;
    ToolBar1: TToolBar;
    PrintSetup: TToolButton;
    Print: TToolButton;
    SaveReport: TToolButton;
    Spacer5: TToolButton;
    ExitButton: TSpeedButton;
    Images: TImageList;
    PreviewReport: TToolButton;
    Atualizar: TToolButton;
    procedure ExitButtonClick(Sender: TObject);
    procedure PreviewReportClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure PrintSetupClick(Sender: TObject);
    procedure AtualizarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
    PAthFileNFse : String;
  end;

var
  RL_NFSe_IPMSistemas: TRL_NFSe_IPMSistemas;

implementation

{$R *.dfm}

uses     UN_Sistema;

{ TRL_NFSe_IPMSistemas }

procedure TRL_NFSe_IPMSistemas.AtualizarClick(Sender: TObject);
begin
  WebBrowser.Refresh2;
end;

procedure TRL_NFSe_IPMSistemas.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TRL_NFSe_IPMSistemas.IniciaVariaveis;
begin
  Self.WindowState := wsMaximized;
  WebBrowser.Navigate(PAthFileNFse);
end;

procedure TRL_NFSe_IPMSistemas.PreviewReportClick(Sender: TObject);
var
  vIn, vOut: OleVariant;
begin
  WebBrowser.ControlInterface.ExecWB(OLECMDID_PRINTPREVIEW,
    OLECMDEXECOPT_DONTPROMPTUSER, vIn, vOut) ;

end;

procedure TRL_NFSe_IPMSistemas.PrintClick(Sender: TObject);
var
  vaIn, vaOut: OleVariant;
begin
  WebBrowser.ControlInterface.ExecWB(
    OLECMDID_PRINT,
    OLECMDEXECOPT_PROMPTUSER,
    vaIn, vaOut);
end;

procedure TRL_NFSe_IPMSistemas.PrintSetupClick(Sender: TObject);
var
  vaIn, vaOut: OleVariant;
begin
  WebBrowser.ControlInterface.ExecWB(
    OLECMDID_PAGESETUP,
    OLECMDEXECOPT_PROMPTUSER,
    vaIn, vaOut);
end;

end.
