unit UN_Imp_Duplicatas;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, Mask, DB, STQuery, ComCtrls;

type
   TFr_Imp_Duplicatas = class(TForm)
      Qr_Cliente: TSTQuery;
      Ds_Cliente: TDataSource;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel1: TPanel;
    Label2: TLabel;
    RG_Tipo: TRadioGroup;
    RG_Financeiro: TRadioGroup;
    Rg_TipoOperacao: TRadioGroup;
    Rg_Datas: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Label3: TLabel;
    E_BuscaFinanceiro: TEdit;
    Chbx_mostrar_creditos_Manuais: TCheckBox;
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure ChBx_NomeClick(Sender: TObject);
      procedure ChBx_FantasiaClick(Sender: TObject);
      procedure Qr_ClienteAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure RG_FinanceiroClick(Sender: TObject);
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
   Fr_Imp_Duplicatas: TFr_Imp_Duplicatas;

implementation

uses     UN_RL_Duplicatas, Un_DM, Un_Excel, UN_Sistema, UN_Principal, env, Un_Regra_Negocio, RN_Cliente, UN_TabelasEmListas;
{$R *.dfm}





procedure TFr_Imp_Duplicatas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_Duplicatas.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_LimpaQrPreviweMemoria;
    if not Assigned(Rl_Duplicatas) then
      (Application.CreateForm(TRl_Duplicatas, Rl_Duplicatas));
    Rl_Duplicatas.Qrpt.Preview;
  finally
    Rl_Duplicatas.Close
  end;
end;

procedure TFr_Imp_Duplicatas.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Duplicatas.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
      if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
      Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      if not Assigned(RL_Duplicatas) then Application.CreateForm(TRL_Duplicatas, RL_Duplicatas);
      RL_Duplicatas.Pc_Busca;
      Fr_Excel.Pc_Excel(RL_Duplicatas.Qr_Duplicatas, Lc_CAminho);
    finally
      RL_Duplicatas.Close;
    end;
  end;
end;

procedure TFr_Imp_Duplicatas.ChBx_NomeClick(Sender: TObject);
begin
  RG_FinanceiroClick(Self);
end;

procedure TFr_Imp_Duplicatas.ChBx_FantasiaClick(Sender: TObject);
begin
  RG_FinanceiroClick(Self);
end;

procedure TFr_Imp_Duplicatas.Qr_ClienteAfterOpen(DataSet: TDataSet);
begin
   Qr_Cliente.FetchAll;
end;

procedure TFr_Imp_Duplicatas.RG_FinanceiroClick(Sender: TObject);
begin
  if RG_Financeiro.ItemIndex = 0  then
  Begin
    DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaCliente;
    if ChBx_Nome.Checked then
      DM_ListaConsultas.Pc_ListaClientes('EMP_NOME')
    ELSE
      DM_ListaConsultas.Pc_ListaClientes('EMP_FANTASIA')
  End
  else
  Begin
    DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaFornecedor;
    if ChBx_Nome.Checked then
      DM_ListaConsultas.Pc_ListaFornecedores('EMP_NOME')
    else
      DM_ListaConsultas.Pc_ListaFornecedores('EMP_FANTASIA');
  End;
end;

procedure TFr_Imp_Duplicatas.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Duplicatas.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Duplicatas');
  ChBx_NomeClick(Self);
  RG_Tipo.ItemIndex := 0;
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;    
end;

procedure TFr_Imp_Duplicatas.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Duplicatas.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_Duplicatas.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Duplicatas.DBLCB_EmpresaKeyDown(Sender: TObject;
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

procedure TFr_Imp_Duplicatas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Duplicatas.Pc_ImagemBotao;
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

