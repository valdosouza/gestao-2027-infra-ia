unit Un_ProcessoAguarde;

interface

uses
       SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Spin, Grids, Inifiles, StrUtils, Mask, System.Math, ExtCtrls, Windows, Variants, DBCtrls, DBGrids, DB, Buttons, jpeg, Vcl.Imaging.GIFImg, ACBrGIF;


type
  TProcessoAguarde = class(TThread)
    private
      FPanel : TPanel;
      FPicture:TPicture;
      FImagem : TImage;
      FTela : TForm;
      procedure CreateImage;
    public
      constructor Create(Tela:TForm; Picture:TPicture);
      destructor Destroy; override;
      procedure stop;
      procedure Execute(); override;
  end;


implementation

{ TProcessoAguarde }

constructor TProcessoAguarde.Create(Tela:TForm; Picture:TPicture);
begin
  inherited Create (True);
  FreeOnTerminate := true;
  Ftela := Tela;
  Ftela.DoubleBuffered := True;
  Ftela.Enabled := True;
  FPicture := Picture;
  CreateImage;
end;

destructor TProcessoAguarde.Destroy;
begin

  inherited;
end;

procedure TProcessoAguarde.Execute;
Begin
  priority := tpHighest;
  inherited;
  while not Terminated do
  Begin
    TThread.Synchronize(nil,
        procedure
        begin
          Application.ProcessMessages
        end
      );
  End;
end;


procedure TProcessoAguarde.CreateImage;
Var
  LcRand : String;
  Lc_I : Integer;
Begin
  LcRand := IntToStr(Random(10000));
  FPanel := TPanel.Create(FTela);
  FPanel.Name := concat('Pnl_ProceAguarde',LcRand) ;
  with FPanel do
  Begin
    Visible := False;
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
    Color := clBtnFace;
    Top := -115;//trunc((FTela.Height - FPanel.Height)/2);
    Left := trunc((FTela.Width - FPanel.Width)/2);
  End;
  //Cria imagens
  FImagem := TImage.Create(FPanel);
  FImagem.Name := concat('Img_ProceAguarde',LcRand) ;
  with FImagem do
  Begin
    Align := alClient;
    Parent := FPanel;
    Transparent := False;
    Center := True;
    Top := 3;
    Left := 8;
    Picture := FPicture;
    AutoSize := True;
    Stretch := False;

  End;
  (FImagem.Picture.Graphic as TGIFImage).Animate := True;
  FPanel.Visible := True;
  for Lc_I := 1 to 12 do
  Begin
    FPanel.Top := -118 + (Lc_I * 10) ;
    FPanel.Update;
  end;
  FTela.BringToFront;
end;


procedure TProcessoAguarde.stop;
Var
  Lc_I,Lc_J : Integer;
  Lc_Achou : Boolean;
  LcImg: TImage;
  LcPanel: TPanel;
Begin
  for Lc_I := 0 to FTela.ComponentCount - 1 do
  begin
    //Limpa Painel
    if (FTela.Components[Lc_I].ClassType = TPanel) then
    begin
      if (Copy(TPanel(FTela.Components[Lc_I]).Name,1,16) = 'Pnl_ProceAguarde') then
      begin
        for Lc_J := 0 to TPanel(FTela.Components[Lc_I]).ComponentCount - 1 do
        Begin
          if (TPanel(FTela.Components[Lc_I]).Components[Lc_J].ClassType = TImage) then
          Begin
            LcImg := TImage(TPanel(FTela.Components[Lc_I]).Components[Lc_J]);
            FreeAndNil(LcImg);
            LcPanel := TPanel(FTela.Components[Lc_I]);
            FreeAndNil(LcPanel);
            Lc_Achou := True;
            Break;
          End;
        End;
      end;
    end;
    if Lc_Achou then Break;
  end;
  terminate;
end;

end.
