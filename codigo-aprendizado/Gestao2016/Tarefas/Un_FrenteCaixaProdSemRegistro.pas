unit Un_FrenteCaixaProdSemRegistro;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.ExtCtrls, Vcl.Menus, Un_Msg, System.Math;

type
  TFr_FrenteCaixaProdSemRegistro = class(TFr_Base)
    Pnl_Prod_Sem_Registro: TPanel;
    Label25: TLabel;
    Label28: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    E_Avl_Vl_Unitario: TEdit_Setes;
    E_Avl_Subtotal: TPanel;
    E_Avl_Qtde: TEdit_Setes;
    E_Avl_Descricao: TEdit;
    E_Avl_Medida: TEdit;
    Sb_Confirma: TButton;
    Sb_Cancela: TButton;
    pnl_rodape: TPanel;
    procedure Sb_CancelaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure Sb_CancelaClick(Sender: TObject);
    procedure E_Avl_QtdeExit(Sender: TObject);
    procedure E_Avl_Vl_UnitarioExit(Sender: TObject);
    procedure E_Avl_Vl_UnitarioEnter(Sender: TObject);
    procedure E_Avl_QtdeEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    Procedure Pc_CalculoProdutoSemRegistro;
  protected
    EditionState : String;
    procedure IniciaVariaveis;Override;
    function Fc_ValidaInsereProdutoSemRegistro():Boolean;
  public
    { Public declarations }
    Confirma : Boolean;
  end;

var
  Fr_FrenteCaixaProdSemRegistro: TFr_FrenteCaixaProdSemRegistro;

implementation

{$R *.dfm}

uses     env;

{ TFr_FrenteCaixaProdSemRegistro }

Procedure TFr_FrenteCaixaProdSemRegistro.Pc_CalculoProdutoSemRegistro;
Var
  Lc_Qtde : Real;
  Lc_Valor : Real;
  Lc_Total : Real;
Begin
  Lc_Qtde := StrToFloatDef(E_Avl_Qtde.Text,0);
  Lc_Valor := StrToFloatDef(E_Avl_Vl_Unitario.Text,0);
  Lc_total := Lc_Qtde * Lc_Valor;
  Lc_total := RoundTo( Lc_total,-2);
  E_Avl_Subtotal.Caption := FloatToStrf(Lc_Total,ffFixed,10,2);
end;

procedure TFr_FrenteCaixaProdSemRegistro.IniciaVariaveis;
begin
  inherited;
  if E_Avl_Descricao.CanFocus then E_Avl_Descricao.SetFocus;
end;


procedure TFr_FrenteCaixaProdSemRegistro.Sb_CancelaClick(Sender: TObject);
begin
  inherited;
  Confirma := False;
  Close;
end;

procedure TFr_FrenteCaixaProdSemRegistro.Sb_CancelaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (shift = []) then
  begin
      case Key of
      VK_F5  : if Sb_confirma.Enabled then Sb_confirmaClick(Sender);
      VK_Escape : if Sb_Cancela.Enabled then Sb_CancelaClick(Sender);
    end;
  end;
end;

procedure TFr_FrenteCaixaProdSemRegistro.Sb_ConfirmaClick(Sender: TObject);
begin
  if Fc_ValidaInsereProdutoSemRegistro then
  Begin
    Confirma := True;
    Close;
  End;
end;

procedure TFr_FrenteCaixaProdSemRegistro.E_Avl_QtdeEnter(Sender: TObject);
begin
  inherited;
  E_Avl_Qtde.SelectAll;
end;

procedure TFr_FrenteCaixaProdSemRegistro.E_Avl_QtdeExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Avl_Qtde.Text,0);
  E_Avl_Qtde.Text := FloatToStrf(Lc_Valor,ffFixed,10,3);
  Pc_CalculoProdutoSemRegistro;
end;

procedure TFr_FrenteCaixaProdSemRegistro.E_Avl_Vl_UnitarioEnter(
  Sender: TObject);
begin
  inherited;
  E_Avl_Vl_Unitario.SelectAll;
end;

procedure TFr_FrenteCaixaProdSemRegistro.E_Avl_Vl_UnitarioExit(Sender: TObject);
Var
  Lc_Valor : Real;
begin
  Lc_Valor := StrToFloatDef(E_Avl_Vl_Unitario.Text,0);
  E_Avl_Vl_Unitario.Text := FloatToStrf(Lc_Valor,ffFixed,10,2);
  Pc_CalculoProdutoSemRegistro;
end;

function TFr_FrenteCaixaProdSemRegistro.Fc_ValidaInsereProdutoSemRegistro():Boolean;
Begin
  Result := True;
  if (Length(E_Avl_Descricao.Text) < 2) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'A descrição do produto deve ter um tamanho mínimo de 2 caracteres.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    E_Avl_Descricao.SetFocus;
    E_Avl_Descricao.SelectAll;
    Result := false;
    exit;
  end;
  if (Length(E_Avl_Medida.Text) <3) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'A unidade do produto deve ter um tamanho mínimo de 3 caracteres.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    E_Avl_Medida.SetFocus;
    E_Avl_Medida.SelectAll;
    Result := false;
    exit;
  end;
  if StrToFloatDef(E_Avl_Qtde.Text,0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'A quantidade do produto deve ser maior do que zero.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    E_Avl_Qtde.SetFocus;
    E_Avl_Qtde.SelectAll;
    Result := false;
    exit;
  end;
  if StrToFloatDef(E_Avl_Vl_Unitario.Text,0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Valor Unitário do produto deve ser maior do que zero.'+EOLN +
                   'Verifique antes de continuar.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    E_Avl_Vl_Unitario.SetFocus;
    E_Avl_Vl_Unitario.SelectAll;
    Result := false;
    exit;
  end;

end;
procedure TFr_FrenteCaixaProdSemRegistro.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (shift = []) then
  begin
      case Key of
      VK_F5  : if Sb_confirma.Enabled then Sb_confirmaClick(Sender);
      VK_Escape : if Sb_Cancela.Enabled then Sb_CancelaClick(Sender);
    end;
  end;
end;

end.
