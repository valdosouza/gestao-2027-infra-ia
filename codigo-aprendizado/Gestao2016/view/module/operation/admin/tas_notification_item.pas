unit tas_notification_item;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, CustomCaptionPanel;

type
  TTasNotificationItem = class(TFrame)
    Panel3: TCustomCaptionPanel;
    Lb_Message: TLabel;
    Sb_ChangeStatus: TSpeedButton;
    Lb_Tittle: TLabel;
  private

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TTasNotificationItem }



end.
