unit Un_TEF_ExibeMenu;

{$IFDEF FPC}
 {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type


{$IFNDEF FPC}
 {$R *.dfm}
{$ELSE}
 {$R *.lfm}
{$ENDIF}

  { TFr_TEF_ExibeMenu }

  TFr_TEF_ExibeMenu = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    Memo1: TMemo;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_TEF_ExibeMenu: TFr_TEF_ExibeMenu;

implementation

  { TFr_TEF_ExibeMenu }

procedure TFr_TEF_ExibeMenu.FormShow(Sender: TObject);
begin
  if Memo1.Lines.Count > 0 then
  begin
    Memo1.Width   := Trunc(Width/2)-10;
    Memo1.Visible := True ;
    Splitter1.Visible := True ;
  end ;

  ListBox1.SetFocus;
  if ListBox1.Items.Count > 0 then
    ListBox1.ItemIndex := 0 ;
end;

end.
