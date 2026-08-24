unit Un_FrenteCaixaProdAvulso;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.ExtCtrls, Vcl.Menus, System.Math;

type
  TFr_FrenteCaixaProdAvulso = class(TFr_Base)
    Pnl_ValorAvulso: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    E_Vl_Avulso: TEdit_Setes;
    E_Vl_Tl_Avulso: TPanel;
    E_Qt_Avulso: TEdit_Setes;
    Sb_Confirma: TButton;
    Sb_Cancela: TButton;
    Label37: TLabel;
    E_Avl_Descricao: TEdit;
    pnl_Rodape: TPanel;
    procedure Sb_CancelaClick(Sender: TObject);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure E_Vl_AvulsoExit(Sender: TObject);
    procedure E_Qt_AvulsoExit(Sender: TObject);
    procedure E_Qt_AvulsoEnter(Sender: TObject);
    procedure E_Vl_AvulsoEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    Function Fc_ValidaValorAvulso:Boolean;
    Procedure Pc_CalculoProdutoAvulso;
  protected
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
    Confirma : Boolean;
  end;

var
  Fr_FrenteCaixaProdAvulso: TFr_FrenteCaixaProdAvulso;

implementation

uses     Un_Msg, env;
{$R *.dfm}

procedure TFr_FrenteCaixaProdAvulso.E_Qt_AvulsoEnter(Sender: TObject);
begin
  inherited;
  (Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_FrenteCaixaProdAvulso.E_Qt_AvulsoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Qt_Avulso.Text,1);
  E_Qt_Avulso.Text := FloatToStrf(Lc_Valor,ffFixed,10,3);
  Pc_CalculoProdutoAvulso;
end;

procedure TFr_FrenteCaixaProdAvulso.E_Vl_AvulsoEnter(Sender: TObject);
begin
  (Sender as TEdit_Setes).SelectAll;
end;

procedure TFr_FrenteCaixaProdAvulso.E_Vl_AvulsoExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Vl_Avulso.Text,1);
  E_Vl_Avulso.Text := FloatToStrf(Lc_Valor,ffFixed,10,2);
  Pc_CalculoProdutoAvulso;
end;

Function TFr_FrenteCaixaProdAvulso.Fc_ValidaValorAvulso:Boolean;
Begin
  Result := true;
  if StrToFloatDef(E_Vl_Tl_Avulso.Caption,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Valor Unitário deve ser maior do que zero.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if E_Qt_Avulso.CanFocus then E_Vl_Avulso.SetFocus;
    exit;
  end;
end;

procedure TFr_FrenteCaixaProdAvulso.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
      case Key of
      VK_F5  : if Sb_confirma.Enabled then Sb_confirmaClick(Sender);
      VK_Escape : if Sb_Cancela.Enabled then Sb_CancelaClick(Sender);
    end;
  end;
end;

Procedure TFr_FrenteCaixaProdAvulso.Pc_CalculoProdutoAvulso;
Var
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Total : Real;
Begin
  Lc_Qtde := StrToFloatDef(E_Qt_Avulso.Text,1);
  Lc_Valor := StrToFloatDef(E_VL_Avulso.Text,1);
  Lc_Total := Lc_Qtde * Lc_Valor;
  Lc_Total := RoundTo( Lc_Total ,-3);
  E_Vl_Tl_Avulso.Caption := FloatToStrf(Lc_Total,ffFixed,10,2);
end;


procedure TFr_FrenteCaixaProdAvulso.IniciaVariaveis;
begin
  inherited;
  if E_Avl_Descricao.CanFocus then E_Avl_Descricao.SetFocus;
  E_Avl_Descricao.SelectAll;
end;

procedure TFr_FrenteCaixaProdAvulso.Sb_CancelaClick(Sender: TObject);
begin
  inherited;
  Confirma := False;
  Close;
end;

procedure TFr_FrenteCaixaProdAvulso.Sb_ConfirmaClick(Sender: TObject);
begin
  if Fc_ValidaValorAvulso then
  Begin
    Confirma := True;
    Close;
  End;
end;

end.

