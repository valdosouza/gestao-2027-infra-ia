unit Un_TEF_ObtemCampo;

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

  TFr_TEF_ObtemCampo = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel1: TPanel;
     procedure Edit1KeyPress(Sender : TObject; var Key : char);
     procedure FormCloseQuery(Sender : TObject; var CanClose : boolean);
     procedure FormCreate(Sender : TObject);
     procedure FormShow(Sender : TObject);
  private
    { Private declarations }
    function valida:Boolean;
  public
    { Public declarations }
    TipoCampo : Integer;
    Operacao  : TACBrTEFDCliSiTefOperacaoCampo;
    TamanhoMinimo, TamanhoMaximo : Integer ;
  end;

var
  Fr_TEF_ObtemCampo: TFr_TEF_ObtemCampo;

implementation

{ TFr_TEF_ObtemCampo }

uses     Un_Funcoes;


procedure TFr_TEF_ObtemCampo.FormCreate(Sender : TObject);
begin
  TamanhoMinimo := 0 ;
  TamanhoMaximo := 0 ;
  Operacao      := tcString;
  TipoCampo     := 0 ;
end;

procedure TFr_TEF_ObtemCampo.Edit1KeyPress(Sender : TObject; var Key : char);
begin
   if Key in [#13,#8] then exit ;  { Enter e BackSpace, OK }

   if Operacao in [tcDouble, tcCMC7] then
      if not (Key in ['0'..'9', TFormatSettings.Create.DecimalSeparator]) then    { Apenas números }
         Key := #0 ;

   if (TamanhoMaximo > 0) and (Length( Edit1.Text ) >= TamanhoMaximo) then
   Begin
      Key := #0 ;
      ShowMessage('O Tamanho Máximo foi preenchido.') ;
   End;
end;

function TFr_TEF_ObtemCampo.valida:Boolean;
Var
  Aux : String;
Begin
  Result := True;
  if (ModalResult = mrOK) and (TamanhoMinimo > 0) then
  begin
    if Length( Edit1.Text ) < TamanhoMinimo then
    begin
      ShowMessage('O Tamanho Mínimo para este campo �: '+IntToStr(TamanhoMinimo) );
      Result := False;
      exit;
    end;

    if  (TipoCampo = 500 ) then
    Begin
      if (Edit1.Text <> 'setestef2017') then
      begin
        ShowMessage(concat('Senha do supervisor inv�lida.',#13,
                           'Verifique e tente novamente.') );
        Result := False;
        exit;
      end;
    End;

    if  (TipoCampo = 514 ) then
    Begin
      aux := Fc_RemoveCaracterInformado(Edit1.Text,[' ',',','.']);
      if (Length(aux) <3) then
      begin
        ShowMessage(concat('Verifique caracteres inválidos.',#13,
                           ' Tente novamente.') );
        Result := False;
        exit;
      end;
    End;
  end;
End;


procedure TFr_TEF_ObtemCampo.FormCloseQuery(Sender : TObject; var CanClose : boolean);
begin
  if not valida then
  Begin
    CanClose := False ;
    Edit1.SetFocus;
  End;
end;

procedure TFr_TEF_ObtemCampo.FormShow(Sender : TObject);
begin
   if Operacao = tcDouble then
      Edit1.Text := '0,00' ;
   Edit1.SetFocus;
end;

end.
