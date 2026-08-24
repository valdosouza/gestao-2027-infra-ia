unit UN_Imp_Ajuste;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.Mask, Jsons;


type
   TFr_Imp_Ajuste = class(TForm)
    Pnl_botao: TPanel;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Pnl_Parametros: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    CB_Tipo: TComboBox;
    RG_Tipo: TRadioGroup;
    Rg_Operacao: TRadioGroup;
    ChBx_Pendente: TCheckBox;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
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
   Fr_Imp_Ajuste: TFr_Imp_Ajuste;

implementation

uses     UN_RL_Ajuste, UN_RL_AjusteDetalhado, UN_MSG, Un_Funcoes, Un_Excel, UN_Sistema, UN_Principal, env, Un_Regra_Negocio, UN_TabelasEmListas, RN_Empresa;

{$R *.dfm}


procedure TFr_Imp_Ajuste.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Ajuste.SB_ImprimirClick(Sender: TObject);
begin
  Pc_LimpaQrPreviweMemoria;
  case CB_Tipo.ItemIndex of
    0:begin
      try
        if not Assigned(RL_Ajuste) then
          (Application.CreateForm(TRL_Ajuste, RL_Ajuste));
        RL_Ajuste.Qrpt.Preview;
      finally
        RL_Ajuste.Close;
      end;
      end;
    1:begin
      try
        if not Assigned(RL_AjusteDetalhado) then
          (Application.CreateForm(TRL_AjusteDetalhado, RL_AjusteDetalhado));
        RL_AjusteDetalhado.Qrpt.Preview;
      finally
        RL_AjusteDetalhado.Close;
      end;
      end;
   end;
end;

procedure TFr_Imp_Ajuste.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_Ajuste.Sb_ExportarClick(Sender: TObject);
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
            if not Assigned(RL_Ajuste) then (Application.CreateForm(TRL_Ajuste, RL_Ajuste));
            RL_Ajuste.Pc_Busca;
            Fr_Excel.Pc_Excel(RL_Ajuste.Qr_Ajustes, Lc_CAminho);
          finally
            RL_Ajuste.Close;
          end;
        end;
      1:begin
          try
            if not Assigned(RL_AjusteDetalhado) then(Application.CreateForm(TRL_AjusteDetalhado, RL_AjusteDetalhado));
            RL_AjusteDetalhado.Pc_Busca;
            Fr_Excel.Pc_Excel(RL_AjusteDetalhado.Qr_Ajuste, Lc_CAminho);
          finally
            RL_AjusteDetalhado.Close;
          end;
        end;
    end;
  end;
end;

procedure TFr_Imp_Ajuste.DBLCB_EmpresaKeyDown(Sender: TObject;
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

procedure TFr_Imp_Ajuste.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Ajuste.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Ajuste.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_AbreListaEmpresa(-1,'EMP_NOME');
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
  Pc_PermissaoBotao('Ajustes');
  RG_Tipo.ItemIndex := 0;
  CB_Tipo.ItemIndex := 0;
  E_Data_Ini.Date := Now;
  E_Data_Fim.Date := Now;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
end;

procedure TFr_Imp_Ajuste.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Ajuste.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_Ajuste.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_Ajuste.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_Ajuste.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Imp_Ajuste.Pc_ImagemBotao;
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

