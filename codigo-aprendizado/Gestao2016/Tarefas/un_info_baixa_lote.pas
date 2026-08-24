unit un_info_baixa_lote;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, DBCtrls, DB, ComCtrls, ExtCtrls, Un_Fm_ListaContaBancaria;

type
  Tfr_info_baixa_lote = class(TForm)
    Panel1: TPanel;
    pnl_fundos: TPanel;
    Label2: TLabel;
    E_Data_Pag: TDateTimePicker;
    SB_Gravar: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;

      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    IT_TIPO:STRING;
    function Fc_validaGravacao:Boolean;
    procedure Pc_ImagemBotao;
  end;

var
  fr_info_baixa_lote: Tfr_info_baixa_lote;

implementation

uses     Un_DM, sea_banking_account, un_receber_baixa_lote, UN_MSG, UN_Sistema, UN_Principal, env;

{$R *.dfm}

procedure Tfr_info_baixa_lote.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=caFree;
  fr_info_baixa_lote:=nil;
end;

procedure Tfr_info_baixa_lote.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  E_Data_Pag.Date:=Now;
  E_Data_Pag.SetFocus;
  Fm_ListaContaBancaria.Listar;
  if IT_TIPO = 'caixa' then
  begin
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue := 0;
    Fm_ListaContaBancaria.Enabled := false;
  end
  else
  begin
    Fm_ListaContaBancaria.Enabled := True;
  end;
end;

procedure Tfr_info_baixa_lote.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;

procedure Tfr_info_baixa_lote.SB_GravarClick(Sender: TObject);
begin
  IF Fc_validaGravacao THEN
  BEGIN
    Screen.Cursor:= crHourGlass;
    FR_RECEBER_BAIXA_LOTE.it_baixa:=true;
    if Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue >  0  then
      FR_RECEBER_BAIXA_LOTE.it_cod_ContBanc:= Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue
    else
      FR_RECEBER_BAIXA_LOTE.it_cod_ContBanc:= 0;
    FR_RECEBER_BAIXA_LOTE.it_dt_pag:= E_Data_Pag.Date;
    Screen.Cursor:= crDefault;
  END;
  close;
end;

procedure Tfr_info_baixa_lote.Sb_CancelarClick(Sender: TObject);
begin
  FR_RECEBER_BAIXA_LOTE.it_baixa:=false;
  CLOSE;
end;

procedure Tfr_info_baixa_lote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
      VK_F6 : If SB_Cancelar.Enabled then SB_CancelarClick(Sender);
    end;
  end;  
end;

function Tfr_info_baixa_lote.Fc_validaGravacao: Boolean;
begin
  Result:=true;
  if (IT_TIPO= 'banco') and (Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue < 1) then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Campo Conta Bancária não preenchido.' + EOLN +
                   ' Preencha a Conta Bancária.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    exit;
  end;
end;

end.
