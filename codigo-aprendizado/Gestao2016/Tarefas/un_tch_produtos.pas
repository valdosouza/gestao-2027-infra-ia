unit un_tch_produtos;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TFr_tch_produtos = class(TFr_Base)
    pg_geral: TPageControl;
    Panel1: TPanel;
    tbs_sonhos: TTabSheet;
    tbs_combos: TTabSheet;
    tbs_donuts: TTabSheet;
    tbs_roscas: TTabSheet;
    tbs_alfajor: TTabSheet;
    tbs_diversos: TTabSheet;
    tbs_bebidas: TTabSheet;
    Sb_Cancelar: TSpeedButton;
    e_qtde: TEdit;
    sb_decrease: TSpeedButton;
    sb_increase: TSpeedButton;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    Panel4: TPanel;
    Label4: TLabel;
    Panel5: TPanel;
    Label5: TLabel;
    Panel6: TPanel;
    Label6: TLabel;
    Panel7: TPanel;
    Label7: TLabel;
    Panel8: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    SpeedButton41: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    procedure sb_decreaseClick(Sender: TObject);
    procedure sb_increaseClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InsertItem(Sender: TObject);
  private
    { Private declarations }
    procedure formataTela;
    procedure ApplyComand;

  public
    { Public declarations }
    SubGrupo : Integer;
  end;

var
  Fr_tch_produtos: TFr_tch_produtos;

implementation

{$R *.dfm}

uses     Un_FrenteCaixa;

procedure TFr_tch_produtos.ApplyComand;
Var
  I,J:Integer;
begin
  for I := 0 to ((ComponentCount)-1) do
  begin
    if (Components[I].ClassName = 'TSpeedButton') then
    Begin
      if (TSpeedButton(Components[I]).Name <> 'sb_increase') and
         (TSpeedButton(Components[I]).Name <> 'sb_decrease') and
         (TSpeedButton(Components[I]).Name <> 'Sb_Cancelar') then
      Begin
        TSpeedButton(Components[I]).OnClick := InsertItem;
      End;
    End;
  end;
end;

procedure TFr_tch_produtos.formataTela;
Var
  X : Integer;
begin
  for X := 1 to pg_geral.PageCount do
    pg_geral.Pages[X - 1].TabVisible := False;

  case SubGrupo of
    //Sonhos
    1 :pg_geral.ActivePage := tbs_sonhos;
    //Combos
    2 :pg_geral.ActivePage := tbs_donuts;
    //Donuts
    3 :pg_geral.ActivePage := tbs_alfajor;
    //Roscas
    4 :pg_geral.ActivePage := tbs_roscas;
    //Alfajor
    5 :pg_geral.ActivePage := tbs_diversos;
    //Outros
    7 :pg_geral.ActivePage := tbs_combos;
    //bebidas
    8 :pg_geral.ActivePage := tbs_bebidas;
  end;

end;

procedure TFr_tch_produtos.FormShow(Sender: TObject);
begin
  formataTela;
  ApplyComand;
end;

procedure TFr_tch_produtos.InsertItem(Sender: TObject);
begin
  with fr_FrenteCaixa do
  Begin
    E_Qtde.Text := Self.e_qtde.Text;
    E_BuscaCodigo.Text := InttoStr(TSpeedButton(Sender).Tag);
    if Fc_LancaItem then
    BEgin
      //totaliza os itens na tela
      Pc_SomaProdutos;
      Pc_Totalizador;
      Pc_ImprimeItemCheckout;
    End;
    //Limpa os campos
    if E_BuscaCodigo.CanFocus then E_BuscaCodigo.SetFocus;
    E_BuscaCodigo.Clear;
    e_qtde.Text := '1';
  End;
  Self.Close;
end;

procedure TFr_tch_produtos.Sb_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_tch_produtos.sb_decreaseClick(Sender: TObject);
Var
  LcQtde : Integer;
begin
  LcQtde := StrToIntDef(e_qtde.Text,0);
  LcQtde := LcQtde - 1;
  if LcQtde = 0 then LcQtde := 1;
  E_qtde.Text := IntToStr(LcQtde);
end;

procedure TFr_tch_produtos.sb_increaseClick(Sender: TObject);
Var
  LcQtde : Integer;
begin
  LcQtde := StrToIntDef(e_qtde.Text,0);
  LcQtde := LcQtde + 1;
  if LcQtde = 0 then LcQtde := 1;
  E_qtde.Text := IntToStr(LcQtde);
end;

end.
