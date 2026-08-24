unit Un_FrenteCaixaPesoBalanca;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Vcl.ExtCtrls, ACBrBase, ACBrBAL, UN_Sistema, ACBrDevice, ACBrDeviceSerial, System.Math;

type
  TFr_FrenteCaixaPesoBalanca = class(TFr_Base)
    Pnl_Balanca: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    E_Peso_Liquido: TPanel;
    Sb_Confirma: TButton;
    E_Vl_Peso: TPanel;
    Sb_Cancela: TButton;
    Sb_LePeso: TButton;
    E_VL_Unitario: TEdit_Setes;
    Balanca: TACBrBAL;
    pnl_Rodape: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure Sb_LePesoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sb_CancelaClick(Sender: TObject);

  private
    { Private declarations }
    procedure IniciaVariaveis;Override;
    Function Fc_ValidaInsereProdutoPeso:Boolean;
  public
    { Public declarations }
    Confirma : Boolean;
  end;

var
  Fr_FrenteCaixaPesoBalanca: TFr_FrenteCaixaPesoBalanca;

implementation

uses     Un_Msg, env;

{$R *.dfm}

procedure TFr_FrenteCaixaPesoBalanca.FormCreate(Sender: TObject);
begin
  Confirma := False;
end;

procedure TFr_FrenteCaixaPesoBalanca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
      case Key of
      VK_F4  : if Sb_LePeso.Enabled then Sb_LePesoClick(Sender);
      VK_F5  : if Sb_Confirma.Enabled then Sb_ConfirmaClick(Sender);
      VK_Escape : if Sb_Cancela.Enabled then Sb_CancelaClick(Sender);
    end;
  end;
end;

procedure TFr_FrenteCaixaPesoBalanca.IniciaVariaveis;
begin
  Balanca.Desativar;
  // configura porta de comunicação
  Balanca.Modelo           := TACBrBALModelo( StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_MODELO',''),0) );
  Balanca.Device.HandShake :=  TACBrHandShake( StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_HANDSHAKE',''),0) );
  Balanca.Device.Parity    := TACBrSerialParity( StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_PARIDADE',''),0) );
  Balanca.Device.Stop      := TACBrSerialStop( StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_BITSPARADA',''),0));
  Balanca.Device.Data      := StrToInt( Fc_Aq_Geral('L','BALANCA','BAL_P_DATABITS','') );
  Balanca.Device.Baud      := StrToInt( Fc_Aq_Geral('L','BALANCA','BAL_P_BAUDRATE','') );
  Balanca.Device.Porta     := Fc_Aq_Geral('L','BALANCA','BAL_P_PORTA','');
  Balanca.Device.TimeOut := StrToIntdef(Fc_Aq_Geral('L','BALANCA','BAL_P_TIMER',''),100);

end;

procedure TFr_FrenteCaixaPesoBalanca.Sb_CancelaClick(Sender: TObject);
begin
  Confirma := False;
  Close;
end;

procedure TFr_FrenteCaixaPesoBalanca.Sb_ConfirmaClick(Sender: TObject);
begin
  if Fc_ValidaInsereProdutoPeso then
  Begin
    Confirma := True;
    Close;
  End;
end;

procedure TFr_FrenteCaixaPesoBalanca.Sb_LePesoClick(Sender: TObject);
var
  Lc_Vl_Unit, Lc_Peso, Lc_total : Real;
  Lc_Time : Integer;
begin
  try
    try
      Sb_LePeso.Enabled := False;
      Lc_time := StrToIntDef(Fc_Aq_Geral('L','BALANCA','BAL_P_TIMER',''),100);
      Balanca.Ativar;
      Lc_Peso := Balanca.LePeso(Lc_time);
    except
      E_Vl_Peso.Caption := '0,00';
    end;
  Finally
    Balanca.Desativar;
    IF Lc_Peso < 0 then Lc_Peso := 0;
    E_Peso_Liquido.Caption := FloatToStrF(Lc_Peso,ffFixed,10,3);
    Lc_Vl_Unit := StrToFloatDef(E_Vl_Unitario.Text,0);

    Lc_total := Lc_Vl_Unit * Lc_Peso;
    Lc_total := RoundTo( Lc_total,-2);
    E_Vl_Peso.Caption := FloatToStrF(Lc_total,ffFixed,10,2);
    Sb_LePeso.Enabled := True;
  end;
end;

Function TFr_FrenteCaixaPesoBalanca.Fc_ValidaInsereProdutoPeso:Boolean;
Begin
  Result := true;
  if StrToFloatDef(E_Vl_Unitario.Text,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Valor Unitário deve ser maior do que zero.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;

  if StrToFloatDef(E_Peso_Liquido.Caption,0) = 0 then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O Peso da balançadeve ser maior do que zero.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;
end;

end.
