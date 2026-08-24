unit UN_Imp_ExtratoBancario;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, DB, ComCtrls, Un_Fm_ListaContaBancaria, Un_Fm_ListaUsuarios;

type
   TFr_Imp_ExtratoBancario = class(TForm)
    Panel1: TPanel;
    SB_Imprimir: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel2: TPanel;
    RG_Data: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Rg_Tipo: TRadioGroup;
    Ds_Usuario: TDataSource;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    Fm_ListaUsuario: TFm_ListaUsuarios;
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure RG_DataClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;    
     procedure Pc_PermissaoBotao(Pc_Menu: string);
     procedure Pc_ImagemBotao;      
   end;

var
   Fr_Imp_ExtratoBancario: TFr_Imp_ExtratoBancario;

implementation

uses     UN_RL_ExtratoBancario, Un_DM, Un_Excel, UN_Sistema, UN_Principal, env;

{$R *.dfm}



procedure TFr_Imp_ExtratoBancario.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Imp_ExtratoBancario.SB_ImprimirClick(Sender: TObject);
Var
  LcForm : TRl_ExtratoBancario;
begin
  try
    Pc_LimpaQrPreviweMemoria;
    LcForm := TRl_ExtratoBancario.create(self);
    LcForm.Qrpt.Preview;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Imp_ExtratoBancario.RG_DataClick(Sender: TObject);
begin
  case RG_Data.ItemIndex of
    0:begin
      E_Data_INI.Date := Date;
      E_Data_Fim.Date := Date;
      end;
    1:begin
      E_Data_INI.Date := Date - 7;
      E_Data_Fim.Date := Date;
      end;
    2:begin
      E_Data_INI.Date := Date - 30;
      E_Data_Fim.Date := Date;
      end;
  end;
end;

procedure TFr_Imp_ExtratoBancario.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_ExtratoBancario.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
      if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
      Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      if not Assigned(RL_ExtratoBancario) then  Application.CreateForm(TRL_ExtratoBancario, RL_ExtratoBancario);
      RL_ExtratoBancario.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_ExtratoBancario.Qr_Movimentacao, Lc_CAminho);
    finally
      RL_ExtratoBancario.Close;
    end;
  end;
end;

procedure TFr_Imp_ExtratoBancario.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    It_Exportar     := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar      := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
   Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_ExtratoBancario.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Extrato');
  Fm_ListaContaBancaria.Listar;
  Fm_ListaUsuario.Pc_Listar;
  RG_Data.ItemIndex := 0;
  Rg_Tipo.ItemIndex := 2;
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
end;

procedure TFr_Imp_ExtratoBancario.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_ExtratoBancario.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph := (Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph := (Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph := (Fc_CarregaImagemBotao('SAIR'));
    END;
end;
end.

