unit UN_Imp_CtasPagar;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.DBCtrls;

type
   TFr_Imp_CtasPagar = class(TForm)
    Ds_Fornecedor: TDataSource;
    Qr_Fornece: TSTQuery;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    CB_Tipo: TComboBox;
    RG_Tipo: TRadioGroup;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure DBLCB_FornecedorKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure ChBx_NomeClick(Sender: TObject);
      procedure ChBx_FantasiaClick(Sender: TObject);
      procedure Qr_ForneceAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Imprimir:Boolean;
    It_Exportar:Boolean;
    It_Visualizar:Boolean;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
   end;

var
   Fr_Imp_CtasPagar: TFr_Imp_CtasPagar;

implementation

uses     UN_RL_Contas_Pagar, Un_Excel, UN_Sistema, UN_Principal, env, Un_Regra_Negocio, RN_Fornecedor, UN_TabelasEmListas;
{$R *.dfm}


procedure TFr_Imp_CtasPagar.SB_ImprimirClick(Sender: TObject);
begin
   try
     Pc_LimpaQrPreviweMemoria;
      if not Assigned(Rl_Contas_Pagar) then
         Rl_Contas_Pagar := TRl_Contas_Pagar.Create(Self);
      Rl_Contas_Pagar.Qrpt.Preview;
   finally
      Rl_Contas_Pagar.Close
   end;
end;

procedure TFr_Imp_CtasPagar.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_CtasPagar.FormCreate(Sender: TObject);
begin
   Qr_Fornece.Active := true;
   RG_Tipo.ItemIndex := 0;
   E_Data_INI.Date := Date;
   E_Data_FIM.Date := Date;
   ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;   
end;

procedure TFr_Imp_CtasPagar.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_CtasPagar.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
    if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
    if not Assigned(RL_Contas_Pagar) then  Application.CreateForm(TRL_Contas_Pagar, RL_Contas_Pagar);
    RL_Contas_Pagar.Pc_Busca;
    Fr_Excel.Pc_Excel(RL_Contas_Pagar.Qr_CtasPagar, Lc_CAminho);
    finally
    RL_Contas_Pagar.Close;
    end;
  end;
end;

procedure TFr_Imp_CtasPagar.DBLCB_FornecedorKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Empresa.KeyValue := Null;
        end;
      end;
end;

procedure TFr_Imp_CtasPagar.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_CtasPagar.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_CtasPagar.Qr_ForneceAfterOpen(DataSet: TDataSet);
begin
   Qr_Fornece.FetchAll;
end;

procedure TFr_Imp_CtasPagar.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_CtasPagar.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  ChBx_NomeClick(Self);
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Contas a Pagar');
  CB_Tipo.ItemIndex := 0;
end;

procedure TFr_Imp_CtasPagar.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_CtasPagar.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_CtasPagar.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_CtasPagar.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Empresa.KeyValue := Null;
        E_BuscaCodigo.Clear;
        end;
      end;
end;

procedure TFr_Imp_CtasPagar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_CtasPagar.Pc_ImagemBotao;
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

