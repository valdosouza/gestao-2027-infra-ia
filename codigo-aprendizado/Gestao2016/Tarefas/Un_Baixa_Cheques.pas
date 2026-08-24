unit Un_Baixa_Cheques;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Un_Base, Vcl.Menus;

type
  TFr_Baixa_Cheques = class(TFr_Base)
    Panel1: TPanel;
    Rg_Escolha: TRadioGroup;
    SB_Confirmar: TSpeedButton;
    Sb_Sair: TSpeedButton;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure Sb_SairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FEscolha: Integer;
    procedure Pc_ImagemBotao;
    procedure setFEscolha(const Value: Integer);
  public
    property Escolha : Integer read FEscolha write setFEscolha;

  end;

var
  Fr_Baixa_Cheques: TFr_Baixa_Cheques;

implementation

uses     UN_Sistema, UN_Principal, env, reg_ctrl_cheque;

{$R *.dfm}

procedure TFr_Baixa_Cheques.SB_ConfirmarClick(Sender: TObject);
begin
  Escolha := Rg_Escolha.ItemIndex;
  close;
end;

procedure TFr_Baixa_Cheques.Sb_SairClick(Sender: TObject);
begin
  Escolha := -1;
  close;
end;


procedure TFr_Baixa_Cheques.setFEscolha(const Value: Integer);
begin
  FEscolha := Value;
end;

procedure TFr_Baixa_Cheques.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Baixa_Cheques.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
end;

end.
