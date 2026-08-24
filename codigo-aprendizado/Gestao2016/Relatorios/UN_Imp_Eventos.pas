unit UN_Imp_Eventos;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, DB, ComCtrls;

type
   TFr_Imp_Eventos = class(TForm)
      Ds_Colaborador: TDataSource;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel1: TPanel;
    Label3: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Dblcb_Vendedor: TDBLookupComboBox;
    RG_Tipo: TRadioGroup;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Dblcb_VendedorKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
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
   Fr_Imp_Eventos: TFr_Imp_Eventos;

implementation

uses     UN_RL_Comi_Detal, Un_DM, Un_Excel, UN_Sistema, Un_RL_Eventos_Flha, UN_Principal, env, Un_Regra_Negocio;

{$R *.dfm}

procedure TFr_Imp_Eventos.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_LimpaQrPreviweMemoria;
    if not Assigned(RL_Eventos_Flha) then
      Application.CreateForm(TRL_Eventos_Flha, RL_Eventos_Flha);
    RL_Eventos_Flha.Qrpt.Preview;
  finally
    RL_Eventos_Flha.Close
  end;
end;

procedure TFr_Imp_Eventos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_Eventos.FormCreate(Sender: TObject);
begin
   Pc_ListarColaborador;
   RG_Tipo.ItemIndex := 0;
   E_Data_INI.Date := Date;
   E_Data_FIM.Date := Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;   
end;

procedure TFr_Imp_Eventos.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Eventos.Dblcb_VendedorKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        Dblcb_Vendedor.KeyValue := Null;
        end;
      end;
end;

procedure TFr_Imp_Eventos.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
      if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
      Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      if not Assigned(RL_Comi_Detal) then (Application.CreateForm(TRL_Comi_Detal, RL_Comi_Detal));
      RL_Comi_Detal.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Comi_Detal.Qr_Comissao, Lc_CAminho);
    finally
      RL_Comi_Detal.Close;
    end;
  end;
end;

procedure TFr_Imp_Eventos.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Eventos.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Vales');
end;

procedure TFr_Imp_Eventos.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TFr_Imp_Eventos.Pc_ImagemBotao;
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

