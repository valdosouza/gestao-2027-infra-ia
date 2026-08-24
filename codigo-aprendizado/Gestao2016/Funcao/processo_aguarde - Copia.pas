unit processo_aguarde;

interface

uses
      ControllerPedido, Classes, SysUtils, Vcl.Forms, UnFunctions, Winapi.Windows, StackTrace, ACBrGIF, Vcl.ExtCtrls, Vcl.Controls;

type
  TProcessoAguarde = class(TThread)
  private
    FPainel : Tpanel;
    FImagem : TACBrGIF;
    FTela : TForm;
    FFinalizado : boolean;
    procedure createProcessWait;
    procedure updateUI;
  protected

  public
    constructor Create(Screen:TForm);
    destructor Destroy; override;
    procedure finalizar;
    procedure execute;override;
  end;


implementation

{ TProcessoAguarde }


constructor TProcessoAguarde.Create(Screen:TForm);
begin
  inherited Create (False);
  FFinalizado := false;

  FTela := Screen;
  createProcessWait;
  FreeOnTerminate:=True;
  FTela.Enabled := false;
end;

procedure TProcessoAguarde.createProcessWait;
Var
  LcRand : String;
  Lc_path_file : String;
Begin
  LcRand := IntToStr(Random(10000));
  Lc_path_file := ExtractFilePath(Application.ExeName);
  Lc_path_file := concat(Lc_path_file, 'aguarde.gif');
  FPainel := TPanel.Create(FTela);
  with FPainel do
  Begin
    Name := concat('Pnl_ProceAguarde',LcRand);
    Parent := FTela;

    Caption := '';
    FullRepaint := True;
    ShowCaption := False;
    BorderWidth := 0;
    BevelInner := bvNone;
    BevelKind := bkNone;
    BevelOuter := bvNone;
    Height := 114;
    Width := 340;
    Top := trunc((FTela.Height - FPainel.Height)/2);
    Left := trunc((FTela.Width - FPainel.Width)/2);
  End;

  FImagem := TACBrGIF.create(FPainel);
  FImagem.Parent := FPainel;
  FImagem.Align := alClient;
  FImagem.Active := False;
  FImagem.Filename := Lc_path_file;
  FImagem.AutoSize := True;


end;

destructor TProcessoAguarde.Destroy;
begin
  FTela.Enabled := true;
  inherited;
end;

procedure TProcessoAguarde.execute;
begin
  FPainel.BringToFront;
  FPainel.Refresh;
  FPainel.Repaint;
  FImagem.Active := True;
  Application.ProcessMessages;
  while not FFinalizado do
  begin
    if FFinalizado then
      Terminate;
  end;

end;

procedure TProcessoAguarde.finalizar;
var
  I:Integer;
  LcPanel: TPanel;
begin
  FImagem.Stop;
  FFinalizado := True;
  for I := 0 to FTela.ComponentCount - 1 do
  begin
    //Limpa Painel
    if (FTela.Components[I].ClassType = TPanel) then
    begin
      if (Copy(TPanel(FTela.Components[I]).Name,1,16) = 'Pnl_ProceAguarde') then
      begin
        LcPanel := TPanel(FTela.Components[I]);
        FreeAndNil(LcPanel);
        Break;
      end;
    end;
  end;
end;


procedure TProcessoAguarde.updateUI;
begin
  FImagem.Pause;
  FImagem.Resume;
end;

end.
