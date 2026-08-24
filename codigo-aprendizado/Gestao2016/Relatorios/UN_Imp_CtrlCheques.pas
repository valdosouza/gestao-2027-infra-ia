unit UN_Imp_CtrlCheques;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Un_Fm_ListaEmpresas, Vcl.ComCtrls, prmCheques, ControllerCheque;

type
   TFr_Imp_CtrlCheques = class(TForm)
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel1: TPanel;
    Label6: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    CB_Ordena: TComboBox;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Panel2: TPanel;
    Label4: TLabel;
    Cb_Tipo: TListBox;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure chbx_EmpresasClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Cb_TipoClick(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
    It_Imprimir:Boolean;
    It_Visualizar:Boolean;
    procedure Pc_ControlaItensIterface;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ExportaChequeOrigem();
    procedure Pc_ExportaChequeDestino();
    procedure Pc_ImagemBotao;

    function getParametros():TParamCheques;
    procedure Pc_RelacaoSimples(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_RastrearOrigem(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_RastrearDestino(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_EnvioFornecedor(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_EnvioBanco(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_DisponivelCaixa(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_Devolvido(Pc_Operacao,Pc_Caminho:String);
   end;

var
   Fr_Imp_CtrlCheques: TFr_Imp_CtrlCheques;

implementation

uses     Un_DM, UN_MSG, Un_Funcoes, UN_Sistema, UN_Principal, env, Un_Excel, Un_Regra_Negocio, RN_Empresa, UN_TabelasEmListas;

{$R *.dfm}

procedure TFr_Imp_CtrlCheques.SB_ImprimirClick(Sender: TObject);
begin
  try
    self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    case CB_Tipo.ItemIndex of
      0:Pc_RelacaoSimples('I','');
      1:Pc_RastrearOrigem('I','');
      2:Pc_RastrearDestino('I','');
      3:Pc_EnvioFornecedor('I','');
      4:Pc_EnvioBanco('I','');
      5:Pc_DisponivelCaixa('I','');
      6:Pc_Devolvido('I','');
    end;
  finally
    self.Enabled := True;
  end;
end;

procedure TFr_Imp_CtrlCheques.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Imp_CtrlCheques.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Imp_CtrlCheques.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
    begin
    It_Imprimir     := True;
    end
  else
    begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    end;
   SB_Imprimir.Enabled:= It_Imprimir;
end;

procedure TFr_Imp_CtrlCheques.Pc_RastrearDestino(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Cheques : TControllerCheque;
begin
  try
    Lc_Cheques := TControllerCheque.create(Self);
    Lc_Cheques.ReportRastrearDestino(Pc_Operacao,Pc_Caminho,getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;

end;

procedure TFr_Imp_CtrlCheques.Pc_RastrearOrigem(Pc_Operacao,Pc_Caminho: String);
Var
  Lc_Cheques : TControllerCheque;
begin
  try
    Lc_Cheques := TControllerCheque.create(Self);
    Lc_Cheques.ReportRastrearOrigem(Pc_Operacao,Pc_Caminho,getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;

end;

procedure TFr_Imp_CtrlCheques.Pc_RelacaoSimples(Pc_Operacao,Pc_Caminho: String);
Var
  Lc_Cheques : TControllerCheque;
begin
  try
    Lc_Cheques := TControllerCheque.create(Self);
    Lc_Cheques.ReportRelacaoSimples(Pc_Operacao,Pc_Caminho,getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;
end;

procedure TFr_Imp_CtrlCheques.Pc_ControlaItensIterface;
begin
  DsblControl(E_Data_Ini);
  DsblControl(E_Data_Fim);
  Fm_ListaEmpresas.E_Cd_Empresa.Clear;
  Fm_ListaEmpresas.DBLCB_Empresa.KeyValue := null;
  DsblControl(Fm_ListaEmpresas);
  CB_Ordena.Items.Clear;
  IF (CB_Tipo.ItemIndex = 0) OR (CB_Tipo.ItemIndex = 4) OR (CB_Tipo.ItemIndex = 5)OR (CB_Tipo.ItemIndex = 6) then
  Begin
    CB_Ordena.Items.Add('EMITENTE');
    CB_Ordena.Items.Add('PRÉ-DATADO');
    CB_Ordena.ItemIndex := 0;
    EnblControl(E_Data_Ini);
    EnblControl(E_Data_Fim);
  End
  else
  Begin
    CB_Ordena.Items.Add('CLIENTE');
    CB_Ordena.Items.Add('EMITENTE');
    CB_Ordena.Items.Add('PRÉ-DATADO');
    CB_Ordena.ItemIndex := 0;
    EnblControl(E_Data_Ini);
    EnblControl(E_Data_Fim);
    EnblControl(Fm_ListaEmpresas);
  End;
end;

procedure TFr_Imp_CtrlCheques.Pc_Devolvido(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Cheques : TControllerCheque;
begin
  Lc_Cheques := TControllerCheque.create(Self);
  try
    Lc_Cheques.ReportDevolvido(Pc_Operacao,Pc_Caminho,getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;
end;

procedure TFr_Imp_CtrlCheques.Pc_DisponivelCaixa(Pc_Operacao,Pc_Caminho: String);
Var
  Lc_Cheques : TControllerCheque;
begin
  Lc_Cheques := TControllerCheque.create(Self);
  try
    Lc_Cheques.ReportDisponivelCaixa(Pc_Operacao,Pc_Caminho,getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;
end;

procedure TFr_Imp_CtrlCheques.Pc_EnvioBanco(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Cheques : TControllerCheque;
begin
  Lc_Cheques := TControllerCheque.create(Self);
  try

    Lc_Cheques.ReportEnvioBanco(Pc_Operacao,Pc_Caminho,getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;

end;

procedure TFr_Imp_CtrlCheques.Pc_EnvioFornecedor(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Cheques : TControllerCheque;
begin
  if Fm_ListaEmpresas.DBLCB_Empresa.Text = '' then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe o nome do Fornecedor .'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    exit;
  End;
  try
    Lc_Cheques := TControllerCheque.create(Self);
    Lc_Cheques.ReportEnvioFornecedor(Pc_Operacao,Pc_Caminho,getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;
end;

procedure TFr_Imp_CtrlCheques.Pc_ExportaChequeDestino;
Var
  Lc_Cheques : TControllerCheque;
begin
  try
    Lc_Cheques := TControllerCheque.create(Self);
    Lc_Cheques.ExportChequeDestino(getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;
end;

procedure TFr_Imp_CtrlCheques.Pc_ExportaChequeOrigem;
Var
  Lc_Cheques : TControllerCheque;
begin
  try
    Lc_Cheques := TControllerCheque.create(Self);
    Lc_Cheques.ExportChequeOrigem(getParametros);
  finally
    FreeAndNil(Lc_Cheques);
  end;
end;

procedure TFr_Imp_CtrlCheques.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Cb_Tipo.ItemIndex := 0;
  Cb_TipoClick(Sender);
  Pc_AbreListaEmpresa(-1,'EMP_NOME');
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Pc_PermissaoBotao('Controle Cheques');
  CB_Tipo.ItemIndex := 0;
  E_Data_INI.Date := Date;
  E_Data_FIM.Date := Date;
  ChBx_Periodo.Checked:= Fc_Marca_data_pesquisa;
end;

function TFr_Imp_CtrlCheques.getParametros: TParamCheques;
begin
  Result := TParamCheques.Create;
  with Result do
  Begin
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    if Fm_ListaEmpresas.DBLCB_Empresa.Text <> '' then
      CodigoEmpresa := Fm_ListaEmpresas.DBLCB_Empresa.KeyValue
    else
      CodigoEmpresa := 0;
    CodigoEstabelecimento := Gb_Codmha;
    CampoOrdenacao := CB_Ordena.Text;
  end;
end;

procedure TFr_Imp_CtrlCheques.Sb_ExportarClick(Sender: TObject);
Var
  Lc_CAminho : String;
begin
  if Fr_Principal.SaveDialogo.Execute then
  Begin
    try
      self.Enabled := False;
      Pc_LimpaQrPreviweMemoria;
      Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
      case CB_Tipo.ItemIndex of
        0:Pc_RelacaoSimples('E',Lc_CAminho);
        1:Pc_RastrearOrigem('E',Lc_CAminho);
        2:Pc_RastrearDestino('E',Lc_CAminho);
        3:Pc_EnvioFornecedor('E',Lc_CAminho);
        4:Pc_EnvioBanco('E',Lc_CAminho);
        5:Pc_DisponivelCaixa('E',Lc_CAminho);
        6:Pc_Devolvido('E',Lc_CAminho);
      end;
    finally
      self.Enabled := True;
    end;
  end;
end;

procedure TFr_Imp_CtrlCheques.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_CtrlCheques.Cb_TipoClick(Sender: TObject);
begin
  Pc_ControlaItensIterface
end;

procedure TFr_Imp_CtrlCheques.chbx_EmpresasClick(Sender: TObject);
begin
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);  
end;

procedure TFr_Imp_CtrlCheques.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Imp_CtrlCheques.Pc_ImagemBotao;
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

