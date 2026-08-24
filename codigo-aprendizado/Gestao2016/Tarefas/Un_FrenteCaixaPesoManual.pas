unit Un_FrenteCaixaPesoManual;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.ExtCtrls, System.Math;

type
  TFr_FrenteCaixaPesoManual = class(TFr_Base)
    Pnl_BalancaManual: TPanel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Sb_confirma: TButton;
    E_Vl_PesoManual: TPanel;
    Sb_cancela: TButton;
    E_Peso_LiquidoManual: TEdit_Setes;
    pnl_Rodape: TPanel;
    E_Vl_UnitarioManual: TEdit_Setes;
    procedure Sb_cancelaClick(Sender: TObject);
    procedure Sb_confirmaClick(Sender: TObject);
    procedure E_Peso_LiquidoManualExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure E_Vl_UnitarioManualExit(Sender: TObject);
    procedure E_Vl_UnitarioManualEnter(Sender: TObject);
  private
    { Private declarations }
    Function Fc_ValidaInsereProdutoPesoManual:Boolean;
    procedure Totalizador;
  protected
    procedure IniciaVariaveis;Override;
  public
    { Public declarations }
    Confirma : Boolean;
  end;

var
  Fr_FrenteCaixaPesoManual: TFr_FrenteCaixaPesoManual;

implementation

uses     Un_Msg, env;

{$R *.dfm}

procedure TFr_FrenteCaixaPesoManual.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_FrenteCaixaPesoManual.IniciaVariaveis;
begin
  inherited;
  E_Peso_LiquidoManual.SetFocus;
  E_Peso_LiquidoManual.SelectAll;
end;

procedure TFr_FrenteCaixaPesoManual.Sb_cancelaClick(Sender: TObject);
begin
  inherited;
  Confirma := False;
  Close;
end;

procedure TFr_FrenteCaixaPesoManual.Sb_confirmaClick(Sender: TObject);
begin
  if Fc_ValidaInsereProdutoPesoManual then
  Begin
    Confirma := True;
    Close;
  End;
end;

procedure TFr_FrenteCaixaPesoManual.Totalizador;
Var
  Lc_Peso :Real;
  Lc_Vl_Unit : Real;
  Lc_total : Real;
begin
  Lc_Peso := StrToFloatDef(E_Peso_LiquidoManual.text,0);
  IF Lc_Peso > 0 then
  Begin
    E_Peso_LiquidoManual.Text := FloatToStrF(Lc_Peso,ffFixed,10,3);
    Lc_Vl_Unit := StrToFloatDef(E_Vl_UnitarioManual.Text,0);
    Lc_total := (Lc_Vl_Unit * Lc_Peso);
    Lc_total := RoundTo( Lc_total,-2);
    E_Vl_PesoManual.Caption := FloatToStrF(Lc_total,ffFixed,10,2);
  end
  else
  Begin
    E_Vl_PesoManual.caption := '0,00';
  End;
end;

procedure TFr_FrenteCaixaPesoManual.E_Peso_LiquidoManualExit(Sender: TObject);
begin
  Totalizador;
end;

procedure TFr_FrenteCaixaPesoManual.E_Vl_UnitarioManualEnter(Sender: TObject);
begin
  inherited;
  TEdit_Setes(Sender).SelectAll;
end;

procedure TFr_FrenteCaixaPesoManual.E_Vl_UnitarioManualExit(Sender: TObject);
begin
  inherited;
  Totalizador;
end;

Function TFr_FrenteCaixaPesoManual.Fc_ValidaInsereProdutoPesoManual:Boolean;
Begin
  Result := true;
  if StrToFloatDef(E_Vl_UnitarioManual.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Valor Unitário deve ser maior do que zero.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if StrToFloatDef(E_Peso_LiquidoManual.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Peso deve ser maior do que zero.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
  Totalizador;
end;

end.
