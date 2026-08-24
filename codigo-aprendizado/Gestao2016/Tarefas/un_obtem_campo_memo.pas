unit un_obtem_campo_memo;

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

  TFr_ObtemCampoMemo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    E_Observacao: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    function valida:Boolean;
  public
    { Public declarations }

  end;

var
  Fr_ObtemCampoMemo: TFr_ObtemCampoMemo;

implementation

{ TFr_TEF_ObtemCampo }

uses     Un_Funcoes, Un_Msg, env;


{ TFr_ObtemCampo }

procedure TFr_ObtemCampoMemo.BitBtn1Click(Sender: TObject);
begin
  if valida then
  BEgin
    Close;
  End;
end;

function TFr_ObtemCampoMemo.valida: Boolean;
begin
  Result := True;
  if Length(E_Observacao.Text) <=10 then
  Begin
    MensagemPadrao(ATENCAO,
                   'Por favor informe uma observação com no mínimo 10 caracteres.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  End;
end;

end.
