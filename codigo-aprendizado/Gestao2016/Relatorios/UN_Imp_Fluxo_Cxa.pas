unit UN_Imp_Fluxo_Cxa;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, ComCtrls;

type
   TFr_Imp_Fluxo_Cxa = class(TForm)
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel1: TPanel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Label3: TLabel;
    CB_Tipo: TComboBox;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;
     procedure Pc_Exc_Fluxo;
     procedure Pc_PermissaoBotao(Pc_Menu: string);
     procedure Pc_ImagemBotao;
   end;

var
   Fr_Imp_Fluxo_Cxa: TFr_Imp_Fluxo_Cxa;

implementation

uses     Un_RL_Fluxo_Cxa, Un_Excel, UN_Sistema, UN_Principal, env, Un_DM, Un_Regra_Negocio, Un_RL_Fluxo_Cxa_Simulado;


{$R *.dfm}


procedure TFr_Imp_Fluxo_Cxa.Pc_Exc_Fluxo;
begin

end;

procedure TFr_Imp_Fluxo_Cxa.SB_ImprimirClick(Sender: TObject);
begin
  case CB_Tipo.ItemIndex of
    0:Begin
      try
        Pc_LimpaQrPreviweMemoria;
        if not Assigned(RL_Fluxo_Cxa) then (Application.CreateForm(TRL_Fluxo_Cxa, RL_Fluxo_Cxa));
        RL_Fluxo_Cxa.Qrpt.Preview;
      finally
        RL_Fluxo_Cxa.Close
      end;
      end;
      1:Begin
        try
          Pc_LimpaQrPreviweMemoria;
          if not Assigned(RL_Fluxo_Cxa_Simulado) then (Application.CreateForm(TRL_Fluxo_Cxa_Simulado, RL_Fluxo_Cxa_Simulado));
          RL_Fluxo_Cxa_Simulado.Qrpt.Preview;
        finally
          RL_Fluxo_Cxa_Simulado.Close
        end;
        end;
    end;
end;

procedure TFr_Imp_Fluxo_Cxa.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_Fluxo_Cxa.FormCreate(Sender: TObject);
begin
   E_Data_INI.Date := Date;
   E_Data_FIM.Date := Date;
end;

procedure TFr_Imp_Fluxo_Cxa.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Fluxo_Cxa.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
      if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
      Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      if not Assigned(RL_Fluxo_Cxa) then Application.CreateForm(TRL_Fluxo_Cxa, RL_Fluxo_Cxa);
      RL_Fluxo_Cxa.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Fluxo_Cxa.Qr_Fluxo, Lc_CAminho);
    finally
      RL_Fluxo_Cxa.Close;
    end;
  end;
end;

procedure TFr_Imp_Fluxo_Cxa.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Fluxo_Cxa.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
   Pc_PermissaoBotao('Fluxo de Caixa');
end;

procedure TFr_Imp_Fluxo_Cxa.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Fluxo_Cxa.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TFr_Imp_Fluxo_Cxa.Pc_ImagemBotao;
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

