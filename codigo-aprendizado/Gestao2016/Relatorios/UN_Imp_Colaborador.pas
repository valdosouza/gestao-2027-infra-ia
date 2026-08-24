unit UN_Imp_Colaborador;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls;

type
   TFr_Imp_Colaborador = class(TForm)
      Ds_Colaborador: TDataSource;
      Qr_Colaborador: TSTQuery;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel1: TPanel;
    Label3: TLabel;
    RG_Tipo: TRadioGroup;
    DBLCB_Colaborador: TDBLookupComboBox;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_ExportarClick(Sender: TObject);
      procedure DBLCB_ColaboradorKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure RG_TipoClick(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;    
    procedure Pc_buscar;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;      
   end;

var
   Fr_Imp_Colaborador: TFr_Imp_Colaborador;

implementation

uses     Un_DM, Un_Excel, UN_Sistema, UN_RL_Cadastro_Colaborador, UN_Principal, env, Un_Regra_Negocio;
{$R *.dfm}

procedure TFr_Imp_Colaborador.Pc_Buscar;
var
   Lc_Sqltxt: string;
begin
   Qr_Colaborador.Active := False;
   Qr_Colaborador.SQL.Clear;
   Lc_Sqltxt := 'SELECT * FROM TB_COLABORADOR ';

   case RG_Tipo.itemindex of
      0: Lc_Sqltxt := Lc_Sqltxt + 'WHERE CLB_DEMISSAO IS NULL ';
      1: Lc_Sqltxt := Lc_Sqltxt + 'WHERE CLB_DEMISSAO IS NOT NULL ';
   end;
   Lc_Sqltxt := Lc_Sqltxt + 'Order By CLB_NOME ';

   Qr_Colaborador.SQL.Add(Lc_Sqltxt);
   Qr_Colaborador.Active := True;
   Qr_Colaborador.FetchAll;
   Qr_Colaborador.First;
end;

procedure TFr_Imp_Colaborador.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_Colaborador.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_LimpaQrPreviweMemoria;
    if not Assigned(Rl_Cadastro_Colaborador) then
      (Application.CreateForm(TRl_Cadastro_Colaborador, Rl_Cadastro_Colaborador));
    Rl_Cadastro_Colaborador.Qrpt.Preview;
  finally
    Rl_Cadastro_Colaborador.Close;
  end;
end;

procedure TFr_Imp_Colaborador.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_Colaborador.Sb_ExportarClick(Sender: TObject);
var
   Lc_CAminho: string;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
      if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
      Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      if not Assigned(Rl_Cadastro_Colaborador) then Application.CreateForm(TRl_Cadastro_Colaborador, Rl_Cadastro_Colaborador);
      Rl_Cadastro_Colaborador.Pc_Busca;
      Fr_Excel.Pc_Excel(Rl_Cadastro_Colaborador.Qr_Colaborador, Lc_CAminho);
    finally
      RL_Cadastro_Colaborador.Close;
    end;
  end;
end;

procedure TFr_Imp_Colaborador.DBLCB_ColaboradorKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Colaborador.KeyValue := Null;
        end;
      end;
end;

procedure TFr_Imp_Colaborador.Pc_PermissaoBotao(Pc_Menu: string);
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

procedure TFr_Imp_Colaborador.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pc_PermissaoBotao('Colaborador');
  Pc_Buscar;
  RG_Tipo.ItemIndex := 0;
end;

procedure TFr_Imp_Colaborador.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_Colaborador.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;

end;

procedure TFr_Imp_Colaborador.RG_TipoClick(Sender: TObject);
begin
  Pc_buscar;
end;

procedure TFr_Imp_Colaborador.Pc_ImagemBotao;
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

