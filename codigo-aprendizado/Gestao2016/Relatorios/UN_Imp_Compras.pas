unit UN_Imp_Compras;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.DBCtrls;

type
   TFr_Imp_Compras = class(TForm)
    Panel2: TPanel;
    SB_Imprimir: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel1: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Cb_Tipo: TComboBox;
    RG_Tipo: TRadioGroup;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure ChBx_NomeClick(Sender: TObject);
      procedure ChBx_FantasiaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;
    
      procedure ConsultaVendas;
      procedure ExportaVenda;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;      
   end;

var
   Fr_Imp_Compras: TFr_Imp_Compras;

implementation

uses     UN_RL_Compras, UN_MSG, Un_Funcoes, UN_RL_ComprasDetalhada, Un_Excel, UN_Sistema, UN_Principal, env, Un_Regra_Negocio, RN_Fornecedor, UN_TabelasEmListas;

{$R *.dfm}

procedure TFr_Imp_Compras.ConsultaVendas;

begin


end;

procedure TFr_Imp_Compras.ExportaVenda;
begin

end;


procedure TFr_Imp_Compras.SB_ImprimirClick(Sender: TObject);
begin
  Pc_LimpaQrPreviweMemoria;
  case CB_Tipo.ItemIndex of
    0:begin
      try
        if not Assigned(RL_Compras) then
          (Application.CreateForm(TRL_Compras, RL_Compras));
        RL_Compras.Qrpt.Preview;
      finally
        RL_Compras.Close
      end;
      end;
    1:begin
      try
        if not Assigned(Rl_ComprasDetalhada) then
          (Application.CreateForm(TRl_ComprasDetalhada, Rl_ComprasDetalhada));
        Rl_ComprasDetalhada.Qrpt.Preview;
      finally
        Rl_ComprasDetalhada.Close
      end;
      end;
   end;

end;

procedure TFr_Imp_Compras.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_Compras.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Compras.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
    Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
    Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
    case CB_Tipo.ItemIndex of
      0:begin
          try
            if not Assigned(RL_Compras) then (Application.CreateForm(TRL_Compras, RL_Compras));
            RL_Compras.Pc_Busca;
            Fr_Excel.Pc_Excel(RL_Compras.Qr_Compras, Lc_CAminho);
          finally
            RL_Compras.Close;
          end;
        end;
      1:begin
          try
            if not Assigned(RL_ComprasDetalhada) then (Application.CreateForm(TRL_ComprasDetalhada, RL_ComprasDetalhada));
            RL_ComprasDetalhada.Pc_Busca;
            Fr_Excel.Pc_Excel(RL_ComprasDetalhada.Qr_Compras, Lc_CAminho);
          finally
            RL_ComprasDetalhada.Close;
          end;
        end;
    end;
  end;
end;

procedure TFr_Imp_Compras.DBLCB_EmpresaKeyDown(Sender: TObject;
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

procedure TFr_Imp_Compras.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_Compras.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_Compras.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Compras.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_AbreListaFornecedor('EMP_NOME');
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Compras');
  RG_Tipo.ItemIndex := 0;
  Cb_Tipo.ItemIndex := 0;
  ChBx_NomeClick(Self);
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
end;

procedure TFr_Imp_Compras.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Compras.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Compras.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TFr_Imp_Compras.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Compras.Pc_ImagemBotao;
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

