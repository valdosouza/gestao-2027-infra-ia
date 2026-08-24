unit Un_imp_produtos_movimento;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Un_Base, Vcl.Menus;

type
  TFr_imp_produtos_movimento = class(TFr_Base)
    Rg_Tipo: TRadioGroup;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    //Variaveis
    procedure ImagemBotao;Override;
    //Teclas de atalhos
    procedure execShorCutKeyF10;Override;
    procedure execShorCutEsc;Override;


  public
    { Public declarations }
  end;

var
  Fr_imp_produtos_movimento: TFr_imp_produtos_movimento;

implementation

{$R *.dfm}

{ TFr_imp_produtos_movimento }

procedure TFr_imp_produtos_movimento.execShorCutEsc;
begin
  inherited;

end;

procedure TFr_imp_produtos_movimento.execShorCutKeyF10;
begin
  inherited;

end;

procedure TFr_imp_produtos_movimento.ImagemBotao;
begin
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TFr_imp_produtos_movimento.SB_ConfirmarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFr_imp_produtos_movimento.SB_Sair_0Click(Sender: TObject);
begin
  inherited;
  Rg_Tipo.ItemIndex := -1;
  Close;
end;

end.
