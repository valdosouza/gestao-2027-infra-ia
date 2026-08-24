unit un_obtem_campo;

{$IFDEF FPC}
 {$mode objfpc}{$H+}
{$ENDIF}


interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, ACBrTEFDCliSiTef;

type

{$IFNDEF FPC}
 {$R *.dfm}
{$ELSE}
 {$R *.lfm}
{$ENDIF}

{ TFr_TEF_ObtemCampo }

  TFr_ObtemCampo = class(TForm)
    E_Numero: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    function valida:Boolean;
  public
    { Public declarations }

  end;

var
  Fr_ObtemCampo: TFr_ObtemCampo;

implementation

{ TFr_TEF_ObtemCampo }

uses     Un_Funcoes, Un_Msg, env;


{ TFr_ObtemCampo }

procedure TFr_ObtemCampo.BitBtn1Click(Sender: TObject);
begin
  if valida then
  BEgin
    Close;
  End;
end;

function TFr_ObtemCampo.valida: Boolean;
begin
  Result := True;
  if Length(Trim(E_Numero.Text)) = 0 then
  Begin
    MensagemPadrao(ATENCAO,
                   'Por favor informe um número válido.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  End;
end;

end.
