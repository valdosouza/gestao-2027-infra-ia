unit tas_config;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, ControllerGeral;

type
  TTasConfig = class(TFr_Base)
    Panel6: TPanel;
    Btn_OK: TButton;
    Btn_Cn: TButton;
    Btn_Ap: TButton;
    Panel1: TPanel;
    procedure Btn_OKClick(Sender: TObject);
    procedure Btn_ApClick(Sender: TObject);
    procedure Btn_CnClick(Sender: TObject);
  private
    { Private declarations }
    Config :TControllerGeral;
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    function ValidaGravacao:Boolean;Virtual;
    procedure Gravar;Virtual;
    procedure Mostrar;Virtual;
  public
    { Public declarations }
  end;

var
  TasConfig: TTasConfig;

implementation

{$R *.dfm}


procedure TTasConfig.Btn_ApClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    Gravar;
  End;
end;

procedure TTasConfig.Btn_CnClick(Sender: TObject);
begin
  Close;
end;

procedure TTasConfig.Btn_OKClick(Sender: TObject);
begin
  if ValidaGravacao then
  Begin
    Gravar;
    Close;
  End;

end;

procedure TTasConfig.CriarVariaveis;
begin
  inherited;
  Config := TControllerGeral.Create(Self);
end;

procedure TTasConfig.Gravar;
begin

end;

procedure TTasConfig.IniciaVariaveis;
begin
  inherited;
  Mostrar;
end;

procedure TTasConfig.Mostrar;
begin

end;

function TTasConfig.ValidaGravacao: Boolean;
begin
  Result := True;
end;

end.


