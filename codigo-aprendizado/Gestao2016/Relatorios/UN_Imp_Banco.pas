unit UN_Imp_Banco;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows;

type
   TFr_Imp_Banco = class(TForm)
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Pnl_Parametros: TPanel;
    Label3: TLabel;
    RG_Tipo: TRadioGroup;
    E_Historico: TEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Pnl_botao: TPanel;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
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
   Fr_Imp_Banco: TFr_Imp_Banco;

implementation

uses     UN_RL_Lanca_BAnco, Un_Excel, UN_Sistema, UN_Principal, env, Un_DM, Un_Regra_Negocio;

{$R *.dfm}

procedure TFr_Imp_Banco.SB_ImprimirClick(Sender: TObject);
Var
  LcForm : TRL_Lanca_Banco;
begin
  try
    Pc_LimpaQrPreviweMemoria;
    LcForm  := TRL_Lanca_Banco.create(Self);
    LcForm.Qrpt.Preview;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Imp_Banco.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F2: if Sb_Exportar.Enabled then  Sb_ExportarClick(Sender);
         VK_F3: if SB_Imprimir.Enabled then  SB_ImprimirClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
      end;
   end;
end;

procedure TFr_Imp_Banco.FormCreate(Sender: TObject);
begin
   RG_Tipo.ItemIndex := 0;
   E_Data_INI.Date := Date;
   E_Data_FIM.Date := Date;
   ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;   
end;

procedure TFr_Imp_Banco.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Banco.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
      if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
      Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      if not Assigned(RL_Lanca_Banco) then Application.CreateForm(TRL_Lanca_Banco, RL_Lanca_Banco);
      RL_Lanca_Banco.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Lanca_Banco.Qr_Movimentacao, Lc_CAminho);
    finally
      RL_Lanca_Banco.Close;
    end;
  end;
end;

procedure TFr_Imp_Banco.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Banco.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
  Pc_PermissaoBotao('Lançamentos');
end;

procedure TFr_Imp_Banco.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TFr_Imp_Banco.Pc_ImagemBotao;
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

